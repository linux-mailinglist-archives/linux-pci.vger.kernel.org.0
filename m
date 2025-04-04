Return-Path: <linux-pci+bounces-25287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60205A7BA06
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF57A9411
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB421A8F79;
	Fri,  4 Apr 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="doEFaeON";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wEeuB3AA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B031A23AD;
	Fri,  4 Apr 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759243; cv=fail; b=ko52JJNYWjpGdvCueEle4TYXdQbaE+hMTjpI4i8b2CPyFpnjp+80y1I8DC0qd4XUi7INNuYW4ywilBoftogAP/mMILdvCEG8qnzjkeYrembGO3KFqJfkl61BfhzFOb3mKDo51vcll9nmzYbFw/ho+hwZqTMvhO6zGfOkQRuQ2aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759243; c=relaxed/simple;
	bh=U9iKNyp3qj5vAuAYGI1JdCoJoHcqBO27v+uYj1xM60w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZyIkBD6nZ8kCGZ0e99kXkhqle7V7Fb7fevk3h9+Jy0nXZmRG876zopFhwN9mAxTSazIpl274exXOqYxRoRguFRWRVMezWlvZdL+oVn3T5Gz0Lzb82yKai49krcgKlpYqOvdYhvyCLDAaxb04nESIq7I0SJretQAL5zB2+Wn4gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=doEFaeON; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wEeuB3AA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5348NAS2024398;
	Fri, 4 Apr 2025 09:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OT7WaLHn8vSgPk/eAjKsOdufxPczstsikkennKu4GAg=; b=
	doEFaeONmqQhjEy/5ap551jTPc5Y8jOOA0gHZ9QF/ohFmF7RgJds6MaMaLq7JPIq
	g/un6P0CWxtU7wtD9NwmSopb4PwEAh0qdfg2T83deLmUeKrbU0zK9fO5FiNc72Wb
	izdMu1pg8SIbtj/CgD2IxXr1Qon5KVAkH00b1uMSAwLzZSMU4aY21eC97gpgy0XZ
	KeqBIyoQDtzBjHJXiZPKHzIkTpnbpxkVQx0TY/o7S/kl5YGxVcLXumLJTHI6FHQV
	wj85nycRJpQe3HJxG75V5dh1UKmpoEtxMEIuEAjIOKwANtAtwaGYuwHWIWwctuVA
	Jnr/VeWaf4GEOgO+LkCP9g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7saxp7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:33:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5348huGx022433;
	Fri, 4 Apr 2025 09:33:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2ykjat0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:33:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPkWGo4FHsBet6oP2RgYM3HfKOP8KZt0RYJ43zwkRAZHmz3Qw1NyvfUuYkVaLKNjLxwS5qqzq21eUmMsDZ1OzvAS7u6/akD4C8Elfi8GNiXP8JipwnZXEFGJtbs9QSNswJapfPqbfjkDRrBp+jB/HVZsj53GFFl/zQLrZtpWCUuQ9WFmCOXBn/LhBBkzemsz8L6g5YRgVP+uU8a5NFIhsjRHT6V56AnJfCbPIvVOvauxGaBF8gngkgeaGJfbEl08PGnggmRoOJP98TU2O+1HFypXEUEO+lzsRjRGePfXpwfQU+DrnfbEX9goRrYQSHfasExZnWkO5NYvIEsD42B0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT7WaLHn8vSgPk/eAjKsOdufxPczstsikkennKu4GAg=;
 b=YJO/yDkCQSseaCfAtmGaTIkM+X0b6qG6SC7th2FNFNvbdo4SGfuHcdgTtt5yNFN3yIJGIJYW1p1IYJmUMPiHegeU+g9OGsiZbc99nBAoCLSsodN2u37WNaZj9uWDZBXkMy0HneUuoIylaZN7E8sq6xgn9BCDDGb8rMByWusrXiyevjScLLV79dRkEY7KBTcxZdOH6gsCOvB5FQ2Zxg2uBp/IefEU5/fF9BQ4BY42aCjGxDnAA1tDvhwQVKZ3Tomv78EhnsFLBoasuKa/CC+eszv+tim0q2dlqC6PfuSsyjZU2kc9Gxqazqb9G0SE5ew7N29j3Z1irzdTaQBZmPMFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT7WaLHn8vSgPk/eAjKsOdufxPczstsikkennKu4GAg=;
 b=wEeuB3AAg2jc8tw2gvXYTyfBR1KhdCPCJEo/GklCeGexLMXpul3xMmn4rq6r3mE06U7nBZGEHGSLtj5aVH9OMZFbtRm9xb63ytk6Un6mYV0bShks0aWGydr2Afth9qR9dzl5HSir24Jdrd3XOeX09JL9INTgvl2ld7LdpfR+7Ts=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 09:33:27 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%4]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 09:33:27 +0000
