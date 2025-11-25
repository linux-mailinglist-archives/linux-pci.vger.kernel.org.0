Return-Path: <linux-pci+bounces-42041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C1C8553F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11D2D35071E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB054322C99;
	Tue, 25 Nov 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBah/NJV"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012026.outbound.protection.outlook.com [40.107.200.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C7A95E;
	Tue, 25 Nov 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079764; cv=fail; b=bbXI0J8tukCVox8Z4AQ6ND05eKh1Q5C4NJW9dg48TTctbskzK8VdszG+jQU27gVlortFZVyClaGT3LKmbnk7sMTzygfJnPA7SyzKnd6Vm78rZ8/QTRU4l4v8B89IlM3ROrCXp6SUi3hSaTkKOKv/lNlHkEVMnZEdviUKFhX84A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079764; c=relaxed/simple;
	bh=dFgtwzEl4XgVGkfCXScyC54TXjc9VNAReiSYpErerrU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=okCQEAu0xoTFtgTME4MoVi3JjtdywK1azwX4V+RX2oAoG9Oo9WrHudBjAGUc7XmrBQnF2ViiBaPkBI7su+rGB6B0J2c6IQDBhWekPcqUHvVIpoOwwIMtUEQloo4yAtTSDgtHnvmOi/7Y3HOlVAvNvfY6kNOtYQj0gfmG/af/0hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBah/NJV; arc=fail smtp.client-ip=40.107.200.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1QdMD6xxe7WCxcrAEf4q1ind6oyN2Rik+MC1i0JOw8aFvb0wM4pyyCrBupiiNhn0Hx9qLQwqMXm2YfRWUlv22wSRpXturUNfuHiaJU7XtLuDeZvg0+P+oRkl1K9LSwIgb4LShJycaHmOYJo2b9bwvNpugrQDgdR/zqALbfaLjXf3hNb9zhyu6uI2Jezj+t6l2iKEohobTsIXzP/3fLVshxZrngqIayHBjRKrdHKLknqGioO/xKoAxpkYV3Vhb4wd6pTFR/toFJv9aM/8KjVPzvGD9oTrRDycJd1e+cPbV506YeZXVf5edxQe6fb0J5J8civgY0w1yrc1qouwmS0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTU5tb+TChVEcN+NjIny6Vhcryr2vuvvAuQIFvzcjEs=;
 b=JYwMFDsno5m61SZLqY5GnSsSb+R74+oO8ORMCIwneojab0AuZAAy78dbhHbHcJVaUPjRmq9mAXj7e6JkemaNFpPLVq2mmRxAwkl+IYi7C3o/Lo1n8UpuD1VK1ZLalx8McEx7+k3bDOe7BCAH3nAyCi9DNaKme0y8FTTUT85vSrY3LznUVHtw+ooCJ6yEyxWa/lMcAqMTFYthdvg+FfL4hAwaE3o/eoiqivQzSxvBI4akVoyIXVcprUuL0bR6Y6CUfxbIKfHKw38VuP5MGDwWmSccq924EFZ6paoL+/Em9DCu3ed/y9e/IXu9zc9WmiNBvRy27quOSvE4weLO/MvtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTU5tb+TChVEcN+NjIny6Vhcryr2vuvvAuQIFvzcjEs=;
 b=ZBah/NJVKkGhkFjfodk75OThjIk5amHv1okAs9S0d559KO94cZLr3171J8mndo7+L+hLHR6BH3iQt9Mkml/sGDUBvPATOtKWOO0qlrhtF68IEAqEE6RKxFWZqXTFIew0kFZeNEuwUiDXOiG0ZPOs9rrIWwyzGJ23OCFTz3G87pDjxpCT6jBtC/JKqmdiLlGzk+p064YWX7RejSexybdFKck1CVn893DK9AZYsfFIOmk3NbYNL/qqYXd8vzGsiWjAv4aMJEbYd65GyR6x3tPfiAKoKXUATDzfbMiQalW08dd2jeeWAcVwm/7ILkD67gG7X6K+qNaJcDcTwEBWnegvYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 14:09:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 14:09:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 23:09:10 +0900
