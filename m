Return-Path: <linux-pci+bounces-16657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5A9C74DF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B88FB257C9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B280282ED;
	Wed, 13 Nov 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EeOGWipv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hMqspxDN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956B44C7C;
	Wed, 13 Nov 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507193; cv=fail; b=tzE+CSmtR9mCp/b/DrvPSPSyaAaXLQrToBaEwA1e84TNk0PaRgMlDx4nU3TzzW+wDpLs6nnH7BFlBsIJ6UxU/ZNo53OIHfryt77iX2DL/bnjKZWhO0nA+4jwxdgx9f4Vh+C/mtMlGs0Y2VCq8eu6Z/6MymTb/R6Ba1n8U01oU78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507193; c=relaxed/simple;
	bh=dp+nnGcFEFrGqFak41Blx568oe0CPaYOdAuYt9hFnWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dG+rx93Cvz/pMQ4NbFpA0oZlohkIM3/Ag0murJy5YN5kv23ppbsPV8gZVqOp1APW/dacQoQ/4w3H/TFxUn3XsiLMy+vR9ADh3uThL8DKTksuxEUon16iu72pMQCytVhQXW83tISb9+aYDii+npwtZ46BJ0Mufwi9avTVoEE6qn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EeOGWipv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hMqspxDN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXYVK010712;
	Wed, 13 Nov 2024 14:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hEXygH8dirUdTPGK5oiAoN3u4wRFPuGYXSleSK/maJg=; b=
	EeOGWipvCoSHp+hypbVlHwXtLzQbSF/laT7GEjDmsWZlPYi7ai8NN8h+kn0/wfmc
	Hx/bPmaIniszSTU2lNVdiBR1IY9mzAen4vi1Zht4aw3zm3MN+VNzwl2cGNU7ZsFC
	wmSZhXwEZWAxe6smiFm3P1Ta37IOuDCNlO3jij/yEluKu6iyVY2Qxx5Ba3ca3bnM
	hbcViDW3EyznXuKxxGRYR8P5rZ+U/p1aDlq2bZVSIx+DGAurHnnpCCrhiWob1AEO
	m6uMibYec4QCw+tCQfu/Vsyc2BoRAVr1HcVWm3YxOfidS6xdiyOAKDT395vjZobS
	N+IwaoY1DixRVWmjGPf/Hg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5etgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:12:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDwra5005656;
	Wed, 13 Nov 2024 14:12:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69p3q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8cNXxcOLMg+ouWQ9q4MKAAsrl6f+XPI4uEe9Uz36esfSDOaEDLeqdDI2Zx/KqGc1zDQ/8dLLvghqRrFSDh9lHsTGAJGmKWMVOjwr7/kZAY833VOY/lxQP0dRDBfgiR3XntbT7+FpjYjQqIz6vyPMpJm3xdf/vkTqRKVxupZPIknJL97HmlmESCVRwsSWUTKvLAsXYCVkzK4n7NgZKvblNGnPmAXJMMOV2kGJWO1bYvGohIYhCEEheavgFtpWiQtBkCcj01pQqa5B52/8Z56Vj1ypOtODAMbwMu5DW3dHkst5WLVvdRCtwOObk8/rSRDoN4TG/yeoVpMaAAb/NY2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEXygH8dirUdTPGK5oiAoN3u4wRFPuGYXSleSK/maJg=;
 b=CDJd9JdUX1/SpDFfAsFhoMRsL1qE5vENC8UCPl/WAqC2pzOUS2dToKDuahO3MxcOHiQmNlSwxmKunwmXeovBDuNjmx86r/LIR0/wJubHieAzfPpGCLOIE1KARd7FhUeH09esijQgWL3kTq5h6tl31o/drE/NKaluVmSdCpcMm/5PI71FUkZ9XvERsAyC1GBCp871jtY9Erb3fR5OIgU+iF0ytqXUDO9nWGTG8EtZU3WzA62wJzlIN7iFmlJMjaVO5o7pAkocxT89LRp3jLahzShq4GTNiVIgtcKi+LCx6+M+a1MAg5yr8PRGjm9EHdBOH/FS0iHF7pTsc1dmyvfN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEXygH8dirUdTPGK5oiAoN3u4wRFPuGYXSleSK/maJg=;
 b=hMqspxDN3Uiz9IxkTMie1EkNqoH8OwCvzGUmKHoORwV9NgRC4byOcJezFkZ9yR+q07wHun++SLH1OO4MZS5f221s58qcG38n3DH+2exNLgRzyBsgx96jMHAceTuuc6LIJKbte+wVTDnSO66ZLFkyPvqSiAJ50nrZNobWW3fnKwk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 14:12:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 14:12:35 +0000
