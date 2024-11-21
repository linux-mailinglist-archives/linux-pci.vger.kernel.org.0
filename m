Return-Path: <linux-pci+bounces-17143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39269D498D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 10:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D974B230BC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C731CB53A;
	Thu, 21 Nov 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UQTputAP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TLe8sowP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DE15B14B;
	Thu, 21 Nov 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180114; cv=fail; b=NL/KZBAlS6GLyTu/FHMpQm62IeRgJOoPAVcBgQ5UBpvsJM3hl5x/BUqyjnGoD3QYlmpaOStkCt6/XhnKVkFb7kLA9qu+uKvbxFbyzoh2W7Lr4mLHViVcVz1nyYET5vOrIz4p4dsNYGIzQiHZOyEpVB3i3i+friu9SMKsRG7c1Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180114; c=relaxed/simple;
	bh=hCNsKHSZlwcgGz4ojjN906hg4eZU6Cbq8pfX4AFK1E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WneE+ZLgq72wg+SDGFVPtTqU+TTIMXU5tR4EptZnzMFipEq8TyGeRHQvw/9sKq8xesj08LEZZR09JhPaQTEmavwONJXXrNKVH7zHg4jo8LNlv2bJXFGYTWO52tVZmHoeMLp1VmzxVLfy46sCTBUbmmbrFWRcwj2kb1tNGtisoMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UQTputAP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TLe8sowP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7Find004315;
	Thu, 21 Nov 2024 09:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n1y+/wCXW5sbYIeCEFr/6bHcpqCHbLuzLubg8CLHJGE=; b=
	UQTputAPSq+CHja7rGnMAGy/iAv7p/EpFKlv89FsNlTnLctHYIIlN0Vc1BVgTMhn
	c6vFNWwy2JdkolrT4h1ejoB+clYCg+EjFV11bE2BR8l1THRk1GJQ4OXTKokhr0l6
	fxrK5hn/QTcFRGffhLFCEMs7qaBE56wc5ebEUPX9rUela4z+DE8qTCEh3brqL662
	Y3sj1D/1Iq8mDdKrpeiUtuEpntkRFQpk4h4TuToY/QOCaMVWWdN78guifglhpdAh
	DYpwvO442gmioSZbGcX0R9Q7HDWe3eBl3B3zn+rEXHQzbcrL2jeE32ePwVP3oZO3
	ZVykFscTLwZ9g2AtKJBuzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0ss65t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:08:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL95jqs023653;
	Thu, 21 Nov 2024 09:08:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubv12p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 09:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhy9rPFDlDlIjKyTjZeS6nTnIShGcSFLfdkE51/PfSveMDG8JCUfzNeW+j3Gav1bvcRAQORzd59G9dsZYIDpEGWFMwQInSLt0mVI2P/Qm4nEOtrZc/p+Pe4FUskulOeumMFT/F5GXDWO4vr0SOKlQ9+BuwhyRtZUuZNQRtChZJsUpQOuE+Twee9tyBIZlDIp6of1d528aGCG0PrNB4vD3hjDY9Roq5VwsUyAHvt89yBvongbyNUHbJ0Ja45JLEiZiL2/vRCyGTZuZB0p1KDJmk0nm7Q8hs41LWS+pFggek9iqzRK86IoLB2ZQwUEUWJwEN6V12D3RdW7LrD8bnZasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1y+/wCXW5sbYIeCEFr/6bHcpqCHbLuzLubg8CLHJGE=;
 b=KtNRkkV4sAoEf3jQYuLeDdRu/I2Up/gIPU5CWDdcU5G8jRxuZ2Zp3BNqQtCkIiU4ing8nfBG1i5IbzUsk7+RjOo7mHeJeaz05RczI5pgIsUXK1o/zoMFlchhtm1WfpMWeq5LGzT0VHcCNHjK3+KaGEykrSJ33xvWGw/EhPFM9uwTDuGTgOIctnviCe+bcmgaGRfdd6oMDpCJwp2OtDJghpgs29r2XWIJ93W/Vi54b3FpVLO8Wnm5V/SrJiD/yEszppkTNGc0bhjBItBhi89lXBvKpXzGNhkzlRmZri4L6reAqfpUUb/Np1avc5pwmlfNT5Hc/KOrpFXETI/rNSvleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1y+/wCXW5sbYIeCEFr/6bHcpqCHbLuzLubg8CLHJGE=;
 b=TLe8sowPjJrjsQLqhKrPx+Ik4Z3JptBdQA/mqDQ2JCAZFCCXl42M1cnLQV9B5r036STZT6io2qVpRtnr0BPz7fN1WJYwZMtPyrwFfjZoPnX27a434Dp60/+2lAAHkDTGl3Wi5Rk+QgpUhyvrxcUZwXTZiqnDWS5//eXOdd3BvjM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 09:08:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 09:08:08 +0000