Message-Id: <DEHU2XNZ50HW.281CCT1CZ79CF@nvidia.com>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com>
In-Reply-To: <20251119112117.116979-4-zhiw@nvidia.com>
X-ClientProxiedBy: OS0P286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:16b::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d87d6c9-001e-48e3-3207-08de2c2c3763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVAxajdJWTRwUU51MVZ1dElKd1dUWmIyVU9xVGlUZHMyeHB4Q0pOYjRkL0dU?=
 =?utf-8?B?R0FyaTdLd29keFRJN1pubmxKVTlQRTVsTGFvM3ErQldsTFZyNXovbWw4K2Jx?=
 =?utf-8?B?T0cwNWVUUEdodlNzWlB5ZDZic3o4S0IwZllaci9wcXZwYXZCd2hwbnIxWWJz?=
 =?utf-8?B?VldRaTBybTZTQis3VmNyTlpEcCt6a0lleVJLYVNCY210N1owQjBXM3BNU3Zw?=
 =?utf-8?B?ZklTZ0NzcHRlZFE3dXVsRDZLU1lXUHlvc0xlQnlDRko3ZWx1MTlUbGVVRUNY?=
 =?utf-8?B?YXg5VUVYYVJHMWQvb0VOSmdoaXcrOTJEY2dUTkkzUndVcTFLM21PT1RwZmdK?=
 =?utf-8?B?S09BNFRmQXNVTkJRSjRBUVJxYSt2ZnJZTTFIdlA3bjV5d1NBTVk0RTFSOXoz?=
 =?utf-8?B?eEh6QzJkWDRpQ0ZWWTg5WkdWUFJOMXVJN2g1TzVPT1J3QWZwUHFzK0QxZnFj?=
 =?utf-8?B?U24zV2FLTTU5cXEvY3Q2VG1YZ2tVUnkvL0t6MWJqMDdZemxGb2o3RGt5c1RE?=
 =?utf-8?B?WElEc3ZPcDN1UWI0SzNCN21IdVlwdjhtZU9YRXZFUzIydm9rWDVOV1NYblhO?=
 =?utf-8?B?THJldnRNZjFHM05tcXU2elpwMHVIM0EwWFRSOElveVR6S1UyZFAzeDFncGZj?=
 =?utf-8?B?SWxmZE1lN3MxOW14bGdPYndOb1dPS1EzTCtrZVpmZngxWk9uQUtuUDY5RkFL?=
 =?utf-8?B?Y2YwVVZ6SGYvODlObFpLNWFvQ2R1NDQwbHJjRVNtOCtrbVpaejloMFBxSzFC?=
 =?utf-8?B?RkMydmNjZEVmT2hQeFBnZWgxenRobVRISUtsZjlkdCtwZG1nbzR4YkkvTVJ2?=
 =?utf-8?B?MnM5NFlodUg2VU1ENkpwdEFDYWNYVGhwVVBJNlQ0S1doQzJWbGlUMm5RSU5x?=
 =?utf-8?B?OFNZODQ4OS84NGZoWXVzbkc1cnJNRlVxU1UxaXlGb3l6S3ZSeTdpejkwdDJl?=
 =?utf-8?B?Um5JUHF0eDRWMGZYNlZrVElGTm9ZWGFYR3pkUEc1Q1lMYnA3TTVjNkIva3dn?=
 =?utf-8?B?SmY3eDdUY0pBOGdUMzBMVm1tSlNPeFN1NUJQdGZUNXY1L1BxVXcwWDdBcmtH?=
 =?utf-8?B?SGJiV3FITjhXS3dzM280ZDl0M1FCaEIxMDRTdnNPWGpGUnRYSUxlRkgweHZR?=
 =?utf-8?B?Tjd6VzYwTjFreGNwRGFWbzdXcEJUU3VnQ1pqVjlKZnVCUTkrN0xJOGs5c1RP?=
 =?utf-8?B?ckExMTdmMXZ4TGdFaWhEQ0Q4RzA3OUlYR1dYR1haOVFVcS9JeU1zWUNabWEx?=
 =?utf-8?B?Q1l3RE82emE2UXBRWkpKTzhEZEl0REVJRnlDTkxBNXFqdjRSVGw2Nk8vbllw?=
 =?utf-8?B?cEVBa09jK2txc1NqU3QydHNWSEFjUXRWSG0wODhBUHFCR2dmZUJ4aGhVZzVq?=
 =?utf-8?B?Nm04Z21KdXQ0dDE1bTh6MW96dEd5bmp2UXZKL0NUYnJkVkoxSVFOOGR2ZVov?=
 =?utf-8?B?VTRmUlJnSWNsakp3WjNZbXh6eU8renU5aWQ5d1VOak9xT0xiSUMrTVZ0ZzEv?=
 =?utf-8?B?MlRLR3k0L29yQjdqcU5LNVcwT1ROZUZsWW9VUFQyQmVuVVdtMEtaaXhjQVpx?=
 =?utf-8?B?TEhLQ29tcktqZ1RBUEhaQWNEVjBMUnZ0cUtZclR5S2h1U2ZjYVE5bEpINGFh?=
 =?utf-8?B?WWIwWXltYkFjcGE0WWt2RVZEWFBHWVlTcWZtV1VkZU9DalM1NytBTHdod1hT?=
 =?utf-8?B?ZTAvMW0ySW1NdHIwM0QyVWhMaVlXTU9ycHpueTFzaTNvYXVtaS9KcldvM1dV?=
 =?utf-8?B?OWxOcTVseEp4Y25hZkRmK29HRHhsWm9ITm5pbjV2eWpBWE41aDN1TGZCRWp2?=
 =?utf-8?B?QUh4RVFwQ3NDRkZCOGxiUWdBY20xQlgwZFdrWW9QRzAxREM3VHJuU3BQV1hP?=
 =?utf-8?B?VzZLU01uaC9zRUEwaXJ1NzBKVVl6TG1ldGlkaDZmM1BYeVBXMW42bTJCRVFS?=
 =?utf-8?Q?+7a7A684iLay6TZocFJmr10dq75N/ePi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJqcXlGa3hwSFowUEpvS1o4OVozbHZJdVpDMU5LQzMrSE5DTnlJbVp6cmVs?=
 =?utf-8?B?T21rOWVpK2lrWDlqaTFiKzVnOXhjZCt4ZXI4MkczSEIrZ2MreSt3YXozTGxw?=
 =?utf-8?B?S21ReDVtU094M2tnUitvSVRTazlqamoweG1kbm5hR1hRdzRCdTVWa2xpczZK?=
 =?utf-8?B?ZEhQRE5Sa3BJTCt2L1BzR1BOTjdoSnVrK29RWlM3ekJKUDhEVVd0dERsOTFi?=
 =?utf-8?B?MkxUZERJQ1pHcnhSMHE4TUJ0bFViWElTZlU3aDluc2hqV01oMURvSnRqQnlB?=
 =?utf-8?B?WjFRalR6V3FUa1JiK0hJWFVLcXlEMUgyUGlsS3BpK2ZjZ2c0K3NqNzNheDFm?=
 =?utf-8?B?NlFOM2J3amNCQytTZ0MxSVBnQzcwQ0FSVGxZSFdpWnBkeWhoR1dkOVhWSXAx?=
 =?utf-8?B?bUJIbDFYanVpRDJ1UThRQ25Hdk5BOFkrVFFLSVM2Q1FFRFFQNzd1c3E0SHZP?=
 =?utf-8?B?SnlqYkxEa3p5Yy9aYzhhNDVocEJ0am1GT0xNUDQ1NDlvS1N5TmJEZjJ3UVNa?=
 =?utf-8?B?ZnF6b3BuWEUyTnJOTi9KbW84ZGpKa1BzbmYxUDUvSmNqS09aRnBlLzJwd002?=
 =?utf-8?B?S1V3WUtsTW1odXZqRmFyNUlpU2VaejE1WEpwM2JVZXpRZVhVRktpRlVITU1w?=
 =?utf-8?B?VW9zT0VtSFhmRmdCeGJnRDFMWnVWL2QvN0V4dmNnNmVCOXF0UEJaSmtkMDEw?=
 =?utf-8?B?SXBmMVlHK0hjSlo2aGxXbEZDR1RlS3laRjdJSWJOK2RLVHJ1OGV5bjR4OFhi?=
 =?utf-8?B?WDdUY3BsVGVuTm5NOG9lUlBycVFWT1psNjhQcEczWnI3VG1MRDBFZTYvKzhl?=
 =?utf-8?B?bDVMdGNLWFFFWEZmV1MyY1RYTCtqZ05XeUN6bm1VTFF0UTcrSGtXbStKOUZu?=
 =?utf-8?B?ZC9mNnZ4OEVaaGZ2ZC82Lzg4VjZxZWhEWHZ0WFVWaTJnV0JDdGdUdUNNaGkz?=
 =?utf-8?B?c04vc3dGMUprT2k5ZnR5UHp0MGpYbm5SdlhxOVlQbGdUVG1MbzRieDRJUVdQ?=
 =?utf-8?B?Ky9VUS9JMTJCWVhSTkwveENqSUpja3RQRlJkeXd3eXhCNHl2L3hZUlFZSyty?=
 =?utf-8?B?REh0MkNOaEZZY21QeTV6am01N3l4WkdXTzhtdjZRWXVxU0xDVjZ0MzRrcGxD?=
 =?utf-8?B?TktucEozUDFQdGlFczZ2Wklac2hGUVl1U0hORGx5MCtmRXc5M1l3ZVNoWWt1?=
 =?utf-8?B?R1BsSzdJN3JscEhCS1FnK0lHeHMxQlROeFZHeVBIZHQ1YkJXOHVnQndmQk9K?=
 =?utf-8?B?cTFTckE4Rk0rNjBFVHRtSC8wVmhWcFVCWWxEYW95NlVsb2MzNGFHSDJvZk1F?=
 =?utf-8?B?cHlrUC8xbittdkNYdWw4Qm9SWG5LZDEwVFVPMHMvUzE3Z1BXSVFWcWhrQWFY?=
 =?utf-8?B?NkN3cEo2VVhsdi84T292SmVsY1ZPMEdEcUxoeUZFYVI2WGlCQzJnSC9yYStv?=
 =?utf-8?B?Q3M4M2tUc25YNHNSM1REZVpFOGhIREs1ckxGYTlTTG84WEhTUVdockdSd0hH?=
 =?utf-8?B?K1FMUTBoUkRrMzgrRmw4QnBnNEVhZXJDaGtVZ3V1TWY4V2R3cnJWWjVGQnU0?=
 =?utf-8?B?c3c4cDJqMTVCclFNTDJaYkVKQmNBaUJiVDBPLzR4UEtIUGdGaDhjbWNjTUhW?=
 =?utf-8?B?T3htKytUbEllR25wNkh3WjhLSVhaTkFLbUNYMmJsRHJ1YnIyRVp3aThGS3lG?=
 =?utf-8?B?eTVranFnUmRTUUpaYStyMUJsanh1UUVNMXMyUlRNYS8wRWQrU1E5eWFidGFj?=
 =?utf-8?B?NG1OdGFXT2pKY08xUmliVFpsSTZHRVNibUl2Sjh5OEdTcVJ3N25MZ0g3Sjgy?=
 =?utf-8?B?T2tiNVUzTXZ6WG8zQzVkelNheVBpSHNBYytCK0ZwOGtxbjBRTC83WVQrclRT?=
 =?utf-8?B?U1hvUkVGQ1NvdnFDWHJGdVJnVm9zNDQ5WEpQd0ZFa2hnR0JzYkZla0V5UUlT?=
 =?utf-8?B?R0h0R0w4UFRUN1FBM1M1Q1ZJdjZDUStpOGlhUUFQcUV2c25OUXhuTXVOeWg1?=
 =?utf-8?B?b2RtWkt1bWdvQWZ5dWx2Y25OQXRQSTE0NWNyRmt1MTNSUUIzTmt3T3RhMUEx?=
 =?utf-8?B?L01GMGtmZEQ4dTNBYkNMU0tPMUdjZWhoQU0xS2hkSExqYTdyMHFOai91VTBk?=
 =?utf-8?B?Tm9JRlE3M3Y3b1IraDFFc2JiaHVpTzNBK05PMHRnK211Z2I4aXB2QkpOZjBJ?=
 =?utf-8?Q?7PxXzq2fvexCWdStQFDONcMSMCthCP3ioKZFLOg9mIP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d87d6c9-001e-48e3-3207-08de2c2c3763
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:09:15.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDLwuBRARBjqkuBcZTeONZTEygjcrK7SVDJxCT9gY+YMfiGn4cxuRimLpz2eEuJZrUqjUpIuSVy0SZhTNjk4+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529

