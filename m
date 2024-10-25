Return-Path: <linux-pci+bounces-15261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCAF9AF811
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 05:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CFDB21701
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8118BBB7;
	Fri, 25 Oct 2024 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQLlgRqT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1718BBA4;
	Fri, 25 Oct 2024 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826032; cv=fail; b=igWXqGj9jwhZNgfZh8peklMbPEsXLOHCIFJFjTTIGDau71VPybrQcfPws62zIjpcbtzpN6ar5P0y0IvWxRkYo3INxWEm7usrQKb5NpL/SXnHBcicdeIO3VkFwEZB712Ec3tgQRF4dJtXz3ly1K5y5vt9InJTHbH+fTOfCQS2dz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826032; c=relaxed/simple;
	bh=5o63i1xE1A+tsXP8g4lXC/lfFVcePxr2jtUJKR2k8jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sc+Or64VXdXG5HmocY3NIr4qT8yWlgvnamVUTXHOgy7E2UMIm1ZxbaBsO/xCrE+cNdLwcXDrKqfn9XVKUUnDr93hR/kviNs3BV6M/Njik9LEX79LaNYQilMMxSW2RN1PwJAMZRUbVFivFZjRHoYAr7MjmbBICs/1q7jr8B8nMpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XQLlgRqT; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ78v4sBtTf6xnPW2eBKmSifRWa2xSXiYe8wlzK+3TVyvjtKCWCF49XQlc+n3wgDddfqGpBDJcfqGqLAZ9200d9/2NLwuKz2sjYj4QIQr8alDgROh1c08nBEbtlmoFEUkmpo8F294MFOxjJs4rk+lc3/20/Bm1TqT7ILMLuRgHCke0wT/dehQG+pBfQM/qtttunI1WpAKH75ITFRAT2ImDrTDZpykb/FtidYVEi+JTu4SuZwOloltK/Do5/N89z47HvCe2ksNDm+IqyuxFfDQhB1BzykhrLacslx3j6NUE4aLyO39CvGhvn6l2E/Hi0Vp234qGPoRVK1SlaQT/IoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9FEeL9Ff987X7a039VLJCbg4lG7QcBiiMQSRmhKODc=;
 b=ha7neRFjjPwgz/XNoVFo73348Z1ONk1XKgC0UNJwJsd6gH0PQXy+mNF6lx97BZKOi4wt0t0GxALQWq0nkNl0UNRhZ/qkZGQCPKt/9Xmx0YKlOh3ycClwHPVeEgF17zq+vEPjC1AAlFwIV4D/ezTeN7ByLii9siUaF6Vgx61XgJRRCjWuYI3gNeI/0WzAH/3MBVfRoVO0/AwmZ9zPLsgU9+zrtUX0MXD2uZSLsfEiN/oPAy5zKsMEy/4edgG3eqtKYiapvpTqB3m0g3ZyixtWySjjukRkMM8AVu3nx22rKmBW16eaPCaRbeZU7I5CmtywxXaVNFC9E0ejjalISIh4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9FEeL9Ff987X7a039VLJCbg4lG7QcBiiMQSRmhKODc=;
 b=XQLlgRqT/ieTcR2lpXOpeauPwJMVaimbXDyi7No1WVBEL4sKTYOnAL1q45p3Lrlh+RqdlwIddL2GeOF5eZbiGFXflASZorIszNZN3OZ2CmrmuJf0OibRa/PcYUNRUaOls6ahFdh6OLLgDyoEKjf39mkhgf5/DQr3WrDDC2BVVI42OXWD2qHbuaEhj2AQ0cvdzLyBYzuXceFO6huzKAZxJoewY1LbyEon1sCUXxAa8rmzikeOu5tJO8VKvuIIgnYDzut+u7B1ALBZMz4HjBZjKYntffshpYeCLEG7r/jfJJ/dl9w7401MkWddX7qW9hLxCk1AHaXq4kWaE74gFU2OZw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7808.eurprd04.prod.outlook.com (2603:10a6:102:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 03:13:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 03:13:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 08/13] PCI: Add NXP NETC vendor ID and device
 IDs
