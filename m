Return-Path: <linux-pci+bounces-44612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B10CCD196D0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30AD8301A21F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFA928853E;
	Tue, 13 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mcz+HeJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749D284662;
	Tue, 13 Jan 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314321; cv=fail; b=SZqDFqiFZ5yGiM+EXE9WWkTFqu7xT4prxfXrNoz841CqTidazGN3JSYsalW9xw4BO+wYz1hxvAq7IP72/Sbl8PrkbPmHmGk8Gj6KXMpWFR/mI08YSjCvDOWGE5rwu+6rBs5fRlf5nNwgskIdJtz4arC+ocCchjWkbECNQj3j/iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314321; c=relaxed/simple;
	bh=DpVTdKX9eEeTrJbdNmAamuoUpQEH+LtSRJ488m7IjUo=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=reYsFKpEgiLrYd5E3zR+5PF8WGKbn5FbxV/c9/TzBNFWiraChiztgQDohc09Mt4Jxu0I8Fl27za/BiHpCTx98uOcFHf1gNKvR0io9KULp3qZO+9EreJX8HptSU1ybAp48UHeRD8s2/eIV39GhKBOEIMC7cx96yDoSgZEtvZs3Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mcz+HeJm; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFXoZgRKDk8Q3oWIjPG7WW1JT60XPgVPFSCxjx+ch5X1mUQC9l3EiFboenfDaaocBrh/DtasHkOY1smFGcmz/zpRbR8oxy5OSuYfWaB6QnCwXSSHDEgth4kzeDcVPYHI984B3N/LVvyXqTC5lYHZvhp+0jLuq6m/E0bjaVW6MpXenSEB3XmsKxE2taZUOGVctfdbA4kOs23DSGFfnyh1o5FuPM6HOtA+kXkRsVm2Srs5nr8o7gI3hPz8tlG6AJZqGIXBJBFf9phDMYN231SilaY7MdiZioJFonW0IED48HzPfPwvpo/sAwuu3Cf/mxTKNpFxFkYr5X1wGHFEIIjQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfQ4aM19Oyhtafo2RdZHkgc0GcVeRiw/4cDV/FJypxY=;
 b=vCNHUWnB72r/shl7gEZYA3st+0dPSDafvONrtA4FzOU7xZ/STPT3jYxWxr6oarEcNaeVmncEp7UIFGsiwvj+Xk7PkwWcVXphp3X5yK84qEumolOfp2HvSOPO7zFUSX3SoApQgH2jNv4s86PnCMBBoctP2wRFSjqexQI87BUS6TTTn94fgc8+NIf4G07zICts0iJyMvVGvK9mpzwYXMsm9rt8gLYFLYTDBBBbEfmAN7QSWkr9Es2X2EvZH7w5pfMXmzuMoJbIwNreuq97aAr9Mg0OzxROrZYjrMs05LZ7+xPRmMRduzBxdc+vTE5vQHVK5wvExaXvuJ44OT6BYEC/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfQ4aM19Oyhtafo2RdZHkgc0GcVeRiw/4cDV/FJypxY=;
 b=mcz+HeJm3bI4/83x2hr16Zh3fED8g1niuCizpfy0BmukKWc0oQGWfNQKAR9lMIijTFiOircYz0Zs98zEpTxrbKHxEM+hEV9gAkK+RM6OsryRTSERgW7iOtzDGmVEOAYKvLfQZIK9psdduXD5efNTW+V37NYUxH66ytti8LgPvfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 14:25:16 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 14:25:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 14:25:14 +0000
Message-Id: <DFNJ3XN9ZGEC.1BS235XP021OQ@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v8 1/5] rust: devres: style for imports
X-Mailer: aerc 0.21.0
References: <20260113092253.220346-1-zhiw@nvidia.com>
 <20260113092253.220346-2-zhiw@nvidia.com>
