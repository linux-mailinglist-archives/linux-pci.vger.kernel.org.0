Return-Path: <linux-pci+bounces-17147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D03D9D49A6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D20B24EFE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03159147C79;
	Thu, 21 Nov 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DEMNePL5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ltiGSGg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A814206E;
	Thu, 21 Nov 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180291; cv=fail; b=BGGhVg0LCF83ZJAHlBxoi1cstcMvcQ29hplCTfs2W8aNsBowQSBot+jrKfR1YXCqJ9o8ttAHCj3swh5XgrClFv80D/eUUJZ3h/SM5Rpm+bptx5zhdxDnfQfnPWkkYZF8b1UC5fWyqXowaCzfGLks+f/Ds/cwG7NrMnVnLpNYko8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180291; c=relaxed/simple;
	bh=PzMS5wIJFYkgxwLGMQkiw3kJDtBr36TlNmseHpiKDKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B95117ZjCGtecbskDC/YQMGDnOt2q8O+u/cDie5/A3tSdZG4EQKpsyJpyRJ/E0GzpQq2QflcVrw9kOJx6o3ccgJvcmnBN0ENF95JF9SspONhwheWjXHI74dFiXJhv0tZey/xKW+v4ilTI311KDx2ogr6sXt51t3udJ8SWENuvLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DEMNePL5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ltiGSGg0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7FiQ9007044;
	Thu, 21 Nov 2024 09:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IK0bxwtAhVQ4OVON7Joba/DVEN67MUgKaYvYN+jVdQk=; b=
	DEMNePL5v03Y2FNSe531cls14th3YPzwWIvUqRBsJhok98nmE7IZJW4gyV7av9A2
	Ky2eda7qsQE2q3feRpWAoQjcPEwkWlWiSbH+DK++s+h0kH8y0xivHJfw0vC3RnJE
	JMnNRYZrbGdOCrODCeL5m0j/N+d133GGC5qsc44zM0X9TLitiRfkuj+iyYwlDCwR
	UWS4bQfV6GMwZGGTsjD3IfuucaxpnSWLuprwXmSquRhEGocZMpAxB5baY3FFxw4E
	U72ICDXitLUGDVAPeFFVK2WJvjqiYQeWabpp3Zy9rkpv3clwo88FREU1YNn9JaVL
	0hH6PWlnxVctEiRLaBxJHg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa9680-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:11:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8gtTL036971;
	Thu, 21 Nov 2024 09:11:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubdmtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/UOn3fvf3Zx+rZ6W7EaOgfwh5F2TyGPrajHwvODz7wP3UuuM57QgDFxEOCtmTig8mJhHRTvZXGosG2FcsheBZV0UWRe7OMOnSoAhw9Y4zwoRD3VwZt/pJvSk+W5oip9QrMhG2IQGX0HLDPOG/oQN1hbzJwFtf27LzMT+wlNsDIjEC590NbhRrz6dbl7qP8qjxSbTNUMJoVBQmEpwVFjywrRzzTYjK4iTsmz3iE5xYy0Xxjzf/YyHr5mdGGFxPPpxREOWR9djdrhSAKFELGaSGwq9kUZ4e+7jplE8BwQIM4XUN36Cbj5cKPrbEAV04Jdd8uadyGL1388Q4sHHXWrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK0bxwtAhVQ4OVON7Joba/DVEN67MUgKaYvYN+jVdQk=;
 b=xgbylyDQqokq6pAlLJRH6oRPua9uomdQWHgZh0DviScPwWsUX+EhwUQEyS3zAAatCAjCds8aVTWENcVytbHNqWmz96e/mkLP0p4p2mVc96mGjgkw9efAiRqvLmpB5NVRevED6DhZRH6K4e0Dv0y2oZOuYEirWf8YGQCVoqmYNO4nvrDwClReExl66RCSleqVYqoPqpC7pVL3Ztrb2NQPnzn4jKDZ2pk7kqjuoiK7oWOzvi2XfQIKPQI5S24dCqdY+Uk/p4MEaoX47+T3MPvjpbQV1lYFpLa+yxpLDg1gIhXrLNwUQ8WMqmSOJpDq245S2EGWqaGyLPSdBho1EACesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK0bxwtAhVQ4OVON7Joba/DVEN67MUgKaYvYN+jVdQk=;
 b=ltiGSGg0GXdCQVC7BI9FrUTO0Kx4gAU/Ezm0++GzhNuW5YV0HivXcQOCHPj1pE4XmlR93pzphPBTf5mBtBOuwfmKnqvfMrOU1cgMMEJCeIUZKI0DazHwAKIzpq9xhWT9yahhMmLlD2iVjUjSMjhu6/fwd1N4qkJ/9oXMN5y3xwg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 09:11:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 09:11:00 +0000
