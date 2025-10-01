Return-Path: <linux-pci+bounces-37319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F029BAEF5B
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 03:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601E217FBF6
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CAC23D287;
	Wed,  1 Oct 2025 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BXcBTdSq"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D71E5B88;
	Wed,  1 Oct 2025 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759282763; cv=fail; b=qiboa67dv4fkNj1oFkS2CIuRhtWjivvQrqTlg8H/UGqTMgqct0ExprPuXahZ2Mr3RWt8LiPBSaqUi0ZdL5Z9WjN0/X+cDUx5nyrTV09eG9XjoAxUsFVSei+nEMmIeVVOIoS1EdMFPNrTTAooqbnFqRYw9C8P9ScyE04MviZoPJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759282763; c=relaxed/simple;
	bh=N73DeMnQGgBTQmlURQwffLc4f4N9mIikgMs2shpu+nM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Niour7URsguj6ifzVMfPcHXWY4pPt+Wwcz4eANe0Q3QWrbbojnkEdNoCptz4ZQRQBG/o84WIG19ovk3g7zQpO+4LWzi2N3/FF+pSF/oT0Y7KHrvra6JjN+vO8EzhTfkS+oU0WslNBYrZ04VDshaTehPc1xHtR2g9AZnI+BY5GB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BXcBTdSq; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcEH3YYBOTFAUkcV66bVRBr7oCyFAudHmH9v187USVIZfVenkfQaPahCjWvAtOYxwaVLBu1oZ9xe0FkzpaGah/BdIIpH4691ypNQduTWkRSv/xflfM39aCleGaViTHU00ytw/tlo5EubY/g0WE3qRJJDcaaJyVOyj0CONm+9TgzXmlyAcY/FtKnvFqJkeSRa4LEhncFrxU08eJJ3n7NNeLGx1D2sthv/t13cBkchQLzb7N0n4wxts9k+byNTG+BLMs5RRSKPzGjGJm8BgtuRU6hz+gsqlXefRhuOtfQS3r9R1dvhGeEyDUOd1/8qMZofPh3QjuiarcC8R9FrgYfzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N73DeMnQGgBTQmlURQwffLc4f4N9mIikgMs2shpu+nM=;
 b=qB6ih+31k5f1uMBMYeWeA20iCmAsmc2TjQ7WM4rUSlnC+w03X9546O0hBBWx28qORdjGMhsg4yttlVYlh/bq+Zyffb8SWFauaiQPOginxKuHueWVmAUXUYdiEKKNjsNHbEhxM5k8gFXCU79s+0jVSa3qILnIP55EWOPkBc8MzoOxRQ1B0Nq73CAR10IPNq3JikVbJKIR7HGulSyCsissoD8LS850EiDo8rOkbLrja4W0mmsE3mw92ffnI4KvMh4qwVb1zcLcpKe20A0yojla6rmSX1vzioaxVV3D2x1q/CqYvrjZyK3cPrgOGumXrB+XV+Zss7R4Qv/mdZUUqKphCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N73DeMnQGgBTQmlURQwffLc4f4N9mIikgMs2shpu+nM=;
 b=BXcBTdSqMRqCIiNYUzBONcud/JFfreE+V1IZs3lo+WtlHk8+nNF4Ibqrfufe1M1rw8uidNFZjy6Rf7pLYpuyIAFfaP76klDfRs/I4OIFe+yqrnkWmIED3bxxsMa4nA5MYHJ/M8grYSjrR7Ml0atDR3bGT1P6kLlLObcjteS1nT+FY+nAmqc4RKZsDXrvIPGxJ75nXcDAx7vVtRaUMlwjtpT8HTaJlDOlzwdmzkTkccxDW6UP8y64VM2EX+Li3uOEN9VjvbfRVELaU5MSnqXC0e2mvK68K3ceVd8jbR8L74IRla4qU5ujuwtTGAdW1M1Wv0bCmH60LppqftRgbQ88ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 01:39:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 01:39:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Oct 2025 10:39:14 +0900