On Wed Nov 19, 2025 at 8:21 PM JST, Zhi Wang wrote:
<snip>
> -impl<const SIZE: usize> Io<SIZE> {
> -    /// Converts an `IoRaw` into an `Io` instance, providing the accesso=
rs to the MMIO mapping.
> -    ///
> -    /// # Safety
> -    ///
> -    /// Callers must ensure that `addr` is the start of a valid I/O mapp=
ed memory region of size
> -    /// `maxsize`.
> -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
> -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> -        unsafe { &*core::ptr::from_ref(raw).cast() }
> +/// Checks whether an access of type `U` at the given `offset`
> +/// is valid within this region.
> +#[inline]
> +const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +    let type_size =3D core::mem::size_of::<U>();
> +    if let Some(end) =3D offset.checked_add(type_size) {
> +        end <=3D size && offset % type_size =3D=3D 0
> +    } else {
> +        false
>      }
> +}
> +
> +/// Represents a region of I/O space of a fixed size.
> +///
> +/// Provides common helpers for offset validation and address
> +/// calculation on top of a base address and maximum size.
> +///
> +pub trait Io {
> +    /// Minimum usable size of this region.
> +    const MIN_SIZE: usize;

This associated constant should probably be part of `IoInfallible` -
otherwise what value should it take if some type only implement
`IoFallible`?

> =20
>      /// Returns the base address of this mapping.
> -    #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.0.addr()
> -    }
> +    fn addr(&self) -> usize;
> =20
>      /// Returns the maximum size of this mapping.
> -    #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.0.maxsize()
> -    }
> -
> -    #[inline]
> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -        let type_size =3D core::mem::size_of::<U>();
> -        if let Some(end) =3D offset.checked_add(type_size) {
> -            end <=3D size && offset % type_size =3D=3D 0
> -        } else {
> -            false
> -        }
> -    }
> +    fn maxsize(&self) -> usize;
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing runtime bound checks.
>      #[inline]
>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
> +        if !offset_valid::<U>(offset, self.maxsize()) {
>              return Err(EINVAL);
>          }

