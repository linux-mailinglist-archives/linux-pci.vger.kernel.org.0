Return-Path: <linux-pci+bounces-13560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13089987412
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C31F214D0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7EA25632;
	Thu, 26 Sep 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="RqZIEcEL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C4134AC;
	Thu, 26 Sep 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355738; cv=fail; b=V2eYtV5lrsKAxSnLuG5cYaVOJlmmMaiM8JrKCYZHAQT94LVW3WIjIFOKb1e81DHkJR+ytLG1XtLvoSjidIkWjHFaGVuWWdixh9WtkyIWX2DRKkmoOWGaXss+jhyYrflAeMU8tPQ+oAj6BBSoGfYdm8qi+zIVNKKLzM8x2MpP6Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355738; c=relaxed/simple;
	bh=kiV3iKzNRhzAVDzOX8yhPRoPSSHNeW8DGQ5juO27xGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3bgJjZD96IaNpw5JPr+MsNf/ErYRY2v4YjLLqm/a51G8ry1Jq0wp1m4yBWYVCF0hX6Mqc0oLVXlhTGQ0xLlTCq5tCTSBoXY4gGeSmohWxN8J2GCXrQtmKjysVyA0KeypDZ2uXBRChhLp/uF308+Y9uK1zmvA6rWmcIX3qrBwak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=RqZIEcEL; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QA15eC004699;
	Thu, 26 Sep 2024 06:01:46 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41vfp3xaex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 06:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNZGNHYmzLVqwxBD12Q4YMiktFv4WNSLQMaCiOeI7fku5j/kpjErEJlR/PtMr1TH49mcwndD9K4QwDHD9uNjdD0gFnZ29GPkIo2UGp9SzKcfpOajMD2JQrqRnls/U96Ex3nnEb8NYBKKc3wp5t7J4Qz9NHqCbYV3mjTLVeEU6R9OITLDV1C8NvNJbo3wloQJTB+H6qX+x3a508oKRhjkkx7AhUNFSjXt/g7VlYQNEeRL9pxzVC5tH4qGnqTHBPmAS9Orod1HzClKsZlYnrfwwVQdQOAJJPVBYKlj4OiEqKaPbN0+dpM8rfumOGZlbfspfxKY+ToZBv4nghJ9yY+Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0bfdBj0+KRgD2W6IJFVNGrE1yPQKuQ7FFw60pKhz4g=;
 b=fQ6bpm3n9Q4SI/KFf/2DwULtp0ZraJfgs2MPmaj3u8lr4uwM6a0PbkiCWp6NSf3pgYrUWWn+b634o6HwXhN8pyg4VVsuhgMN3u55jybDHt/tf1R1M9aUsZlbFl54TaaAp9LzTdsaMUk4Nxem1oCIyh08eOpzDFN3G3nWH8UjHKT1rLJRr6v8t65bwLdBfzV/vcLgmxQ53ikbL4ceRe9KeJLrFd/tKJVC8pqoN34VhnycBStsADsajOJXEVYouQr9xYS/TIpts9H0VDknR6XNjRB7b2HK+Ad9GVkWndQEZhZ8szvMfsFyX5mpjdVAiKimJkSEMg+vvv347Q+SOHQOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0bfdBj0+KRgD2W6IJFVNGrE1yPQKuQ7FFw60pKhz4g=;
 b=RqZIEcELwRUFIeBZpqcg2LtwAEmfGO0VlroERSMLIGIkKYwVlPTkN3E2vcD2UHskN2h/qUiJYf6C9PT24F4AkLCxr9JR9pWqlu01TjW0yQzFDviiGy5QxYe3m2OzKWtMRBIso32JOQy0VqtowhDO4uo1I91jOIAZckHjkXC0KfY=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by SJ0PR18MB4413.namprd18.prod.outlook.com (2603:10b6:a03:3ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 13:01:41 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.8005.021; Thu, 26 Sep 2024
 13:01:41 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: RE: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHa96U5wMquoeCkjUiLMha3b4gFCrJZ8y0AgBAoL7A=
Date: Thu, 26 Sep 2024 13:01:40 +0000
Message-ID:
 <PH0PR18MB44255522F80C7113038EB8A3D96A2@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240823052251.1087505-1-sthotton@marvell.com>
 <20240826104531.1232136-1-sthotton@marvell.com>
 <PH0PR18MB4425913FD7CCB42864311F52D9602@PH0PR18MB4425.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB4425913FD7CCB42864311F52D9602@PH0PR18MB4425.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|SJ0PR18MB4413:EE_
x-ms-office365-filtering-correlation-id: 5cc57ddf-9c6e-45fb-feb5-08dcde2b5d44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?//r0GalF5sLjkBwvZLXpBIYdInEHoFKX8OpntMtPclsSuk0JRA6x+fKnMCI2?=
 =?us-ascii?Q?dPomAwRIR65IXY2f2t8Tm4Xj0s7ATdc8GfbrtQqAKZvNUnFsjrQh5EROQv4Q?=
 =?us-ascii?Q?/MGzcOz+0qllMNHmkW3hFkY9bEmj4k9egzb2TseVtJKO7rhLaT0DEMuYO92L?=
 =?us-ascii?Q?D1WaQQGsUY8O28Lxn8uvf+hjKJg3pNyKJtkzmpGyGEyvaerF+BvdCNlPsj/j?=
 =?us-ascii?Q?4Tly7BH1eShvhy6MJ5RhcfhJr+fnulvWSr57wC+XFcIVvd3D9pzHq0ux+Wig?=
 =?us-ascii?Q?wXHa6j7vjyWvpixyHqq4GEG59GAW1td9oD31KT9LoTy2cyfoc9SJzq7jk5eD?=
 =?us-ascii?Q?YipAmNJrqWZOmuPtY26E/aj50ZRVAahcWwur8TVRbyjs36WRov7Zu504wvyT?=
 =?us-ascii?Q?g+Ze3x4vQU1y9SP+9b6nBGqgMDn4tdd7HQuu6AGC7nJEtc3fL4quXJLjfSlQ?=
 =?us-ascii?Q?ey+tKCuxp9NF6TS+xPqQ7RQ/pmf0QSX+P9j6IrApScFzeM2/xcs7rfAUXek/?=
 =?us-ascii?Q?1w5HSDna9CMvbhD0o8mo/KoU/MVki4QEBHTzfBJ9sgSLx/ldtCwSD2M3hBh+?=
 =?us-ascii?Q?/GtqtVAbYiNoNIvadkfffj80iH/CqPYVx7DJ8RwZbQ9yrG+5GT6lFDE0x7U7?=
 =?us-ascii?Q?gzCmcw34IAl1Td3ZobiA2JZQHzKEcYWP74nkH+mYGsleBqPtpceIaDlHhVo2?=
 =?us-ascii?Q?WFyU/ADBI5OnpqdWqvWbtrHvnl3HmpJE1NZSs1IEWRNg6F505TFmMTurKe9c?=
 =?us-ascii?Q?QlLGIzzbe5qshG47+yX7pTFz2yhxhZdA/VHOwXIweg1lfOcfaEpIeJAa3cEv?=
 =?us-ascii?Q?o2crYseqefIQRJBUd6Y9Qv2u8p9/ChWFbYcQkZSVPtKPTYFDpRhcID+EkTvO?=
 =?us-ascii?Q?WO0+R567GVnwNbDwOU6WSL/nRbo4Pzndx9x44VqR4lcyQiRfwvSNNBkRzQve?=
 =?us-ascii?Q?sCXNiTFZmQSMTyDU9uArYetFlu3j7hcWxcu5XCKD7pts/+WSzfM3POc3Iv+4?=
 =?us-ascii?Q?uD7IvtXyWjH7QxiuTTFTL1l64MhSfMpULSF2t28A35IyA3wjG8zKH6K5Uad2?=
 =?us-ascii?Q?2FVDY4Yyc27bD1MkHo6X0QPQQSTjgxXj1vFr4QNmiAlecUvg3tVu4CmGD0vF?=
 =?us-ascii?Q?Pz+AFX4N5v0WtemELut/rTYk2dBMU7zV85V70OfXb61t0V9OWJVAy4Ib1/Kw?=
 =?us-ascii?Q?tgxAKGTNuS/qi7L85iNqreLzCZqtOsu+zCgNmvWEYmtfoIcr9sjC4t4Hls6R?=
 =?us-ascii?Q?toqVKXZtWI8h6W6/1k4m+LZoje1TKxAV9bo/2CH+mWlSxkk8YJVLZ8G/YTd7?=
 =?us-ascii?Q?CfPfkNxmrJBv+r7MIP9867HMZmx5xxKcZd6NDH6V8P3PcxsR86GnhiMVeGR8?=
 =?us-ascii?Q?Qbp/GGjwO8Mn8jhUzOxC0Vb1YZIZMbJUrNVLWUM6YTmsgudZRQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NiqJSJvpGPPLz8CfbZIrSB4+IXaQQ8ucK60akxHzklfk8GbJmzQbsWOeBGAJ?=
 =?us-ascii?Q?VHuam1CDdxNEIC3AOjksUCaG2fk05Gm/vvZ9iS3oEAO7hVNjm+YwSy8rthiU?=
 =?us-ascii?Q?3vOojtZAueXZqEdjBaU/kySK5LQxdkf9ZkIpnhM1f102EYPd95hEVH1UiOlh?=
 =?us-ascii?Q?CHDd2kqKpQRKL7HprGrS+7tFqM3oVonL6bhj9vPd9Y8kWh58BULYOH8I5KWp?=
 =?us-ascii?Q?zYeWEz6DzZ4PLpZvoi8v+BRJaJd07Spmd8RIeCzf7jlXqqH86xV4d+H78fUi?=
 =?us-ascii?Q?YfbU0Ao990Ei6f+EFgK1s2UM/FyJAZQ6zPDvnoM7ZHMfGi36cc+dhE3Bs8Kf?=
 =?us-ascii?Q?Vp/zE4/a2dvMFKrupe1pg7Fl8Xe4r5M0XypAzjH6GBykfrpTfgycU7ViXEPc?=
 =?us-ascii?Q?G/vXYjIjhjxCEiYOSmX5ClnCXfjTIqnoj2d8X4IwtIayBMPhhTDC3mCTKn+V?=
 =?us-ascii?Q?ZRHihMBAK7RsHhTpHQtj2F8IZ10+wX6g+wXgyaaNGRNTt1B2sYH6E3dtXKIL?=
 =?us-ascii?Q?bZhfFsfzY3vRlZRSrbvBY7z4yBKiZ/BQCievoxXIXbW49Y+T3/qY6m1U6S0p?=
 =?us-ascii?Q?qEhLzsgtejHRUq3YvaH7m2hNUzWev4Gx5p+ktu/OonGEbNNeSy6FDcepldlO?=
 =?us-ascii?Q?vI3tr0+6PsoFw3h5/kzk7Mv1kGRIK1NXUB37QJBZvGAuc7O6V7qjVYVpSKcz?=
 =?us-ascii?Q?1OtukD+/Vo8jC1DjtZmH/NwoRGPVzaBA6c1u2t5vdAeNUyhwkoRLxyy5oZvW?=
 =?us-ascii?Q?QDfWD95WnBfW93VdqcpWaUrOwzR/UDD6XzEsLFB8MejG2VsxXQeeVxP5g+Q0?=
 =?us-ascii?Q?5WbmzMSgXTaoPAMtFZ5S36ABl3Ichs5JxSOvHAkTwNFY0901Y2dU+DDbKAqj?=
 =?us-ascii?Q?nICGRXvuhvdt4gaNxCI/TTtpni8naOuuoBUdDRks9n6glE8gA13Zg7KkTsBy?=
 =?us-ascii?Q?LCWkQbwtVSw2S1f0T0zy6hHGAP4KRtp5/zM0llP8pYqjErsEAab5BJM0KvAN?=
 =?us-ascii?Q?P/AShY/Ac5pKrTLtITnKUXTq8AM45hylua43caoVq63O6zbo0QNMdM9dPeDO?=
 =?us-ascii?Q?59aN1H6h06Oi+VVz2DvtJNSGVSK4qwvUb5fZ+hcpWUP0h1ZHjNa/RqFOA57W?=
 =?us-ascii?Q?BjFwxT2BHB9Y6QWqqcY1fu8zLV6WKU+6ExtiSSELDPxVec079GIg7r9J106k?=
 =?us-ascii?Q?FAPVnSmdRb4V+jBrj9waopEKcg0fMnloBrcqMntnStrecU/vmS4xSoCZ5NsL?=
 =?us-ascii?Q?/VrVwixchhBv5SFaDHCmfrUPMQ59D1wJv3HUF3QdnE/qZYAWNKFSJfVPXpt+?=
 =?us-ascii?Q?W7iJC3qNDzYK8iI5+DElW1pOWlHzQYdFZbGwHJkvVaLGnlJ2HQRTx34e5EwD?=
 =?us-ascii?Q?LhlPsvvl7dEGJUKyFlxsL8Q66Ehr5n8CDNnu8+Bi+/diwjXc1gJ1cbP9T4rl?=
 =?us-ascii?Q?v5v5PDgiGg+D7LbeXn+shjl6L4apb0eEXl7IhZW+SwDULEVp4saiKeAG5E8q?=
 =?us-ascii?Q?UamfP1NzNRL/pN1Ux1yyhGCCFSsXfyQOOO83/Enq2CQwKmCQUnFQyIhHcSuf?=
 =?us-ascii?Q?IeEYUc7hfN8bNpq4XhWTgzolZf3AXePnowkjA6QT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc57ddf-9c6e-45fb-feb5-08dcde2b5d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 13:01:40.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C37AGPwY+OFsWOtfpWqIv/cn+N2YsLt4Jwuxw2byZ1rRhx0NeTOZ5UrFZNQNsDTvm7tqyIfmbBu8oRmi6vVjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4413
X-Proofpoint-GUID: z5rvwzJSgLhfA4-AhmhwTfkoAjhCWt2X
X-Proofpoint-ORIG-GUID: z5rvwzJSgLhfA4-AhmhwTfkoAjhCWt2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Just a gentle reminder.
Could you please comments if there are improvements needed?

>Hi Helgaas,
>
>Please check this patch.
>
>>This patch introduces a PCI hotplug controller driver for the OCTEON
>>PCIe device, a multi-function PCIe device where the first function acts
>>as a hotplug controller. It is equipped with MSI-x interrupts to notify
>>the host of hotplug events from the OCTEON firmware.
>>
>>The driver facilitates the hotplugging of non-controller functions
>>within the same device. During probe, non-controller functions are
>>removed and registered as PCI hotplug slots. The slots are added back
>>only upon request from the device firmware. The driver also allows the
>>enabling and disabling of the slots via sysfs slot entries, provided by
>>the PCI hotplug framework.
>>
>>Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>>Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
>>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>>---
>>
>>This patch introduces a PCI hotplug controller driver for OCTEON PCIe hot=
plug
>>controller. The OCTEON PCIe device is a multi-function device where the f=
irst
>>function acts as a PCI hotplug controller.
>>
>>              +--------------------------------+
>>              |           Root Port            |
>>              +--------------------------------+
>>                              |
>>                             PCIe
>>                              |
>>+---------------------------------------------------------------+
>>|              OCTEON PCIe Multifunction Device                 |
>>+---------------------------------------------------------------+
>>            |                    |              |            |
>>            |                    |              |            |
>>+---------------------+  +----------------+  +-----+  +----------------+
>>|      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
>>| (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
>>+---------------------+  +----------------+  +-----+  +----------------+
>>            |
>>            |
>>+-------------------------+
>>|   Controller Firmware   |
>>+-------------------------+
>>
>>The hotplug controller driver facilitates the hotplugging of non-controll=
er
>>functions in the same device. During the probe of the driver, the non-
>controller
>>function are removed and registered as PCI hotplug slots. They are added =
back
>>only upon request from the device firmware. The driver also allows the us=
er to
>>enable/disable the functions using sysfs slot entries provided by PCI hot=
plug
>>framework.
>>
>>This solution adopts a hardware + software approach for several reasons:
>>
>>1. To reduce hardware implementation cost. Supporting complete hotplug
>>   capability within the card would require a PCI switch implemented with=
in.
>>
>>2. In the multi-function device, non-controller functions can act as emul=
ated
>>   devices. The firmware can dynamically enable or disable them at runtim=
e.
>>
>>3. Not all root ports support PCI hotplug. This approach provides greater
>>   flexibility and compatibility across different hardware configurations=
.
>>
>>The hotplug controller function is lightweight and is equipped with MSI-x
>>interrupts to notify the host about hotplug events. Upon receiving an
>>interrupt, the hotplug register is read, and the required function is ena=
bled
>>or disabled.
>>
>>This driver will be beneficial for managing PCI hotplug events on the OCT=
EON
>>PCIe device without requiring complex hardware solutions.
>>
>>Changes in v2:
>>- Added missing include files.
>>- Used dev_err_probe() for error handling.
>>- Used guard() for mutex locking.
>>- Splited cleanup actions and added per-slot cleanup action.
>>- Fixed coding style issues.
>>- Added co-developed-by tag.
>>
>>Changes in v3:
>>- Explicit assignment of enum values.
>>- Use pcim_iomap_region() instead of pcim_iomap_regions().
>>
>> MAINTAINERS                    |   6 +
>> drivers/pci/hotplug/Kconfig    |  10 +
>> drivers/pci/hotplug/Makefile   |   1 +
>> drivers/pci/hotplug/octep_hp.c | 409
>>+++++++++++++++++++++++++++++++++
>> 4 files changed, 426 insertions(+)
>> create mode 100644 drivers/pci/hotplug/octep_hp.c
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 42decde38320..7b5a618eed1c 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>> R:	vattunuru@marvell.com
>> F:	drivers/vdpa/octeon_ep/
>>
>>+MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>>+R:	Shijith Thotton <sthotton@marvell.com>
>>+R:	Vamsi Attunuru <vattunuru@marvell.com>
>>+S:	Supported
>>+F:	drivers/pci/hotplug/octep_hp.c
>>+
>> MATROX FRAMEBUFFER DRIVER
>> L:	linux-fbdev@vger.kernel.org
>> S:	Orphan
>>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>>index 1472aef0fb81..2e38fd25f7ef 100644
>>--- a/drivers/pci/hotplug/Kconfig
>>+++ b/drivers/pci/hotplug/Kconfig
>>@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>>
>> 	  When in doubt, say Y.
>>
>>+config HOTPLUG_PCI_OCTEONEP
>>+	bool "OCTEON PCI device Hotplug controller driver"
>>+	depends on HOTPLUG_PCI
>>+	help
>>+	  Say Y here if you have an OCTEON PCIe device with a hotplug
>>+	  controller. This driver enables the non-controller functions of the
>>+	  device to be registered as hotplug slots.
>>+
>>+	  When in doubt, say N.
>>+
>> endif # HOTPLUG_PCI
>>diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>>index 240c99517d5e..40aaf31fe338 100644
>>--- a/drivers/pci/hotplug/Makefile
>>+++ b/drivers/pci/hotplug/Makefile
>>@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>>rpaphp.o
>> obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
>> obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
>> obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>>+obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>>
>> # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>>
>>diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_h=
p.c
>>new file mode 100644
>>index 000000000000..77dc2740f43e
>>--- /dev/null
>>+++ b/drivers/pci/hotplug/octep_hp.c
>>@@ -0,0 +1,409 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+/* Copyright (C) 2024 Marvell. */
>>+
>>+#include <linux/cleanup.h>
>>+#include <linux/container_of.h>
>>+#include <linux/delay.h>
>>+#include <linux/dev_printk.h>
>>+#include <linux/init.h>
>>+#include <linux/interrupt.h>
>>+#include <linux/io-64-nonatomic-lo-hi.h>
>>+#include <linux/kernel.h>
>>+#include <linux/list.h>
>>+#include <linux/module.h>
>>+#include <linux/mutex.h>
>>+#include <linux/pci.h>
>>+#include <linux/pci_hotplug.h>
>>+#include <linux/slab.h>
>>+#include <linux/spinlock.h>
>>+#include <linux/workqueue.h>
>>+
>>+#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>>+#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>>+#define OCTEP_HP_DRV_NAME "octep_hp"
>>+
>>+/*
>>+ * Type of MSI-X interrupts.
>>+ * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are
>>used to
>>+ * generate the vector and offset for an interrupt type.
>>+ */
>>+enum octep_hp_intr_type {
>>+	OCTEP_HP_INTR_INVALID =3D -1,
>>+	OCTEP_HP_INTR_ENA =3D 0,
>>+	OCTEP_HP_INTR_DIS =3D 1,
>>+	OCTEP_HP_INTR_MAX =3D 2,
>>+};
>>+
>>+struct octep_hp_cmd {
>>+	struct list_head list;
>>+	enum octep_hp_intr_type intr_type;
>>+	u64 intr_val;
>>+};
>>+
>>+struct octep_hp_slot {
>>+	struct list_head list;
>>+	struct hotplug_slot slot;
>>+	u16 slot_number;
>>+	struct pci_dev *hp_pdev;
>>+	unsigned int hp_devfn;
>>+	struct octep_hp_controller *ctrl;
>>+};
>>+
>>+struct octep_hp_intr_info {
>>+	enum octep_hp_intr_type type;
>>+	int number;
>>+	char name[16];
>>+};
>>+
>>+struct octep_hp_controller {
>>+	void __iomem *base;
>>+	struct pci_dev *pdev;
>>+	struct octep_hp_intr_info intr[OCTEP_HP_INTR_MAX];
>>+	struct work_struct work;
>>+	struct list_head slot_list;
>>+	struct mutex slot_lock; /* Protects slot_list */
>>+	struct list_head hp_cmd_list;
>>+	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
>>+};
>>+
>>+static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
>>+				 struct octep_hp_slot *hp_slot)
>>+{
>>+	guard(mutex)(&hp_ctrl->slot_lock);
>>+	if (hp_slot->hp_pdev) {
>>+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already
>>enabled\n",
>>+			hp_slot->slot_number);
>>+		return;
>>+	}
>>+
>>+	/* Scan the device and add it to the bus */
>>+	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>>+						  hp_slot->hp_devfn);
>>+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>>+	pci_bus_add_device(hp_slot->hp_pdev);
>>+
>>+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n",
>>+		hp_slot->slot_number);
>>+}
>>+
>>+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
>>+				  struct octep_hp_slot *hp_slot)
>>+{
>>+	guard(mutex)(&hp_ctrl->slot_lock);
>>+	if (!hp_slot->hp_pdev) {
>>+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
>>+			hp_slot->slot_number);
>>+		return;
>>+	}
>>+
>>+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n",
>>+		hp_slot->slot_number);
>>+
>>+	/* Remove the device from the bus */
>>+	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
>>+	hp_slot->hp_pdev =3D NULL;
>>+}
>>+
>>+static int octep_hp_enable_slot(struct hotplug_slot *slot)
>>+{
>>+	struct octep_hp_slot *hp_slot =3D
>>+		container_of(slot, struct octep_hp_slot, slot);
>>+
>>+	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
>>+	return 0;
>>+}
>>+
>>+static int octep_hp_disable_slot(struct hotplug_slot *slot)
>>+{
>>+	struct octep_hp_slot *hp_slot =3D
>>+		container_of(slot, struct octep_hp_slot, slot);
>>+
>>+	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
>>+	return 0;
>>+}
>>+
>>+static struct hotplug_slot_ops octep_hp_slot_ops =3D {
>>+	.enable_slot =3D octep_hp_enable_slot,
>>+	.disable_slot =3D octep_hp_disable_slot,
>>+};
>>+
>>+#define SLOT_NAME_SIZE 16
>>+static struct octep_hp_slot *
>>+octep_hp_register_slot(struct octep_hp_controller *hp_ctrl,
>>+		       struct pci_dev *pdev, u16 slot_number)
>>+{
>>+	char slot_name[SLOT_NAME_SIZE];
>>+	struct octep_hp_slot *hp_slot;
>>+	int ret;
>>+
>>+	hp_slot =3D kzalloc(sizeof(*hp_slot), GFP_KERNEL);
>>+	if (!hp_slot)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	hp_slot->ctrl =3D hp_ctrl;
>>+	hp_slot->hp_pdev =3D pdev;
>>+	hp_slot->hp_devfn =3D pdev->devfn;
>>+	hp_slot->slot_number =3D slot_number;
>>+	hp_slot->slot.ops =3D &octep_hp_slot_ops;
>>+
>>+	snprintf(slot_name, sizeof(slot_name), "octep_hp_%u", slot_number);
>>+	ret =3D pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
>>+			      PCI_SLOT(pdev->devfn), slot_name);
>>+	if (ret) {
>>+		kfree(hp_slot);
>>+		return ERR_PTR(ret);
>>+	}
>>+
>>+	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
>>+	octep_hp_disable_pdev(hp_ctrl, hp_slot);
>>+
>>+	return hp_slot;
>>+}
>>+
>>+static void octep_hp_deregister_slot(void *data)
>>+{
>>+	struct octep_hp_slot *hp_slot =3D data;
>>+	struct octep_hp_controller *hp_ctrl =3D hp_slot->ctrl;
>>+
>>+	pci_hp_deregister(&hp_slot->slot);
>>+	octep_hp_enable_pdev(hp_ctrl, hp_slot);
>>+	list_del(&hp_slot->list);
>>+	kfree(hp_slot);
>>+}
>>+
>>+static bool octep_hp_is_slot(struct octep_hp_controller *hp_ctrl,
>>+			     struct pci_dev *pdev)
>>+{
>>+	/* Check if the PCI device can be hotplugged */
>>+	return pdev !=3D hp_ctrl->pdev && pdev->bus =3D=3D hp_ctrl->pdev->bus &=
&
>>+	       PCI_SLOT(pdev->devfn) =3D=3D PCI_SLOT(hp_ctrl->pdev->devfn);
>>+}
>>+
>>+static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
>>+				 struct octep_hp_cmd *hp_cmd)
>>+{
>>+	struct octep_hp_slot *hp_slot;
>>+
>>+	/*
>>+	 * Enable or disable the slots based on the slot mask.
>>+	 * intr_val is a bit mask where each bit represents a slot.
>>+	 */
>>+	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
>>+		if (!(hp_cmd->intr_val & BIT(hp_slot->slot_number)))
>>+			continue;
>>+
>>+		if (hp_cmd->intr_type =3D=3D OCTEP_HP_INTR_ENA)
>>+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
>>+		else
>>+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
>>+	}
>>+}
>>+
>>+static void octep_hp_work_handler(struct work_struct *work)
>>+{
>>+	struct octep_hp_controller *hp_ctrl;
>>+	struct octep_hp_cmd *hp_cmd;
>>+	unsigned long flags;
>>+
>>+	hp_ctrl =3D container_of(work, struct octep_hp_controller, work);
>>+
>>+	/* Process all the hotplug commands */
>>+	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>>+	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
>>+		hp_cmd =3D list_first_entry(&hp_ctrl->hp_cmd_list,
>>+					  struct octep_hp_cmd, list);
>>+		list_del(&hp_cmd->list);
>>+		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>>+
>>+		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
>>+		kfree(hp_cmd);
>>+
>>+		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>>+	}
>>+	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>>+}
>>+
>>+static enum octep_hp_intr_type octep_hp_intr_type(struct
>>octep_hp_intr_info *intr,
>>+						  int irq)
>>+{
>>+	enum octep_hp_intr_type type;
>>+
>>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>>type++) {
>>+		if (intr[type].number =3D=3D irq)
>>+			return type;
>>+	}
>>+
>>+	return OCTEP_HP_INTR_INVALID;
>>+}
>>+
>>+static irqreturn_t octep_hp_intr_handler(int irq, void *data)
>>+{
>>+	struct octep_hp_controller *hp_ctrl =3D data;
>>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>>+	enum octep_hp_intr_type type;
>>+	struct octep_hp_cmd *hp_cmd;
>>+	u64 intr_val;
>>+
>>+	type =3D octep_hp_intr_type(hp_ctrl->intr, irq);
>>+	if (type =3D=3D OCTEP_HP_INTR_INVALID) {
>>+		dev_err(&pdev->dev, "Invalid interrupt %d\n", irq);
>>+		return IRQ_HANDLED;
>>+	}
>>+
>>+	/* Read and clear the interrupt */
>>+	intr_val =3D readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>>+	writeq(intr_val, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>>+
>>+	hp_cmd =3D kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
>>+	if (!hp_cmd)
>>+		return IRQ_HANDLED;
>>+
>>+	hp_cmd->intr_val =3D intr_val;
>>+	hp_cmd->intr_type =3D type;
>>+
>>+	/* Add the command to the list and schedule the work */
>>+	spin_lock(&hp_ctrl->hp_cmd_lock);
>>+	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
>>+	spin_unlock(&hp_ctrl->hp_cmd_lock);
>>+	schedule_work(&hp_ctrl->work);
>>+
>>+	return IRQ_HANDLED;
>>+}
>>+
>>+static void octep_hp_irq_cleanup(void *data)
>>+{
>>+	struct octep_hp_controller *hp_ctrl =3D data;
>>+
>>+	pci_free_irq_vectors(hp_ctrl->pdev);
>>+	flush_work(&hp_ctrl->work);
>>+}
>>+
>>+static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
>>+				enum octep_hp_intr_type type)
>>+{
>>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>>+	struct octep_hp_intr_info *intr;
>>+	int irq;
>>+
>>+	irq =3D pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
>>+	if (irq < 0)
>>+		return irq;
>>+
>>+	intr =3D &hp_ctrl->intr[type];
>>+	intr->number =3D irq;
>>+	intr->type =3D type;
>>+	snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
>>+
>>+	return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
>>+				IRQF_SHARED, intr->name, hp_ctrl);
>>+}
>>+
>>+static int octep_hp_controller_setup(struct pci_dev *pdev,
>>+				     struct octep_hp_controller *hp_ctrl)
>>+{
>>+	struct device *dev =3D &pdev->dev;
>>+	enum octep_hp_intr_type type;
>>+	int ret;
>>+
>>+	ret =3D pcim_enable_device(pdev);
>>+	if (ret)
>>+		return dev_err_probe(dev, ret, "Failed to enable PCI device\n");
>>+
>>+	hp_ctrl->base =3D pcim_iomap_region(pdev, 0, OCTEP_HP_DRV_NAME);
>>+	if (IS_ERR(hp_ctrl->base))
>>+		return dev_err_probe(dev, PTR_ERR(hp_ctrl->base),
>>+				     "Failed to map PCI device region\n");
>>+
>>+	pci_set_master(pdev);
>>+	pci_set_drvdata(pdev, hp_ctrl);
>>+
>>+	INIT_LIST_HEAD(&hp_ctrl->slot_list);
>>+	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
>>+	mutex_init(&hp_ctrl->slot_lock);
>>+	spin_lock_init(&hp_ctrl->hp_cmd_lock);
>>+	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
>>+	hp_ctrl->pdev =3D pdev;
>>+
>>+	ret =3D pci_alloc_irq_vectors(pdev, 1,
>>+
>>OCTEP_HP_INTR_VECTOR(OCTEP_HP_INTR_MAX),
>>+				    PCI_IRQ_MSIX);
>>+	if (ret < 0)
>>+		return dev_err_probe(dev, ret, "Failed to alloc MSI-X
>>vectors\n");
>>+
>>+	ret =3D devm_add_action(&pdev->dev, octep_hp_irq_cleanup, hp_ctrl);
>>+	if (ret)
>>+		return dev_err_probe(&pdev->dev, ret, "Failed to add IRQ
>>cleanup action\n");
>>+
>>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>>type++) {
>>+		ret =3D octep_hp_request_irq(hp_ctrl, type);
>>+		if (ret)
>>+			return dev_err_probe(dev, ret,
>>+					     "Failed to request IRQ for vector
>>%d\n",
>>+					     OCTEP_HP_INTR_VECTOR(type));
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+static int octep_hp_pci_probe(struct pci_dev *pdev,
>>+			      const struct pci_device_id *id)
>>+{
>>+	struct octep_hp_controller *hp_ctrl;
>>+	struct pci_dev *tmp_pdev =3D NULL;
>>+	struct octep_hp_slot *hp_slot;
>>+	u16 slot_number =3D 0;
>>+	int ret;
>>+
>>+	hp_ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
>>+	if (!hp_ctrl)
>>+		return -ENOMEM;
>>+
>>+	ret =3D octep_hp_controller_setup(pdev, hp_ctrl);
>>+	if (ret)
>>+		return ret;
>>+
>>+	/*
>>+	 * Register all hotplug slots. Hotplug controller is the first function
>>+	 * of the PCI device. The hotplug slots are the remaining functions of
>>+	 * the PCI device. They are removed from the bus and are added back
>>when
>>+	 * the hotplug event is triggered.
>>+	 */
>>+	for_each_pci_dev(tmp_pdev) {
>>+		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
>>+			continue;
>>+
>>+		hp_slot =3D octep_hp_register_slot(hp_ctrl, tmp_pdev,
>>slot_number);
>>+		if (IS_ERR(hp_slot))
>>+			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
>>+					     "Failed to register hotplug slot
>>%u\n",
>>+					     slot_number);
>>+
>>+		ret =3D devm_add_action(&pdev->dev, octep_hp_deregister_slot,
>>+				      hp_slot);
>>+		if (ret)
>>+			return dev_err_probe(&pdev->dev, ret,
>>+					     "Failed to add action for
>>deregistering slot %u\n",
>>+					     slot_number);
>>+		slot_number++;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
>>+static struct pci_device_id octep_hp_pci_map[] =3D {
>>+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
>>OCTEP_DEVID_HP_CONTROLLER) },
>>+	{ },
>>+};
>>+
>>+static struct pci_driver octep_hp =3D {
>>+	.name =3D OCTEP_HP_DRV_NAME,
>>+	.id_table =3D octep_hp_pci_map,
>>+	.probe =3D octep_hp_pci_probe,
>>+};
>>+
>>+module_pci_driver(octep_hp);
>>+
>>+MODULE_LICENSE("GPL");
>>+MODULE_AUTHOR("Marvell");
>>+MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
>>--
>>2.25.1
>

Thanks,
Shijith

