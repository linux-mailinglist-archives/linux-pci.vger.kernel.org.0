Return-Path: <linux-pci+bounces-42037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDEDC853A3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053784E8C57
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB143770B;
	Tue, 25 Nov 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJrasmSF"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54D221DB6;
	Tue, 25 Nov 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078280; cv=fail; b=SOX4VP9tiagc2QGEvuK4q3ci9pPTFN96QwigqTue8X5bO1FvkQ2VEfzCbB8oSWSYVwMdJOGTkIo0x8FYgjnSYhJqm1Nrf0dONV4B8CkbX3/ieHgt1e38Ok2jYGbpt2Mgh+NniLOy9x6lGjrguXRy2HfP+EnDBBp+mBlIH7ij08M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078280; c=relaxed/simple;
	bh=9K4Q9Ny9kVYwALSudBYFE9dAEh7chpQYnu8a0Qnholk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gBlrqHfcjWPLRQADf18pT1isO+NqmKaDkSLUZPU7pFZNSZOqW9qYd1hV5IAQrC3JjJuyC5l+4Z28u8XbA1rn0J9B0edE0aRRt6CBIGx9avXeiWE5w4EVrH+ahTT5IcMKhKf8FRASu5MKdSHAo6ky+Rr7qToRLfcQygM/T6ljWE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJrasmSF; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMAqvbooZWEX5bcnFGgBXtdyBkCk3S7o9rs7fy6ezfh7VvPTCADVjXB4bxMMt/DSxJr+P4xV3mGI8rh6ObvFBGlCjdwfpWSLHYETkfxssek5tbLbNQ3683NpQWoc2JrjBTfUNbiAg3w8wiqayxqh8B6cjjWoroINWlRYkK04SMcXPIK+ufBhl+YdIbCMhsd1g+HnSHK32fi6YOsPLmipG0BOcfZ6tK1BWpLuFzBwMTK3w4YeEvF+ee/b7XFI2+aEEwes48hkV7Viz3gvVgreTFoEOsmvvR1I3HMst/2lBsOehwlTANVEpC9m1EbfoCSRvyb8D+CJ8wgH6GFsjw29mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K4Q9Ny9kVYwALSudBYFE9dAEh7chpQYnu8a0Qnholk=;
 b=bwiHboZLTQjiVA96Zutc4yW42krgHPWIqPG3C4wMWzRa2nk+wlFUngZGTCHk6Lkm0gRzdvq+/9LOYi9m1QafGXu2Wf9T33hCFschFvH4i25mZAfO/sNusEwUvKstccUsKwDvynWGeSSxPYsE30MnCpqZsuOuSuH215k7j7W4lHyhI/KEjEsOYA5dfLjCBap0Dmp+c9Lq7UJjC426kswAFtPpYaZh4GdFf1M63lpXnFb92EBdMaS39vc7aSnt6zfc2ORSEvSplNceMj24zOBx7dYK6rC9O4O8wKsDfe+wC4twKx3j11GYkfhEEi+3zpCv/9aK0p75Y//86LAYjUp5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K4Q9Ny9kVYwALSudBYFE9dAEh7chpQYnu8a0Qnholk=;
 b=TJrasmSFDP62gduoFqCu7K65l0dP9KbfZVsTQUHvdvrZ/RFS1h0pX3qp94L/HtWOKaFZXYUCKxNU50asjnQcKOghCu/rZegqGuJIlQ6bCo/uJD1nw94Yp3+ixcVusC7h7syxxtnmotxIGCjKFDbff2urFVye0BYhZEaIW5mb4htQnpGQyO3dFveRCbtFj4XL6dutyDtPf2O+RMaYFZ7GSEHoHnKK6TWmG6uHYREAUjmCchzMMPVgBiqimxeVwxNGxbCkIX4M9l/lBNtQAqht0w8jnkLM42CkrZnfAw7g1j4qxJUHaqx+GuzsQq89YkPFsREO4bwAOw+U3t5XdLD+3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 13:44:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 13:44:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 22:44:29 +0900
