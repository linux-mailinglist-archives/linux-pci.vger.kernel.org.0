Return-Path: <linux-pci+bounces-17141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891DF9D495D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 09:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7311F218BB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD11C9DC9;
	Thu, 21 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l9SOPItX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C6Jltlxh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F82230983;
	Thu, 21 Nov 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179520; cv=fail; b=GJDhJaaU42vg5nfZ+r7EgtKY+9gl1/C8jRBhD2/L6c0fEAvSZPbh13IE2NA0lcwhJGvLRZjoI6/HoT6srjQtuF6QpCopegRRX5F0Z3NgtaYoW1XSLpobVT+wKl/d1Wra4vjBL7KcQfqCDJmUNPG3RHEvKe5RDl1czB7+j+0j37g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179520; c=relaxed/simple;
	bh=HAk3czkxOreWlVcLmMyZNbuWIcGf86nm4uXYw5QXnV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gTPGS5Q0QUAQkrcg2Fi7UCpb4ziMdOcJ02p4mdB4gpVpMf3tXKPwWrX4v+B1LMh56IK3KC7e1pnWa0eepj6xFV0ikjA8y7FomyYu/hHSVmvwALVoZ2EFLH+QqFI5JlNfSAFHzCCIXqSmI8Nw9/9NPQsBkrS0NkeptUt+JxhfHV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l9SOPItX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C6Jltlxh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7FgJh004292;
	Thu, 21 Nov 2024 08:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iwttz3qj/XNvONzVI1nm07/NIziMXjXm9cIhlYAEBqA=; b=
	l9SOPItXc/LRr/bz8uT2IqAMeWhePfX/guOooTt88DRDTep69bysiNuOqWzToPEk
	bIkFTQWhHqY4cvktl3UtPuf7G4XF8i3NcLGCi7+Gr+dTvDWJmIP7wCVETiwMYdVu
	V3zE7odD11lfk2Qx7itGXOJxBoCIX1CYOEzQRmrYnSrvBBfK8GCz+lSYau9FZDJm
	lnm2QwRA83iJPQMT6IVnftHAJosh9CpAaVSQRoaSJ3zW9Lj5cLcyH+dVql06Jmjl
	oVkJvkUk64+EhV/bwqNu5nlwigCjbfnj3OKeW8O+hpK790tvO4MvFvbTYRIUL9eg
	b756BrWvUi+BGMlIIQ4lnA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0ss5ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 08:58:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL7eN32039202;
	Thu, 21 Nov 2024 08:58:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhub836w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 08:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmIe9YaOg4F/drCFlAL5QlQeiWAbGU/1PFve8FA1p6mw3gSwwbLrfi1iEY6yB+nNMHOQrkojIdc+6quQvk+w7DItvQBi7pkW0MjP66bWWtsVMcZ3pvnwWzya0Zu5yECDg/gFKbAOl6DqHcMYtYQuNec2jl6GipJOTzP0t4GP2c65xgoMjzdbpUEetJkcMc/BgMaKS2pu+Xg11TlhHw1wjGrnhBph4NwnGwR6s2tlCqs5XuCfbbOp9oZOq3tOFhlh36Entc74ZCWa8f//Gil4VYfVffX2Fd0JwhjHM1KuR31jvanFBK25cb5rXz9EILI1L+Vk6DOwTODkRQ9LCgsC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwttz3qj/XNvONzVI1nm07/NIziMXjXm9cIhlYAEBqA=;
 b=JldqxSRi9Wjaabo3ERP8hd8bLsrYrm0CrrZQjkxqQO4iVwhMjf4OBTkDPU0CRwH3U5gFe7HMX2H4axO1HFbvQtuwBAyfcOsw5BzfJF7gFwv/CO0cy2jVssZ0aulVU/tAY0jmAQ1VbqGfTraf7CRjlpHwPWbWPw/2t4flmpZxC+dMVGlsCLmawTaFO8bvoDaESiu2cZkvUjelYGbQet+Z12JplSNV+88+2uH+MihYyepI1FHplVFtKqGlOZLJmpCJLvWxs2P+brAR/XbLW4lIWajrVXt9swHYYuc4cHoOtQb/ppR/KGGvQXE8oS4Tp4/XTSS3nh7KYvR27z0dRHSi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwttz3qj/XNvONzVI1nm07/NIziMXjXm9cIhlYAEBqA=;
 b=C6JltlxhvBQzL9unU6MFuVRu0pUGPnUAa4YEB2Z1B4eG4xcM/nbp1hadYJeJwYpwbrS2IHwIW4Xpytzb6nFsq/ukZITK8G8vWu9agHTH7wxJad7qf7SQOyfGzttrAvln9LodYFy3CeegLg+SgIOkyphikmxh4lgf111PXkrEc2w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 08:58:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 08:58:05 +0000