Message-ID: <8b303ed8-f819-4fa2-b447-8d8f4a42b380@oracle.com>
Date: Thu, 21 Nov 2024 09:08:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] blk-mq: introduce blk_mq_map_hw_queues
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
 <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: fd053992-7234-4a06-943a-08dd0a0c0417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckpXMFFUSE1DTmZ4UWRNSlNRMVkwTWtpRUxzOE1admI5Yk1qMXY2dVlwRTZU?=
 =?utf-8?B?MkQyTkEvRkJqMGFORlM2MWkrdlZEQ3VsV2lvbmhlRVR0UWxBc0RKYndCWFpH?=
 =?utf-8?B?VWJuUVVMRmZTVzRrSURLN1NsWmpRM3FFNDhkVithZUZaZ1d5UU9lVThxdHIy?=
 =?utf-8?B?Wi9oUlNUaUQrTHFjZW9aekdHNVdoQjlWdTBBYVQrOWdYN2kvakNyd2g4REgz?=
 =?utf-8?B?aXNPRkRjcDM4bjg4VjU1alZGUEwxMmdaQVozUjk2WCtNVjM5VjRERi9mc0VC?=
 =?utf-8?B?dEl4R1V1UWJsYlp2Q0tmNlFjREE1cWRWaG5FdWI5RzlzM2s2Zit1dElXbW0y?=
 =?utf-8?B?TGRJaDhwUFlqMzY2S29EZVVOL3l5L0VPbHZlYmJNQWNXOXhJNnlCei91d1lL?=
 =?utf-8?B?U3Y0RUN6Y2doYVlZT0R5bmZZeUlZOG83MEtIdXR4dUV0czR5cGxKc2N4ckxX?=
 =?utf-8?B?ajFCdjBrZ2VnRHJpWU5QMUloODhhb05HeE1jM2paei9YdVZzU3Rxa1d6VzFG?=
 =?utf-8?B?cjA0THlIa2w3UjJTeW9zUzhDNk1HVkRiWXBiUUhpVDNqTkIwVlAvZmUraG5T?=
 =?utf-8?B?aGI3Z0U1OWljaXZPOUtLcjhaMmVZT1BtVjJSV0E1bFBJWnRmekROVkw0L0ZY?=
 =?utf-8?B?bU1wVGh1cU9aa0FTUFZKWkhyNld5TkRkS29UTjJWVmdtQk5VNHhWRjc3U1dH?=
 =?utf-8?B?TUNNQXlMOU9YT3VuakhFV0dPREtFTDk0eTNWWExBM2RQdWpjRCszWHF3L3BP?=
 =?utf-8?B?N3VQZEpMOUI1WDRYNXl6M2UvU2djQnhJVnQ2S3ExRzBDZmF3bnJONk9pelJU?=
 =?utf-8?B?T0ZHb1pwMkV4UG5kaWo5TkNUdXdLMnE5K3EvRFBpbWo4MGZUUUc1YUtzYnhQ?=
 =?utf-8?B?QWlMUVl2alFYNUxEN0lQRlQ1Nk00SFNMcFY0UGwzVmVteWtiVytQRktLZUlY?=
 =?utf-8?B?czRESGVINC83TGhwVXlzZHBGRVFRVDFxYjNTT0tIRjVZdWY5M0poMEwrQUht?=
 =?utf-8?B?cHFpRlptWlRjdWRWR2hINUdOd2FYWjFLYzdVckhQVTQ5c0F2T3NabmV4SUhY?=
 =?utf-8?B?aDI3V09paXhGQWtpaGpwTE1nL3Q1WHdzbFdmdDZRR3UvMHFjaWFYWjU3M0xN?=
 =?utf-8?B?L1lZQ2tET2NNMlk1Qjk0dWJrSE9KbXFZWDRpaUY1NzRKUlowOUVkV3VITVp6?=
 =?utf-8?B?ZlVPN2tTNVBJWXljQkJDUmZacWNkUFl0VWhNWndTQWphYS9OUVhuanJLOVF1?=
 =?utf-8?B?QXFXSzRkVXQ3RCtJQVh2SVI1WGhwVWNLN0lYY21IbHl6Ung2MEc0TzZlMzkz?=
 =?utf-8?B?SVc4YXByTVUrL2xlQXorU2VacHF3V0VhNjhTVVBwY2hJdm91OWpZMkVxazBR?=
 =?utf-8?B?NUNOLzhyWERLTkJwYVlVbWZGRWFEdHIzcnhCRU5kUWxVSHd5VW5RU0lTS0Uw?=
 =?utf-8?B?Ujhqc2pPY003V0hoTWYzbDNkR2RabDJwdXdqZ3E0ZHpxWS9kbGVmaXBwenl6?=
 =?utf-8?B?QW9weEZKVnlqWFQxV0xaNGcrOWU1WmdscFhJSHNQbzVzbDBKNUV4RW1iL3hj?=
 =?utf-8?B?Q2duNmlYWVRvOVdwL24vU0J2anBDWXJmRmlBS1F5ZVFoblJlQkQ4MnVxS1Ix?=
 =?utf-8?B?N0NYZ3lhdDZBd05uSTgyaUJNYkFjUE5yU3VZNmd2Mlg5NXkwWVlyVGs0aFZY?=
 =?utf-8?B?YUgydjcxdmF5TzV5M3dyUllrbnkxZFZ0c3dPcHl4bVRMODdxQzVUVUt4QnlT?=
 =?utf-8?B?YUpERDUxOHh3b0w3dm5jR01MUmhGcmlpbDB6OU1MaGQ1cGJ0WDJlb0hZb3Qz?=
 =?utf-8?Q?Rj75SDtjD27Zl9LrpiCeU5cGtzpPhJ+k/zg+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE9LWmRZM1MxV3FFcWFVcGpjMUNUc1FRcEg5c3VYVFArTzJHRnNFQTJJKzcz?=
 =?utf-8?B?clNoaTNMS2k5K04zWDRFZFpqcmZaTEVIdi9DWlN3NDE4RUwxTVZjUkZTNGlM?=
 =?utf-8?B?T0t2T1Z5WHNsM3ExeG0xY05VaEVscDhzT2dNVUF2V0s2cmN2d0RaQ1M0Qnhs?=
 =?utf-8?B?YnJpLzdkZDluR2VyNUxYcTdCTXF3RXBVdjUrOFFEZjB1d3lvMlRtLy9oUFJH?=
 =?utf-8?B?UHFwSVVQd3BZS3FTT0tCVDBwVFNOSXVaSEdKNWd0NXFNbFFGZldNelgxbEFa?=
 =?utf-8?B?L29SQ2ZRTUVQbUVHUWRDcUtCNVVaT21uQzFlWGhjdm1VMDFhOWNxSXgwQm1u?=
 =?utf-8?B?MDF3dFl3VHBOR3Q4NUJwZTA2VGxTRmc5dGY5aWxMMUVCYTFKcHJzVjRUcEln?=
 =?utf-8?B?djZRQVg3YnVQVTgzRmpTRTNqWFc0d3BjVktXSW1yWkVVQjF3TUtlUkVMalY1?=
 =?utf-8?B?azdSYVBpMWo0MmxVRnNQcGtVL2FkTSs3TlZwWEZ2bXdwZmlmRDNpZkxHbVhy?=
 =?utf-8?B?QkxiQUhuZlFzOGNlTDhrVjd5d3dzUVZZM01wT3hjem8rNm12Qy9jcE41d3Nq?=
 =?utf-8?B?VGtjbTd6OUJYZnZ1aGpXOWNSY2ZQRHJUVllWbm9SVU80ZGg4TjhoUkMwdFdp?=
 =?utf-8?B?eTN0ekJnUFBsN0p1RjlQTzJ0Y0VnSGlEb24vUnRTNEhwU09ud0VUMllKN1kz?=
 =?utf-8?B?YW1QTTU3cE1oOUx3UVhVNDNiMFdwS3dMQlFXQURaSzh4bWdmcTdVOTVhaVJH?=
 =?utf-8?B?UFdDU01rbHpqN1VGcldwY3JZalJrUXJnbFk3cXB4ZDlmVUdKemNNc1FwcEVj?=
 =?utf-8?B?ZlhXQ1M3dzdWTHFNb2ZOM2pTRTJIcXI3bW5WVHJaN3ZnRG1EdEZWOVJNNWRD?=
 =?utf-8?B?V28vSU1BWW41ZFJIbjlxVDRjdmZhcUhja2J3OTNvWldaY1UzTURNSDM1OThx?=
 =?utf-8?B?ZWVIMnZCYU5tSnFsakNhTkpaNXRoK0hrTzg5NlVzZDFXbis1WnlHZEtLb3NF?=
 =?utf-8?B?MnNtbXBxakVIYlZXSlk0QVdHWTU3RTNHMzZrb1dKcXdTcVdiT1IvaXNENktN?=
 =?utf-8?B?ejMvQWEzL0pIYWZpRmE2dzhTQVJtNnBrNWlmd2tSbUFPYVc4eExmdWMvMTF4?=
 =?utf-8?B?bHdEWUk5R3E4QnRRRnZjS0NOSDAxZTdJY2pFcHhzY0NMOXNDTjBwa2pWWUxk?=
 =?utf-8?B?NDlzeUlKNXN1UnZGQ3FsS0hIQnVra2srbTM0djJ3NnByOXYxUUlraGc4Nmx0?=
 =?utf-8?B?NzRMeFd1cjBNS1dONmJIallaUGdDV3EwN1BVbndkM281blZlQW4rZkVQRGVt?=
 =?utf-8?B?YUs5SVk1eHIzbGRzTGN6VUZtTmRsOC96WFdyVkZRTStMaCtsNHpTM0dLYk9y?=
 =?utf-8?B?NWloTmQ5ZXRKbWhndWdkTFErU0tsRk1Qc3MxeUtIWWJvRnFhb2tmdE1vNkZC?=
 =?utf-8?B?U0RVRXg5OGZtOUhzVHFQOEc4QkNtMWRPWDVVMjJSWC8wN1p5NzJJQnlCSFFx?=
 =?utf-8?B?NnpLTWlGQ0FyU3ZFNXVMV1NiUkx6WTJpaUI5WjM5NHJUQ1FMUEtWSXFwVFpy?=
 =?utf-8?B?dDR1T2ZPYS9td1NsU1BPQzFqbGhoaTJ3azIzVzFkd0NRNzA4YXY5dnFvZmRs?=
 =?utf-8?B?b2hRVUhMWDBNUkZtcGNSZTk3N0hqNnVqb28zSUpTT2wySkN1N1J6QUZKaEJQ?=
 =?utf-8?B?dkZISFplVWZSbU5WS2djK0VxVEFLNmZBcStndGpGUlhQdXZUTlV0Q2hsbFUw?=
 =?utf-8?B?M20xM3BNcXFud3FzMmVxSlFITjdremJ6ZnFVNnlvUXR3WDJsZ2g5OEo1cmZl?=
 =?utf-8?B?ZWE1Mm9KOHNtL1VTd1B1dDFIQld6K21kNUUyQ3BWcXJjRmNkNnRVWTRESnl6?=
 =?utf-8?B?L1NvTEVXU1RKR3F2ZjAzZEhsc3pJTzVGazE2bkpWUnpCcHRqc1BHVkxxZ1ZY?=
 =?utf-8?B?TE5mdE9DR3QxajlzajhMSkdabWdRK1ZqVWVpZGJ4dmxzZFFNT0tmbk9ORWs4?=
 =?utf-8?B?SlUrM1daMFUyQnFlYkhBa2lORXpZV0txbUQ3RzdRWmdIOUR1S25Rd1hndE9Z?=
 =?utf-8?B?c3JFUkRleTEvOW1nNkdMS05FeWRIWkM5ZnoxNlpINzJpV2tuMUxSN0MyUW9J?=
 =?utf-8?Q?KGgcIK33pnZI5y0kdT/53ZoRq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PsFqlv0jdTVsqZBsTAKJZhk8p7vX/ocqtvUYo9SeRHi0Shal8B/EJ7CIHTI9TJR9xHx1ynkr9Gw2CjT0dNOFDrTu5D8bfgiuVl2ex6sHiYW/2rf1VRRnfVyHPAA8AzJL5twNp/cL3L14wQ081VNpFgkvl65oh4a7zt7kW5KyEJt/2tD9K9+EN5NdLZaPTcRsotYiWllq3Fh9DYOYEOJZKZLzz6oiWYBKM0F6o4b5T/FOweKPIEnlovVyCIofH/pEk6FQrmHHscVbaUB5oCGoUmkforRVf1UEgbeVuXUZcxqYlYjeT1WF3WHpBgpJ34y+LFctSoeF2fjhsL/PuGd9E4u5idM5lQ24BQ9XdqSG18AnOlPTgkQIJCUfxK7RflQF5ugU0Zf5+9Bn4gnuFQ9AG+K6RPPFYzvVkGnz4Kcu+YbtX74d/Bbsg8sGK5TkituJCGZ7PlEcGHjdR6UCMyjGzunXtNIvF4VZBEFK18qDrEFyecFzpHWB58Fx9GuGF515aeYncBtXIjTJogdVpZnNlzYGVhQqAOvCREupjcpEvIj44U9ANs+j1tSuBIEMn3hofu+yV9jvKK36dFnosLpt/ELgDfe1YPiMRI66XEUCciY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd053992-7234-4a06-943a-08dd0a0c0417
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:08:08.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJpIlsbp4vpVvlpwIrEBnpyE4/anlXR6+jxPtCVYGkmEXrejjNHd4UTdzr5SJEVusc/vgUTG/HWoOh7JOO+qZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210070
X-Proofpoint-ORIG-GUID: 63mAt6V9ZHKfKPDpAMr724zjJ0sAtqNc
X-Proofpoint-GUID: 63mAt6V9ZHKfKPDpAMr724zjJ0sAtqNc

