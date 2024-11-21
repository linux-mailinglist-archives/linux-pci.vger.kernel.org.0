Return-Path: <linux-pci+bounces-17142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132799D496F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9351F2207E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3791BE239;
	Thu, 21 Nov 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CQPbPsIy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="COrLZheK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C342048;
	Thu, 21 Nov 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179766; cv=fail; b=oWHjTdCrnumi+7KK/Sub9g8Q+ckFzVDTieeWOpWFYvOBeA+x43WXGsQ7XFk6kI83YY799sZpxhysnQPdDIcvoay+SXDLisuJ3IO9ChYRRoJKwc9LEnNWeQ0X84TdV5c9y5j3f88vKKfgYapIQxkzmWSREft+vRxyGLSAZ836UVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179766; c=relaxed/simple;
	bh=H/V8AVS7IPMDOs41cKKRKdb5tjLnCajJAhoaPKhgwBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHnb63DAtJ1c4NsoS4Sxm2eqWertGv1Kknk2poCz8xvlmgz+8zx7CECa1rggLXjiaGYiRcllk0B9ZYRmBI9tekEwikFxbWPLEtwsl51ihxTvureAa1LX9v57VExltk8tUqFkMCC60PuQKrAJhibCm1mz7LzywSDD/LpmO8dT+Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CQPbPsIy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=COrLZheK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7Fj6n013249;
	Thu, 21 Nov 2024 09:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z1LfvxyXVgEuOGDUQ8yG7zUFvQSLHIAn/tF3DIFwzhI=; b=
	CQPbPsIysPFY0sR0/TOLW2DhR6FMELMHmyzDC1Tse+s+NSBoHgndjoop0LmxOV8t
	CwxMyVH0rD2HvfyzCHNRiuTg62Y/3lvWYdB7hkh3H5b/khQEo/MTppUagY6yVVE5
	/NK7+UBIoZdGAf0Fu2OQ0vuAsgU+M2CsotwqcnrqzMYbO2AU1AYntMXUja7j5/Vh
	R4ZYUGfNPaUGrJzm9qMQzq9zXpHw55PCsULc7xQ6bjB8MnA2rM4IYL5IMeBiOhUd
	6QYXB863dJuuZAxfqAsCV+Heg/S5o3E3ROvkJjX7VGJ6qzV/DYAk+rSaerIueJ1X
	hWKSGsFzPQW3088vzMO2IQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98ry50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:02:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8vW2e007776;
	Thu, 21 Nov 2024 09:02:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubbxx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/XEdHyOm0rbSqE8WgIr91k3Hya6ImDJYtzxO8okIs3GfycCzG7Yv0ZYat4xntQIwXv3EkU8WcmLg2a8AOO0KJeZWwf72BHOAMp3Gc6uYY0s3kp3563WshxZPB3dqB9OUNuPgJr4gieBaq218N7KWQhjeuO9XjF4xGHAw/mDSWvF7ACHG0kGNTw2P8RB3C8tmCtMAOPo61GCJXE2cFY6ynMrgRsntuBvrfmnKgl2M3+AOSYGUWGUe0IPEs+EgiBtDRXW5eQeUBn3TECUYNOQqw5h9QQ/gNg6LW0UHaqssvrA9t3dmIvF1MzM/6ECDjJ3sYFK+r+EYnkOaVrYGWjW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1LfvxyXVgEuOGDUQ8yG7zUFvQSLHIAn/tF3DIFwzhI=;
 b=roPlGsjEBAgcaE1cOsi+CtC7jUU8n3fc241/g7Mrxpgp9Cx6MSd8LYYQkEV09mYSv+wUJDPM/IpQK+WP6xcBj8HfWPsmtFZ301Y3yDqBS61zN6fyw3/5ckZ5wQ64OFivnDgyrvXfdCGpqrjAyu2W6VR7NzgJ00BuskQiR5YQZ0NkZ5dLIOPIr+Ul5n+STrxiscTMRV2eofHKEOL1JXxdAzKHrwyQlXivTdpwUJzAHuc6U6kvCjICk/nOZTDHaKK/CBzGzutGdjcuqKVoJRHtETUtQ6Giachlz54P38OB5GDkARcYh7BU1T8hcyZBNBeHR24fTc0p+I/83iHRrnc5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1LfvxyXVgEuOGDUQ8yG7zUFvQSLHIAn/tF3DIFwzhI=;
 b=COrLZheKZrhalb/TaqWS+GBAjR3+HSCndDdMuaH2bk0yqlW78Snz6tRNLF/qTaHCn8smNUM2grcHaoeynFvnrNGiZ6f55fu9bbnA4lQaQvdaup5gEVMTPJAyQ+kf8wGFwOczWCET+6tiXolfxzLCJThHUli105aNmQwAhYEFgzM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 09:02:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 09:02:03 +0000
