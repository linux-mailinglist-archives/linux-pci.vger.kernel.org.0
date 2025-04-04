Return-Path: <linux-pci+bounces-25277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC293A7B80F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207B17A5743
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8118BC2F;
	Fri,  4 Apr 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dx+rLo3W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9E2E62B6;
	Fri,  4 Apr 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743750216; cv=fail; b=UeSU8GUzn3ztyvxI0kzqHUaD1jCcC3pqRhHZMr4pacbiuX/xfTpnluDrFg0CRtk6KwMHvcZ1GdHWto7kvO694AGpTuPKF3pNfNMfEqZZHzjZMuhqfFmJIK6xjTp60j7K2/25GEYkW3zReVUeUfLG8f3lNNBJuav6ZB0I1eRElKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743750216; c=relaxed/simple;
	bh=8QEhWnFD+UEqcCJShJM1V8/K3lbBWzUTjKVFtl3UjYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AtNsWpO/03MmLpEbckFgtQQFEMKKYRfTx6a6AoWe6y7xJMFOIr3J8rdaVh1MYqmBwLTYG/+3r41RyKahzeNXuRiedhDyEhv0Dl7CNou5qVroY6agNbKBzpJ7V0v7KBgK9mR5MdkX1sstb1gSGeNPEtbr+hfYsHJTy1q/++nMU9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dx+rLo3W; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+ynAkir2yKFhl+Rw39R386K5AB7hntqxt5oRw79Nq38VYWtWbLVmfKvDDczG48RVF0sXBYCkkzeyfE7dQB5e+mrV8Ojb02B525tGSGdg45lMxYb5mdRj9miBLxgurzT3ccrnhKEM2d/8TQ5ElEA3jIWi5wcLVfaRU9iSmanAnLOC8xNsW7DTyss3LA7+pFi/w6d4NzJn+irufLiUPtI1Tfy1pJDoOgebbi267nPCXIQzPOlw8IXCk2lIw703sPcav2aJJ51oCg30M6YIEviLFIXduaU5Fp3Fw962EIw7+LU/byzOc3hEpetmg/XPGTBPBYT/o5rCxhp5L92eLRp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YejZGK+R5bVVsZpBmadIbB64qEnn8Y+pDOrR4NhBdSo=;
 b=X5/Ee3UdV7WJxM+gtFfJh2AJwLSfPuIuM4NGfeTRsP4AMiILAF9YwWw96Bb8ViaCWx0CqMca6P1uNT/QO+DHWLCLYrQAI/JEaEw+IAvobb16Cip3y/ReGkBp4W72SqBJ4cnb7Okb1KyhD4u1UDm63Ln3qI6g+7WK4koG95oxzXgZA8uLmy7f0c77luhS8yhx7vFmP/CC1k9gQtrrYl4ANxjIULdf2XnTb7LqXe/7nBVIE8ngVFendR+ua6C3gM/6xSYpdUfwTmD17FAsdH6XhLdHHoFoKg2lKngum9tVNJCKsFWTrPVJGGDwot8DGguLMnvPAfGS97TqwH9ghBt89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YejZGK+R5bVVsZpBmadIbB64qEnn8Y+pDOrR4NhBdSo=;
 b=dx+rLo3We9NnU0lj8TgfyX9tvvVFRz5Pyc8AVOyfp58zZJzaqAIWHokEsmMHnR4M8yu3vFZYA3ljyKrFzUk0fofK7QQIBMbqfepAg3eBcXW8WCcZYspYpFS5n8mGPXqZqeYL+SJYFsnCv+XUZCPwjYLAo3BtgAPi+fCD8W+Tivo=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 4 Apr
 2025 07:03:32 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 07:03:31 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Topic: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Index: AQHbnfbpjrXLjxd/8EKiaV/Ed5MZLrOHPpIAgAAL/ICAC9f18A==
