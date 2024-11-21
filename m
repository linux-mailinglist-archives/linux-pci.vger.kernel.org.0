Return-Path: <linux-pci+bounces-17145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A89D499C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9151A281988
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3C1CB531;
	Thu, 21 Nov 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lTEXseSq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQEktOft"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BA82890;
	Thu, 21 Nov 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180203; cv=fail; b=nMtf4US1653n303v0HggTwUpFE2Z6c2gl//YMW7n3uJ0I5Qqa/eo/n4t7AWPRU0HIh2qSDHCrph/Japq2hlXVCxbw3AzWTEXCa4+Eq7y3vSm4mYwu7m23v1twWYcdaRTZhgAvc8JW3+JZy4aS0ltFHCGI1KGAw4Gu8jrk3lQ4Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180203; c=relaxed/simple;
	bh=/d9rbo0Qq9VNkiTQqLdq3BHOsbSHQsjEvzINxI6Kr4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6zELogC34LhBdI1YfyMwH8lBgzBhlmDKIew4g5P2BKgopfRn4N4uGG9Wk5A3qjVCjDwa2aX9nPaY0CZhB+qg1BDbYQJ6rXEPNbxBfcCxLqUNwV6ihVoOK6adOvyz6mIKNNsT2Pa09nf5+BiMB+2qvjiFjf/W7T/oK9ogWUeuEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lTEXseSq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQEktOft; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7GgrE026665;
	Thu, 21 Nov 2024 09:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=US4SJ2+rXKOUji58AeuWSdYHMHrWm0vu+nabtPOWM0k=; b=
	lTEXseSqGl83c6XFcQ09ylIbZjEJIK8jH6KDUHJw9nd77d23MPhP8ob6+oIsvFRm
	joGaBPPRmkOzDGyfidLlkIR0kmqGHfGtnD5BeZSPXzBxwJ6CHMaDwrGXhiJydJAG
	Y5LI2CQE7PGomQXx7LbUd9j2ycjwRGxrIbzH983HsAUle4Fje3wPqSQkJAMuuUCw
	65cA5LfcY53mkWmWAzDobSPiRqTZ4mp8XaFZ6n2cnTEnnOLZN5fpy1jMktH3fl02
	dDipjKdKLxLpWtjaklCcvRWbQTVyEKhJ7Wr/zh3G1Oc6453N35OsSPdUO9F5wEom
	5yeYgJJkD/mDX5wQElh+6Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430xv4ur6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:09:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7OmkX037310;
	Thu, 21 Nov 2024 09:09:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubgwqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:09:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMcIYGs18F9s3gWK8xOX/9mozNKDIC2a/a2B0Y1kDnHoGF+BjqzWSwz7hWzxltIO25jx80QzIeOfD3pQ1kNwiTkkbQeq5Al2HZUmaEEpjB9or0XRi17Fk9K/B/O7R0ROgZrqXI6fi98ERhHjKM5yBXTggruNpPUX7VZ9BIP1wu9XH3W2zaoVMb29vMD/eUwh0dBh6o1DG63xSHZQq5bG7BZ8sgesM1Kcdck79C5yksaQ8fB+oJUqKZMcP2Fy9neG46lsUeQ71N5CfhzNNDPO2rnR80RBKfesC9JrfvDwzST8cW71nEbCJLcj6sdlv/4EFIvaz4XxHuZsQPg6zQUuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US4SJ2+rXKOUji58AeuWSdYHMHrWm0vu+nabtPOWM0k=;
 b=Jv+QZZmP/v+Hl64tyLhQRgA2ky8AFOGLH2Po5nivhau9JQDp3jhhTP+k+7Wk5jf47/4V9E4Tpo6XUeTCUaWHyNZOjvrofNXzdN2ZDzP5gnVPWvoRHrF2LyL7SvQxIKUhZ5ZKwa1h/NNvvTlCiSM4RcDqW7n+0rZ+unnox+D9o3lWlCtfMtLnD+pqi3Ezb2FVhyZjzV5OtuWYvfPvo6DgPumd/mn1dj2wjERPxjMHslyGxBnxZNRI+WGRq8CZDH68ftLPZjlIh9MhfftXff9NcxFPwfJ1ImjfGGTGZLwuyegfoNeyIn10gFhmXuenwAZT8n6pf8W0YhVTNgUdAb1FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=US4SJ2+rXKOUji58AeuWSdYHMHrWm0vu+nabtPOWM0k=;
 b=bQEktOftFJacb1XTYJZe2VFWESKzsz2WAeaAGE91n8dFuhD0In5NzfLhIpu0moymNnca/7ZwDt79/2YNrQGVVuiWkhutVrCqBIy/eywwNFJhO9m9QyTu78KJA5H0InWtRsizOvPWBFdLi5kyGyY/+v2U/cuYDN33QTl8OFolsyA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 09:09:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 09:09:33 +0000
