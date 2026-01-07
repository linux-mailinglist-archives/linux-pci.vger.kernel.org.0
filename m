Return-Path: <linux-pci+bounces-44215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1BDCFF827
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DBFD30B50FA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F2345733;
	Wed,  7 Jan 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="okj9a3Ff";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XxK+MSko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7003369970;
	Wed,  7 Jan 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809955; cv=fail; b=kUCxzeqGHCJCXrk4RgRjKBCvEUh1Wd8PhvsdBAzEThP5oJJozAU9NwS9e46FT5kpzhaLAtMLuBTI+aovnbxUhmL7DeIzD41jlBTkRA7ByH/AKLPgmrqwZc+dtUZLQX+Vx3zuIjIBtvwgLWm6g3bXBfeAhM2BJ910g5N6VbjyUwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809955; c=relaxed/simple;
	bh=3kB+VmXxvML2ZgnrhIGI4EsfrMyt7XiUQfYbAZ+fjRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIXTVoPgvbYOIS+pFQWruDh34bLzGIo9VjepHYviI8KLJGpY4v2W/2nL4VwuYatFhaLruGPZylqlxOGy8AAToTfkswAhn698bjeCkcpZiLJdD7iBcFLSK9fe+e1YNK8ZuB0KlQfyWvXNBH0BvdKdBZa8vcQBSek8SACwn8CBg84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=okj9a3Ff; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XxK+MSko; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607Grd352482183;
	Wed, 7 Jan 2026 18:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3kB+VmXxvML2ZgnrhIGI4EsfrMyt7XiUQfYbAZ+fjRQ=; b=
	okj9a3FfnXVHx5/3ZQOwbwloaNhpZjyhIOsEoTfwX+JvpbMdgLRWjdTrGOsv2KaV
	v0ho9ULiWC/ZftTYRS7T7cN1mkz+0NAh2v++oaR+MhRwmbV0/IJkDN8/T68UAJUu
	C9d2Q0/Ppt/tgfsM7GKCM3cD6rEECG1QcpaWADW5e5settkOsOTDmpkn0dJQQG7P
	j9Wk4JrMHe/T7YE4J1g3B6zzBexZZWldRfUhAE6dYaNEivCDYyP4U6ZYWgA+UXQm
	hEixipT+zK3NS0XFlqCNvW6cer6Gq1p/MxijLPunSFFZcYFSXExG1W7H1WvZIGkD
	SgxtWCCd7k7f4TFo5Tr0dA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhudh84hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 18:18:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607GU5vx019956;
	Wed, 7 Jan 2026 18:18:28 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9wdk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 18:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ2+sIbyMBKw7CmfWLaAt3wpI0gcwNm1D2D2U4PQOJZAhOkcz5VknmuKmr0K+f0OOz/qRxmodfr+iZuNndZ4ApA8wK3e/RIinv0tizWIkb2zsh8eABA3TZA/a6Xsnxoema/ZrTKPp01rtzYHhrue1DkxHwAdWjHsz7gcNWb2Yded7Ubp2ae2Hx0fysAMltBWQFnqt+F+UTj3Tvce5n5AunXV4VD/DPnJQM13rLZBf3jGurATqAqVwR2r1+/mQLJPhqkdVNIM9W0QXnukkRkOl7VR1fjjpoyje54lloEXwBHfsLUvoiCKdywy4nnhZoFiV5xYW8XiKceooSyI4KNMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kB+VmXxvML2ZgnrhIGI4EsfrMyt7XiUQfYbAZ+fjRQ=;
 b=ZMmVhp44vY8Z6wVvT4wGDBUHYdDcNjIftBMFSqka0hDYu4XHBUj/ettmEBmhGIy0Cq2deZb6akkkZ4gsGcdsPfJqHkqcrV/R2oEjkRRKFnsm5BY5KMaDHvLEBRaoWCh6OC3FGj3g1iMDhqe+oQ3fRjEFDTmMggqopjCVsOODXBl9792xMAjga5q4+nJN3THPjBfuIVwfjBkt/ywGaQaYVyyXcpEfYE0xd0FuMIfiYuxGy27bPlxF02GEHRTlhKeCBO4PLstVHz1kuyfK4mPxX8vTvX5KVqR+3bZL/C50ixDXkfCIyxcSV+x98muUIEXan0MRX1qm72gYpkgyUaYRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kB+VmXxvML2ZgnrhIGI4EsfrMyt7XiUQfYbAZ+fjRQ=;
 b=XxK+MSkoxU16XDWrE/Acn7QWNt8Z83l9L3mEgVTj1WjdfBn7Y6R4EhiRfbS4PyCUa5/VofMuCQW8RHZVl9hqmYeA0ykJqWxL4OFtZx/GAzlC+WFMgBfP7XBUPtQtDHi6lNeP99X5Nuhm6x2TLNY1QdICMLBdK+5TUnL5ezvnDKk=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SJ5PPF1425E126A.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 18:18:05 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 18:18:04 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