Message-ID: <acbbf1f8-bcb2-4d39-924d-9d84e95d31fa@oracle.com>
Date: Thu, 21 Nov 2024 08:57:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] PCI: hookup irq_get_affinity callback
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
 <20241115-refactor-blk-affinity-helpers-v5-2-c472afd84d9f@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-2-c472afd84d9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0682.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: de4d35d4-da19-4108-cd10-08dd0a0a9cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZKd1JyYlBwanVPT2UrRmJobWpqUDZMWUtqR1h5U0Jjb2xjZjY4RzdnTmxN?=
 =?utf-8?B?NG5OYnZZUk5uQlVYUjFGbEdzamliRnB1ZSs0alg4VThpcm45VVNtWGZ4TEpq?=
 =?utf-8?B?MUgvd2FjeXZmbjE5VnZNdXFoU0tBdDd1dlpaVGdjelU5S3dnQnp5akVRU2d0?=
 =?utf-8?B?Mm90ZGMrWEh4b0xKa1I0c3BFUlM4Q1pnSVRJM09OcytFYzlDY0pNWldyQXU3?=
 =?utf-8?B?bXVlTk5KMlBRQXhqcHp0MGJ1Z1EyTG1CSlVDSk9SSnhUejBSSTRWUEVNWU43?=
 =?utf-8?B?M0pubm1CdEV5dDRXaER3TzdTc1VQWjR1RlNyZTEyOTNZc1M3SENuUDRHVkRi?=
 =?utf-8?B?bW1lb3hLSlBvakNmWVloekZMdzlGUi9qNjR6c3kweWlWVHk5Q1Q3VXZaaTZC?=
 =?utf-8?B?TG52dFArdlpWeElzSTZzRC9WZGEwQ0VYeUc5MEdEdWRKMUlZUUQ2Ri80ZEFk?=
 =?utf-8?B?RVd1UW1Fb3A3RnpRbG5wcEZBSDNVRlVKVi9iWFBNeS9ZWlgvdFByRUtFWnlu?=
 =?utf-8?B?blBONDdNbTVWbERWVzNUb1crQTVySUJoem9vd2I5TTlLY0lHMDlnNGN1MGdD?=
 =?utf-8?B?K2lnMlBzSmFaTVdFTWVKY3YwVFVCbkNLVk5LdmIveVg0TGlOV1FwR2RqRTlk?=
 =?utf-8?B?TUJOM1o3VnVRamRZZEVkbEd1a05WS2lXMWk3UDlNclZKSExiNlJEVjRxVWVt?=
 =?utf-8?B?R3NFbkoyejhiOTg4amMrR2pzdi9meGdpT0xIRFpjaEJHR3hEOGtYbE1JeEti?=
 =?utf-8?B?dzlFTG9BbkVsMGJIVjdEeC8wRlNqbTBaVlF2NllLUUFPYzh2WjB3SUtFMTFT?=
 =?utf-8?B?S0xuNDRhY3gwTWVtNFc5Yml1QnJ6R0ZONll2QXhhZmt5dlB0VWpXTElEckQw?=
 =?utf-8?B?WFJwRFF5OEg3WGZsbkhoWW5Vc1lWK3hiemJuc1NOTGk2SWtSbmJ1dlRjWFRh?=
 =?utf-8?B?ZFFGV3VrZTlaL3hlSWtYMSt0emIvSEFQQlFWYndwdmRORHczbkp5Y1VUM3Yy?=
 =?utf-8?B?Nm1UYTlLNEpkSWY1bkd5V1VoT293SUJjeTl0bDVoalJXa21tMUlFaE1NRWho?=
 =?utf-8?B?K20zZ2Y3R055QUk3T1JQaW1wWHpiaCtnd2FKZ0FMcVo3dWNTTDBUaGp0d3lF?=
 =?utf-8?B?SHhqVXlTSnYxN3RxUThhQWNZV0w3TEhRdHpjbk52NEQ2ZWh1Wmg2WUJUOTRQ?=
 =?utf-8?B?eXg5UkgxMDE2czF2ck5JTHdURmFtcVM2eTQ0NFFIMGs0UkRkUVdWdTdmakQ4?=
 =?utf-8?B?Qm1aN1RiK3Y5YW5yNXFzamsxTUNDazFMRkpHVHNsRkh3QzhkWWNqYWpOUjFy?=
 =?utf-8?B?dEU5N2dUZkhtdVlBR0pRZFMyUnpVbzY5Y3I5bmNRODJia0huYVYwdElhVVVi?=
 =?utf-8?B?eFUxZm0waG5abmFCOTZHaXFkd3paOWhXbStkZjlVMGJmRjZ0SmFKSGFzblJI?=
 =?utf-8?B?V0g3WWs1Y1BBVGFVQ2dSTTF6d2piaXpqRVhKMTVwdmtjZVdLM0FUYmYrUGZW?=
 =?utf-8?B?UldyVnA3ME81Wk8rNWZEbVlxNjZldjZpdlJmQ01sK3F6YTFtYlpFT2YzdC9k?=
 =?utf-8?B?SGd4MlpNSlBxZkZsK0FDem4wRXFqckd2bjZ4Mi9IQmx3b1doNllZSWV6a1dI?=
 =?utf-8?B?VkVGcEFld0FUaUFzOEZlOXYrcTZnRms4NDVrZCt2clNTa1pZSG1ReHhPU3FP?=
 =?utf-8?B?VENDUGszbjZTQzAxbUxJQksyeEczNXZDdkcwUVVQUGpGUTRQY2QxdmVVenov?=
 =?utf-8?B?Y0Q0UEhoWVdxZEJRcTF5RHpRTzdrYzdHZUFZMFBvZ2EwUmJjK3FvMGhYMWMv?=
 =?utf-8?Q?BEG96jSS5bHJNvTUngoNC/b4sIWYLlAlGgCZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFVjM3llMnd2d3g4aytiaWs3Y3RDVFZLUzdKRnRxeGJHOHIrTmZYVkl6a0ow?=
 =?utf-8?B?Y0JrZkUzTXlMTHZ3alVFQjJhL0NVTE82MXhpYlhSN3lOWEpTMVJDeVJtUWZI?=
 =?utf-8?B?RzhuWUp0cDNGS1RIektXSHAyV3lGVHBWTVlRLzFkMXpxbE0wek1kQzlkR3BY?=
 =?utf-8?B?bGZ3NDBnVFdjOUFwakFZcEYwZWFtL1RHd1JlWndtSVlVdE5TU1NHb3BxSGUr?=
 =?utf-8?B?cXZjOHQyRHhBODY2SWRoZ2doMmo0LzBSL2RBcGUxQVNhTWRkQjUvVnN4SkNB?=
 =?utf-8?B?RWJSdW5yRWdzZzRFUTFLRkRuLy9NcmREaUtRSUJRNGZLVU5VUHdTYWtJSHRq?=
 =?utf-8?B?M3Jmb21zYjI3aHFnQ3lzeFB4Kyt5SVAwZTd1cU5zUVR6STJDWEU1R0ZKRVRW?=
 =?utf-8?B?THRXR2YyK2o5Zk40aVRwcU1ydTVnTi9MWG42TTBWUERqMmRjT2xYRW40eVgr?=
 =?utf-8?B?S3hmbE1HdlIzdkVrVThtK3hCeEEza3YyMDE4OTE1ci8rR1BERGpTMEhXQzNE?=
 =?utf-8?B?em9lQW9sRzFGZHlLK2FyZ3NrMlZPT2ZPZWZQQnpOeWdKUkVsVGhZeXFObjN3?=
 =?utf-8?B?NDJRTGIvSU1zdkM1cjY0U0pkVmdFTUcxVEYwdU1UV1BJU0FTMDNrRFUrc2R3?=
 =?utf-8?B?TnJTZWJIVXFnNzZ2WjhkSGRDalM4TUxCczg0TWVnaDhZckNDbE51TDZMVFd6?=
 =?utf-8?B?RnRxeXZFa1RuYmpaY3lSMlZ6L3ZBNFphMTBpL3k2YStISVYvWG5nclNuS2U0?=
 =?utf-8?B?R2VXdElSTEY4d2dDWU5GR3FMMHRCWmRnUXJibmJxU0dsS3lpTXF6aWwrc2Vu?=
 =?utf-8?B?b3hJZTR1b0Nac29EZW1NSlljV3V3WHFoaGIybmU4STYyR0hRcWx2anRacnJ2?=
 =?utf-8?B?dTRhU0lLbjJuaUljTFNrenpTaUNhQjdFUlB3bTFXMUVFMlNzRHAvdit5VVN5?=
 =?utf-8?B?U1FFM3A0dnYvWi95SFg1WndNWWkrRmNEYVJ3UGRsb3lhQ21JS2g4Y2RWMDFF?=
 =?utf-8?B?SVNiYndSbWJiZXZqUzdPWmtpNno0ZlhTVEhKaGhKRWZnSFJhVTZFSHpQNWdQ?=
 =?utf-8?B?Z3hBOEV5c0ZxZTlqd1hlN1FLWlhZV1h6S0piaXgrczR1c1FJUmRMWHp0eTQv?=
 =?utf-8?B?ekljNGZWNDQ3SWNDWVloNXR0S1I1RTNRYjdndnA4djUwemVMZUZIQ2d4Q2h6?=
 =?utf-8?B?bjBOY3lLVHp1cjVzMmdRV1dGTEVwMVhjN3JXcDZFNW1YeTdldlNOT21QMWZr?=
 =?utf-8?B?V1NUTzl6TmxNNFdZbGhqU2s2MW9VY1Z6WStFY2s3WFVkUXFJU1EybnhFU3ZD?=
 =?utf-8?B?TU10ZEhvVnRVa3BlSm9YcVBYNEVqaXFwdS9rejRWQzJ1N2Zld2ZYNWpjc1Rm?=
 =?utf-8?B?N0dWSG16M0pWek1vc0VCTzU4YWRLNzVmaXJ4N3o2L3pjTnRwQVUrOWw4RGh1?=
 =?utf-8?B?d0ozejdnVTVNeHFtcWYrMGgxSnViSjJxKzZEVXNuNXJHRVdyN083d0tlaFJT?=
 =?utf-8?B?dmIxMDJNTjZRb09MamZrZlpac2RYUjVMMkdPTHBSTVU2Y25HeE53STdMY1NG?=
 =?utf-8?B?UUN5NHdQbUJGcytJdzUzWm9FNk02ZHZEMWIyRnpYYTF6TzdBUjd4TFZub2Qy?=
 =?utf-8?B?NTMzSFd3amIzQWNHa0FmN011T2cyZUt4VGdpUHI3UVFTazdIWS9uRnFBVGFZ?=
 =?utf-8?B?MVdrVVJRdm9BeHhLdWdFcE95MjJVaUE2WVplWDVpaVV0TnZXT0FuUzVhUExK?=
 =?utf-8?B?SnAwcUNaTG1TNXUzV25hLzgvQ1oxTkZUVVRacGR3VDV4MEJNM2NnbmR0WHdr?=
 =?utf-8?B?WVJTb3J4bG15bm4yb0JEOFlkVWNESnJqeEprbnVQTW1ReG04SlBFTGZMbjhp?=
 =?utf-8?B?WmxWcWoycEFQV09jZ3lvbFlXM2p4c0hTWTFKd2tTVUsxNGplMnMyZUVrZEg2?=
 =?utf-8?B?c080Mk9QY0dHTDhRdDhJYk9LNHRENW5Zb3VPTXBGQVBsN2k3VkRHRm14YWt6?=
 =?utf-8?B?Z0NTemUra0pEVzRhK3pXZlk2NXd1QjBOWndLRDVQbG1WMDIwMTliY2d1a2Ny?=
 =?utf-8?B?U0Q4c3VOMFpTeDFhOU1DU3l5Q0lNYTdqTVhFT2xJTlQrUnVENzY4dDNwaUtI?=
 =?utf-8?Q?WuIVkHHJi5ZW82CD+79UzAVoc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C5bMwNvHvoi264rZN840pXg4TdtPEWKg0krfH6neIXkoEWiwnyZ7hD/NpDwm8qTBYeJuK2TxSpJrkFFy3hLNwmXqSYhPrKU8xaE3Dbg3dUjxOGI1hstBX0dX10hfb1pW5tzT9bjnFdY3fROViiVWmhsla6gVYy8GNgZfdeC5ypNTlqtGnHOhYWwD/OpgbWYTdzOSiTDY40ucLPM8TBcJaEAv4KfA8wQ0fDOtQy41wz1Lpy4xlZbIRPWMByhmi/wW3FTJAFuf/bgTIKQig2PE2oKNJPOaq2BdZf4UkPFqMtx6rwwy0mbfsn/2t45VBeEB3ZzJ7ougHIGoEL+emv4x2oV3yPekLWiPhoOwF/e5EuTt416bw4KTQ6jTcbRq6TjPbhOiidY9M/KIxML0OHZjLYft+Tw1iWo+SV6VvO9XN9y8AjjcvN3hBwM9PafCT11u16aLyjeD1jHYTiDdN/s0tvXWSJEdrPoDPBRWlTDkWHFkOm1xXJHKU1m5AiXDicOZU715by2ppMGJDjOgLixuYK+zwfcpwsJFocaSa/W2jjKvIotpq7W5DOEd+eewJhKcS+5v1RDc0hRMMXpz8zgBXyI+YF+J7b9zL2MrY1Z0MCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4d35d4-da19-4108-cd10-08dd0a0a9cab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 08:58:05.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfADptPG/rqrI8UovEuKWdoXvVvn5XCMCf7dZ6MiGVhe5Vagre/nZmWSKxEaWOSkzW+Y+q066QU2KY+CmhWqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_07,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210069
X-Proofpoint-ORIG-GUID: jTwWSPlAX5Q5VnDxSCVRNV0iVMZdb2OC
X-Proofpoint-GUID: jTwWSPlAX5Q5VnDxSCVRNV0iVMZdb2OC

On 15/11/2024 16:37, Daniel Wagner wrote:
> struct bus_type has a new callback for retrieving the IRQ affinity for a
> device. Hook this callback up for PCI based devices.
> 
> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Hannes Reinecke<hare@suse.de>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Signed-off-by: Daniel Wagner<wagi@kernel.org>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>

