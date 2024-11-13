Return-Path: <linux-pci+bounces-16634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78A9C6C6D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4ED281E2D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AF1FB88B;
	Wed, 13 Nov 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZX60qiGe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iqaBhctc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315914EC59;
	Wed, 13 Nov 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492629; cv=fail; b=mZkr/rQaePEEjjrInjzsmMDP2gw4ynQzsaLtWfbki18oyX3VqNV2hWEv1VD/izSD3t4/MmzmZLkMYgB+jqt1RZj5J5B3OUd49OgwyXIPU7NOdp9eqyjKIWVX0ebvoK87NFZPEjh4qLwBP/njLly0lPggOKXZd2tOQ8HoJKUVeiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492629; c=relaxed/simple;
	bh=cIpa9DZ1zwTvGR5dQ4sss9eqn1q83TdXRPpiL1cVcWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+yQhBQ33exdtYB33taV+eb7TvkiOalfDlQfQdavFmxES0YRimI4uwXaQ7T8mhY0olI6AWe49mL+hbhJ/y9LESP6Va5/rVTOSd7jC7jFzkGoRuIAR8k+fs0UtXMc0+hAM29bYnQ3Yy/ajKDoXJHA2sJmwreDaaUsa1wKx1IWrYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZX60qiGe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iqaBhctc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9dvqh003385;
	Wed, 13 Nov 2024 10:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zVU2d8HG/72ASEXtiCpxDx+US9fDNlvQpzhtSkhPqbI=; b=
	ZX60qiGe7e/zUwBzvi+nT//q1k2Ke1bGUC7R8gXk2CMP6NxoQDoOvcrHll4jDnxI
	Ic9NdO3SEkK674CSQTBTuFhMMKsSiNgVsNhLUlMjq3CfTWYI3opDRXoMAHvFcnVX
	CYQjBZ4yMqOq8A1j+/TCVqgE3qD7Lk5AhlOOxBmTFZQNxevhe4tUF9KuYPPPeUBW
	6+TiQ1zjyGgPwVnRZcXKuFNsiE6C6UH0FJ96wJHV+VcPeZBNLXXPluGGlxghJs5s
	89BFif0FA9PUCrq92vS8orzYVj0z0QYEjOt6qbxHkVJWjMUKjeoMa4w7GuboP0nq
	N/xbCUH+xgt+1/On7tQGXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4g1ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 10:10:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9lGSY005652;
	Wed, 13 Nov 2024 10:09:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69dutw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 10:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEKAEBhi4+Qfg3dOwJhX7U/EDB6z3S9yPjpuuYq7q4xZy67j+ECLw0pJ+v08J6N0zRadhTABYbwwAMfFprbDC3fp7qUhNd0EWreI/w1Lp3GXiLlIOniJOrKQ2m+AwKLXj5ifV3htR4rRlmDxyVbDlbFR+5oOsHk8ttUIhosaDwKNqjbccorUSVAMIESztQue+tTCpY1rskkBc2Ifcsukm5EYaToT1MGRUqlNVmGQnxC/SUT4/8P4g4PpO9fl/Kn0jGpmzZjZnEnw69mxg/5SuibQ3+OVSE6Z4TRdhU8HacRXcMKr/2hpRkBybFY8r+Pt3cY85B6j5MqTH/dBt4UGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVU2d8HG/72ASEXtiCpxDx+US9fDNlvQpzhtSkhPqbI=;
 b=p8NTh+fyXjj9YVJ7TN15gMmo26x5tiBMaDmTY1+YgYYDKNPIt3klQWmOWcDnkWQn9irC2sEi4Qmu2K8fiT/aCDy6y5GmUlC1b+PllEe6EH8K7yt1FVnqOFaGTPSDLoFBZyjVTGaLZEpeLPnWmHSjxS/ip5QlhGJ7SbZkQ3MpU+Xe7sCXgTmnTfQPl1RVUowdZ3VxMu2uCFDS5Q/DpIUKgX4eXTAbBVETPJ9MX9mDjb7w4lPbl1SynfsS2qQfcw3IQfZT9OcEGZNmh7mC+1e16k462p1qs/7IFvLDYVAoF+R67/sEeK0rsJvfx9bsKlUBHcSKV3BXoaKYjcjt5N1K+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVU2d8HG/72ASEXtiCpxDx+US9fDNlvQpzhtSkhPqbI=;
 b=iqaBhctcgU5TBdj33N03laEELiegEnnxWxVvaWcKaizIsDqubxyPlu/TAoK8uu3YoDgmPW5rPRgme5pfDt2AMl6k8vyaFLn0dxN4RKH4H7pm7EoOZby0lYENZk6i6g51h3uEkvLaimBYgAakn4AGqC5kPyP4teqBJzqEkyD4Epo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 10:09:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 10:09:55 +0000
