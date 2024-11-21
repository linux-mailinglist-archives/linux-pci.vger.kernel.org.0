Return-Path: <linux-pci+bounces-17144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BA9D4996
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB09BB23A1C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8381147C79;
	Thu, 21 Nov 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="omQir+0e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YuPNQ2sA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2B15B14B;
	Thu, 21 Nov 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180173; cv=fail; b=jaLSDsvlIxfPPTdTuOMEOYt2yzItC4bIap4EteTg7JDFp+6aIDckL54kBkLMtCaF55M/7vRBHxjp6gKBFFCFwPbTWSZ7lH1RiolmTTUxnoCU5TrTcyVv39W/DrFtzASNbRIHufUGBSnES6boK3ytas3tFuLAbnXlLnITAZNq5I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180173; c=relaxed/simple;
	bh=0m/+0lx3RmqkMcfXF7UcMyE2IznQPsmtMRkupQe7jeA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKs/0RerKiVpL1cKFK4ImZPFK7abXBkG/fyO75kixkRLYlTgOoGkRX1YWI3EpkZkAnGm4O+tudfT251ytiIdvw9a3WAd+LjqXLgtLNeHw2T2aMaVFAiAPCTnBgXqaJdLQgKNBpAf/TFX2cPZ0Cqoebv5mBNRyhDXyiQEIurIIAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=omQir+0e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YuPNQ2sA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7Fi8I004311;
	Thu, 21 Nov 2024 09:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Lytd1pnrB68SeXNnAQ2NOFqiJswLmVmNHklpnpYJsww=; b=
	omQir+0esnJlTqVpcw/3Kh/cY+HWJyxWDlXK7L0ClkPWnsMVEod2ZT95lj54PCIs
	wfV+VV/W3SXEfOmOTHKqIdQkMNWf69T6LQBI883yVxwhVHtb0tIShEAszcoBV5ig
	v0Ex85TQ940w+WHHcGVNZpl4lpl4CQy4jblQQZxOcms7HwsENkoiWm45orfNZVfR
	PFWa7lc/5QRYGn1lg8l7czTG1LDtIPiJmv/ULMeykBnOLw0XBAujdVtEpHY21pNN
	Pa6gCFGFrSMKB9rqqueRCGLq5SBBwyqJf3uojZk36bCITITclkg/gxL/ZZV9M4DP
	MwmpCFTYnl4JibKldJd4AQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0ss691-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:09:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL95jrC023653;
	Thu, 21 Nov 2024 09:09:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubv209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:09:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdfHCMdHeL2gB4OFYoSCCwGv8czn84s7lJjtYq2VcFLhCq7pey4SaPC5rmaw+BbkVtlBw1YHSvu10RIeDjLTZtveIgQPmId0tpkWM5qfGqt90jLDAFTvdugIsQewgTVyTcU9DGCKZZlLTFKTFfxZqR+xUIPAm/gpeGQDswrlMivqfQ2K8/cu6+lEjGXdsK5rgYU0bcHYrz8Sde3l3miVdcDDA8Ih9nm85Ktf7c01RRBkJZGRocLRLKLATZpNEAJC1lsRy5sIvLYLRVuLgXWRVH3e0Tg2DaRGKJOY+EJc8VEgJICeqmVHu34t/xeX7ILeoQphXUoxYe/bugujxNBjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lytd1pnrB68SeXNnAQ2NOFqiJswLmVmNHklpnpYJsww=;
 b=JJqD1gEZn6/wVZ6ka3YOCEw1w85mMaOiNGaGlr7vdDvn/ppFWBqbnWb4xFWGOCJ6jTjf4vpSmhL5schs5zLyR50KBB3ngCufLx4RJ9KRvbNTZ4TQKlAkMBPISV0PJLGmATEYH2QYVTD2eu2gFxhRyiU0YchgysH/8PzUgXelNeHOtzGSnqyVphbT+aFE213hW/txx6xlDDdw5vBREolayzmnX9g89dht3c8dFpC1D/GmnwT1k4E3HEUZcITKN8ByhJlD2rGFOxYcAc/3Nt0/rgzTamOGM9FZwVSiRcm5V1+DpNN3SSYe0Xwz6qAXfUV8DgwQ5zvGreC5yrd0sMfpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lytd1pnrB68SeXNnAQ2NOFqiJswLmVmNHklpnpYJsww=;
 b=YuPNQ2sAW0bfGjD1vxhTMy71YZ8Xf0lEkIQhEH4Q1FM6hOdHU+lfzddBh2kfGQ0lW/XjjMkxyXXjcTM/FQNnw5ZEFHJAP8I4a4fRAjj+ShKqlazi7olxx6jks+rpr1LpNx4qhajvDy2iJFv1F4l+NaChc5Ub+wLCp3AzxFvg60A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 09:09:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 09:09:07 +0000