Thread-Topic: [PATCH v5 net-next 08/13] PCI: Add NXP NETC vendor ID and device
 IDs
Thread-Index: AQHbJeOqRmdBCQMZjESDHEXLJ06RHLKWNeoAgACV20A=
Date: Fri, 25 Oct 2024 03:13:46 +0000
Message-ID:
 <PAXPR04MB8510ECEB6E78D1FC62358828884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-9-wei.fang@nxp.com>
 <20241024181630.GA966301@bhelgaas>
In-Reply-To: <20241024181630.GA966301@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7808:EE_
x-ms-office365-filtering-correlation-id: c32e34c8-5027-462e-d793-08dcf4a30a43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?voR8sGwGI0rD5LzNjpA7ojdmbcgjbfoT+93CovG3GHfQoJr+sAODaVVJckOW?=
 =?us-ascii?Q?bI6oJvNsXo4ET3BIFvVGEcx7UrhQ4qcIphXcqQIIsxch3CQnAD1ncu3u4wgC?=
 =?us-ascii?Q?envuvzbd49E8eIAoG4rQCq/TCPHoM6vhjIAgIE7j/feGQ3cuVXbrhdLgr2sm?=
 =?us-ascii?Q?Vq+n3fzFgcGaT3/x5bukSbyv091bv+o67xw5akaAiMfNo6FhvoeMu4TYvCZf?=
 =?us-ascii?Q?nk6lOJTrwY52sYZVhD/kDNxQZYZSP6Ix6yPj9ufHTBLq2l90GS8iKuTuihDO?=
 =?us-ascii?Q?71TF4pF7vIrS8t4XfnZDSpRGQZk+QKTrVuiEd2ByzbKq82SbHDAPuVYFo7Ay?=
 =?us-ascii?Q?/IUQV6xgGYja4pFIJh0R8/uOkkoEwIzYK0Ht3qxf5eUo1gU3IFnwFUMRkcLG?=
 =?us-ascii?Q?uB6DdCVBgiO/eow0klLSwhxt0MPS2kINYevH+bPU4AiGlEAzgfxeobY9FIp/?=
 =?us-ascii?Q?biT/T/dn88d6BvZFUmZx7ovVfG3VWIN5LWguPJqtdxkykC9XeKSTVp7rpFOQ?=
 =?us-ascii?Q?/IGXU+6FNhDclXjxANxY5Nm+Hpnpz2FnpRsUN4jGf1ZuNE10baeOd5fkto8s?=
 =?us-ascii?Q?9hf85XwyCQcIm3ChU2BO5qujqYK6Yp3Z/KieuwMw0nUeMs0sT7LgUrWhE0TQ?=
 =?us-ascii?Q?/hYiGgQGWU5kZZDYnttF4OcKurgspcZodjbJ4U1xjO5C1PuE4gJdEvcCAzfk?=
 =?us-ascii?Q?afpx3KNBpFJfCOGRv97PoHEEhKKLWJiDdCqSiqtk9yb+EJuhNHzeDvDVW7/p?=
 =?us-ascii?Q?oayQiU/m2u82GWY6AujwRvwNW2UCEQcecKmGd4QjaGHtrdz8ZeccPfle4LbV?=
 =?us-ascii?Q?qNGiImzvD7lbSHmg1wJ3AAW6KdB1jvt1/pfVMRH4Am0wmwYpejuiqVFhDPOv?=
 =?us-ascii?Q?9/uWKAFKbFIxwnjr85YZWPWpTA+rNB3Cv3nPhNbo0hm49orB+eommKTZE0LN?=
 =?us-ascii?Q?QqSkfHTSaGwcG2T/0c+H4+ljpZSQkB7ZsJIF5kQTfHesVp4pgPNLUykWc9dw?=
 =?us-ascii?Q?Lqw/+RH6dvQFP0pQZpe2YpqClWz4cBBzKMljCWlm1TbzZtxx4vd/k0MuCz/s?=
 =?us-ascii?Q?fC5+tX4kSj14mWb4TFwJhZ2s2PMmyQ+uqqZH6QHYs0OoDAB1lnH4/bKMpI6D?=
 =?us-ascii?Q?XXZxSlQiaJYXLeuXSJZnFyqRzW1S5CoTVxUEDcXyB/m+if3ZIp9VWG+kaWe3?=
 =?us-ascii?Q?VyJXAUuzFhcR4Tlk3zkJfEt045VYr0GwZ3eFZk2uctWFRyzZ6v2wuySQfMOs?=
 =?us-ascii?Q?QaQ4eEfRt3lBKVDqiyE08Kyj3jg29tiAo3dnjQLIviG3iLrW0mKX4H1umIaR?=
 =?us-ascii?Q?JcPkcbNhPaE9dQFmBmtxtpCSfdzbELK+NUm1fvCenggEWP/kxai7EowLA/1c?=
 =?us-ascii?Q?mmEpqsY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C26tSvfcamPlFbNnzzJbDY7ohoyv6C09b/99emTk/NUFHxhKd78COr8bEY17?=
 =?us-ascii?Q?paKHjKVAduaWshGRPIir3TSCcliy0pqVUVaNNUh2MtAAPxQuYxDavWZSPlbY?=
 =?us-ascii?Q?9u0Z/6kRBinwpq1E5z4Ow7Pl68z4gsJO1JpYYE3F+a7titUXEhvwrdTs87g4?=
 =?us-ascii?Q?ULBRwFzEC7ySU3FGBbDFnbY9Lu+J1qvIIH3WgtorjNDYpKoK5/S3oSGigj4p?=
 =?us-ascii?Q?cYHil6UppL4Xo8XEpi3FMO0c/UTV8YUN6eq2AR4CKEhqB5ScrxBS6i+sK8nx?=
 =?us-ascii?Q?UnvLs4fVznUkXgtEDcjnCGcYxyjPP1tnLipZkOnecXIMk6ynibINde3UDxrR?=
 =?us-ascii?Q?dxRMhxcFcB/av55hHzM+IfGSEKTEGktqpWH2Qr1nz8wYormj3XS+zRlgBys+?=
 =?us-ascii?Q?kV+AK1CNziDYd6A2czLfzDP6NdmtmCDNFbhMdyT4JKLS1JCYUS5ZXhb8fgxm?=
 =?us-ascii?Q?hcnc9YtS6lmUPxkI17Sy1q0CYx5reOoXOqWjFEnLqLVVT781rWMjW+NpoF+e?=
 =?us-ascii?Q?4n48/wWIQD/GMuzx8sdbrgZwjcrHVJA/qOb9NDK6sa3Iz0mfi9tZGAX9ZTkW?=
 =?us-ascii?Q?8I9KMRDTO12cr/Ec3DVJW4g8FG+ROdbjObFR+Ge/lkQCgde5fjPgtVqDkICY?=
 =?us-ascii?Q?vDl3yv/kbJNtKoqlZXPmNU/MKKcitqq9fzWNAYjNJkl/l+yNJ0uyYavcAZ3t?=
 =?us-ascii?Q?qQu9qCI0h7+fQCAZTs/Pj+axOIqTgn2TxexfNQsP0iBCp11vUv4kxpzpkDvD?=
 =?us-ascii?Q?3J/lo88wk4NCNb8FijS9+MRX0Cd2KzbqzINiK/8Ist+vc/9xjXERwRiURXfs?=
 =?us-ascii?Q?MHIuPeTHxORmTiwraoWQEzV/XxBP85N6sJA/TRHOvUd/8ETthI9LFaWIiRuW?=
 =?us-ascii?Q?hXoa0zFIZsEKOU6fcLHoLIun3HuTQuxEH5yKfT6htI2mMLtqlocUWrOWo2D6?=
 =?us-ascii?Q?s9qWfh4x2I7Yf9b1esYMfUkBl897fYtFYFNVichKl8T3yNqW5tFzvB9oqL++?=
 =?us-ascii?Q?l4rVllHi7lyD2xsSX/Fm9h+EWScTcjdhNv/hkO8scxWo0WZ4OZdgAzigtW8i?=
 =?us-ascii?Q?mQX4jqX26VQTeFSbYtM2XXOSVvFGA8AYknJ7ca6H9AZ+c8vWfPnIKt5GSDzw?=
 =?us-ascii?Q?OxhmEdmvMqvFo+8TE7O/vPNNJb1IP/c6XSNt8iu0Irt/4yK+qVaU0inrZNea?=
 =?us-ascii?Q?J/PPBI2BX89GU/pFaYP05Hmek9Cu6sfH9f41WobJAzKAbIgU+uZ3XFHlNy8j?=
 =?us-ascii?Q?RRhcxJX6GMzs53pMZSJbtx6OA/1997VdzfccpWatWWuH6gnRTQIDocy+KcfO?=
 =?us-ascii?Q?QkCq0ops+R8BFCUcR3N+Ssn4riOHhkgKYyrXxLwiEK+jnc4HWoVKPWW4pN07?=
 =?us-ascii?Q?tACAHeYpfE0jBahtFpXWVwyH3NVIlx7sI5aCyukEefvU+b6oB+QfVTF2jqFu?=
 =?us-ascii?Q?zId5G7lpFLuaC/2FxauLpMC9a6f1kZWx4i1KUgowEU+1yS4qPUlNFGYiuS1h?=
 =?us-ascii?Q?0aYA8b3TMp+ftS+i7uK5dS7/hgNe6eKy3pXcr2+yTerdgmsfolp1BXZuFJ8R?=
 =?us-ascii?Q?b2zIXKym5xjAyhVI4F4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32e34c8-5027-462e-d793-08dcf4a30a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:13:46.8218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekxnKzDPSi1WDfaiIbbO5T5BUln27HRt93cmyVhxRUydk6WSH+KUCbejrglNzUJHvl0vUvF62CQhJgYtvNWbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7808

