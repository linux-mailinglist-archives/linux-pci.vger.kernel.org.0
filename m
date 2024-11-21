Return-Path: <linux-pci+bounces-17129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52559D45C7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376601F2243D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 02:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D612FB1B;
	Thu, 21 Nov 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NmRX2iaQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FtWBDTtd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDE7080A;
	Thu, 21 Nov 2024 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156668; cv=fail; b=roBobpiaFkZTfRy6bO9wuopMjKMaq/Qo2+qwU4mcjxLxtqwAVbC3sqZyPyhnk1OSfViJp/qFYy6SfYwbYZhaOpsQOGryfRhn5JmOeyc2qgWdyDHzXko+hmj0fs6Qz1GxR9vmHPvVtPx8LdyVBKxDiOoXZv7WyLcjaymHsNFCGc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156668; c=relaxed/simple;
	bh=cscdQtJA5Ovp9PhjqgSnJfpXtYKamHG9Q4SkrjYNW18=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Q9p0uTh0kgR+fQxgaO5EQrSyYUjp4xYGgXjwNFBckLF9rkKne7Hqts0QznbaGF0hx8dPnLzGmaErVX+p5ygiFe+jzVuTDZNgkSvZgwEHuAW2whCn8XnrDCC/EK3u4sZAdgmSUeOCDp9Sn01n0YkiC1etkco20xjpV/2QSw4rFsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NmRX2iaQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FtWBDTtd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL1gccM010291;
	Thu, 21 Nov 2024 02:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TOH7UqwYnf/1P2VtEE
	APzilRa95gfwbaW6NyHszWra0=; b=NmRX2iaQFmGgFWKUgTGpXEFGBz9hVbpi5K
	IFXFTmcvhWYx1LlnFSbca3+U77qunUSVc8v2M+wrxGWqUtHDNYQH5H13PayiQoxN
	aWay0ybafw3HIaZO16dGu44udqZh9vrlj9lLBJShWV/OzxxXHoYcm+S+sRlqxOd2
	MC/5PnUm6kt6fV1+Z1vsB26ZUalWZGBI4xPv30BlTHj+ZdjBzQ7GOPATvDag39VL
	q1uKDMJDvJNZQe16Z8iT1andCeSl81QwfkSX7zy6/SabqbS8gAG9p2ekWFaZ1jYy
	WNaavn43cyqL2bfGKvSIPaArFaMG0XOlC3NaoqX+MuMBbq9YglLg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0srrek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 02:37:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL1b0gr037121;
	Thu, 21 Nov 2024 02:37:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhub1wkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 02:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEvitaBDcJLomx5j9itsJS+Pa71i4DM7qBXdkYKOtBn5Q19GIMAH4OQEQfh7MocSVPDAH4xuHd8qrPIQOp10nlHouk8vhqkod32NAUFZyl18EkiDoa45xY9nTg+EdXspiSqs7iM8jOA2QEqMIlYkWO1ztsmYcw+REaLooRAB+vUsIUmEr6FMJZyneariULGpqE/zgalZePKcu1R4gXLiKIP59G58WAWVErF8CIbwASwpzqW6v6IenJP/Kc9XAYy+cJsWzf9gRJtlhU9Ogaa1T6tVLHYqDEfBupkOB6KqosxbEH9S4TOI+xE9ZOJ+24U0dcZackvhbbp/sf8z/hcnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOH7UqwYnf/1P2VtEEAPzilRa95gfwbaW6NyHszWra0=;
 b=WVhKeTSr7brZQnJaHdRm+wMWr8HtUMuKlzFx4nZoB49GYB3VjXPbnuyDzJVEgbApuAkNUMmUZslT4OCHhZ8MbEg2HO8BOScVxfkJhILBN0wt8qWObIzGY2oVnnL4I7HDi+R/WoKRvUSvEKAgWciLP5GcIKIeIsBX1F77gYHyQWzrzJuJUn0MMHvC4YV796bAGOEebj68X51DqP3H67UcIO07isLR1raMncdafdrhVONi7FQEjuMeip53DioXkqKMG4Upa5AkPpZO7DqMgKqq1CW0GvrqlzZ4ycNT6PRwb3yIbAC/FB28VvTI/R3uKRDJqE6aOfhmzf4ZFCb6akVrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOH7UqwYnf/1P2VtEEAPzilRa95gfwbaW6NyHszWra0=;
 b=FtWBDTtd+VS0SybCDzfQb05QaiTo6lNhq/J/tBwrmNNpWg5YvUsZQGm8RXRiFSdQALJYXkh33FVfChy6uRJ0RkUtFgvCiKCPl4ndCOG6+bqx0Ah7IxFG/Vg2Le1wE51IVcVJ1Gtf9rsFuo6cGJF1HWIb2NL4DVaGtOCctccvNyE=
