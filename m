Return-Path: <linux-pci+bounces-16754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53C9C89DC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 13:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBDB27F90
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FF1F9AAE;
	Thu, 14 Nov 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ck+wjqrA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i+CPUt88"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98E1F77B8;
	Thu, 14 Nov 2024 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586915; cv=fail; b=Ub7c0CvQxii2EpEdM7MknIpAPbUNbhB6nN7R8tQlIRdWB2G+ifElHkaTKDKwY+k3mWNj4IIMZD8q3dVL0SmWV7i3FSNpM+SsJsMA2ZFB1C2ALXkfqBdhnNPmaqEmFy9MoGegvyjsvZSHuglKPtAr+e4+H0IIboKSo0KBBVla2Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586915; c=relaxed/simple;
	bh=H63xyG5GhSqvkU48g8Xft0RwnrAEv1b8NatL3LKYaEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5nPGCov4XcJgVjD++UYbyeQOtM82gMd437SRWvWkUC51bSAQMsivDij3W22DBaL9qH5o99/CLZaJ0HzZE5vvP2B6EFmzs143xbwDo0WAXUaM8fIfHlCTMV35K2B9pAkhaxsGUirci6PPFZYYjji6LGHA6W520PJmNdrbMjXH08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ck+wjqrA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i+CPUt88; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1fcnE018624;
	Thu, 14 Nov 2024 12:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=crQlJTPJNTAO8C7hvD83K1t0364PZk/fVC8lhMxz8NY=; b=
	ck+wjqrA8EKbtMd28ZPq4SZgn3sFMmZbEHIv29601tFZL/Ksl6te505b1zsah94I
	wSRUhJ3YYnEXScdfHtPjo4wwD/2YoVgS7DsEWX8QASeyqxbFmYFTScKrH2ktHL3e
	v+Ch5RABssZAVpjf2YaBGixMqltFzB6C4WA204pGpHVc8CtJ3dhkzz3T167Kyh6d
	BVvbLTp96lOf6ambgEeuYZPDJCs7zsf4Q3rFOdPvh0a4lFAcA54zFqx5vasH7ElV
	l+ETSWLzI9wR6oMywIEDa9B/rvgtrnbRFt/GANXg9F48EHfnBDZOjCPXgqMk2as7
	GwjEVCtwre9Hk7BLaosmvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc15sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:21:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEB6ixG006016;
	Thu, 14 Nov 2024 12:21:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b3rdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 12:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJbdTCjXhNjbs2rS2Q4jZBgdzXfSsisuRxSRGEn1TNjo8XMAZWHbUwaqQsbU2lU2NLUy/V0mvrZQ/Ee2z6DS0R9vOFH7sGkVrKAi+KukZ3z8K8jAtYOBfpU9qE93r2kbjePOweV1xe0H3JlSxT3hTCRhdRsrLWwjBFNODyMKQ9kOUifzZ3ohwZoZjvIzbrN1+pvo0qOuPP7mxdwU/O8Qgt6N80OA/gn61sqbmaU8Uj1BtC05CbOZUiLj8LAj0t7v8OEgIa/U+Mg3YVwqVeRqb8Ljq/v6kdUMpECZ2zzI8b+RzQ4302SfWDmzUKHsSS4UB6FQGvslj4kIti3QgzSjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crQlJTPJNTAO8C7hvD83K1t0364PZk/fVC8lhMxz8NY=;
 b=knz5wbGkcKPrCkB/BNGNBEHMdfQfNhlWfB/TR8+wYtGIXH/nC12DXp2+zw8CacUimhtA+nH63eM65JWj/+PZ3+pQkA8RAH0yqreLEgb3jIAbe6WwE3Y6uPPPuFad2Cnro4JRh+CE6qFNQyceUvt6ntKZr2sdrineWEsuUVQLpy8ZF8i4VQzwsIbGQYU+ik2PCpZw0OByk3YyTNRIHYqrFQEBVUgICOU5dBHZmOBwZQU30+miJ/tEJ//DdTq8xGpfvt9/fvOBNLPNXyCfNIbuNBZVULEhXWqZLCpHLXpar5M7BEeG28t5bJYijKl/deM/NZfTIqCQpJrhb0gj3SQbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crQlJTPJNTAO8C7hvD83K1t0364PZk/fVC8lhMxz8NY=;
 b=i+CPUt88zpNMa7n9OoX2Mm+240i6BBDYR+7r3ewOr7pCm8OD/S8LxLXxThUoCKOsfxrLHVeAI2egK6gdM3OtZNDS4OmuS2t/698sIetRiOOnoZwve+OpEI5ftMRTRlyEG5k0YMJwu6ZvZStybgW9nSMdxNtqj/cbfJ5nx1BrL2U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7024.namprd10.prod.outlook.com (2603:10b6:806:318::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.31; Thu, 14 Nov
 2024 12:20:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 12:20:57 +0000
Message-ID: <5ea5d717-8fb1-4db3-9190-88cc9e6037fb@oracle.com>
Date: Thu, 14 Nov 2024 12:20:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
To: Daniel Wagner <dwagner@suse.de>, Ming Lei <ming.lei@redhat.com>
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
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
        linux-nvme@lists.infradead.org
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
 <ZzVZQbZOYhNF08LX@fedora>
 <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local>
 <ZzW-9rWvKBxFZU1E@fedora>
 <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
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
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4313e1e0-c2db-4110-b840-08dd04a6cb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGNSSXFhYlVJS2VpSDIwaHJMRkVBcDRCeXNFcnVoRHQyKzNyeXNRSzhsbjlz?=
 =?utf-8?B?OUJyS01mYVZmK1pHdlFvTzVBak8vL2ZBd0FtcXpXLzNjRDVWV2pwaGtUZHNL?=
 =?utf-8?B?cWJpTS94T3ZuS20rMU4xcDZNQVd3OGkxbUlsWkNsdWc3VmdJdjYvN1h6WGF3?=
 =?utf-8?B?NFRoQ29vM21MZ2hnWi9SUnYzNFJ6NmNGamFTSlRRbjk0S2JyWHR0ZG1DWFkr?=
 =?utf-8?B?Wm9Ka3N4eUxTd1hPSHdielYrSkV1cVVTNm9XTWJEZ0JmSWJpYnZaeGt5ditw?=
 =?utf-8?B?TXlnb3VmRG9zSXpRS2VQZDBQS3dsUDMwdDVBdUx5UHhYT0ZCN3hZVnV6eFlP?=
 =?utf-8?B?OGpVUkJLOXFtejg4M1pOUmR3YWgzNFpNUEVYYjgrR3J3UDMyQlNLQWM5Sndh?=
 =?utf-8?B?aXppbnNXTXI0SW5ndDNkUFRDeWYvTEtia2JLQVBmcnV1b1pxMXJCUjFXVG9m?=
 =?utf-8?B?dE5LOStFeTJ6MG9HM25Fa0I4TEFUb1hQN1RBSTNra0Z4S080QVNhaWxpcmVs?=
 =?utf-8?B?dE5LM0x2a0xnU29ieVlLVUJSWHFKRWlyQjNtSE9UUUN6L2o1ZGtuVTYxQVFt?=
 =?utf-8?B?ajZkYjFpZitMeis5c1hoQUE1ejUwV2Z5SFJhRk9Oam9VMUQxV2Y1TTBrSHFK?=
 =?utf-8?B?V0toTVk4UXVBMXlVSk9ucjV6SkQrNmRmcHdBNW0wNHpYRjNXN3BvM0ZPVTVJ?=
 =?utf-8?B?WVJoVU9LR2FsZHlmVWVuMVVxeHA3cjlmQUxRdXBKVUl2bXdFb25zaGNta0ly?=
 =?utf-8?B?Z0ZxdGJDek9ldzZ4TSs5YzNScDVXZ1plZE80UkhVaGIzRzZlWG00WVFHZmZj?=
 =?utf-8?B?dlJ3L0ZjT0o1NGR4K2NaODgxVXBua2FKcTlPRitWM0x5dWV2QktDWTlTU0p0?=
 =?utf-8?B?a0NiZGx6NzBMNnJ5Y2FMcEF3NjdjZngrWUtIbU1OYjdaRFVTcUcwbnR3VXJP?=
 =?utf-8?B?NXJBS0RlVEtMU3c0MXpZVWFpVFIzVGhBUllEckdVWnQ3R2t0bG5UaXp5WFNP?=
 =?utf-8?B?M0NJNUdHRlFqM3FsbFBRWXNlTzhvY3RBdVBNVmlTbGpaamNWcEEzcGlZenFL?=
 =?utf-8?B?Z09BcDhVM01haHZIYmltR2xGK3hFTHVKeDFuZnNLVGJLczZZUGxSMHJuOXJa?=
 =?utf-8?B?K3hIT2hpOXFxanRtQXZ3NktTQ3VNZlJpVE02ZU10TkNvM3FaZkVjcytMQzcz?=
 =?utf-8?B?cUxHd0J0OXBIUWJsaFhJSXdOWVBsRlpnZmp5N2VWbmh2Zmg0NFBWd2dLZ1FF?=
 =?utf-8?B?ZStXR2J5cjF5MWNBcDZpS2x4QVkxNzZRQlg3UzVCc24yZTdvaHZjYlVkM1NH?=
 =?utf-8?B?bDB2TWpiUTFsNFlmdEdDQndqLzk1bkhDNGFsYkw3cVNUNTlhZzh0RWFWUjJy?=
 =?utf-8?B?VjlUUWJJcmd4OFBubWs2YWdQVkVmZlM0aGdzbzlYY2UreTFMNnJBdkJXK1hT?=
 =?utf-8?B?VGRpcXhzcFp0cXdKMS81NkY5Z24xWWNndzNhWnVLTHdtSVNjL0hxME9IUzVN?=
 =?utf-8?B?ZkkyeWxkYmlqTFJqOFYybkhCU0M0M0lyaEFiTXJMa3dqMnNyZ0haM2tldk42?=
 =?utf-8?B?YnlFdW9yN0J0cHRmMU9xb1lzbVJ2TXQ4TXQralZFOXpKYW1YblJxVHNLZkNp?=
 =?utf-8?B?anlwYU1jaUxUamFVenRieEppYXE2cjRwaXZGUFJ4Y0NGck44RlpUeE1ZYyt6?=
 =?utf-8?Q?jh7Z8vlNZqs+8ySVOr+n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek5yV0FLaFdMcnp1VUYvM05vVkZjZy9rSDAvYThXWjhhZU9CRGFPMHF4dHc3?=
 =?utf-8?B?N1RXTytUN011VlIyOUNxR0Q4bmVoenI4cE52QWFYc0E0VWZQRk9ySmNlZTRH?=
 =?utf-8?B?M1RKSHJlVXdpTHBCS3dDY1I2a1R4VEh2OHZpd1FJaCtBMlpyWHRwdzE4M2xM?=
 =?utf-8?B?c014Sy9OOFRJRnpqWFRTSm9adVlZWmVsKy9PQUxLaUtRS05ONnNiWVA1UzBF?=
 =?utf-8?B?R2pvWkhDb3crVFplWWE3TWV2SDdjeTk1TEhyOHNoQk9TaFhxUWo2WUJMRzVm?=
 =?utf-8?B?Z09SQm9WT3ZKdlBUK0p0ZWNDbmVGRExzT3JEZXhZUWE4MkphakdwVFV1YTk2?=
 =?utf-8?B?cmo3ZVFOMzdmRXBUSTE3TEZvMS9pdCtLTysvMTFBZ0RkM2R5VUxpeVg2MHg0?=
 =?utf-8?B?d0VMYjBhSXJJalVGeVhmaktwZjgveWFXSFRjMW1LR1IrTS92dTdjTDJMOVp0?=
 =?utf-8?B?U0lRQmJicDMydTErOGZrRTMraW1odVNvVGNlNlNLN215dEc0NTJHMUVPenU0?=
 =?utf-8?B?d2Vsczg2SkoyeGNWQkNqNFhPZy9rMlY3a1F0NThuMmkvZkx3cU1NbFhTSGho?=
 =?utf-8?B?eGgxVmIxWGFiWEV0TmtWY1dCNXFLUXRac0s5TzIwZ1I5a0VvdmJjaGQvRkw4?=
 =?utf-8?B?MXVQWjFXUUZIaW1QbjMwWUkrd0xqMGYrMVZ4c2JuNytGbzJZUFZlQVpweEVm?=
 =?utf-8?B?UWxOTXp5VnNSS3hvUHE2N3RmQzhhOUlGMEJuWUxyVWFVZFZVaTNYM2VvMUww?=
 =?utf-8?B?dlk4ck9iY2ZmU0UwNG9vMG4xNVlZVkNHWFJXdXFxYjZrOXhkWDVyYlFBOTlo?=
 =?utf-8?B?ZWkvcWFKdEg5WlBFRGpaNTE3R1o3NWdXQmFoa1UyZHFNQ3ltbERTYlFuL1dv?=
 =?utf-8?B?R0drcXRHN28vQmEvSG9Od1JkK1B3RWNmQ3NhdHd2THVQY1ZUeE9iM1hOQURV?=
 =?utf-8?B?N3lUT2p3WDlSSGw1YU1UaURDQ3RXQUVuTW0vMTNtQmVBWS9XMG5ibGdiT0ov?=
 =?utf-8?B?aFdoYkxMUzh4UE5ZMVFsZm5tWnZ2eHNzek5OVVUxNnY5SjU2d3EweUFTdnBY?=
 =?utf-8?B?eWNMODk2dXdSQXZBVVhkcVFMM1F3MGdodnFJTlF2SkN1MkEyKzJXVEEweVpV?=
 =?utf-8?B?Yk80S0J2Z2NYZkN4clNHMmFyRHo2THh6UC8zMUZ6TTFIdUNLc3YwdnVFUU1R?=
 =?utf-8?B?WFlGYXMxVXQzSFRHWjh4VHk5bXAvcXk0VEpHMGV2dEpTZmJMSDVTSXFwbTB2?=
 =?utf-8?B?bmR6RHJDMnBneFZKamx3WDFEQnBkd3Z1Z09EU0NJd2RtbXo4K0FJeExUUEVK?=
 =?utf-8?B?c0FVWkErVVNaZVB3QzI3bXA2UlFTdnF4a1dTY0laaHloeTNZMmdIWGdCM0ZU?=
 =?utf-8?B?clR1d0VVQWp3SHB1SXk3aGpFQW9oZWdPWkxBNFcyb0xiRzdkQTQ5OFQ1bldK?=
 =?utf-8?B?SWxTc2VVeTVjeVRSODB0RHo4d2FZRFIyQ0JhbmdEY2tkNU5xTVhWVWd6MG5T?=
 =?utf-8?B?N3FQejRtVGlBanVDVWV0aFU0U3U3bWt0SGxyOW1ZZkFuVVRiTkQ3WVNpT2ln?=
 =?utf-8?B?d1NPemtjbThKZHhJczk3emtnMDJjRmMzQ0N5bHBtdzFxRmx1R0hKSHppRlEw?=
 =?utf-8?B?WFFIQjg0T3lHeTZudXlsWXRtWVZOSHd3VjVMTE5BeTFMeDFvR0tJUy9ybW1p?=
 =?utf-8?B?SkEvNTRTQmpqOGtTZWFSRVBkNDBIajlwRzFFUHFLMktxQUs4b011WWNZVGtq?=
 =?utf-8?B?RTVma0JHUzZHaGtEMlVJMm5hOTRrSVEvamU1MW92OHd2RE9EQVJsZVhsNGoz?=
 =?utf-8?B?UllzWTVVTnVJVHo4ZUVmMkRReURXS2JtOElFcm96K0pPMjdXUlQ1ekJUeS9J?=
 =?utf-8?B?bUlIVCtSc0prUWY0dE1uNVRLeFdOZUpXVk1zeDl3bTNLcHpPelhOWU0yOHFW?=
 =?utf-8?B?M3o1SEE0TmJJQmtpdGJaSDFtdWpEQ3RPbnVtQzliTDgzZHBLK2dBdUprNWdm?=
 =?utf-8?B?cVpBSnpnK095UzFPd3B5elA0U2RkYzdZSnZIOGFSTXJ6a1E4MGFZSFdTWGF4?=
 =?utf-8?B?TUdOTks4TGJCOWwxWEY5ajVTcW81SjZEbjRRWGpRaE1wS290dS9FaGVJUkxH?=
 =?utf-8?Q?1oGmVF5mwYUc0TasZWKlAGD80?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i5tkZvJOyEDrNxbFAm/jA7noIDjvLP8fUB4gWk1Xa2ZIBFS+hUCOTRByFLvIDESXy0+VHV3ywtPFswb4mKysUMnsJCaSZfY5oLMvCrYgAO5zO7i6i20wnDuhuSTPevJ6hffEuw6Y/dOPN0T0LQNqMYsDSY6dtZ7hlqlzd/CFD1GHU7apSMJQljEz2Ln5klGhyiiLuBTK/hb5nlNewQVgS+R5HVN7JTi8Y5MlYBsD51OI3MG/kz1TLI4V/EcuqHTctF57djLVKr+rc/YRPE9cTgHbEoDHpIEbxpzVNzvuZTkaHwydDLaGJpJLQvhYfFIG/QBEyOBxfVIUBgn1KTA3JNPiG7WZx4OVc4QRFftZPNwbmBj/mErMKP2Ogb5hJIw+4YbsjmkxA+SGhgDDWELRBCYJeN+TJttT08/11hrVt7KwmdFclwlqYP31sI2DfViKi/WcjcOZySu3Lu2ib5d1pl+Ny9eJL4uUDpUGSD4LOu+Xm7IgVoAJbA1n34/yYKKCoV2Uzx7+GFgTCPm+kwFQgVSqkqcTP4obHnIoU5Wf307yOip/bbo/S9vLg4oAnt1n76gpR36OAEiESWY3WH6PgcU9EniflbHwoJe0g+G21RM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4313e1e0-c2db-4110-b840-08dd04a6cb0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 12:20:57.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9iksXNMdv0ZnST7PwpKq3UXASCKmB+SqbOjBmDfF8X4Ipu244EPz30BAv8iztrRydfu2iu6yXQfcBWWsH21gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_04,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140096
X-Proofpoint-GUID: siSm1H12kiE-c0nYAWD8UvR96_fyrk7U
X-Proofpoint-ORIG-GUID: siSm1H12kiE-c0nYAWD8UvR96_fyrk7U

On 14/11/2024 12:06, Daniel Wagner wrote:
> On Thu, Nov 14, 2024 at 05:12:22PM +0800, Ming Lei wrote:
>> I feel driver should get higher priority, but in the probe() example,
>> call_driver_probe() actually tries bus->probe() first.
>>
>> But looks not an issue for this patchset since only hisi_sas_v2_driver(platform_driver)
>> defines ->irq_get_affinity(), but the platform_bus_type doesn't have
>> the callback.
> Oh, I was not aware of this ordering. And after digging this up here:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/ 
> all/20060105142951.13.01@flint.arm.linux.org.uk/__;!!ACWV5N9M2RV99hQ! 
> IWDpRwKfvo0y1LzokS_0YDXzX7eZLeVUcaTOFCpn0yEcV2e5gknO2Q3igMwPhA1Mhq6IOKBOkiLxHYe-0sM$ 
> 
> I don't think we it's worthwhile to add the callback to device_driver
> just for hisi_sas_v2. So I am going to drop this part again.

I agree. I would not add anything new to core code just for that driver.

