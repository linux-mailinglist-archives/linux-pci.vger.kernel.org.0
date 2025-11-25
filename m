Return-Path: <linux-pci+bounces-42059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1AC858FB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3814EC71D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4532694D;
	Tue, 25 Nov 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p86uXXJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5423BD1D;
	Tue, 25 Nov 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081985; cv=fail; b=CiN6mVfJfuPxUm41wXz993p9Sm/JvmqMNOg5K5BxvcvWeCFZoEUgfk1pZOhefoLrXAMdsusivk2Yf1e4lfNB8k+rsAorDn4mRxD5GIlvoLiXFt5dULTJE+3kvaM6ysCUQqER4sR+59lcMz2dnSoeIryNK+OcOdGsT6yQT7ZKWtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081985; c=relaxed/simple;
	bh=y+FKcxBfIIZYX4Cc+FC7tUQ1QuPkWVGaby9j5hEuBbw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=sZhHMosJJ6whK+5s7xxQ49NfkNAQohvvKx86n9Fqfu/zGzVVJKfKKmb8I/nMrg42FnNPOkuLcRGI3MjA1ghRePQEZlXFX6CACSNsHROO+vOZTrcobVgUxOxVqncG+ZMFNL1rhylzlp56ujIuuS+xWR4l1ElbzSCAiLcWFhk2akc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p86uXXJN; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8SYmo7SQDF/RYxKzaMOolQeO5PmQe2atXoEuiL9sw61q4Qy9lgEcVc3tkSlaFk23T2VbhhrdyrPo/jzGOP+ANjpSlAEV7X1YeqjfOtiUblmcJYkf98UZOn5x41Yywf+jXWv60koDUXfeQXyko95Yhcz5xu+QR/ZDX++pQH2FXbZMjmaI0mmPOrXTLI0B6PCq8VD3IJZ/c+gSvi4KEK2I4R7mxEx85Pk0+bWtgo1vQMERhBmTpIcVYRbzHBXyYcXtsuhtFqXIFjqb+NsuNQNiKu31KVY/X7qpYie5H4rY3IVvAyBW2hjMTujg+q4Jv6H15P3ejYT8EqtBFEhw1n6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml3jNjT9lNq/rs7Y8y2UmIFXM+gfboQbE5U5/1oD9M0=;
 b=KMtVwSbpJ4UViknFmUQBCruLfQyjC/baZKmNoy3Pm3vqDiUA5s+o0gB/e//iwoRbIvOhCA9Tfz2uafqd1i+SRMsNGbtKwACXy9DyAOPlrhSTkZOCe2GnlFQWhTVEHdsnSwtBZ6NiB7R2g4ZKrhDkrWLs/d0VKqHWi/dAyYLbnC3NTkvfqE3vqzJDq9GcVgIgMX0d/OvplHjAPK/EGQD+4PWsgn3qUiH8GIjozqna+LaCF5yKl4FZV54IyxTS4ttS4sCt3DZHU32XoflgbtYJMw6fuk02pzw0ew7W0vQHkNNnadopp4WqEuUR3A5RnS17HaNsBXn6x55PGx7y3yInUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml3jNjT9lNq/rs7Y8y2UmIFXM+gfboQbE5U5/1oD9M0=;
 b=p86uXXJNqa5rkOLGj9BU8yzwxke27PNZRgMAqmesNBIfB7CGXZ0RRJw5gh8VzTzUS+Pfal9Y3T3Q6N00APE5G8HmYf5K3IlfZmX6ge/qBD8gMOu2Z66eDq57gO7ChfBjH039FN2EVo9NqeJPImqBbqnXTsXJHRtlYa3FDfDuLCIAlS1IiMVONNpRN8eloub3inuDHRYe9gHdZZ1X4x9GlKTNecgyq6UXieMAX8JR2VoeVlQgze84fzxHKwLzKo3n0KikBZ09ylq7Hl9SCWdX3RNg18AsfQPcFy6Wz8UbIpoSBpVBEkVRjq1lqtHKcGGfB3TceDSLb5qmAcd8jp7y/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 14:46:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 14:46:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 23:46:16 +0900
Message-Id: <DEHUVC6D60HX.CBJ6ZKGUMA8K@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com>
 <DEHU2XNZ50HW.281CCT1CZ79CF@nvidia.com>
 <DEHU7A4DWOSX.PZ4CCKLAH9QV@nvidia.com>
 <CAH5fLgiCgMse0-L9Fb_r=3umucTqNosfO4R+1YVzOqavo07zMg@mail.gmail.com>
