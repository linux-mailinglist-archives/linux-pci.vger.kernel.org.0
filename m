Return-Path: <linux-pci+bounces-35801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA2B51498
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF14E3FDD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8131691F;
	Wed, 10 Sep 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I9vIzSfp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF23148CE
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501750; cv=fail; b=APkuIRpdk7e5F7n+I1ozh1EKVcZjnqHDN5yO+T/p7iUTnkiO7f/NYPTdhpWNOKWij0n0GStyo77Q1r2VXLm07YVCQnh5huVLBpuMXasCaDKmJ4NsEGMzX/O/GrjNKB3Uy0ZjthTgtDeq5+osJ5s4KFKyKT89zqiX58RTV4b03aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501750; c=relaxed/simple;
	bh=UhXKBlKThsgFPr61MOOZpxQm4W0p7Z6J/lXPLFMqp2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=juSX6KSMaQNOuNoeeKLvHAAFbPjIIDwwtf/PSQW27dypQ2g0Pxc9NFykuGO/x5lY3GHDxjJHokMZYtpRoi30HLZ7tLDYAeJZ0MYUWhphrnlyhen8hco9p086EB7fSH6nFpcyFvp3X9/oQtT6KxkzMLf/xknKyDTry2xfCP4koec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I9vIzSfp; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZSgObGsbPOXpYY4slW71kbFpgSZh0GroSbcWIWPlYpATPEjgu9l3QZcmorIq0sqbYk3uOYsgmJgQnqmeQR1ZqIHctoJTXHg9qzqlCSHB3I1qyh2sFQOfN8fiPh+rvgdkhOuQZzBo7+0C/fWg3LaBondfFouY9YKXc0yMhEjUuLSfzPr0lza63W2zH6CMlnCeTCJVqcQT93T8URTegQ0ebWQPnAA2264hePMXWYO9s/Rn+c4Pkfo5L0WGfuEUJAczSshsqwFdUGb99fbDT3Fh+R/F93DtR23fe83joJGOrPGGHizMmCGrP22mtjSTv89qlRdARMgCetARr7OGfEVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biqi5TU4P04kvRUxPETQkIqxMG4J3kXFkZYj5fdxJeQ=;
 b=DaajbngryVjVoYANOnK6BbzSdwoyrWHvMQLqiEu7OF0Nk3AAqmwLHpuApQmWqA7t7lbvCIu0AFe8C8LRTBFpDn8xzvJdatPtil28+0QV7iPRsv/magSLKcPl3OQ1D16N5ZPx1i95s1ORNAcUJpfNneRrhrHWkvbtE18wiytEfXLiWBt1Hj/ARaKH8bw/31Cmn5F4wbDdH2lQs3na74iJwTIuhoQqI0tHFlPJkyArOKmlQzrj7mwNNbAHDIUkvKj2uDPaFevYmTnCsUEPC+/7xVTxb58V1TB2dFH1P7Tx+ZEBrDZUsv31KJWzx+w1T0z51roWG4O44T2wKBpQQkIyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biqi5TU4P04kvRUxPETQkIqxMG4J3kXFkZYj5fdxJeQ=;
 b=I9vIzSfpctBVRTlygrSx+6Vm5R1zfkeiVXQZrFMwRBJWYY4Zoyt/CNizgqYsiBrv0IcwnYQU0tXuAVHN0lh82GWpct9hJlyIG3pLHI+/Sm2XQl4bnfnnk8Tfw23h1f5+pO9tIo8RK/fe31eUPnp0+GeMUOM28kzcaI003Q3reO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:55:45 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 10:55:44 +0000