Message-ID: <a159cd2c-b028-4d26-a33e-172138bfb147@oracle.com>
Date: Thu, 21 Nov 2024 09:09:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] scsi: replace blk_mq_pci_map_queues with
 blk_mq_map_hw_queues
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
 <20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: f45e01de-6b05-4f4e-108c-08dd0a0c2750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVhyZjhja2R2eVNEVHJmN2RSTXptOWlDM1E4S0FPamRuOGZKU0lEM2FUTCtr?=
 =?utf-8?B?bVRKaitoZ2k4NGljcHlmd3ZJcFUwL1BVeG1udXd0Y21jT3h0Mzc5enl0dXJ2?=
 =?utf-8?B?bUtyVDNBT285bGtDbWVUUEVxckc2bi9WQnpmMzBXN3NxUEgzYzE5VGpIeTlP?=
 =?utf-8?B?Yi9MUnlZeWNKbTB6N2R5ak82K3JIMlJIM2NHZ1grZkdpYnp5ZGw5QmxVU1dG?=
 =?utf-8?B?djNSbDN3V1RuTDlwM1JyQzJqdWw4QWllRDF5KzRQdTJwVk9ibDd1aG0wNTdk?=
 =?utf-8?B?OXpoeWlab3lKVUVBQ3pWWVRFWFI2cnEwcGlzL2J2cnBzK045Z0d3eThwUklj?=
 =?utf-8?B?MjQ2amFFZVVpVDZpdWtpb1NoWTFxKytHWVNmdDZKQ1dORitmSEdSelNiWWtI?=
 =?utf-8?B?VG9NNmh1WlJrSDA1U3hPQ3kvcGx3ejVFeTdMeFQrWG0ycExXZjVaam9VWU0w?=
 =?utf-8?B?Tmk2SkdFbDZwTDNHbnltQmJpMXE2bytPd3RINUw4QkppL3p1bzR6WTh1d09r?=
 =?utf-8?B?K01EcmdHQUJVNkxJaHpuZUZYZ1c3dCswZTdSc2M3MEhuL1N2Vk1QQ2N3S21r?=
 =?utf-8?B?bUtySXZkalJ0YTZPU3d5ZW1vUXFMWkNVcUkyVUwxbkxkbGNOTXgzeUNiNGJi?=
 =?utf-8?B?NnkxYzlPZXMydjdlSlRsS1NhV05LaFA5MXlnSjd6MS8zM1hpeFpCcXV4eWxO?=
 =?utf-8?B?UWFxeVdPQ2YrbmdkTzRVMGZqc0NnSkFTaVhDbUxCaGh6WlFldnYwcFc4WjBL?=
 =?utf-8?B?VUs3ZEJIZ1NjVlNFRGptVEJFWjhmamVlMjBHeE5CTXRZVEp3bTFqVmlzK1Vi?=
 =?utf-8?B?b0l3bjBEaHlIL3R1RkwxWEIzOUN6ZmFRcVBTOFBSeHhNK29tZ0xFRmUrZHBH?=
 =?utf-8?B?TERSVEc4V1lyME9yU2hSUTN6YVFWQ3dvSEN4dTI3UmVtSUhTQjlHZ2E0dTdZ?=
 =?utf-8?B?bW5zVjJTaXBXczc3eVNlZm5iQ3creFNEU1lWbUw4RUF6dEpRM0RGZWxabndh?=
 =?utf-8?B?QmxROTRiWWxXUVlVUEtXMi9FSCt0MEtxRGdIOCtyQ0swYXF5YXpQM25NcE16?=
 =?utf-8?B?OGM5V2xkWXIyNVZxZzJ6b1M2VC9wUzI3Z1ViSHlBbjZSVnJqUXNya3FnTzEv?=
 =?utf-8?B?Y2hNV1g5d3RrWUhsVUdlQ2ZPeGpaQkd5elh0RHgzNGlsL0FBODlzL29POFl3?=
 =?utf-8?B?SEZMVnkyK1FPTGVkbFhzRmJScjRGUWlsZGtJUloya1FFN1dxWEdCM2NnQkFa?=
 =?utf-8?B?RFFDQ0xIZ2NWaTB0S0pGYnE1OHFTaktYeTk1NUlpUFB2SjRxRGNxVFNvNFd1?=
 =?utf-8?B?ZTdNOGdPZXpmQVE5SlJaazFqNVpQRmhUaG5Cb0Rab05IMzN2R3Bsdm1Pa3Jq?=
 =?utf-8?B?aGJvYUdQTEVsVzEyenhuTi9ZS0tIcS8xTENqUEVpRVNSS05zc0pmMnhtTm80?=
 =?utf-8?B?OGhkblgvenNsSmp2VmlyZXJaUkREU1NTUjRFMDExalc4cGhYcEEybXFubFVU?=
 =?utf-8?B?MVV1a3pqN0hsTzNCNXhDdTEzdVVhT3NpcUhEZHMvUGdIQ1BuT1lrVGNyZEQ0?=
 =?utf-8?B?eVpHdXRuR0FpMDJPZkZ5dldzK252ZWo4bjhtbmpidGtIL3NXb0dhWmNya2JD?=
 =?utf-8?B?WSs1K1FJTk1KU21BU0xEcFA4c3hKdFVnOFNVN0g4L09wbEpMYmMrWTYydEVV?=
 =?utf-8?B?MXhsUmxrbmw1RGhpR1dWOFByUkZraktGZEZnMHluY296TWpLSllBeDNYOWZE?=
 =?utf-8?B?Y2swUzZuZHhiUVVaR2lFNFR5aGpkUVBLN0NPS1ZWOWRsTWR6SmprYnJ4aWNy?=
 =?utf-8?Q?wgNtD2J4KDUg9NmgnTJDLSw45y4ItZBZiZcIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWQ0dis3bTFQTzdiRHFma3Q2MGQ1cmh3RGc2UDk1Q3hwdW9NcG5haTV6U0l2?=
 =?utf-8?B?cUYwUjRrMGVERXZpZ0VLY1B0NkV0VHRPbzJ2SGFiSFFzZGY5aTJGT3E5MDdX?=
 =?utf-8?B?YnUwRE5ZU3dWQUpZMFFKOTFvRWRwTGw0NUE0Q3NaUUxGQis4VldhbW5Gd3FI?=
 =?utf-8?B?R0QySHJKbmVyY24yeGZ2eDVJVFdORGx4RzZkNEY4UTVwcHRtMHU1V2RVaUZR?=
 =?utf-8?B?SnVvME1GZlozUTlSS0czbTF3dVlTaWJIQ0VIbjRQejVnbFV4RHB2RWx0TTUy?=
 =?utf-8?B?a0duWSs0ZlpzRnl1N0VBSUh5YkdoZEtGRDY5T2Z0RHBWd2NtRjBuOUZkRjYr?=
 =?utf-8?B?UE50M1ZDSjhEdzREOW9FcjV3TGtaTlhrenI1UXpRNHVXWjFTU0hMQ0w5Nm80?=
 =?utf-8?B?OGZIRHRkcFFOSklXdDRWYWZkaDNSenpRRFdZOFJsaFhMZVdQMEpPRXdNWUcx?=
 =?utf-8?B?NHRhMHZFNWRPeDB5eC81MzNqbmxEWTY1OGNQandqVURyekZYL3AzS0I3RGVH?=
 =?utf-8?B?WTFwREV5Zy9jNmJMMExybDlGZDYvT3hCOGg4c3pmcTZOem1acmlTSFN5U3l6?=
 =?utf-8?B?Q0dSTDN4eVBXQ1JrVlJKTVpyMlNvbDFvRmdHT25ZYWdTdHZsbjQwSU0yRDlv?=
 =?utf-8?B?UHRVeFdPYUNCTjJIOTBqY0grOFhBaXZ4Q0oyYjdqNmdXNjYvMFU3YzNkcytD?=
 =?utf-8?B?dTVGbGFod0dkS3p0b2IwaGgwbFNheFplSzdibWxENnVqSnd4dWIxNFNnS0tI?=
 =?utf-8?B?VTJvb2JqdlVJbFFQNFh6NmdtdFZUNzhkU0kxN253aG12bXg3OTdhNnZKODNn?=
 =?utf-8?B?SFJwdkdkWWVjSFY5c3l0YzVnMW90VkdhclMyNjhPeXJnMVdhT1g0bmdjckt2?=
 =?utf-8?B?bFIrZTloVFNsSnhONHRzUUw4QXM1aStIc0lDUWVYZmVVSGRMNitsaXNQMWhM?=
 =?utf-8?B?bXlHbWk0ZVdUVmREQ2Uwckg5YVhYN3BwYStZUFNwa0ZkVFZiRFNXckx5NmRi?=
 =?utf-8?B?emhPeUROeTRVd0VVYTBBOFNucFZRZjZGYmtvclVkOGIwSFRDY0NKbDZGWlpU?=
 =?utf-8?B?eTJvczgwRzNnYkxzZEZGRitqanFFLy8yUE15MGJBTWFvQitLYVRIYUp0a3hq?=
 =?utf-8?B?UGxTZEpLVkEyS2ljcURoOGs2UWpoNUdZd2NBYlJIK0o0cDFOQURTbzU1ekdI?=
 =?utf-8?B?dmNwaFkrYVI3MVo0dGpKN25GZVZLUUxhSmI2NTNYakFnN0ZSVTZpYWNQd3A3?=
 =?utf-8?B?ZlIyek5RU2tXNGk5dXZxUnlIbkhQNFBYek1WV0szbWJSVjI3ZEx2aDFUSG1D?=
 =?utf-8?B?UlE3My81ZmVTMHA3ZkpIdGpkbVArZ1ppWVI3dmw4amEwcVdNY016WThDTjBu?=
 =?utf-8?B?NVRwSmNJWVpVSzlqQzhORGtwUGZQREJ2SUlUaEpaMGpZK2VVaTh6bWNKcnU3?=
 =?utf-8?B?VG56SlZ5Qy9iUG9vM1B6OTV2eDVJN01Jams3K0diNGdBenhhdzdVVHNwS1h6?=
 =?utf-8?B?Z25qTHVFTFU0TDAybmtIV1R2OVllSURFcXFrbWlrcmpZUjdvazRxeFdVK0tV?=
 =?utf-8?B?ODhja1ZsbVBEcHFYZ1BUU3JSOENiNjU0TFVtck1SRHZrNGhLK3VLK0M4b0Ex?=
 =?utf-8?B?bDVWMTZ4cFltWEJua3dFc2prbFB0MzJJbGZhSjlnSXo5MjhPTFlacGRSdkxn?=
 =?utf-8?B?RW1lUzl1YWZubmt5dzU3N2Vwb0JlcW9hbGQ3eUV3NE5DRmpUbWxGK1lSNnEy?=
 =?utf-8?B?YjNSM3ovSEQzVVMva1ZOeXFGVWxjZTNUMFpoMlV6NXVmODNuUktsY2hDZHly?=
 =?utf-8?B?WXVmWnhrZlBSVkRuS2lhejlXVkQzVmNBeXFlb3IrNFd6SEpnWjhRNXRhY245?=
 =?utf-8?B?R3N2YU85L0hXc25OR0J6c0lUVFdTWjJzb2Q5OTJER0lNM2hUalBFaVBvdG00?=
 =?utf-8?B?enpBclQvSmU1VkczdkFFSFBnSXZKVGl6SDBiWHVLZnVaUm5IWU13WDFUSjBH?=
 =?utf-8?B?Q3VJS05SWmNRaE5ldmpaTy9oTU5tK0YwbWI0UFVLajlQK2JHbzFjL1FxREgw?=
 =?utf-8?B?eVlKcUtKTEpXeHRNeVA3bVR2dFNneFdnYks5eEwyd1Z1eVJueGJ3Ymc3RXYx?=
 =?utf-8?Q?lVG5nkdKQYfzD99o5/W98YSdo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GAkFvZAInctrgzxqCYThKXsA1YQOunDaPbKwgQ/CrM8/nvWSTT15xlPj05LcCLtvmvGk4WLI/LTkTunrWtdF7P+qlCS/FPm2iJ/vpXJ/a6jIPVCiPym6BpQ2KBrVmqfK3OZxDT/h8J5XPdqw1HspRkV2esMXZiX894Btjbo2YaFLzybv6uRvuy1bai7AuevBQ7c2mVWCs8Zc1hrDIKAX0LiftMiWSCkLYoR4YS1WlE8oVHbEqlm2xWvMucWh/VXVSTnU54Vbk8m+C/qvRla7E+Gpp64/79Uuq5e4QR5k8o8Qiln8shFnF1FPqzs+XX9O9DXbve3QvqdQ7zeRP3bWpAzPAWPZMGf8JjpS7+VK+ka56MYYiOVlj4vlbPW42XwEfYTHXH/tlXJ+viOpp1s4hcUhVPZPK6v8zGLVa1nbo0F5vMLiW8KSEoUNoxvlaGKvxspUEzM/scdp+fS4E/qUIgHz2VUpe68cnCMMPx7CHxAsg6PHmZ5mcQqt1+njFUiT897KFQPhbQrmT4cGg/ASI/UiuC3gBvdTPcVB6548mwyTFPSFGj2xKAd0/Fatg7ZWZeA+oSYK4EXKsVbN5wpPQu+BUWor7Ut7apPmY68Owi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45e01de-6b05-4f4e-108c-08dd0a0c2750
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:09:07.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkLXRTaS9+yobCCQ9QhoMigzsPmykxMf/86eOb7qPGoVPkWWIxSEox2hagr1Sbe6KRTsf0S3FzGsL/bFhgZn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210071
X-Proofpoint-ORIG-GUID: e1HGJ1ckw0hBZ-VbI3EXMi2csisn__1e
X-Proofpoint-GUID: e1HGJ1ckw0hBZ-VbI3EXMi2csisn__1e

On 15/11/2024 16:37, Daniel Wagner wrote:
> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_map_hw_queues. This in preparation to retire
> blk_mq_pci_map_queues.
> 
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Signed-off-by: Daniel Wagner<wagi@kernel.org>


Reviewed-by: John Garry <john.g.garry@oracle.com>

