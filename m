Return-Path: <linux-pci+bounces-25674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4DBA85C89
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978374A4F7A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2329C35E;
	Fri, 11 Apr 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sijDeJsG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686729B212;
	Fri, 11 Apr 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373399; cv=fail; b=PXV1JlBngz4oOTA30XnXkBLsJkcQTdWtScF4hbYa3x9QTrotySzy7Wcs1NOE4tHdN9dgW1bFIMo0rA/EuTKq3hPLLxf1NOIl4GHBQvoQQ+n2GENb7EKtUcI6otArHSdrhNWjV7e7m1VoFHBXTf9vvb7WN5Z2mKdn/hQ0XVWmvjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373399; c=relaxed/simple;
	bh=+1yPtfd+fYVprjWyy7y5OK+5OFgZjL/lmf4HR9VvR+c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lD45NGJlDxs6cWRnOeAXLmWPUZ9n/15Xlli+tNlaBuS4KQVSlEG4wOVgVzrM8QLjykByculzcM/k+fzGbCWae7iQUoKYaJzZHfdlR8LBwd1OJlHvbnGUh06JgyTOZIE0TadPIg7MVJez7eTeXyh1PXR1gNSAlWiSJUYNbPjx/wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sijDeJsG; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5D9WyYW/8CXaRVQWgxTncYuvPX6xgk2VkiJP7SScOaLjYAX2m79qXaKJKeyz++xNwNhuHor4GbcOUS0Ob2rzUjVh3I2Nnz+91F//Aa6gvayYe0RosA648If1x7q3Lnxi2wvST+Gd8pxpaGnqWN/rAOVnADYuHEYPe+OEQM6ocCLxvPXoUOn+xzspFCnF2hFheFUI+rsn9SHVm8q4/nA4unqhYGZqsW5icn6ROeJcnvRvkv9XnUGJtjuiI/6OvC97HGDJptalEVsvPBVJZ8rRUeqpyMpvw2m49M5dnOtXKU1haCbAi0HqBUYkCPojr92hYvxKC+yuHLQ1RvMBpnCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wxIsB8ul3nfT06DIfZcvjI8Z5atlCWQs3C79YegTeo=;
 b=ypg/ylVLm7lmQJFLmIClgbFysHft4IHeOGZHS257RU8uADIegQWWZLJwDqGHHYh1KYyM49IsD8dIEBc8VxnKYUh1LV6cLr9ymHqrlWOtDr8BM36FuPiZGnpMRS+tqkCthgf8wPyJhxX/Pnk5prekb+fPtVv5Ngr07B6fUDaDTvFopzWmgcA8nGWraN6fKjOlRHU+oENHF3KrPQTYa13xbEbNw7tLR4/ayKZ8je1d3f6ysamkhGC7jXUT/modJxzJu1E+0Eg33jgRQdd/jG3heIyK1e7vi1XMxWKzXOSJWyuY43sMl58xrLfyy6Tgi3pTBEta7I/Gh1y3nmNKLBAkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wxIsB8ul3nfT06DIfZcvjI8Z5atlCWQs3C79YegTeo=;
 b=sijDeJsGJU95dcAjo2OFi6sU+Th1RlSOQN9jFGpK7zW775GedPsRJv8fzUZSfW7IgX3nSK9EnSF0jlnDontv6xZImSS+w27OFhhVWFYwpisw0iz8qqN1oCrj5fIMjYXgASLjexvdXDKiKr3pl/uTlfipzVnhrTphQjdLpu/4EaFOKS6hwY0dujW/AtZOYwVCWuH0yS/ZVgmfD1QQbtneZTgzWpYHEvjloq+DljOshdErM6JPoJSRHB9d5WBrXfZ48xVSemElC7H4UqrwknkOKFXMi4ISNGT+pnw4Uzph1LSkgxQC3rN+T2VXPHczBJzgNONYeGQ1LKaV0p4asJSQCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 12:09:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 12:09:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 11 Apr 2025 21:09:39 +0900
