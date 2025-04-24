Return-Path: <linux-pci+bounces-26676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF7A9A74C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 11:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3693A3BCCEC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5141EA7C1;
	Thu, 24 Apr 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mjPYZ+7s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T5wm/ZzC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B67204F83;
	Thu, 24 Apr 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485314; cv=fail; b=W8yRTKPSw3MLnvwXPhqIImRAEJZ4+lBd9WJO5yJzUywBHkknkMfvcGWeA2opr48cOcIU2wa/aDOjBDwJJUhbb1mBNQpeoVZYZwH9hyWVzuPnM5Igif1wBEp7fldqFkfTS9xzAGHPuQbMIpGdk2vWA4Wl3jUugYEpXFqDFCLPgJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485314; c=relaxed/simple;
	bh=cEcjMMOv1ABjONP7DDaHmthHU5SlnqY0khiLlt1ld0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlaUnu+LtJnbbWS30R7Sb2vps3PmNERGniALcqggo9nakgrUewlr1/4HiKbK+1qp2DSQ5QgJkRx3xj9ncN5RH5iUwq1N3d3wp1EiTxN2r6NcRLpZaizCbe1Gjj/vDMN5wzxLMIJe7KWxdj7qelw4J2SyGWprGU8zHBI7tNgaRX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mjPYZ+7s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T5wm/ZzC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6tvIh013957;
	Thu, 24 Apr 2025 09:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0gymDc6uTlTWmquA4+U/g3K7e5k3J5OsLSDi8q/sbZU=; b=
	mjPYZ+7sedkedNIauxvNCOedALNvoOLnx6mZd/tyczgnbDizlcnWseQsPpPLdBrs
	DbA6DZhJdFGRl7wWPvzO0dzw4fGrw1WPVCKV4sr+WN/CgDXW2Ncc3RKsVZyjFibK
	czp8texN9MKJ+VML2kzc11dlCp36IdRmZMEqnZgO6dDRJxv5s+9U7tmz3vGsMPG/
	G8EfkxNYZnouWz1JusOlXRPCUYzQU0B2VfPrY8C70mMi++MaWdbK2AwErbBlvtgp
	uHXZnutdO9qc5E3VZBtD/AD0ET3HYSXngZ+34SMkwXhEwzxOweeuSoO4FI0hN1Ui
	iN2jZQ3dAeGKhFyD3lNMxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467eghrc02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 09:01:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7xJlv028600;
	Thu, 24 Apr 2025 09:01:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx78eev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 09:01:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myya7qI9aow+wO9kIYvJ9ErILoExvLDEMdPgEK6vUmJvqC8gAeqlauqB/ePBT50JcpOFpazkvmrbhum1McY9fSdd0im7XGUZni+qIfFTHpPy0oLYyKAuppCWV7Z3AYu0JWRzJcVxkpEcO2CHTb5i33q1u1JnsA5pfH6XpPjH9laC5BwgvZ8UdY52pHYV3eb9Y60nPEgvCeRiVeiecn0DKD2IKNSUccz7uiG0dP+3u0rGbRRqVAHVlUG1Atu5Akq1w3uuruPXBX947944h2WjMAlfdvqUZLVE6HQlEoyYzzgK1Z0pnPXNgylyxe0X6q6iAXL7Be8pPqxeIB6ePqf0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gymDc6uTlTWmquA4+U/g3K7e5k3J5OsLSDi8q/sbZU=;
 b=uEL0qqeAR70sqdG/SckFB9XCtivdIJ5myyA0OL/6myA+MgbvQStDlfN3c+HqBpprPGLhcoDRjpLYNRvd/yExGpH0IlAlR2P2v1QBxob5P4EpIfypAJ7Mw6o/XhEUDcWrNWW4cdumsjGW6cVxLeo75Dmjf+X3CE+K8SF6tR02i9bcBZwN7cYxmrRu5W1wOo+yOf594icrvuP6PNwm7TdFAuqUjMLQFqEGJy1eQf/sHyUGgUQdT/K5MKc0Xx4yJt3sPsKUEz2og81QpCM7quu1/wnfot7Maz8SEmQXr5V/y34dQe3FwBBCU0ifdkcG9tCWPw9Lvl7xgkWFyYWCPVS8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gymDc6uTlTWmquA4+U/g3K7e5k3J5OsLSDi8q/sbZU=;
 b=T5wm/ZzCZtnAc8vrsA6CORURC8qTtx8T3GSHvKokcSklJlcsqGHCAknJobpwg8WbnUQZFicuJwjuAqPWc90ifV57ZLz/zj641sIpnH0IelftiF6ZbGYWh2nqfZ8+X1SHRoIgFUONjGeJDwJyWNAqrjYDK2pN3mT3ntZL/mncd94=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 09:01:18 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 09:01:17 +0000