Message-ID: <fed73e8a-5d4f-4478-bf8c-c93a7e5fd1f1@oracle.com>
Date: Fri, 4 Apr 2025 11:33:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com>
 <CAMC_AXXPKsat846r==J_OYQA2j8kT-kZriuSqoH3F_nYEN8ATg@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXXPKsat846r==J_OYQA2j8kT-kZriuSqoH3F_nYEN8ATg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::7) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0ad4ba-94a1-46bd-076a-08dd735bc0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE1kc1JVMSthUnNtRXdVL3dHajBndWNZaWFWd0J6MGpXb1E2OVhPdTlWbGtL?=
 =?utf-8?B?eHFOWWRKQkR2YlBrRFBHUEZxYVVBVDVCUDZvUGx3Z1cyMDhXSFFibW8yZjA2?=
 =?utf-8?B?RjJwazlBWmxPYUZQL0RnQnVqTVBnQzROOC9XTC84M3podzlLWERpREJLSnR2?=
 =?utf-8?B?azJRVmxseE9jRm9Uc0pXOUphcGc5Q3hyNzYvd0lORzJmeFlPbnBZaTRpZzRv?=
 =?utf-8?B?c1lTb0JnVEVqdWdac2NmQTNyb1Jta0J0QlEwZm42NmNxMEUxL0Q2L3UzdDhV?=
 =?utf-8?B?MDF0SitnSnZLbWx1SjI0aHlWS3pueXB4RllnLzBWNS96c3BQOFdianZjTnNY?=
 =?utf-8?B?RFZSMC9NdEJ5VzFqVTdxMndoOEtGam9mY3IwZkVSamsyWjNuSHJjKzJ5aE55?=
 =?utf-8?B?YWlvSHNLRjRvK2t0MG9iNEFnSE45TE43N05acVl4aDdNakYya0VKTFFveHEv?=
 =?utf-8?B?elRVMUhuVmZqYm1sUzM0UHV1T05OQVdWS1EreU1PL0FYaVlqR0ZqQjd0N3hy?=
 =?utf-8?B?dURaY3lGMWRCZWlYWGhkcHBYYitBQ0g5SFEyZTJxMlZPdmRUTU55ZEd2MUNa?=
 =?utf-8?B?U29ubjN1RzVyL0pLSldOM1NsZytDaGUvYS9uanZvSDRKQnEyVnNoTE90ZXIw?=
 =?utf-8?B?RDE5M2VXNVhSVjBVTFhYVG9WMHptYWxpYk9wYVdEUjhhNk9mVkcxR2FQb2Zl?=
 =?utf-8?B?R3FSR2pTZnFreGJaSEhNdzAvTS9FcGd1R1NHYm1ZRGQwQTBtQ0NKemRnREh5?=
 =?utf-8?B?ZHBIMU1MRHNXVkdDWDdYRHMxMC8xSjE0TzF6MnA0Mm8rUUl2Y2huWkhodEhO?=
 =?utf-8?B?S0traHRTVW1Gc3IweWZLWFBJQzJuUVI4WFBNQmFnSHZKY25aOEltbGZURFBt?=
 =?utf-8?B?RHB6TUs5ZEJZRmJnQ2x6akRaeEg1QzRCR0N1VU9md1VOQ0RHMmtNUmg1QUpC?=
 =?utf-8?B?VTZrWUZDcHlySVZhT0tIYk1Memg3blE5SHNhT2NOVE5pY05Kdnh1WHNXRVhm?=
 =?utf-8?B?c29xL2g2STAyOWxxaG5SYkNJeWtibXZKSkdTU1lmTU1lM0hXUm9ZaE9hS1Ny?=
 =?utf-8?B?RERUUjNIUlVBY2Jmb0xubkpmT0YzcDVrWVdCTUJrQlpCRnFZUFlhZlM5dWJa?=
 =?utf-8?B?R3YzbXNqN09lNlU0TkRzT3pvSU1nUEViaE5DbkhaMVZtdDlkWlVhZDMwQUtG?=
 =?utf-8?B?aWNDNEFHVkREUndHcHU0a3k1QVVJUHAyY1B1VXN4bU52WW5sa0s2a0o5NzAy?=
 =?utf-8?B?aVhpNHUrNllwbklrQ2FERTBxeERweGo2WXVCQldTS3FkUENsaTNuSlZJK040?=
 =?utf-8?B?QmtrbDdqQTV6TTVBTVBUU1NiNDljTDFGYzVncm9LWXdnTWlYYlQ5a1E5R1Rp?=
 =?utf-8?B?TGdBTk9IT2hWektILy81cDVMY1ZxSEE2T1o0TE5mZ0oyVy8vR1R4bEY3dzFD?=
 =?utf-8?B?MXcrQXdwd2lPc0xSOE9QeVN3NEYrcjVZbGRzalNxVklmekRQb2ttM0ZMcnRK?=
 =?utf-8?B?REcwNXUvV3hIaXlCdXdvTXZsODZYdEhIalJQMjQ3RXRHTGI4S3VDVmJmNFhL?=
 =?utf-8?B?M3gxa1B0eVFtZ2ZWekhuYjhaOTJLMloxSjloeU1hMVBQZVFTa1BVeHlzTkhQ?=
 =?utf-8?B?Nk5WQVIxWFIvbHYrSkFmM284TFNhZDd2Q0pkdFJySjJxYXI4alFnU0IrZjZI?=
 =?utf-8?B?UlRxNTBYSXZSTTJpR3RYOFNMSWpPOCs4OU54a25HdFNITSt1R1VrT1FjK1hJ?=
 =?utf-8?B?NWZwWVoxMzNUejFQNmxaS0h5RzBLdGZXaFowSjBWdm9ERzJtc1FNVjVhVDVl?=
 =?utf-8?B?OGFqeWNTOCthUzhBdXdPVFZFbmg4Y1JwNFc4b0ppSEJva0RJb2ZVSGtWTktE?=
 =?utf-8?Q?f2rLc7pk+tFYU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFJXdUgrUStiYjVLV1FRaFZXQ2owRklrTy9FaSs4MlZoYXJXV0gybWhqZ3Bj?=
 =?utf-8?B?cFNrcnVkSERnUGMxRzd2ajN3djlZOFpySi9UMTd3Vjg4UjFOKzZ4cVFkUWJl?=
 =?utf-8?B?R0JQZzRzT3JuSWJ2RXlCcmxMbjNTSDgzWlBrbmVYV1RlN0dBSitndWsvSmFP?=
 =?utf-8?B?Nmo1Nk5PY3RqOEFSYm9vSVVDOGwwbW1JRitTMjBXVlE4Q01nWHJDM3ZyMExO?=
 =?utf-8?B?OVdYMUhmOXVDR3BIdEwwa0NFQlhPeDRvUm1CSUxUcHUvMm0rMVJ2OEMwd0M4?=
 =?utf-8?B?NXN3dEpsUm5UeThIaGozYVRySm5zYVQyM2pTam8vMmE3Nlk4dERBMDBQWHl4?=
 =?utf-8?B?OWp2d1lZbU9EMEZHbndHeWlJeUJFeW9hMGdIRWo3eTFnQ3pEcVR2MzZvMTVS?=
 =?utf-8?B?cDFyOU80cHMvVmI3MCtvSXRYWUdoaWFGcUw3NC9TcTUzcDhYaEJ0L1F3Z1NQ?=
 =?utf-8?B?QXhKaS9sUGYyMTM4VzZjNFhtQmhIYXNTVXRLYU5udWthd3E1ZUxPcHdsZTZm?=
 =?utf-8?B?MDhnSXdpQWVETkVKMm1nL3JzaHZrenIyM1Jla1E3ejE1MjBZZEdZa1hFNEVQ?=
 =?utf-8?B?MzVCT2NaVm9EQzhlRzFmRXpKTmZnM2E3UUpuMWgrTk0zR3FNVXZDZXdVaGla?=
 =?utf-8?B?WkE3UjhKYmtJaTY5S3VXYVoxVWNFL2pvRmNJVlJRUzAyK05DcWszbDdFTjcw?=
 =?utf-8?B?dGdEc2ZUZVFWY2FGTHp3Ujl4Y09zK1JwamVJYnNwWUI3bmFJMTBJVlc4Ymto?=
 =?utf-8?B?SVQ0UEd4TklPTGY2UWFGanB2YU5BbWFzdkZVYW9rUDhlYS9Xa0lkbnY4eWZl?=
 =?utf-8?B?Q1NHTFJIWjhoc2Faa0I1RVg3NDNFdm4wbzdmUFlkNXhFMmdUN29oajlHVVRX?=
 =?utf-8?B?ODk2bnU3L3BIQ1RyOE84N3djVFVycnBDSG5MZW1Cd3NvODVpUmRldnZjTXhi?=
 =?utf-8?B?aFBVZnpCVUtNYnh2bGZ1elNoeUE5TEFuc2R4b0JjamRRT2xrbjZlRFhvYTVP?=
 =?utf-8?B?MWhhZ1FneU9HVWJQVEJvZEp4WDdNbXJIaENhSEp6Z0VkR0FwL3YxOWhIcXA2?=
 =?utf-8?B?WGpBcFdNOEo0TFZHeGxPSFQ1TEZ4b0Frc20yaUpsWUlvRk1SSmtmd3o3em4w?=
 =?utf-8?B?TSt1SHBJSDJzcVBpSWlpMC9HNEduMlhUdXBkMTNVK2RKWHRqMm1qS3JrYktR?=
 =?utf-8?B?b1F1Smo2WHVTNUlEQnM0ak9ZWGJnelcyZWQ1OFBIcDIxMGVWdXB1NGdnTDRP?=
 =?utf-8?B?MTdXSjJlL1ZDNXJES0F2ZzgyYWpYSHVseUMyMklmbkp6UEJZM21QWE1BQWlI?=
 =?utf-8?B?elNJSERURGlBbHlzK2hxVzQyR0dGcHQ5NGd2RzJoc3kyUm5FV0p4YXNWbjFl?=
 =?utf-8?B?ZGxYTytjSGtxL1BuMDBsVjkzWGltT2g1TjM3Q2dkVlFNQWdZS0JsdG9Nelcv?=
 =?utf-8?B?Z2RSVjJjckdBMi8rV1k1a2djNXhVbHhZa2pyRmE0MTVDcWtXUDJDU0xMZ1Er?=
 =?utf-8?B?S3A3aDY0ei9KSUJ5dWdmdVQ2Mk5yVEVFNjgzamFEbzdTVXpMbHJJYWxWUEx0?=
 =?utf-8?B?Q3piT3BkdDJUSEtnNVpuOVJoVUVqRXdxc29OT1RsWURGQW43eEpZU205b2hz?=
 =?utf-8?B?TnJkUW0wWHhQYWw5RjV3aDgrb0J3OUhuQzd5UllQLzh6UmJMM1BmRjhBdi9H?=
 =?utf-8?B?Z2tobTRHbWloQktJV1R3TWxKaWhhSHdaRXBuaXZrRndSYlgrbUdnNnFmUkt4?=
 =?utf-8?B?L1h0ODh4NkhBSklPeEN2ejRkUWx1V29DYm5VQ2ZmamQ1Z25xek4vSUJJaGpl?=
 =?utf-8?B?bVl5dHlNemFVbG9YUWdZK0c0REpMbW9NN2dWUlpCUHB6NTI0VzRtcjFZanE5?=
 =?utf-8?B?TkdUVEh2UmQwWkx3SHAzTUN2THFmT01nREdnNlZLQjBDcnhxWmMrQVJ6cE10?=
 =?utf-8?B?aExQcEtIUHRTdnpTNzIza0xvV29SdGJJdVA0TjlRMk9QWmM5UEorZk54TlZ1?=
 =?utf-8?B?NVI3ejYzK2lkc3VZYmlVWUI1N1VpNUpjT2k5dXhRS0tEbWo5a1B4UVkzYTdZ?=
 =?utf-8?B?aCtUaFgxMzdQWUozVmFvMTgzVjdWUzVDR3h1VU83dDVIREc4RlFUTjN2U25n?=
 =?utf-8?B?Y2d2eVI0ZHdTaTdxM2pYbHVMWkdUaVRqaWQvSlRLWm04a20weHovbGNSNXhU?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G4djEtoPg0YguZxrWn0PnSOgTeGzn2DVfDc25tt6pL0hAM8m1qtVW0p8nGA6WdT92cjplPScQWnfDrfmB3vsye89Kpbn4azuhAVFzw19OXft2iTlBDk6h/76VJxdtDOYy7+mZQj359NZtN04Gt2ZASk9QPO+MEFga3n9YkHY4GBODDjU+iYiHaDxyG8+3hJnxn9dv8Uefb/pj+gvA2yvX7zJWsvvwoqQAtIrA8ZaMsxUH9zX5rEmk89kSGOwLI59yw7oxlhZTk7gzpW5LAVXpbjhiBGrDmQag06DpY8moZuXpEvBwWTdNZxReqhRM+qxYZr2uLLHH1EO5+WPI8YB63q52xKyKhxtNXMoyADFGEtqh1rKlDaLt7MO2qHBM0dVtKkb6YjQofe2BoTHoGT7h4wmkWhSJUwBBHdNdT570p8dFhyny43ci3aAU048Ps6ql4vxOoBYGyaVTPBXBybwLgHyYIzd4sEEyl4ls48ha9c1UvYecAyOiIzF5wLcwUvcuzE1CSkr97AkdSJYp/Sq40Pbux7oBkGQl0OYpONU0lcMj6e8SumrOeDjMq8afPYDermBo2CdwUjdVoh+6j7DaovK4d2Q4Yj2xdLhqJBc9Qg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0ad4ba-94a1-46bd-076a-08dd735bc0b1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 09:33:27.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze8jV/UsirATAsDWW9Lje5iEMB/h75y03dyxHLQ0LXZIzaUU19+7IIGU7ADgVl3ERasyBgKrA5QMB5AeGkR47f5wvs6CbUc+97Fl36JY8XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040064