Thread-Topic: [PATCH v2] PCI: Do not attempt to set ExtTag for VFs
Thread-Index: AQHcU7piSqDn1py/UkyQpwwZm9YksrUOGuYAgDlBhwA=
Date: Wed, 7 Jan 2026 18:18:04 +0000
Message-ID: <342E9A64-70B0-4BC6-B26E-4EA189C1BA6E@oracle.com>
References: <20251112095442.1913258-1-haakon.bugge@oracle.com>
 <99561464-1C66-4075-9963-C67F8C492E46@oracle.com>
In-Reply-To: <99561464-1C66-4075-9963-C67F8C492E46@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.200.81.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SJ5PPF1425E126A:EE_
x-ms-office365-filtering-correlation-id: e49dc3bc-c9d7-4383-ff9e-08de4e1919bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aU1qWkd5ZnlJbEVLNWhoNEsvZTdqT1NzeFV1WjEzeDllQmRyTXhEMHl0MDRU?=
 =?utf-8?B?Y3FVN3lYYS9YdVhudWpqNkl5enRiK01wanFRZ2RwZzYxRm9HODkyb0h4cWhB?=
 =?utf-8?B?SW9ETHg5SVIzS1FTYjkyc3BTUUhqcVEvNzBQdUY1VXcvOGpraEprZTlCT1VO?=
 =?utf-8?B?TUpyZlhwUjgwL3JEczRBVlJyMkI3UE96RUlDU0ppZGl4RU1ZS0lIUUZLNVQ3?=
 =?utf-8?B?dnJrZmhrVjRKTzBRak5XQzBpSXhHR1lSQUZRcW9sR0ZOT0NaWVVCNllGTEVz?=
 =?utf-8?B?TnM2SlNFQnpocDdxTkJJMGdZVHI3Q2J5TlFRT2xVZXVLc3BMNmxpelYrcmR1?=
 =?utf-8?B?bkFZU3dZcDVRZEpCOUU1MDg1U1dpcjNPY3N5WW5SdWVhQVV0M2RkY0l2UWgz?=
 =?utf-8?B?K1lUKzNCL1orbXdLNWlGdmVnWXo1b2N4eW9oa3ExUGQwNnB0TjN4NThqeVNN?=
 =?utf-8?B?TkE4TXk1cU9IM2lXM0VBR3BnbEdxSEpmeGR2bm9IVmRsb3k2by9oU3BmLzFW?=
 =?utf-8?B?M0p4aExtUkVSR2QvS3UwL1l6cmpkREdNcmM1cVN5cERvSklDeGpqK21tcm1K?=
 =?utf-8?B?c2ZvRlB6dTdwSnlWaTBFeWU3dTJ3QkFzUFZaa3dQRDl4OUk2ZTVzZkx1N0lx?=
 =?utf-8?B?VjVKZ0FQMjlmQXRpWjhvYkNaQTZUWGYvcFVUNHVpekZraisvZE5TZjF2bnRx?=
 =?utf-8?B?MVcvUGJsNDR4NzVIU1dBMlJqWnA2b1NSNHN2cmZDaUdjNUpROHdFZFNyOGw3?=
 =?utf-8?B?U0Ixb1ErK1k5cXJnUWF0MkRNWmVDWDlVdHd4QXNsaXZQN0hRNkRJbG9NTEZD?=
 =?utf-8?B?UUN1bVIyUUxaZEdFU3ZmQWdNNzI5WVcyZjY3OUxQYUNVSjlzRHdyU2xpVkpC?=
 =?utf-8?B?ZnR0MDFiQjJ5R3QwNHlucmE1VFFSejltSGtXSmhDNjY4Tm5LSVduZTFwZ2ho?=
 =?utf-8?B?ZjF6S1pFZ0N5MERlY0dOVFUyRDZZdTE3anpmNDRodVZ2T0ZxUmlKR2dja3Qy?=
 =?utf-8?B?TzdOSk9zd3VNRXhCRWtIeitBR2JkdzJmemgzdk1EejVEeS9LeFZrY1FrV3Jm?=
 =?utf-8?B?V0ZMcVNsTmhxNDNZU2RJajVnTlV2MisvV1VRTXpjMkdTSFhMRDFYR2ZHTjlB?=
 =?utf-8?B?MkloZTJKSWF4TmR3KzhBS2ROZ0NXZTd3UXRhdnBZTmtjM3M1Mng0WU16cTk5?=
 =?utf-8?B?TkhZd2ZVT1VQNmFFbG44TEw3VHROQTlLS3ZOTVZmeis2VVA3a2NwL3RILy9y?=
 =?utf-8?B?ekdJWE5tMEdtNkhPb29yd2xYSngySlhUR0xJTFArSDZ2T25BWnp2WWJDRE82?=
 =?utf-8?B?NW9MamZvQ1RuTW9Jd3Q3ZWx0QURsbnViVUM2dU8yMlArNEllUWZkdk1IVjdF?=
 =?utf-8?B?WG5NTFo4eDBqdEFlSkhDSXEyVGxOcWhxV3BqZGlBK3M3dElOZzljUXRVa0Qw?=
 =?utf-8?B?VkpCWkZKYmUrMVR0Z1ZLaXdZUVh4WTNkc0RIanM2dHZqSGNNd3AyUGlRZjkw?=
 =?utf-8?B?dEpYSklzMmdETjZGQm1WdGxEM3BBenBKcSs3WWdnMjZweDgrSFlTK1NQcDFm?=
 =?utf-8?B?YmNPRjFNSGxqZFpkQkFLNlUrU2Z5UU43SFVIdGhZbjRvT1BwdUZ3WkVZZVo1?=
 =?utf-8?B?K0s5M0JnR2hjRXBsdjZpWGNBNUdjMXdIYUZBbmY5bFlJQWhKelJKN1hmOTZp?=
 =?utf-8?B?Z2VHU1ZNeXRqazdIRGtuNjNjc1lqOUZQRktha3RRbXRjbjlGOGxjekRJNkdJ?=
 =?utf-8?B?bWIxZEV1K3BtWHpqNFNjMDhIeHVnQkJ0UTVaTUNkWnNBQ2xZZXdSZ08vcjVn?=
 =?utf-8?B?bGFCbC90M2x3cGFweHlHYmQ2THVMbys3STlZU3RPbjBWbTY1THBrN0pWL1oz?=
 =?utf-8?B?eUdiQ0QwQldidGxCTXJLRHJaUms2cHFRNXF2TitiWlA0SFY4dVdWRGV5YVR4?=
 =?utf-8?B?SFRIeDN2b3pMbjZ6Y1RwZkltanZ0WGk0VGtWeGUxUndJNnNVYlovWHZvUkZ1?=
 =?utf-8?B?MXUxV3RwQ3RLTE44dVBJYmFSdFFtbExSVVN6QnBqRTY4OHUvYzQvY2Z2MFhl?=
 =?utf-8?Q?qqh0Em?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWRtemkwRmpSZWY4alZIT2Mya04xYTB6UWVTeFczN2FYeURjK0NTdTNrSlJo?=
 =?utf-8?B?aERNNWFZNG54VlEyM2FlOWZpeGNPMzJPR0hUdmVXREFON0QzSzc1Q0xvaEF0?=
 =?utf-8?B?SVI4REkrVzFRSnVsbGV2dFFVclFkMXBMQndMZ0c1SldNcnNkdkk3amVSY3I2?=
 =?utf-8?B?WHlRT1dReUUzOVd6ZVpZS05hSUllSktsazZlclkySFRrSVVVQTllOEM2OXJ5?=
 =?utf-8?B?b2xDR3N5andHVDZXbmROcGlXbEdMSW9zS0U5WTJXZG83aFNYQlpya2RSUk02?=
 =?utf-8?B?L3AyRTUrUnR1U2hqaERHaXQ0SEtLdkJhSEVDOFlxR1YyMUgzRlVhclhqRWFv?=
 =?utf-8?B?Nm5RYm1zNHRjQU1BdzZmSW91UVpNSFM1T0wycGtKQWJEcGZNZWFCVzl6b1VK?=
 =?utf-8?B?Z3orZ1c4R0plYklWUklUeXZhN2hsRHMxTzJacGgrb0d3NThneDVGYkJyK0N5?=
 =?utf-8?B?cFpocFpab1l4Y3hBbVpHbkJDKy84ZFU3NUVRRjZLanhiMjJmOG0vWUN5QUJK?=
 =?utf-8?B?aHhSdWNBOExZWTd2eUl2OTFWd1IzaXZMRVlsNlE2QWFMdWpCQkpJcG5ZNXg0?=
 =?utf-8?B?YTNyWXFNclZlV25hVXJEdElicEpJaHF4N2dqRG42eFRaRXpjckU2SEpXTkI2?=
 =?utf-8?B?YWFiUXVoRkZRNDBFaFBKc3VuR3JScW5TRUlhbGpFQ2VaaVVKYmJFUDUvWFBo?=
 =?utf-8?B?ampYOVF4QmRyQ1Fobi9yeWNjcGVUUDJDelZibkQvL2t1OHREOHJZT0Foa01t?=
 =?utf-8?B?MnBTU3VnSkRzcUt4czR4RWlHV0FsSU9CQTBHOUhUbGJ3aUFJZ1RUbnAwTlRT?=
 =?utf-8?B?VWlZVkJNdUZVd3pKbFZ3MmxESjhtZmJXbmtNUEhTdWxTRnlKelNWeENWelBt?=
 =?utf-8?B?cWdSb2JrWmZMSzE5WGRKQ2FBbUtzZFFJTXBLdTkvYXNpOW1FbUFpQUIyaUQ3?=
 =?utf-8?B?TURyc2pha0kyMGJwcm4wK1dQSThqNERQdkRqSllhdzV6ZDNnVEI4amdnUDQ3?=
 =?utf-8?B?ZGxLZmVFeitobW5vbEFqdTBYc0I5d3MraDNWb1VWbkZYYUlHbXhmdlFHOFM5?=
 =?utf-8?B?WXRxSDBhTkk4akNhc0xndWxUQlp4YmQyMURLRkphbXY1bHJkMWYzczBNcnFq?=
 =?utf-8?B?ajdWNUhCYVUyT3d1UlR5R3Rra3VhcDhHai83emRpYmdDbVIvbk4vK1V6Q1F5?=
 =?utf-8?B?SXE2S0R6NCtmaUIwWFJSVkM1MGRtR2J3RHNvM01rR282YkZXRWp4OTMya1FF?=
 =?utf-8?B?MFNSRnZFT3BXM1BIYisycUtDQ0tISHhac2QxWDBramxCVmtIc1puYzEzdCtz?=
 =?utf-8?B?bmppcG11QWM2SHhlS2w5ckFHT3R4RkF5OURhcVk2ZklVdmxZZ2JMdXZSNXJq?=
 =?utf-8?B?eW5PTmlpNFp5ZlZGaXV6dDhKY0FTZ1ZWOTJFTy9HelpZajlicTlMRTZnSXAy?=
 =?utf-8?B?Wkw2NFR5Z2tQU29uaFoxUVZ4dmwxenFuV2FWZzVsRTBRSjB1K2kwS2txdXRy?=
 =?utf-8?B?S1d1UGw3WmozZmhHWjQwZ05RZUd4RlIxL2F3Q3VWOFhWcTJTWm9lV2p5UWFl?=
 =?utf-8?B?dmowdDk0dHh4SVFleDBhLzgybHpmMUtjb09rWmZDOFRzZXdLTHBMSzlwL0hk?=
 =?utf-8?B?Vk5XeEhINEtzbEV4UlcvT3B4bXdxYTBNaHBxeEUwS2xSUlZhU0hNYnhPRi9I?=
 =?utf-8?B?TDhZalhmWldTei9ZSTc0RVVFWDhPRHdOdUdKYkp3Yjk4Y296RDZCNUJkTzJB?=
 =?utf-8?B?clZZcEpjcndZYTdzYTJhVHMvdWtldnJKM2hVRHIrZmx1Sk9uRmhLdElGVjZj?=
 =?utf-8?B?R1hrcmJ0RTQ3QWVvTWpIV0NHUStJUXp4aFBJRmhoOUpSQ25LNTRYdUhNbEx5?=
 =?utf-8?B?Z3kwSGpyR0FzNGNlU203WHlOczdDUTFYOGd2Uy8xTVdYaXR6dmtKT1ZaVzBw?=
 =?utf-8?B?TGNCSGZEa09uckNucGl5V2lrUG5lNVRpSVYwY2tORmgxaVlnemd0bUVrdU5N?=
 =?utf-8?B?S1BSeDArTzhTeXpvazg1V0d3NlV5YWgySnlqMmhib0t6L20zTXZVOUR6d201?=
 =?utf-8?B?NFRiaTNTRzJQR0xUNXliNTQ0K2dTVFRCaHRudVhacnBnWHp0UG1ONUczZEdi?=
 =?utf-8?B?bzNCcm5zY0pXWkx4QUxWS2x4OCtmS0s1Zmd5OE1HOXpMZXBEcTNiYUNJVG5u?=
 =?utf-8?B?TlJBaW5QeXhzZ0dLNnBPRXowTXdjVlorK2s3MW0xWWxuWW5sRThMYXQxbUpE?=
 =?utf-8?B?eHdyam40eFZnVzR3YVBpM0h4aktaTXVweHR5ZVdwdkg0WmY4d2Foc2NDcVBC?=
 =?utf-8?B?RUNlVGYxa29vUU1yOXQ3TFBCSjhmcXlHZDlqSWt1ZUJFcGtUanZUKy9uNEM0?=
 =?utf-8?Q?O/TRGOhkgn2wdS4k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F4D5349D0FC1E46A360442EE545BD7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jrceWnNPQUBBqwCw0WQe9dSBn7eiB94//8cdXURii45EBY1XHEIuPrG069/WR8TQM1dbzIPc1rq4Y2BTl8/20SmxyZxZpE2HkmEpbJW/k6d5EQRXzu1D2O9bVK4nBb2X0Ds0G2jybyNVXpslsgWwyzm9I5BXl/yXPcToo7+hP8T9gI+bbVq5dicnAwDvz1Gb9VN6Kf03ursYLxHXb2zrKctOHpue0WMNAoGTuA4GxP0sQuRBdpBWPBm4Ius0HHZAwyUw/fHGd27XGDzA7vw4dUmtlS6k+B5K9VjV+SeCvm+7qV6OBqSFv4DqJfIEx+TfoY/45qYPXvUSgIsA71Tdp4hrPBCTf9zMMIjBv3NyndtbllSyGJ0Rv71SOj1F41DZwxASQiIQ6oHp8wcrtKI2eEsgWBo8Ss5TouTQ6k6AXucE7qXeXLcjrY3HED5hvnYtfk+BIXvxKUIrD3faktvf1dI3p2d5hOHL+dTWmWRPxOpNxFEYJc1TRLEol08GoGFUpE+nrTTJ7s4McuP29eNHLQp3ySATNOsMWIayvUeQcp0OYs+WqQRo4Mbge8x/wtrydoBvVsWdt+wEwh3QcJ5buD/5VFA0hbSbLz+Cn9AXSmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49dc3bc-c9d7-4383-ff9e-08de4e1919bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 18:18:04.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuQxE+rZy9gDS73UhuJRrCfyw7LDh7qyai2PfIB5Dy57Lp+yPA9E2AEso2tLsBJ8xzhUf5dTsHfku2O9zQM++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1425E126A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NCBTYWx0ZWRfX77oIZzNdeMAu
 EuZNpOBmFBsEnIc5nXX/5ZvL1XgkVriXOz9Yd0BZFMXLrU0WskhU8FuNxcCZDdMgyh+m4uDc8Qu
 8ojJ/wLQ6qKNUvFnmkN/oPInJzRe1xFKVP0p362uRCa+5kQhRQy4/jmCWO9guQeVT8oX7577sgA
 PjsDDoVTKJduz9n+Kp+nZoAjrOBGr/WnCgAzJ4l6RCwu2sWir00q9Z5Jyt4ZOjJpSyzW9XqaPos
 a3FkQ00UGRC4mJGBKxAA3MF3IxSMu0DQTsazSjll9LmpQT7LWbXvBzPTBhu3tv5cO9FjiMprmg7
 FXcy/zPOx6kc4odri7UdwRv54pbQHcEhpJndiWMNiDDLsT8nYBFacMWDZsofDKiVmVzi/YVsFDJ
 XaqsVpEY49JUOOkoL8xN+qhj7uqLG0ZWXGOU3B5ajrs8W/zpVMdibm6QhKidT6RQ+SCR2Orgv3f
 ND/l5qH2ciopgJC3Qkw==