Message-ID: <5a92a75f-4348-4578-9b61-45682edaa514@oracle.com>
Date: Thu, 24 Apr 2025 11:01:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jon Pan-Doh <pandoh@google.com>, Terry Bowman <terry.bowman@amd.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng
 <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250423203143.GA442813@bhelgaas>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423203143.GA442813@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::28) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b49fb0-e0c7-49ec-6724-08dd830e92a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0JuYnRrL3dJS0c1WGtHdTBwck5RUUhsRmdGK3RIdHg0Z2VrRSttaUZ0UnZ0?=
 =?utf-8?B?dWJyRVpGVTNCWkc0emVUbG1lOUtUYlZoeHN1dzBOT2NnRERUV1JVRmlNQ0Vw?=
 =?utf-8?B?NnUrd0VydmNSNTBCT1ZpVXJMVE8xa2xhdXNCbHVwU3d6NFJPZXlCbzJhZUF4?=
 =?utf-8?B?QlU1UUNBazgvUlpCM3pyYUV4TnpZMEl2TS90NjhBcDMwajlGSmhrbGRRSTYz?=
 =?utf-8?B?ZWFUMkFEc3MwN1BsTkRJeTIrbEpmSkY1NzJySHdPdzhvWVoxYldxU2lZcUpD?=
 =?utf-8?B?MkpLVWNrYWQ3VEp4VGRxSHpQaEZtMlFSZk9aZjVsMTRRNmpIVXBOVUVLdUsy?=
 =?utf-8?B?dEkxTlA5MUQvRG5seWcvdDVaN1dESlBzaStXV0F4Q0NuczZwbHRBUi8yQ2Ir?=
 =?utf-8?B?bnBNeFZBa2xFdzZ5d2VqVzh5R1ZYaGhxMS8vYlliYndOaXEzRGtyc0dHb3VK?=
 =?utf-8?B?RkM2TkdtYU5VUFFPNkthVGlNNnJ1S0RhRHI5N0lxbUJqOXN4UmdvMnMvc3Ey?=
 =?utf-8?B?U1Rva1ZzdDNoTm1DZFhMRXBhc2RhL3I3OFNTVlVtYW90blpiOVNkb0g4M3hk?=
 =?utf-8?B?S1RySUNETlBtemhxMEovQkgzcGQraWlHUUNuU2lQTEhKdjBIRUhlZ2o1WTAz?=
 =?utf-8?B?Tkd3UWxvdS9tTndDRHdSRG0rZlpzZEx4Y0tNKzdTb1UxYWljQlcxUUEzbm1O?=
 =?utf-8?B?YXhsWFMrYkpsSkVxVm1YMlNhNG1Ra3dpQm1xRzU1bktBZ1VGNWhiNE9Dd3hy?=
 =?utf-8?B?NzlScjJiNkhla0lvUC80M2c5bFlmN3d3WjZOOTlZZ1hJOUFTMXRqUkRsdGFP?=
 =?utf-8?B?elArUW5nb0JsSmFXaFZDb1EvUWlZQ0hMNXBJVVRIek9HRSs0K0JQYlgvdEdi?=
 =?utf-8?B?Yk84eDRNZ0dmYWlsdXJHL0N5V0ZkSUEwUTZZbUFhR3ZHTWJOK0U4ZlgyWktV?=
 =?utf-8?B?R25WcnpDaGpsVU5ha3RseENEbkdvRjlXNDc4d2R5ZTZwQjV3QmZLbFpUN2lH?=
 =?utf-8?B?ZzJ4c1VXa2g5NWYwTUJZTjBpV2dVVFErSkxuOGwzbFhZb2FyWGkxZkQwV0dK?=
 =?utf-8?B?TWFvTW4xTHlXangrcThYTWlnMjk2VkRRU1lPc3dKNkh2Y0JKWmRSTWxIOEJE?=
 =?utf-8?B?NUkvd1o4THRESVdSTXkzRkNZT2RIMnFxNlJTaVNNTzlWeVdhakVMY25NZHdO?=
 =?utf-8?B?TnRWa3BOMW9rM21sTDZGRmxHWDczNHk2K0lWZEgyOUw0RS9Ca0xYSlRWNW9p?=
 =?utf-8?B?K1czdmxrbXc4UEdJOTN4aHIrOHA0ZE9jUVh2SGw4YlBVNHBvaGx6ZmkxYjR1?=
 =?utf-8?B?T0RnYXZ4RlFlMzhNRzY0bXVXNThGYUxtUSs3cWp3UnJUSTd3SlFZamlGZnJJ?=
 =?utf-8?B?R2F5eVRJbllnNzhuZGVoVjVqcnkrZko4UVBlTlAwVGI5VDZsREZFQXJwU2Uw?=
 =?utf-8?B?QW1xUER6RU5ZMnYxMTFOOUFiRzhyTzN0VTdOQ0lKNTJTd0RPSTFEQzI3dVBH?=
 =?utf-8?B?R05GOWppTC9oYklrSzhRRmZCcE9DY2xPcG81UXhLMFk5OXpvRDFya3F1cjJQ?=
 =?utf-8?B?V1hJdVFEUVIzeFYxL3lmN1MzdWV2ZkJTZWRTeDNDdnRmd1g4dytIRFNnS2pp?=
 =?utf-8?B?Z2Z1OHZTQ1FqQm4yRi8rSkR5RHBXNEFnM04zdjRUazYxdjlyOGxBV2prYk1r?=
 =?utf-8?B?OXJPS28xSm9YaEptek1tbTN4UUxyVVJobyt1bC9oZkQ5RkFvM3k0d3BoTGRz?=
 =?utf-8?B?bXRZWVNrN3padm5FNmVaNS9FVyt4NktmYlNDeHV4VHVpM3U4Rm1GUUhKZUR0?=
 =?utf-8?B?cmRrcFNRMUJ2Qm1saFZQT29mMGl6OWZoTGxMRElXR1VZN2V0VkVPbFd2K2N1?=
 =?utf-8?B?NzMrTzdlUmloZDBaWjdBYmhERmFQMnZsb2llbEpDdEFzbzB3MjQ1c2hnSkhy?=
 =?utf-8?Q?QrUKtnQwxLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXVtVzZkam5xQWhQWHlPSnNPZDUrVklQeU0xZjhxOXJRY2FGckY0MFUrbkw4?=
 =?utf-8?B?UWRueDE4bmNJVGRLaEFPNExXdXNEcFY0MVBMMUNGUWQ2MXRuYml1YlFGeDkz?=
 =?utf-8?B?dFJqMHpTTGN3bjROK2J5TUovdyt5ZzRPZDlITmF4MW1oV3Rvbmt0QWRjUTB3?=
 =?utf-8?B?M2V6anVsUjVndGFMT0plUnNTK2k3cWJ2V1VSM1hnVWlCTXFERHg0eHlYNk1T?=
 =?utf-8?B?M21lemdwMlM1aXhvZUNFSnNZeEVGV0lDRjAwSUlBWjJiSEtVZW5iaXVSVld6?=
 =?utf-8?B?V0c0YmsvMFBlVDBOTVM5d2ZSRzJnWGJlZDRBWngwbjFSMjZaU2UzVnlTdEJy?=
 =?utf-8?B?OTdzeEhqMEx3OUNsdVNGNEVPZ1lwcjZFaStsbWU5aUNTTEl0Y200SS9XbUxr?=
 =?utf-8?B?OVVZdHNNRFFQOUJtdVIycXN6WitVSXdzZnRubGZCWG45WDBCdUNMSGdFb25R?=
 =?utf-8?B?WktZNGNIWk1xd3VaVjlvbkRuTVFIcUZXaEJhdFhMdURnbHc2ZzBVbjE0ZWtI?=
 =?utf-8?B?RFhqRGtxMVljTmhjU1F6cTdrNjdTM3IxN0ZTRk45UkU4QVRzcVZpMEVOOHdJ?=
 =?utf-8?B?aEpJSVlTSVp6STlTZFAvZEZleGUvaUh5djltdnNpV1FoUUZJakpZQ0ErVFV2?=
 =?utf-8?B?VE9xcStnYlNPdnBNOUEwL0NmVXIxTGdWWUdTL1lGTExaUVRRNXE3bWlHNFQ1?=
 =?utf-8?B?aDY4ZUJ3L1hLdzVNa3dqQ2JMc2F1Ky9EQXFLS1JiK3BhZGk2Q04xbzgyODYv?=
 =?utf-8?B?NExUR1N6dTVkWm5JREU0OXZlcUxzMStHekcxdmJTVU95am1nTFpmS1YxLzBJ?=
 =?utf-8?B?VkpacCtTMVRuV0FkN2YwcDR3QTl0clMvNlRsY01DdE5CWDdjdTA3d3g2eS96?=
 =?utf-8?B?M28yc3ROMkZBdUxldkpRUDNhNXZSVkE4YjNMMVQxT1plbEtXVlpIbjlTUS92?=
 =?utf-8?B?ZVRhL2FHQXF4UDYyUkNqM2laSmt6cndhaE9Sbnk4SS91UEo1elJham1JTWhB?=
 =?utf-8?B?Z0VOdVlFZjlqMy9ycW1ZWGV4ZDg5YnJYSEZtbUFZSXFXY0FVTVdob2VwYjB1?=
 =?utf-8?B?SGNuUktoeEx1SGJCbkJtemVIZUVGbjlPb2thT0liWGV4aXM4T3g4SUNLL1c3?=
 =?utf-8?B?ZDdVYVUvWVc3MmFIdStmR1RRTnRUYi91czhyZ0xSU09DR0ZqY1JrcDN1c0hB?=
 =?utf-8?B?ZEd6a0FnUjk5dno0SUFwdGpxNnNlcVpPVXhLbC9YNWVzRHRNWFNYVFBkZnBk?=
 =?utf-8?B?UlFQYXY4NmQzUVlnRVNMZ1REVGFkR2ZScHBYQWhSZ0IySGtFWFlmWnAvSVg0?=
 =?utf-8?B?Mk9jVVJOUmJ3N3NiMmJDTGk3eXp1Ly8vdlc1QUxUY0pxSkVkajJaT1FBQnBa?=
 =?utf-8?B?UWxFKzJidGt6M0lWVmVFOThwUkRFMm5BQWQwUGo4ZlM0dzR4ejd6R2UrUUZu?=
 =?utf-8?B?Ym5LeStubUd3bDBsYjhoSE5KS1F0Tyt6cDI1NHpCUkM3c0tTcm5meU9PaW56?=
 =?utf-8?B?cFpjU3N1QTgvNDEvbmZTM2pibVJYaXFES0YwcjdVMngweHhEUHo5dzkxS1lh?=
 =?utf-8?B?dVcrQ3N3cUpHSGhvb21SeDcybDhoRjdDRU1mcDFhbXJhY1gwODBHRE9ZK2JE?=
 =?utf-8?B?bUs2YzRLVlFBVU1YWUFTcGc0SFowSXRqS0p0UW44YkcxcTg5cEdQaWxLenFs?=
 =?utf-8?B?cWluQUhmdzFRUHdlZWtOUGliTjZBZFVlRnBxVGs4MlE5b0VjZGtTREFFUjha?=
 =?utf-8?B?d2xpeWdjTnRpdnAzVGxUK2JKaUtybGkvQWF1UjZkbnd4NUNwVVpoUjArNjVw?=
 =?utf-8?B?bVFuNUlZQ2wxVk85ZUZVZDV0NGlLSHZkNDJUUDEySnNiVFhaYWszQjlia1F3?=
 =?utf-8?B?MTIyOUNDYitQTGdHSVlYd21rUXp6bjF3K2dPTU16M1JORmZoWW1tbllHdys0?=
 =?utf-8?B?ck9abGozcDBwcFZQZjJnRy96WkZ2VG1uK1hlVHBaT3pGVXBSL3FucVE0K3oy?=
 =?utf-8?B?dmhEMDE0cUo0V0h4R2x1RDF6YU9VVm1JZks3bFZCc213UWl1WmZsMHRXTzhl?=
 =?utf-8?B?VG9uU3dRSFRNTUdhRkJ6bC9oRTNabWo5cG8xRDYyeDRBNGE1d3VqSGVLVTJ3?=
 =?utf-8?B?NnhNUzdnaklwbnFQSXFITkYrOFZSVFRjcjh6alZVc3ZNYzUwNXBKeE1GSWlC?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g+TmHMswtroSsgg26bNwi+2s8S/Y1g+9mxlFD3zTXEMv/hGKFro4ogElLvR4ujYgwd4iW97zgiaN7WN99YjK4HUS91YFhNsRf0I4/2CE/h7OiGTtuMX3f+UjyzPkOYiSFp1EA4fKOL2R2s6UML+6yJjGphS/4v4R1msOdvAWcaX3BroCQmbo7UASRWmRYshzBbYxTYO/tlcN5sZeOVXAh8zT5a70W+ztLpx0xvajFk6fN0jEZJulSFx+TXTQLElmuVrCLln/3kkH2wipbV+8zYS7uLzwHxAG+fyP0qPqU4b2tonX3yjEfoxKsIf861ySLkK6E/6QCEUnItEETW0yawEYbnEh1P/QtVTmuccSKQL63OKGx0OetmwOzYU+iCUYQByAWlN1VW5kfw+yqfqX5xLsEP4KLNTq80c31c6tViSR7WfoWeK0dQ3dA3hBm4Pk91IS46wY0rfwlo3Kkx3VeGscS9yJlhARfD7gW1Ui5yACyalt/kLnyt2sWEeUb23WxKsIBZiA90YDAsP6BIFJo0UuWwLh8NjBsm9P8c761NWeJ2OSRoX5Pqsd4fPbhDViJhQEX6WGHfJpvi40FP5csoMR8hGs4VLNWRtCORQTJAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b49fb0-e0c7-49ec-6724-08dd830e92a7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 09:01:17.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2j0g1ohEBcL3IEtksWXNMJFfyRPypvltivMnsTNqBSmWO06cJJUYnS2YcNOtqIgcuPwlU/DakM7Pc6+L4iFn9IRyzP04ZwxRV4m4zq5YIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240059