Message-ID: <5ed6e072-5ff1-4327-aee1-e6cdf673fa67@oracle.com>
Date: Wed, 13 Nov 2024 14:12:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
        linux-nvme@lists.infradead.org
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
 <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
 <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
 <2024111323-darkening-sappy-23fa@gregkh>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2024111323-darkening-sappy-23fa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b06a411-80a0-48e6-c824-08dd03ed38e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eldPS0wzaDUxWXNPejZqNkVJOTZ6NVFCc1pVandITktuQUhRemRpb2oxaVpt?=
 =?utf-8?B?QUgrREtLQXlualdraHY0eXpLOWdhL3h6MnBseHdPWFN0UmpINHVtMFhYS1hY?=
 =?utf-8?B?KzVvT1ExQmVLQnkvK1VGMEFXV3dsRGpjdjBsQTdRcElsS0ZWdDZFendQdm1p?=
 =?utf-8?B?OFg2RjZQUUJCVWpCa3hGenB3WDJsTUNTaGNIWEhyMGlpN2ZOY1R0Nmh2MCtm?=
 =?utf-8?B?MUlsVmx6NEZaQmxuWU1xWEwvVTJMd3B2bkRtT1JIOXR0dExIN1dSYlF1SFBP?=
 =?utf-8?B?RUJwS0FNMDZ5Wm5PUzh2SmpDVlZGcEJmb3Zldm9oYXV6aEV1UGR2TCtXSTJR?=
 =?utf-8?B?OWNUQUYrMnZrd01aRzlRRnJYbm4rNnBDeFV5SHhUaEZoS1lrY0owR2ZoNmFn?=
 =?utf-8?B?bFU5U1gveEovUG5kN1B0Sm51eEFyWXNXbXRJWjBkNHpwUTFzeDFMaHNnb0hm?=
 =?utf-8?B?bngyWDlRMEtpWDNZSHZrb0xMZmFwdW1kNXY3R1JieFowTm03aFVFOWFYeHRM?=
 =?utf-8?B?SUVPTWx0Y0hCWHJsVmMvdVF3ZGVXOWdBTERCWXltRFYvdE9BUFQ5NXNMODRO?=
 =?utf-8?B?VjJCTVZMWEFPRVUycWVubVVmU3hyU2ZZQWlmbVhCVTVDUjg5MGh6aWU3SExW?=
 =?utf-8?B?Um1tQ1ZCbnNvYWc0eC85cElOK0ZpNms0ZDkycFRFTGpzNnZwblQvUGJKVDNl?=
 =?utf-8?B?MXJVMG8ydkU0R096SFpwM29pUjU5WGVmR0tFMWxycjVQK05MNmNPSWlaQlc1?=
 =?utf-8?B?ZjZVYjhNS1VqM015S1ZjclFYeGw5WFpmVnI0cm04Nk9TczNncm1mbHV6bWE1?=
 =?utf-8?B?TEtRSk9hUEJFQm1xOFdZNlpLU2F6d3k4VGtLUmZzZWVRRmFVeHVUd3ptbHdE?=
 =?utf-8?B?ZXRkaWcrcHhrM1R5NjVtNlpDZmxsdWFORWx1VVRRU0dBU2p6QTJVcU42SnIz?=
 =?utf-8?B?L0lKUUFrNENGNnZETExOMFVFMFpaa2FuMmVEb3lmZStuTFk1d1BDZER1RHVk?=
 =?utf-8?B?TFpSTjl0VmZZblRGeXp1OFVvNGZIb1JLS1pWVkhhN0dzTVU0YTlkeVd2TUpu?=
 =?utf-8?B?M250TUx4Vkk2a2QvbUptWlV6MzNncDVRb1NUUHZEUlRkZlRmdVc3eFh3RlFN?=
 =?utf-8?B?aktOckNpMlpnTVd3UnVQK1RSdzlMeS9vRUx1blZDaXNPT0dlbGRrWWhiQmNT?=
 =?utf-8?B?U0lsdFJDUG9aWndlUy9SUXVJMlJ1WHRFNXhUWWoxeWhCQURzQ0prS2tzcnk1?=
 =?utf-8?B?ZmlIdVlQR3VNcjBmaFlybW81NXJERS9Sa3RGdURrQ3FyMzQ5K1lDTjdwVjRu?=
 =?utf-8?B?VmJoQmZ6OXRZcFVmdGhjdDVRU0dYRnd1RDU1UVVJNS9vUFhBWmRJdEZtcTZB?=
 =?utf-8?B?TUdIOGZ0Z281OWRRSFBIbzRaNkdHQTAvYnFJcHpibkwyYm1XVEdjMDc0S2hp?=
 =?utf-8?B?Rmtpemx3bDBIMzFtaDRHT0R1blNsdy9aTXhPcWxtdHdUaDM0MDQ4ZENWUjZj?=
 =?utf-8?B?Vlo4QzRIVTJCVWUwR29hUDd1YkRSNk1JTkJFZUhCd0ZLQ2x1SEpCM2xPN29H?=
 =?utf-8?B?WlJMajg0SnpiRUhhcDVzMmlLUFZFektORUM3bmRveitsSU9ma0VRdTJmWnMr?=
 =?utf-8?B?Y2Q5VGUyUUN2V1FjYXFpRU1XNWNZMGU0R2ZKb2FZa3UvZDZuMmhuOEVrM2JK?=
 =?utf-8?B?eFYvdVdzVzJnSmE1MHU3NThteUxBdVRDZTlGb1B3bHJJZjJuMmhWcEdkRU9a?=
 =?utf-8?Q?PF6RaE+OWhqxPXhcp7nh9Zz0DbrWlcKZouxnGF+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEkxbkdRd1YvRi9tZXFUa0QwUGdlaFdVY2pVR2ZGc0NqdkxoRVM3MFFhQ21E?=
 =?utf-8?B?YjdBakVCdlRVSlFDZ2ZLTXoyYmFmdDdnOEJ2N2JEZzB0QVhXK1lRWHRmZmVP?=
 =?utf-8?B?K1JPaGlnRVc0ZzlseDc4T3RsNFJKaHZiZmhTRWQxbVFEOWxVTHJqQUxCdFRR?=
 =?utf-8?B?aHdOQ1pXSkdpbVdLeVU5YjlCMlBWc2VIL0NzdU5aVFJGT1ZkMXpkazY4YTlp?=
 =?utf-8?B?STBnMEkxcGRwZWZEVkxEanRkeC9YT0Y5Lys3RFNJLzZrYzlDaXZjT2F4aVdj?=
 =?utf-8?B?amdhWHI5YW9lVFE1QWZ6cGF1RXdOZExmWDlxQ1liWmJzWGMvMUZENVlnT2sr?=
 =?utf-8?B?a1p0MnNQUHB2ekV6eUZkalNOdVk5MUM2RDhJZFRDQkFrem11cWNGVC9CUUhY?=
 =?utf-8?B?bnlDVmtONnpUZkdFbld2eU9lcGY0N1pOUFMrSlNxQUdHcVVLdnFYUnVPQ2Qz?=
 =?utf-8?B?dG8xZFk5eHU1Q0gwL1plTEVkSnpaT2pid1luTTVlOTJ1bVdYdzFUWFVuc2xt?=
 =?utf-8?B?T3JEMWJqclJHRGkrRnlrT0t2aEtIQXRhV2xUNHdtb0JYcmNNbEFmbkw4blE1?=
 =?utf-8?B?ZFpmTUp1WXBaOENFbmxobHhRMVpMNjkxU2syRmpud25yVENqdFNhQ25EdTNw?=
 =?utf-8?B?NmxEWXJoc1JaVEtwYmh6c25oVm9KSXU0azUxOUJJQ1Q1YjB2QThmRFRkSGRw?=
 =?utf-8?B?MjNjNHVVSTFxalpoaFJJb2ZWdmpJaVVXWTZlVHlPejBwUDN1ak9rR0Z2YWlr?=
 =?utf-8?B?K2FwaFR5aWY0OG9EVG13UDhFQ0N1cmtRRiswZVVleVRZbWRwSEhobW0xVlda?=
 =?utf-8?B?NkdnQ1VBbXBZZjlKUmJ4ZEh0Z3E2MnN1THZoRTNrNDZ6MUtRa1c0WlMwWWxw?=
 =?utf-8?B?TFlPaTB3VGVwellEMzZkdm9OUWgvUDRrQlNiN3grNzJhdHBvanFDVFpWUFBa?=
 =?utf-8?B?OUx2OUY1K2VlWWtSRnBPREd6MllwVWhWUHN2UDcxTXJ0bnk3RmFvcHpaKytH?=
 =?utf-8?B?ZllpRXJaZEN3RWtFTjVWZHlZTHNMcFFEZEczd0lzQmtRZTc5RHFIc3l5aDcy?=
 =?utf-8?B?eXdUSEFqV0xpYjZQeVQrN3RDUHN2K0NRbFBrMzNjMGVQcXlBajFuNEI0QkR5?=
 =?utf-8?B?ZktxUUhqKzBJVzRMZDhrM0NHTXdYZVdHSHRDZ1BqczBhdVFPTm4xTXlub0ly?=
 =?utf-8?B?MmxEdGtwUGxzL0lEeThDRU93SHlqbjQwbmVKN0ZyRVJKQnBJQmVqdGEzQWJF?=
 =?utf-8?B?VnBPSTNTU25odDFxOFBJM0VSSnVKb2tETHBVRGMreVpPRHA1YmZKSEJtNXQ1?=
 =?utf-8?B?bUlMeGJZalZWUy9wVDBPWkJMNHpYWDZXMS9pWUNGSXFlSDNTN0E2ZTJ4TTBU?=
 =?utf-8?B?VURzc0tCNGF0VTdZN1o3a2hmY0hhZVc1S0R2Z09HYU53RCtPK0dST0RDV28x?=
 =?utf-8?B?cEU5ems4dzZ6cFg5QWY1cnVaK2drdklvenZqOEtPZDR0V1A4Q2dqMXUvaUNo?=
 =?utf-8?B?N3FoYVlCb0lrSDVSbjVML2hqMExna25FWmdNQzJ2VmpKOXVkRG43dUhwZWNZ?=
 =?utf-8?B?R1V2d1ZrM2lyZFpxeG1rL1FtRDNsbVNqeGVOV0JWVXBGUm5nREo2VXJhUXV5?=
 =?utf-8?B?ZUlVeVFKSmJMeXZKb1N1dlFUa3VIeDVNYzRRaGJlOWpzOVlzYkh4Wk5hc0pW?=
 =?utf-8?B?a1k3QmVUMWZZN3lOM3RFaGdrR3FDUTVPNC92U1IyMVZrNGZTeDdURWk0cTZn?=
 =?utf-8?B?djY4OWY1ckRUR3c1Y3FDV29jRHRMSmprTnRtUnkvM2xhMS9qaCtqekNHeXQv?=
 =?utf-8?B?MndmNDk2MFVycEsvcDBRMFI4VWlCcUFabHJ5UzhjY1dhUmpEV2JmK1BYa01z?=
 =?utf-8?B?STl6WXlIS09MT1B5bTB6SVJDMkx2ems4M3l2U2FnZXIydksvU201ZVFWZEVh?=
 =?utf-8?B?VTBraU1QTk9zZDgrVThaMmFCdlVTQXRmZUlFNGNRTk5xc0xnVFBMdVlzczdq?=
 =?utf-8?B?L2N5SjZwbzF0VUJNZHEzUHV5YjZhWGwvMEtIU1F3OGZIV2lvWDdEUldvak1n?=
 =?utf-8?B?ckIzYk5DK29DZ1U4dTd1MEYvbGZpRGdVZ0lsNFhpQVR5NGZCNHZ0OHhNcjdo?=
 =?utf-8?B?YmduTldHK0daT2FpS1d3SGJIcVA4TG8rWURXWHFva2R2d21GS3dZcjI3N1ZM?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ovVhAoTKeidCQVH6ulowHh2JZH/YZhRH0a4DdOYMTTu6ijqt6HGu+3IVWdryoty9XEoAzlv1fopnaDXr14afZkvpEo34q4yTY6KY5QlQuJAL6Zevopbjub9RuahHzQ/ptnCw6QBcBOWwzZ9A4t0TgTtkxznEUWgH5XJ8xcGJH9/RsbwfMyNz5khnfIk7cWB0G4fYGW5E9aeVMcR9NA2KVrLshDXH+8pJGZM9c6Oky3iYocImFpNcexXmoNhWu+bapRVq90DBNDC9gh3m3al2uMjexDvRvO5VCemFV8yn9qaO4pf2a/xRWaIjwnIxhAwQx2JKoRYA34E2YkEDelaPeHi0h5h1MVcVNxpkNojxJJDDdNlFIHxM96fJpy3KmVFTugyaknN2nF6tY8lEe3++9nBRzB6CT7DjO/w5KTXoWuPnL4FT+c3zT/lMR1h4mngvmQQ1Ycoh7Ao2UONBOAZXVRzQEAPi/6eEMYtJO4t0JGb6Lxn86yOaTJRWCDYGyw6wdfxLpz9R/3RIgu/nJXIc2LSi+vAojnYKaC7MSmGsV3F4SXpCmpUBigdrE4rV5/U2AZRsojBerS4IJNos/UBcX5NyaBU/OT6OvRtFOa4pH8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b06a411-80a0-48e6-c824-08dd03ed38e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:12:35.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SGZHUUd53hizTOCPnFL1t4zYu8fbSjstSnHwUI3ZWl5P9qdRdBw3ZabvJk+TitMOiyjyfdxjFZznn6BaODNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130120