X-Authority-Analysis: v=2.4 cv=Xv33+FF9 c=1 sm=1 tr=0 ts=695ea374 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=JDLutmzGqgvO0IVpaY0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JrOKle0JgMxVoaADYfczgZ82w-q-kk2h
X-Proofpoint-GUID: JrOKle0JgMxVoaADYfczgZ82w-q-kk2h

Pj4gDQo+PiANCj4+IE9uIDEyIE5vdiAyMDI1LCBhdCAxMDo1NCwgSMOla29uIEJ1Z2dlIDxIYWFr
b24uQnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiANCj4+IFRoZSBiaXQgZm9yIGVuYWJsaW5n
IGV4dGVuZGVkIHRhZ3MgaXMgUmVzZXJ2ZWQgYW5kIFByZXNlcnZlZCAoUnN2ZFApDQo+PiBmb3Ig
VkZzLCBhY2NvcmRpbmcgdG8gUENJZSByNy4wIHNlY3Rpb24gNy41LjMuNCB0YWJsZSA3LjIxLiAg
SGVuY2UsDQo+PiBiYWlsIG91dCBlYXJseSBmcm9tIHBjaV9jb25maWd1cmVfZXh0ZW5kZWRfdGFn
cygpIGlmIHRoZSBkZXZpY2UgaXMgYQ0KPj4gVkYuDQo+PiANCj4+IE90aGVyd2lzZSwgd2UgbWF5
IHNlZSBpbmNvcnJlY3QgbG9nIG1lc3NhZ2VzIHN1Y2ggYXM6DQo+PiANCj4+ICBrZXJuZWw6IHBj
aSAwMDAwOmFmOjAwLjI6IGVuYWJsaW5nIEV4dGVuZGVkIFRhZ3MNCj4+IA0KPj4gKGFmOjAwLjIg
aXMgYSBWRikNCj4+IA0KPj4gRml4ZXM6IDYwZGIzYTRkOGNjOSAoIlBDSTogRW5hYmxlIFBDSWUg
RXh0ZW5kZWQgVGFncyBpZiBzdXBwb3J0ZWQiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1
Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gDQo+IEEgZ2VudGxlIHBpbmcgb24gdGhp
cyBvbmUuDQoNCk9uY2UgbW9yZS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo+IA0KPiANCj4gVGh4
cywgSMOla29uDQo+IA0KPiANCj4+IC0tLQ0KPj4gDQo+PiB2MSAtPiB2MjogQWRkZWQgcmVmIHRv
IFBDSWUgc3BlYw0KPj4gLS0tDQo+PiBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgMyArKy0NCj4+IDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+PiBp
bmRleCAwY2U5OGUxOGI1YTg3Li4wMTQwMTdlMTViY2M4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9wY2kvcHJvYmUuYw0KPj4gKysrIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KPj4gQEAgLTIyNDQs
NyArMjI0NCw4IEBAIGludCBwY2lfY29uZmlndXJlX2V4dGVuZGVkX3RhZ3Moc3RydWN0IHBjaV9k
ZXYgKmRldiwgdm9pZCAqaWduKQ0KPj4gdTE2IGN0bDsNCj4+IGludCByZXQ7DQo+PiANCj4+IC0g
aWYgKCFwY2lfaXNfcGNpZShkZXYpKQ0KPj4gKyAvKiBQQ0lfRVhQX0RFVkNUTF9FWFRfVEFHIGlz
IFJzdmRQIGluIFZGcyAqLw0KPj4gKyBpZiAoIXBjaV9pc19wY2llKGRldikgfHwgZGV2LT5pc192
aXJ0Zm4pDQo+PiByZXR1cm4gMDsNCj4+IA0KPj4gcmV0ID0gcGNpZV9jYXBhYmlsaXR5X3JlYWRf
ZHdvcmQoZGV2LCBQQ0lfRVhQX0RFVkNBUCwgJmNhcCk7DQo+PiAtLQ0KPj4gMi40My41DQo=