X-Proofpoint-GUID: 9yhiGvdsaksqHkv8uc9kWGg2V7qlBU_O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1OSBTYWx0ZWRfX2dR/bd86aTuG dgTToYesv9xvJ//aENo5AP+xSkXoP/BqNBYuj/FrXAHYv3e6oP9Z5fNYD6abTTNeN1V+H/m4B74 ep6gfKOPgwO9br4BrvFLiTR+vdxtFQDfc+ryLJ9tET/DdmGXIFoQlmSAcC3Et96IQVghmLcg6cZ
 YdBNvzQUzTA8FXNPzRARHorTv7y788LYXmvsiGbb8nrkirh7fGVcs87dMWQrGb9r4VMUsoXdj6u nMZDog0dZTEG0r5ZVmnkB4cZRzluTC1TJL6kGqnY0a42sxtsKuvedeUz30Xy92WjoUYA7uVDtvG eOy57oRzLqzbXodFH706DB2+qpxN5MX9vZaBJPytu74OFNndxdrjQfDZCV+43ky/pYwdS0zK0Rj pjXoZSyq
X-Proofpoint-ORIG-GUID: 9yhiGvdsaksqHkv8uc9kWGg2V7qlBU_O

On 23/04/2025 22:31, Bjorn Helgaas wrote:
> On Wed, Apr 23, 2025 at 03:52:27PM +0200, Karolina Stolarek wrote:
>>
>> I wasn't able to produce logs for the CXL path (that is, Restricted CXL
>> Device, as CXL1.1 devices not supported by the driver due to a missing
>> functionality; confirmed by Terry) and faced issues when trying to inject
>> errors via GHES. Is the lack of logs a blocker for this patch? I tested
>> other CXL scenarios and my changes didn't cause regression, as far as I
>> know.
> 
> Yes, I do think we need to say something about the output format
> changes.

I understand.

> I assume you're trying GHES on machines that actually do
> firmware-first error handling, right?  I found several GHES logs by
> searching the web for "APEI Generic Hardware Error Source" "PCIe
> error".  The majority were Dell boxes.

The only way to inject GHES errors I'm aware of is Mauro's patch for 
qemu[1], so I went down the virtualization path. As for working with the 
actual hardware, I'd need to ask around and learn more about the platform.

> If you can't produce actual logs for comparison, I think we can take
> info from a sample log somebody has posted and synthesize what the
> changes would be after this patch.

I also found some logs at some point, mostly from 2021 and 2023, but I 
felt bad about mocking up the messages and tried to produce actual logs. 
If I can't find a way to get this working in two weeks, I'll revisit 
this idea.

All the best,
Karolina

-------------------------------------------------------------
[1] - 
https://lore.kernel.org/lkml/76824dfc6bb5dd23a9f04607a907ac4ccf7cb147.1740653898.git.mchehab+huawei@kernel.org/