X-Proofpoint-ORIG-GUID: gV1jTjRLjFJfJ5SCMBR5nscEOonBBu3v
X-Proofpoint-GUID: gV1jTjRLjFJfJ5SCMBR5nscEOonBBu3v

On 13/11/2024 13:54, Greg Kroah-Hartman wrote:
>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>> b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>> index 342d75f12051..5172af77a3f0 100644
>> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
>> @@ -3636,6 +3636,7 @@ static struct platform_driver hisi_sas_v2_driver = {
>>                 .name = DRV_NAME,
>>                 .of_match_table = sas_v2_of_match,
>>                 .acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
>> +               .irq_get_affinity_mask = hisi_sas_v2_get_affinity_mask,
>>         },
>> };
>>
>>
>>> If no one objects, I go ahead and add the callback to struct
>>> device_driver.
>> I'd wait for Christoph and Greg to both agree. I was just wondering why we
>> use bus_type.
> bus types are good to set it at a bus level so you don't have to
> explicitly set it at each-and-every-driver.  Depends on what you want
> this to be, if it is a "all drivers of this bus type will have the same
> callback" then put it on the bus.  otherwise if you are going to
> mix/match on a same bus, then put it in the driver structure.

Understood, I think all drivers on same bus will use the same callback.

FWIW, most drivers of interest are pci drivers, so I thought that it 
would simply be a change like this (for those drivers if we use struct 
device_driver):

@@ -1442,6 +1455,7 @@ int __pci_register_driver(struct pci_driver
*drv, struct module *owner,
        drv->driver.mod_name = mod_name;
        drv->driver.groups = drv->groups;
        drv->driver.dev_groups = drv->dev_groups;
+       drv->driver.irq_get_affinity = pci_device_irq_get_affinity;

Thanks,
John