Message-Id: <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
In-Reply-To: <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d29fac-85e5-4526-3864-08de008b5586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TllBalBxRDFOc2NHanUvdTdxRXpZajM2blBNVXFDeEtHTW1kL3dBMEpISm1m?=
 =?utf-8?B?QXE4dWdVbkJpQWVWNFFDdldINjM4blVNTlFaaVFtaVFsbU5ySXRlandBNjlp?=
 =?utf-8?B?Ry9ta0RyRnMzWjExaDdnbkxIc3IxS21MVFZ0SW5yOURKM3I3L0ttdEFRR1dC?=
 =?utf-8?B?VW43c244QStsU2J1WXJDd0xaVFIwcnh0V1ZKZm00SjArclRFVGxRTFd5Uml3?=
 =?utf-8?B?Y3ZOdkhRczBOSFdOVkdRUlR2bGt0ODJGUWk3bUx5c3RBNGttbERieTRCV2NG?=
 =?utf-8?B?Nllqdkx3K1JySk1vYW9hSXlFaTdocUNjRjJaNmdCUFlPUU5ScEMxTUhiVzRX?=
 =?utf-8?B?TXU1VkpYVkF0aTN2b2xUZW4yNmFsMkpKU3FjTFZxUEs0aytScThPb2pLenRh?=
 =?utf-8?B?OG5uL0lURHdBMFZCRDVHS0pUaUgyTDRGOGxMRDdWNElCYXkvc2lRSFFWRWFH?=
 =?utf-8?B?RmpTS3RuZEdXcWVDRjU5OEV2MTJETWxZYWIzRnFxTmxBaE1LVXZnaVNkRUVl?=
 =?utf-8?B?eVplOXZLNGNUWWxkaVlMcG1EeDFhMU9uVStIckU4R3lvT1FpcGxQYTFIa1BI?=
 =?utf-8?B?b0tjcVNNZ1VDWHNhSVRydVpZUDEwQzZocFhkUzExZVhRaVBYclVDMytobnNT?=
 =?utf-8?B?cmlFNFpmSzJhR2xVSVRNSFpOdHFtRU82NlhGNVZsZGZjQVVROENIejlpeVBN?=
 =?utf-8?B?RG9qWFpGMEFrZ25qekhNWFNQS2JSU1gxenFXWlV1YlRHN2k5NmFlY3BWbjBt?=
 =?utf-8?B?MjhWcVRvdU1jVmVHR0NyRlplanVqdlVLK1MweXN1SmRDNmZpbTFvTXIvcEE2?=
 =?utf-8?B?T2ZLOUJYSUdzdnlpc0tEQndYbGdXQ0drOXUwRUZGS21HMGh5d1hZcGlGMDgz?=
 =?utf-8?B?QXBvRXpIQWJYS3NuRnB0YnJ1Sy9UZnNvZnltbzZoblZaR2NJUUpWRnV3VFZn?=
 =?utf-8?B?cU9CWDU0ekliOWFGZ0ZUNjNzWWlvRUJ0Tzlvc2k3emp6aDM1eHljek8wcWVy?=
 =?utf-8?B?dHJUblZJSzhZVm9xV1I3eXQyVFVJUEc3OUhPWm0xc2lqbVZwNHJRVEQrcDZj?=
 =?utf-8?B?RkVZa3M5bnJwN1NYQWs5NkVZVUZDQUtxOXVOSURwOTk4Wkc5RHVUcG9JOEpT?=
 =?utf-8?B?OHM5M0ZxL2dnRHNzWjFpT3REWEludWd1Tk0zcGRKZUF6ME1ZSFpYQnhxQ3Vo?=
 =?utf-8?B?U0l0YU9yY3VvUVg5OGVLT2srRHJPSFZFUHNhN3hRb1hnYTVYdk9mOFNhZTFy?=
 =?utf-8?B?OXZNVDVTWW1xSzlSaWNXazF3LzBRYW1OYXM3aExleXBvSzVSL2F1Z3J5R1Mw?=
 =?utf-8?B?RDZCZmg3VytqWVFQZTNaV2hycW5kSE1mQUJ1OThSbXc2Y1JKWlZIbFBucFhy?=
 =?utf-8?B?SjROWE9XRWUzSFFNU2JJbkIrQUpIZkp2dm9hTHRhWDRNWnNYWjJkV3VneC9t?=
 =?utf-8?B?SVFmWG9BbW4vOXVjWjE1NXBhakh0cDZTWFRNdWlpdVJkVDVNVGduSmZteDkx?=
 =?utf-8?B?TmUxWSs1WW9VdHpoS3hyR0VWQXcvNHJUUkwzbnJHdDRpY1YvaTM2ZHpuRE1R?=
 =?utf-8?B?L3pHUEM4dGpCYVdpdVd4VkhvY0pzdUNwMWhBWmQxbEs3UHNjRFVYSnNUYjhO?=
 =?utf-8?B?VUt1Nkx6Q05WaE51K0N3WW9NVnc4ZUs5UWd5WDFaYTFadWNLL2VFMDNhOEVH?=
 =?utf-8?B?SjMxOVhIVDVDaHhGOGNmakVIZjBqU1A4WENIeUN6cFZ5TDYvbUhEbkdVSm51?=
 =?utf-8?B?a25aT2xzanU0T2tGMVVUWE9VMGliWE9uQTVXaVF1aXE3SXJIbnJBMVdWTVUx?=
 =?utf-8?B?YW9YdXNWWnBBSGVnOHJEK3NNem0zRzJVbTUzT1VBNDIzd2RLa1U2S1Rkb1FN?=
 =?utf-8?B?Q0tEMW9MN1YvU1UrL3g4dWNyUmFsbUgzZjNkOTFBM0FHb2xZSkRZUlVibGQ0?=
 =?utf-8?Q?73S++/tmdDjg8xQMorBpMO41xQO9CIX0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1Ywc09ZemZ5L1NjZGFPcjRTKzUvNGhMcDRld2VaNmxuU1VwallQejJRMUY3?=
 =?utf-8?B?YmZkNEZRMFo5bzhxN01iS2I0aVhteFBIZk05b201MkFrTnhGcXlJbzY0cnZs?=
 =?utf-8?B?MnFCNWtNVXBHcmZxb1dYS0tZMlZLTzAxVUdOSDQ0cnhBdFZFdmpsSHJSMmtj?=
 =?utf-8?B?VzZGMGRIY0lFNXNmUFRseitjdVVhRW4rT1FMOExoMURwYURWdmdZT1dWejdx?=
 =?utf-8?B?Y2hSbTBxZWp1ZXAwZGNuUUtvbmszUmRBV3hBUzhqRUt3NWhWSFlaY1pvZ09Q?=
 =?utf-8?B?Nzl0SE50T204VVhCYVJ0KzdLZmwvQi9ZZWFxWk12bHQ5bEFlZ3dtT2Z2b3Zy?=
 =?utf-8?B?aTNyaVVHMEJETWRjSWVDMkhHWVJIVU5BWTh3TTc2NFoxdDczblJvWktQTHR1?=
 =?utf-8?B?dU5zTmd3VU9aeHhIZ2xPTHV6dGpZZml2aDE4cGZjQkUxdkVmdzlDV2dpajd6?=
 =?utf-8?B?aXkyd01HRzRleEg3N3RQTGtNdkQ2cmFJVGd5WTJuZmN3LzZYdC9vOXE0ck1E?=
 =?utf-8?B?WnBrSEVXNE9VcXdNZE8yc0kwRkZiWU9YVmhNNFZRVnRKL3RPNmlkNXFFMmlJ?=
 =?utf-8?B?Q1dacktNRVkySEdZNGcvOWZnKzhEV0tNbDd5aTd5OFhJS3ZTa2g2d2JMNDIz?=
 =?utf-8?B?SHdxMG1GNW1nYnV5RnJaeGNaMGpvRXFJTERUbmg1NHVPaHhVNnl4QlJtSHZq?=
 =?utf-8?B?SndZUlMvd0VpZlB3NmRJbEJhSjhiMFpLemhlVEd5dFdSOXJtU29wNXVMOGUx?=
 =?utf-8?B?L0c2ZlZ4U1VEMUNkVDExdFU2Y25CZG54UmkxSlhWMlM2bHkxYzROSVhMSCt6?=
 =?utf-8?B?SnFlK09pWmp0dHF4SlBCdzZ1SE1Yb3lEdWpsUHVSUDRZWE9XQnR2L0dWZGNT?=
 =?utf-8?B?b1MwbDVYZ2ZBaDhEVTdiRXlnQWZNZ2NIemU5dUNjRFNMNlVPdlR0YWZhbmVh?=
 =?utf-8?B?ZURMY2xmcmMxT0UrU2hRazVTYkpreUtza3FwN1A0SWNNM0R5eDlQQ0pEZ3ND?=
 =?utf-8?B?QUk1a0pNNFhxdHZxRDZ1Qng3MWJBSlE5RHNxU3o1Rmx2TFNDaFQ1RWd4Ri9V?=
 =?utf-8?B?dE1BcUx5ZnBwaVdwUytsczhoVE1tOW56YjN3M3Bsa3BIRTl2NXVTZEFKUVE4?=
 =?utf-8?B?ZVlaR2hTQk90ZlhIYU9XTnNGdkxxSk1yQ1lxWGdBMlp1Wk1pdHB2WnhxYXZH?=
 =?utf-8?B?UlY1UHFCa05GUXJJRGJNejQraVg3aGsvUHJVZWRWTXJVMmFLMkorTk1QVFNk?=
 =?utf-8?B?TTJIMlZXWWswOFlWOFFiZEZ2RlR1QmRyR2lKL2lTQnAvMlRJdG1BL2tsbHIr?=
 =?utf-8?B?enB3WVcyUnpxK0ViVFJjV0hKSHlYdlRBTDh3cVRxRzBadmVuMlpUVXFRNmcr?=
 =?utf-8?B?SDZEeGVYaG1aUHNma1NPWWJWbVArdU9WS25sdlVKcXBVVTZDTi9UQ0ZjWmhW?=
 =?utf-8?B?UVFTWmNta0toMGtnYXBnTFplbVRMMDQzRnFlZU5sZnZhVCtiV01Ka0w1UXVD?=
 =?utf-8?B?SjdwYm1ZMDJ6aHBUQkVMOU9ESUZQOW84VHdaNkVJdVE2N1NTeWVSN0RZblFS?=
 =?utf-8?B?anZrb0sxNlQ2a3NOV0VCSXgwQ0hYVk9yaTgwM2RpM1dRRWIwaTB5SVFCa1Ni?=
 =?utf-8?B?MHVNOWg5eElzNmpWUkxhMmVIVDJNVkhScVY4SjJFTmNTNHcycW96U2MrT0ht?=
 =?utf-8?B?OGkxK2g1eDZFSWxhb1Fwa0o4blc4OXdFZ1JzekNtYXVIL0ZjUzZFTThvTDdW?=
 =?utf-8?B?cEtJN2QzZ09kQXJJTmhSeVdFL0JHMVB6VnZJY0FYc093d1NmRjVibGFrSHV5?=
 =?utf-8?B?MWxPRWVydTA5cU0vQ3RNeTk1NXVKMVVCVnU3a1ZuU2pialc0R2xVeUZCTDlJ?=
 =?utf-8?B?OTFQUExXa2Q3SnNaSVpVTmdwQmI3UVBpZ0xPcTFmNE1YTUlueDQyaVVBTWZr?=
 =?utf-8?B?OVc2ZFZuVTNzdk9iSGFZQllrMjFqZjNMcmJvdThMY2ZqKzlqRUpVcTQ3dzNT?=
 =?utf-8?B?RS9JR2Nqazh5eVBKZnpJSHY4cklEM1RFb0lGNGdRRDlPeVFOTnRiMW9SMFNw?=
 =?utf-8?B?SmdpbUxUdkVsYitNblFQV1hSRzZNQnJoU1JxaW4xcjhyM2NDMHZEVCtaS1Rj?=
 =?utf-8?B?Yk5OTTNlaE9EMUpnaTNOQ0JKampLWVdKQktHZlMvS1ZLMDM5aG00cmFpQ0gw?=
 =?utf-8?Q?W4cKiENmf9crxdqIDWJ0YpxMKAt9qCiJ6Bt8AHs+toKv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d29fac-85e5-4526-3864-08de008b5586
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:39:17.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvtHhh0ORZZbDaYExfgsPSBjnTVP0i9V4bJXJ4Cz7tfCxFlNzoCxUJ3nC7zOovVRCfqa5EsK0AB7e2BaDStjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137

On Wed Oct 1, 2025 at 10:26 AM JST, John Hubbard wrote:
> On 9/30/25 5:26 PM, Alexandre Courbot wrote:
>> On Wed Oct 1, 2025 at 7:07 AM JST, John Hubbard wrote:
>>> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
>>> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
>>> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was t=
o
>>> let NovaCore bind to the VFs, and then have NovaCore call into the uppe=
r
>>> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
>>> longer in favor.) So, in order to support that:
>>>
>>> Nova-core must only bind to Physical Functions (PFs) and regular PCI
>>> devices, not to Virtual Functions (VFs) created through SR-IOV.
>>=20
>> Naive question: will guests also see the passed-through VF as a VF? If
>> so, wouldn't this change also prevents guests from using Nova?
>
> I'm also new to this area. I would expect that guests *must* see
> these as PFs, otherwise...nothing makes any sense.

But if the guest sees the passed-through VF as a PF, won't it try to
do things it is not supposed to do like loading the GSP firmware (which
is managed by the host)?