Date: Fri, 4 Apr 2025 07:03:31 +0000
Message-ID:
 <DM4PR12MB61587CD51275A8E63A9B704ECDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
 <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
 <f65db82b-fedb-43d8-9d61-53e1bacda3ba@kernel.org>
In-Reply-To: <f65db82b-fedb-43d8-9d61-53e1bacda3ba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=db466d65-5808-41e5-9a20-2ff058981ef2;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-04T07:00:17Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|MW5PR12MB5624:EE_
x-ms-office365-filtering-correlation-id: 5d253827-8be8-42a4-3227-08dd7346cf39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QMc+j63UQYhItIBC0+h5KF8Bvqrbv7Ucoj4pnAUXCmdFfbJziJjPMTk7heQG?=
 =?us-ascii?Q?tCqCuo8ayLgBtTF/HFzk26bBdeX0Y/NBQ4pwp9/tBCyIlQGzVE3t3puLgyro?=
 =?us-ascii?Q?EvIC5KUffI8NPZVazpHFaysR/DKgUHt4LcwIzmg9+lkgHveRWALDhoicUT8x?=
 =?us-ascii?Q?3yjty74Jv9J5ggEytuEq4IUbI6yP4Tk/CeoTJpQkRdfM84Ccj94TNKzcKElI?=
 =?us-ascii?Q?68NdMrdTEOR0TKSE2Uospf/ioh4ySjUIJTH5XTAfgWWnCDK1tzlvVv6Bsdjs?=
 =?us-ascii?Q?1aa3x90jXzyU09VLc+dViKsX+TXj2vPsE8ibtLycGfLgjUPVHekVS/jFRtBa?=
 =?us-ascii?Q?xdsET/revNDJ+k2S+N7xNPUHYmGRncO6pKs943kVZmKI93cjl7VMdt0l9sI/?=
 =?us-ascii?Q?IIaIdMFRIZkeZV0GhmHP2HCPn9uyvwbiwf2WwwIp/S+gU5C7vjHaUuYYwqdD?=
 =?us-ascii?Q?hHwQHyEJgc43RmUttGibibTpDG3oM8tjkrfCDRJV0ZC2C9AjMmVIVE7KTF9o?=
 =?us-ascii?Q?J6I/cMZJyChc7GArn1N5m9TVtoTc3v0s+mzFqGXyLauqU7Xb/RmGifX4Lss8?=
 =?us-ascii?Q?lylxX8/MzvIbLc68k6znVS4OobHNKlPgBBr6RE0l3anDP3gpdpZHuDsUhHYm?=
 =?us-ascii?Q?aKVFDR0YPbnnGcu3Vj43JZ/FbHK8VMEWdJ++DSywQ7AYP6Xcq9CRGJEOXQUu?=
 =?us-ascii?Q?o3BVj9jh1E920ZZfm/Hv80zXw/or9fqcbf/JeXtfiU4vp6yIwExdVz5ZB6TH?=
 =?us-ascii?Q?QHz08ZLjXpDZpHce/STMgPMeV4a+Q37vgKy3xiIrUr9dMDAuL5/rjzVODIP9?=
 =?us-ascii?Q?WCcynOf+Hk3vGESNa8UGnEHyimjkJ8X+o5nC8ZDg0WB0tAKt5Vxg23RCp6oF?=
 =?us-ascii?Q?YyoxR0Puue0ylTtZ7283ZCgWHTv3PydfjDqbx4b260KzQkugkF/fHYptSqKn?=
 =?us-ascii?Q?c7IegpnIEAzG07wlTtlYDfBhVasijblkUx1ud4GgkWa24dGzC0LTW5cVIBK9?=
 =?us-ascii?Q?1WBC8hTDFfL9mdLVM/WyJ8LgWBTz6yZHEClSDuKpMqsnyDAk1Kqe/JLzLfsD?=
 =?us-ascii?Q?7EqCKNsh7yuPq9+I2yxcnE6BiqHq3Y9iT/I0Hf77atWBwsYsfQkKk8veW7lM?=
 =?us-ascii?Q?QQUHt5pHz2l2ZSRKX9zgt2GM1aOA/uFCd/FpYVG1PIXGCLJCUkWSfg+Me/E0?=
 =?us-ascii?Q?/IqNOl3XAQIhWah2NwmF56O0Jhsaid96iTg8dFxzScGLmoGsUJgzS63ejWEL?=
 =?us-ascii?Q?hqoEuUTngCz7V/O8229x9jFxUicjhRbythQi1OYhDoEe17ia8WlRC4ESOzC/?=
 =?us-ascii?Q?jblhrxlBytYnyUzGXiG8jZ//vnLnaubRUvEdlkWynu4L5kQNtWOfOqLAzcKp?=
 =?us-ascii?Q?ktutvOrCSoDFwDk5jPE3L/oUnbBO+mBRlZY99Gl+uGZqSkkKbhSV7mfzFfAj?=
 =?us-ascii?Q?kE0HYnoF8URmSO4U8aSyfRAat/sB4nSE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dzbnsrlIErAjIx0UAUYhpZpNxGIYCfAp3EDRPi00gEINkrf/ECtqochqSAM5?=
 =?us-ascii?Q?0kXycJ8J+Rzg48G115FLpt+jQ9JDOjhbxw/vS9tcKgwNvFVdBVoEtuoUMuiA?=
 =?us-ascii?Q?syeKhwp+/AlBaO1+K8yvBog/FohAoxaBpPOcEhDAR+5dksRWFmG8ev6L3Uy+?=
 =?us-ascii?Q?ZGZve2YQZx2p23A2h4BBZJApHMoX1sYNfLOjKCOq+qe/gZ8ZNvNF6d+GhKSX?=
 =?us-ascii?Q?UmyOFJK9MAemdKDKz9x7GLk0/K4xy16c/j5PAv+BuAYY9BcTOZl3cgUjHWNh?=
 =?us-ascii?Q?sBmrH/PK/Di7HibhXJrtWIgOLzKLJ5rC0Bn9lrYazUq3F33NJRp2WjD6zYDp?=
 =?us-ascii?Q?UYmdXt70uEqcUDvD8oCT2Zgp6xtnqymaUwQHZOgp3XOsQvfh6NfCAafMncBR?=
 =?us-ascii?Q?XEtbqo7PlTkRuR566IAb5va2LSQYqQNubjnwMGRQETvZF+yyBCkyRtg98v9q?=
 =?us-ascii?Q?0fDZJdK/SfFLvRAifPRW3lTSyDa7CdhCFbOE3mv9Umjx1DudoulduK3ZYHwN?=
 =?us-ascii?Q?eWSmmpALqscvRrbHm1SNSdBJUCcStGzae5ozx/x/86DtZJA+Leenu7uJNiQR?=
 =?us-ascii?Q?jl+m1A3ZUvHmvMmVehyW2j8Qs8/tyf48jtiKG6jfz472tBSJe7ylP/mtZ3Di?=
 =?us-ascii?Q?MZw0LI2FJWykWP/mEn/WFKBKHxHKo7AThnrdFRiz3zzrzY2E+6BAgPE66Rqp?=
 =?us-ascii?Q?g0HAnVjQ894xlcW5Pj898jqayr09Zr7dyWM0kKf8O+MGRLE91wj34gYZ7fHz?=
 =?us-ascii?Q?KRBmnUaL7zbbIbcYNGE47xZ3MiZ/2yz0JX+w/a+cI3Yu4pDQ3TO9LvyrV1EZ?=
 =?us-ascii?Q?/ULPwVayZNIngePb8pCFhzPYagRpOuaxPgLGfeb5As4MXJWR5Eyj3s/6i5oA?=
 =?us-ascii?Q?xWx5njnT7Ir7YQ6Z6LN4xWXHB7O8m6ggsfmDX6YjYRtw1ObRzUYN3MdioBrD?=
 =?us-ascii?Q?k+EuMd64IBWc4WZVx6ltMcsB5rf+EQrA30V6ZonJ67pQVMOYmUa0ehzExd2H?=
 =?us-ascii?Q?HPRIyKnjPZz3ID9tJFHFrVHNu9osplEI5N+RoWSTGes+ai5ejRE+58MWoBS2?=
 =?us-ascii?Q?ZtBBEI1+wjwHeA85wUoGKl2uAly7EDZaXfxtHCXX6YUvMOW099wdTkWyr6jb?=
 =?us-ascii?Q?yIbbtvkxsxFr5X+t3uP8Ws6Cn4fuSl9ZfXEnWeA2nbMXCRAcfmywovAQXJGE?=
 =?us-ascii?Q?mdR8rsYywEXH0ymBgtGLHuT4KVyZJ5CS2QGvYVoo6CQ7VxzIPi/R83xHM9jt?=
 =?us-ascii?Q?RtWo3i4xGpJhbStFkehSbWHU0gt7fxxM3s5J+uz8WMEjoggAEC4/pyZC5v/X?=
 =?us-ascii?Q?UCQOh7sG6acm4UCCxuZooN9B4imaIMc6QNMMFg8eVM2R6HwGQy7ACt+MaSXQ?=
 =?us-ascii?Q?3Cg6uGSlSE7f4L4MXcyOtZQQm0SJJfaPSPwn8dqcp7KgAVw7sHYwJ0XmGvM9?=
 =?us-ascii?Q?cPs1qJHaDJeNbMd1avmlTWN6kaw1DOl+OvtA1uvI2KOUf7QwYkqmaJhm0El4?=
 =?us-ascii?Q?+5vGuF1TNLpVwGswVsuJPwK0fRTRO9SZq3/kEGKmNq6l3tQLDimU23FyuVow?=
 =?us-ascii?Q?0zB0rgDHTQKICBiYMPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d253827-8be8-42a4-3227-08dd7346cf39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 07:03:31.7570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgRUKevripZeY3gJfEM4Hvraz3SlAj4C9UVwuy/E31JHa8uhPyI+4Qott9IA9pq+FO4v4yT/R0f1vteMZAcO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Krzysztof,

