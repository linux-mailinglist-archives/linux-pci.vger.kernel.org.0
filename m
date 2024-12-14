Return-Path: <linux-pci+bounces-18442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B129F1E86
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798797A04BD
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937418FC72;
	Sat, 14 Dec 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1xsaPP/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599F1865E3;
	Sat, 14 Dec 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179465; cv=fail; b=o6/7PERQYEt78/PunQLhfSUWPWj05C9Jb3vbIuWpw9s0ftnCiDLobkgSOfcCIEtPNBygHhDwvwwFU799O+npLbvcB2dcEIgITBWsTOEZZFeHv4MHsslcVki72r7NbJ1B3y1I0U4q0vx8NsJumJZ4gSSpksq2DWrT6rNIrI4U4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179465; c=relaxed/simple;
	bh=KqFTom9Z18IS5p1I8DpPPDIYgm9NQbCW/8EsNUybjRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NujwHGm8CB3/Ha1r3VeGf5nnOtIt+6B1XaxFBxZbgkJBaPHEO4l6nQn9CSKy9T7QHs0JDulQ3n7+fLBf7sYbeLaHXbaDzyHN+kUWf0WLTAdxBuZVEAqscjcmm9MJxCU5QQZno6Lytf6fcp6nK3Me73hKmmWAdeU5vr5kyRemMXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1xsaPP/; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah7UiQHMLG86+Byde1ACcGu9NCX259lIyLjmuEqeovV6PzcI18YqZICdI3L1cuKk5tDFdyRip36wGrio+/+j4WHzyhelK5fFNo2a2r290mOwmIqhAXM0hEIWdZiK3lDrlGXkRAnr5fDhuzEM57Ln5gqPiJM5JwE4R6fQM1k9D5bvedotP5BD1ZsUoZ8Ikpr70poFKuhKtaFgsW5Do1UTbtXmezw4vjzyVa6/gJElAHFm/F/4MRUStVetKiwafz4RYjkoH7IYgQi96I4fNg5yM16eFQdZIENXAR9cnwVshHM3fgivmsRuv/ZPLHNpVdLuxQr1MKmATD5k6UJAJrezRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqFTom9Z18IS5p1I8DpPPDIYgm9NQbCW/8EsNUybjRM=;
 b=FYFot+YCUXTSTk2Iubtz/FjC7zP3A0Qm55BxJ1BC/zOv7PqT22YGf2hpK90Hzo0lpj7C+Xi1mXOvo9KqDBcE+jy9AtD/d5Z7gML6Kp3LfTqdEkFMi+39Kd0M8sRmsNQj5m3M3qH7DQERbvicP7p+ATdHQ5kuDxsM4tsA1CZVrpTINtCcNz/22GM+O1tIzwSNmL2bV7NWEm1BrmeLfwXigDdq/L8+H9kGNzsvVXcWQI9Tr4ObZz8d7CfBEI16KhfrxAfWVnLhhi1wtjdWBYY2AmFzY51kPb92Lfpmki0OEd/Y7GU09cYcpwXk2Gv2lhjmYb8S4ZbRiByXPY7Gv4fhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqFTom9Z18IS5p1I8DpPPDIYgm9NQbCW/8EsNUybjRM=;
 b=H1xsaPP/3xOoxZQsz1t/9vdB1PSG/PGay1f6k2POsqLQSxiAx3D4DgQesCwWMfMGhGKrqokMKNuQr5jiYxCDymBB4zWajQG1n9V4OjdpUUo0bCya5hUJTyy2Hv8CMo9bPkqqSwc4idH6oEsib6+f8bD6ZsnNOI1LRih8XUOspe45U2YxOMatxtA5ySbct7Fc0flD0pML677+Ms4p9P4wSogC1tqT2ZaspedYY61ffjtQKQ3p1qdufgMkL+txHRA3t0eNsMbIPhLtxquHKusVJ517YzrlCZGpTh1nv+NNOW5Fvn/UKmCJa5oPsu2pYlyez/qT1zjR9AeFjtbc0PQfJA==
Received: from BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Sat, 14 Dec
 2024 12:30:58 +0000