Message-ID: <eae15480-403a-45c8-a8d0-4a34339d6b36@oracle.com>
Date: Thu, 21 Nov 2024 09:01:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] virtio: hookup irq_get_affinity callback
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
 <20241115-refactor-blk-affinity-helpers-v5-3-c472afd84d9f@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-3-c472afd84d9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc691ac-3988-4cd8-9322-08dd0a0b2a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFhK1YyLzJtYUVOcWpqUTRvbGtHRnZIOXV2MzhxUG8ySEdCYVIxVFUrcVpK?=
 =?utf-8?B?b0dyZnZ0YmwyMGRacXM4SXE5U1hENTRUZXhZQnVJMHI1V2o4WFhUZCt2cnNR?=
 =?utf-8?B?UlVEcGo5VzRnVzdsNlhTM295TFY2SnVScmdrUFBzbW9ZUElzbHhyRGxvK0Z5?=
 =?utf-8?B?RlhsUmNKMDJJbnhseTBRQ1pMZkI0bk82TGJDR3hJNEFYUTA0Ukk2Mmo4bXZO?=
 =?utf-8?B?ditzVnBUYUNUVUJEQzR2OUFSenFzL3kxcnM2b3FESk1jOTAzTTdRbFVDeEdF?=
 =?utf-8?B?UjNCMngrK2hqa1FDWjVTWVJxejNObHZTSkhoZDd5RnBxR1k1bUdBc3pWdTZq?=
 =?utf-8?B?SFVHWU9Dek52d29ONWxOZ25XayszS0hSR1pzTHFwNGVyTkpoaGV3ZUhhVnR0?=
 =?utf-8?B?VmY1SkxlUWYyeVBJRCt5QVlzQ1NEcTE5QVMrNGgrWGsrTzBEWXRsY2oxU0RW?=
 =?utf-8?B?WVVITTZTTDJ3WlZMNGx3ZGdvRk5SZzErUDJtTVYzbzRoNHdEbytNdnJTdDBw?=
 =?utf-8?B?TlFpQ2lLTkZPYS9QVTYrR0d2RUpob3B6cmw4RDBKNzdlL0VVcTMyQi9lQWZ2?=
 =?utf-8?B?dWVRTzZoNFk3WmRjaEszajhYL3RraFM0eDZMczFvSnZFQndkYkxuOTNvbitu?=
 =?utf-8?B?Q0pFY1pUaGxTYkVpTFJZcFYyTEZkeUFhWWU4Ry85ZHpKSmo3ZzRiR1hPRy9m?=
 =?utf-8?B?SGEweXc5eVpBS0pEOVAyWmNPcytvY3NBRVlmUTdZQWZJb2pxRWlJaXlTWEtN?=
 =?utf-8?B?aWtWNzZqaE9aTitDUUZJUFhZKzArYWpzNUZGblRoS3BoM2JtcHg2WUNYUCsz?=
 =?utf-8?B?eExZc1lOdTloTEhETXpaWlNBVjRvcWFVMHE5VGRjSllKNWp1QjROTlgvcklx?=
 =?utf-8?B?dEhHclErUFk3WTJoajUzTU1Qbnp0akh4TFdWdk1NN0RPbGZWR2FuRFVBRTZr?=
 =?utf-8?B?cEtIbUk5WSs3N05yTk11SWlnOWNmazZ2aFJsQVRod3BoZ0hkd0FYT3J0RXlr?=
 =?utf-8?B?c25NS0RtalYvaGFZdVZYRzBuRXE1dDA5Y1F3VTluYU0yMER3MTlwOEVMSzVC?=
 =?utf-8?B?NmhoMCt6YzZTOHdpb05MdTJON2NIOWVHMXVLZzI3cjBvRkhrLzdyaXJ2OFUx?=
 =?utf-8?B?LzdZQUtjZzRsUWo2SXM2ditpNkQyaVkzc0pXVzJ2Tk43VUlrak5jM2JTK2tV?=
 =?utf-8?B?V1lkWlFxM3F3eWQvWFlLWDREWEYzN2JCL2VteU80SzdiVkw4a3lwU1FiWGhm?=
 =?utf-8?B?MXdNUXU3eXd6ZTR3dkhvV2FFQUhQUlZja21RcEs2ejZidnphcDlpTG8xemw5?=
 =?utf-8?B?UXpoTndkeTBLS0xsTUlySmhFZEdHSUp4TndzNGJQYy93b0FHa0dlZGYzaXF2?=
 =?utf-8?B?d0dSMGNLMUxZSlpENmNoMkpzaDNYeHYyd2t3SzlDcUVIbHBiRXhiMmxSTHdT?=
 =?utf-8?B?SmY0Z1laS3YwZWs2Ym0wQmJrSmt0Y3dsSE1xMzh0UVJKc2dYNlhEZ3NXQXRw?=
 =?utf-8?B?MGRFL3Y2Y3dwUjJlOFFCcnMzQnRDdHRqQVlYaVdVaHdUM3ErZW5yKzEyeUpE?=
 =?utf-8?B?ekw4VDY1bUtJWmNKdHJqc2NZSzk4Mi94YXlMU2Q5S3pZYzNQNTZrZllLb0Rn?=
 =?utf-8?B?Q1YwU2FTQksrSlM4ZFREbTM5UEdFb2JoNmxJS3lsZHpvTWxtWFh5TGRXUy9G?=
 =?utf-8?B?VU9JTlFGdUx6R0hFVVU1VExhSzlaQmxFS1VBMjZuUDFFVnUyeTRSenh1UjdG?=
 =?utf-8?B?NDQ1ZEtqZHpFL29SL20rc1lvQzNzdkRORUIyM1RqQkxXbXZ6VkFoN0hNa0JZ?=
 =?utf-8?Q?oew6HV1I+q5bJrirZrWsl1O9GUvt5BVl0ZGcU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NueFhaa2pnSVU2UDhNTkFTbTc0T0NKQk82djZhSEtLR2ltU1VrSnMzR2tx?=
 =?utf-8?B?RXkzL0lBcS84N2RpMzdURVFjUU1rTXFNMnAzN3hCMUg3NFhxR2pKMXF6R1l6?=
 =?utf-8?B?a09UaHhDcTY4T25tdTdpMmFVY3QyUW9YM3k5ZUdPcXErOVNFd01ZUFppZU43?=
 =?utf-8?B?ZVB5bDlXVllocm5LM1poMkxINWJqRk8vaXNsNXFOV3hEd1dxWHpBTW5idXJa?=
 =?utf-8?B?d1lHQWwvMFZzMHVyMVJvSU96Wkxad3AyWFlhRk9kUmIxaGU3ck56OWd3M2Rr?=
 =?utf-8?B?d0paSmhFczNHR3F6M2NNWis4Q1pBSjlBUWJlNmtEMWs1YVMvZDg3dnJ4TnE5?=
 =?utf-8?B?WHRCMG45OVgrWS9UNjhRYjJ3L2JDVlNQeC9GYmU5bDhVTFRKK2YyeklHbDU3?=
 =?utf-8?B?RUdzWjdkVEJ5LzhFMEpDaWwwN3Nsckg1T2E3Z04vNTdSc2Zodi9zcGJZQkhV?=
 =?utf-8?B?d21LMko1NzIxRWswMHhwMnUxZ0NWeGE0RTd5WU45eDdlb1ByZ2s2TUJpVGtP?=
 =?utf-8?B?MlNYZ1JjQ2dlUndMTVpEMHZNYUxKTUpUVkI0ZDlYUG1oWW1SWjZCVzlXd0ZY?=
 =?utf-8?B?THFiSmh1YnFUcUo4Y2MvbTcraW01VU5WdnQzOHdGenkxVXg3ZmZtUjdvY3E4?=
 =?utf-8?B?TW9SSzhQOVhLZHlzNXljQVBybUlkVEdSSmc0cXhlcmRJOFpJNEU2NUhzMW55?=
 =?utf-8?B?cVZySFNTeWt6Y1ZMaTltMDJtazRsZDBjWWVUbmJzTVNQRVJLb0pxUDB2MFVn?=
 =?utf-8?B?c1hWaFlSbHlnaGtrRjM1MEVZYXJacThGMU55aytFbVJHV2ZLQzkwNXgySVdk?=
 =?utf-8?B?c2hYdXpTS0lFWlFrR1lQSXFoc0lPWDJLWkVyUE1ZdWZoOFo2b3F6QnM0cExi?=
 =?utf-8?B?cUFaelU3ZWx3WEw4dFlSR21UeFcxc0NxczVLWCt0NEhXVWRCUU03YzhJTXMv?=
 =?utf-8?B?Z3l4a3RPS3FRQVlIcnhnS2tyNVdaS29ldXJvU3YxZjkyK3FqSWhJWVhHeFFW?=
 =?utf-8?B?Zy9lQkN3TFFDTFN5U1hTVTViLzZ4V1FiUUZiY2VOMmJrclJmTHppd0JwUFBi?=
 =?utf-8?B?b2piaUh1Z3NDUDZvWXp5bGVXcVB0Y1htcE9MRWNFQUZ4OEd2ZDlrU3pFYkh1?=
 =?utf-8?B?N045MHR2M3V3aVdheXZhSTl2alkxV3RUaXliZDVORlZCRXVZTCtCWnMxU201?=
 =?utf-8?B?cTdBajRvOVgvazhMU0VFNCtqV254V3ZqYlR2U3IrOWV6aTlibENEb0dNYTk2?=
 =?utf-8?B?VmRVa01SclhwQ2ZRd05qVTJna05hMmR6U1RKZ1Q1K2JaV3lMNEpLcngvSGpB?=
 =?utf-8?B?ZCtnQkxRVDAyZFVqYTZ1TUFtNlRYVERVVGRlbVJMN1hSZWM5VVdjS3dpU1dH?=
 =?utf-8?B?dXBNK0RNaTQ5MDNUeWpodFRsbTNxWGZ3S3U2RkU3S0d1L1ZjNWoyZWp0cHVP?=
 =?utf-8?B?eHlxRWtvSmt3VWh6RHRiR2J5ZlZrNHFmbU0vKzhEMFBJLytlZ1B6Zm5HQzZs?=
 =?utf-8?B?SGxSWlFJYzhtOExpQmdqMFZtN3d4MWNrR0xOT2hyWXplUk5ad0toZWxPNGRX?=
 =?utf-8?B?OFRzK2RhT01PSnpjeGs4SEZBa002TTZXVFVMZVNtbWdsTVd3eGk2V2lmMDNm?=
 =?utf-8?B?SExrT2NLZFZGemkybTQyU09jUjdEZmQ2VjUyaDRFM0lEcHNGMW93Rm41Q3Vu?=
 =?utf-8?B?bFdlWUVkTmdEeUJmN2FFdVZjY21qUEowVTI5Njk0YzlWMmNFRUtpSHlVMzUw?=
 =?utf-8?B?RDJ6dFBOak94RTVkNlNHa3lIdDBsRkpMYnppTG5ETElzeVB1MzgybjRIVGZi?=
 =?utf-8?B?SWFGY0J4U3Jrdmg1ZFpzUzlCbEsxNHp6M1Z5b21RYVNrbzRmbDFDUDU5Nyty?=
 =?utf-8?B?NHdua2RERjJENjFiV25PdVNodlJiVFAraGR6RGNpQ1BwOWY0VlpIaXRmN3JJ?=
 =?utf-8?B?amhRZ0x2OGNZM2tUdUxvbExmdkxSMkpWMy9aR1lDcDdZQmRRZUlTRFN1MTZC?=
 =?utf-8?B?NnhKRWN0Tk9TVHZJb044dEdyM3U0VUpuMjh5UVFnbmRLL0o3SjliaG1FOE5i?=
 =?utf-8?B?T0FOK1VwMUIxTDFUQWJjT1BETlQ1UklYK2RDWHovV0ZIZW1jWXdwd3plRXoz?=
 =?utf-8?Q?DaDO1YgodICncpePiHGPGnlWF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nmB7J/TxaQHcMqlywNej2RW4LDlTpdgXf7yku7uPREnXYzAyklz+BYKbCPAKP+DhD4x6i0W40bzaxme7Zw//Y+oX2553SoEdwhOrWAUQh146CGLB7W+BpVLjL43hLZtMWPqYeMB+nl7X6FgW9DSeIOBIsSrLrpdO0mkky9PGMjAaSoQZCEKFYmQ1MFlgT0TgyJYCi86tc3xMH/kk1uHTLAb2U7E5XsWFAEO1WyyREQNIXio3dg8vG7M74qfewK/cRbHRxuPPyzVVgrFBfxX7RGPGOJvLYRPtWT+JF2FA+AHVIfhEYUbpkfWDk4ghYbRJ6LAv7SF1LnywjsdGrwT28ino8QUkiNPBrKNijWGLB2RRLbBLKMjGFbWl6cB5SE09FSc+YcucGpauTpBAeMbM4c2t6RqqQxLFU4Ko5YrJLOu5ApoOrIh2fc0sbuDRvlogB+HgsCLnFoJ2cVNlxFgVHf6pMjlKg050N7yR+Fic0TQEVCuqs4i+dUXP9IHvwv3+wlEvy6VgvxsBAxAToBvZl0/PeGi4Htj9DkWwfjsaw6RRDKFJpCq8Q5c7uDkC46yoam04fNqmjeBKZl18koqj6NbdOSrfmxmAW/JdhFZ7bQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc691ac-3988-4cd8-9322-08dd0a0b2a55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:02:03.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xa9MFfEEi1o+qIIt0B111EUivZQk04GS0jzaeYZ4VN4f9pdwSVK33eTZBUzlU1GCS5HqJEvJsJJ4gdSYcK+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210070
X-Proofpoint-ORIG-GUID: DAfVqD_TrF5pFNNJfKfeu6htvx4-BlH5
X-Proofpoint-GUID: DAfVqD_TrF5pFNNJfKfeu6htvx4-BlH5

On 15/11/2024 16:37, Daniel Wagner wrote:
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner<wagi@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/virtio/virtio.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..4ca6ec84cb092eac7ddf4b86b4eacac099b480cf 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
>   	of_node_put(dev->dev.of_node);
>   }
>   
> +/**

nit: does this really need to be kerneldoc, as it is static?

> + * virtio_irq_get_affinity - get IRQ affinity mask for device
> + * @_d: ptr to dev structure
> + * @irq_vec: interrupt vector number
> + *
> + * Return the CPU affinity mask for @_d and @irq_vec.
> + */
> +static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
> +						     unsigned int irq_vec)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +
> +	if (!dev->config->get_vq_affinity)
> +		return NULL;
> +
> +	return dev->config->get_vq_affinity(dev, irq_vec);
> +}
> +
>   static const struct bus_type virtio_bus = {