Thank you for reviewing.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, March 27, 2025 11:38 PM
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Musham, Sai
> Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; robh@kernel=
.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org;
> Simek, Michal <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERS=
T#
> signal
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On 27/03/2025 18:25, Manivannan Sadhasivam wrote:
> >>  /**
> >> @@ -551,6 +600,27 @@ static int xilinx_cpm_pcie_parse_dt(struct
> xilinx_cpm_pcie *port,
> >>              port->reg_base =3D port->cfg->win;
> >>      }
> >>
> >> +    port->crx_base =3D devm_platform_ioremap_resource_byname(pdev,
> >> +                                                           "cpm_crx")=
;
> >> +    if (IS_ERR(port->crx_base)) {
> >> +            if (PTR_ERR(port->crx_base) =3D=3D -EINVAL)
> >> +                    port->crx_base =3D NULL;
> >> +            else
> >> +                    return PTR_ERR(port->crx_base);
> >> +    }
> >> +
> >> +    if (port->variant->version =3D=3D CPM5NC_HOST) {
> >> +            port->cpm5nc_attr_base =3D
> >> +                    devm_platform_ioremap_resource_byname(pdev,
> >> +
> >> + "cpm5nc_attr");
> >
> > Where is this resource defined in the binding?
> >
>
> So this is v6 and still not tested.
>
> Where is the DTS using this binding and driver, so we can verify that AMD=
 is not
> sending us such totally bogus, downstream code?
>

This patch is tested for mentioned CPM versions, I apologize that
I missed adding the cpm5nc_attr resource in DT binding. I will not
repeat this again. I will add the resource in the next patch.
Thanks for your understanding.

> Best regards,
> Krzysztof