Received: from BN9PR12MB5323.namprd12.prod.outlook.com
 ([fe80::efb1:9741:c066:f01c]) by BN9PR12MB5323.namprd12.prod.outlook.com
 ([fe80::efb1:9741:c066:f01c%4]) with mapi id 15.20.8251.008; Sat, 14 Dec 2024
 12:30:58 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Thread-Topic: [PATCH 1/1] PCI: Fix Extend ACS configurability
Thread-Index: AQHbTZ3TFrzQme3a5E2xHStvOldK07LlrLdv
Date: Sat, 14 Dec 2024 12:30:58 +0000
Message-ID:
 <BN9PR12MB5323203A4C5B913271DF48A9B8392@BN9PR12MB5323.namprd12.prod.outlook.com>
References: <20241213202942.44585-1-tdave@nvidia.com>
In-Reply-To: <20241213202942.44585-1-tdave@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5323:EE_|PH7PR12MB6585:EE_
x-ms-office365-filtering-correlation-id: ec822fef-60a4-466c-7bd1-08dd1c3b29a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?313bF6w92GuoV6VcCnYe47TZst/ytemhPmFtdCfdR1r7yf3OrCaG/JPh?=
 =?Windows-1252?Q?BXhCcJcdDvbHhfmZ9OIm9jBRNk3r+3domyVfz4FKeGbsqu4lfQSu3axl?=
 =?Windows-1252?Q?dL3FQBcpZ82mIXFOOQeQwa2gMV/bPNIJ92cfVXpn5QI8Bz9WVAmDi/VG?=
 =?Windows-1252?Q?JDKx1YjqFqFDFoivDH6ZvtIeKabzAwVQzQ0pHp2Z6dzzpFF2UZnyPSBA?=
 =?Windows-1252?Q?F2MpNONTPz3WO2CtdUmbnCU6wiI0PU1pfTTO+gYvvaSzfHSdonfvRiZA?=
 =?Windows-1252?Q?h7+BR2OnJgE7gRxG9SoK5p4DjdEli3hPwYCAz0zgXSOW4HH/UKVpZ4lk?=
 =?Windows-1252?Q?SMST1YLFGAtXflY79NgFOkOWHStilWTNt9I9IkZWQ1tV2iFfPRwz/LA3?=
 =?Windows-1252?Q?yMTPPANTMx0DcLtxpVhIiYEbbx6kBo/CR6G7W7ZYyqP2f0P6CTBszqWp?=
 =?Windows-1252?Q?KY77m5rrB81O57uiq5e+lh98mUyoTqVHPKHTRbfKQYatCU4Yb39Bak3o?=
 =?Windows-1252?Q?u/9sSbDVNz3DXBWGjDeWVqdiYnoIRjYEHo2hMzmZD4V5YwVVCpDY8Vd9?=
 =?Windows-1252?Q?vrtMAzM8lNixGXh0sX5xfkg7aBX1GLfE+b9WbimBv5jwzZRbCXR6KcZS?=
 =?Windows-1252?Q?wwOYZqun/PD99Vhc8eRGkwfnG0TKzV0xJJNse01Qr3bjaU417dxHqCeW?=
 =?Windows-1252?Q?F4lZunx6+T/N9dltmES5B7A08qjmw8O48mEvBizS4zizQ9FpiXxV4Hmz?=
 =?Windows-1252?Q?aGYCnsAn7u9wE/bHaYs0O0+zl3D/ZNo0OX/+xXEEvPAX0u9zzlms7+YO?=
 =?Windows-1252?Q?SBjlx1Ye+D6+8A+u1Xf0xdlNJguLO36tPiMHu9GdGsfUAiIkEDLxqly5?=
 =?Windows-1252?Q?zQI489zywXPARgkrh89ghb1mCJ+AcDZIhqO9KOxFRr8+JUVLWyTK8U/d?=
 =?Windows-1252?Q?PA6eGQ1l0ED6RfsxITgPlF9iM/TUIjapFlIg76VsljkSPmXVdIUluXZK?=
 =?Windows-1252?Q?2Prg76dDpx4xGW/3si2qGAyDz0ssW86dLt4HyQ/f4RCbZY1juvpjs66G?=
 =?Windows-1252?Q?4jFcuwtvkwX3RnqjGoEYWaKpiVb8IV0WaWf1UufLeOTRuccJAeRkCLZs?=
 =?Windows-1252?Q?pMdK8bU+HUK+p/K/v9q1L1fNK+vmnLeoa3U8eTsfMX1Zzs2Q0OE33P/N?=
 =?Windows-1252?Q?W613yNJXb0DyzIPKrCizcUo9wkMfCnVQbojQnWpq+ODctieyg/MmfvUB?=
 =?Windows-1252?Q?oB3cmu6erYM6snauCf07BRr8MEUCw9PPvYWSLz475K93M442QGsmAExG?=
 =?Windows-1252?Q?MAtFtBalbtWd2NPj7Q3kvpCLHso1Tr6uHZhKXWvjdCBDAPIEtRsAy6O5?=
 =?Windows-1252?Q?ZPXCxrIf86ZOI+HVroF9MD9n/awWOOZYZQdqz3n7r0zX1gZ3lWwJ6Oc/?=
 =?Windows-1252?Q?dgDJjCU0vu2eG1W9iWQz1V8uam5UCv7geY4CRp6RtnYHJce1NarY79i4?=
 =?Windows-1252?Q?mpZFY0kOv622UlegUVJ9mvRUiHxUlBgD8F3G0Z9eSKwSvwLqVQJemxmj?=
 =?Windows-1252?Q?zG266oH0Zb7D5554mkhFvkOx7OzrTzurBhAi4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5323.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?3yBnvrjIe25/JtIBnWgnl3BikruwOahBndH4eqRKLWcrMMWJ0q2u6m/F?=
 =?Windows-1252?Q?3gE8fXHJMdVTr04/ASDrrw2iWEvKFgBrwXjfN4ckNbiKg+vKGJjb2ewj?=
 =?Windows-1252?Q?m31bfUSDsBMqcYFinMvsl7/bCDJDBwBOIp0mxSJZRIjPARU60U0UxOM3?=
 =?Windows-1252?Q?7VAjgu2stnsCtHxq6MAygxKMAhLNKKG9iOmES+MNExEAZHfwkl7ukGTQ?=
 =?Windows-1252?Q?OgYNwWwaRDrFyZm9oQ0zziPj4LwdAwor3fsgxCQkxbgr8LmaX9BeMiyV?=
 =?Windows-1252?Q?+vZyatqWT8kGXyqehL5I98NDH2R0RAcUwcKVTzG8gtQzN44Dqtq3J0sc?=
 =?Windows-1252?Q?AKmrCAVG2fGcqmdixYmbewAnXOqihd3dJeORRi7VUffImN3hT9PlRZoI?=
 =?Windows-1252?Q?iYY5hJUPIRaYpk1VSyU+0xm5pV0qMtSLFds1cO5/5rKaMrD/JSNy6Fpx?=
 =?Windows-1252?Q?jcgebiGvIQDAdVm0IzQ7xx5XoZ76rpsM6+0mmoLSLRkQbnXFQ/B5ygdd?=
 =?Windows-1252?Q?m7IPwIgLD45BAm6bmf6TIec/EGeq45sJnB5pK7Ou6/JqdnvQxtP24gjk?=
 =?Windows-1252?Q?nPOrRHS7roVB2d3FjVnK2qtI0hr5jWhUBsbi+5e5bqElXMtApGGdz4Fr?=
 =?Windows-1252?Q?FxZ+Bo52rGCgEvSsLdJr5qJhyner8PHugQkpqkYF0QC2KPufD8RttbQ2?=
 =?Windows-1252?Q?WxSQl4tIkSkHYkFizEMvw0RbBc/MIbnfT4bPsjWf73VMQkzs6nstqlTt?=
 =?Windows-1252?Q?EbrhwpX1D+cro+bcT9OXS05O9D3yRzZL3V9ZlZos8A9YhHQN9xhEH/KV?=
 =?Windows-1252?Q?ZOdOROj0ItGarl4cEcTE3O8NRNt5qr1u1+Uy0kdnPcExxJLDqG/Txgbf?=
 =?Windows-1252?Q?AgKijtoM/z3m43iksqDtjtVVr+5V9V+eUaBDpdt+ZrNftAoRMmahXnhd?=
 =?Windows-1252?Q?KkDAU3z8U6mgVIQNOMSVIbcm0oiCG0Pz62QnmRMJvmiFG+QvRYNMce2o?=
 =?Windows-1252?Q?A+wSGZ/TOFyMNJwfZgj7dz3pctsH2toIULEiWH0x/eutfQ+nOk5MeTHj?=
 =?Windows-1252?Q?8EAvtawVxiiCAmd/UiO82FlJg0SlXdM/LlnYaCkB0/+VgIwU2UJQQRvF?=
 =?Windows-1252?Q?L2d93WwtGbr0p6dLP11ijRb3IdrMxK83gP944fAIVhEE21wjN8Ai5U0X?=
 =?Windows-1252?Q?altQmQUau3lRFiBalid7ZV2T7qkulBk6o4NZGi4m5bDhLx1GJdkJplJH?=
 =?Windows-1252?Q?bYF8BWEQdZNBnpEPvM1aifZPpTXljkUoJJytne+h8+ABHt2bdybiFyOW?=
 =?Windows-1252?Q?1chdzeeSxxnyoHiszx0Vet2sMnpkrtr6Yh7eY4cZufKZS3A86KtlPE87?=
 =?Windows-1252?Q?ZQg1x5zAD26X5bE8kUunx8dwcK4iGioeSLjMwWAKtdbbLyELFsj9fO1X?=
 =?Windows-1252?Q?ZdvmJ55D+wsfR7gTrisscy6XEzlJHkd28HTguMDuXyFXdvX3T/OZdSE1?=
 =?Windows-1252?Q?l3kOfcp1bRyihSM26QKLYb6YIAfY7YumBzH+/kSN4uVTzH1vs/6/uCOP?=
 =?Windows-1252?Q?h1u9Vli53OX2H0jF8VbWkGQp3J930FHtDpslcoe8diz5KIbwDXnI0sB5?=
 =?Windows-1252?Q?X6kb8xiWnBJ2YU0W7hsAqk2vkbOZTFe4wmu/1G7pXNmWxKgob9jV3UJx?=
 =?Windows-1252?Q?paPE/0UxuDc=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec822fef-60a4-466c-7bd1-08dd1c3b29a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2024 12:30:58.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3SoktDV73AvDixvfYkRzza5P4nJ1eCapOrudRGQlpD1sdO+m01kBXN2CSp0MbD6/kZnQr2v0wr1U1xcHpQCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585