Message-Id: <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <bhelgaas@google.com>,
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
To: "Alice Ryhl" <aliceryhl@google.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
In-Reply-To: <aSB1Hcqr6W7EEjjK@google.com>
X-ClientProxiedBy: OS3P301CA0030.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21f::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 39325101-04f4-4712-1d63-08de2c28c3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDN5SHgxRDBicC9HYlBuUDlFYjZvU2MyWE94VWU2ZGVoSnFIVDJ6Z1BSYW9I?=
 =?utf-8?B?eUVPbGY0SHJKSklTNzRnZVVwRDJBTlYrcENSNTI0ZXNkakxGbEJzYTI3QjFm?=
 =?utf-8?B?UE1MRDJLNk42QUUybkdQL2YyQ0wxWDd1KzBEOWU1WTVKR1JzZ3MwN2h3Mnoz?=
 =?utf-8?B?TlhSd0k3bTR1Mkx5SG10eGF1djBjZ0hQUkpFa09pTXVSSmNwc0FyTGcwcklw?=
 =?utf-8?B?dkxONTZGU3FCNm4xYXlHRmVkVkhWeWpOMlkxeU5BWmVsZDR5bVlKN2U2Ly9Y?=
 =?utf-8?B?Y3VkMzdWRTN3WEx0bmhiRUY0ZHp4ZWh0Sk42SnRTdWpaaXU5d0hrVUh4cE5S?=
 =?utf-8?B?K2Y0L2xzK1lhUVMvQ1JDTS9hSmVrUW9zSDRsNEV2UTN0M3JNdWEyR2dsQ0gv?=
 =?utf-8?B?RmF0OGxWcDNXUVVvSDlkODNzVjhOOXByaXl5ZjRKb0Mrem54b0JPYml3SEpr?=
 =?utf-8?B?elV0d25RY0xSTy9vdStsQ3IwRzQrMHdJZFdPcjVEeUo5WTJjbHJmakJXUUxs?=
 =?utf-8?B?dDQyTXFxV25XZXVPTkhYKzNYSG9NRElyUXRyeXhoNXZqbXZIcGJLRkE4U0dq?=
 =?utf-8?B?QmpjQ0lVcWIxSzQ3bVhqMUdMaWxHNzB6T2lBd2J5dDlTc3EyQmQ5bTBibDla?=
 =?utf-8?B?VGEzaFZ2bGJaU3ZmditFT2tiZTRUbC8vZTJKd2t5Nlh0dktXM29QUGdJVHkz?=
 =?utf-8?B?MEl4VU84VUx6cVIrcDJmeUJVVmhTYmFyRVp3YWpMWVFqeDIxUWFQdDRrZDVh?=
 =?utf-8?B?STVodENWYTVhMW16d2ptQmVqM1M1NC9MWGtGakxlUUFyRzRRQ2RRR0ZQT0lW?=
 =?utf-8?B?Q2ZubDkxQ2x6aTF6dDdaQS9pK3dwR1lNZnBZdEFTTFl3ZEEvL2Z2OWxXTzU3?=
 =?utf-8?B?M0VDMDdCR0IwWCsxaVlmZnlnR2wyblNPR3Z1cTdDNTdTMElMUFp1Sm5JMGVJ?=
 =?utf-8?B?MGxOdnZ3dmhQMzJMeURndGJaZ1pWQUVEYjdKbEZhaHRjZ3U1MVFEakJodGFI?=
 =?utf-8?B?OXVTY0FhVnZDZmpldVFzY1BvR1lRM0xQV1NMaHhjanJKQzV2SjZmMHBYaWJW?=
 =?utf-8?B?THlaU2lFcno1NlpTRERBY1V4bFNMc3l0V3RacFpDUW5kZ0orZXdBL3V2MmhI?=
 =?utf-8?B?NjhpNHFCaDF4U2g0OE51RUJLUmhUUXFiYVRYekJ3UitxSmdVYThaU3dmYk5u?=
 =?utf-8?B?eThNdmIvYlFuTHRvZXlpQnducHRpMXc0OUcrblFOMm1aRUVEeEJpN1ZseDl2?=
 =?utf-8?B?WjFjYllGUlUyRDFyRGNoa3UwS25KVCtsbXFtZElyU3dxNnFEVk91b3krc01V?=
 =?utf-8?B?ZmQvdmZBMHNyT2xTQmpWTEN2SnJ5TW1iczZ0MkZLYkJrcXp3aExSUmoxQzE2?=
 =?utf-8?B?b2o1TWVsazhKS2VnSC9Rb3lVaklNR3dQQXRWdm82STZuT0RiRUowSnRMOFhn?=
 =?utf-8?B?YVk3R2ZFWHZ3VFRvaXUrdE8rQXRMamhDc2ZOSGoweERiTEhXZGVSeWF6VzY3?=
 =?utf-8?B?WVNRN3d2WXJFeGpzRmJpYXlaN1k3dFFucHZza2pzYTR1WUFHMDJPcGphYXln?=
 =?utf-8?B?WUs3c2ZZb3hXT1B4bitDNlZEd3VCb0owQlc0aVpIRXdNTXV5OS9Hbzc5UXNL?=
 =?utf-8?B?YnFjajF1bjdZVmJqSHlNYjA4MStGL1pBdVhSOWZIMGE4NXorQStuNmN1RGov?=
 =?utf-8?B?TllqQjhNK0t5R3pkMmY3UU9FRlFtUnpjL0piWnM3RngvVVpaYVAvRUhQSDVT?=
 =?utf-8?B?dTNMVllkOXZVT3MwOE9FeHRpT2JwU0NTYlpxMGxQNGRGTU9FL0RpeG9BMFZR?=
 =?utf-8?B?TXFnODFtUWU3SzBVeWM1d2hWWHBQaDdnUzV2ajAxbUc1SWVRWU8wTzJpZjZP?=
 =?utf-8?B?UHZicEc1WnRXaGl1dENwQ2x5Wlh4SmtsZE1RVnBOeEZseW9FUmx5c3R4YjNS?=
 =?utf-8?B?Z2R3bDJaNUNGcktyVTRpRDJTRjZsS1JwYXErbDUrVTVicWJDcjZYY1dWcysw?=
 =?utf-8?B?SFMvaW03d3l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkE0dHBkN0Z4SElEVHl4NDVIbm5TS01kSENpajhiSEN2VmE1dHprMGdiT1dI?=
 =?utf-8?B?eFlyK3VvY050UXZtS1RYUGdyNHJlcWwvR09DRUhRc3dBL2pIc3IxYTdzNWlX?=
 =?utf-8?B?STJLd0xOTjhRZzdOTHFVdHdxdWtmL3pGWlZiTk0yTThFaU5yeXk1V2t6Y2R2?=
 =?utf-8?B?cEVJY0FzUG9RakRqS0h3SjcxUzh5MTZTOVBGdHZuRURuQVhycEpQa3MzdGw2?=
 =?utf-8?B?d3dRc1JFVEM3QURXcHJEckxLcG5GamJZZTJQdGxIc0F4Yld1UzBDNnNsUmFj?=
 =?utf-8?B?dUE4cm5OcEMxYzZkalNTOU14WmhRckRSRlJweHZnTTRYc1VocFBwUmFHeEM1?=
 =?utf-8?B?ZnFXem1MYTNtazkzcWlzTjEzYXpiYlVMS3Q0U21YNUhtSGxKMDBlNThjekdm?=
 =?utf-8?B?OHhUTlBkUWJENzhhWE1HQUprQjJYY1dPZnBrbmJMYzcvdU9uTjlwSDRDUy8z?=
 =?utf-8?B?OENCWithUzBEYVlMaXI1SzArT3IyamYxVE95YjdSUUlleHdvdFQxR0dBamxH?=
 =?utf-8?B?N2Q3NUZkMHg3c0hOSWhXcVVwRTNSanVMTzFLajhxRldISWh0WExPRXNabC8v?=
 =?utf-8?B?ck9yd3N0MDdHd2xlZFprSU43T1cwWVgvVDI0R0xLT3FWVDZ0ZHhKTHppVTJ2?=
 =?utf-8?B?ajZhb2JjcjR5K08wN05pZlhRRlphbTRYNUYreGdLcnQ4SHQ3T3FwSUNBMy9Q?=
 =?utf-8?B?byswa3JqMGZiTmtXTkptTHhWdk1vV1F5TGZUN2NveEJ5cjdJcEkvdE8yTVh1?=
 =?utf-8?B?ZHVyVFJlSmVkSERlVThJSW85R0NBaEFpOEFYL0ZEc1FFWTdaVHY1ekVnWG0v?=
 =?utf-8?B?MU56ZnllMFFhYWxIVUxVRGIyN2RQZjBzRG9DSTU3MitQdkp1dWYweU1EYkxp?=
 =?utf-8?B?TW5PM0p1WFQzR2lNZXR6RTZYcGFiYzI4WUorVE9OUjhTQ1hUQ1ZrdlN4TmdR?=
 =?utf-8?B?MUlzVmdIeDBpTkdRdndib1ZUWHd0Mk1XZStQdFhkL1ptalZaTWxWUTNyaEor?=
 =?utf-8?B?ZVNEYUxCek1DTnlIa0Vtd0daSWR3NmZpNEhyTFBZQmM4NUJJRURsTVBQTXJ2?=
 =?utf-8?B?TjFzYzFxdW9QaHZta2IrVVhvU2licHhqMkVtcUxldkthS2xxMHMzT2ZJdnhh?=
 =?utf-8?B?d1ROSTBKeXB4YU9abEMzaVFZaGkvRThsWVpvMXg1dExaZnYzQjRLUzdpOWNC?=
 =?utf-8?B?V0hkbzk2bDBaLzVtUlFnNjZya1owU1hZTXE4enFHeDB3Q2VjbnphbW9pV05Z?=
 =?utf-8?B?YW1LdnJNTWZQeXJJWVQvOS9MM1lZQmFkUkprUW5KT1JmcHB2L1hnQXFsZ3BV?=
 =?utf-8?B?WUJ5dndvMGEyTlhzYmZKYmhlbDdBaVd4Y3hNZUtCUkRwZ2lLeFpQK3QwalFZ?=
 =?utf-8?B?UXprLzh4Y3NzVzB3d25mSTk5WXM5MDA0SWJwb1ZocXBvL3pwejd1QTd2R0Ju?=
 =?utf-8?B?clFzaGJvRDIzWnVmOVZDOWVLdWpVVHljRys4UnNMN1BYWUxIZFhnSEwxWXhZ?=
 =?utf-8?B?NGZCWHNmSTY3c0FZaXZzY0duQy8rYTFhT2NEYXdISC9Bcy9rRHdyOWp6Mjdh?=
 =?utf-8?B?WnZ0MXNHeWEyNE1BczV3cjZUdWpXOVd3eEZXQnhtaDJiNXlQTlZDVjVhY2Iy?=
 =?utf-8?B?WHB1UnVnNXBidGlSYXJXa29mRVZ5UUh4Q3oyY3E0eEhhVGx4VUJMcGFaWC9I?=
 =?utf-8?B?bExsbCtjRUZDeGF4alprZnE0a25HeDQ2ZkkzSUNjcjFCTGZNdEQxb0luTEJo?=
 =?utf-8?B?akwwZ24xWmNIVEloajBFWFdjay9nV050MkVZMXdnVzRiL2ovZkpuaTJBdXNB?=
 =?utf-8?B?R011QUlRblhBa3RpeEJmd0Z2aWRIcVRMMmN3KzFXYmlCN05YOG9peFhCS0Vh?=
 =?utf-8?B?ZmlzbmpWUmQzMDh3Qyt6VGllMTVGRjRxRFcyS2NGZkxEQTR2ZGpUV2ZobGxE?=
 =?utf-8?B?ck82M3V1ZjByN0pqZXIwTVRvams1eEtIN3FHSm9RazlNaVF2bGVLWnRVWUgw?=
 =?utf-8?B?MjJDWWtxWDVpVnA5MnljeTFxSjZVcGNSZTFHY1IzZnJzSFhDTDBnWEVVODFp?=
 =?utf-8?B?dTlKK3lJMlRxRGlNQnE5MmlQZzNwUFV4c1ZLamJHYWVndVhZRmxLc0xzN29T?=
 =?utf-8?B?bFB4QXJGQjNjaUw5WFl2dXlXbzNqM2RZaGM2QTRsM21qejN0NlVVL0I1ZDdR?=
 =?utf-8?Q?V8K7EbOSMcPHTL7o2SJ0wztujqJ/ojzCrfEWQHTBC12K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39325101-04f4-4712-1d63-08de2c28c3ea
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:44:33.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhPvX1FwfK6a6iOgU0k+AiD+OcuTUHRzW73ecMxQM5ilXrmvb8+vh3Sm961wdlVgN1yTQarwe2Dw0KUK3SiAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
> On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>> The previous Io<SIZE> type combined both the generic I/O access helpers
>> and MMIO implementation details in a single struct.
>>=20
>> To establish a cleaner layering between the I/O interface and its concre=
te
>> backends, paving the way for supporting additional I/O mechanisms in the
>> future, Io<SIZE> need to be factored.
>>=20
>> Factor the common helpers into new {Io, Io64} traits, and move the
>> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
>> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementatio=
ns
>> to use MmioRaw.
>>=20
>> No functional change intended.
>>=20
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Alice Ryhl <aliceryhl@google.com>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>
> I said this on a previous version, but I still don't buy the split
> into IoFallible and IoInfallible.
>
> For one, we're never going to have a method that can accept any Io - we
> will always want to accept either IoInfallible or IoFallible, so the
> base Io trait serves no purpose.
>
> For another, the docs explain that the distinction between them is
> whether the bounds check is done at compile-time or runtime. That is not
> the kind of capability one normally uses different traits to distinguish
> between. It makes sense to have additional traits to distinguish
> between e.g.:
>
> * Whether IO ops can fail for reasons *other* than bounds checks.
> * Whether 64-bit IO ops are possible.
>
> Well ... I guess one could distinguish between whether it's possible to
> check bounds at compile-time at all. But if you can check them at
> compile-time, it should always be possible to check at runtime too, so
> one should be a sub-trait of the other if you want to distinguish
> them. (And then a trait name of KnownSizeIo would be more idiomatic.)
>
> And I'm not really convinced that the current compile-time checked
> traits are a good idea at all. See:
> https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
>
> If we want to have a compile-time checked trait, then the idiomatic way
> to do that in Rust would be to have a new integer type that's guaranteed
> to only contain integers <=3D the size. For example, the Bounded integer
> being added elsewhere.

Would that be so different from using an associated const value though?
IIUC the bounded integer type would play the same role, only slightly
differently - by that I mean that if the offset is expressed by an
expression that is not const (such as an indexed access), then the
bounded integer still needs to rely on `build_assert` to be built.