Similarly I cannot find any context where `maxsize` and `io_addr` are
used outside of `IoFallible`, hinting that these should be part of this
trait.

> =20
> @@ -239,50 +240,190 @@ fn io_addr<U>(&self, offset: usize) -> Result<usiz=
e> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
> =20
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
>      #[inline]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> =20
>          self.addr() + offset
>      }

... and `io_addr_assert` is only used from `IoFallible`.

So if my gut feeling is correct, we can disband `Io` entirely and only
rely on `IoFallible` and `IoInfallible`, which is exactly what Alice
said in her review. It makes sense to me as well because as she
mentioned, users need to specify one or the other already if they want
to call I/O methods - so why keep part of their non-shared functionality
in another trait.

This design would also reflect the fact that they perform the same
checks, except one does them at compile-time and the other at runtime.

Another point that Alice mentioned is that if you can do the check at
compile-time, you should be able to do it at runtime as well, and some
(most) non-bus specific APIs will probably only expect an `IoFallible`.
For these cases, rather than imposing a hierarchy on the traits, I'd
suggest a e.g. `IoFallibleAdapter` that wraps a reference to a
`IoInfallible` and exposes the fallible API.

<snip>
> +impl<const SIZE: usize> Io for Mmio<SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }

Nit: when implementing a trait, you don't need to repeat the doccomment
of its methods - LSP will pick them from the source.


