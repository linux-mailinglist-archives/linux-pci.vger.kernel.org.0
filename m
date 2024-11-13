Return-Path: <linux-pci+bounces-16654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C949C7140
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D328A190
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339B1EB3E;
	Wed, 13 Nov 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XJ3EhWlP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0OQEpR3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7A20409D;
	Wed, 13 Nov 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505499; cv=fail; b=b6wVNZBP5oRI79A0PiXQXh3X2bWoozNygHJ3ZqCg3dGTxFWNRg31+rKzyF0Q2U8Yhsb/xd2vkPqJgUXwbqmcwzfEo8xMJfM3P4WegLGh/PdIpRdGquruV9zdyKrShjtENycSSTFvq6ZqqH3UdS60+tfGIMAfCzcGLXcpz+CUzF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505499; c=relaxed/simple;
	bh=8n/JOAu/0akBIvdIgB4Zo/Y/u/bIZ9cI3ADb/2cQQ4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mV15jcn7uOCADDrtR09JwUwxbuXwA8im4O+XJPlvRdQgvnn2G6yJZyUCCasXhg8deFn3y0QytdFq5OixJryla/8Q7QlAXhFPnWoSVMqiF3odOiNUfBH36t+UU5TyezgEJ/WE+/QhC4R4JJ55Si5I4262UHpNjfwanlEHBbqOT84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XJ3EhWlP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0OQEpR3l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXnw005278;
	Wed, 13 Nov 2024 13:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6bZuIl3CixR97VE4JDUNw8NEHaOnf7hFPRpkM6axfNU=; b=
	XJ3EhWlP2tzBf2waOcStiezlo28KlIqFvd+p2LbHzm/8vSlv2Pvs5h7xWWxq8gIT
	QAY1AfCr9h+0vKC2kPYx6NXux1cch+/CSW7U0nZqh2ub8Y6EFA9wRcKZb3Mc2cM6
	Mxin4+iJIXV924V507XGKzhbMO4tbVIpor3bHLDe3SRkM73s/ZPfVSJ/3EU0ASE7
	USqFTn8ee6XEPDV0bydhe71Hkq/u3/iKMTQxABOQHtRuIjp8dIhvHsBK1Iw7XDSd
	3vALQwhG8lNZfwoPhTvaeCZxtf0/SozGRIWg2vr5tpzG/Vad3SeyVTWwIbnyEgjQ
	pqXmEDSlYpMKNrO23YFkbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heprtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 13:44:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADBuWCD000338;
	Wed, 13 Nov 2024 13:44:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp8prym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 13:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fey5Yjl/jcB98fqiiUn2oRj8GKUs0HG0cfrio5EgHohMVa4onsEYpAzaCd8GAKhwfz8p6tljnr0sPLcYuwH1b0Ew1q4yToyFX9xG2AL9/9iwsiPRpaAo/nr6zp4R98LIkmxryu+0Dbcodbm53MCZbrQSSa3qTCuKrI8J8eGnjDco4WVcGOe+g7pjk+MDoTCJWQ2nT8Kf93ckS3te5fPuwPHH8prpbVAHxXSD7T8v/WK2yVfx5/pKbwIHdQtWJtrCLIN+HVm8mMWxp81k3JVrZlJdqql8/TFGzJPp+bCllPYpsapDmj6HsbHhi7dz3onpDmYyPM8buiGoyjkVNRHG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bZuIl3CixR97VE4JDUNw8NEHaOnf7hFPRpkM6axfNU=;
 b=Pk5XWTCDi1ecnkn/JYBtbyi++RfnjvW6AtihpfOBt/RBHugxZj7dh0S0bD10zhUz/c54CpJpI0Oag0kdLE26D5kuLQ7LAzwrBV+RfVDobPRAehhWHKiSFywRsSRQQ+99O3E3N8XMEDvKxZWTkv8lg3DkuFgWqn75hM2UbaLtocj8Y7SzqMmhf/ZkosAlj05WQ+zpQoj49lbisGCe4o9Bl1K7qTn9Mt9VCbxmFkQaw93uSLWl9ixD8HLRLi4pwEsh822pNW1XEok7lbd1iBQ5WlVjN5OGLgPgRfPPbHSHzl2gdKr90PWPlxuOnzebBKRJnKdOosRigYZj5TUPbL7zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bZuIl3CixR97VE4JDUNw8NEHaOnf7hFPRpkM6axfNU=;
 b=0OQEpR3l/U9h7innS1clwFkndUg06CkZ28SYskmyDqvm490oOVnzNjyL4BzQLYCdWAXs11SXSM1y/bT2vC4qmL46F8dbegHJhBOwVgmE3HlwGW2nZGfMc3lh1K38IPbSqV6s7+I3CRKrcfqIXDSW9XD0i2QJIXoNRpknx6tqSyM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 13:44:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 13:44:06 +0000