In-Reply-To: <20260113092253.220346-2-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0203.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e40a230-b8a0-4657-01fb-08de52af9225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEw1K1lFOEJUeWV1dTQ4RTl2K1RibjQvZU9MWWJ1eEUyQ2ZXMnVEV3JJeGdx?=
 =?utf-8?B?a215VWpIZ1FzR1BwY1NKN2NRUUtSNXZQN1p5b2xUWGUxbGQ5eEtiMThVaWx2?=
 =?utf-8?B?a2srVmJienA3RUVoeUx4ZnMxVUFqcExzUmNNU1R4VUJac2Rzb0hQOE1LSVBn?=
 =?utf-8?B?ZFByczJDQnY1Skw5YW03c3R1bFFidDdFeG9uTXhVSWhxNmVpVGZicHkxNTM2?=
 =?utf-8?B?UnZTeTBIcHlmRlBFa1lRazJ0N3dZSk5TL0xwb0xUU0p6NnVidHNmTlNSYktB?=
 =?utf-8?B?SkFwTEpnM1Q1Tkg2N0ozTldiNnN5c3RDMWNFcTd2TTJIMFpIRWlkQnlyMWdu?=
 =?utf-8?B?ck8rM2lGVDdEL0g5MzRnVytGVEVpR2o4b2U1Z1h5WlVsSlRJcnY1S2VFQnJC?=
 =?utf-8?B?QTVIRlBSUTh3ZFRNM29tbGNpOXdPa1BXZ3RQWndoWmdhTFVEbm5VTFlvY1dK?=
 =?utf-8?B?dHVXMFcwN01tQncxeEViVHROSkl5aUh2aS9Kakd0WUJsQktnSmJrZTBPUkpS?=
 =?utf-8?B?M3BYUjFEOU0vb0tsanlZWjMzaGg3RGk0Y3FJamFOd0Y0M2VXeWthRENvdGtk?=
 =?utf-8?B?TEo0bkN4a1RKbnJqdGRyS0l5bjlIMnY4SnJBbExWaW9jT3YrbjRRZ1hjMXZS?=
 =?utf-8?B?UHY0TUM2S0V1Q2JzT0NhTXBDMFJTRGJST1BaMlRqM0oyaXFVT1Bqcll6Q3J2?=
 =?utf-8?B?bnNDSGFzeVJTT0lYMEE0VUhndXlJUjBod0xzSThpWjVSWDRIdDFxMFRUOVFW?=
 =?utf-8?B?YkV0ZERuaHVPTVNTbFMwWTJVdkJXc2dQZ1pFWmFEdDlrU3A3VGpBQmhvTEhQ?=
 =?utf-8?B?YTJkZys3QUk2YVFMbXdsa3JmY0h0elRzOVpaQlNVSHRnMGwzMUdPMmVLSXIw?=
 =?utf-8?B?N2lDenIzYmkzOGFRZlNRanFySVlVb0NmMUpQSzRkMmR1U0pVNUNqNFlzTlpM?=
 =?utf-8?B?TmxkN2ZhTUNqY096aUNMSFNNdTRYNDg2NVlKWXVSRHBTSy93SGdTOXdGOGk1?=
 =?utf-8?B?TGg5Wld1ckdZNnB2c1BnRkdZYTFsYURXNkpmcUIxc2dybnk1WVlCelpKSk1O?=
 =?utf-8?B?VWpkc0FzOElhMVVNT0phNzR1cTBWV2FETCszQlJ4anBnelE2b0pmYUN0QndP?=
 =?utf-8?B?RUZ1VTQyU0FicDUzV25EZWwrRVdDdlNYblVEMFhka1FWcEIzVWRJZE1NL2U3?=
 =?utf-8?B?d3pYeS9UVVRTNXIwVHFRZld3dkRNT2d1dEZJYnV0TWkwN1dMYW54L2FsT0h1?=
 =?utf-8?B?eVZFUXhUMHZiVDZWb1l2N09oYWhESWNWK1dzbnBkbGxuTkczQkdVV2dKRFg1?=
 =?utf-8?B?ZzRzMDNWNGlCK01QZ2owU1FlVHBScGpBa1B1eHl2eXMxa01yRjk5eHl1N001?=
 =?utf-8?B?Wmd6eENVdERQSGdscHg0NDJGVnB5WjF1SC9JenROMGtJbEQySXFKWURHWitm?=
 =?utf-8?B?UzhxTzc3RVRKSHRoYVVQN2Z6WnV5U1RIQkp0dTkySjZHTEFpQWhWVHRleFE2?=
 =?utf-8?B?S3lrN0hwOFZXUE5WazR6aEZOZFdZRnowYkFnY0FtUDRrSXJDalVXYlJzVW1j?=
 =?utf-8?B?Rk1ZN2l2NllTVHpxWDFWZGhuVzNqbmVUazhCbWZYL1hUYlJKMzlzMGJiM1dG?=
 =?utf-8?B?TFVFRmlhZ094UmE3OHovQUhYb3BQTUVMVjVZdHRtaUNhUGhHTWNhSHhSK2RP?=
 =?utf-8?B?ZTBXdVoraG9OVjVNUGpOY0tGemZBMDFmSTRkMUNtWGFySTZZeUh0ZmRPdUhR?=
 =?utf-8?B?SHEzVmVCL0VPVEoxbU01bmpQNnZrN01wWmlaelNNNEJ4OHc5WVd6R0hKZHh2?=
 =?utf-8?B?aURhSTMvQThQK0hGbTNCZkVtNXNmek42Ny9waDhBVTBQSlNveStpbk56d1Fs?=
 =?utf-8?B?VlZWY09CeFkvV2xRVTVIcGtoYzErT3R3eHNXN2svWEx5MUlNRGNpYmpETHR3?=
 =?utf-8?Q?fw817hjDwPt/g2gtF1wh+3DwvJ00y78r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUdMc3p1TDhTK2xmMHZuM2lMZDJNZzFZZHRRQnc5cUo5YlVLQjVvajFPOWpa?=
 =?utf-8?B?NzA2SjczM05MUkticHFOWHluWnpFNlZHT2Q1QldEcjE4REREb2JXcTg4Nnp2?=
 =?utf-8?B?NHN2YUg4dTJCbjdlYjdYSk53L0Q2ejN3MytCMUx4Qk1IdHptR2xNUDc2Z2I2?=
 =?utf-8?B?dTdNaTNLZ2xhaFNScWdzaDBaTjFKakF3d1Bib20wNzBzdDhqRms1a0wyVDFr?=
 =?utf-8?B?OFlOOGwxVUZmT0xRY3JORjRuN1l5ZUJhOUthZTczN0NvRFB1ZEsxV0w0ZytQ?=
 =?utf-8?B?N1hpRmhCM3JpNmhNQWJBLzlRTEoxVTdJQmhIZ3lJTzh6N2hvVjJjM0hKSjBU?=
 =?utf-8?B?MVc1amE2elZhd0ZjSURuWnl1UmJmVGtmdWFPMFc1bGhuVFp4Mktqc2ZYamdl?=
 =?utf-8?B?QUhSdWljUGNENW9HTHJFK0FVSjM3aU5VMDUrYW1OOTJSZ1dUUjdPRFBUeFFD?=
 =?utf-8?B?alpYenVKTlFvendIUXYxTWYwOFNSeW55cTk1dWNkVWYwTFZLU3pDRVQwYnZv?=
 =?utf-8?B?a2FOSDIwcTFTYmJDS055K0RDRUhIaWJQN3ZBRmtSdXlZNmhyNHF4d3Jma1kv?=
 =?utf-8?B?RzlpbWpsWEo2WGtlRW14MWhwMENqa3FmeVptbkFiajJPK2VIcTgwdTZ0T2dq?=
 =?utf-8?B?QktoM01uSk5tNEZkdHl0dGU0RHNHRWhDN2cyMEFlRnRzVkJndW9mSm9wNmRs?=
 =?utf-8?B?WnM2SjAzZld1cHdOQ1p2VWtVaTBTdUg4ZnlsRzdGZlZoRFI1cjdabWpLYVFS?=
 =?utf-8?B?Qlh6TW5hcWZQbkNOVXpSU1BWZ0ZOM240eDQrNzkxbDdJMXNZOVI5bkFqSVgw?=
 =?utf-8?B?dytTNXhoVGE0RlIwb1I0OHVXWUJQa2NDRUg0bDZYenJLeWVkMzBPK21MWUJ0?=
 =?utf-8?B?QlQ1cmhoeEZQbTdGUzROZUJRTnJmOHdjQjdHcy9NZHZPQVBLV0FDM0VBUmY1?=
 =?utf-8?B?bVdJSFlYeVM5UjRhWFBOMlF3QzZnTWNEVS95TTdXVExneENVWUtTMmpNY0RL?=
 =?utf-8?B?WExuRmlNbFN2dytiQjdlblBlZjRXWGMza29SMmdXNVhVdTVwMitOZnhuckpk?=
 =?utf-8?B?YTZzRnM5NDZyb1JSK3U5bFhkUis5QmJUSjB1ekpRYnN0SGFPWTZnTG5Ic2xj?=
 =?utf-8?B?QmRJNGRPQTludVdKWitCYnVRK0lHb21KQ08vOTF1RjRUd2VvSnZEY3Z2WGlH?=
 =?utf-8?B?R2tVdmpscVJYZHRZOGNpWU9TRTVwRDVQN2g2cklOankyR052RUdXcUZKZFFm?=
 =?utf-8?B?dkNjaEswQ1Q0VXpJT0d1VnZ4U3Rra2NFajV3d2hkOHQxV3RiTzB3L3cyWm9K?=
 =?utf-8?B?MmdoZFVlcmpYMzZEaHFPbHA5OTg1MEw1ZUwrMUticmZYSEJYU0tKN1BSVU5R?=
 =?utf-8?B?UlUwOXFsVWgvbWZ5U0tmNUV3TzRzY2xRRWJ5RlBkOUxDNGpQMzBoR0FIalNI?=
 =?utf-8?B?cVNTdGhQNGZud0VIVEJZbWd0R1hZY1czS2RHWGR5Z1JtOC9jSlRhb1BzU2tR?=
 =?utf-8?B?M2NsbkNGdWt6T3B3MDJOcEhoNHMwRllYSWhoZHl3MGN0bWdESEtQQmZDaTc4?=
 =?utf-8?B?dE5lZTN3ZlRvY1RWQmI2MVluYnViTmpNVjBoZmlHcTRwWnJzZnRJdDZnRERr?=
 =?utf-8?B?OWRBdGhWSHNXVkxlQm1FRWNtczlwd2hnS3dNeFVIYkFQVEIyMmljN3hpRERV?=
 =?utf-8?B?YzdrRnRCSjhnZkZBNXZjQUFZekhlVGtXU3NxRzQyZnVKbVpnSjZML1hMeW1n?=
 =?utf-8?B?T3dWb1JSTUFZZXV1WkhHQUZaUGRFZ1pLc1hmMDVvR0FVU2lieWlHcGp4dVYv?=
 =?utf-8?B?blhSTzNWZUxhU2JZZkgxTWtUWVVvU1NsZ3pTT05lTzNrSG5rVmRnRGZCaG9Q?=
 =?utf-8?B?ZjRKTEdnTDB5NGF0WEQyajFKaHRHYzVmKzlRaDNFTmx3ZVVNc3JkRmRZRDFl?=
 =?utf-8?B?d3RUc0dnTHBpc3U5eVdxMmVjK1JDT1dXVHJ0YmM0a0EyK0dmMHFlRnVlRkYx?=
 =?utf-8?B?M1V0ci9pZ0hsUjlhVU8wSlJmYmxVVFJhUUtCTk1samlxYVFTeWptRFQ4Wm4r?=
 =?utf-8?B?dThTSUFKQTRFOHhuQ3J5UGJpR254eFFyNk1jMGVPT3ZheTVON3M3RE9XQW5R?=
 =?utf-8?B?MHBmeXJ5T2F6Sk9MOUYrckVDeUZHMmFPbGcrdEdVK2krMkw1dTk2eWM0aXdh?=
 =?utf-8?B?Z3lZTnRwRjR1b2pqSEJsNTdqbURtTncrdmM0L0dxWlg3SzZWZHBrZ2JndzFL?=
 =?utf-8?B?dDV1ZzBra3FXcVBoblFBNlN4TnVLZm5sVGw4dG4rdmtzMFdWeGpxOGdrYk9j?=
 =?utf-8?B?RHhBbTVUbFlLcmNGSWxPeE1BMlJCZUZncCs2UkVWdkY2WUtQRzNaZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e40a230-b8a0-4657-01fb-08de52af9225
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:25:15.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4d75fRFc3g0asBnrj1bs2qoNYCpil50MTVjQWAhCnVFFxqUYLI4VTOgKIjlEWgK1JUyVmYIhBxJwAKn4+sWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5360

