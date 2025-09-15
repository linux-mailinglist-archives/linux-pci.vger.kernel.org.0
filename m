Return-Path: <linux-pci+bounces-36197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C491B58524
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4122482D70
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797327990D;
	Mon, 15 Sep 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KUrKtEuW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dMAZYGZw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3701E9B1C;
	Mon, 15 Sep 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963475; cv=fail; b=XOH3ywy2OLA5ycULMVp7/cD3/eAojbhWItTmZl6ECPDE7fVrZcTgBghCTm7D2aBdtEkOzuHx9mswscCvCKsHMOxJhjMmgJ8Fwf2PEX/sJakDb2we1qwfGCpH/1dC6ny49K087s0eBKeXzIfEU5WV8d7YfnWFIk2pb9Kj+NbkkaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963475; c=relaxed/simple;
	bh=C6yWLpKHHL6CUoQ4CHre1jIajBMdDVq2tIyT1SfoY64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMSEnjzlImvmJNbSBEWHCZ/3qqWXeUi6AeTqnbPZ6ZiUw3irJlcYqhZmasO6xf8vw58flqkpxiWdgK+pJLmUr8ak4jiRfEElYhV0KsxxlIgMblc+1YxbgXWci9GVNX9DZkj6IeM2iB6uxDCvCBTHvX+XiZKBuUGMcEstSCYwiFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KUrKtEuW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dMAZYGZw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FFT2sY025934;
	Mon, 15 Sep 2025 19:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8xxncdPivBdyfBqTIACNr6CGCqGmOx0ykJ19TU62SYE=; b=
	KUrKtEuWfe7Q7Kzei4yYKbJHqhz+/vhwd8fL6sGf5kxwO7z7P1OqHAbX9inE2HwU
	lrNT7bfdamcCo0OC6Ctb6NurZjahiGvozGGtrt+I63dGZbQTBji+46B1q6oJoTaL
	ycBG+Wc1jBKFN3vNXIXqrImFfEaNdmrOOPJs5aMa+YfCrbjIXVI3Ez3bzhwJ3e9a
	0RNkzt+pwKwMYoSuH+DDusugeFZk0GaOaiarGI8yoRPZmqTRFZlJmTq2A/MEPw2Q
	VthG0XTBYCQUd9GZJYLPHuohpGWPgn7fbuZC5el8e8Xo/NecRwGC+J2ziWMN8CBV
	ClxATf+RqrgONBAXpJm5Bw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v335n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 19:11:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FI1VuA019213;
	Mon, 15 Sep 2025 19:11:08 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2bpb54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 19:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAsPalvLntsI1nHUX/6jpZzxROLwG95lFgeIBbDNsiycDuXg4xVUAcz4/F/3h3W8jki8YC11FnEtUmhu1XTDR5Ev01fLqJnMT39XJ4w/zTmS4QjIoaeHqak9rhdQ/1jvvHN1OUHoLwcGljWUdFNqDrakKFPcogRvbt7vjlJggC1o94DTtCij/nj1hAJakNWrwOH2Gqz9a/90bMYPv3DmWgJ4YVcCpHHWr566akmpaV1LnAsSkdqAnwQPVZJE+3BhHFdwAfP9RYUxWryd1pkI50R2+LjeeWiITui2biHAyluIzH08ahpRUeDS7FmfjOsQLCW83u8ocAg0+x/DuFNLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xxncdPivBdyfBqTIACNr6CGCqGmOx0ykJ19TU62SYE=;
 b=WYoVhnBwo0ukX0acfPDsQq9ZF0KwglFbfF5fBOc5LPsQcKihOFEL1bCmq1OHqPzIMqVEmjUmBKAkRpzFB8PG0BCaVOd6YokkxYHmmDIt2j2nUMHs/aEpmAXRH31YephC5yljGDEIph9gt0EtVWPNqfuyZGnsoYEfxcQiSzflvZXZZc6vLotXpzTFxTInrSEm8BlUrj0pCDWS7xKhLwk+NHV+s6BT8XqpSIM8ggF8E0dNjyqSJmYLOQ0CEzcu+gsl55u1Vr3N0bJ1DxPyhFIWmQ5R0g0dZ1YkdAZoT79zyV4412B51rz8ySdb6V6wDiWlRL4+k0I2sKPzuBVQR6SVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xxncdPivBdyfBqTIACNr6CGCqGmOx0ykJ19TU62SYE=;
 b=dMAZYGZwirf0OuOcL1KwPL/Ps1ByyvLedRpgQMCCCcLGknJFnd3r6O0nBMdJ8ldQ9Q33HLtj1tGO7POe+odepyP9PkUSXXiX31Iq9cZxBpKk0kdIL5tYfTC/WCxXTfHi7wq+bKuhHdcyN+C1x1gEEfkhOpX0n+7eWO09eX+Ei2g=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB6317.namprd10.prod.outlook.com (2603:10b6:806:250::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 19:11:05 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 19:11:03 +0000
Message-ID: <1f96e533-4863-4085-9da0-99053e0e5901@oracle.com>
Date: Tue, 16 Sep 2025 00:40:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] PCI: plda: Remove the use of
 dev_err_probe()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: daire.mcnamara@microchip.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xichao Zhao <zhao.xichao@vivo.com>