Message-ID: <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
Date: Wed, 13 Nov 2024 13:44:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
 <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6067f4b2-4668-41e7-d6bc-08dd03e93e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTloUVlJaHhvVU9RZEcvOWJ0Tmp5NFZGVnhIUXpBRFdSNXNZL1BJMEFWOGNG?=
 =?utf-8?B?SjdPVFNkQ2RISmdxM0dmWkVMTkxlOWV5eHhCdk52VDJ3SWFPY3MrU3dhK0lO?=
 =?utf-8?B?SkhDeXNSaHNGTEUzRXdrOEJ5SENtVmZBTnQ0Nit3RndsaXpTNDRKWUJIQ2V5?=
 =?utf-8?B?WHBEY29SRVViZWxxZVZzK3A4TlVRV0VYSzhMYWhLSGEyYUtRb2lmTEd3NlZH?=
 =?utf-8?B?aEFXcnJrT2FYQ0hqY2dHWmhUS09CYU9PYjlUWjVjNVNDMVBBQklvTTZKOEQ2?=
 =?utf-8?B?R1ROU295Y0RXL3dWL1RISm9UTEtObnlSaUF5VHEzR3kvdHJNU0xjQ0xzQitB?=
 =?utf-8?B?TTY0ZmVWbzhsNFlBYzRUbEQ4UUN6WGVyakdzS2ZzbVhMSkNFZUhpaHJtdGtE?=
 =?utf-8?B?WVJSbnRCSzA3TlBObXUxNkErRXNoaVJSNTg0dnBGVktuS1lJdmsxSTBVYWFH?=
 =?utf-8?B?QTRjNCtGRm9nUGJpdUNmQjJlWnlQdFQzT3l0Z3BnbGo1WnJmbGJqTVcya3NB?=
 =?utf-8?B?S3R2L1dkNzVmMFpqMFlNM0hDbTJCRXlJTFUvakhVeGV1S1R5YWpuNEVKeVhD?=
 =?utf-8?B?SHk5SlZBYWVSbi9sV2c2U0x6TlV5TmZIWkFKRGxUbmxHMytmS0kyVkZMbkk2?=
 =?utf-8?B?NEQ3cEo2WDJzZXc5R2diTmdFMTFHYnExRC93M0x1VVpWOXlGMkxIclZPYW8x?=
 =?utf-8?B?ZGVwcUhtY2hwRGJNRWNJUSs0emg1VU5ONGpxWitWeDNBakNOMy9XclNDUUdY?=
 =?utf-8?B?ZFp4OWliTHFiZmk0YTVEYkVSaWZzT3g2SWRXZ3d3RThaUEljVzU0VytObktK?=
 =?utf-8?B?M0dvQ1ZqV0w4bFlzSnVZS2w1ZjMvdjliWEhLV1ZsU0RTMStCbFhOQk9NVm5n?=
 =?utf-8?B?UUVPekpkY3JvMkZKcE5zREJRT1NFeXM1OXFKV3pqVGc1aEdxem5ienR3R1R1?=
 =?utf-8?B?bE5mN0s2M250b0dFNG5RSGRXRktqaXBmZnU3S0ZqeFFzejdLK1U0Zndxa3R5?=
 =?utf-8?B?UXdLdFg5VVl0N1ZBVXhjZmhHNWMxK0oreG81WFQrVW9zOUl4TlhCSUJqWFlH?=
 =?utf-8?B?aTY0b0xoem5YL28xWkd4bmd3NGlxNHdyV1B1RlF2YWlFR3pmTS9HM1JBRkJI?=
 =?utf-8?B?MDZnb0ZxaHJrbWMzZGM2OWJFWW5jR1JSZS9kUm9lSUFoK0ladElMbEVRbVc2?=
 =?utf-8?B?ZmFuSkd1amsvUXQvMzRaRVRaR1dUQlk4L1dRWmxCTGY5V3MrSTJhVTRLQUFa?=
 =?utf-8?B?Y2k5OHVDL2tiejdmQzJnSUgyZGo0bzFlVDZLbWtpZys3dHVwWU5yalp5bW5D?=
 =?utf-8?B?UTNtek9WSk9lV2dzQVZVK0NtNHQxNU5VLzVLdkNMNWtiRGR4cENMVlZSYngz?=
 =?utf-8?B?VmJvbjUxZW53QlFaYnc1Q1NCczF6eVNucXV3UFowMjh1VkJkTU1XckJ1QVhh?=
 =?utf-8?B?VThzTG1XdHRGSE9FNXl5L05qaTFaaFBOS213bEtFRGVpYk0vVG80N0dOMlJN?=
 =?utf-8?B?dEhlbWEySGYwL2ZRSkpVTkc1RldlbjF2eWJjMzRheS9pd3R0bGRyb2oySzEy?=
 =?utf-8?B?bjlUdTdPRWsrd3RKTTFQc203VVRBekk4ZytiWUFldC9ML3h6TlBhWlZsYTBu?=
 =?utf-8?B?SU5vSXBYUlVNMTRoa3M3NkcrcjdQUk9DemI1Z3R0QWwzSUgzVGdpWlVpK0gz?=
 =?utf-8?B?dXJsVkVBRit2bjhWMnFRUnpGT3NhTXhlT0pXeGJ0b1M1MTlDQmhBSk05K3dV?=
 =?utf-8?Q?R6ZdEO+QL1Emid28MNX6SqvPaJJWxcFPvdYK5DU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnE2N3lRWVBteExzalZaMHQ1YU1wbnhoY3RJVTNpVFFQemM5K0dsc2doZURy?=
 =?utf-8?B?WjZHV3FrN2Q0Vll1UExkVEtzT0F6THlNWWhiR1B5cHh0L29hc1VWVnd2RmJx?=
 =?utf-8?B?SEQzcjQra3VkOXVjQ1U0ck1udU50Ni80ODNjOURCMzh6Vis1R0l0N09ub2dY?=
 =?utf-8?B?dmdhTjNyNGNicnFIdk83bldWL3NOa1VqWGplNnFoZDBGWjVoeWZQc1B0Y3Mw?=
 =?utf-8?B?dDVObDZjZWttNE1Ed2pLdmc4WkNpRzRQM3JLbG8zZzc3V1lpZ25DVUdSWjhD?=
 =?utf-8?B?WlVaU3NWUytYVG0rYVFpNTRGVXBWVUhyQ3B1MXluRGgrdFFJaC8wNEZlR1FL?=
 =?utf-8?B?cXRJZ0UrY1plQ3lhdUltMEVCcUVuaUo2d0R2MkpTSlVRVHV5VlNuSkRRL2J3?=
 =?utf-8?B?TzJZV210UTV6TXN4RGVGNk83TmhJN1JpN0dSQUFBWFhyQWRiVHJINHR0UGk0?=
 =?utf-8?B?c3FTSjlRRXRvQXhkRjBvT2tDamlSbGQwU0FwU2hNL1hIQ0VqK2dvMzlkVGRW?=
 =?utf-8?B?ckk2WlJsMUx2d2hNczdBNGJCMVBSWEQ3WTlRNEtoSFpweHdwUzFrL1g5RENy?=
 =?utf-8?B?LzgvTHREbVpLTGtHNW5ZOUVqWjd1ZDdKWkpqK204RGFsRktQSzBFMnhwTzVm?=
 =?utf-8?B?bmxiYWlNRC9XajlPaldGTGl6Y3dkR2hXaWY1Sko5WE95eTMxanVrdm9PeUZ4?=
 =?utf-8?B?VnNuRXNwQ2F6RDN6aXB1QkZueGlMcXhrVWJac3lrcTVrL0c0Tlh6UURNUDBU?=
 =?utf-8?B?dGNReTNpbjlaUXF4ZVZYTW1xVG9XSmJ5alAyL2c0Q1hrN2NhMUxJTXNXS1BE?=
 =?utf-8?B?U1dmN0tXRVUyYUViUWIxN1lBQWwyR1dyUkpxUkhEdVlabVFacXA1ZC9DRWVk?=
 =?utf-8?B?UGdXU1F2M1dKeVRRRFhydnU1VklsVHhNK2lyZzVDSlZLWGpmL3ljT2Z6Yit6?=
 =?utf-8?B?VnprcGZwQkpsMnJkU0RsbEVaYndjWFZaemcxODBhZ21rNW9NQzBYbWo2ZHds?=
 =?utf-8?B?OUgxR0VNdDVSeEU0UDBlcExTbHdIZEpiMzZPa3p2K0FybDFWWmV4cmhXaHVE?=
 =?utf-8?B?R2tDTXBaRDVteXNGQk1jYlllN0lxMnlYVGdzdmtUTmtHTU41eUJ6U3JXWUdn?=
 =?utf-8?B?OGxwL1B1N1AzMkFRV1AxSGhzRk5pTjZkNHhyWWFKUVhqOE42YzlveGhxSGRl?=
 =?utf-8?B?Y0lUbVNDK3dYTlloUUZyVWM2Z1B3OW1vOVA5MzFWNVN3MVQwTmpPT2lEQms0?=
 =?utf-8?B?RFFrS0lJS2FZMmVyQmYzUjY0ZUFENE1vemtkUFFiZkFGTDhUS0VoU2RxWU9u?=
 =?utf-8?B?Z1hGQVI0TlVWSlJsQ1VvWDRYT25zQkRTUXpZYlNid0NkMDd2TVJRMTJWZVFL?=
 =?utf-8?B?UnhJVng5YU9VYmJ4eWZzRm4yRG1rNGR2aUc5ZVFaTGpPSmhaNytPdmdBWnhC?=
 =?utf-8?B?eFgwWWNXNi9HaVZSWC8yM2xVZEVDcS9qSnl4QzJ3VGovNkVTbHlLRVQ4d3hs?=
 =?utf-8?B?eWxYOElmdm4zODQzQmMreDdLK0JyMjB1SWhnb0tTaUFzSlRXZ3FPczIyUzc0?=
 =?utf-8?B?T0Fwam9yQ290ZnBrNGZTd3oybldQWVp3VE5kSURyNktqbjJ5ZngrRDh3NGFR?=
 =?utf-8?B?VUhlUE8yWHg0M3BmNlY4ZnhjR0pDQjZJTUJCNUQ5dTJRdzQxRktNbzRBQ3VQ?=
 =?utf-8?B?TGRFZG5MZmRlMTJINlhlQkYrK2pOTGtMYnBBZStXYTI1MjhtN0pFSG9UcXdO?=
 =?utf-8?B?OFFzb2dxVU12blg4bnh4SEErTG04bmUzVktFVWVsNUxTSTR0cEx1UllKWVRO?=
 =?utf-8?B?ZHFLV1NucDFMenpmNVJsYkRjTmhJUlBLMHVDU2xVRWlhYTF4UkFOc1lpb0Q1?=
 =?utf-8?B?RTYyQVZYUDE3UmxrR0lUc0p4ekYwbnBrLys2bno5N3h3K0ZCNzBuNHdYbnBv?=
 =?utf-8?B?VStZbUVDcVpwMW9yZWNLU2h3ZmczUHdEZGtUZ29tVFN3bjhJSWdMa09UVndY?=
 =?utf-8?B?L3dLSEVGQVB2eExmOUg1dGdoZ1Q3Zm5aKzBRU295WlNaT3R1VHkrclF1a1VE?=
 =?utf-8?B?YkpVSDVVTXIvMGVNRHJkbU15M1BEcmYvSnNWVlUvcmVmd1hQU1RybWRpei9w?=
 =?utf-8?B?Z2I4QW4wdEthbUovUUdiRmRGUXlsK0JHdk1aZFhKN2k2OFJEUkFlT2xLVks3?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AzLPKGdo/BaqhbjS98fbeLH27al8MsByigVQuKlgJ4+Nd0wBAgwAxP9PXi3JcUALFjvwrp936aAlUZW2fSfOEP80a3U958BdsR8xvJ+dNqymQVBRdG7zoMl0+NzECWWXydlyGCVMaLZ1bXjC0YOCM0ddxNSrFTY0/jGzN9b7hG5hMaDwRj7YcMy6u9qHa22vXiVZUKnMKQ2I2xkZnaBZwcMCy0tHzC7ESbF5Q7UrxQpqI0gzkb6f9GdlWccxPNf+dKV2eDUTFGkUyfiwajMSgczDiSUaBVAivVx+JBye+EmFEbWNQbY87LGn5rWOUaTuL1dA5uLN6JM92yaf8DtCRFQVkFnbZemVl+tokXZOJduCX0No6e6YA2yHcmfUcxvpn6ycdhwUiq8Aaa1rOhEGPOcVEiJ1fzaZCjJ/Oa/rEpHg9kfShRe9sDqW5KwtCTTWRjva7cHX0GUtGTSZhupn+PP1jNW/e14vUr8anD22AgI9YDF0GRgWb5w0rKTLPJeNGmuqvLR1lYhVhJWda6AbSxEIiLOE0Le1TCn6RU/MEtIB2cV+yVnA0IBIOImFRvcmE6GXOXdge6Vx5GI1LmEfT72iwESc4pVULYwJ1RoBu4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6067f4b2-4668-41e7-d6bc-08dd03e93e4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 13:44:06.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z1ItAJz38PwCVolvBNevaTpXs03DT+W0wh05lT+cDKmLVNK9+aF3EVGcKh836qrJ916EeOPMp4o902zyIqZaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130117
