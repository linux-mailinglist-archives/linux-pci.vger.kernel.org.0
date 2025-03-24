Return-Path: <linux-pci+bounces-24568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EFDA6E397
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 20:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F98216B3D8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1A7E110;
	Mon, 24 Mar 2025 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VKxf+1pk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H5PKSVTj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CA645
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844721; cv=fail; b=Lg5yXsFlh2uZdrpetruCtLAhrMmjAMCKB+ob8sGa3Lm2noB3KJIgvT2ATEfUH/bLoQsBXIfzcSEYaomIK0gqkic0brD0Vt3NM15/7l9/tCDcxyAnMY1Z6TxGf5LqNBo2VNkekbGzWcbQVSFrcPzy/YTh4qoQ82X1HOvJhfqWZJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844721; c=relaxed/simple;
	bh=GXMTX51/JUhwJ2ZTekHGUGUiQWD1RlcC9gVk2dmq9WE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MGnSikQvLavq4hPtSkfJIuI+TPGndMk9hY7TqnfU/2RjMHptFjgklIH9JQbMI5kEE3xhwtkCK5idNpBcN3/wGHjgHaS/U4sJyRnpmXOZQ1ND6ZitRyaIIILwDnQ0pQ7+P6QLS50JSexLTegLjJyz9KFkEcjLYX5tYpw0kCR7g2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VKxf+1pk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H5PKSVTj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OIfpeH017742;
	Mon, 24 Mar 2025 19:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4tS+wiJ6fLhyJrewvAguV12O5BlI1zjdF8rnxz+4Fxk=; b=
	VKxf+1pkSPv7JlI51OE4tbNMllR6nX+OSIkpp/LV/AJXaMEj9GQ6I9nS1y6Ma8LD
	ZuUMXca8srX9kDDaNxcVpIcuYQWldyv+w0TlpR5/iQYJnRB4ifx5oWacO5gGIxv2
	zTsDBaMJ1GeazSnvyddVvqDNda/XDE91cPLKVuqv/UD3mWHqoFZf6+VssnkYx3MF
	KhTDFxpNlqLbV+FR2StHhTFsh5mstdVBwiBLW8nVtpTKg/37kgD0QYjz58P2hMNT
	lZnL57gbBcbI+fgNw8I0S82BoluautphOwnzp10+SScSrr+kgNwdTikHMBYAFyhC
	TNiYvQ2a9LMHiWLgv5sEIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrscp27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 19:31:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52OHvVa4028716;
	Mon, 24 Mar 2025 19:31:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6r9cn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 19:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7LnLJ9osDXwKqav+ttXPzhPcEeLEGl7Z1ftv6Sfglv3lVZ8STIx9vrcIgqj0mhazGdQYwOZ4z5NZpAcCsXgZRIr3I7hx0U0HT6js0zcUXDSJII9Yqo5PvhslEFah5EMzvDCoTR31fYthrsK67RSeoigtDKeyUQOH2HKJP/pYAB2SzsmSlwncKXjcTDIL9bX8Cpab7Rji68k68ORQFdPy8CtI4k4Xs7KXUNAwypF75GasatT0h2q/lvpPlbGeIBhPFWVeKVsb9FqS8bpDi2lRJq5E+mL9X+3adE8Bv6vfnUglD/bpmT9VswF7V2syHUu+g9YpwVJlEyyzfPdvJFooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tS+wiJ6fLhyJrewvAguV12O5BlI1zjdF8rnxz+4Fxk=;
 b=uSPqtK7QogO43qOc7SZos7zt4zvLT9FeVb4lLhQk5XxxT4ec1oXCxn6dVioxx16C27GuqjhFJCms1cSnbRR5LZtoMcYWenTTOCeMxsZ4YDGMpPZTYgQ387pL/zQsHuPlcQGeco5tVXyhg0UQPIJxgznjW/ZycpBVXE20fjUgWY6WbjxntzBJ/N6ej49ZmmShhniK6nwT7iexF+uyDeQyyvikrjg8OlaLbzlk8sYnhodjz27IrFfMAMpUBXydcbgYOjhz+GmMrXdw5agQJcaGUCpAdwGB1p2+rX8nQLrdnHxcMsDq5BCQopcIgGEpAMZnmmLwT/XNP5MXh+fw/Nzyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tS+wiJ6fLhyJrewvAguV12O5BlI1zjdF8rnxz+4Fxk=;
 b=H5PKSVTjL5CvqZeKARdRdLqXNs4kvQI4PosKOlkYf2ppVW4too1ykHaZ9kTL0/8bDC2i2PtuBg3RoIn3Zk/DH4YHmqt1pJm8ccepJix1B1UAiD26mnTQ/TmLaPCI1FFS9Jfsmvtp+U4qkmIkGmy+is5BQzCvS7xOUQqXMdER9aw=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SJ5PPF7E749FEBA.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ac) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:31:10 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:31:10 +0000
