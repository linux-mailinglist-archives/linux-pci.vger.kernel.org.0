Return-Path: <linux-pci+bounces-42095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB68C87D93
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 03:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93A51354CCA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 02:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F63081AB;
	Wed, 26 Nov 2025 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JIzXjHLX"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A0249EB;
	Wed, 26 Nov 2025 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124734; cv=fail; b=ESc86PMiNX9sVZmUCP26hoLEL7P1tboWqrAbBp4WAqe6Si6S9RPtY9+35hZRCxiEkyFByM6rzbn7JXR75yz/S0zzMYT2Gv0DtKJiZZ/jXN2EN154Sy1YG1OV8XXTVoD/OdIjmXWNSrL3WopgoWZBJLkpBimw6BZHPcgyx7ip27g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124734; c=relaxed/simple;
	bh=sn4KLAyb0J3o1ugJSTWPXmSCoA3Bx3ZSv6Lk75cdZbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=imJxLfGWDBMDjJFH20AMuffSBHBzt/DxGOOHWRo03UrdqLffODuis83wEOna3GKdWtKFjuDpn7DVGgBfgALeFeH+uZ84oEkeTyKNBI2rzY5RjvD/0yoraokeedlXFVoFL7lFN4Vij9KiuVx56SnGlcd8ON84h+VfvM8/Fy+lxoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JIzXjHLX; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7xKQ7FwjNk9Uc4s2e8SxUJtDB5IVr37WbuaemxpSXEKaZ9G6F89KAAIr/D4mnKBjXJaRcb3Ahzj/Y+6h2keZenjADl66Lgu9msgL0RoJ3dTG7f7dTOMWEuuudc6Jr1fv5u9nAgcfo3KS+APpLDCqnwEjZNbOSz880as7cb0Fe6cjX+Wu4RTvT47Ekz4h/T+CZYnIHI0bIfUO4QH6DZYBDobyIDElJIX7r9aOwHTF5AnDkV+K4P9gVEfMAP3bd4tsUad/dPB1DZFOuBsoBYm2o/DE6s6SP+8WDAlc89rPucUPxyixtq2NzCU/IJXiXJCQ6PlzBWzWKK6rqcgkGztCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peXhP94zHXdjRC99EVuu4MIYC90oDPnY66tANDHrWo0=;
 b=zMt3RSSWmfmunBc6u/qFZS0pjRpal34Fr3shwUxe7oU2Ftgs46q1JehK2sf3BI7OlPUOGgm4VTHdwkQCRmu1Ok32H3LgYH3KZzJMHfhPPfIfe8V51MsJOH3HDAnz/GMR0zke4R4mbdEDbu0fw6LB5ybg9kqsOf0fQTA+10yimIoPyay4rhITFFO2wCWPrY5yzKXx0/6py6Ro/PUARKbymL1kHxPRx8aOnny+ln9BHuqegN7XmXLCHDax2+puptTAbPEF65EZNwqFJZawHQfhMFee/cAppWgEAsVpSSN9nVt8lJIL7I5lcBUXf3+lsZVx8Ok00bcvHka/X/3GHagqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peXhP94zHXdjRC99EVuu4MIYC90oDPnY66tANDHrWo0=;
 b=JIzXjHLXwdAHJbmwULxtsgEBEIwRYwUYuWQnFZkP/tPAKshlBcz+7NXM9s+A4jIi5CFgTHxizN7BM5kmTwYvh5ju6mySbOzMhMvC7BXJWwJLOUxtDkyt1yoG2q0QoTTydCF5vSkp06hDoY81aA8ZPvs1cVKrW+TTSdDPwSgDqDWSSXebFg+J/Qk1XKpwdFTQFPjFDGr0sVBE1doD+jZPudagLLjXtOw5PIiyCZTqx7aPsw87MuBV1oHDK1G7/GKPxkSVwtPAPTVpnrYLOJIQ99bM9J5SLExg0tEMKnaarAprXsZsZ5weEFlTMoXKwWQfRHt9hpgLQtejlH9fLWRHhQ==
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM0PR04MB6866.eurprd04.prod.outlook.com
 (2603:10a6:208:183::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 02:38:46 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 02:38:45 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: "manivannan.sadhasivam@oss.qualcomm.com"
	<manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>,
	=?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark"
	<derekjohn.clark@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephan Gerhold
	<stephan.gerhold@linaro.org>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>
Subject: RE: [PATCH v2 08/10] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Thread-Topic: [PATCH v2 08/10] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Thread-Index: AQHcXhorWq8bv5sJ10SiyCZPQ0dHVbUDhrVQ
Date: Wed, 26 Nov 2025 02:38:45 +0000
Message-ID:
 <VI0PR04MB121145313FF6024D52283CA9B92DEA@VI0PR04MB12114.eurprd04.prod.outlook.com>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
 <20251125-pci-m2-e-v2-8-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-8-32826de07cc5@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR04MB12114:EE_|AM0PR04MB6866:EE_
x-ms-office365-filtering-correlation-id: e57ab33b-94f6-4a3a-110f-08de2c94ebce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|921020|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?X/sSLRrdetEowtXPAEZxCL4lZSht/c6KbrW3arl0Yr9qc1pR5mIXLDD+os?=
 =?iso-8859-1?Q?5F0b0n09pUGey3Ia9PrJ8WLxbfT26b68GddFFS/8BWR76joyKokUKMHUMU?=
 =?iso-8859-1?Q?EgoR63bFz/oijx+RRA5GN2xGmVMsxXwIuq7Hvqok/BKAOymB6vvaQSA3En?=
 =?iso-8859-1?Q?o8eDava8by8HuFVsfGxS0QUat7cQKLZYy1Me0Jg0VsboY85oKj54FP86G/?=
 =?iso-8859-1?Q?ULAdeaEJX3PAugbLmdQlrx0UTQF62R3H0Lyot362zVd711bgJsg+1QIFXQ?=
 =?iso-8859-1?Q?MP/YMyzC5dbd5bCecO6VqQuUNff3RqihmeQ2udfXz2Th7Di+lUGtv3KN3n?=
 =?iso-8859-1?Q?2Gu6HX1qPLlLQoraBjJKHxy9bk2m12YAXrj2hzwv7fqbIWqvJNI3FXppOh?=
 =?iso-8859-1?Q?fUXFLVZheWWq4HmVQ5YZAXINb1mj6y0BfNYgpN3K/0nlzV6x6m36jhCRuM?=
 =?iso-8859-1?Q?ach4VHUoUv7IcyQu14+yrWzrmLA5WzQOle6xY1opoV1b1JOaz+tTcvNpl+?=
 =?iso-8859-1?Q?QGEV2cwJks0KmCZlaKqz59AlLPXJfov1h1Y//QjBLefDaAH+nPbG885ehI?=
 =?iso-8859-1?Q?5jcePYFIHjrEAkt9Z2CIsxG+cpVkHxZc/zGZNOioqLc9rOoaQWtCrGk2+B?=
 =?iso-8859-1?Q?VJfbgmzaeYmSJMxGqyo5wEZUhh/f8xREATFBbGV67g+5/BvMZUti7U4muN?=
 =?iso-8859-1?Q?pv7l5nZUBGrbXofqhvBoOtTiQ1T+sri/8WGXwn6HA1S/MCr400LxYCzjiy?=
 =?iso-8859-1?Q?5abT8rZiXntnum8sqsSMKVtOzRHw9mGr0TYffiIMk6v+zC3hqYBNvyR/gt?=
 =?iso-8859-1?Q?k9fFu+IeOn1dQAD+BLfYTjgzKUissmGL0dVPJeaJVSEing4wEBpaFExefK?=
 =?iso-8859-1?Q?ZLd7QNmUOMptCoGdXqQitCbjOl7K+BAp1p7zkqAC+oPFUYpsg2q2sE3JNy?=
 =?iso-8859-1?Q?vhQVyMTFmPjvqkahfwufSxeRL8iDprhaJ3DW6uPNY656imaku7TUiSv+Yk?=
 =?iso-8859-1?Q?kTuYWYcGJARQzEfBpJFd5lbLsFE+jfujbrRSD8UFXZb8rZ+otaReWOl6wk?=
 =?iso-8859-1?Q?9fhqJsXQVMVy3RGcZho4oqL09k6HuHX6pxcN+mPcAN2MMfR52xZmEAR0vO?=
 =?iso-8859-1?Q?E9E1RVwymnkystRnvz1M6mxGUGIrFQ2knStjWehgY4/Gfnq7eZs5I8BPJi?=
 =?iso-8859-1?Q?ap9KDn9ZDQjteUIXzTQD4QqYtGg+e/UOEUPq4TRQZ0p3W6x20CvfHjnk8y?=
 =?iso-8859-1?Q?gBdKtY83Bh1N7hrSqPMXEBznV1aHzs0oyKhwFlq0ILcBCy6dElL8Ahlmbw?=
 =?iso-8859-1?Q?1lUaXaFnWC2RBh5Fr5CVXE24uRjP4FqUMx04PGcDL3kQqEMeeu3aaQYqqC?=
 =?iso-8859-1?Q?2Bmbikx8ygVS2sLvb7ZAb1bPs76p7XQ7b6dzFxRbqxRLu3nIoWWz1Bvhia?=
 =?iso-8859-1?Q?XYN8ve3kmD7/Dak2hmeKvu19hmC/z+OW5DgappaTXduOBsa5uSXWnRgaLz?=
 =?iso-8859-1?Q?DShMQa84D7yYlsgI5s7QNDYVK3sVEnk+UVT/HY05UX8PNczzyGFd7liSwy?=
 =?iso-8859-1?Q?Q6k6G9b2iEh+R3gqPQS61JfclrsHs8YBgMlcWEbHR/oJkfHE0Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?G4jq5cGoQ4SoFuVoo0o24jdRLd4pU9BVFzw4AjhmkjmGVbOLBwxE6hOFa8?=
 =?iso-8859-1?Q?4BS8noXi31RF4ls1ZDbEjASJmPek8gan2CWQXif0HQ8wOaVCXSoBUjYWuN?=
 =?iso-8859-1?Q?QG588Tu6/BXyHv22ATmmysjiPfxISKP64LpkpsV0ia/TvA0mPd48/03zRS?=
 =?iso-8859-1?Q?qTC4n7K3pbSXXvW6cLXehUSQXbrm7hG5+mzRx6ZJFZulUyIVn8aLW7E8Yz?=
 =?iso-8859-1?Q?jXJjVzmWoWKs/COySU7pmP+5uk4DPvtlPFHb8XtJKLtv5tLtQ+gjw4WfJv?=
 =?iso-8859-1?Q?lFQkNRpmaGLdGcD1ef+j27Er6esqAEQna88Io8ih5qxXj9OqFjemEMhvqn?=
 =?iso-8859-1?Q?3R+nZsOXRv6a7GJlrCZoNNejIZG5V36LOg9yxzoWK1jDXAxbJKhb83puxR?=
 =?iso-8859-1?Q?gfNZ7ijIQavhsoZ0Lf9eSQvC3JCPEM7E+jes/lDv0DCA+R5P/17EM0LtrY?=
 =?iso-8859-1?Q?GMrF6AWwXGpKlAtH5qPfVfFKi2uYq34y9ZhGvT1v8R8SR8gtGitSplCHn1?=
 =?iso-8859-1?Q?Snn95z4Z2q51fWv/M0vkOtwIMzYjFTBxGzso9yIkCIwbNKbJzqFFren7Ny?=
 =?iso-8859-1?Q?nM/eWPWmTAaLNhP1j2DXjNVS8iZ4423fKLesEwW+6XC47eQdtPa4No8mHb?=
 =?iso-8859-1?Q?rbdQ8u3IE8lE5TRMu4p6VorUghXwpoDcd7j2Wrsf4NGotKqYqGMUvCNu+E?=
 =?iso-8859-1?Q?Fi6Mq0u9hTY539HhGy0QytAL01kPc3cw/z2kxk1FgY82+PHK2zARRKoYsk?=
 =?iso-8859-1?Q?IlyLTRVCPgqcvIv0Uzuxfm6z2NPToMUbVruZqH/4EvX44Nu3IgNaZPcm6D?=
 =?iso-8859-1?Q?dnXw6UeP/nvsBrrIbGAG1QxFmgNEUiOfUe0YR5XaZWgcShy7sP87HnQKZ/?=
 =?iso-8859-1?Q?euFUkNbqMtOiG6pSBp4S4/KN1PAnW+hVnFdJ4vWT6ySI7DGnoYvOdbYchn?=
 =?iso-8859-1?Q?OIlkEfrwivToRilsymLiMNUbn5tvArBPWtDYOIakZtOQ5gfzCfVWaZkxjb?=
 =?iso-8859-1?Q?HMvwe5jIXhKcqqR7YpDALuoeA3Qlo53TGMCB/wJx4vkbVVEqi6VtdFlc1t?=
 =?iso-8859-1?Q?ByRJ75GdHffsmsqdJAa1SJhoCD69sZfXWTRQSObRhTlN5dhir8jdbHYwNd?=
 =?iso-8859-1?Q?dD2snXOKj2j31RPRs/cbB6mQzEX977rat0p9SU7fQL8uq7nYHPTQ0gCroc?=
 =?iso-8859-1?Q?1TGZxF21AM/MwaSFG1bVDxSUsJ4axzFIMNPBU0oKcWFxBXjW13ySnMIQ4k?=
 =?iso-8859-1?Q?SxWr2Ka9Qgr5GBlMyfNljgRGwkR46l6qexNjChz3IlC2+g5AvCeobKIZWB?=
 =?iso-8859-1?Q?2RkfM/zT0q+mTewM4qsRLqws1Spl678qH7KAz4DoA+UbJiR4Qi+RrfiBP5?=
 =?iso-8859-1?Q?FsZ76VXeiIc82GIiRDqq9HOr3LIkZulNFkZAtXk1vYooReX5d0ol+3EtJx?=
 =?iso-8859-1?Q?fffTG2Ci1KZWhJacWNlqLu/PCNsROBjSf5tt0xxXVKC+d5Th2Q898agzHx?=
 =?iso-8859-1?Q?f+gtDFfWVZ7bvkyeKsPX3Qz0YqEQSykKW0lJCfJtyon+ajtlvGUp2z/4Dl?=
 =?iso-8859-1?Q?JKE14e0e2R0859NdZaZUk79qHzHdM0Aq3SfcxfYckk24uD+UO/mbYVoKHB?=
 =?iso-8859-1?Q?RMsv8gAc2RcWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57ab33b-94f6-4a3a-110f-08de2c94ebce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 02:38:45.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5eaA2JXYD1eDjnZK1PCSlil6CDAzwCr7KWnosoKrHpKGCk5DCKthNAqcnuHtZQ1u3IqUgIrQRZdc2NggVfYOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866



> -----Original Message-----
> From: Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
> Sent: Tuesday, November 25, 2025 10:45 PM
> To: Rob Herring <robh@kernel.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; Nathan
> Chancellor <nathan@kernel.org>; Nicolas Schier <nicolas.schier@linux.dev>=
;
> Hans de Goede <hansg@kernel.org>; Ilpo J=E4rvinen
> <ilpo.jarvinen@linux.intel.com>; Mark Pearson <mpearson-
> lenovo@squebb.ca>; Derek J. Clark <derekjohn.clark@gmail.com>;
> Manivannan Sadhasivam <mani@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Marcel
> Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>; Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> kbuild@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> msm@vger.kernel.org; linux-bluetooth@vger.kernel.org; linux-
> pm@vger.kernel.org; Stephan Gerhold <stephan.gerhold@linaro.org>; Dmitry
> Baryshkov <dmitry.baryshkov@oss.qualcomm.com>; Manivannan
> Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Subject: [PATCH v2 08/10] dt-bindings: connector: Add PCIe M.2 Mechanical
> Key E connector
>=20
> From: Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector define=
d
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector pro=
vides
> interfaces like PCIe or SDIO to attach the WiFi devices to the host machi=
ne,
> USB or UART+PCM interfaces to attach the Bluetooth (BT) devices along wit=
h
> additional interfaces like I2C for NFC solution. At any point of time, th=
e
> connector can only support either PCIe or SDIO as the WiFi interface and =
USB
> or UART as the BT interface.
>=20
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating a=
t 1.8v
> sideband signaling.
>=20
> The connector also supplies optional signals in the form of GPIOs for fin=
e
> grained power management.
>=20
> Signed-off-by: Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 178
> +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 179 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-
> connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-
> connector.yaml
> new file mode 100644
> index 000000000000..fe2c9a943a21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-
> connector.ya
> +++ ml
> @@ -0,0 +1,178 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id:
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic=
e
> +tree.org%2Fschemas%2Fconnector%2Fpcie-m2-e-
> connector.yaml%23&data=3D05%7C
> +02%7Csherry.sun%40nxp.com%7C22ea3ba76ac749b69bee08de2c314c73%7
> C686ea1d3
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638996787414741474%7CUnkno
> wn%7CTWFpb
> +GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFO
> +IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DY8y5ctS7QJzaMZ
> wdY%2FAnr
> +FqydRTUumh3hRBDMtK%2B8Y4%3D&reserved=3D0
> +$schema:
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic=
e
> +tree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Csherry.sun%40nxp.
> +com%7C22ea3ba76ac749b69bee08de2c314c73%7C686ea1d3bc2b4c6fa92cd
> 99c5c3016
> +35%7C0%7C0%7C638996787414756341%7CUnknown%7CTWFpbGZsb3d8ey
> JFbXB0eU1hcGk
> +iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj
> oyfQ
> +%3D%3D%7C0%7C%7C%7C&sdata=3Dz9JeuCv1%2BkOH%2FjQcV2hpwgfuMJykj
> 1SFgn4EzkHSK
> +0Q%3D&reserved=3D0
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical
> +Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the
> +host
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on th=
e
> +      connector. Since a single connector can have multiple interfaces, =
every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Connector interfaces for Wi-Fi
> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: PCIe interface
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: SDIO interface
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
> +          - required:
> +              - endpoint@1
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Connector interfaces for BT
> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: USB 2.0 interface
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: UART interface
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
> +          - required:
> +              - endpoint@1
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCM/I2S interface
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: I2C interface
> +
> +    oneOf:
> +      - required:
> +          - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host
> system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO controlled connection to W_DISABLE1# signal. This
> signal
> +      is used by the system to disable WiFi radio in the M.2 card. Refer=
, PCI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO controlled connection to W_DISABLE2# signal. This
> signal
> +      is used by the system to disable BT radio in the M.2 card. Refer, =
PCI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO controlled connection to IO voltage configuration
> +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate =
to the
> +      host system that the card supports an independent IO voltage domai=
n for
> +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, s=
ec
> +      3.1.15.1 for more details.
> +    maxItems: 1
> +
> +  uim-power-src-gpios:
> +    description: GPIO controlled connection to UIM_POWER_SRC signal. Thi=
s
> signal
> +      is used when the NFC solution is implemented and receives the powe=
r
> output
> +      from WWAN_UIM_PWR signal of the another WWAN M.2 card. Refer,
> PCI Express
> +      M.2 Specification r4.0, sec 3.1.11.1 for more details.
> +    maxItems: 1
> +
> +  uim-power-snk-gpios:
> +    description: GPIO controlled connection to UIM_POWER_SNK signal. Thi=
s
> signal
> +      is used when the NFC solution is implemented and supplies power to=
 the
> +      Universal Integrated Circuit Card (UICC). Refer, PCI Express M.2
> +      Specification r4.0, sec 3.1.11.2 for more details.
> +    maxItems: 1
> +
> +  uim-swp-gpios:
> +    description: GPIO controlled connection to UIM_SWP signal. This sign=
al is
> +      used when the NFC solution is implemented and implements the Singl=
e
> Wire
> +      Protocol (SWP) interface to the UICC. Refer, PCI Express M.2 Speci=
fication
> +      r4.0, sec 3.1.11.3 for more details.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply

Hi Mani,

I am wondering if vpcie3v3-supply property is necessary here, consider the =
following real board designs on our i.MX platforms.

1. M.2 power always on, it connected to board VDD_3V3, no control gpio. Sho=
uld we not configure the vpcie3v3-supply or add the fake regulator like the=
 one below?
    reg_m2_pwr: regulator-m2-pwr {
        compatible =3D "regulator-fixed";
        regulator-max-microvolt =3D <3300000>;
        regulator-min-microvolt =3D <3300000>;
        regulator-name =3D " M.2-power";
    };

2. M.2 power regulator reuses w_disable1# gpio for control. Should we use t=
he vpcie3v3-supply or w-disable1-gpios to control this?

Best Regards
Sherry


