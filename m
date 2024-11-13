Return-Path: <linux-pci+bounces-16635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B99C6CA1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D4E289B26
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F71F80C2;
	Wed, 13 Nov 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJJDA2ie";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ptHwMLvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF333086;
	Wed, 13 Nov 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493030; cv=fail; b=EVIGEPyYJUMuEnBXt8BvB1tudlyRIqXTPo8QoXoSriVTFmmfygFnPtCGfiKMNzh7P7BcKshHNY5zHhbxGhJP0RSkEft4N3NmR9q6iJyWNlHAv4fSPTydfxc9ofMacqKajL0jTX+E9YPglLDFqGXeXL0kIYQ+V69EBwNFgFZKk34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493030; c=relaxed/simple;
	bh=uWtNWP41ZaTAdY5OYW/0D5LHWaypb/NtrtASlWULqnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HVtRhNHGilW5E63YSNdRGbKi2xiKoD66p79bJkmdHShVNAmF/2W7o0cBmt6LQY6wCL1kuw2DFHkWdat/bVs+xIJql+qYJ3fumw0sw57kt/ZjWhQGHrhhwA3Q8HnNuiU+x1sXEC6LjNQTi39pPzizdJhJ5QVy2QUNCuG6hCF5PfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJJDA2ie; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ptHwMLvh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD8c35S028171;
	Wed, 13 Nov 2024 10:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y2o9PuN1rKDHeWjxhGBSKB09Dnd+8SGIwUmBdukdF/I=; b=
	DJJDA2ieNmQwN579au5v3T7ivTuX2mxEyGqMOqIiE4oYFpGIKb+Y8OZe91V0759g
	xtVveLfb0uat08RKs/ehISuo/glWmBH4mQi6GO0F3qFRtgfX1Gdk5K9kffejltPH
	kbDuxYnGxdzfsUjsknyUZEwfUmLAFZs1XV2GJwt1TWqBYAVHxZ44E/DGezf8/kM2
	vK1Ix6mqmdgb80PU30J5/l4jX+10JxcpBru2dSKSg60ZdbtEapNib/f0Pzweoqs7
	vADH56QkPxUZl0NhFR5RG30wvKGkY4rtVRkLUsDw3S3tLGsAiU3njMgVWn063VpW
	2mWidYtxtGxv5oCWYpopSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hepces-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 10:16:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9sKXx035985;
	Wed, 13 Nov 2024 10:16:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx694nfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 10:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV0l5hAyvlGbmw35OLR5Fyuk0t1MdAuD+3fwZo0ZyFIdayHifM3pLxEiL39LEvEYOthWJXUnf/ROH582VOzGOawMC+BG4tJ/FKzurAJYJhUCS+AepM+bTfywuieMtBMK9gH3tkJqHtuSYycre/t2CmmTH32nIKMcPW971m9CdxBs6SLkx8CSxpCeV/DkPAuYa9GW7BzlSc05MtqngPusNwpOXbiHZ2qlpRb9INCB+EBXn7hSYepmQ9pEH+cDrbDQ3XGQ30BIIktnmC1PoDbSf/JVAR8sriqI0h3Se+Ln/npXy/E3D27EVml+KG5O3sT+AvgOzCpykB5dWQOcWV5+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2o9PuN1rKDHeWjxhGBSKB09Dnd+8SGIwUmBdukdF/I=;
 b=rG8ByZhRkhrqa9KiKHD3L4HxQgfm70cvXSlZppNGYcnokBEuR4J9iUr1iuS6sfAZaD49kZgPLLhJZ/FPwwUnU0EX8i2MoXas+ZVloda3hHh916X23kndALWvAIHGgcUtUSMwMJjsZNSZeeDpDOiOX1CD5rrw9EV4Ht0kMJmEqnHET0x6+P8+SBSZTV5OymuHI1tKps6mrQPoTXAvBph4LQwDNeU5Stc3b7LpS7HY2F81a5ar5XfHVwAMpu0cPr5bjK1V29eeDGNVRvqjjU/Sh/eGHI063JpmaYAAPWjcYf/UP+0Al3v5IBUY/e9oMZiJJJDXMbJKqVq+LknQdagnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2o9PuN1rKDHeWjxhGBSKB09Dnd+8SGIwUmBdukdF/I=;
 b=ptHwMLvhu5P7VqaRvRzdlmTVBFs+z/sQuX/v4jlj6oatnrEmAB5AMADvx7opXEvQQK/An5Wzdq6TF/kptsp9NYjMm8Y2qFFr7f63kbGGqtNs2gdWcqrTRcmLqtP8Ul52vSm4TBPNRGPwGOSc2yruwtUnpCK1Ck0ldJ/oOSpV2Zg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 10:16:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 10:16:37 +0000