Message-ID: <44b1b803-b8a5-4d81-a918-5d2ae13914a4@oracle.com>
Date: Mon, 24 Mar 2025 20:31:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Pan-Doh <pandoh@google.com>, Terry Bowman <terry.bowman@amd.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng
 <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20250321150607.GA1124679@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250321150607.GA1124679@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SJ5PPF7E749FEBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 46afb06d-c8ee-4cf1-c9a4-08dd6b0a6e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dElGNTJ4d1pZMVZad3RJbDJ0ek4rK3dKQkdmTzBjbGZVNyswbVU1RFRGcVk0?=
 =?utf-8?B?eVRXS0JzdmJwdkd4Qy9KUjNTK3Q0S3hPeXo0N0ZTTHR0ak80Y2ZxcWRzOXNE?=
 =?utf-8?B?d1ZRbWh1ZEJRYitsTWhVUUFHNzUzNGNmRGtWUlkyM2dLdVVnd0M3UU05WVRG?=
 =?utf-8?B?N0xTVit5V00yczZZMzMzdGdkZkxUL3B4OGk2S2FpY2lMREdmMzlJSUVsTllp?=
 =?utf-8?B?T0d1L1haeEJqd08rbGNha3JDZDgrWDUyVWM1T3l6M1JtcVhMNkI5aFFTSVFh?=
 =?utf-8?B?elNnMDAzQ3hYU3J0dytMR29vSVRSNCt2WEdJZ2NaQ0o0UkxRbnZwekdQczR6?=
 =?utf-8?B?VFpSQlFqYmp0czkrcFBVVHhadFNJODY3OGQzck9MS0c1KzhxYlBXdkduMXRC?=
 =?utf-8?B?b1pHamMrUHVEZFRQakp6NTNTcWNJVGkzeDFQamExWmlhTDNPdEJPVTlTVEpi?=
 =?utf-8?B?RmNvUzRFTE9KS2QxSW03MnJZdDNlTmxqRTFpakRrMDNVYWdwVS96SmY5UVJr?=
 =?utf-8?B?Z0oxcEhxZUlZaWRkZWFjMWh3N2lzN1IxVjVrWGpZcGppNTEwMUp2c1hMS2Zk?=
 =?utf-8?B?SmlRQVBzTnZxTWE4RS9RS3g0UTNzRzVmb3RlQ2Y2RFVPRHgyV2QwYlRWT2FM?=
 =?utf-8?B?bC9zQkZDekNndVM5eXdyTnF2T29nQ1VkTEdjVFNabThVcXBLWFlDeUV5NlJI?=
 =?utf-8?B?VnlyZHRxbjIyZUs0TDI1Qld6ZlpCMkMrQmd5bjIzL0M2WFBtbXZCNTdHOTEy?=
 =?utf-8?B?YVBoQVVrL2pITHRuK1JON1RPVlBPeTZ2R3VjN21IOTRnLzd2N0tKcTcwREh3?=
 =?utf-8?B?MUV0Y2dEM1k2RG0ydTJmaExXSE5NeXBqWVdjak5yQzl6RDZsYzZqTEJWYkpS?=
 =?utf-8?B?TldmK084VWNKYkFLeEwxZkI4VGNTUWJVRWNBNm1MVUV5aDF2ZTBNaFkvMXM3?=
 =?utf-8?B?bWZyZlJNRTZXY25wTi9xUjc0bHhlcXdvbHJ0UTRMNkh3SmtvZ1Z1SUtNbWEv?=
 =?utf-8?B?enlReENsY3RTT0tTUlluVnRqTVVpejNSeHBKMU9yUVNrMXN1cmhYcW0yRWpW?=
 =?utf-8?B?VitlV2dZa1NYUVFsbWFNWWVNNlpLSk9FMXNiVFFyUW9lWG92Y0F3NW1ZcWdV?=
 =?utf-8?B?d3ZTYm5kMy93WDh5UG9GaFI0RmJjMzZaYngvS0hnc2R0ZmRMU250OTFWYkxp?=
 =?utf-8?B?ZHhIRVdUNDdTZlFmdTI0TlVnbXJJRkNJaU9TL0FIa216eFBpdW1VVEphZjZw?=
 =?utf-8?B?djU1cWY1RDF0R0poOEs0VGZmV1lhRysrdkNiVTRCdjFYZ1VkR20yckVsR1ow?=
 =?utf-8?B?cTFIVjlZZFp2QUNyc3JTdnErODgxNnptVnMwczdQVmZQZzU4cG02THpDNGZ0?=
 =?utf-8?B?MHN1Q3RNaVZCK2phRkJYdXZNSW1YYVFXNHF4ckJLTHlCaUczQVBQY3JKdCs3?=
 =?utf-8?B?b0dDdThrOWlaTmcvV3Ftb3pWcHZheElld0c1OUZYQ05wd21nS1NQTUwyN2tT?=
 =?utf-8?B?QThNOHQ0SWlmZUF1ZmN4cUp0UE1KMXJpU2ZwNE5kYkJQM0lMbVArenlSSjNa?=
 =?utf-8?B?YlM1NUJ4N2M0RkgvaTZteGJRWGZWQ0FYeDBiZCsrWFZnZDVUcTVQcjlWNVBN?=
 =?utf-8?B?R0RpWGdobHVqTnYxWHM3WkF3SW1reUhaYWZRMjVxSHBHZUFRQ0xQbC9SVjNN?=
 =?utf-8?B?Tkorb3c5RzRZUEJEM2Z2T0VTeVU5L1F5Um9XMUVWK2lOSlhpLzFmRjIrUnBh?=
 =?utf-8?B?R3BzRHYrZy84eG9qeEkyb2g1Qnh0VWFsQy9aRUlxRytiVUNKWEkydkxWTm9v?=
 =?utf-8?B?QjhWZGo1Um9zYSsrUUFOQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0luczhNV3IvN1Nvc1VUSXQzMmFMN0NUNCs0aG5EY1BQRUk1cVNhMXg2YWlk?=
 =?utf-8?B?TkIwajUzSUxPYUhZTzFzcU5tamo5WHRuNGFpekQ4NmZXZU9nSk1IL1hPaGcw?=
 =?utf-8?B?RTFNU0htZHhxWFNzaGtBYVhRUTFuSStIM0VCL3hHaWZXcExoYStmSzV2WGhW?=
 =?utf-8?B?Wk1zRHpOeVBOdzVxa2RqNk41aXVUbnRxVXNqMVZZVDU0dmRWRkFyZUo2VHNo?=
 =?utf-8?B?NzFFM01tSWE4MGxZUDdZYTZPbFdwR29OY3BJenU3V0N2eGNvRDRBdDdEeTRm?=
 =?utf-8?B?eTUzLyt3MkNldVNWU3ZBeWc5OGQyRVVkdTI5TjMyWnNYaFQ3ZGpLWFVsZWZO?=
 =?utf-8?B?c3pBRzRiVXdxUStSci9Yc2hibU1FaGhrekZnK0JaTE1DVGxCT29rNzFjTWtG?=
 =?utf-8?B?aDI5Sm9pZjlUdnhtN081V2xzUkY1UEZJaThkeDdNOENXS2xhV2ZVK2labW1U?=
 =?utf-8?B?VUl2Q0UwTC8xM21SbWREUDlrOVlwbThsWXBoZmY3cG54M2ljeWFqMWtHb2xO?=
 =?utf-8?B?TnQrQTl0NzdnV1NXWEpNMFN6dnM4c2JKcG1qM24zTE5qUVFlSTh4SDFodXpl?=
 =?utf-8?B?V3o3ZUNVdFdTanBqL1FSaElsdUVZZEVnU2hHNVg2SG5KblM5eWFTY2NVdHMx?=
 =?utf-8?B?dzJ5MCtSWkx1T1kxVzRmd0xxamswZzJLSWdEcHpBVXNORW1uOVhuRjNIZHNz?=
 =?utf-8?B?YWM1VHdDaXBMRW9aN2lKUTlqdkxpM0h4OTArQ3J1aHhtdFJKV0lBQWE0dTk2?=
 =?utf-8?B?Nk1DQXJiWDlwQTM2dTEzOU1Fd0kzMlV6TlJhVk0ydkNGb1R3SzFDSmhnQUUx?=
 =?utf-8?B?SVMwR0ZESU5aWGp6akUxckVDY0szRDZ5OWdpb21SYytGSjNMSHp5Z2pEckFh?=
 =?utf-8?B?MS9hS1AyakczSFdpbHJPd3FHcVhaTWJYcHRWWFFTSVRONnlsUnNldHkxMnVv?=
 =?utf-8?B?WGQ2VFpQSm9ENmdMVGlPSHVra21hQU5Qbm44V1pNUFE4VndCVTZ1enF4V1Fo?=
 =?utf-8?B?R05LeFBIbytKdDN5TVlqVFhuSHAxbUl0eGFlUUQ5UU9SQzYrYmtxYnAxcXI0?=
 =?utf-8?B?ZE9QcXpSNUNHN0l3VFYreUJRNGxpSU5nL1RGaitRMFhGc2N4UUd5aUZMajND?=
 =?utf-8?B?UnhyMUxtczlUOEN3N0V2QnhLeGQrai9WN0Y5Q3BMM1diUXpnck9pK1NFZWZ0?=
 =?utf-8?B?ZisyVUtHR04wUE9vVUFMZWlUTWdtaGNwSzRoYW1YOEdQQjc4a0lNUWJZZEN1?=
 =?utf-8?B?eE1NVmUxTkRZWk1SbFZzeklBR01JUEZCb3BVSGoxdEoyUkpYZWx1R1pJS3Bj?=
 =?utf-8?B?QTlSVUtrV1ZNVm8yL1QyT0dkTVdrbU10N29ZRmZJa2lIUU1JQlJjNTk0VlVt?=
 =?utf-8?B?STdXMVNCUTczRWVOaGZWelNoTG9ZRTdqRGJqR1JISTNtV1lBa1dyRTZvTUdu?=
 =?utf-8?B?ejZCd1ZnNFhuTzB4UjNFWHJSS09pRDVLUFpHWk05Q0M2bVVCak1BQ08vOGh4?=
 =?utf-8?B?YVhqK2FnWGpGSVh0UWo4QWhjbjZndjhPUDhuWWFRcUVvckZTTm5jcWYwVkx2?=
 =?utf-8?B?V3BkcW9tWnBvMk52SlR6aGpLQm5mMmJBc3p1OE5pUm5PVjc4ZzFVc3lqQytZ?=
 =?utf-8?B?cHN1dmUxZXlOaE50UThYak5qYW5iRm42cmFVa0Vsd0FpalExSTlzcG5Ya2xW?=
 =?utf-8?B?NklxZ3pxV0M5c1NJOUpueGlPWWNvWCt5N09iR3AxSmwyNFdacThlQ3l5Qkll?=
 =?utf-8?B?VFU2UWhzK1UwUHA3RXpSRk5MR1VpaE1KK0lLcGxkc3pYT05BZGM2dUcxUHAx?=
 =?utf-8?B?UjErN2w4OWFwNEY0MTNrS0xUbEdzUGNEK1U3eG1hNEFTNkZNaVZCQ2RaaUU1?=
 =?utf-8?B?Y29Ia2tSZUhwWnl6RHl0Y2FiTDFWcllEU3lhQ1NFL2JNRGVBWDlaOFgwbzFp?=
 =?utf-8?B?V2Z0b3Q5Z1ROOU43azZ2Y3h6TkpJSGwzeXRFenpzSEU4V0ZkWTRXZVU1Z1Mr?=
 =?utf-8?B?ZEtLRE5reGU4SXN0ZEpDQ3ZkRHpiK2FFMlJMZEZBeXpNVUhOdGo0cm9hK0pu?=
 =?utf-8?B?eUN5SGRPQU94YU5FL0IrdUN3MnBOVVlzWlNmNEN1YUROMkRxRE5PM2R5YTdt?=
 =?utf-8?B?UmxiWmgyQ2F0am9HNzdWK3lnbitCamFwK0VtOWdSem9mRVBxMVgrYTdUT0N0?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q3XEPpLlkzuar3dFrnrsr+Q1h/9DDfze0A1PgBjtoimgDszArm2cc5CxipJmG6C2T5AGxD3EE3S9yYOLsIuqgvzeZgoNKZI7bBAExHb/9QQqGQlGAJKWZicF15tiRVwYjhwieHE078ZQGp6jy0V5PZDvYRVTfXC3jBc0kmPlBbppgU715m2mFGBM9cQqWl8/BO1L0DwEW2dUBnL1sS0sTzTLykuH2JYcAl3GqHoZcoE30CiWuEOtQQJN/nzn+aQPE2g69sW6KDnXmDfKS66hK6VvGbzor9WyI9Bretpu5iZ3w8ia4b6br5oIT9bMe9vbdueBsncZVNdfOJRR5BhpoV6txBjTQ0bSg9TdQiGZesoI7yf8ytIHyo7e8PnZGSV/qWzbyfqiCFvQhSg0rlsxo0PDaGVxoVkU1bdxJ42JqdNkCIqETgbKhbMjGZI2VWzdAaGqt4ZPOZGz294meLA8+u2YGEmyBEM6hoKX+ez7nMObNP4y7D1exZpgi2u2p9vhPrq2A5PLL3uMuvbX6Q9YXRCmsVfsW8qG/iMRQQi60E/peOHxRCJF9GZprwbQsdqP2skcttO42313hPd6EQFB1fClB6ktfXdQ0D4mX7n0h98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46afb06d-c8ee-4cf1-c9a4-08dd6b0a6e2a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:31:10.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZWGz+TVzHq5wvDO/ZKd/BuaJGgBLHkBAEYxD2jJjMWH7i+bLLIRF9Q5P9fU+ifzQfDkwIzS30e1kmcFgS1MIU+fKLbiNcedtjPyNyvGo8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7E749FEBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503240139
