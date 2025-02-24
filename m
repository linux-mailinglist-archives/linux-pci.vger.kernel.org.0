Return-Path: <linux-pci+bounces-22193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71280A41DC8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E23A41E4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F025D530;
	Mon, 24 Feb 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXu1cW8N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JZDoz/N6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096425D521
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396443; cv=fail; b=eIFS1S5iJ27Z6xKXqPUuPtORFnJM361fYzrM1uceMmKP9LYVPol5j+o6q02RYBQVJdNhNXL8Zix8ff10tFgfe5zG7LUobXqbpuVZwQvJ9wiLdhNeneELriUlz7Luf6qbDgEyf8H/XQ15GyhW05Z+sxt59sKiWreyeuIJgCtG2lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396443; c=relaxed/simple;
	bh=TUuDvrZXrpznkUFmQgRCFxK9CAYfBV0+yTB2VFdcPiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSSSHBZ7GWIwy0x7Y2eBVYOBDDq+Z7gby8XUGtzQuOroTpeVW7o6NkRjPWhT2fNlXrqMsnL3PWPP1FF8L29r8ktxeTe5VoW4UwB5yvSLq7rqeuitYVQL8D2iayd+R994byzHckJlWTW3ThaMRVDP6koqXqHjO4/MBpP8bU4CKfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXu1cW8N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JZDoz/N6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMa3p015094;
	Mon, 24 Feb 2025 11:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tvPY2gjJdBUdyMXTXUF3BFvF2abmRvGhD+kGcriOKEE=; b=
	TXu1cW8NxVZdS7+JsSxVckpHt+gjgq2cxIBQQjhaytoJcELgfv190IHd5t5/u0Q+
	SXzcJEBsYOamA8FRYeYbaTUIgSluHn/jrcdkqY2HINFwX8Qf8HZxKt+BphQIaZJ7
	pc8udUGiUD5EbeHBxl4yyQkA7LUcCX+VGk+hJnjdckDCK/t3MTHWP6ujScCuLqMT
	Q8JXSA3tIUf2PYMvbF0R/nemaLSd8AQg3+JyAPPaU/aIwbQ1MaJ+MzDnlSW/wXWJ
	VePv1dWSTapWdbCnJN5lB6R4LcFKxft6bVe5tf5kWGhKrTo9JOiAz6G704Eyhr7/
	QAfjKj8h/+7Dj6wRrShd9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y66saatk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:27:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OAIgld024389;
	Mon, 24 Feb 2025 11:27:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y517gw4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANTUOgXpK5TBz3L07oadloSBM4oWdhI4z339LKu9nejZSOxNQ9WTRdPPi3BYWgpm96DyJPxnKyZLMJd9wueYQ0aQlrRbIR04buB+keKB2JA791ZG3YGD0rOjCM/BFrNrwWady0KVjeStFSiO8RYCleWbsnc67DYQh0ix84PuSNqpINE2p7jeqb8ru7QWV96tkEldgsfnWALIPHLRs6cUR/pY5xhyev5ZZyQTOILUkfcHZjYf1s+0RhXFuhLi5gL8msCQrM4RR+AnAwvfE39II2D3wzxgCKeeUID6V/Gs8sElvEsaLkk7IXMTWU8wN5dfAtY+fImlFlaXHHgJOGNrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvPY2gjJdBUdyMXTXUF3BFvF2abmRvGhD+kGcriOKEE=;
 b=WW+hKwJYvnhy2c4cM9+rLxR+QWXHfN5HYaQcnbD1ABNh3s+xAYrATitjCaiIRlvZv+BC8XKnYqwcVU8rUpVzzU60Q4Ksi4pCgcK2N+dO/lFS+f57cn55ahi6Va12IIU0WaLAkk5IFKIWwRILNFU1BM66voSytI/IkUzb6MZbif0DiM1Lrf8ZzUagV/w3vtgIc+B2/5aT/gYCPpI1dDL9pP1h0oV84KSj2MA4J497P4FbYc0f0EJqKRN1M6JmFdHsmU4TLQIe8FRwmE0kgU55AtuiGNeLrAi0vmtWm1XVzwdOH0jV6LYRLpQ4vPN4zU488h8Uh10psFKMBA63tBGFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvPY2gjJdBUdyMXTXUF3BFvF2abmRvGhD+kGcriOKEE=;
 b=JZDoz/N6AjlimJ4fUepkiIbR9kZW7V+rb+RQ7FhtI3LrRmcmMrfAXjPs+fDmLobAzGhka8fSOprOtBSI8WP51To22DSPBdVWrWD8SWI09tRAKYDCi55CKOoA7uNDiRZGR1HshQiQeJjPVmbzmT6NaHkGMv4zCR+B6hJ7Dtn0+ns=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CH4PR10MB8122.namprd10.prod.outlook.com (2603:10b6:610:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 11:27:03 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:27:03 +0000
Message-ID: <ed4effee-efbc-46b6-976c-e5f16ab9b4ab@oracle.com>
Date: Mon, 24 Feb 2025 12:26:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] PCI/AER: Move AER stat collection out of
 __aer_print_error
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250214023543.992372-1-pandoh@google.com>
 <20250214023543.992372-4-pandoh@google.com>
 <52d8c880-85e6-47a4-9734-73a20bb42414@oracle.com>
 <CAMC_AXUg1SaL_zCUi8fE2iBT6_o7Jubi3AQ6oPM-GDUuX5Tc=A@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXUg1SaL_zCUi8fE2iBT6_o7Jubi3AQ6oPM-GDUuX5Tc=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CH4PR10MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c26b04-7e7e-4fe5-059b-08dd54c62941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWwwK1dPeVhpeWxSMWdQWEdwWkRMeXg4OE85cFhIREE2S0IxZEVSR3pYODY0?=
 =?utf-8?B?cEhkZytlcDZSU2NqMEFtRHR4SWVVd2YvMVNrVG5rcFcyTFJ5SnMzK3l4ZkxH?=
 =?utf-8?B?b0Vna2p1Wk8zWFREeTJ6STE0ZW5aMFlVTEM5UVg3cmtTZUVyd0VwR0M2a0ti?=
 =?utf-8?B?a01Eb055ZWhrRkp2VHpkYzlmOXNTSTBUWnpYMkNETFB5TlRjMGFrV3ovZnlq?=
 =?utf-8?B?ZDhrbmVUZ1JJL3JHUjVGaE9vQVphdElrTEdnNmNJT2VnRC9LSjRHcDdtelpZ?=
 =?utf-8?B?TitjWjNNckJ2YVJmZVloVS9DQnNPOHNFdmt1cmc5ZlhXdGNvcE12ZHg2dXpV?=
 =?utf-8?B?aXR6U3ZPVk1XbDQ2blF5Y256Zmh5VEtUdlFKVUdRcUp0VmIrZGhMeTNEZEtj?=
 =?utf-8?B?U1lrdzI4ZFR6NmRZMUxkQXVxd0F5VSs3ZXpjcnJaazEvM1pCRktNeGJFOUpP?=
 =?utf-8?B?MTR5YkNsTG5FOFRucFZTMHl4MmNGNU5nVmJPS3VOaWs0emNsT0hNM1Via3Nm?=
 =?utf-8?B?YkszMCtzY3d1NFBIWXZKSXNkUGQvM2ZPQXE0WEJkOWtDZTExR3V6QWx2VzZ0?=
 =?utf-8?B?WTAreXl5RWNLeHJLbFNNZEp3M3MwSEpCSGEwSkgyZVdDaWo0TVVGUjdCQ2lo?=
 =?utf-8?B?SFJIQ213Y0N0WEJkNUxnbzJBUUhTS1FyMUF0Z1JXOFl1bjZzTThoS256RmE5?=
 =?utf-8?B?Q0tVU3B2b0Vwa04waDI1ZHB6THFuTHhtOSt1K0ppT05WS1FoME1qTlNRSTBI?=
 =?utf-8?B?QTZaT3hCZ3FTQjdaMTFBSlNGR01maithaFVHWUl6Q3JFWjR0endCZVlmOXZ1?=
 =?utf-8?B?RUszS0M1dG9qTnZvQVBPSTlGU2x2Rk1QL1V6ZlRZTTg2MmNvbTZSUUp1dk9v?=
 =?utf-8?B?SDMyZWx4MFhNcmtZb0VaSno2Ui9Pb29YMUQ3VngvTTVzU3dFWlhvMTEzMjdl?=
 =?utf-8?B?UTd5aUsrcU9hbUVoZXNvamxiZ2syZ2dEN3NzT0NJNU4wRVZ6Umh2Q2pSc2Jr?=
 =?utf-8?B?ZzZXQTgrVTU3MGlmZXB4ME05ZXpMK21ocjJmUitkZ1NMbCtxSUlKcCtreU9n?=
 =?utf-8?B?N1MzZHJ6c3NqVlFhWnVrQjJTQ2dFcVhyOFA3ejQ4UXBGS1kzZ0xQNDQ0TTJR?=
 =?utf-8?B?bTdGZHphcU9DK0gzT0ZFVXpXeldVZ2s1Z0J3aHpPZC84ek95clhuY2JEbzBp?=
 =?utf-8?B?U3VqOXUxMXhMeTJhUkJpTW1FblNURy96aUY2ZXNqZUlydmRLOVJyWGF2Ulpv?=
 =?utf-8?B?SXVTbjZ2YjA3c0J3RUtpdXhBOHBaZkU5eXJWL2JiZ2xKeHdFOWNZcmk4azRx?=
 =?utf-8?B?aFV1RlRlUkpjdUFtMmdSR2xRaHgrRVM4Ymh5cFNxbmh0bEUzZnNiZWFOdXVS?=
 =?utf-8?B?WVhaTGY5V2tWbUFNd2RLNFd3YUFZa0lqLzRuWVZpb0JOYWlSMmhXeEVnNHdX?=
 =?utf-8?B?NjN5Q1FxZVJEdHZ1ZXZaZjJmenJIRk85UkwvdnZvbEIrYmRLdnc0L3RPS2xZ?=
 =?utf-8?B?N3BwMUdwcEpreVltblV4K2lIT1Z1RlBrejJHalMvdVNDOUxNQ3Q0cjhGZkp0?=
 =?utf-8?B?d3hvVENQa2JLbnZhYWY1ZzVaNTZiR0E3Z1JKYVdBcjlBRUVDcXYva28veG5T?=
 =?utf-8?B?eStzNTgvYnQzblErQjdFWEdQZzYzelhtSS9xL1UyempPVzNEeklZK2pPaDNu?=
 =?utf-8?B?d3ExZjZGQVRESVdZWGk5L2VPUjY1cm94d0xtcStKd3hiOFdETnpIcnNkY2lD?=
 =?utf-8?B?WWZNYnFLQzZOcEtDd1BMZHhZa1B6VzIxYTNYSmxWai92dXRVUkZVRlE5K3pH?=
 =?utf-8?B?cTBFZ2M3c1lkeVJ1WlU0dC9lM0M5cWlna0w5VGF2QTJpMmg2QzduTTRnaXFv?=
 =?utf-8?Q?lD8wuYE77/y0I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEdTMkllZ3UwcEVRYkNwdHlqS0NGQWIzbjNXY2wwSW4vUWJYQ0ZGb1RKT0F1?=
 =?utf-8?B?L2xFT0NRVU1GbDRaOWxWbFJqUWttVlppMDMrWnZOZmp2MFJuZ1JjR3FmQ3Vu?=
 =?utf-8?B?aVlIUXp4azVMajhGT01Yb2lOMWgrNUcrckVtNEszb0Jmb255UTJOSHNsbE9T?=
 =?utf-8?B?OHVWYVM3NWgyQlA0RDVDMTVCaXB1eDFDSG56UDV3Y2xHTjhHaGNXTzNaYkZq?=
 =?utf-8?B?R2JkMUtuWVZsenJIMVoyRnk4aXlxTXRYUEZUWUVpOHQ5RnNxTGs4U2xNQlZW?=
 =?utf-8?B?U2hGUlZBWm8xN3dVN3picjZ2dWRkZUp1aVRETGZsQ3NBb0xjeDFaQzk3eElN?=
 =?utf-8?B?MkFyeEY5aWd2REVuWlo1dU00dWw5dHNUbXk4K0lRSUxwcVQ1d25ISFdWR1V3?=
 =?utf-8?B?bDViR2dLVnJxc01vYXhxVU5GQ0FLWWpQSW96Mjh6YkF3YmxacGF2RkJkcFQ2?=
 =?utf-8?B?dFlQLzhaSXc3M1R6S3crbkY5bWxVZktpRjJpcmwzdmJ5UkZHL2JMa1NydmRL?=
 =?utf-8?B?SmpWdndhMHJNTElqLzhWZG5XcXlmZmo0MHd0YmRNdmV1L0ZSMTBoRzI5dkNk?=
 =?utf-8?B?dVNpWFhscGNNUFQybTd4Y1FKWU9zSVYrTFNQcTE4VVRBSTUwOG9OK0tpN0lm?=
 =?utf-8?B?cE1uWE5QVnRqc210SVF5Vlplb1lGdlM0bEUwdTVMNUNJSmY2Qnc1VnV1MDhy?=
 =?utf-8?B?aXd4bGhqZVZORjZCT3VlMHJBTktFaGt0dkN4NHFQb3EwbklQeWViczExdHB5?=
 =?utf-8?B?Z3JKWmJuRlEveDNQb3ExaS96OU5wSUFIRmZ6YnBqQTFTSkl4eWk1dlExQTJl?=
 =?utf-8?B?djZHcjFaOFJxcnY1VmtrcHJ2RmwwT0cwUFJYNG5xZGpHRGpIajdaZ015emdi?=
 =?utf-8?B?b1JoNWNkclgzNjFoUmhzRDFzQ29iNW8rZVE5MnVSWlAvSjVvdnhoR3NsRUVz?=
 =?utf-8?B?UFBXN3ZlQmJ0Z1RzSXJKSWNTeUROSGo0RHdGaElGenI4bi9sdVN2emdZYnVU?=
 =?utf-8?B?Vzk2bUdad1BlWlNFc01pZDBKd3ZLekZrNmUxSEttS0paT2ZtSEdmekZ6cy8w?=
 =?utf-8?B?TXJ0NFhNNkJIRUMzVlJHMkt3RFFlbGd6ZmlHV0lOaUd3alptNGM4SW8ydFVv?=
 =?utf-8?B?MUdlNDgvMHZkblNxVEo1Ull6aVp1b0ZQZ2dRSkRZN1lCRGNrSGc2V1cycC90?=
 =?utf-8?B?ZFJpbExicEtORXVZcFFYZDN4OEhmR2xuR04xRXY3bXN4VnhaL05MUEVvbXNt?=
 =?utf-8?B?ZHRDMmU3bS80UW1wS21mWGIwV0xkbU1KWHllWUdhNUVUclY1d1BLMm8wanR5?=
 =?utf-8?B?Z0ZtenI2MEpjSXZ0WnFXWkROY0o4WTFQamRzMEptbkt3SFV1alY2TGh0STJR?=
 =?utf-8?B?RTdUaWpIQytLaGx3YWN1K05PUUFVZk5zbHJqakdob09LL1hyT01ub1IrRmVw?=
 =?utf-8?B?RXRGOFFPbEVHaXNUeEgvV1dtTldQMU9SdGZWT3JOQjRUcVZoQVZydlFoME1n?=
 =?utf-8?B?cStmWUpmaDVabXg5TzJKT0RZUGlUUkd3RlpGdjNKSDg2S3RqekxkMjVBeTJ3?=
 =?utf-8?B?R29GVE5IQUEvRzUvWitpODdwbGxncDlRbEtOWm9JTXZpUmQzQ3dvSW4relJo?=
 =?utf-8?B?eStFZ1Y0RnVOSnBXZDZkNDI2UjkxUjRZbkI2SjcxNHU0dm8wcWczajVPOHls?=
 =?utf-8?B?YlphVmozU2xFVFpmRGFhamZ4RkRCRXdOTk5IRTFuOGNFd0J4Mm8rdDd6SWVt?=
 =?utf-8?B?Z0djWDh5RmN2c1BuRVJLVzVTem1pT0N2R0RhSFdJMFdheXVHZVExUXpoeWJn?=
 =?utf-8?B?Qml6WlJDU2dIaEpFVWRoMzVnbU1tZ3dSbDNtRjVncjNERWNpakZqK0ZZV3Y3?=
 =?utf-8?B?Kyt3ekVpWEZxb2NMVGxXQ0IwaVBZcG9lb1JTOVUyd09CVEFjeXQ3aWtUL2Vx?=
 =?utf-8?B?NDJNbDFEK0FoS2JSNy8zZDMrNm1hbXo5ZlNpUFlpbU5YY2NQK2FSTjFyc0Nv?=
 =?utf-8?B?Vk55eStWeWJIbjNuUlJNSGNyeHR1NHQyQjVSWllOS01jeGp3WitKOHZ5bG5n?=
 =?utf-8?B?TjFadGViNmQreG9jajMvaGo5UWV4MngyZThHcUhBU3VCY1FIZFlwM0cxNWgz?=
 =?utf-8?B?b0tnQzYrMmRxR0RnYU5LWnd3MCtDNVhnKzMwQjJwbTA2VDVldzZvRENqYURF?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2vyJVCnXu65V75H8z6F4JcEYBOA5VBPKMFKJZ998l+j23wjjR8rR/zpGQqbubpa37JGftqjL9ykCTGk79oUHS9FKk7noDYAkSU6fl9WXbsCDigg+5CTVaRV7rU6KdNjkRBzxKKVd6Hdt4/TYW0igH1iksbIEKCjJ3k/DTOxOZsFmIe8HZH3tlP7eqJI3DTeifXDrxdGz3cAY3rTJcCBD4ZXIkQenDgr9ceTTQKe1eWitoLZyMMpJGJxl86nlGq0hY9DISZpQIKiEX41u5Bnc6kcRQRIqEdkiey4sRLH7PAaXrDa3wActvlXuaJHgWwwZy/AbN2sEIPaCZ1BDUzZXeaxkKT2kmGh8RC5RdqfHC0LeVFKOISAIv3qLWc7MF967siir8HVNctxUY9Q7+297p6fR8RiQ/YDTbQlnR3b4sGBroQiGnoLPcfjc5YIzZR6uhxV7FBvVSJbd2TEOm16jOV9ZYfl3TgR3RgEfMNm/JrzrrIGGPBK7TA4hTTmA1ODOoY30dunAGnEr1EVDUj21zkJ5GcT10cQ0MzgH+z4Ccz2RA2//p7iakKxIM9s408YwQk3tLU4h1wk+Ot6xvTCu3VNm88vNxhv0FnFbgYf5D04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c26b04-7e7e-4fe5-059b-08dd54c62941
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:27:03.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDpVfXCVN05DTS//cRhvcJ0yTJtxphpN/3LB1Vdc4kSMJLzD3+OgX4n62hqpEDhxOLfa/vCNNrC1mDwDP8zg8oyfN38d0fyO4l1fZdDgSwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240083
X-Proofpoint-GUID: sIHIyKCej3Tr-VIyM6ghms2ny_UzT_Iw
X-Proofpoint-ORIG-GUID: sIHIyKCej3Tr-VIyM6ghms2ny_UzT_Iw

On 19/02/2025 03:48, Jon Pan-Doh wrote:
> On Mon, Feb 17, 2025 at 3:29 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> With this change, we increment the stats when we iterate the recovery
>> queue in ghes_handle_aer. Is there a possibility that in the GHES path
>> we would increment the stats twice? First via AER module (aer_isr) and
>> then in aer_recover_work_func, or is it either/or?
> 
> It's either/or. aer_isr deals with native AER handling (i.e. by OS).
> However, AER errors from GHES originate from ACPI APEI (i.e. FW
> notifies OS of error).

Ah, OK, that should be fine then, thanks for the confirmation.

All the best,
Karolina