In-Reply-To: <CAH5fLgiCgMse0-L9Fb_r=3umucTqNosfO4R+1YVzOqavo07zMg@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7b3b2c-368e-449a-93ed-08de2c31653a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFprVHFrSFNxSzZHVTQ0Ujg3S1JReVQxYkU3cnpleURjL3drMEhncFdOZ3Q2?=
 =?utf-8?B?SXZ1OWNtTDhFNVVTSkI0VDB6Y3pzSHU4Ty9NYzBrQnBoZWkxMlBLVDRXYWNF?=
 =?utf-8?B?NXFRVEtEbmJRNEdFUWxzTk5lV0d3ZE02MDlZSVBKNnpZS0tFTDZCeEN1R0Nx?=
 =?utf-8?B?N0FuRGtMeHV2bjhQU1FOV21HQzNJOTVucFlYNXc4L09HVFRRMnBPNU1ScjdU?=
 =?utf-8?B?eTNFUlJBL0ZhNU0rWjNPVE9PWWZHRndIZGZnKzlLU0c0R05nTUdPREFwM1VP?=
 =?utf-8?B?eThuU2hOelZwWFJyeHp1V2RMeGpZbEg3blRkVUlPazVBbG1QM2ZaVjRhcTdi?=
 =?utf-8?B?UERLR083ZlkxM1ovTThRelhVVHFzSElVMDA2TngzYXJGb1l5UmFHVTRVczFQ?=
 =?utf-8?B?VXM1K1VUbnF1MENFUUpFa1dNTmEyRWdKc093SmJ2cWNQN3YxeWt5VHBiZHJ3?=
 =?utf-8?B?eFpQc2FwbERKM0lhSlV4aDhKby9FUENwc3JtTXl4c0ZTM294K3BIQ0ZuYXJa?=
 =?utf-8?B?QTJ1MVBJYlNFOWtPN2xFK3lKNWNQMm5uOG5tREhLTFZpdVRUSkV0SWdzSW9E?=
 =?utf-8?B?dmtnZFRTY1BsejYvSEJQbEoyVkd2TGNjQ0pIVEpXRFk3TkNEbG5Pb3FlbzMz?=
 =?utf-8?B?azI3Sm1CbVlvaVJUZjR0a3poS29yOE5FalRDblQ0TjNrQ0lJQ3Fad2Jvd1Bi?=
 =?utf-8?B?UlJ3bUVmVzU5WjVUMzFvam5ua0w0VDYvK3JUZndLb1VqU2ZSRzE0RFkyYjF3?=
 =?utf-8?B?amUzTmdxN1pOY1hIVkUwN3hvaXo4ZGQvdlJLQVZmK3BaNXlJN3JiUkRtbFZS?=
 =?utf-8?B?T0tpNmhNRmtUOGtsQ09BN09KU0ZPSTVSMXBvMlFjSDhuTzBhbjVGaDBCMmJ4?=
 =?utf-8?B?Z3dRZ3R6bnpFc1JFaFF4WnBwQzdFYVRvVnN1dkVQS25oSHVKNFVDVHBBRFpC?=
 =?utf-8?B?RTBwbko5Z29GekFNMStlYmVkZkNjWTJmUlA2Vm5CQzN2VEltVWxlVkpMYjdi?=
 =?utf-8?B?bWExVTVLd1cxTEdWQXc2MFhkazZmR1hOU01CdTM2djhqc2NEbHBudkdXTysr?=
 =?utf-8?B?Sll4QUV6Z2VDZ0Q5L296MkYwVzEyY3d3aC9hQmRGNDdQaWFKREYzOTNGQm0y?=
 =?utf-8?B?QTNvUEszaGNUU1hXUVlHWGZBamhXS2ZQb2dlZFFNYjZDem5vRSs1ZzBpNi9E?=
 =?utf-8?B?a1lRcVVmdDJWSjVWUEpDK0sxV3pISVE2TVpaT1JMMVI2ellTUzJTK203eWtW?=
 =?utf-8?B?enVJbUNCOGsyZkhCSTRlL1NaeERXNnlkZ2FndGJoY1JCNEJkR0FaS25xT2RC?=
 =?utf-8?B?SVFJa2QvQ1Y5OEdXdUs2cy9pVUNVWGV4aXZyTVJPVDQ3SDdyaDFTM1VpQVZI?=
 =?utf-8?B?MFVGZkNlaUJqS1FTQVlGb1MyUTErMm04MVB0L2ozLzZwR29CdXFFdTBqb1J1?=
 =?utf-8?B?UExaWXViZDVaUHhpUkUvYmIvQkNnVjg1MlJUbFYzcXIzVUVaSlVSdGFwSkhq?=
 =?utf-8?B?TWhTZE5jdFloUFBOT1VQaGhLN3lMYmF1YXZOV3dYdk5xcGdLSDl5RXEwWmFP?=
 =?utf-8?B?OEtYK1lhV2dJNVp1WHlNSnRLWDBBSlJrM2d1UUVzUEZGVEd6SlQwT2I1UGhV?=
 =?utf-8?B?MW9POXRnYjIvL2tRNk5Nb2RVZkhiOFV4K0FxL2xSTW04Y3BaWmExZHNRNWFB?=
 =?utf-8?B?U1daaVhFd0FiZHNjWkRpYVNjc2RIM0tkaC94MlYxVmxDMWVPRnNxYXp3M3ZH?=
 =?utf-8?B?YnQ2blU2OE1WMVdnTGs3VTUrdTBKZjRyQWwvQVdhMjlpT2dXaVVxZFB3Tk9r?=
 =?utf-8?B?Y2hObDJPVWhqdnNGVGVSYmJQZEVjWkRYWFpVQldITkE5ODk2VVVwZTBkMjcz?=
 =?utf-8?B?VzdOalMrQkM0bVB3eDMrSzE3UUhHVG5Ea2lhckw0c1hhd3Y5TityNEIyWDZ5?=
 =?utf-8?Q?rL6XaD16MQeOquqEzUju4Un7IgDaSnVF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2E0REN1aHR4RE9pckRYa0kxeDZzM3VTVGsraVhBTW1LdFFsL3AwT3U5OFNS?=
 =?utf-8?B?UjNXUkVvUEthY2xZSTVrb2h1V05IZ1JIaHJ4dUZVQUovdFl6V0h2emNySmth?=
 =?utf-8?B?RnpBNnlWS21QRi9qQkhsK3pJK20remQ2d3NsWmVka0FiTzQvWVpzUWJKcXFD?=
 =?utf-8?B?dVRVcGtoZmdic2Z4OE5FUDBWTTcvZTNZSXUxcTlCNDYzZHFQdElnOWRMQ1Zk?=
 =?utf-8?B?Uk9Yd3NNbVhsODBPdlNvOExVS0dKN09UQmpOaG1zSkZkaWpaeFZsN2ovaUha?=
 =?utf-8?B?SnZJSncxTTFCMkx6TVBQaDVqQVR1MC8raGlJdFRPQlY1QVlqWTk5NWRnUXRC?=
 =?utf-8?B?QUFtTlc3SlBPTkhLMGVIU21LZnFMdmNkZUhZWUhTempLTytkSWladHRBOTc1?=
 =?utf-8?B?MFN1dExpWlBVcDVmYk9TVnREK2JBaG5RaCtkUXdkUnFhZlc1bjRWTzg4dTZ1?=
 =?utf-8?B?RlVWR3RmWEFpWGxvUjRLSmxReVZ1OXY5TVJzMGFOejRnYkp6WnN0cHVjbHVn?=
 =?utf-8?B?RFhJYXF2R0Z0aFY1c1FkRlZHd21hekQxMnZJajhCUVRua1pYREJndjh1Q2xs?=
 =?utf-8?B?SllWSSs0S2dlVFp5bU43eUtrM2pFV1UrV2lYT3loSE04UHJPOGN4Y29MU2FM?=
 =?utf-8?B?eHdST1Frbi9wRWVoN1pnVzcvdWtXR1N6bGtmM0xvS1I0MEhNeE9HSjlja3du?=
 =?utf-8?B?SWtCZHNxNmRMZkpXWlNLcTkxZTU5TmsvdWk5aUlqa0ljdGhsNDNqK0tJNXFo?=
 =?utf-8?B?U3JDNXFIdHFablgyRllHV0gzSTZmUU9ubHByRmJlelhYbkk4WGp5WVJVN0Y1?=
 =?utf-8?B?TklPbkpSQk92QW5JejFUMFYrRlQxdnBCVkdYTFAzZVN4NGMxeHBzR0JBT1hq?=
 =?utf-8?B?RkY4OTRWM3VPNUFDbTB0WVQ1MkRzd1l0R2owWWZFQ0xOTGFNUEhEeVVLYkd0?=
 =?utf-8?B?UVhBVTBqUXRMd3NidTFNWitmZlVOYVNrM29TYzFGbmJEeGlhQmk3Y0d0UGU5?=
 =?utf-8?B?LzF1TW9KSDRsaEpxK1VsQ0tTMzNGT3NTK2paS0w0N1V5NlFUd29lcU1mdHhU?=
 =?utf-8?B?cFp4MHM5RXVqaTJ2YjFpc09GWjBZbHFobXBzamNkcmVQS1lUNVRZbFlCWi84?=
 =?utf-8?B?SFJMNkVyQW1PMFB6Wi9wTmptZXVzTDFrQ29FT3JyN3FUOTdLV1E5bEtDL1VV?=
 =?utf-8?B?VzV3SmlFLzViQnZzeHc3a0QyTTlueXd5REVKRmRBd252WTFUb2ZZaCtQZXpZ?=
 =?utf-8?B?RitEQnFKSHpmUXBiUnEwUmpzMmFkTDFSeVVLbGhXNG5RQnl4WDFRWHhkWnBH?=
 =?utf-8?B?RkYvazZIbkREYnNLNGtTcmlGT1Znb1kyTkdFMW00RjVCRkkzeURHOXFCejlv?=
 =?utf-8?B?TVhSbVRQM0lSWEZVcXorQm9PK3hOL1FFR091SWQ2dzh1cnU2eWNIZzZnL3Z1?=
 =?utf-8?B?NmFOM0dTSlFFUnlRTlhienFnWTVrMzFhQTVGYlNxOEFaMC9SU2k4YUg4TWNq?=
 =?utf-8?B?cjQwQWVMVTJPSzhWUk5PTEsxZjJLeUdBVVFZU2tLbHk0c1l4MG93YXlkd2dj?=
 =?utf-8?B?ZjBxdkVpd0dQTUxUaUJKa1RwZHJFa2VVblY4dmFpM0d1Qm45bkJzd2pNWXUy?=
 =?utf-8?B?OU5WWUlEQ3lGclU5aEh4RFBkMmNUWHpITmRNcVIyZWl6NE5HMHF4amp0Tzg4?=
 =?utf-8?B?Sy9BNlcvd1dNZXg0b0pBK0hlQ3pIWGEyTURsNDY5U1dpMmtBMUdJdUphT3Zm?=
 =?utf-8?B?NHFwR2hUc0x6WE5RaW1QMDRvSDhaUDdDZFgwcDNBRUo0WXZEbis0M3VHYXJm?=
 =?utf-8?B?bHYyUzJKRUh3L01BQmtlS3ZwdE1GZGxiS1pCWEp5OEx5NXg1UjhrT245N1o4?=
 =?utf-8?B?bnhoSlJ2KzhFbXJ4RVk2UG1QQkhoSkdoUGFxR29uWWZQYmRFdTFVYzRPNGkv?=
 =?utf-8?B?cTZCemZVMnBQTjd3V0NTcjVzbHVzMnNsRVNLYWh5dFFFQ3ZJa053M0p5QnE2?=
 =?utf-8?B?WkZuQ29EMlBvSThYUjRrMytjcDVIdmVhOUJ0NU9IVG1ySTc5U0EzN0lEc2hp?=
 =?utf-8?B?V2tsREU3Z1JqekdNblA1dVBjV1pEcUJ1bVV1VU5ESHFRTEV1SGFCd29LTW00?=
 =?utf-8?B?YTFscURGSm5xdWtmazFPMzdtc0pOZXVENXl1Ty9kcUVrVEtCVUxxYmZJOCtH?=
 =?utf-8?Q?nI+9y7bfzjVczoeyat7ybX7SW6Sscaxsi1kRXvUvJPvD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7b3b2c-368e-449a-93ed-08de2c31653a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:46:19.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv5BOR/f+96NGZmscxB3Zyt60PoeH+/HkvWYe2H/jseiCrsBoErCvZNWOWRnFb6N7cSlM3n/xgP5AIKp6j/10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