Message-ID: <47a21e9e-5749-40bd-8207-efccc747e7e5@amd.com>
Date: Wed, 10 Sep 2025 20:55:37 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
 <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
 <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
 <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
 <68bf77c923ff4_75e31005a@dwillia2-mobl4.notmuch>
 <c920fde0-0241-4ca2-a75f-384f6f18a255@amd.com>
 <68bf886bc9271_75db10029@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68bf886bc9271_75db10029@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c55cce-4b95-4d22-47c3-08ddf058975f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFc2dUtkZ0VUUnVhL25SK0pGcEQ3b2NGbzlBaFBmSXdLKzlJNXNoYWR3T2dn?=
 =?utf-8?B?VkF2WUQ3MU83V3dNcTRtd1VReDdHekQrZnhFKzllQUpmUStvdWc0SDZTRTZS?=
 =?utf-8?B?R3JpNWUwZ2wxdjlVM1k3Y1pCSVZjQTdRTkEyVXFBVFRCVjgvWHRFYVh6bmlE?=
 =?utf-8?B?TUs2dHZMWitEenhudTVTWXpkNTBzMUNhNmVpMlRvdmo1amE5TGtWeFo3TURm?=
 =?utf-8?B?ZzdKL3J3S0JXWklHRmhSTGxEeHZUdkRodkozeEw1QWtjWjQvOHZ5ekZDNXU4?=
 =?utf-8?B?eUpQcE4wOFBsT3dMRTFJMjRHVFJnd3orWHFoRUFycXZlZzZJdW1OZ2pUMGda?=
 =?utf-8?B?bVd6YUtVNXQ1TnZYK1NMTzZ3RlJ5QVpSMno3KzZGZzJEY1lJZkppNm5GVE9l?=
 =?utf-8?B?Wjg3Ky9Najd4ekMwUmZYZ0F5NWxXNUxhMHNrdVlLMUt0Q296eWRDcmdLRlpJ?=
 =?utf-8?B?TDNneUxVNElJQkYxNkFXeHNWL3BuOUVHa2JpanBBN3VXYVhhSlFoeVNEUk9k?=
 =?utf-8?B?SHZXUzVEYVRkM0oxTHNURnlPV0FDVzViWDRLSjM4cTR6ejkwUDZVa3oxWmNr?=
 =?utf-8?B?R01HQ0J2dkwrcWhIQ2NmM3VTaTdFVE5STk5vRXVIcFBxcDF2cUtCNGNzWWIz?=
 =?utf-8?B?REw3SlRJUHIydHp5LzRocWhjOG5tcVRHOVVwaC8xK0tEWlFXcENZT1MyNEps?=
 =?utf-8?B?dzVBNkZzdVNndlFSaGgwbzZwUlhJMnNuS1ZNdUlKbFRLaDlsSEJWenpJYVJY?=
 =?utf-8?B?WEhHbEhCTzg5bW1nVTg4ZEpyNUo3Mldoc3IwaWFYVS9RQkdiNFE2UkFCS1BE?=
 =?utf-8?B?bFBhcUJzZHZCbDRkaFoxRmtocG9KUzkrRmhldEJiZ0MxTDdlOVZNeUFFazR2?=
 =?utf-8?B?TW1uMnZBZmFWTXFVQW1ZZXNwWW04VHlvT2daZmNEaFlZcnliN2JkclpwQXdW?=
 =?utf-8?B?a25oLzlvTnJUdzVqVUlrTGhLZFpGTm1jOHNsbkVRbUw1elFsRmhPY1EwZ2Q1?=
 =?utf-8?B?cUp6V20wNjh6Nk9BdjBRR1dFOFBicEhXYWV6c3RsUXVXUEFaY0NIVHFtdXM2?=
 =?utf-8?B?OWFobFJqTHVpUXA5a2ZqNWsvK1FWSDBJcWxuRjNMcGxMeTNZemdWZFhRNU1l?=
 =?utf-8?B?dXZwN1FOWHVCcmRUUGFvaGg2TzVVNklmVlRoNUdISEpBL05tSHRKZXF0eGlX?=
 =?utf-8?B?OHdLRW1HeVJzMGhmYkpLVTRlY1dXWDBPQVZmWDBsN0Z4QzRWLzMrWUkvTmN0?=
 =?utf-8?B?a0RteS9kMVJQaXJ3NXJlT1g2RWQ3eVBydnV0OTdXRDRwOUdSZytKRE55ZlA5?=
 =?utf-8?B?OW81bnRHOVBzYmp0ZTZzY1Q5NGxIbnViZVFLYnJaS0U3MXoxUStsa1cvZ1Nn?=
 =?utf-8?B?ajhvNmpCSlNndGY5OTF1eEZQZWRXNGZmMWd6Rzg3a1FYTFM3UWYzTjVVeTgr?=
 =?utf-8?B?U2YyaExyVUNKeFM5Tmx4MVNnVnZ4Sy9nS3cwcXY5V25OVlZSeStiYTR0TW5y?=
 =?utf-8?B?d0dGd3ZVTDE2aGxMZVRVd054NDJrak41TkVlM2Z2TDJPbi9KZWlhZlI5b3Bv?=
 =?utf-8?B?aksrdE1DSUdtS1cyTGd6Qlp4R2F3L09YYlBxbGpMSmN1UEJjS1FwYjZxaklx?=
 =?utf-8?B?a1N1VUd3RVhCNE1mLzNHcElJSGZyaS9KQVRUZ0JUV3RWNXlrWDFQNFZDdXg4?=
 =?utf-8?B?Y0doWHhVWXJnTzhsVFl0V1ZHS2FZWXowbVZEUUVCUTR4MTRRTnBEeEw0VGcw?=
 =?utf-8?B?Yy9YRTJuamtIYkJtNmtFcDJ2SkVRQW1nRkpEZjlSTURhblFpTlJvbUR2Y21u?=
 =?utf-8?B?Z2FsZVJocm0zSm9TS09OeFUyd2VwamJ1ampWOHNxY2FEL211ekU0Q0cvTDk4?=
 =?utf-8?B?M2dIaUk2Z2QxeXlvTlM5NWJDRkV3d0gwVkRHVWkvRDN4M2pyM0xqMUFaakVw?=
 =?utf-8?Q?uJrgXnrrTtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkhBbWdEZlZrRWJJSjRXZnl4Qy9aOHIzQmMwWjU2WVgyUTNTcis2bWNrMndv?=
 =?utf-8?B?MFpYRTM5OWNSb0Y3aEtBRDY2c2crUUlURWFlT3ZvazByN3NhQkl2R2dUZE9i?=
 =?utf-8?B?dU9Qa01lb2p6UjhRbVlnaG05RFZRMHZFbmpmc1VVZlFocW9hVWNQZXRhcmZi?=
 =?utf-8?B?YndpQldUMHVzVnB5TGplbU4wNms1UnJrL2UzTGZDVXBwUUdLUzFrNGdSdi9o?=
 =?utf-8?B?enhrbGdVTHhIbGpLREt5bUI0Um5XY3BCY21WWis4b3lHa3ovSGcxYXM5bmFK?=
 =?utf-8?B?QnFnOXc5NUl6RnZ6endSOXczcVRSVnl5WVRiZTBGWXR0cU1pWlpxandXVllv?=
 =?utf-8?B?K0x0YjJ1a0NtODhkZEJ5ZHpGTDAxNElDcnpWbEpRNEJNUlNlTDJia0tUbUpY?=
 =?utf-8?B?bnVyTmFMWGhneUxQc3lFYWZNNlpJWmJydjhaOUdTdXR6WGxUVTRncUVqOCt5?=
 =?utf-8?B?eEdyYjUzQUlNbUE5L2ZNaEFGOXBHSEZ3bkFwODBJcTNCSkt1eGRHL2ZZZndz?=
 =?utf-8?B?RXp3SFp2VEs5SVNwRE5jT0FTVWZNZGEzY1NJa2tQOWtlZXBPTit6cEltNXZ4?=
 =?utf-8?B?dUdJNmNrYVBtajRUYmY0Z1Q0YWt5R1hOek9JU1FEaHFsUEVNTGR1YWMyb1pv?=
 =?utf-8?B?c1gxREdHY3RTUVc1NTlHTEcyRjh0bVA5V2FoT1ZMazY2MjAzUnErVHFCUUEw?=
 =?utf-8?B?V2ZXVEczZm9BcjhZemhhUWpNQi9SQnhhWGJFa2lBaWtrem5YR1pxUXpDcHM2?=
 =?utf-8?B?VW5QbjlzQWJYRFlkMHIrVmJNTThTTmZpWmZmVHdMWWRjK3lveSswR1VVaUI3?=
 =?utf-8?B?cnRiMXN4UWp1QTZsd0llQXdUOFpLY0ZVTGdMVm5vL2IwT0hxa3Q0UUIwSG5K?=
 =?utf-8?B?Z1NVY3hKTzRMd3IxdkJwUGFldVlpTVp2OERkRm1RclVzWFBHbjFmNE52VkZN?=
 =?utf-8?B?Y282THFwcjZvYlJqUFFsTk9kdEZkSkc4YzM1RFlORWtTN3Y1MmxoQXhmcW5Q?=
 =?utf-8?B?SzBoa1kyVFFlNDE2THUxZ0tMUE1ycHBadlpHd0FxWlc4SkFkcHEya0dNUGtu?=
 =?utf-8?B?WUxmdUZrNHdYOGJuSmlGZ2pmREVMQThUQjloOUVTdnd5U0ovVjlESFcxVU0x?=
 =?utf-8?B?SEVhTjFSN0E1cmVqVlBrS2FwT1NJY3ZiNU1zREt4ZDdHQ0g2d0FoSzJYcC9k?=
 =?utf-8?B?cWEvbElDUUxEYlFlajdQenNuRTluZTErVk9HQm5PNlV4SVNGTWJzVFIwcUt5?=
 =?utf-8?B?M2tNN21mSjJWZ243Mkl0SjBka0hHb2JtV1lETXUxUkxndno1REM0T3ZKd1do?=
 =?utf-8?B?NlBMWXlOeEJqWlRiWXBGQlhGOVRSVFlyWFM4Zmova0x2YmRNdC9YV3p6L0Fr?=
 =?utf-8?B?MjZZOHhsV0lQY25wZ2tiU1pIMm5hZTBuSFE0MENRZUVoUjZIcFhjS3NOV1pw?=
 =?utf-8?B?WnY3cEdvZ3JXRFZnc0F6ajV2QmpFeGU2UC9WRjlzcFNZcTI4UDdCb2l2OFRs?=
 =?utf-8?B?TkVXeGh4VUZ3VzFaNEpBWWJKZjhXdHFsZVF3TGVQaFY4R2JTYjBoWnZGNVBl?=
 =?utf-8?B?ZTRTcFBnTkp0b2ZWNGwrdkYxREZOSi81bUlLN2tMbTRxSlhUUXpoMFFMT2xm?=
 =?utf-8?B?TkkyVjRzYjhML3RRc25mdHJKT05VcEtRRGFjM1FMNDN0bkhiRnUxYkpSdy93?=
 =?utf-8?B?eTk1dW9SK0UxbHptck5oL0t1STA3VG5EN1FnYTFxMkw1bVNPWnIwa0NGcHdo?=
 =?utf-8?B?UHQ0WGZoUTlkTEdJTjFOR1ZJc0lEL0V0dkNubUc0NE5UT0JTeGpHRUJ1d2cw?=
 =?utf-8?B?cVRyYTN0Z29qVnBHdExtbTU5dmJiR2M3aFdSb1pRNVpJYVE4clF5ak1jWWM0?=
 =?utf-8?B?WFM5MnJUWStjSjNuYjBJOVZ3d0NaNGRXcmhEYkIzZWFNaFAvU0Z2ZlIrejVK?=
 =?utf-8?B?TWNCZklZeURzNjk1VUdKeGZsMjhFQytpL1IvZGhHdWxxUm13TWtsM216ZjBY?=
 =?utf-8?B?ck9kaDV2YXA2MC9xbXlHWWRoZWxSdC9lSFVDZDVmV2tKVHJMY2lCNFg3YkVN?=
 =?utf-8?B?NnlTakFMNXNQeTlxQ0FDeTU0QjY1VlBOQ21XL2hwV3pUY3Q2SGJDaVNuUTlR?=
 =?utf-8?Q?VLaF/heqavSaURk4tcPLunjTz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c55cce-4b95-4d22-47c3-08ddf058975f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:55:44.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhQt+vNqatZdgC++5/VcSJSSS84kT+kK99YwdlapCjalzhDReS4GgiFa5cPHntctvdU/xs+Y7UtZGcVdW8MH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907



