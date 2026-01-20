Return-Path: <linux-pci+bounces-45294-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMioCLXFb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45294-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:13:09 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE84933F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77BECA43904
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C87426EC8;
	Tue, 20 Jan 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SBOHKrQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5F426D36;
	Tue, 20 Jan 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930529; cv=fail; b=sgsmXi+h4GqToQG8R5w/869i1/xAyq7WLFdiyLgLbGJZsb+/ogO6bhzqla9VJbz6I3PKoIELWUlYzHlnaK8vvUB7Mdnw3YQ4+jaZ9Moj7sBepvOT2YtfVEPlitGMENzxQd4hPfau5XcyIniB6fCGt89TgMtskyORfKKFkrN7FxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930529; c=relaxed/simple;
	bh=dmI8k2lFcICCQRvy4uPvLQAyKJGX0Cu5ZoYDBJ0r2QI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VWZ+TPOvUdAUhEv226r5vNaDe4Ef7pEwJ1orETPq+dROYt8dGRNuE2/TF1GSBPu6+8NdioR22xbJF4BpguagE+qOMRJm9MFsD2uTqK4auew5GuZBbvLzWchGbPRTQc17GMHxsPxIaskSgXiROVCIlHmALpJOb2ZBhr7GTHQUkjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SBOHKrQd; arc=fail smtp.client-ip=52.101.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrzih5HOzS4IVzWMZ11OHANVjBbv5A0ChVp21uIf04MU3rxE9QAZJ+/D95fTC/mpaGnLdordAiZYORrUfdIKr3fmHiALRUgDrr7/oENlCDSUr4RIQrQyO9WtjNxUw+xznNLFY4omp5tHRcQKLvKO4yCRwfTUqA4MgI8VUD0hud4TczSEeTRRQ3w7CGkw6RFcCy2O2+oy1FMxhwYSp+6X8FjnAAN/AhJNloI6aZdaFZQIHVU7UY1nSK3YgMpQ8FvMYsZ1qads2sOjLsfHn+842eh72EK4lV1EEbtEBqklPhqNoqv/Ad+v7cUkypKaExIL6XJ1Wydq3Y72R4BZnyfWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOWxScbR7xbvKwpp7QFQ9Fi4jfNgY861fR9bHEoATDI=;
 b=zK/tjCnvMAetq9bJ+9dYkbaSPVln2/hPzuHGjng6qFs70TKye48+xaqj7q0DsmkOJT6+AncQSOzt/SICQkYfyIqKHKTk1Sxc+W3I1O/JMAW24PeNfUo+VePsNTeDZZkRF0SJSNOsK9Z08EVoFYvEHW6DUvOTN7N4e20QG7JR1QQ+81oA28cCHMguYO07PFCyriG9T8Kax9ZvWLnZEEeEbcnjvJJhuPkg+e4feHlArzI7mLRQhdXyDuUnJXQ+B0zGgjDaoYmLI1JIh2gADtDGfR59pw47Z718KXCfdpizt5t/JJpcjTF1Mjn+Nz5Ha798BaX/m2OpzHU/JOG3EQtXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOWxScbR7xbvKwpp7QFQ9Fi4jfNgY861fR9bHEoATDI=;
 b=SBOHKrQdlnjERUIKmS4g3JGHT88t+tq97auZc3sDhulw+Wrg4rASnOddg2xrsL/8Gjmpkq1A1H4EJHROY7gWR1husLbyVCn5isER8MsVOrxJLfp1NFofPhamV56dZ7ZPrGQx1ME74COaffceSTlH/c4vj/4oQscSbMyPgjSRi5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5455.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 17:35:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 17:35:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 17:35:24 +0000
Message-Id: <DFTLJCC9IJW2.2UMF3Z6AF6K4W@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com> <aW83HV4lVR5MQlDd@google.com>
 <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
 <20260120192654.014ba848.zhiw@nvidia.com>