Thanks Tushar for the fix.=0A=
=0A=
Tested-by: Vidya Sagar <vidyas@nvidia.com>=0A=
=0A=
________________________________________=0A=
From:=A0Tushar Dave <tdave@nvidia.com>=0A=
Sent:=A0Saturday, December 14, 2024 01:59=0A=
To:=A0corbet@lwn.net <corbet@lwn.net>; bhelgaas@google.com <bhelgaas@google=
.com>; paulmck@kernel.org <paulmck@kernel.org>; akpm@linux-foundation.org <=
akpm@linux-foundation.org>; thuth@redhat.com <thuth@redhat.com>; rostedt@go=
odmis.org <rostedt@goodmis.org>; xiongwei.song@windriver.com <xiongwei.song=
@windriver.com>; Vidya Sagar <vidyas@nvidia.com>; linux-doc@vger.kernel.org=
 <linux-doc@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vg=
er.kernel.org>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>=0A=
Cc:=A0Vikram Sethi <vsethi@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; S=
hanker Donthineni <sdonthineni@nvidia.com>; Tushar Dave <tdave@nvidia.com>=
=0A=
Subject:=A0[PATCH 1/1] PCI: Fix Extend ACS configurability=0A=
=A0=0A=
Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced a=0A=
bug that fails to configure ACS ctrl for multiple PCI devices. It=0A=
affects both 'config_acs' and 'disable_acs_redir'.=0A=
=0A=
For example, using 'config_acs' to configure ACS ctrl for multiple BDFs=0A=
fails:=0A=
=0A=
[=A0=A0=A0 0.000000] Kernel command line: pci=3Dconfig_acs=3D1111011@0020:0=
2:00.0;101xxxx@0039:00:00.0 "dyndbg=3Dfile drivers/pci/pci.c +p" earlycon=
=0A=
[=A0=A0 12.349875] PCI: Can't parse ACS command line parameter=0A=
[=A0=A0 19.629314] pci 0020:02:00.0: ACS mask=A0 =3D 0x007f=0A=
[=A0=A0 19.629315] pci 0020:02:00.0: ACS flags =3D 0x007b=0A=
[=A0=A0 19.629316] pci 0020:02:00.0: Configured ACS to 0x007b=0A=
=0A=
After this fix:=0A=
=0A=
[=A0=A0=A0 0.000000] Kernel command line: pci=3Dconfig_acs=3D1111011@0020:0=
2:00.0;101xxxx@0039:00:00.0 "dyndbg=3Dfile drivers/pci/pci.c +p" earlycon=
=0A=
[=A0=A0 19.583814] pci 0020:02:00.0: ACS mask=A0 =3D 0x007f=0A=
[=A0=A0 19.588532] pci 0020:02:00.0: ACS flags =3D 0x007b=0A=
[=A0=A0 19.593249] pci 0020:02:00.0: ACS control =3D 0x001d=0A=
[=A0=A0 19.598143] pci 0020:02:00.0: Configured ACS to 0x007b=0A=
[=A0=A0 24.088699] pci 0039:00:00.0: ACS mask=A0 =3D 0x0070=0A=
[=A0=A0 24.093416] pci 0039:00:00.0: ACS flags =3D 0x0050=0A=
[=A0=A0 24.098136] pci 0039:00:00.0: ACS control =3D 0x001d=0A=
[=A0=A0 24.103031] pci 0039:00:00.0: Configured ACS to 0x005d=0A=
=0A=
For example, using 'disable_acs_redire' fails to clear all three ACS P2P=0A=
redir bits:=0A=
=0A=
[=A0=A0=A0 0.000000] Kernel command line: pci=3Ddisable_acs_redir=3D0020:02=
:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=3Dfile drivers/pci/pci.c +p" earlyc=
on=0A=
[=A0=A0 19.615860] pci 0020:02:00.0: ACS mask=A0 =3D 0x002c=0A=
[=A0=A0 19.615862] pci 0020:02:00.0: ACS flags =3D 0xffd3=0A=
[=A0=A0 19.615863] pci 0020:02:00.0: Configured ACS to 0xfffb=0A=
[=A0=A0 22.332683] pci 0030:02:00.0: ACS mask=A0 =3D 0x002c=0A=
[=A0=A0 22.332685] pci 0030:02:00.0: ACS flags =3D 0xffd3=0A=
[=A0=A0 22.332686] pci 0030:02:00.0: Configured ACS to 0xffdf=0A=
[=A0=A0 24.110278] pci 0039:00:00.0: ACS mask=A0 =3D 0x002c=0A=
[=A0=A0 24.110281] pci 0039:00:00.0: ACS flags =3D 0xffd3=0A=
[=A0=A0 24.110283] pci 0039:00:00.0: Configured ACS to 0xffd3=0A=
=0A=
After this fix:=0A=
=0A=
[=A0=A0=A0 0.000000] Kernel command line: pci=3Ddisable_acs_redir=3D0020:02=
:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=3Dfile drivers/pci/pci.c +p" earlyc=
on=0A=
[=A0=A0 19.597909] pci 0020:02:00.0: ACS mask=A0 =3D 0x002c=0A=
[=A0=A0 19.597910] pci 0020:02:00.0: ACS flags =3D 0xffd3=0A=
[=A0=A0 19.597911] pci 0020:02:00.0: ACS control =3D 0x007f=0A=
[=A0=A0 19.597911] pci 0020:02:00.0: Configured ACS to 0x0053=0A=
[=A0=A0 22.314124] pci 0030:02:00.0: ACS mask=A0 =3D 0x002c=0A=
[=A0=A0 22.314126] pci 0030:02:00.0: ACS flags =3D 0xffd3=0A=
[=A0=A0 22.314127] pci 0030:02:00.0: ACS control =3D 0x005f=0A=
[=A0=A0 22.314128] pci 0030:02:00.0: Configured ACS to 0x0053=0A=
[=A0=A0 24.091711] pci 0039:00:00.0: ACS mask=A0 =3D 0x002c=0A=
[=A0=A0 24.091712] pci 0039:00:00.0: ACS flags =3D 0xffd3=0A=
[=A0=A0 24.091714] pci 0039:00:00.0: ACS control =3D 0x001d=0A=
[=A0=A0 24.091715] pci 0039:00:00.0: Configured ACS to 0x0011=0A=
=0A=
Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")=0A=
Signed-off-by: Tushar Dave <tdave@nvidia.com>=0A=
---=0A=
=A0Documentation/admin-guide/kernel-parameters.txt | 11 +++++------=0A=
=A0drivers/pci/pci.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 16 +++++++++-------=0A=
=A02 files changed, 14 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt=0A=
index dc663c0ca670..fc1c37910d1c 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -4654,11 +4654,10 @@=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Format:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 <ACS flags>@<pci_dev>[; ...]=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Specify one or more PCI devices (in the format=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 specified above) optionally prepended with flags=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 and separated by semicolons. The respective=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 capabilities will be enabled, disabled or=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unchanged based on what is specified in=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 flags.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 specified above) prepended with flags and separated=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 by semicolons. The respective capabilities will be=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 enabled, disabled or unchanged based on what is=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 specified in flags.=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 ACS Flags is defined as follows:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 bit-0 : ACS Source Validation=0A=
@@ -4673,7 +4672,7 @@=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 '1' =96 force enabled=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 'x' =96 unchanged=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 For example,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 pci=3Dconfig_acs=3D10x=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 pci=3Dconfig_acs=3D10x@pci:0:0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 would configure all devices that support=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 ACS to enable P2P Request Redirect, disable=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Translation Blocking, and leave Source=0A=
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c=0A=
index 0b29ec6e8e5e..35ff21b014ac 100644=0A=
--- a/drivers/pci/pci.c=0A=
+++ b/drivers/pci/pci.c=0A=
@@ -951,12 +951,13 @@ static const char *config_acs_param;=0A=
=A0struct pci_acs {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u16 cap;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u16 ctrl;=0A=
-=A0=A0=A0=A0=A0=A0 u16 fw_ctrl;=0A=
=A0};=0A=
=A0=0A=
=A0static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 const char *p, u16 mask, u16 flags)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 const char *p, const u16 acs_mask, const u16 acs_flags)=0A=
=A0{=0A=
+=A0=A0=A0=A0=A0=A0 u16 flags =3D acs_flags;=0A=
+=A0=A0=A0=A0=A0=A0 u16 mask =3D acs_mask;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 char *delimit;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D 0;=0A=
=A0=0A=
@@ -964,7 +965,7 @@ static void __pci_config_acs(struct pci_dev *dev, struc=
t pci_acs *caps,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 while (*p) {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!mask) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!acs_mask) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=
 Check for ACS flags */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 de=
limit =3D strstr(p, "@");=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (delimit) {=0A=
@@ -972,6 +973,8 @@ static void __pci_config_acs(struct pci_dev *dev, struc=
t pci_acs *caps,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 u32 shift =3D 0;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 end =3D delimit - p - 1;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 mask =3D 0;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 flags =3D 0;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 while (end > -1) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (*(p + end) =3D=3D '0') {=
=0A=
@@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, s=
truct pci_acs *caps,=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "ACS mask=A0 =3D %#06x\n", mask);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "ACS flags =3D %#06x\n", flags);=0A=
+=A0=A0=A0=A0=A0=A0 pci_dbg(dev, "ACS control =3D %#06x\n", caps->ctrl);=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 /* If mask is 0 then we copy the bit from the firmware =
setting. */=0A=
-=A0=A0=A0=A0=A0=A0 caps->ctrl =3D (caps->ctrl & ~mask) | (caps->fw_ctrl & =
mask);=0A=
-=A0=A0=A0=A0=A0=A0 caps->ctrl |=3D flags;=0A=
+=A0=A0=A0=A0=A0=A0 caps->ctrl &=3D ~mask;=0A=
+=A0=A0=A0=A0=A0=A0 caps->ctrl |=3D (flags & mask);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 pci_info(dev, "Configured ACS to %#06x\n", caps->c=
trl);=0A=
=A0}=0A=
@@ -1082,7 +1085,6 @@ static void pci_enable_acs(struct pci_dev *dev)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps=
.cap);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 pci_read_config_word(dev, pos + PCI_ACS_CTRL, &cap=
s.ctrl);=0A=
-=A0=A0=A0=A0=A0=A0 caps.fw_ctrl =3D caps.ctrl;=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (enable_acs)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_std_enable_acs(dev, &c=
aps);=0A=
--=0A=
2.34.1=0A=