On Tue Jan 13, 2026 at 9:22 AM GMT, Zhi Wang wrote:
> Convert all imports in the devres to use "kernel vertical" style. Drop
> unnecessary imports covered by prelude::*.

There doesn't appear to be any dropped import?

Best,
Gary

>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/devres.rs | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index db02f8b1788d..43089511bf76 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
>      /// # Examples
>      ///
>      /// ```no_run
> -    /// # #![cfg(CONFIG_PCI)]
> -    /// # use kernel::{device::Core, devres::Devres, pci};
> +    /// #![cfg(CONFIG_PCI)]
> +    /// use kernel::{
> +    ///     device::Core,
> +    ///     devres::Devres,
> +    ///     pci, //
> +    /// };
>      ///
>      /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x=
4>>) -> Result {
>      ///     let bar =3D devres.access(dev.as_ref())?;
> @@ -358,7 +362,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P)=
 -> Result
>  /// # Examples
>  ///
>  /// ```no_run
> -/// use kernel::{device::{Bound, Device}, devres};
> +/// use kernel::{
> +///     device::{
> +///         Bound,
> +///         Device, //
> +///     },
> +///     devres, //
> +/// };
>  ///
>  /// /// Registration of e.g. a class device, IRQ, etc.
>  /// struct Registration;