In-Reply-To: <20260120192654.014ba848.zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfa9ea9-916e-4459-b78f-08de584a4b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWs3TnMrNmdyVThuU05uZlhsQjNBYkh0dHVvZHJQRk1sb0lFNWZJdEQzK2Np?=
 =?utf-8?B?bXVTbzBLMVZpczZmTkRjS2ZGdzc5U1hJRGFGajI1cGw0eUdGNkFkTlhJODJX?=
 =?utf-8?B?aElFS1lsaVdQQXdsYTJDaklzOGZqclNtVUFtSm9PcVc5Q2JrMno5ZW5nUWlw?=
 =?utf-8?B?TnZOR1BSUGc2V3o5dzlwU3YzN0cxbDZXTGdzSmtYdi9HSGh5TTJ2NVFpblhV?=
 =?utf-8?B?UVpSMVZOWmdHUytGZDEvUTNJWUlCd0QvNThveFpjOHJ3d2FVT3dPc29kT3VN?=
 =?utf-8?B?Mnk3M0p3VGo1UjQ0QUlEMEU4eVBPUmorYmZSNENCaHlWV1lUTGpiS0szZUFk?=
 =?utf-8?B?UFJnUVNQZ2NsMEJCdXFRQnVtalhUa21ETi95U3d6cWgrRWJIQ09LdzRsRlI1?=
 =?utf-8?B?SENzdTBDSGRUTGN3NlhydmJtQXhjRFVqczB4VUFKaGF6a1pxSitpbGpiZkZC?=
 =?utf-8?B?aHdaS2FOWHdZNXNmYWw4d2ZsTkJrdFVLOGRXdUptS3AvODJJZENuRVkyZkxT?=
 =?utf-8?B?MXZSMVRnTWk5SloxcmtJNSswbkFudTRNTmFPZ1hCT1Z1UEZvYVptNUoveFdw?=
 =?utf-8?B?T1NwSStxQW5IejFvYmJPZTV1VlR0N1JYaS9xbU85dDNYZ3d0U0lMNW82MXM5?=
 =?utf-8?B?UXI1OXJacjl6QTJmNHplYVh1NmhQRmttSWIyMzNjUzU4M085ZEtxT0NyMDJm?=
 =?utf-8?B?VG9YZnNrSVA0WmEzM1loaXIrUTBhT2dTOTBNK0dwRko3TUlFdElVZUdJWU1G?=
 =?utf-8?B?c01TY2R6cng5SkVGNWJPVWdNMFo4RE9xNDRZSEJjQWpNY3hnQ3ovMXVxbXpE?=
 =?utf-8?B?MUgwaUFxTVFvVHRKM0JLSmtacURUWU1KUVhmcXYxejRVdUJja0pWeVdsa1Za?=
 =?utf-8?B?TnBlalhiUXlUZUpGY1ZNd0tWQmdkMjZDeHFOSjA4M3JrcEJPQzdPcFM2TG9Y?=
 =?utf-8?B?Z0pDaGg0M1gyYXJZODlza2dJbVQrYTFrSllSL0tRM1VLd3BjMnZzQnBmT25J?=
 =?utf-8?B?b0k0YXk5QytXdDlIWnNYc3hNVUZGQkNWTHdHYmlkbWh0WlNtVnRQeE1xQ2RJ?=
 =?utf-8?B?b1E2SWxhTFZtc1lJam5xbUlrYWo5RVgweTZyQ0VKaDZxZ1FwYXVmVkpSM0JX?=
 =?utf-8?B?MDR0VXRubzcxVkhTWUJDbGZ3RDhpQ1g3MVo4VVB6YkovTEc3SnQ4QWZweVRI?=
 =?utf-8?B?TWZuRGhjYXZVVVBUMXNLYUFwL01NbVRHdWR0d3MzWGV4bmhMSVpObEo1YURP?=
 =?utf-8?B?RGkrNXcwdkk2QytwNGNFZForUmJoYml2eTNnR3JPRWtPSlY2YVJrQy9jN09F?=
 =?utf-8?B?WERoVkgrM3VEWFV6Q3oyUGEvYmx3cFdaZStoNG04Y1lpYXRUZXB6R3cwMlRk?=
 =?utf-8?B?MzhRaTJYMy9QSHJyWWFmQytDYWhtVmM4d1BZbmdueUl0MGpxKzR6U1JlZ2or?=
 =?utf-8?B?NjB5Z3FBclMwZ05kNW1vVzJnTzFvTzI0cENYanF4RFdmTEVsQUZkUEtGaUQ2?=
 =?utf-8?B?ejR3R3MxQndTWk5mVzk2QmlYdFR6OXNCLzJQU29kbW5Rekw0QXhrazZwNkVm?=
 =?utf-8?B?K2laM3BSN2lveFNXaExQMnNkTUIxT283VzJJRlFHNVZRQ0RMa1Bnais1WVh2?=
 =?utf-8?B?UXh1MHMwNUxhakoxTnNjL05rR3lKemRrLzdvQmE4eDRReEp1V2txcG5kZGt0?=
 =?utf-8?B?QUZPMGdreHZsMXEvaG1aVE5QWnBtNURYZmN6NG9tTWZZdmlENjU5YktHUzJy?=
 =?utf-8?B?Y2szWlY4c1lmQ2NtM2xpM2lkcGhXd2ZEZ2tYMk5ZMENYbGRTbjRFSG5jVWpq?=
 =?utf-8?B?UXlObGFBYkpQUFlIdDdNNDFqblBoRlRpUWtIVTFVVTJSbkVEeHNlbit2N1hz?=
 =?utf-8?B?anUvTmpBMWVBREVMWTgvcHdWZkJJbFpkV3RMaWRpM3BISG5MVHZGTDRYUUV4?=
 =?utf-8?B?WEV1WU1zZ3VMZGJnYWc5MlBWbTFiMlhsdytjSFVTSGROdlJRWFJ0SmxCQUtR?=
 =?utf-8?B?dVdZT1hqc2V5dEtvR25weWkwbHgrYlZWcWRNT0NMeVVOT2puc3o4bVMvaUxj?=
 =?utf-8?B?dmpBWFh1b2hrdHBpU1VoVkdxNExvZ1d6RnBNUExEYnFpNWFDb0t0bzRPOVlD?=
 =?utf-8?Q?NSpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJGTHI0ZG5hZVIvQXRjRjNyOUN2Vm5ESjJ1OVZWcGdOc2k1SUx2N3BESEho?=
 =?utf-8?B?NU5kbFNaclRweWtrc3dDRGJTa3NESE5zSGdPeDNjekt2WEZ4N2RtUFlMTS9S?=
 =?utf-8?B?RDNFVmJJMzF5cmhMeCtTZW1JaGVhRGRDa2tuRnBPRUJmdHdPTjl0cWphZ0xs?=
 =?utf-8?B?Z05LTGJqbXcwM0pxYVZ0anQ5VHM2OGZzSUI2UkZrZE1pSVNUZjFaMzdDWUJB?=
 =?utf-8?B?dGFySlpVNzlhUjdsS0xkY000TEFOUXFETW82ck5pZVhLbW93dHkzTm4wMW5I?=
 =?utf-8?B?eGFObll1ZjdUSWR4N0NYOVIxMEQwZmNOa2hxQTZOZ2dkVjlzbGt6VUFxQmhB?=
 =?utf-8?B?UUVLVWM4K3JIM04vK2ZRb2oyOFVRRTZRb3BCL0JmcWRPTmpMdXJuaVBDSUFL?=
 =?utf-8?B?ekRvaFdBdzIvbHF0MldVd1VwNUpQdGd0eGVrMmw3bzBLZ1dlc3o3Qk9YQXh2?=
 =?utf-8?B?NUx4Q09hSGpPcENlQW9CSGhhb2gxZmtocVY5T1E2RUxDbHNyRmk5aHlad2dj?=
 =?utf-8?B?U2Q3d0Y4LzZRSEl0eEtEV0FaY1g3YlRCQXF2YnpteTZDZ0RaalhUSFRzc0l5?=
 =?utf-8?B?MnRwWkpWeVRBdGtaNE1pT2tRSDVlbEVDaXhmVXdXb1BmTXpHeWpiM1dYR3Nl?=
 =?utf-8?B?aXZwcm92T3ExckVCcU4wTVpDaHh2VzJZRWJLdmlMMk9qTnQ3V3RuMFo4eWlt?=
 =?utf-8?B?ZjRJNnhrVDBicHVkR3A5US9Hd2tGSlRMbEk5UTVzV2hJR1BmdGtyeG5UcUh6?=
 =?utf-8?B?TUUySEFBMVZ4MmtaMlNzb1J4WGUwL3AwY3NsY2k2VXltMGFRN3NBa0RYQzlt?=
 =?utf-8?B?MGIwSjdrUWQ0RW1aeHNOTEp0aURHOVdLcHdDWkpTMDc5WTRQZUJxajhMU0R0?=
 =?utf-8?B?QmtvRWFycXA3Q09WSmtJaTRZZ0R1aXBvd3dqMXpmNFhQamkza0E2dkVxQVh1?=
 =?utf-8?B?ODJNT0ZZYjJWY0JNZGp2bHhJNFZHeWMrakJjYUw2NUhtVC9CMk1jcG9iaUxJ?=
 =?utf-8?B?a2daRU1VNHlUb014R1VNYzl0SWZqaHA1UzhET2NnOUp4OVJBKzJLcUJqVlFG?=
 =?utf-8?B?dkFwemhYOU1rZWlXUWhrc3RPMEJ6S2krKzA3bHJuUWQ2ZHZIVGtubTlSc0JJ?=
 =?utf-8?B?cmVrYmtYVTRFMmVpYmRsZDh0TEJ6SGxya0srOTMzcEQ5LzlQOHJJTG1uQ1pn?=
 =?utf-8?B?TjMwNDJQbHNpSWpQSlJlckR4TDUzeW4rbklaVVgwTTJtRXZGcUJBTkUzT3hJ?=
 =?utf-8?B?emhNUEIwbnlGdmZTMG5RVFZSbHhDSmE1bnFuVWIrV2E1Ti9NbFpodWowREtR?=
 =?utf-8?B?d095SmxHSUMxNVFOUlJOb0NFWTJlQUl5ZTc4T25VQWVIU2F0ZkkzYnRkNFhz?=
 =?utf-8?B?ZHRCWEwxY0srRHAycmVhSEdzRUp2NmVBT2hBYlpzQitlRVhMbU0yZ256MTZU?=
 =?utf-8?B?dEh2MldmcjNyQzhzKzJpYzdhT3dlbFVPdjYzNmhYWEUzNVBrSVpBa2dNSjBJ?=
 =?utf-8?B?ellCRk9NcDFJdlZncGFIRlFpeUxQUElwRmJFYmN6WmJ3WHpwUHhaQi9IeU9Q?=
 =?utf-8?B?Z0h0Zmt4VHppZWxlbUFUWTd2MDhyazVLTWdEdWE3b1VIYmJ3UU8yM1pZbS9W?=
 =?utf-8?B?QWZBeW9BSzdsdVFYcDM0N3hUYjVoeFRjMUNZNWRVL1pNVklZeEhZMWFIelRM?=
 =?utf-8?B?QllzU3hhRDRPMC96SE90NE9pcjdTRTc3OUZZVmtVUVY4K0gxblRKeDZtRHdn?=
 =?utf-8?B?am1xcGxBZVZFRkVnSDkweklUSzkzU2daalA4T09GU281QlRRcS9WM3JsVFBS?=
 =?utf-8?B?cHRwQS8yK3dBZUhNcU5qUmFLZ1ZFeExqTVRqS1h1aXJ6ZzNMdzMwa3FZVjdJ?=
 =?utf-8?B?UytJUmVVWDcvYW83WExzd0JNb1k5QlViS3F4NFlzRVRWNjBuVmdVVS8yNnAw?=
 =?utf-8?B?MktzbjAzR1lYeWJZdElIMFpmeVhDeENBZktJc3QraHlqSUtCbUJ5NlNNZCtC?=
 =?utf-8?B?U2JsMXhhWHVuak9LMUo2K3lCOHBFRHNxVjVNQ3RVMHlVMXFwQ2pDdTVxdjUy?=
 =?utf-8?B?M0hqRjFFQVJKdjJvR1JaSnRDb28vVGZUYzZzWjBSd2p1VzJxTEVYSW9iZGox?=
 =?utf-8?B?Sk56c2pGandwN0w1ajFoWSs0ZDR3dmxFNnVpREQ1aGowbEVsby9nbm5PMVJI?=
 =?utf-8?B?am92RnVSWVhwTzNWV2MvdUJtL0VaSlpIbTcvcVhGQ2VkTzhBdFFFMmc1d1Zt?=
 =?utf-8?B?Tkg4aStYZHEyeVFCcGlLNFA0SFRKWWhvZTY4V1N1RXo2WlhteVdkRFFVSVo4?=
 =?utf-8?B?NzIyWXozRzNFT2s3MUlENTVXRjloSkREUWRlLzZSOVNEbVFpQlViQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa9ea9-916e-4459-b78f-08de584a4b82
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:35:25.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4kdrPg77ndTAx3pCweNDRi1ogO67Cs6Lepz2WtjQEOuoFB9ig2vHogHB3EQG9gBd1pG+p27yzs/XLr8JhPQEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5455
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45294-lists,linux-pci=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,posteo.de,nvidia.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 96FE84933F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 5:26 PM GMT, Zhi Wang wrote:
> On Tue, 20 Jan 2026 11:12:18 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
> Hey folks:
>
> Thanks for the comments and RBs! Agreed. I will adopt this approach in
> v11: using a single series of IoCapable<T> traits and retaining
> IoKnownSize.

Thanks a lot for doing all of this.

Best,
Gary


>
> Z.
>
>> On Tue Jan 20, 2026 at 9:04 AM CET, Alice Ryhl wrote:
>> > On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
>> > Overall looks good to me. Some comments below:
>> >
>> > I still think it would make sense to have `IoCapable<T>:
>> > IoTryCapable<T>`, but it's not a big deal.
>>=20
>> I think with this approach it's not necessary to have this requirement.
>> In practice, most impls will have both, but I think it's a good thing
>> that we don't have to have an impl even if not used by any driver, i.e.
>> it helps avoiding dead code.
>>=20
>> >> +    /// Infallible 64-bit read with compile-time bounds check.
>> >> +    #[cfg(CONFIG_64BIT)]
>> >> +    fn read64(&self, offset: usize) -> u64
>> >> +    #[cfg(CONFIG_64BIT)]
>> >> +    fn try_read64(&self, offset: usize) -> Result<u64>
>> >
>> > These don't really need cfg(CONFIG_64BIT). You can place that cfg on
>> > impl blocks of IoCapable<u64>.
>>=20
>> If you agree with the above, I can fix this up when applying the series.