> On Thu, Oct 24, 2024 at 02:53:23PM +0800, Wei Fang wrote:
> > NXP NETC is a multi-function RCiEP and it contains multiple functions,
> > such as EMDIO, PTP Timer, ENETC PF and VF. Therefore, add these device
> > IDs to pci_ids.h.
> >
> > Below are the device IDs and corresponding drivers.
> > PCI_DEVICE_ID_NXP2_ENETC_PF: nxp-enetc4
> > PCI_DEVICE_ID_NXP2_NETC_EMDIO: fsl-enetc-mdio
> > PCI_DEVICE_ID_NXP2_NETC_TIMER: ptp_netc
> > PCI_DEVICE_ID_NXP2_ENETC_VF: fsl-enetc-vf
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Please drop my ack.  I don't think these meet the spirit of the guidance =
in
> pci_ids.h, which is there to minimize churn in that file and make backpor=
ts
> easier:
>=20
>  *      Do not add new entries to this file unless the definitions
>  *      are shared between multiple drivers.
>=20
> PCI_DEVICE_ID_NXP2_NETC_TIMER and PCI_DEVICE_ID_NXP2_ENETC_VF
> aren't used at all by this series, so they shouldn't be added to pci_ids.=
h.
>=20
> PCI_DEVICE_ID_NXP2_NETC_EMDIO is used only by
> drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c, so it should be de=
fined
> there, not in pci_ids.h.
>=20
> PCI_DEVICE_ID_NXP2_ENETC_PF is used by enetc.c and enetc4_pf.c, but it lo=
oks
> like those are basically part of the same driver, and it could be defined=
 in
> enetc4_hw.h or similar.
>=20

I was not aware of this, I will remove this patch, thanks.