References: <20250820085200.395578-1-zhao.xichao@vivo.com>
 <cl52jts26ulfcanbzz42w35g3bcjlwfhteph2oze4drveajzg3@a4kq3cxfzn2l>
 <cf18193a-5a49-4e0c-b07a-a4f705fc5c8c@oracle.com>
 <7vtlzppunpkrzwpdfplyzcm53fpxik335wtng7ethfjyvu4tph@df5xusqn25it>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <7vtlzppunpkrzwpdfplyzcm53fpxik335wtng7ethfjyvu4tph@df5xusqn25it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb20711-678b-4b03-5b4e-08ddf48b9d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTllSC95LzU0ck9vaDc5eFc0aDBuL0NRNEFOS0lPWFNsM1pUUFMvd0pqS3Fz?=
 =?utf-8?B?ZXdDZTZvdSt4MU9ObXlHcTBvZnYvRUxtVFh4ellneWhMbDIwWnVENnZrSkY5?=
 =?utf-8?B?SHRLUGlSZW1DcWxjUVNyMEJJSWZVUFdVTjlhS2M2eVdGeGJnSlJ3MGtUMmh5?=
 =?utf-8?B?V0g2bVBOUTBpSDdTWEZIWDhsMjdpNml3ZmtCSmJXemx5QjNhK0h0RnN4cXlR?=
 =?utf-8?B?ZUxIbFlYZUx4YjNXWEZ1VjBpNEJwMmlGb0N5UE53S0pGQm5jSWVlWVJFVTFF?=
 =?utf-8?B?MGdrb2hHbW5mS1FWMnVBb3BPWWdmcUNTa1V4SDA1WHlxNDAxZ2t1SWtmbXlo?=
 =?utf-8?B?bVhlNCtST29KR3hUejlJNk5nSE1VNkdrSlhmR0pvQjNuY3hFa1IrdzlMVklw?=
 =?utf-8?B?ZDVmNHhIUHZsdnFKQ2RGTk1ua2t2VEUzQ01qUWhIVjBtdExCdHY2OG9jVXhR?=
 =?utf-8?B?a2N6S1NlZTl4cWU3UitwS2NZbVRwWEhWelpFb25NQjFBdzJ4cDJoMk9pNGNF?=
 =?utf-8?B?eVo2UlJ2NW1lMDBjanVIeDhVZ05pOFFoK2JreGU1UEtxdmtpRVNzbmliOHhG?=
 =?utf-8?B?Ym55T1czL1NlNHpBVjI1MTZSZ2wwTVdCRDQvT1ptZWZqR1Y3eWhGTlZ5RER2?=
 =?utf-8?B?b3p4WVlCWllMUndqQk9oNmRreUx3NjEvRHV5Z0hETjJNNTNzOVl5RktDQktM?=
 =?utf-8?B?TmsyWE50cXZvVHJuYUNjZEZkaXgyNko2N05oWHdFWEw3VG90dG9pdkFPM0wx?=
 =?utf-8?B?MzZUYmhwd3pQWTBRcEtkZXJoUTFPN1lXK2NTdHBKbUtLNFZFeVVvclQ4enU4?=
 =?utf-8?B?NnN5ZUt2SG52ZUdiL05XVEtjZTl2VC9yVnNvdTZCVGRSUE4wRmh6RmhqTy96?=
 =?utf-8?B?OVU1a3RDSWhYYTBrT3NGR2VzY2hxTkMyU0x6aWNRNHZQOUhITVFNcHIwdXo3?=
 =?utf-8?B?SnBmTzBEK1hxNWtuQ3JqWVdLeFZHRFNQdHRmNGhEZkgzRDV3U3QvU1Z4clY4?=
 =?utf-8?B?ZjJORTBhWTVOSU9zREhENEtLVC9NTFpBZlhYQVBOQmxRMU1wTmM0aDdMaTNX?=
 =?utf-8?B?V1V1UG00cEFYSW9aV1RNbjh5eWM3cVpMTFphaXE2aEJVbUhCSmh0WFROU2Nz?=
 =?utf-8?B?cVpjNGJEa0pkU0pIbUp6dTBJdEl1VmRuMFg5eUk4aXpFODNVUDI5VzFNRlpQ?=
 =?utf-8?B?eXFmb2FJU0c5UTdnZG9mWEQ4VlZXaFdGRStTU1JOVjdPWlFkZ3dWaXd2UlhM?=
 =?utf-8?B?aW8xcnRWSjU1alVPVjlxY3BBUmlYbGFrVENJbzZCT2prV0RMTzRsK1QvOVFD?=
 =?utf-8?B?Sm5tVFBaMHZ1UmlCcjQzSTdiUmhZQlJOQXpDRjhMek9rNGZTK29KN0dHTXg3?=
 =?utf-8?B?bms0YmpHZWRPMnhsZlE5UUkzeE1CZWhhSWlOd3Qra3pXRnB5bDBHNkExb3d5?=
 =?utf-8?B?bHdPckxYamNPSXF2eU55WnIzalo5MHBQOUJ3b0ViNXg1UTZ6UURWSURsUlJV?=
 =?utf-8?B?b2xKdnFIdzZyOTJIcWRYYzZsMkQvV0VLaXZvSXVCT1BmQWQ1dDlhUmVhYjlQ?=
 =?utf-8?B?aUt3UDYvd0kxMmtINENTY2d1Vm1BaCs3ZjJIVmNGMk16bUF2dGtrUnMwQlUv?=
 =?utf-8?B?aEFSVFI3QklWaERqaHlKNnlFK0ZlZVU3UjRQN1EzQ2wwRHl5OTJLNGlLTmw1?=
 =?utf-8?B?ZkthR1N5TVJudmFSU2hLK0pmeXJGU1I0T3R3bENzZlQzN2I4WU1KZ0FsaURB?=
 =?utf-8?B?ZmVjMktDQUxaczVPb0EvTEo3VFY5WG92cnBMTU1DTXZWcnh3UmhkYWZNOVJq?=
 =?utf-8?B?K1BZRG1mb1ZTakJiQy94UFZ3SmxuaU5NeWVtSDVWMHhmaTRWdWdwUm9EZnd1?=
 =?utf-8?B?YkJjZzN3QTQzQ0c2TmpMYXUvSWJiaW02VThhTThBMXhGMVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpINEdLNWdiM1dXd0ZuWlRtdkkrd2xWd0hXanlyRVVkdDBZUFVmMTRhbTh6?=
 =?utf-8?B?WERsdU1MR2xOSGlzMTVQS0FoZDg4eGpsVDVTVUtQMTdnQ2x4Sm1EK1pnYWlr?=
 =?utf-8?B?N1VxNVBMYmVYZFF1UGNTeGtsaWFBdXZZM1E3LzJ1d0VxNUQ4SnhYZEMra3JQ?=
 =?utf-8?B?cHFFTVlEN1V1MjhpMUJIcXZudEU1Mm9LYWQrNlRJSFg3N2hQTWREQklpRVNO?=
 =?utf-8?B?aWJpYUY3Y0hNNTVseEorQUpWL1NrS3l6Z214S0hnNG9tRmFZOHZiMHJmd2I2?=
 =?utf-8?B?L2R0OUVDcU1SR3laTjRsUmtROUErYTMvYnM0b2JPeVRjZ1RLUmQ1Qk5vdUk4?=
 =?utf-8?B?Qk1LNlBiZGZ4VUJwNjM2Z1psdWRBMzUwei83c2Fab1ZpUDFncGxmV01qWnNF?=
 =?utf-8?B?c0VQengyclpwODhKanN1ZlBRc25IbHZsRno2UEIyd1BVTzNJUnF0T0RzL2xJ?=
 =?utf-8?B?Y3A2RTd2Qi9md2JSZ0tEWWczQlRPUFZXRXQ4cElWdUtyd2szbzMrZlJFRWt6?=
 =?utf-8?B?WkcvQW4xMVk4Q1NiMFNtS1pOa1NlU2J0MzJhSzRRakNDVU9WVVNReFd6RjU2?=
 =?utf-8?B?SUU4ajFnbUFScmxWMWs2Q0JxcXAvL3VOZDQxQS81ejg3WU9NWmQ2MVEzS1c1?=
 =?utf-8?B?d29WclpKaEFCeDVNVjhWRWlKMVNieDBHYkVPVFkrMjBPRUdKTTRBTGF1b21C?=
 =?utf-8?B?dXlFalA0UEhtVm9iSjVRUk5kT3VKNWRiNGJhUmhOMjRyb08zbUY3b3YrL2RQ?=
 =?utf-8?B?ZnFJRmVjTWM3RlF5TVQyUVhCUDlPV0xFUWFoREhFeXZZWlM4WXdtMjBQVXZl?=
 =?utf-8?B?cG9MSmM1NjN1ays0ekRmZlcrcDdBb0NBc0Y1TGVtZFRwRzBYSFNGcEJiL2Yv?=
 =?utf-8?B?bGg3MTJuZjcySENkajg3RXZ0ZXZBazZrUzVHM2pOcEN5OVd4YTQ2L1ZjZFU4?=
 =?utf-8?B?RDlVWVBrK0NWNk82VUJGL08ySTdXbmNSWHl1TVpiTVpwcDZXcklWTWpJcjQr?=
 =?utf-8?B?c0xxbktuSnlFSmxjUERZSDJWSGt5WXhxSlkxOTFWd0RSNm5RY0dwWkk2SC84?=
 =?utf-8?B?OGZCL2wyRTBoRmxVRUlHODZjNXFqR3h3dm1ZNGpaa0tWV2Y5Q2FjK1VkV2l4?=
 =?utf-8?B?bThDSkJnUjBnOHlubVE4L3llUFZIOHl3TGJXNkJpRTZ6LzZWekdxODRtS0wx?=
 =?utf-8?B?d3N3L3JDZ1FDK1NLVGdSSGVuOCtmaW1RQy9MeUxRVjgrRjNOOElTUXdHWkRT?=
 =?utf-8?B?b2RqbzRiZXJWem1iSkZLTlFkNGJZU0QvYlVpdDBLRHRIVHgwMk5rd2RDTGlU?=
 =?utf-8?B?NHVTeXM2ckx5ZnhzMXVRT0R3UUhiRGNadUZ3TUNQUnpTR3ZtZVdpWm1IUWc3?=
 =?utf-8?B?c0FyK2ZtYVc5ZUpLVkxNWm5xb1ZDSWEyRjR5LzZWa1dnZ1F1amVtNkRUS1NQ?=
 =?utf-8?B?RWhJQnJvQzl5RFQxd3F6WlFqQUptMjlQc214Mk5raUw4ZEtuNGcxZTA5MVAw?=
 =?utf-8?B?UUFGeGxoU0xRN3IwblB0elV2bUQzNEFNU2RzU1lmRVFUNjd6Mm1vS1IxWW16?=
 =?utf-8?B?NzMyY0UzVkJvbWhqSGF5Y2k0dmRnNTJNTjRzVmdKblRoWjRZVWVkbFBMSW5S?=
 =?utf-8?B?NGtUSWtwcXFqMEZYYStUdWk4V0cyRzNpU29DNklUMmtyQUhEbUk3MUIvQUpw?=
 =?utf-8?B?TG1NT3A4NFFzQmg1VkFNU3o3a1hWa1BVY3VqSnhIM0V0U2lyMGlBN1pnZ1Rh?=
 =?utf-8?B?Y2Zkd0FKV0xBa3hmbk5sdXB3cjBvUEVtMlhESzdEZ1BKRGoxaEJ2M2ZxUGFq?=
 =?utf-8?B?UnV0amZndHBmaGg0RGtrUUlSd29Tb0lGMmQxSXVBUS9rMTNTa0dKTllxUnZ6?=
 =?utf-8?B?WmtYMFVxVndENXFEcGlvVkZwZVpaMmo0YXM0TWJnZjZITmpsckhBWmNYS1FI?=
 =?utf-8?B?VG1TelU2UkdqOWlBOHJHbWs4MGpNTkJzS2xMYWZmQ2cwOWdWMXBQbWhlMnQ4?=
 =?utf-8?B?M09pbzBiMGhhU2VTVnF0RXN6WWVRVTBxZEhYSjdsZkxNdXNFNGhhUVNhNFZa?=
 =?utf-8?B?cUdrTlJaWWswZHJQbktOcnprNno3SHpCbTd5R3RrTFc5NmdkU1Mwdm01aFdS?=
 =?utf-8?B?Sk5xeUhhc3ltc3k5cGQ5bW9sK0pYcW9LUkk2bGtGdElFYkI3ZFlKTXRrNU1v?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yLOjAjE9PKisuq4zcgSuTbbGG+lMKlMBRnbr/cxS86eOV3AsNw6XOYE5JHoDldxaNsoNLSagXK7/CIYEqFNbmLehHMOsmmCQ7WsIy0cpGX5+jPVb+BvHyPp2k7sdjoDaqU2tF9rnjxox/CPLxcFEKfGdw67EpcrTqEX0HEbraGrW9VdjPxpmyMcWweEE6RqcYCXMIuOsxi4aTQjIlqQlk5CdJKQ5j6YKR5V8t5xBsdqs8XswbGPTppVHKNgQpB/iu1j3IuQP54Zlhy4t9lR/S9QctGqYUGQ4o1s4zOxyaV7IlmXdvx5/B/DJaHl8bI1rLb0ojouO2jiyq/oZBdm7gBDE4dkZOMl86Dw7U93IYPJJuJf0WIPFXuOlV2m3Rrics7vWDTbUfqXB9/d2MwPzvnlTzH4nK2vNgA2qc0BBSAxnpLlaQAPwucNjI7CK2cn+t6rTHYgUdWUTzbPRnJEix2V2qPMDT6pKbkLyVzkuYGJ976A4GnAF9/kvPjVNZpjbtg3UoGzewF+5x/pHEqEKjuDTrOiaMaeWyXi/mnjDBJM77w+QwiluuDOJXAE1S58SpdGXMP6BZznkvrYkGQLhH7fuvqd3tA1XG4WjhjDX2L0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb20711-678b-4b03-5b4e-08ddf48b9d72
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 19:11:03.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PQKV61yvkDXbe8ViC/uzbogDFtxOui+XQXfb2QFEHawEgPh3KNlOWx+iLz+uPVVnK8NOwID4udtbmtsyGaVVT0RMGuG3hbD1FFvMjpcGCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=726 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150180
X-Proofpoint-GUID: HqHd5RzV-Hbs1wKFPRazbpm4RCiFFJpe
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c864cc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=X_UhRqTI2KD8B14xbFcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfX1BFexdqx/tdz
 Dfh73oSfxDjlxftOjvxtWbO63eoMUh0LT0uefDBAVn2CfDeNY6ywt2zZLI/sh7yU+qMs347F1Ps
 LawWvEgDhlY7HlBE809HoCh6hm8aARjnKi5mf/L6v72tmQ8Dn9XKmVugtcHHxyMCx3yfERO4h0N
 HrpGBDoTf9KUhzkFzpal2ARKXLEw+BIeT1wxDHh4Q2OYWmwJRMEPfHdLakkM59T0Q5kDcikSX1o
 QF7tRz1ApwWC93e361zjKHlTVu847kY28XeZW1ad9Uneh6i8YbpvSFSqUHWUmFRIqABzbOiIRNz
 uctFU9KOp/P6yrryE/deSNs7PomdzocdtKuJUE42z+i6DgdkNOXHD3hIqsto/zQuQMhOFzmuttb
 FBkLiMfl
X-Proofpoint-ORIG-GUID: HqHd5RzV-Hbs1wKFPRazbpm4RCiFFJpe



On 9/15/2025 7:37 PM, Manivannan Sadhasivam wrote:
>>> Change is fine as it is. But I think devm_pci_alloc_host_bridge() should return
>>> the actual error pointer instead of NULL and let the callers guess the errno.
>>>
>>> Callers are using both -ENOMEM and -ENODEV, both of then will mask the actual
>>> errno that caused the failure.
>>>
>>> Cleanup task for someone interested 🙂
>>>
>>> - Mani
>> Did you really intend to do that,
> No, I don't have bandwidth right now.
> 
>> Should that be an RFC (for cleanup task) patch ?

I am planning to send a patch for this cleanup.
It will touch all files under drivers/pci/controller/,
and I hope it will be useful.

Thanks,
Alok