On Tue Nov 25, 2025 at 11:22 PM JST, Alice Ryhl wrote:
> On Tue, Nov 25, 2025 at 3:15=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> On Tue Nov 25, 2025 at 11:09 PM JST, Alexandre Courbot wrote:
>> > On Wed Nov 19, 2025 at 8:21 PM JST, Zhi Wang wrote:
>> > <snip>
>> >> -impl<const SIZE: usize> Io<SIZE> {
>> >> -    /// Converts an `IoRaw` into an `Io` instance, providing the acc=
essors to the MMIO mapping.
>> >> -    ///
>> >> -    /// # Safety
>> >> -    ///
>> >> -    /// Callers must ensure that `addr` is the start of a valid I/O =
mapped memory region of size
>> >> -    /// `maxsize`.
>> >> -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
>> >> -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
>> >> -        unsafe { &*core::ptr::from_ref(raw).cast() }
>> >> +/// Checks whether an access of type `U` at the given `offset`
>> >> +/// is valid within this region.
>> >> +#[inline]
>> >> +const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> >> +    let type_size =3D core::mem::size_of::<U>();
>> >> +    if let Some(end) =3D offset.checked_add(type_size) {
>> >> +        end <=3D size && offset % type_size =3D=3D 0
>> >> +    } else {
>> >> +        false
>> >>      }
>> >> +}
>> >> +
>> >> +/// Represents a region of I/O space of a fixed size.
>> >> +///
>> >> +/// Provides common helpers for offset validation and address
>> >> +/// calculation on top of a base address and maximum size.
>> >> +///
>> >> +pub trait Io {
>> >> +    /// Minimum usable size of this region.
>> >> +    const MIN_SIZE: usize;
>> >
>> > This associated constant should probably be part of `IoInfallible` -
>> > otherwise what value should it take if some type only implement
>> > `IoFallible`?
>> >
>> >>
>> >>      /// Returns the base address of this mapping.
>> >> -    #[inline]
>> >> -    pub fn addr(&self) -> usize {
>> >> -        self.0.addr()
>> >> -    }
>> >> +    fn addr(&self) -> usize;
>> >>
>> >>      /// Returns the maximum size of this mapping.
>> >> -    #[inline]
>> >> -    pub fn maxsize(&self) -> usize {
>> >> -        self.0.maxsize()
>> >> -    }
>> >> -
>> >> -    #[inline]
>> >> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> >> -        let type_size =3D core::mem::size_of::<U>();
>> >> -        if let Some(end) =3D offset.checked_add(type_size) {
>> >> -            end <=3D size && offset % type_size =3D=3D 0
>> >> -        } else {
>> >> -            false
>> >> -        }
>> >> -    }
>> >> +    fn maxsize(&self) -> usize;
>> >>
>> >> +    /// Returns the absolute I/O address for a given `offset`,
>> >> +    /// performing runtime bound checks.
>> >>      #[inline]
>> >>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>> >> -        if !Self::offset_valid::<U>(offset, self.maxsize()) {
>> >> +        if !offset_valid::<U>(offset, self.maxsize()) {
>> >>              return Err(EINVAL);
>> >>          }
>> >
>> > Similarly I cannot find any context where `maxsize` and `io_addr` are
>> > used outside of `IoFallible`, hinting that these should be part of thi=
s
>> > trait.
>> >
>> >>
>> >> @@ -239,50 +240,190 @@ fn io_addr<U>(&self, offset: usize) -> Result<=
usize> {
>> >>          self.addr().checked_add(offset).ok_or(EINVAL)
>> >>      }
>> >>
>> >> +    /// Returns the absolute I/O address for a given `offset`,
>> >> +    /// performing compile-time bound checks.
>> >>      #[inline]
>> >>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>> >> -        build_assert!(Self::offset_valid::<U>(offset, SIZE));
>> >> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
>> >>
>> >>          self.addr() + offset
>> >>      }
>> >
>> > ... and `io_addr_assert` is only used from `IoFallible`.
>> >
>> > So if my gut feeling is correct, we can disband `Io` entirely and only
>>
>> ... except that we can't due to `addr`, unless we find a better way to
>> provide this base. But even if we need to keep `Io`, the compile-time
>> and runtime members should be moved to their respective traits.
>
> If you have IoInfallible depend on IoFallible, then you can place
> `addr` on IoFallible.

Indeed. Maybe we could even make `IoInfallible` automatically
implemented, since it just needs to `unwrap_unchecked` the fallible
implementation if the range is valid.

> (And I still think you should rename IoFallible to Io and IoInfallible
> to IoKnownSize.)

Agreed, there are other reasons for I/O to fail than a bad index so this
should not be part of the name of these traits.