X-Proofpoint-ORIG-GUID: lUefPyeh946GaKJ65OAqMESLSwUlvz68
X-Proofpoint-GUID: lUefPyeh946GaKJ65OAqMESLSwUlvz68

On 13/11/2024 12:36, Daniel Wagner wrote:
>>> @@ -48,6 +48,7 @@ struct fwnode_handle;
>>>     *		will never get called until they do.
>>>     * @remove:	Called when a device removed from this bus.
>> My impression is that this would be better suited to "struct device_driver",
>> but I assume that there is a good reason to add to "struct bus_type".
> I think the main reason to put it here is that most of the drivers are
> happy with the getter on bus level and don't need special treatment. We
> don't have to touch all the drivers to hookup a common getter, nor do we
> have to install a default handler when the driver doesn't specify one.
> Having the callback in struct bus_driver avoids this. Though Christoph
> suggested it, so I can only guess.
> 
> But you bring up a good point, if we had also an irq_get_affinity
> callback in struct device_driver it would be possible for the
> hisi_sas v2 driver to provide a getter and blk_mq_hctx_map_queues could
> do:
> 
> 	for (queue = 0; queue < qmap->nr_queues; queue++) {
> 		if (dev->driver->irq_get_affinity)
> 			mask = dev->driver->irq_get_affinity;
> 		else if (dev->bus->irq_get_affinity)
> 			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> 		if (!mask)
> 			goto fallback;
> 
> 		for_each_cpu(cpu, mask)
> 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> 	}
> 
> and with this in place the open coded version in hisi_sas v2 can also be
> replaced.

Yeah, I think that it could be plugged in like:

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 342d75f12051..5172af77a3f0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3636,6 +3636,7 @@ static struct platform_driver hisi_sas_v2_driver = {
                .name = DRV_NAME,
                .of_match_table = sas_v2_of_match,
                .acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
+               .irq_get_affinity_mask = hisi_sas_v2_get_affinity_mask,
        },
};


> If no one objects, I go ahead and add the callback to struct
> device_driver.

I'd wait for Christoph and Greg to both agree. I was just wondering why 
we use bus_type.