Message-ID: <02194fdc-ef90-4f29-9ec4-7081c6dba6f4@oracle.com>
Date: Thu, 21 Nov 2024 09:09:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] nvme: replace blk_mq_pci_map_queues with
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
 <20241115-refactor-blk-affinity-helpers-v5-6-c472afd84d9f@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-6-c472afd84d9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b054095-4f07-45d1-4554-08dd0a0c368f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TG02a01ERGNMNkQ1L1BPeU9yUnZVak11RThMRVhhbmEyUElCWEJ6ZFdta3h2?=
 =?utf-8?B?YS9xZ0p3OE5PZUxOMVNEQkhqbVQ3TDk5c1dWby9IY3hwNHhBMkk2dTVadWJ6?=
 =?utf-8?B?RVJ4dnc0TmNaNmhkejRMdHlQYmdjQXpsendaeFRmS2duZDlqOUc3Tjh4UEU1?=
 =?utf-8?B?dzJBM2hvaVNLMHdyRHVmczdxd2ViUkRGY25IQTNqZTMwcUJxVnROYTZzdHVR?=
 =?utf-8?B?ZDlHNEtJSGRDU3ZGMjFkTW82V3JCLzFrcDUwYUhOclBDN212YlUrN3lDdUUy?=
 =?utf-8?B?OWdMWTRNM20yTGplQUVlaG11MmIyTWtXczVFNytmTHFtUE5RRGlKczd5S25s?=
 =?utf-8?B?amw2NVNmVDA1ci8yVHdkWHpJU2NBdTJ3U2pSQ0NPQzVqYnlEaEx5cWpQK3lu?=
 =?utf-8?B?RCtjdFRRZTBBa0F3NUR5aXFLbWtQY1hwMUFGQkhMNlZtYUFZOEFrQkhVdEZX?=
 =?utf-8?B?WElsRDRRZm0wUzVyNDlhUzhaVmg0VEtGUTRQU29BSU1UZTNicXVLd1F4RGNn?=
 =?utf-8?B?TUU0bWlHQ1BLMS9WL2JPYXBwbld5QzhJY2RYRlMrUkU0d0hacUdCYlIvc3hZ?=
 =?utf-8?B?emZ6WDlab3piVEhEVDRFWEQ2eFJJWk1KKzFqZUkzNUl5bjl0U3B3WTNiNkxi?=
 =?utf-8?B?MGQxUTgrUkR0dXpOSjYxYUo4UUc0Z0NtL0dkcVlsdnkxVDlScTFvN1M3OWlR?=
 =?utf-8?B?QlAzOEovanBKdnVleXlMaHV6U3pnMVR4SVQ3bEpLTUlrOXJYaGFCQVF1RFMy?=
 =?utf-8?B?b0NTMmxUS3Z5emQydGxwcHhTQ2dISEgza21QZis4Mm5Udm1BWWcvMnZTY1Zv?=
 =?utf-8?B?Z2psTDlHRkpzN2NwdXBVZVJWNVlUUVdaNlhZYlNnb0NOVk8vbEtMclN0K0Z1?=
 =?utf-8?B?U2haODM2TWdyaEVUcjFtUEtKR0dYMXpKT0dDb3E4Wmh1cVByc3N2eTdtWERl?=
 =?utf-8?B?S1hhbnhWLzlPNzZUR2VocXV0d0hYeUdXbXZRZVBOdXRldlU1clVoQWtTaWZl?=
 =?utf-8?B?eW1YVDlkZDEva3MzMDI1T0QrT1dKU3Q3aUdXVTg1ZzJxdExKWUdBRlRTQ3hn?=
 =?utf-8?B?U2JKaWFiS2Q5R0Z3eXRuYkN1dHhaUU5lQi9NYVd0L1BxMjlzbGI0RllGUFFN?=
 =?utf-8?B?WUo3ZXh2dXgzVXZ4Z3JWZnJ4Y25hM2RnNlJlTGRwaFZrUTVGUnZncWg2cS9s?=
 =?utf-8?B?aW5GRlF2RDlvSmthMldGWHRQV2xOK01ZaCtvWXlHaGd5STd0ZUNCWEM5VXND?=
 =?utf-8?B?c3hUdVJBakV0WXpzSjNTOFg5VTVLMURZM0grMzdCbnkzMHpwbWZzUHhHY0dw?=
 =?utf-8?B?N1pOOEZySWtSK2VVRmNkelQySkhKMUY0ditIVDJPdHF3R01SdldZUG9oZ1J2?=
 =?utf-8?B?RXBsUDVVTjhsRkVpeVNiSmdtYUhaVFI2WDc4ZVlUS0JJUm82UkVNVkVWZlJP?=
 =?utf-8?B?WDZYMlM0K0NrVHFMSzZyU2FZMFFKbVNIaHVhZ1dRMk8yZ09zdUZpR2VXVGJa?=
 =?utf-8?B?ZSszOCtLWFF6WEJBWVJ3YVhYRWpHcWdxaFpsNm8yOXpZVWhURk1FWkxjenha?=
 =?utf-8?B?ZlRaS0ZiZkUzeWp0R1VYbzZzSFBLSzBxUDIvN1RlMVV4SVZhSzRYQ29VUUVm?=
 =?utf-8?B?SS8yZW04RTNtSGJVTGVHNlMwL1ZZNGtUQStxQzN3TFZIOTZDYzNGUThtOXdQ?=
 =?utf-8?B?OTltV1RyNUxSVzdPZk9mUWpnOTdXL1l0YnZhM08rMEVtOEpHV1p0QU9YMTZ3?=
 =?utf-8?B?ZlZxeXA4RTdWSWM3THIxdElzYklIUTNuZWFTUHExYnlKbU5MUmNXQnFKenE4?=
 =?utf-8?Q?yrO8HkmSoXojKTLYowQ05UtbK9CM6e24dyJ4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG1LMjFKMUJpcXJHaVNXcE52NVhHemY3ckRRTDE1ejYwdU1wRnZLSEFSQ0Iy?=
 =?utf-8?B?elFGLzNWOGMzZHQzK2VVeityeExOcUV3VzhPRUlGN2IrV3Q0dzE1ZjZxRHhJ?=
 =?utf-8?B?RkVKM29FbUo0K3d2ZUc4Ny9EMmVKTnVRUmZWbzczZmRzTEFzdE0rRnV2aEFI?=
 =?utf-8?B?SEpCM1dPdjlVc283bFZsRmN2RUpKemYyMGQ2ZlhuK25pdVVsL2FCa3YzTjZC?=
 =?utf-8?B?Y2V5VHV3WEFKcnV3QmJlQ0J4dEt4WXJncG1XT0FVK2JBMnVCVnorTXV4TDd3?=
 =?utf-8?B?R0krZFRQUmZKbC9HaWJXNUdPcEcvYVF4akh6YlVHSlIvdVN3UERKVjZzN1pO?=
 =?utf-8?B?WkIwbVNEY3ZuQ1NJeVd5RVgzU1p5TFkrMUc3c2JVOUd1YWFhbERwM0lubkRD?=
 =?utf-8?B?cXVCbzZ0bUw4YzBXbDRUVTE2b2dhek45azB4clBwZUo2ckJGbzYySXdRUE9Q?=
 =?utf-8?B?NXN5RlptcWpJUXppQ3RhZFBsUGs5QTdVOFFDUWxjZURJWStqZG1XS3NNS1Jt?=
 =?utf-8?B?VUdScnJxb3BFL1hTZzJReTZydlVPMEJZdlF2QUxtanlyTTJUQUEwc3BZVWZL?=
 =?utf-8?B?YWs5SXFBK1hacEFsNWJIdWRzZk5lWlAyUElVLzBKL0Z2VnhkNWpsVW1FRWUr?=
 =?utf-8?B?UjVMRXJ0MUNlSUdrNUV5YUt1OWtPdWpYSk5vcUtSNHVGK2E4UXpaa1RueDlC?=
 =?utf-8?B?a1l3WllxRkNiQlNxSTNYTVRQN3FBa0VJU2I0OTJuTGoxcUV5dTIrK3RtWCtt?=
 =?utf-8?B?MjBqSUt3TngwMXpEUDduaCtva1VzaThaRHJFbWg1Y1FYK2t0UW5vOFJkYTVG?=
 =?utf-8?B?ZEUvbmhlWWhSYy9Gc1N4R1hmNWk4RDc5SGNSaTRGUnA0V1JPbzhlMlNWZDM4?=
 =?utf-8?B?U3dwWkFKUlZtYWtqZ0lxR3lRK2h2Q1VpR3Vhd2hOeU1SY1FndzlGc1k2MENq?=
 =?utf-8?B?c3V5V2dORjVXUVl1ZXZtSkV5emhKa3VJeklJVmRBVlFud0FMSnZLMkhiVUgz?=
 =?utf-8?B?VUtUNTgwUFdVTDVtbVV4cHM0NjBRNm84dklXREFaOVhtNzl1NUo3ZkU2WFB1?=
 =?utf-8?B?c2h0cGYwT091dW9rMGZEcnR6akpwU3QvR0lWbFUxUEVuamNBWWNNMFBIV1dE?=
 =?utf-8?B?dDgxV3U3aVhLSy9scDBLWmppWmpoNndnK0twYSttdnZITTdEOXYxb2RBUStU?=
 =?utf-8?B?U2t3clZ5VE5mOXJJNGhTK3gzZmFhMWRpTGl2aHpZY1kyMUdFMHFURFh2RWFK?=
 =?utf-8?B?M2xhU3FVWTRjazArRWJZVld5dlg2SlZBKzJ5Z2V0MGk3c09EN002eUVEZmhV?=
 =?utf-8?B?Nng0RnNLNmlNTzJod2tUbzRjZko4Wm9NTk1FeUNEa3VHTTVPMnBLRCszL1ov?=
 =?utf-8?B?TklyRkRTMGVZTFVHemFuNGZDR3Y3NU1ENmZPUFlLVkl5dVQvenBKTnhxWnRq?=
 =?utf-8?B?eXZMd0QvcHBWUjFLWFFibnI1THRLNmdZaHN6em5MbHluNVNkRGZmYWJQekUw?=
 =?utf-8?B?NXZDL05nNmlwYkFVejY0WW5pSTM5VmVtRjU4eW0raCs3WWpFWW9XdkF4SUZy?=
 =?utf-8?B?czZ3ZW5BM2JjVEJNZk8zTHBjUVU1NURWSGFxYi80SHRvTkZFeDdoaHZNa1ZY?=
 =?utf-8?B?TmR6OVZ2cmZCWGtBOUlwNno5cmE1VlBMYU1WcnlUVEpRVHBkdThRcDhnOTJs?=
 =?utf-8?B?dWtOcldiWWxYdkkwVmo5QTZ0YjkvQU9qVFg5YVROVDJkZkt5TEp5aDRpSDRn?=
 =?utf-8?B?ZUprWURST0xQT0EyTHdTSS9veVF0VTZOMHdHL2g3b2dNemRBRnFZZjIxdEZH?=
 =?utf-8?B?bTJQbWJxWmxQVVRvdzBZSGtPazUvazFtc3dOaGgxdVFRcHRWSk1XQ2RDSDJn?=
 =?utf-8?B?ZHh0MUV0a3NJc0hDK01HRU1uMXhCUmlmVHRJUThSMDVkWVFhYmpTTE8rSGpN?=
 =?utf-8?B?aWJFRDY5bWtrb3Voazg3NUtQazlVOXpxRzBSN0hPZmdRVFpsTFRRcWdJTHY0?=
 =?utf-8?B?eTN1U2w3U0ZMd3lwaGVSVVlIWm9Qb0svVkM5OSt6UTdGOS8rMXlsODEzUkdr?=
 =?utf-8?B?K2Y3RmhmUjF6QWhNUXUyMXg1RWFJNUFTRHRSYU9EVm8vWXliVktndWMyT2xq?=
 =?utf-8?Q?XQ6xSYcI+0gXTVUSj4PEt+63f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0t2XAPHz+AortW+/byYtzCBtZ6ljtZ+OEgGKIKr28jXV+FV7MjW99BnAjX0eR5r9c2adVt1JxDR4qihgZwTnIUmbHULjnSLLtRe1Q+39x/Ik2ydNSBeRCSdYV80Bh9kLOTn7OXpMt4hD1tCA97kFZttJiwYtr4X1u3lnLysllcwjDs1j3dhnH8WGsBQxLH8gVzlgEFQTT86lb1Q4M8gS28ujOM7mtO680FAxzL6cAWiSqTK7Y+NTYSorqHTd+bmnfMpSBC0Koaj1m6ZT5Z1CKiZ9/lCRp+NGUUrf4l7tN/5NEs8+3o4qW6/Of0l+7zngeRMTv7V9KwdlcZnC7K+BqjCiuqM5pxre1rsiL+4BPWXqLVhaH5DX/RKB1BBNoks1dvCIezmAQD5/LzFNgLfl+1JQ6qPk5gLD7R0xe7PNbreI8Hi2+t1/qkHwwodrcWSGqUREMTmUQDUx2yU0tZJXFUs4RuXKWsoroa8Wr7bluKpHE4cLIWqddkP2ScQesmgV6GTXA3JN2D/8MUVFgQ27T+uxxO96dy0lON9oM3+Rhruvpsn2Hw8kfQAIy7nYRsNltJL40fjGGrNDfDhUYPU1KCa6r6yaIqYfWNK4BrQ9RoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b054095-4f07-45d1-4554-08dd0a0c368f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:09:32.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bf+20xPq2hqDziFavSbMtk4oZ0py8ysHBdPPcQeHUMBNms1HsWqy3CVa/ewfRX1evs3kFmRceijRH3IoJK3sBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210071
X-Proofpoint-GUID: BJ16yYXOjt2ZEtfjA7hoDUDNu81UGdiT
X-Proofpoint-ORIG-GUID: BJ16yYXOjt2ZEtfjA7hoDUDNu81UGdiT

On 15/11/2024 16:37, Daniel Wagner wrote:
> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_map_hw_queues. This in preparation to retire
> blk_mq_pci_map_queues.
> 
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Signed-off-by: Daniel Wagner<wagi@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