On 9/9/25 11:52, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 9/9/25 10:41, dan.j.williams@intel.com wrote:
>>> Alexey Kardashevskiy wrote:
>>>>> So PCI_EXP_DEVCAP_TEE means that there may be a DSM,
>>>>
>>>> This bit I am not sure about. A bit hard to believe that PF0 is always expected to support passing through to a CVM. Thanks,
>>>
>>> I am losing track of your specific feedback, or what changes or being
>>
>> I've reread the thread, I wrongly assumed "tee" is used to decide whether to show "connect" in sysfs or not. I guess I was a bit tired^woverwhelmed when I made that comment, my bad.
>>
>>
>>> suggested here is the summary of what the spec assumptions and what the
>>> core supports:
>>>
>>> Spec assumptions:
>>> - DEVCAP_TEE on a physical function is independent of IDE cap
>>
>> Right, I just want to make sure that PF0 that manages TEE VFs does not have to have the TEE bit itself.
> 
> It does. Otherwise, how do you tell the difference between a device that
> that only supports Component Measurement and Authentication (CMA) in
> isolation vs a device that support CMA *and* TDISP requests?

I'd check for IDE (not just CMA), and then I'll ask the TSM about TDISP (my PSP asks the PF0 for TDISP version at the very end of DEV_CONNECT). It is the TSM which does all this IDE_KM and TDISP stuff anyway.

And how do I tell if PF0 allows TDIs or not? Try binding and see it failing if it does not? Same thing imho.

> Now, the PCI/TSM core will still attach if that PF0 device has IDE,
> without DEVCAP_TEE, but that support is incidental.

Sure, I am trying to clarify the PCIe language here, none of this is a showstopper really. Thanks,

-- 
Alexey