X-Proofpoint-GUID: jf73c2NpL_ouPjtrDsvCYsv-cWSryWyq
X-Proofpoint-ORIG-GUID: jf73c2NpL_ouPjtrDsvCYsv-cWSryWyq

On 01/04/2025 03:47, Jon Pan-Doh wrote:
> On Tue, Mar 25, 2025 at 8:08 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>>
>> +static void populate_aer_err_info(struct aer_err_info *info, int severity,
>> +                                 struct aer_capability_regs *aer_regs)
>>   {
>> [...]
>> +       if (severity == AER_CORRECTABLE) {
>> +               info->id = aer_regs->cor_err_source;
>> +               info->status = aer_regs->cor_status;
>> +               info->mask = aer_regs->cor_mask;
>> +       } else {
>> +               info->id = aer_regs->uncor_err_source;
> 
> info->id isn't filled in pci_print_aer(). Is the addition due to
> aer_print_error() having a conditional/log for info->id == id? From a
> brief look at the code, FW-first (e.g. errors from GHES), I think it
> will always be true. However, that doesn't always seem to be the case
> for CXL (e.g. when cxl_dev_state.rcd == true).

I just went with what aer_print_error() expected to get from the 
aer_err_info struct. It's possible that this id check is not be needed 
for GHES, but I thought that as the values are already in the regs, it 
wouldn't hurt to extract them.

> 
> Disclaimer: not a CXL/GHES expert though.
> 
>> +void aer_print_platform_error(struct pci_dev *pdev, int severity,
>> +                             struct aer_capability_regs *aer_regs)
> 
> I like the encapsulation.
> 
> Reviewed-by: Jon Pan-Doh <pandoh@google.com>

Thanks a lot!

All the best,
Karolina

> 
> Thanks,
> Jon