X-Proofpoint-GUID: gI5CJqT9ih029FJxNRYxaLIF1zG3NX9i
X-Proofpoint-ORIG-GUID: gI5CJqT9ih029FJxNRYxaLIF1zG3NX9i

[+Jonathan to ask about CXL error injection in qemu]

On 21/03/2025 16:06, Bjorn Helgaas wrote:
> On Fri, Mar 21, 2025 at 02:56:16PM +0100, Karolina Stolarek wrote:
>>
>> ... But still, the question is if going with the
>> new format that matches what's in AER a bad or disruptive thing. I'd like to
>> try going in the direction of using one way of reporting AER errors, if
>> possible.
> 
> Absolutely, I agree 100%.  The choice between native AER and GHES is
> made by the platform, not by the OS, so I think it's crazy that we log
> them differently.  We just need to include information about any log
> format changes we make to help users adapt to them.

I agree, we should highlight the difference. I'm trying to get 
before-after logs for CXL but I can't get this to work on pci-next 
kernel (i.e., without Terry's patchset).

Jonathan, I'm sorry for dragging you into the thread, but I thought you 
could provide suggestions on what might be wrong with my setup.

I tried to test this patch by injecting a CXL Correctable Error via 
QMP[0], following these instructions[1]. 
qmp_cxl_inject_correctable_error() finishes with no issues (it calls 
pcie_aer_inject_error()) but I see no AER log or whatsoever. This is the 
command that I used[2], with QEMU v7.1.0-rc2-21892-gd9a4282c4b and the 
pci-next kernel.

Is there something else I need to enable or provide some parameters to 
get this working?

All the best,
Karolina

------------------------------------------------------------------------
[0]:
{ "execute": "qmp_capabilities" }
...
{ "execute": "cxl-inject-correctable-error",
     "arguments": {
         "path": "/machine/peripheral/cxl-vmem0",
         "type": "physical"
     }
}

[1] - 
https://gitlab.com/jic23/qemu/-/commit/b3488ff7ee6ebfe247c9af751f44f2990babd4a7

[2]:
$ qemu-system-x86_64 -enable-kvm -cpu host -smp 4 -m 16G -rtc base=utc \
   -M q35,cxl=on -nographic -serial mon:stdio \
   -drive 
file=/.../ovmf_code.pure-efi.fd,index=0,if=pflash,format=raw,readonly=on \
   -drive file=/.../ovmf-vars.base_image.fd,index=1,if=pflash,format=raw \
   -object 
memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M 
\
   -object 
memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
   -device cxl-upstream,bus=root_port0,id=us0 \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
   -device 
cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-vmem0 \
   -qmp tcp:localhost:4444,server,wait=off \
   -M 
cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k 
\
   -hda disk1.qcow2