On 15/11/2024 16:37, Daniel Wagner wrote:
> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
> hardware queue mapping based on affinity information. These two function
> share common code and only differ on how the affinity information is
> retrieved. Also, those functions are located in the block subsystem
> where it doesn't really fit in. They are virtio and pci subsystem
> specific.
> 
> Thus introduce provide a generic mapping function which uses the
> irq_get_affinity callback from bus_type.
> 
> Originally idea from Ming Lei <ming.lei@redhat.com>
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Just a couple of styling queries/comments, below:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..0b65ffa5a183cc8e6697df4a16748eff15bfa8b3 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -11,6 +11,7 @@
>   #include <linux/smp.h>
>   #include <linux/cpu.h>
>   #include <linux/group_cpus.h>
> +#include <linux/device/bus.h>
>   
>   #include "blk.h"
>   #include "blk-mq.h"
> @@ -54,3 +55,39 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
>   
>   	return NUMA_NO_NODE;
>   }
> +
> +/**
> + * blk_mq_map_hw_queues - Create CPU to hardware queue mapping
> + * @qmap:	CPU to hardware queue map.
> + * @dev:	The device to map queues.
> + * @offset:	Queue offset to use for the device.

supernit: maybe no '.'

> + *
> + * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
> + * irq_get_affinity callback will be used to retrieve the affinity.
> + */
> +void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
> +			  struct device *dev, unsigned int offset)
> +
> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +
> +	if (!dev->bus->irq_get_affinity)
> +		goto fallback;
> +
> +	for (queue = 0; queue < qmap->nr_queues; queue++) {
> +		mask = dev->bus->irq_get_affinity(dev, queue + offset);
> +		if (!mask)
> +			goto fallback;
> +
> +		for_each_cpu(cpu, mask)
> +			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> +	}
> +
> +	return;
> +
> +fallback:
> +	WARN_ON_ONCE(qmap->nr_queues > 1);
> +	blk_mq_clear_mq_map(qmap);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);

is there still a blank line at the bottom of the file?

> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2035fad3131fb60781957095ce8a3a941dd104be..05f544a9ed873d2f96d72c18e124c94146f6943f 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -923,6 +923,8 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
>   void blk_freeze_queue_start_non_owner(struct request_queue *q);
>   
>   void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
> +void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
> +			  struct device *dev, unsigned int offset);
>   void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
>   
>   void blk_mq_quiesce_queue_nowait(struct request_queue *q);
> 