Message-ID: <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
Date: Wed, 13 Nov 2024 10:16:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback to
 bus_type
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
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c0f178-cc8f-4c2b-f1a0-08dd03cc41b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm4wWVdleWIweHV5ZWIxcGpISVc2VnNWL0JuZUhMQ0hPRGJCM3lPV2VkSDYr?=
 =?utf-8?B?alp3Q01XNzY1UkhCaCswK2UvVTBGRnpLcStJQk8rRHJTa3hrZDZlZXVJSGNJ?=
 =?utf-8?B?K3JJaCs2YzAwZDVxVUwvcHVsQzFCUml4QndDNXRKVGZyRWZ3a1dNSXkvYkVa?=
 =?utf-8?B?VWtHV1JDK0pHUDlPN2l6MTQ4akZ6UEVtUjJ4VXkwelhpb0E0anFvMVlpNlRM?=
 =?utf-8?B?RTNsZlpKbUNiRGN4QURkQnduRVR4cEh1NDBXWTRxTXhQaFYwc0FNMkxQZUda?=
 =?utf-8?B?Vm01djl6V2JOVml0WU1wRUF2WXBUSkdTWTkwdnZ1NnV0cklSL0xvL3ZVVFJG?=
 =?utf-8?B?ZkJHMFJyNkhqaTFITTlIYmhNb1U4bU94bmVlMzk2WnlXYVBXS1Y1U2pSY3Z3?=
 =?utf-8?B?WE9xaFh1OW12NWh5aTJvL0Fjd251bjVvc0NNUi8xb1hycEV4bFd1OUlxd1ZZ?=
 =?utf-8?B?MVBJSVQzY2djUXpyVW0vdnhpYUpUQnFsL1NaanFXQ1lCR3g1ejd2bmRlVHBS?=
 =?utf-8?B?ZEJYSGl4U2dPb3E5U3Fib3hqY2pqSy9NQWlDSHNROTBEV2IvN2txOHRWRGcv?=
 =?utf-8?B?LytXZFoyZWV4VU1YVlJYZ0ZoS1lTc3VsUmY5Q1FQNGFCTFdjTW5BRmJBNU9M?=
 =?utf-8?B?NWZKaDRpbnJvcEc1VU1vWjZjdXJJd1pnOVVXMkRWNTFoR1ZhZzU4bUdGNFJJ?=
 =?utf-8?B?RGF4MkpmSEVOb205eFhzcHJjS0VCUEw1RkFjNEhHUDM4dHY5OGszd2xJd2NG?=
 =?utf-8?B?MkVJSnJPd0pKOStrRUtXdVRldG1UWjkvYmorU0VwMytpZGk3MEhUYzcrVDQ2?=
 =?utf-8?B?cVlkbnRwL2xjeWRrU0NlS2N2bU52Tlh0Z0RhL0JxQW1zNnRmcm45TCt2WkVH?=
 =?utf-8?B?QjFtRUxOYVptemJNenYwZTdGKzRyUVhQa1V6bFY4STVsNHBSeDluQkQ0dkQ2?=
 =?utf-8?B?RGhvZkE4R3hXR0hkSDlNS1ExV1ZTeWJyUmNKRU1yOU9QMGZyM1FmdXVpb3JW?=
 =?utf-8?B?OWEzbVhlelIwRXhqNUpkclFiZG5FYUswN0VESk0rR2JPQ095bVYyMGhwQ0Nw?=
 =?utf-8?B?WFQrbFh6eWR1Yy8rL0xnUnNCWEthNzNWUHh2dFpNeU5jcG50YUIwWjVtSEQx?=
 =?utf-8?B?eVRZQ1BZanlKWmpMM0NiWUNLYUplZ1VjR29idWVONlcyOE9BV3o3UlU2SG9G?=
 =?utf-8?B?cFB1aUxDaElOOUIwU0VsUlVOZ2VvUFk1WVBOM1lKN2ZkZDdrS040MmlUMG5q?=
 =?utf-8?B?NnE4OXJ2QjFxT3Mxc2pqZ0k1R2lkeFhlK0poTUFGam1McVVvTHpobVdnd1RV?=
 =?utf-8?B?QmMyMVpLaXJLV0RVaGIyL2JMdnJ4bFdnUVdBcHJzSmZ3NFlYTlB2KzdMTDNJ?=
 =?utf-8?B?ZWNyVjBXTDQ5cHFVRTkxM2dkcFJkd1M5YWxaMFIyUi9sdnlLS1RYODNqRE83?=
 =?utf-8?B?NCtPeHJ3MFZUeEEzdG9TTGlDU0p0Rm9telErN0c4aXJjYUFmZzZLUUtKVWJX?=
 =?utf-8?B?cGUwUzIyNDdTaW5pSU5Wdzh6clZxRWNYMlQzMGhocEoyV0EydjU5RXd4QXE1?=
 =?utf-8?B?aExwWEQvbmZCa3pTSjFkUzRQYkVsdm1qQUJVUC9mb1QwL01sSVpJS2wveUJy?=
 =?utf-8?B?YkM4SGRLSEJUMjZvZ1lHVzdBWTVwckpUajRHRGJub0NiQWF2YlFHVVVWRlhD?=
 =?utf-8?B?c0VoaHhsdUc0UFdGT29FZm5WZi93Y0x6RDFaVVQrQ05LNmtHODU3V1lNUjVV?=
 =?utf-8?B?Y1p3bWVmZzdFeEVnQ0pydURJSTdoNmlUcXRCZUxjY0V0UFZSY2hNK2tLYlF6?=
 =?utf-8?Q?yEmcHUzfhi6yb5D/j1fqeZeSSijAep9UAP9A0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm93OFZFbTJTQlErdDF2ZmkyOFEyZWtSLzFuVUFoUk8vWlFrQTBaRk1xQ1F6?=
 =?utf-8?B?Y0JXcmV5TFZLakI1bTlyd0J4dk1rYnl1TDhxVEQ4K3FhTnZlc0dSa2ZuOHlU?=
 =?utf-8?B?V2c0ZGk4eVNKVXF6ekpHMDZHWXIwNmN1MG9ISStFOW9GT3dSRXRib1FiTnZ1?=
 =?utf-8?B?ZFNibGRkS21CQmF2ZnI5QmJsZUtPZDg3QU1QVFVybmdzZ1FVaWVkcEhRQlpi?=
 =?utf-8?B?NGNJZ29VbXdKdkVoMGFGVm9Ka1FDam5IbnZTa2tIMTZsZ0Q1VVhvZy8zRERL?=
 =?utf-8?B?bUxVR3Z4cnovOWxGY1JDazVlTlh6dlBqTDB6VXY5cDFkVkpWak1BTkNSUitX?=
 =?utf-8?B?SzlCMXZRN0pTeDNLamNvamc0TWgyNnFKMHV3Q1h3WG1mUGVIOEx6OW5jS29Q?=
 =?utf-8?B?bW14VFBrUFJjOWRWRDhqcE5tem9OazgrV3BscXRlRUp6dGpSN3pRbVVFR2Zy?=
 =?utf-8?B?UTdvTkl0d0NHcXY2RzNxd25TU3YyYlBsc2Eya3RXSUxpNGxoT2JjOWFvaWZV?=
 =?utf-8?B?MVFZRXcvSnFyR09FN3dvSFUyZU5xUHlFZmpYT1pBZEtWbUdNbkxnNllmNG02?=
 =?utf-8?B?dXFoZjBxWnppYXltcHJFYmpLYm5VWFVxV0FKVnhpRGxZRVFHY1duRis0Yiti?=
 =?utf-8?B?VHZKVmFBZkYxa0lVR0E4RlBSL3BkaWgyVGxTYVZaQ1QzTDNaMk83YW9QRHZW?=
 =?utf-8?B?SjFEK0N6TWwrV0dZSUZjd1FRRHhuRW9RNnJsVWwwcjJ2M2pMVE4yKzhReWlz?=
 =?utf-8?B?eHFYTkIzR3dZL29JTTF0YzNUbS94WXRKa1NBb1VTaWFtZ1N3OUtGQ3krdCt0?=
 =?utf-8?B?NXh6VkkrTDBPajVuOXdDdmZyRE4zaFVxdnlxVy9SQ3FYc1BkR3Ura053Wm84?=
 =?utf-8?B?WXJ4RDVUT3JYam5kNmhxNXQwUFlDeXBnVkVxeWFhTnU5TWp1VU9vMEEwbXh1?=
 =?utf-8?B?SW9NREFsRlc3MjFUdURNa3pzSW13Qks3MERURkpOSy91eUQvalFET3RLZXA0?=
 =?utf-8?B?VUdXb1hYZytWZVZ1YXZ6K3NjWW1Da1RWMlkrZkRpNUk1Z1dIaCtSQzlzc3Ar?=
 =?utf-8?B?elNlNDBONjBhbkdlY3NyM1k1VkJzVHc1cGExa1VZNzVXMU45WldaYStsdGN3?=
 =?utf-8?B?N2hzajhKQXlRU2FBU1FzYzloT0RQK01nSlU4VkRJMTNvQU1yWmtwa3dlNysz?=
 =?utf-8?B?MHZOcllva2hwREJiRjdzMG02VWZQWW1pTFlTSTV1ME9sK3hBcndoQUMzSFlY?=
 =?utf-8?B?NVJ5SVMyTmFXeUZoNHFvcklqQ05ueVNWTThOeS9YcDN6N284ckhYRW1OcXZL?=
 =?utf-8?B?dmN1U2JLVmRGZDhtZC8rK1pCY0ZOUGFwVVlHM3Zob21RZEJWY1VVbDc2VXpP?=
 =?utf-8?B?bGlJRG54Z1VWMzNrN28xamgrODg4QVdaSUR6WkZNUStIM29tUnNienFiTSs3?=
 =?utf-8?B?MXdKdXlzME1oN09kaEdpUEJrUit5Um5JK09LM0QzK1diOEQ4TUtaRzljS1NB?=
 =?utf-8?B?SW1JaWZlQjhZLzNRS0FFSm9pbVBjNlowa3RPRW55RFdFbEY3MDI4M3phaEJI?=
 =?utf-8?B?bG9DdGZiZllJVXVyUjRSTEsrc0ZjWWFFNDFPay9nd2tuNnYrck5DL0x2VGM2?=
 =?utf-8?B?WHYraU1JcGQ5STVNQ0h4TnJYOGVDcG4wSW4zRGhocHFwcFhWL3VRN3FzVzNn?=
 =?utf-8?B?ZkpIWXlkV0hoam5YMkFxRUl1QjZ5aGFFb29aN0o2VG1aMnBuSVNIRUJMUXlS?=
 =?utf-8?B?cGhKK0p5VjVmdE44VGtNeFlIQjA1Rlp0bWM4Y3BvcVZYTXhXWlZaN2l6UDBa?=
 =?utf-8?B?bnBLK1NSeUwva2hPb3JYU2t1a0YyQ1R2U3dpcGxYS1JrNlcxV3E4V2xTK3ls?=
 =?utf-8?B?MFE4Q0lZOU5CVldtWUxTWEZDeFpvL05QUnZsWXd3c1U3RXRXbEE3eDlOYU9Y?=
 =?utf-8?B?aXVUZ1dkTy9rcjB6TGlHOExMUkZJR0djQkRZUHZ3WUNhM2w2clJYRWtFeCth?=
 =?utf-8?B?ZlhtSzBhZ0NNVkJCeHl2dnljT0Z4SmEvczAzbkowalE4aUdSSG9mUERtM1Z5?=
 =?utf-8?B?TnJ5bEtYSjBOVTdKUm01bVBONm1Ob1J2SkxjZzJNVzRUNjhtSVFKQ1hYNkIy?=
 =?utf-8?B?WWQwZFREVVVuNlJ1VjdXUHZwOEp0QU1QNjFDRUwzM1hzb3ZrUVVHbE5DUDQy?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8jjbjLf1lfdE1WpCzjCw+6zlrjvf88vcMKEkPpIAe0ZYBglSJZF9PDkLK+Y+DaGhEUCP1m6bES9CxihsF/4KRifDiF97DixJlBmd/BdwhFm6nlmmi8sB1+S9mNRB+Jd4xk+z3DZ1i+0BZ4W/rsyGGKHBK174+fEA7/8rXNar9ApzkZfvBo97iP1b4Wd+PxwygoDZRnMyizYRuVy/3E/rQdwXY2ggRbx5Qwtf8r6cjgjDvYN/crr+ea25IX/ELLUerYNMufhdhcGjSU9N7Nc7cPwPlS1j2QVrLMJPUZGAneqR9rk1N9bV6gWWbIh2NrU71rk44+v6fGoLrkzFGljhbxnaa1418ienlUe0+QWrbFRPHIiF+sUveN7OPrjVE+Pv+nHIdO2XOSJFTD5V7betY3V7oXlMyXSUgyTxInaGlJA3t++yQHmaFuz6Ft302uvFOWNThwuPBR9GFcyxxl7nli94nhB5bGc0/jPlIdkbrySt3NDV7dYWMFQhasMSsBEZhoGMnZJalJYOM+ynF1xvS9zvf5ZotVvL9H24z+jGXgkElQE+0oEwB3P6CiHMP94TPpiSsiYx2iXfnmhAdPXPQpf+p0014HisDg8lUQkOxR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c0f178-cc8f-4c2b-f1a0-08dd03cc41b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 10:16:36.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLtsL3io1O0pluau8tHRcc0YQaijG7SNhIR4xXZ5hgAgitcnq1zjaHa9lkuVxzVSTmWRBVchuLX7+JPIkuiZvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130090
X-Proofpoint-ORIG-GUID: D-D6rlPIvQ6lGzzHWyO8h7BmwRLnUvbC
X-Proofpoint-GUID: D-D6rlPIvQ6lGzzHWyO8h7BmwRLnUvbC

On 12/11/2024 13:26, Daniel Wagner wrote:
> Introducing a callback in struct bus_type so that a subsystem
> can hook up the getters directly. This approach avoids exposing
> random getters in any subsystems APIs.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   include/linux/device/bus.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -48,6 +48,7 @@ struct fwnode_handle;
>    *		will never get called until they do.
>    * @remove:	Called when a device removed from this bus.

My impression is that this would be better suited to "struct 
device_driver", but I assume that there is a good reason to add to 
"struct bus_type".