Received: from SN6PR10MB2957.namprd10.prod.outlook.com (2603:10b6:805:cb::19)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 02:37:07 +0000
Received: from SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c]) by SN6PR10MB2957.namprd10.prod.outlook.com
 ([fe80::72ff:b8f4:e34b:18c%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 02:37:07 +0000
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>,
        John Garry <john.g.garry@oracle.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke
 <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
        linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 5/8] scsi: replace blk_mq_pci_map_queues with
 blk_mq_map_hw_queues
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
	(Daniel Wagner's message of "Fri, 15 Nov 2024 17:37:49 +0100")
Organization: Oracle Corporation
Message-ID: <yq1frnlqpn8.fsf@ca-mkp.ca.oracle.com>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
	<20241115-refactor-blk-affinity-helpers-v5-5-c472afd84d9f@kernel.org>
Date: Wed, 20 Nov 2024 21:37:05 -0500
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::16) To SN6PR10MB2957.namprd10.prod.outlook.com
 (2603:10b6:805:cb::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2957:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c8af01-b096-430f-328f-08dd09d56437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K80QMJbLYi/gIAwJDdvV2NA+C7wVvzaoNv5IcE9MAiIKB2+zhy1rlh+caOzF?=
 =?us-ascii?Q?LSV8X3EA+8gxEXupWDmIlcOQusgVYxCwaM03KR/2En4ahWPUBWDUrGWzDVUV?=
 =?us-ascii?Q?TcVidvMN0atfW/DU/D7b0Nt8t28aWvb/xWAhUp/c+so3AD4yQhwDmY++HnyN?=
 =?us-ascii?Q?oQyZ0QIE1dx0PzKk67OGMy+Yrf78cBzt6DudeXJFHtT/6GB5KgcnQTqHyN22?=
 =?us-ascii?Q?mW/iKkqpfeTi5kKzn1ZtRJUc9i9ik894w6jbgdWvSpC37bWjDzYdaCTieox4?=
 =?us-ascii?Q?GLy7x/RBFVzbhbOnNNAjaOXA5W8B5V/aALLQrz7gOPwExK54Ohd1HzjSHZNz?=
 =?us-ascii?Q?k+Sa1oURYsHzUV2aF9eifsmZja0SHZDeonU3HRezLVQFj8icyOMVjXC3Ghib?=
 =?us-ascii?Q?T3mayVfQt/N0MKg673MoZt0jeoAGQfHIkBJPTdOg1FSsw4ydChQmgDyrl9+d?=
 =?us-ascii?Q?LbbrHQOPL33CgsVdj2Y4B3piR0ndlN7KQ8jid4j3/tV5QaabwtyU4yvOSHwk?=
 =?us-ascii?Q?HT1UZgzu3wSD6p+vEkTK7PL4e4swjtU6dfEIpHPetKSAaoHTqLX3Y1cYD1jD?=
 =?us-ascii?Q?zuqebmI91LCiToPxfnIkZdCUhmVlSTDsDb3zfWDRfYonFulVj3sd+vKs+jpi?=
 =?us-ascii?Q?06TSP70AbnAPSl+lj4YRWIaifCgD/M2RZCB9uSvwoEqyjaejPBfxfUuvSW/i?=
 =?us-ascii?Q?I0JSUYdxiYrV0DRZUdnoNJ3tnU/btGWuWrPZ7EDJ7HNxbgfavmBuIjC+ok2z?=
 =?us-ascii?Q?zdLKZX314PLDlWBF/k33Lax7dlOfI9NMZwr5XDXArDLsN6+GaYIyxqyGrl5M?=
 =?us-ascii?Q?gVbGRsNz9mjnjYPHnL6xmh2sBvKrUc2w5qihaJOwEpxMha4aU2UNK1qWUgCQ?=
 =?us-ascii?Q?6IsQ0vdHsEoRzAghPoueXchSZGYYBrrVKE8Zn+Y0IBjTrHLX8o1T+FRjcpDt?=
 =?us-ascii?Q?5gRmNoskv0s0KrEOEzj87lbN9hBVfNgXFt1W3vt0fjZ9kYCKbUBvGMjH9L2N?=
 =?us-ascii?Q?+XVIamBWs/w7DAuXjsNu+Ew7GfygXsxT1ucjnX7sfCY3a8zXUN4Z/dLugpiI?=
 =?us-ascii?Q?eTkJkchj0LVkHT62JQE//ToK8NAHFRidoudjjRC/5XMUGl/DkmND43WMMSBF?=
 =?us-ascii?Q?VeVo+PnSNGdj4xREN2KIcEw7gv3ERG4s7dyLLcmzYglIGls9IMgKfmq72DJY?=
 =?us-ascii?Q?bXmsNMloBWss1xQ4QSlPlP8NSUVWkc6ot+AOkiOSp1zHnZuLnP8NuuOsTwPx?=
 =?us-ascii?Q?AyHdwaiaFsEzQzo0KR3jxiYTmnMwj+uyDObDFq/a4qm0yRBuAcSFV01CVQnb?=
 =?us-ascii?Q?Oqe3nhBvvtj/e966j970QBns?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2957.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZNldehEejLni92LQcaiECcWV4tFEShNMbVl1ffH62GKOvdP3bXJHNwWEQya?=
 =?us-ascii?Q?SH295WWmmFjyDNlti46VDs0Txuf5ikAzoS3b8zNOjEHWSB7uyqYcLDkYij1G?=
 =?us-ascii?Q?dbbjOUCQV25re1fhXSMsjI4XkwIrLVRvR1G06Vd8skTBQw6AD8yGsApyrpt7?=
 =?us-ascii?Q?Ahb2ZdUQcBPr2MgrxBnJbi9PK9q46sdViSCzs0XSEyaqmtREEJB5PzwyVQ9U?=
 =?us-ascii?Q?c4cQTBnF0gDBGXy2eYZn4/h0C/syNAZej6CG0mg3OLQ/RKUerkoSz/ApYaeu?=
 =?us-ascii?Q?Fu0aT0RVTyCEN0GDrxm23UT3GPinvYa2CGOiXbWdjgwWgI79NuEwXajSwiwi?=
 =?us-ascii?Q?cJ2G3YyV9R5YsY4ouscnJ9MJj1rolSgoAitsHbQGL9O5jgmPewfaCLuADTgp?=
 =?us-ascii?Q?NLza4v++uWf1miozD2stCxZxFbbwubXTDAAkqufKTw2VOa60+CVwZN5CBmLI?=
 =?us-ascii?Q?m3BU0Bi+rFDpi2zfsr9sVzFkQ1e8L37HUjLAh374m1mrqVZIXTFTV32Qo1XT?=
 =?us-ascii?Q?jcfSp2XQlM616YPf224S1rMwfZpvdJKEYJNHo/GQO4jcQxYjFL6ht8pAV0Ig?=
 =?us-ascii?Q?tbaYKqkXAtbwizbK+FvQEOimgINhLMncIgEHrHSlxzK8fi6zKpuzfmQ3SaDB?=
 =?us-ascii?Q?T4lODQOxDpESMEMMj1sQ8yIRrXzi2q6Z//zM+AbKekelGw3Zu6zTSU4DjwJc?=
 =?us-ascii?Q?gR1g6qRsUg4tuFcnmKbu3ElsHndRqjhgBToTCnNqRr5mDjL2XFU4TddJJQck?=
 =?us-ascii?Q?0+Zm6xCq6/L6UOmjJFqGguQtrSSHhtDy8E4JCwDxAxXDFNrZoHsazt2T2SB/?=
 =?us-ascii?Q?ZMnTZAKfoI0dxNj5xsrHYWHmOzRZ0cyINNgETcWohugq6lZSM+pakL4tRtzY?=
 =?us-ascii?Q?nXEb1pZ7devvcrR64ebW1KgOzrGTslpa37RBiloS13EQBEq3cG7u2IERVhJ/?=
 =?us-ascii?Q?D3W252afgc2LmyaQCLqe91w9CpO6+F9GSesyV4foywkfAiQ4jpXdEAdUU5Vx?=
 =?us-ascii?Q?8crI3aqmbTU5MGNqLydukbW3mi91JZuv2tpiOIvrTfGnxC0t+jfxIifj1iHV?=
 =?us-ascii?Q?Gi+SkJEPilRtWTxvcBQvZ9OZqFkAuZbR3l/c+8tGExgoqHyUF7AC1khkWiZa?=
 =?us-ascii?Q?Z9Iet7xWe1KPMUM3t493z55qD9bqypnfAY8RitxHYrTILyshoyI5YuP30+W8?=
 =?us-ascii?Q?45inZKViHLkGvtmfdMMHFE8PAJEB92z2IwkeXDwPGN/sg8lHfiiXaTkla46s?=
 =?us-ascii?Q?6PPnsP+1SVNPQasI/fCpUN+m5N2LkLOck73gyiCqiaWrkAmyooTOyeIxATw1?=
 =?us-ascii?Q?erKkCCk2jHyUPNLu8rNNvYS6tw4KzFOpkcu08qgLlvjR0rVeUb6MJBtHIFqG?=
 =?us-ascii?Q?iPNgdHw0O2sdk0Vk5QkCnC/M/3gHBFnzHpdMpqvo28F2TMkYfovfrZpcuxCc?=
 =?us-ascii?Q?hpE5NguBFgoYlf5iXUNG334e91jawb+YlUsTvxTtoj5PTZQ0JHiHkd5GLFVp?=
 =?us-ascii?Q?x8EjYd1xAvLlRXaPlYOZpj0xJxfYX7TNauPkMYY3X3LcV7piQVO6yw/zpH6M?=
 =?us-ascii?Q?axqPuhy7qPv/2evsqfNsuA5US9QQcS6PtBh/JFJiwYmNmNlOBYpOZhSnXfXn?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oCmVnxtBlGrYIll92bWCAPCQUxVQGRGF14Cf1vA3c4wmNOhfrOOU+rnwrYqbnT/XDEpOd4MU/yBmE2muLIh6udkfXQZsn0r6uQQ/7tOrefHoheyoDc6/7eO3940yblG9XV04xmYntRvrH6hBXgUBepxsKcAKMlyG+IGpPjwLZ/Dn2GuCThrBv/9fj1L3H6H42V2KJ4afkT4Dw0uF3NCrMtOmTXYsiIveDI8w6zKk2UdlezYxu7y/nYoVV1H1jvLORljSlgExw35EK7fxV1y+oVRrsC8ZXN6k81eBfGAk+WC8YdX8zT9ZFpWI6wjKWrgEO3kH9JZpmcmzGlHXEsqDiQ8drbu8Zbp7izKwyikP12KnO+x+FXPqh9jW2IBo5B+EvikHSVXXVokOV7d035Evj2+KZzprWb4dXHfMW7OFQBiqXkfkCABbFf/I2K9TLNbYmaT4h/1loNbqH3AvdNm9i5aKyNkKS1a/EAzvGsBsbJBx7cfDiH8RMVs7DinSR73XgMPTjIattAT8oAJmsr2209Q0kMYwuleL27BEmXAM+bjrSn/AM/4GAGUqdmbqciwFJO2+3D8OAIo5qXvxw1tyfV9r6omkaSE6SK/G+isjJQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c8af01-b096-430f-328f-08dd09d56437
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2957.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 02:37:07.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iXQUYtUTA9W678QAUkRoFdgYsmFMDVKtP4QaAHQ0IQBofOnQsBaEeHZu+FTEQhDWLd6EoxGwPCDC4ApYhs1hYbMRwYd4jEr4X7cEtqbnfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_01,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210020
X-Proofpoint-ORIG-GUID: UgJ3T-83Q1KSqrHHpqdtyRTLHIHhmjB2
X-Proofpoint-GUID: UgJ3T-83Q1KSqrHHpqdtyRTLHIHhmjB2


Daniel,

> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_map_hw_queues. This in preparation to retire
> blk_mq_pci_map_queues.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