Subject: [PATCH v4 2/2] samples: rust: convert PCI rust sample driver to
 use try_access_with()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-try_with-v4-2-f470ac79e2e2@nvidia.com>
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
In-Reply-To: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: OS7PR01CA0238.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3902da-4242-49dd-dd51-08dd78f1c464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXNyaEoyenAyWEdXTzVvbzNTYUd0b2l4cURUNFN1S0tlWDJHZXk1ZncvbUxl?=
 =?utf-8?B?QXJPZmZ6WUduaUdzQjhOTDNBMWRSQVRYSHBuMjBCR3prUFZoeFNEcmR0RU1Z?=
 =?utf-8?B?c2JmdkJ5OENNR3BNQ21xdTk3UHpOZjJ0bWhxcCtmNmlnWVo2am1PNENqWUFt?=
 =?utf-8?B?ZTlYZEU0Nnl2Ly81TW5UOGMyV2pQZmRneGVKMW5lN092UC94ZmJRSWxzWUE2?=
 =?utf-8?B?NWpiMXk2QzFNK3dVZGgyZ0RQcGRBVWt6NnltaDBDYVoxN25PYlQzdDl0MVVM?=
 =?utf-8?B?WDR4RDh3T01KSS9wdFRaUGFyRy9GK1RWWU1KYkV2YWhZckkzRktEdmUzdWZh?=
 =?utf-8?B?RDltWFJ0dXN2SXJqRFN4ZTIySmhpTDkwODhFaVY2bTVHZDlnOWcvOEVDUUFV?=
 =?utf-8?B?cENtNEo3ODVEQWVla3FURFd3dFVhaWRhSWhncDBrUVdxL2VHYnUyTjdqK2N0?=
 =?utf-8?B?WXFWd0M5aVZySVZxbUUzNHFiSWxlczl6MTVyNFJXSDlaWFhQS1VLU2ZuRlIw?=
 =?utf-8?B?YTJOMFZSRGdYMWJta25sMGNsTm1oRGJkY0JxaUxwZnA0amZPb083UHpsM2RU?=
 =?utf-8?B?bGZXMjRQU3d2OXlsSHFzdFJNQk8vU1QvN0FyQk1sR24xUXpRRVdneXI4UXoz?=
 =?utf-8?B?LzczaWVDbkU3QkxKZWU2dXRLeEVjR3J3dGVqbHB6ajdkUFpMdllua1lIYXA2?=
 =?utf-8?B?ZmFYMWdGNEZRSE01Z0NrN3d6a2ZIYnAxVk15Qld1M0xidE1KS21icVVoK24y?=
 =?utf-8?B?cFRwblNxY1BTOFFNUXIxdnpOZHhIUkZHVTd4d2JiODZzenBBTk05cWNIYU1r?=
 =?utf-8?B?L05mUVF0UHcvTXNtdm51NDJnYW0rcWpMdk9UNUFHUXNrK0phd055VWVIeWs4?=
 =?utf-8?B?U0MzdkZPWlhDWk1DK3JZUngvak9tVFhpVzNrOW5LYzZwUXkvZ3hjRnlKVi90?=
 =?utf-8?B?TlhRZDhIR3ZNc1MwbGxyWUJtOWRvdExKcHJXRlpxb0RrV3FzMFJwSlBwTzlj?=
 =?utf-8?B?VmMyWTlyVTBNVm9ZWTFUajB1aTc2ZE5rK0RWWXJjQzZBQUxBblZ4dklUM3NO?=
 =?utf-8?B?bTlmTlZ3OUEzQjFnUXFpR3cwKzhUL0hpQUhWY3dQN2pnb1RYY21HSk9TOXA5?=
 =?utf-8?B?QmRSZExHdUhaMDBuL2syWHVicWRjUDRlS3dMSStlajZsa0NJMno2Ty9wWjRL?=
 =?utf-8?B?b0pkM2Q1b05oOWNCcnVkWmIrZ0VXdXFwTnRWQkgyWDF2Z1JnNSs4ZkdKQm5q?=
 =?utf-8?B?WFJsUG13NWp2QjZKaXFkZGE2bWIxTk9TdWlEYVRmSmljYnBtOFhrNm0rKzhT?=
 =?utf-8?B?dHZRRThRRE1pNFRKQWQrQkZ6REhzY1psOGhVRWdVRGtreWFnRHFqVktTWWtH?=
 =?utf-8?B?N2ViS3ZVVEdIWS8vd3gvbjdNdEhUNjgyVlZRbUg2ZEZjaHlMUzVqTkJtSmJB?=
 =?utf-8?B?N2l3YmdvSUluSnYxUjJOZ1R0aVBsaTYvOEF0anNaK0lXNG9zKzVqcVQxM3VM?=
 =?utf-8?B?cDhScE9rOXhXeitNbnN5VllBYllwNlZnQ0xTMzV2NUV0dGRmTFphZXFXZzZh?=
 =?utf-8?B?MDBabUtCRGRoK0dGbW9ENzRJak1GZ0NONHNnSkxzclFlZm5nWWZPcXNjaTVp?=
 =?utf-8?B?bTMyVzdVaUE2TGFMUHJFYUdnY2c2MG1FNW51b0JGVlpQcDRWemloSVpRdU0x?=
 =?utf-8?B?c2xNdExVNVZaOU5SLzRhMHZOTXhiZkVudS94NEQ3WHhvakYwb1ZkQm5TMkJJ?=
 =?utf-8?B?WXlFMm93VnNIWFh4VGtDbGt5Z2ExNC9EN2Z3OURyZjcrMThPNE5sNjdQK0pW?=
 =?utf-8?B?c2NNZW94RXZXVXlaUnpzSVpjanFxRUlVVVRERzNWUzB0aVp4YVVEUEltVlIr?=
 =?utf-8?B?SXRZRklVcVpvYWhXRVo4RW52dllXOS9CNHJjbjZpdEs3YzlJbi9OVWNYSHBR?=
 =?utf-8?B?SFhzOXpaSkpua0xqYVBkY0JtYzNlQkUrR1RVMXMrRkJpUFh0S3l6NFI1K2NE?=
 =?utf-8?B?Y0lRZU4zQzRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cndUTW40aEtZM2dUbjR5Y0dhNVNJUjE2V01ycWRNM2VoQ3h1QU8vVXZhNlM2?=
 =?utf-8?B?OWlBSTE1V3UwNHl4VmdNVi9wQjh0UTlTMHZDdGtBeW40YWppaXBwWDVJa3lt?=
 =?utf-8?B?VXo3VzZRNXVVdEtkayt4L0Z1L2JIVU1LeHNqSkpKcWVtdTVRUUhZZE5yRkZa?=
 =?utf-8?B?ZDREc2hPTitlajZJc0Y3Wm9UMWRibnFnZWt0ZVk1S0luS1ZpYVZZQ3YxekxV?=
 =?utf-8?B?ZHNza0NyTjd1RGgvVHBEQXYrSk54ZEhlbHc4eGc4Z01ydHBoYXZ3Wm5DdGtK?=
 =?utf-8?B?T1RySlBBaDBLdHJIOG5HRUdTVGRsK2VzQWRqdWJBTFM2b2cwU0RWbjB6TSt2?=
 =?utf-8?B?R2Y3VTdYSHFYMWljWElzblJWcnB4VlF0ZUlhM2Q3b29mTkJXSWt0K0oxbkE1?=
 =?utf-8?B?VlpuT09XbjNoTVNJbEFEK3l6NjZrYzNOQ1NEdFRRR1JlZG9kZzZycHFXdmJN?=
 =?utf-8?B?RHhrTDZBNlhteWNERTBRMkJlYkdoT05rYUlEanhaM1ZRbUdrV3NYRitJSEhH?=
 =?utf-8?B?UnV5TEY2MkFhakJ2NVZkc0FXSllRWFAxT0o2Yk1rSE9XWldoTFNXMjdwZnJO?=
 =?utf-8?B?UnA4aU02Sk5uS2VIWjBCMGhJVzZIcFRxK093bDJmVDVIUmF0aGNzTkFtVENB?=
 =?utf-8?B?TzNwY1hydGhWSTV4Z2dLdTM4cWxNTWRIa1JSa2hqL0VTMnVmUkhjVklKd3V2?=
 =?utf-8?B?Rm5qSXM3RFVvN1J1V3IvMHpoOVVta09jcTVwSE9COExZbDVQNU9YdWIwY3ha?=
 =?utf-8?B?NEFrOWFWd1J3enlxczRScHlQZTQzOVh6ZStQZ1Q2eHRSSDZiZ2x5YWZrR1pa?=
 =?utf-8?B?QUgvRGM3eUZscUtIdGZCdElXN1Q3T2hhOWlscFg4d3phazN3blJWVHluc3g3?=
 =?utf-8?B?c2llVTJZbGo5MGM0SkRhRWk2Q1dlZEcxNkpRTCsvL3NmM09tM29lSVUzM011?=
 =?utf-8?B?NFU4K29pN1ZKWlcwdkQyemJuWXN0djhlVDJMWjhoT0lIdGVScHEyTUlFUVpp?=
 =?utf-8?B?ZnQwZzF4RldldUFBSlM3MGoreVR2VFZjcUtORTFPVkllb1UzRWFkbUxITkxi?=
 =?utf-8?B?WUoxYVlvRlg4cXltRmpTK2UrQWhyK1RvTUpvQ204UnQyYm5XRTc0T0hwSWVL?=
 =?utf-8?B?QWovS2R3ZUhGb29RMkNvVFgvYTVKbXpmNGU1VWZMZHBZeE9WTmtzQnFNOFVU?=
 =?utf-8?B?Ym1KRm8yaWpsSnh5elQ3Vno1V01GYXFXeWpuam1KUW5FVGVjYVZGY285NDBL?=
 =?utf-8?B?VWowdm9oWWJPMmZEcFJBcmlYM0hZR011d3FrK3BWMWJoWmtNMTBMTURId1lt?=
 =?utf-8?B?MHZZSklNd0FnR1V2MklEbzFub0lnbG5KSTVCa1g2QS9tSFhveXVJcUU2S0o5?=
 =?utf-8?B?Z3lWOHRielJUQ0FnNHNyakptSkRiZnRLUW1EUFRCdDhxZFpCWk44NmxNVnBQ?=
 =?utf-8?B?T2FLUjBMTlFOMnpobG5FZVR5WWtsV0dDMHBHMUNSa0Z6ZlNMeXdXN2hiN3dQ?=
 =?utf-8?B?bE0yT3NNMlJFbUtoRUdUVm5kazh6OTlXczZjeUFua0ZWYVFyMG1SWWYxT3FP?=
 =?utf-8?B?WE4wNVdwSUVndjV6NEdNaTZTeXRHNXdUV0VKelIrUFBmTmxGRGdHckxBVnFP?=
 =?utf-8?B?aWpRNHBPdEM4bWxCUFVldEZ6Ni9YanlzNFhsT3M2MG5pNm1MblpnSlNKRGFE?=
 =?utf-8?B?UVI1MXM1NEtHWGN0blVjRlU1WEFiU1ZtNUM2dXFXRHVsSXVBOGZVWGRpYWpP?=
 =?utf-8?B?Y25lT2tzNkJxRUpxVTNkd2FQR0dYMTM2d1I1cHFUWTlzYTFTUk1MSXpkZ250?=
 =?utf-8?B?RlA2OTNuNkczd0JpU1VjUEtrazdQMGd4V1lvNjlwdDBMeHFDUFNOK3FRSkFm?=
 =?utf-8?B?V0RZalNJS0t1L3RrOTA4alQ0TzNkS3BmR1pyeDNJRmtTVWwrQ3drVENwRnFq?=
 =?utf-8?B?R3g4cTVGTGRBSWc4Y1pBOXFCblcxcmtYNXVVK3NZYnJXSWxNVHkzWWZVeUYx?=
 =?utf-8?B?Tm1mcU4rN1lwb0ZVU1ZIWUJIeWdrRERBd3YycjRxOWZ5MVM1M0I0ZWFUcVNV?=
 =?utf-8?B?ekI4TnA0T1BxaFI2ZWpNbU01OWxnelNoRWkvRGgxb3VZblVZLy9jeXRqYUJN?=
 =?utf-8?B?S0tmNE9oY2hjQXNOeWo2UzBlc3hRMU9TNnd0OTZtNk5DWkNMMWJUVHRkeDJO?=
 =?utf-8?Q?jNBNnzC+vMCiWpg25IthqNIS9duGHAP5WO7JwSQuTR/m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3902da-4242-49dd-dd51-08dd78f1c464
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:09:53.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zm8+tZlrQ+2ZsIOjYA/aLOElgFdsluepdzmwn+KpykQZuCilhMiuKDmOvn4RXCjyLSCQzfD0xgruQbHS0STgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877

This method limits the scope of the revocable guard and is considered
safer to use for most cases, so let's showcase it here.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2bb260aebc9eae24db431238d7d7b48fbad788b4..9ce3a7323a1632e08f833a14c3f49a4218e9a5e6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -83,13 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
             GFP_KERNEL,
         )?;
 
-        let bar = drvdata.bar.try_access().ok_or(ENXIO)?;
+        let res = drvdata
+            .bar
+            .try_access_with(|b| Self::testdev(info, b))
+            .ok_or(ENXIO)??;
 
-        dev_info!(
-            pdev.as_ref(),
-            "pci-testdev data-match count: {}\n",
-            Self::testdev(info, &bar)?
-        );
+        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
 
         Ok(drvdata.into())
     }

-- 
2.49.0