Message-ID: <edfa40cd-5e45-423d-9ea0-359f216ef59e@oracle.com>
Date: Thu, 21 Nov 2024 09:10:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] blk-mq: remove unused queue mapping helpers
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-8-c472afd84d9f@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-8-c472afd84d9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: d9180b1f-24ac-43d9-2a71-08dd0a0c6a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2piaDdiK3RmUitMSXd2Z2JuZFlUSXhraXRMS3R1WGZtaUdpYmxFdE5CQXRO?=
 =?utf-8?B?eGxYR3ZSR2ZTdXFGZ2NBdXVzdEhEOHJOU1dheERYTWtWZC9sT0VkTG5nMTc5?=
 =?utf-8?B?VWtmcVlQQ1V0U1JScXpPUmpjajJlSlVnem1ScmFVamR0NEd5UTZHVGRrRllq?=
 =?utf-8?B?R2NVVWhNdG5Sdk1FbElmYzR4R1hpS0V3SE1hOUtWK1VMTW9JVFBYU09Ib1Nk?=
 =?utf-8?B?UW9LT1Y5NzJ6UUhWS0U5Sk5neUlQUGhCeDhLdDRyMHN3M1Z3NnNkaFVBdUhr?=
 =?utf-8?B?b2NBK2Q2czdYd09ZZ1IxM0xmMy9VVi9qSVBMdE1JZGJWaGpod3lIclF2UUNl?=
 =?utf-8?B?T2tYNHZDTFBhS2lMVVl1YThHVTVhUVkzRjFidWFEb25Gbklwc2taVHNDYWVE?=
 =?utf-8?B?Tnk0cllTNk8rWG5meTJZZXBOdXNzbk95OGZBYTV6OGI3NHlDWkxFSXJWaVFj?=
 =?utf-8?B?ZmxKenM3NmVVV3ZzSERtNHkwbEJkbHdRTVRjUnRGc3pIOXFHMTFJMHpiT1FR?=
 =?utf-8?B?Mkd5djM5cXJkelVXZjlqcWJkaldEMDdPdmErWi9tazI0ZzI0c3IvRkFqaFBV?=
 =?utf-8?B?dTlYVFpGUFVESUZBNG5USHgydTFtQXNSNFpoUzBhc0tDaG1DNGZFWExZV1RG?=
 =?utf-8?B?Yk9NUit4Q3o0Y0s4V3JCSDhENlBOTkc5MTdaa0VjbUVxU285b1dxNmJTam5V?=
 =?utf-8?B?UTRYalV0V0J0MjVTQzduUEorN2RCb2hCakJVVVVoSjJDSW93Q1Qya0FRbVFr?=
 =?utf-8?B?OVdDSE1HVGM3S2JrUUkySlF6UURUam5zS1ozWkVUVnpKbHdXNkJTc2p4MUE0?=
 =?utf-8?B?b0pxYU5oaVVyVnQ0SmNjMU04NzNyNEZRNlZuWUVmWWRDM1hOckZvWEszTkN1?=
 =?utf-8?B?cTY2UDFkRHlpK1F2R3BuYmt1ckw4cHpmSVo5NGFsaXB2cVJGa05Nb1lYeUF6?=
 =?utf-8?B?Rkx6ZWkvdmNzZWxmNDFyRFRHUGgxQWV1R3RGMWxEempxdi9HNE44L0ZUblh5?=
 =?utf-8?B?VnE0OXVZSUV4bFQwZkFNUXZnNk1PS3JKZWJHNCtYaTRhZWNQQUVmbUEvNDI2?=
 =?utf-8?B?a3N0TU44eXBRNFBWYysvY1F3Uk9GQjZBS2FLVzA3SHVuTDlBMnd3M2dRd2FY?=
 =?utf-8?B?dzdXcFdMSkozTjZ0cjV6MnlpM3NxR0o1UjRGS1VqV0RSMHd6NFdmYWo3bXBN?=
 =?utf-8?B?Uko3U2pqVDk1TytYWUY3RVdnUXFxaDg5NzZReWFBbllKVW9kbTVqemloTC95?=
 =?utf-8?B?SVdyRmFZTFVOSVJ0eW05ZVBoVTRyaXlSVTRUNzRVNzYvZ2FIWnEydFJkTE14?=
 =?utf-8?B?ZVhRZTFBZ0QrNlg0ZmpyNndCQmhFU2ZZUkdPbnBxS1RQT3ZhM1NsTmU5Q1ZL?=
 =?utf-8?B?L1VleksyYmRxVWNtVkhFVUlXQWlheTlFeVhJQVlTNlREV2ZoWkJEOFBaS0dJ?=
 =?utf-8?B?QlIyNWp4Y2Q0ZExSWWJxYmtQOVlTSVFMZG5VUlRiOWVlUmp2YS85NVgwUnR4?=
 =?utf-8?B?MUYreHJCNGxrMFJobUhSMlFHbFNVNndwUSswUUlWSGNKS0FYTjNGMFFpSDRq?=
 =?utf-8?B?enBtbzVOSVpOcXN4SlhuRTdGMktOSEY2RXlpMVUyeXZOdEZ0WFlBNkZDV0hq?=
 =?utf-8?B?eFdOWmJLUFNRWndWNTV2d0JTRGE1MFJRVFY3QlNUb1FTRk93N1B6Z3dPTS93?=
 =?utf-8?B?dWV4R0d1VXZMbmlPK3FROUdIelZucks5RzNLTGIrc0RBeE82YlFjTGpSNE4x?=
 =?utf-8?B?ZEdqSGZNWkYxMmRBa2Q2REJNSy9oVHo0aTUxTGhPYnlod3E0UFQzMWgvZGxW?=
 =?utf-8?Q?Cw7NDEWgaJsRSTFL9j1GEZl/bO3etd0afo4R4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG93dWliUWg0Q0gvRFBybWRFdnFOcm1TWncvcUgvNEtoUHRDM2trTENEUzJG?=
 =?utf-8?B?K1hLeWpucEJsc0Y3aDl5REdxQm1ZMll5c0VibTRYMlNQUC9Db2dSeVNWdlJr?=
 =?utf-8?B?OUlncmRWODVzcWNyRG1BWnhvb2pqRTZQQ1BJclhXSUlVOTAwb0x6YTkyR2ph?=
 =?utf-8?B?dDY3WEp1dDVjQ1ZMUjk4cEwxUVFuY1BFcUNhSGNMSTRkdkQyWVlrL3R0dzJz?=
 =?utf-8?B?dy9pTk1HZFYwUUUxbEtTa1haejdteWRxamVFRGp4VllTcWk3VFJ2U0FHSEMz?=
 =?utf-8?B?MDBVRnltMnNVUmsvN3UrUWJySWJzcXRQS29uRlluQ0hJNVBJU2huZUZPUlY3?=
 =?utf-8?B?VVFHdGNCL2lxUFk4YkdzM2ZxNUNad29McWE5ZTVyZHNNSXdidDV6ZE55Uk5y?=
 =?utf-8?B?ZkxERmdISThaTlNDYVhMWkZnQ2NvZGRqN1dZV0xieGtSSW9teXdLUVl0c1Fz?=
 =?utf-8?B?MHJZRWlkdHdoZXNHekZUaFYyc293bkVqWnFDbFc2ZGNPQkNPdzFRVDNodHRO?=
 =?utf-8?B?NDJxOG9wZnYyOXEyTVNNdEQzaG42UkdWUG5UOWJWSzQwNDRZN3hqdWhhM2RV?=
 =?utf-8?B?a05xN09zaGNNY1gwQ3JUQjdubDE1ME9PdnpKWFJyUlU5ejZNWEg5UkdtZUh0?=
 =?utf-8?B?YXl4Z2VzcUEvbzhhN2tVeGs3UVF4UlVnV0ZnbEFhcnZETWVpK0ZwekhxT25C?=
 =?utf-8?B?VVlYbDhCa3pMdHE2aktCMXBZQ1l0NXdVUDVISVluQTdtT1lkeUpNdkZEbWRa?=
 =?utf-8?B?WlFXRFZnMzEySHRhTmJwdHNZd2EwUWY3blBXejdBQWpIMExLc2t6RTA1RVpr?=
 =?utf-8?B?TGlnYkZJRHpMU2pEVWhhK2Q0WmdNbHVzZzZiSXNGUVZ6ZmNDbExpL2cxTXE2?=
 =?utf-8?B?VCt2QzYyZmVsQ0ljV1I2aXc4Ymc1UGFHOXFBblJ2Z3Y0Uko0N0d3OURhdEpQ?=
 =?utf-8?B?TGoyMVUySjhKTHF1Z0FjQVcwWEZUanl0anp1TnpicW9qcnphRlphTko5NjVr?=
 =?utf-8?B?ck96VmdRWFVwOXdiaG1vbitnR3o2OWwvNm1NOWhNOUdza1FiQzN0Q2ErQUFJ?=
 =?utf-8?B?V1EvSUtPSjFVajhHVVh6Q29uTmgybEZKajJMRHZzM2Y0NUhPUS9mVG5OQmo1?=
 =?utf-8?B?SEZQZ1NYQUI3VjR3TTRtdk9jMFU5WUlaSjFnb2NoaVVjRmZLekNCL2VVd2Vl?=
 =?utf-8?B?Nkd5UHFFVlZmOVdxNGkrRmowT2tzK0hHcWg5OXE1MXRhTG1NOUFoT21jTlBy?=
 =?utf-8?B?Q2Z4NCtZaVJ5cmZrT29zTXJwelBYWVVkaEdVcWRTL0NzKzdNcXFSd0l1Sm9u?=
 =?utf-8?B?SGw3ZTVLSE9DZmRRSmhRZm1yUGVCa0prUllvSGdTZCtrWlpIOUQwZmF5ampY?=
 =?utf-8?B?aldUM2JTUlkzWDFHdUxhay9udW8yVlVvZWE0T2dmTWk5elpyYmxwc0tKVmor?=
 =?utf-8?B?MW1sU3VuOFA2NVZoSFEwUE1VbWhHVmdYRkhBLzlUck03S2hkMllNd2xxRzh4?=
 =?utf-8?B?ZmpvcXVVK2YvMmRDeHVZb2tUV21sbnNHNjltQnBoVlJpcm9MQzNBSk5KS0pW?=
 =?utf-8?B?eHpBRTJDUVY5RDNEaGJFcU01Sms1Y2xkTmFwVTdELy9rK2MxbW5KaWN0RWFi?=
 =?utf-8?B?RTZ6Z3A3U0NDdzVScCtxVTJrNEN6MzYzT243YzNxbnN3S0o5T3AwME1ZcEtU?=
 =?utf-8?B?cEt2dW5CRERHcVdNQnZxQURDSVlaZVcwU0NYd0YrdWJybVV1cW12R0d2YVdE?=
 =?utf-8?B?d1JUQ1ZYcC9GdWJreUp3ZUlJQ1BuOEVSR2l5Zmx4U09SbGl0MDZYU3VzTy9j?=
 =?utf-8?B?ZU1RSnh5cGVrY25VeGRzMnA1Y0tNMWxZQW9xTWFqbEYwQWNHbjRPamtDaTZt?=
 =?utf-8?B?M0hIanJDT0xzYnpIcUExMjNGNDlmWnpnMElzLzJrTzVuOHNsSS9UODJMUlBa?=
 =?utf-8?B?L3F5VVN1eExXYVpzRmlBUDBhcmVwRXc2cXBBOXlLaGZHRHdsRkhaUnB4QVNG?=
 =?utf-8?B?UWxXa1h3ZzJzU2p2NFFqV1ZLRlRMaWZSYThVNFRWaTN6SGNpb0lUV0Jzckt0?=
 =?utf-8?B?clJjbWNWdncxVTl2UDU3ck9vL1Zaa3lQYms5cUFKaVpmaGFsNGhSUkIwUWpv?=
 =?utf-8?Q?2nH/fs2x5GG05zYm183pAhsue?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GAbMQUMOBkW2yfNFb0C/hqPzyUkL+tnchZfsn5rrUEt7ZziWq5lcTGwat+Gp1E095lwyK5a2NNg779o9FRy3TVgmazrvfuXSeKdPK1RK/fJijLsBDaOwcXGVmwsPbmDyb4417+xkko+/Pk8T1xZtaB/JOyb3KUUh8o/H+fB8ejA6+e1STYvjnabXbIJNLSe7K38Y6ntkDiuNbsbw1ef+5qSciwiQ0YUj9sIt+NydndyJhWIpcHLFeLb/WBCtFe022f75gccTpK6PHlmW+l7UTO0o1leQe8O7qNdJm90OQhHkw012iT/L+7GjNrMltzYKolUIasT5NNKv60XfKRM1brsMazgPraPvs2mRXFzStGPO6eYoIBlJKNEgUAt9fFjIhnviY/ECQVcJPTToUTEyu9mc2WcQX5OlTh12ZGDQ6wcELPI+2XYgslfgrt5Mcwvumj+/8rezHALyASISznQKILQqdQKmAoFYhMrkbyiUWXLFGBawGWdVxAEFVfM3vlnh/CClq+aYHDqySy4+T9rSkAtjE/Wqef8UIJ7UoCCTmvBSJIgdZWMQUUq9ZvPbfZFfTkEB50hWbLkLh+rTdPIo/goR2EClNiap0R8ZgsaV2vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9180b1f-24ac-43d9-2a71-08dd0a0c6a78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:11:00.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uhgj2EAciRSo5MF85KQ6pa+H9mL/SenhEHDUslVapXw1Ph0zlgR4I7jpvqGKTv5QMMlBSYFGtMyGCTmaouu9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210071
X-Proofpoint-ORIG-GUID: ntwmA2Kk3yWQh7aZw3dJXNnomQfGN4Q4
X-Proofpoint-GUID: ntwmA2Kk3yWQh7aZw3dJXNnomQfGN4Q4

On 15/11/2024 16:37, Daniel Wagner wrote:
> There are no users left of the pci and virtio queue mapping helpers.
> Thus remove them.
> 
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Signed-off-by: Daniel Wagner<wagi@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