Message-ID: <c06cdfae-8a0a-4c7e-83f2-c78196ad83ee@oracle.com>
Date: Wed, 13 Nov 2024 10:09:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] scsi: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        storagedev@microchip.com, linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-5-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-5-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0393.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::20) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bf1725-d025-40dc-f2e6-08dd03cb5206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJ0YlhhWGkxOGNrcFFVWDV4TlRxWWlkRXpHeVVFT0Mzblg2N09DZG1NWUtw?=
 =?utf-8?B?azJORkNYRlI1SksvVHh4ckJvRTVEVE5FKzlsYWc5UUtaRkFkMUh4TVY4ZTNO?=
 =?utf-8?B?NGh4TDk1aDNqTGJiS1RBNW1ueGx4WTU4NFlsN0RzdXFQN3ZQVWxIU0hYa3RY?=
 =?utf-8?B?RCtjTGIwNnk2MlJ2MmFjOUV5NXNEZVl4Q3ZMRFdyNWdXYTFIKzlxaVc2aERH?=
 =?utf-8?B?bDcxRGFRNU1pblJ6R3N2R1Z1cnRSOXJuNC91L2ZjMS94RTBxUFkzdW5sSExT?=
 =?utf-8?B?RG5JV1V0bG43R3V5eHYrZ3ZUUGZaazVBUEIvb2hyZ0ljUFNTalNjc3VvdVBK?=
 =?utf-8?B?c0t4NHllU09mS0ZtT3ZEa1lqNGlQNUdEU3VhZzBwQWd0NXRHZytQMzRUREtF?=
 =?utf-8?B?MG1Ick5UMk9aMDdMVHZoTFV2Wk9SNmdTcnYzcUh1Tm5YSjd5YmFBOG5Kem02?=
 =?utf-8?B?Yll2NVlHT0t4L2tYRFViUU5vSE9wOTZpSjFNcm9iRkcwb3JZTlh5Q0F1SnQy?=
 =?utf-8?B?TXFwSGVnUHhZRUhhRFNWMThETUtUNHhtbnNBME1ZLy80TThXaFVCZDJQbGZN?=
 =?utf-8?B?aUJpR1VWS0ZLOS9neFBzMFlQdXNMOTNERHQ1QnFUZlU0QjdsMDdDUSt4WkFR?=
 =?utf-8?B?V2NMYmZrZFJsMCtvMENwMGoxYnBGVjhycFV4S0FRWHdLa2NZaFVmSWQ4dGx0?=
 =?utf-8?B?UXBtbkxCcjRSYmExb2toMG11NDdZZlZ2WDNzM3F4QS9kNm1kKytvL2xmcEpO?=
 =?utf-8?B?SGlLZlYwcXUvSDMzRlRnTitRZks1TzFkWXJOMVg2bER2MHlRQWRMY3BDOU9q?=
 =?utf-8?B?enhkSGxOeWdZdHdkWTZGQmlrM0xlOWU4ZVlDUGRiNzdsZlU0ZG52dG1sUU9w?=
 =?utf-8?B?U3lZMWFuVE8vV1FuRUpqVnRFb1c3SUl6R2NXakNXSWNBL2QxVFIycDZ4TVZh?=
 =?utf-8?B?U2hNelJqcDRMM2YzNWNSRzBXM2VHU0p2WU9QSGh0aWx3bjBzalRTRU9hd0kw?=
 =?utf-8?B?bElZQTNMUkxmMzdSSEhhZ2U3TlRPOWNiaWtFWWJrU2Q2bm9TU0NJUmpFZDVH?=
 =?utf-8?B?eXA3cEdQWnM4QUZmNTFoVXc0azdmLzJHbms1eUxOZUxKS3Z1YWJPZFU5RXA1?=
 =?utf-8?B?dkFJTm9yMDU2NTJJNzRPYmpXZ00vTlNiSUZFNXhaSmtadnF4czRKNUpvT0Jo?=
 =?utf-8?B?UjNtZGovc2kwZXJSZFh0bzMrc2R6V2YwS241NUZnOW5PSVdybExlMXNEM3pk?=
 =?utf-8?B?YXI1cDh6RnJaREtKQXFIcmw4ZGgzS21EajJjcFNJYnA3T3JDMzc5clB1WDYw?=
 =?utf-8?B?ZTNvUytpUC84ZWF1WkZ6dEF2aVZ1bTBBZXdyN3R3SVdRV25MTktWZTF1UlFR?=
 =?utf-8?B?aVpPSjFrTjE3UUlFWmNxaGFSSnRxdTNpWTlkb2JDQS9JMFhXejByZzRlbUta?=
 =?utf-8?B?S2Z6b0crWVlKVFE3UmI1eG1EYXVrZmtWYnVVWmNBdEoydmw2cTlSSFg4clU2?=
 =?utf-8?B?Q09tZkdiVzNMRlJ2T1pvRzFKaWw5Q1dpVHFMSTdFdE1SQzZMSXFsbFBzaW96?=
 =?utf-8?B?QUVRL05KMlJ6REpBMm10Mjl4WndvR2NtZERDZHU1U1J1VEQyVWFSNEFlQmZD?=
 =?utf-8?B?UWx5VG5PTEN2d1dUd055UHYvK04yWkRjT1VHclF4YWVCc2s3RktDcUpvUnBz?=
 =?utf-8?B?ekhZc0JZcWJZdzVqUTV3VXBQRjNveFcxK243SFdLb0pOZXlmLzZrTWlNZFZm?=
 =?utf-8?B?NkFLZHB2YTZHZy8yTlJmRzVTTFUydHAwZzNibXJWZ0pmYkJmcUhIQ0JLd3Az?=
 =?utf-8?Q?AD6cUfTkjXXWCwz1WdIXW94whkfw/ZxfR0Rtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtFbGRHTGNmMCtzbEJEVU03eFNyNEUwL1J6UnRqUDh5aWtuZ09iMElIRnl0?=
 =?utf-8?B?Rzl2MVpnVm4rM01NT3NCcDFzdTVJSVhoa1dzMjVxNU03SVdDd243WUdpdkRW?=
 =?utf-8?B?QjNXOVR1S0cyNTNaZC9TWndCVWVndmk5REpqYk03bDNjdVZxdDhVWnNuTE1X?=
 =?utf-8?B?VS82TVNSRS8wdThrMUsrSldveitHM29wL2V5bnJPd0JGTGEwU0hWcVY4WmZu?=
 =?utf-8?B?M0xsM2EvNGV3SE5aTjNxOS90N1hjVXVmaG1QTk1PcDltZTVFV2ZxaldlZDhI?=
 =?utf-8?B?ZGkxc0ROTVlGV2U3QXpOOUN6WS9URit3Qks2NGlUeUZaMU1DOHlnTDZJMjR6?=
 =?utf-8?B?ditKKzc2N1VZc2dmSG9DbDJRMnNPaTRtZjlXUU4xWCs1dFpuVmp1L05LUXVW?=
 =?utf-8?B?MGUybWVKb2RTYjFpZ21CU3FibTRCbElxWjhCR1pYcUhuUlEwZ0U4Qk9XcDgv?=
 =?utf-8?B?QmFIL0lyWVhMREJNREZhekx3NjN5TzRrWitmMGxTcXQzbFFtaEVsekVMMmda?=
 =?utf-8?B?MlRVcmxOSG4xVHRkblJ6MG42V3ROVzc5VW5CdjNOc1EyTzlYcGtkTGx5VUov?=
 =?utf-8?B?RG5Ddk90cGZzdXdIWVI4QU9sSWFTRTdVekZ3V1B1RHZBcnlzMHlrZ1BqWVN1?=
 =?utf-8?B?YW54MjRaZFRoNy9ObENkRTZPT21DeGduc0dJbWFhbWx6bDgrM3lNMFczeGxJ?=
 =?utf-8?B?QXg0S3R3Rk1CdDhXd0FHb25IRTJPS21kN0FCdENiQkF6dFppTnhPakFmMXd1?=
 =?utf-8?B?eERla1l1SWdrQUpjUDI3ZHQyRVBmRWNKc1cwamZmemtGTUtqZDhqc0dNSGFT?=
 =?utf-8?B?QUVuc1dMYkVMaEpDUXlPdlBKTjB3T3o2R29lZFAxT0pldlJ4QVhVV2JTM0tQ?=
 =?utf-8?B?TVF5MWdqbTNYVk9NcGlEVG1BWllPZUZkQm5HTWJ1MHliVDd5dS9aNGM1S3Er?=
 =?utf-8?B?SS81b3hQb2hkaTM2eFVreXVDWjdwdjZCTEI4YkVRZ3ZGeENaS2VFbk9HSWc5?=
 =?utf-8?B?MDhzeUUrOERadU40azN4d2lCRTZFL0R3ZDdzOUp2cmcyV1hnNVFxSGcyZ2JI?=
 =?utf-8?B?TW9Ic2dlaEsrSVNXRkRieFk2Y3hDaFdHVWRIUkhEbDVqNm01U3kxTGVZTUht?=
 =?utf-8?B?ZDNrcnlrVDl5dzVCTk1zWkNkQVJZblJ6cW94MWVUNXh4WG1wZmdWUmE1VUdL?=
 =?utf-8?B?RnVmbEhzUWpERXg5d3o3Y2ZTWHo5T0cxelYzQ0s1VzRYaDIzcmJqdU5acG5N?=
 =?utf-8?B?L0NCcTRUMy9SYWJBbmxFMTBWVGtEU0ZhRGtRamplUk1KRDdkVmZaN3NENUp0?=
 =?utf-8?B?dWFRdVh6ZGM3eDFWZnJ4MlA4OUF6ZGF5ZHdtNW5EaUt5bG1KU2IvOXRBRXg2?=
 =?utf-8?B?Nm1BME1POFhrVDVXSWhKQ21zOHg0eFgxNll6dW9uQ2pDTGZBK01RRlUrSjhJ?=
 =?utf-8?B?RGc3SWhYL0lPY0I1U3NOQWRPS3N2U2wxQnVmdGJEaS9BMnZOeWR3T0NUZk5h?=
 =?utf-8?B?R1J6Y0dVaVc5OTU3elA1UVhGcTVpSS9weTUwc0pocC9TSzBKdTN2MmFMWjhI?=
 =?utf-8?B?a1UvaXZTMHJPcEl0eGhiVEhJRWhxYklEdERyK2Zmc2xRVnY2SEJwQ0t2T2lW?=
 =?utf-8?B?UG1oOEhqRVdnN09BcFNkYllTRzF3VTlXY0pxbk5JTkZoTEpCKzF4UVh2WFFr?=
 =?utf-8?B?WnM2OGs5cS82cENtQStqQzBpcTlHRkUvUTdadnZpM1prUFdNTE5wNmVRaS9s?=
 =?utf-8?B?R2QzdkVaZjJOYTZLcXpZQjRkbGR6dHZuc3hGUkNMcnROdEVpaU5OeTdFOWUv?=
 =?utf-8?B?Z1RLRmVwVEJvTnQ1MTYzZzZrQXZ6YjBCUXJkT3o0dmNENUlld3d6VEVhNUda?=
 =?utf-8?B?Y0drTEZ1RzFHYlI1R2RvUWZFdEJIUm9lMHdXQ2JCKzBJV2NCZGwzc2hvYWpv?=
 =?utf-8?B?KzgyczE2STBmVHdiZG9SQWdqNkdEbzA2NnBkWFQ1a3BISmxqUUoxQm9mSnhE?=
 =?utf-8?B?MitvcU1Ed1pmSzU1a1lxaitTWk5XYy96eVZZRGNhQk53K1JNS0R6SUc4VVhN?=
 =?utf-8?B?QzFVbG01cTNPQVBwU0dWM2tFR05KRVF4SGk0WFluYndBRnlHaTBVS2d0OXJC?=
 =?utf-8?B?OHd2TisxeVZKODdWcys1bEo4a1N1emt5SWRQdEFmUjhmWjVoSmNIWTF4ZVBi?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L6C6it6DP1Jgk1gqUIexQ1JtDgrOcQT3g9a+LZKhp0jy70yCa0Y6OYaHzUse76gysSNyc5XksKIFue+HonTWjE6oFD6quNQmKhQV0eALQa/SS7HRqUU4Il0PqrvknxgDTEl2CyWK/tZJp1tthN4ssFKw7ezwRdCTUJKZgPSgLapameGB6BMcACGMk44Y7rvq3E/chNssnefDXGj7wMxsFUitBTh2nXrpHQYawBF4ctQ6DHinbIQuARu9bS7MFnueEbvt2BR+MGV8MDaxP1j86xc/WbgsM5KaAtjGH9goXwMhH1ygU8gGlJEuq3kxs8X5x0i9Sk+FAkK7im6/OPVxgsBa2Q2nArYWIKaVkdrTxVqnjUGn8pfAVNIK8Y+zHlVfoYBenZ6QM77T0VJ+QFuKgEvp2L9Ax5CNEvBQSqHAd+UkHVXcL2R49gFQLSxfQ0tL3sBqxOHTpKX5a4qheF0f+yJmU0nt9Fe70DcLiu6TbzJY3ie8m8SJmp2nKCUe5KQC/0+7IWlpPqbdLvD8cnC467/+lq7RikVNKw8ptJ0gyBl9+K40L349BuoNXmP7YDy4q+VDlHP6kD0EnE1IiricFxea086tJnxREFrkVST5ju0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bf1725-d025-40dc-f2e6-08dd03cb5206
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 10:09:55.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Tx1beX55SGXGtlb3WcgkLNoxd1lWxrTQ/HJ5iBXRwCnLA9DVD/BBHN9nITcmZujCoUtKD/SnZ9IRI1G1qRA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=885 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130089
X-Proofpoint-ORIG-GUID: gsxuXwj1kt2n3iDkke59k9WQzmJN4Jhj
X-Proofpoint-GUID: gsxuXwj1kt2n3iDkke59k9WQzmJN4Jhj

On 12/11/2024 13:26, Daniel Wagner wrote:
>   #include <linux/acpi.h>
>   #include <linux/blk-mq.h>
> -#include <linux/blk-mq-pci.h>
>   #include <linux/clk.h>
>   #include <linux/debugfs.h>
>   #include <linux/dmapool.h>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 4cd3a3eab6f1c47c962565a74cd7284dad1db12e..7858c807be5eacb70ded5ec9399c6531a4ef6116 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -3322,8 +3322,8 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
>   		if (i == HCTX_TYPE_POLL)
>   			blk_mq_map_queues(qmap);
>   		else
> -			blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
> -					      BASE_VECTORS_V3_HW);
> +			blk_mq_hctx_map_queues(qmap, &hisi_hba->pci_dev->dev,

nit: hisi_hba->dev could be used directly

> +					       BASE_VECTORS_V3_HW);

looks ok apart from that

>   		qoff += qmap->nr_queues;
>   	}


