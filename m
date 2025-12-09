Return-Path: <linux-pci+bounces-42804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D036FCAEA28
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 02:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E0B301A1B5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A6B2D1F64;
	Tue,  9 Dec 2025 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="Z1X/L81e";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="Z30jJ5HA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C5226CFD;
	Tue,  9 Dec 2025 01:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.147.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244288; cv=fail; b=MF3WWFTJUO2yEF+680j5wF0MQGOW+h8smOOxI10OQ8UrsRQhoaRPkvNQTfoLKAurYEncjF8QQuVEAuBREwipdrPuZxN3hMtZicLjr4csdhduP+lkEK6N3bXN5+eciuYfqu+KABo+78+AgbjsZYxWQRiz/KRTcR7nMCXu5MoQh9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244288; c=relaxed/simple;
	bh=/Q411Jae9w/fzEcfv7TEPMlfh84MjZfFmrYNvsDhh6Y=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=IsIP/OdjaanxKmdnghlwiCzWltIU+IPEtBI0oaJvhceuemrNafZClRZKhcRciilLs3R5IVVH2GVTMcnQTCv2y5TddpEWevSyoWMUaZwEOtGg0R+mfFYeUi+LryZZXT5Bn5UkES4qYB7hDf9AVbwNRCTIgRl+wAkyrVKXhT+qY0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=Z1X/L81e; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=Z30jJ5HA; arc=fail smtp.client-ip=67.231.147.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0422211.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Jfw9d009130;
	Mon, 8 Dec 2025 17:05:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date : to
 : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=ZbuJTm4UT7sw/eRHbhRruT4rmSSupSE9B0JUsTY2MK0=;
 b=Z1X/L81efo01WpSEO5I21Qtiv6hz+Ln5zbWlzIMTmeNxianIHg1ven9pkR/HmaDCAsve
 GI/9LZR3tutFhBus4+xTOd2t8lvpciagLKdxVaPlpLqD88kZy5csXbAnph7a5aUWdOQe
 TTDgIBY/qCs7lWL7roI1EIMZqDtWIcoecxsnSbR2FgxcSIhS2NgJAht0uAfjRu+vlMZS
 PxkYFKow7uHoSlYBALr4aiNuOa3kVipywJ/1hTuxfvd4O+SKjnbR4R79a9N/rQDMTybK
 hvEM7+QwV/SH2Hrv3MmHDFtymYYjzLFYAItdtriV6ItOx6VYZ2m31YGMzY+6k+ejTtYY Mg== 
Received: from by5pr09cu001.outbound.protection.outlook.com (mail-westusazon11011029.outbound.protection.outlook.com [52.101.86.29])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 4ax52b8vqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:05:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqKdHF/WgemAQcL+tgNYL3vfUbki7KFNhiCpoCD8GJDMl/q922ACE5Je4YneJDl0JObbIvm4SySVRmSq5mGh1A7ypKieCT4olYGHRCZCiTHQphiuh7N+dFZpw9Awaj0aNCJn/5MFTvnJEfbAvcBghsfAOfqmD0eamQ+ddP9GvvC5KT8BqNWmjcYK/hKkA6HUjsQ/oQT7sdvE5vN8dBBJ0hwQ7dhhY0fsBqn7C40gwOKzlEqWJ1It5GNL9+umzDdxTd5r160s/oh/tHF/juph2FW85i274aewRK4ys8cNLyuOYL2bN2pWL9pg/S+kDov3KxFy3SGhh7SPmL+wqPJ32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbuJTm4UT7sw/eRHbhRruT4rmSSupSE9B0JUsTY2MK0=;
 b=BdmhPpsC5aKqohaBrJZtiw7sEtfyHkpQcLynkqHMybZjN9w5bxlZRBusGMYQxXArIquNS8kTJUViQzRN3SHG6r1ECPW+5McZP2IT8S0wCzCBaujRmXI2C0fXPFQ2yVg8R+up9+3EH6L422SlnMEuIcnKF9FU2q/OR+J7HMV1XQDyhU6jA2m2Dc3ot5pJH7B81Jenkd3eTPcYCshxaIsDqWnQnYcaxUJN0jWnCqaNxhzQugKKnlVp4GvI/4nOp0iapnk7yyEHzLvRZ6Rxn2NNJ63Xk9AyR5AYVe2gr1WkSL7oUUPMwVzuGMpK0BUHVlGvdCF3k9BpSed8ZXMBzSz30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbuJTm4UT7sw/eRHbhRruT4rmSSupSE9B0JUsTY2MK0=;
 b=Z30jJ5HAoKMTBMz6hU94C0ZC2JQlVb1v9DNxDwyAmO/5QUNi0ZCrekIYTRa4XIbEwMaGbcXvYD1Za3x9SQ1Sv0Vb2dY4Bpg/h0w6MgYD0lC8HQtkUeI4Y6M+RSN3Ua5G66kvbOVZvvutEPKBE9ilVEFxtwV9RDo+oQkB4W5XwGI=
Received: from SA1PR09MB11481.namprd09.prod.outlook.com (2603:10b6:806:372::6)
 by SJ0PR09MB11078.namprd09.prod.outlook.com (2603:10b6:a03:513::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:05:27 +0000
Received: from SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::f6b3:25b7:844a:6d8a]) by SA1PR09MB11481.namprd09.prod.outlook.com
 ([fe80::f6b3:25b7:844a:6d8a%6]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 01:05:27 +0000
Message-ID: <d422a22c-a6fe-4543-ae16-67d64260e0cf@llnl.gov>
Date: Mon, 8 Dec 2025 17:05:26 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: corey@minyard.net, alok.a.tiwari@oracle.com,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org,
        linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v7] Introduce Cray ClusterStor E1000 NVMe slot LED driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To SA1PR09MB11481.namprd09.prod.outlook.com
 (2603:10b6:806:372::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR09MB11481:EE_|SJ0PR09MB11078:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6a7f24-d5fd-4f71-2aee-08de36bf0a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkE2OUVkRUQ2bjg4eEZqOWh2blZmNzdRUEErNHoyWE1VbGdpYUhsKzI1ZDE3?=
 =?utf-8?B?Vm5PS1duNXAyclAvY2c4KzQ4ajJtZzlDZ1ZzdnNrMWFYb3hienFVdmNpdXdH?=
 =?utf-8?B?Vjc4dEMyTndVci93bE5pRkl1K1FvVWpxcWZqU0Fhckg3R0Y1ZjVpd3VUNEJX?=
 =?utf-8?B?UktPYVRKeGtoZVFNZmVyLzRDejdSM28yUmJnUndWcDRWaFo5RlFHc01Vd2or?=
 =?utf-8?B?N0E0YVZoQzVBQUthbVpmbWZrbWpQS1FvWHovZHg4MXJNR284RlhCZXJiZThs?=
 =?utf-8?B?TCtubUdmYjlTVURsVWRNSC9LUUgrazg0dEJPaUNjU2liajNDaHV2dmUrd1BS?=
 =?utf-8?B?c2lHenZ2MHhkQzhDSWVKSlA1RU1ta1lLNFBxK1RSUEFRL1poTUNFMkNOWlVT?=
 =?utf-8?B?MDg2SXNnTWdOVjZKNEhkME15d1lDUTBHZ0pFZFNQSVJKZkpBRnVJRGxmYnlI?=
 =?utf-8?B?cGkwVXo3RUE3RkpOaC9CLzg1elJhTlI3MGFtNDE3Tlk2ZzhnSHhSTjFVV2Nt?=
 =?utf-8?B?aXpvc1d1aHZDbmlwT21TdWp0K3duaXZTU05WMGxWWklqcVdXVTQ4SVFyb3gy?=
 =?utf-8?B?NUdVOFgrRCtITWRtV00zK0g3Q05od3VkcWZBNkJKcEE2OHMzTXc4SUxib3RW?=
 =?utf-8?B?clpQM1lmbk9lZnN3bjMxTDFyb3REQmE2MzBpWjE0SjduOHNFWjQyMk9pQVMz?=
 =?utf-8?B?R0dUR1NNaUlObWt2NEFEVXAzYzRZaERXd3NIalBtMGVYYUdEaEFSYXZGYUlK?=
 =?utf-8?B?d1JEMmlONElRRzJ2eTFsWENWaDJJZEdGQVpZa2VuY2x4Z3NPT0pENGJpRGxP?=
 =?utf-8?B?amQyQXVEVzNJYTN3Ny9mVFVTZ3ZYbUpKaG13VDQrQ1NjUS8wZGpQSFhFaGRk?=
 =?utf-8?B?eFllOVR1TjM0NHlweEJ3eXE4UVlVdjhBaVdPNVFvTlA1aWdOM3JGVzdjd0ZB?=
 =?utf-8?B?SEdCYldYcTZiWkNzMHBKZ0F0TEVwdEVMWHpWNGFveW4zOVgxWEZWckZmcDZ4?=
 =?utf-8?B?WVZBTWM5TzB0MjQ3cHI1R0doL1p3RXQvUFlSMGFDUFJaQ3lxU1J2NWxMc0xh?=
 =?utf-8?B?Mkl0bzRObWlrN3NJR2ZpaFRKb2RoS3hZaGUzQmNxL2F4REN3TmorZUxhY2o5?=
 =?utf-8?B?dzV4WDVDaDhBRlRYREtZZU56Z0FKeHZUUWEvTzM3SGl2SlFvQS9FTVNJanp1?=
 =?utf-8?B?RVRTcXRuQ09wWkloYmtLalRWSVZKbGlSeHNQVmxTMDBMRTFwOS84bUJ5dnlK?=
 =?utf-8?B?d1FXVWx5NWpBMk04K0dRbG5YcUhkVTdQVjE1NThoL1dhMnROaGgrVmxSYkU3?=
 =?utf-8?B?TDU1ZW1tNGZ0NCthRE02N3BDdTJqN1BudGM4VnorelUydTRkUzhpWnpmdU1V?=
 =?utf-8?B?MXdYU01jVHFHRDVzYlc0NlF2OFdQUmduZGIwdDgwNG5jVE12SmJFdjRRNDFw?=
 =?utf-8?B?bjBwQlF4L2RQRVZXQXY4dzFWakhoaUpkbzltejJFajVXNFErYXlKRzkxUjlx?=
 =?utf-8?B?eDdCSitXZHJqcmk3WEtRT0o0Y0RNZ0NKTlFmbTdjNGYzb1F6UVpyY2k5cis3?=
 =?utf-8?B?dlRZSE5KY2dUT3c0SFNrcDZnNTNYR1ZCM0tGc0k0YmVpQ2d6dmd1OUVDUGhC?=
 =?utf-8?B?NnJxVWYraThoVThjVjNmbFYrdlBURExobFdTdjJUQW9SYWdEY3E4bDR3VGlZ?=
 =?utf-8?B?VWlHV29kWUs5ZkwvSDRXcFkyYkJYTjE0aFdUc25oKzdBZC9RZkpXZVNXcHVj?=
 =?utf-8?B?SFZjOGlBWnFXVDVpNmhZVUdpUlBIU1dXM1oxSml4WlcwVWJoQ05XQndkY0pC?=
 =?utf-8?B?V1l1ZGlaT1NDWVdGK0RKbENJTkY3Rk5iek54dVliRjMyQThrbFY5aFhYZHNz?=
 =?utf-8?B?emVJRmhOQXBMTFNXWlVzaG9oME4wbG0yNkpvUzZEb29mOWVoM3JsWGw2TzNs?=
 =?utf-8?Q?LSADdk++gp8hWJpPpyQQd44/libOvp6F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB11481.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm5QUjJuTXFsZTFKM0FZbUtvOW04NkxpOUIrT0F3dmMza1pWOWVzTE54SG9P?=
 =?utf-8?B?dTZjczZ3U2lDOGUrSC9RaUlrbUpRejBpeVFCcWJkUFhRTmZIOGxuN29IN3BP?=
 =?utf-8?B?TndDZTNBUFhQZmQ5UUJITTYwWDlxbzh1eGxQNHV4WWhIMGlYaERxUVNQcWVz?=
 =?utf-8?B?Qlh5WC9wbXJTLzhIdkJvTndQeDh3Q0U5MnRIUGVWMnZ0OE5INGFFWDZYL3lR?=
 =?utf-8?B?dlBGSnZZbGNDSTJsYy9ieUFpdEJkRDBTNmdpY0xlc0x5U3Y2QW5jZ0t1Zmov?=
 =?utf-8?B?a1FSZUt2cExYMmRTczRvSUhwUGc2b0FXZXl0WmdkcWV5b0VkbUNxU0plMk1O?=
 =?utf-8?B?SnRsd01heDVDay91aTIwSGJsK2dQS1NrQmNNSWdwNDlzTHRjaVNHYURJdmNV?=
 =?utf-8?B?S1IxSmphYmJyVlVoV3pPbVFuRExYQnhRSHlIVlhoZkQ3cmNmKzI4dlZrZlJa?=
 =?utf-8?B?Q2FPK3UvQ1FmejJwMkpiL2FIS1RGK2tHdUNSck4yWTI5NnlocVdGRm5OMXRm?=
 =?utf-8?B?WW96c08rZ3MreHI1L2pxdnlLS0xEODUrelgyeXQ4ODU4enowdUlRSXNUckZQ?=
 =?utf-8?B?dEE4UGdvNlhreURaeHFiQlF0b1kwSmI0bEFtcVF3bnhQN0xKV3BEaE5aajh0?=
 =?utf-8?B?NmFqcWdlZUVWeFUwdkdiUER4aDkvdFk1QTBqcXVTaDhnWitPRUkwZHE3T0h2?=
 =?utf-8?B?Mko1MHdPMEE3YTVVV1pTMW1tYTZtc0VzaUdrb3E2UVMwRy9pNFpMNml2YXUv?=
 =?utf-8?B?QWFET29HM2dDZ3lBQ2JiSmZXQ0VNRFlqN0o2UVJhSHpWQWNWL05RNmUraVpR?=
 =?utf-8?B?MHppbDFtWmQ0VlBFWXRrQytPS1JqRmM5Nkp3UUdxV25GNE92OHEwL25ZY2RO?=
 =?utf-8?B?cklJckI4dTZEZ3lCQVk1MitPQTViNStKekJ3MzVyeTREMGhYZlhtb2VPbVdy?=
 =?utf-8?B?S2trZHJmaGxwY1NqN0ZvM0gwWE5MTlhWOUkzSzVGMGp4UGFWdHZtRXhCaWtN?=
 =?utf-8?B?ZmFYd3RUbU4yMXFjTThXT2ZiVk5jQVJqeDE2VjZxdWRlOFh0QmhaZU9kVFd1?=
 =?utf-8?B?NzBTb0ZGQUhMNUt5TGRKQThwMmFqNUZhRUZaQUVEWU50QUY2QTVpWVRvY2tT?=
 =?utf-8?B?S1J0REZNWTFEWnJyY09IY3FhRWl0NTIzU1lDL05RdTFGQkEzTGJqNXkyUWVj?=
 =?utf-8?B?K09HbXFNYUx2VXY0K29aR0gzQzNxRFlKN2xiZFFycVdFVWVlZTJVTS9BZC9T?=
 =?utf-8?B?aHRrTElTVG9lNlVnR284NE9VRWlKblVOaGlYeHFBNzBmZW8wV1h4Q1ptRTFH?=
 =?utf-8?B?Qm90UWVLR1YzYXZNWFIzZ2lwT3ZiZXpZVmhSZWZpMnpPeXhSUVpUblFOM3cz?=
 =?utf-8?B?L1hjdVlTS0VTU0thT3c1WE9PWFRjUEdlZm9vNTZFRjliWEN3eDVCbGNhNzhn?=
 =?utf-8?B?Tmp0WW9ZTU1LN2ZKVVM3R0NodzlTcU9iVEpsWkl6QmtkNGg1dWtKYklYcUw5?=
 =?utf-8?B?OG83V2hZUFpaM0ZxWVVKK2JiSTZyN1JRSXQ5RWpzWjh5b3JWS2xXZTBURFRZ?=
 =?utf-8?B?TzdOTWlKRGZzT0E0anl0U281aDlKSW1XbFRmNFlpeVVzNmZwa3lRNWtQbGtl?=
 =?utf-8?B?SHFCaFUvQ0pYaUZkSXFDMjdVMnQ0N05MVlNycGRvekhOVzJJVCtCcWt5WGVH?=
 =?utf-8?B?OVY5ZFFWdTVpVWE1dHNUaEJ2Q3F2bnpNUm1sQTFpTnMwY2N3Nkh6ZHhNUDRk?=
 =?utf-8?B?TzY1LzNiTzg1MnhXZjg4eUg2TE8zVFU0N09GUWx1UjBzR2p3MXlSck8zTmZN?=
 =?utf-8?B?SWRrYSt3WGRMVVhJR200YjJBWVVPNUthTE5tTEc1cFh3aFdCOXAvdHFwb1Y5?=
 =?utf-8?B?K2V3TDFVQ05GSG5VaVI3NUhMbVhhRUQ2ZUU5djZ3WFFGSExoNWd5RjlhRUhw?=
 =?utf-8?B?OEJLWDJnWUhsRTM3cW15dGxoa0xvZDNOZmt5ODJzd3diVjFHYVZsZGtPb2Iw?=
 =?utf-8?B?YXlpNzB6ckdydVg5S0YvNjE1blRoNG5qTjdCZ21lMVN3dHNKUVpoR2pycGxj?=
 =?utf-8?B?Yk9xcnAzMjczajRvNEVGODE1MjYxaHplRGRMbHdHc04zZXlPVUVXREQydlRO?=
 =?utf-8?Q?nG8vS8ygQu1jRth10O452iggz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PBWFVpLSppEpmTlPO/XYAO/Bg8ENTdpz+x92vbFpY+JFoNwexBRiXRF+JVbmZtN2GfqLSYuq+xpPZFulb7VJYl89oC5egdDPMrdw9tBCG3ynRdvxEzJmRCmvvmxv7IPtb41hh9Wk97yUloRrNmXnhNCIG2J54g5j8Swba+0rC52BuMQ4skvlFmVxRoEYyASn7ERY8WTqj0pj14xpms1UgGFaJvA/Hd6MRBTxVUXzNGV/CeDRb8B68MqXS41pxZEt+yoo6hKTnlnjJJuVMRLAv1RXBDMvo16tpc+AhYE2jJ8CdgnW+TMgMZu96Zh53uNW/my4ctipqciCHnLlGp/mtDXOjAqIhiDgPgO+ZzZU8A/F+3MnUDyxTtv/TrgG1toOIg0MWlScnsW3zsI6vLAWqb23DiJp2hWQAKnoCvyUq8z6X/U2RXbCWiUR6y5UVZRdJi2W1DrHEYaoaAFIypoQr2RbYWtTUj1HbWENQiejrlqGiMzD4aTPQqOv4ncqnjj4F3L/G/XMF1jz2PX/DY0vso52JCshq/OfCDoU2CTHgLZ4N46V+cEjI2qummoxMvwe9IB9w5EFdAT7mn2CR806IPZzmeKWOajylAfPJjdfHGrgX9GY9xJFb6xH2eLkXUGDCRu+5IDFom88Y4VpyeuFSw==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6a7f24-d5fd-4f71-2aee-08de36bf0a38
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB11481.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:05:27.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB11078
X-Proofpoint-ORIG-GUID: dW9Z2C4BySAMzTImUiOnbpy82pg39uoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAwNSBTYWx0ZWRfX13fhBOBf7Z6+ ozL+rVFko3yx0Hwd/0tlj3j8U7rZcW+AfclKDpI+2aWB+AR5ZbXvObHj/06p7h1UHUnlpM5QEbK y2AXv++16/U2LUVKZpaIsA3bydBOpR1gUB/o3Kqwk4zyhKbYpD43UN54sfOgf35nnURphVzAQhi
 MwWg7yWXaBanEW73Z16Z3AOkiHLHKyBZC44peygnQtonN9R+htFFlgb7rcRbfEzGGIRL7BPjG70 iuXUlDkrmsVaMFLy3MixmArTZCUFWmr45dz0bRwFXaX2gg3NGyhm6kTrw+4pnHH4eJCkNwiK4D3 F5/7+WPMOvWtxPZ+ZZitx2XjWQ2Y4/LkNtX4HS8CS5ch1n4JJW8wUnShVg6PjPpLdThhwWSVs46 nWfWZBJq
X-Proofpoint-GUID: dW9Z2C4BySAMzTImUiOnbpy82pg39uoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512090005

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v7:
 - Update sysfs-bus-pci text from feedback.
 - Add DMI dependency to Kconfig.
 - Refactor pciehp_core.c to remove CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
   code blocks.
 - Move errno.h #include into correct alphabetical order.
 - Add comment describing the reasoning for the debugfs counters.
 - Move craye1k_init() call from pcie_hp_init() to init_slot().
 - Make craye1k mutex global rather than in craye1k->lock.  This enables
   handling of craye1k_[get|set]_attention_status() calls before the craye1k
   driver is initialized.
 - Do driver cleanup on craye1k_smi_gone().

Changes in v6:
 - Change some dev_info_ratelimited() calls to dev_info().
 - Don't call craye1k_init() if pcie_port_service_register() fails.
 - Fix stray indent in #define CRAYE1K_POST_CMD_WAIT_MS

Changes in v5:
 - Removed unnecessary ipmi_smi.h #include.
 - Added WARN_ON() to craye1k_do_message() to sanity check that craye1k->lock
   is held.
 - Added additional comments for when craye1k->lock should be held.

Changes in v4:
 - Fix typo in Kconfig: "is it" ->  "it is"
 - Rename some #defines to CRAYE1K_SUBCMD_*
 - Use IS_ERR() check in craye1k_debugfs_init()
 - Return -EIO instead of -EINVAL when LED value check fails

Changes in v3:
 - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
 - Remove ACPI_PCI_SLOT dependency.
 - Cleanup craye1k_do_message() error checking.
 - Skip unneeded memcpy() on failure in __craye1k_do_command().
 - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
 - Make craye1k_is_primary() return boolean.
 - Return negative error code on failure in craye1k_set_primary().

Changes in v2:
 - Integrated E1000 code into the pciehp driver as an built-in
   extention rather than as a standalone module.
 - Moved debug tunables and counters to debugfs.
 - Removed forward declarations.
 - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
   than using NPEM/_DSM or led_classdev as suggested.  The "attention"
   interface is more beneficial for our site, since it allows us to
   control the NVMe slot LEDs agnostically across different enclosure
   vendors and kernel versions using the same scripts.  It is also
   nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
   both slot LED toggling ("attention") and slot power control
   ("power").
---
 Documentation/ABI/testing/sysfs-bus-pci |  21 +
 MAINTAINERS                             |   5 +
 drivers/pci/hotplug/Kconfig             |  10 +
 drivers/pci/hotplug/Makefile            |   3 +
 drivers/pci/hotplug/pciehp.h            |  20 +
 drivers/pci/hotplug/pciehp_core.c       |  16 +
 drivers/pci/hotplug/pciehp_craye1k.c    | 690 ++++++++++++++++++++++++
 7 files changed, 765 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 92debe879ffb..8536d2ff30d1 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -231,6 +231,27 @@ Description:
 		    - scXX contains the device subclass;
 		    - iXX contains the device class programming interface.
 
+What:		/sys/bus/pci/slots/.../attention
+Date:		February 2025
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The attention attribute is used to read or write the attention
+		status for an enclosure slot.  This is often used to set the
+		slot LED value on a NVMe storage enclosure.
+
+		Common values:
+		0 = OFF
+		1 = ON
+		2 = blink
+
+		Using the Cray ClusterStor E1000 extensions:
+		0 = fault LED OFF, locate LED OFF
+		1 = fault LED ON,  locate LED OFF
+		2 = fault LED OFF, locate LED ON
+		3 = fault LED ON,  locate LED ON
+
+		Other values are no-op, OFF, or ON depending on the driver.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ac254f4ec41..861576d60a36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6543,6 +6543,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CRC LIBRARY
 M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 3207860b52e4..3cb84e5e13e9 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on DMI && HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver it is not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..82a1f0592d0a 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..3a8173f3e159 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -199,6 +199,17 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_init(void);
+bool is_craye1k_board(void);
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+#else
+#define craye1k_init() (0)
+#define craye1k_get_attention_status NULL
+#define craye1k_set_attention_status NULL
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
@@ -209,4 +220,13 @@ static inline struct controller *to_ctrl(struct hotplug_slot *hotplug_slot)
 	return container_of(hotplug_slot, struct controller, hotplug_slot);
 }
 
+static inline bool is_craye1k_slot(struct controller *ctrl)
+{
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+#else
+	return false;
+#endif
+}
+
 #endif				/* _PCIEHP_H */
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f59baa912970..10c081f29a14 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -72,6 +72,22 @@ static int init_slot(struct controller *ctrl)
 	} else if (ctrl->pcie->port->hotplug_user_indicators) {
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
+	} else if (is_craye1k_slot(ctrl)) {
+		/*
+		 * The Cray E1000 driver controls slots 1-24.  Initialize the
+		 * Cray E1000 driver when slot 1 is seen.
+		 */
+		if (PSN(ctrl) == 1) {
+			retval = craye1k_init();
+			if (retval) {
+				ctrl_err(ctrl,
+					 "Error loading Cray E1000 extensions");
+				kfree(ops);
+				return retval;
+			}
+		}
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
 	}
 
 	/* register this slot with the hotplug pci core */
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..d62b04c5beac
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2025 Lawrence Livermore National Security, LLC
+ */
+/*
+ * Cray ClusterStor E1000 hotplug slot LED driver extensions
+ *
+ * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
+ * It provides hotplug attention status callbacks for the 24 NVMe slots on
+ * the E1000.  This allows users to access the E1000's locate and fault
+ * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
+ * This driver uses IPMI to communicate with the E1000 controller to toggle
+ * the LEDs.
+ *
+ * This driver is based off of ibmpex.c
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/errno.h>
+#include <linux/ipmi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/random.h>
+#include "pciehp.h"
+
+/* Cray E1000 commands */
+#define CRAYE1K_CMD_NETFN       0x3c
+#define CRAYE1K_CMD_PRIMARY     0x33
+#define CRAYE1K_CMD_FAULT_LED   0x39
+#define CRAYE1K_CMD_LOCATE_LED  0x22
+
+/* Subcommands */
+#define CRAYE1K_SUBCMD_GET_LED		0x0
+#define CRAYE1K_SUBCMD_SET_LED		0x1
+#define CRAYE1K_SUBCMD_SET_PRIMARY	0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define CRAYE1K_POST_CMD_WAIT_MS	200
+
+struct craye1k {
+	struct device *dev;   /* BMC device */
+	struct mutex lock;
+	struct completion read_complete;
+	struct ipmi_addr address;
+	struct ipmi_user *user;
+	int iface;
+
+	long tx_msg_id;
+	struct kernel_ipmi_msg tx_msg;
+	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned long rx_msg_len;
+	unsigned char rx_result;	/* IPMI completion code */
+
+	/* Parent dir for all our debugfs entries */
+	struct dentry *parent;
+
+	/* debugfs stats */
+	u64 check_primary;
+	u64 check_primary_failed;
+	u64 was_already_primary;
+	u64 was_not_already_primary;
+	u64 set_primary;
+	u64 set_initial_primary_failed;
+	u64 set_primary_failed;
+	u64 set_led_locate_failed;
+	u64 set_led_fault_failed;
+	u64 set_led_readback_failed;
+	u64 set_led_failed;
+	u64 get_led_failed;
+	u64 completion_timeout;
+	u64 wrong_msgid;
+	u64 request_failed;
+
+	/* debugfs configuration options */
+
+	/* Print info on spurious IPMI messages */
+	bool print_errors;
+
+	/* Retries for kernel IPMI layer */
+	u32 ipmi_retries;
+
+	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
+	u32 ipmi_timeout_ms;
+
+	/* Timeout in ms to wait for E1000 message completion */
+	u32 completion_timeout_ms;
+};
+
+/*
+ * Make our craye1k a global so get/set_attention_status() can access it.
+ * This is safe since there's only one node controller on the board, and so it's
+ * impossible to instantiate more than one craye1k.
+ */
+static struct craye1k *craye1k_global;
+static DEFINE_MUTEX(craye1k_lock);
+
+/*
+ * The E1000 command timeout and retry values were found though experimentation
+ * by looking at the error counters.  Keep the counters around to troubleshoot
+ * any issues with our current timeout/retry values.
+ */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (IS_ERR(parent))
+		return NULL;
+
+	debugfs_create_x64("check_primary", mode, parent,
+			   &craye1k->check_primary);
+	debugfs_create_x64("check_primary_failed", mode, parent,
+			   &craye1k->check_primary_failed);
+	debugfs_create_x64("was_already_primary", mode, parent,
+			   &craye1k->was_already_primary);
+	debugfs_create_x64("was_not_already_primary", mode, parent,
+			   &craye1k->was_not_already_primary);
+	debugfs_create_x64("set_primary", mode, parent,
+			   &craye1k->set_primary);
+	debugfs_create_x64("set_initial_primary_failed", mode, parent,
+			   &craye1k->set_initial_primary_failed);
+	debugfs_create_x64("set_primary_failed", mode, parent,
+			   &craye1k->set_primary_failed);
+	debugfs_create_x64("set_led_locate_failed", mode, parent,
+			   &craye1k->set_led_locate_failed);
+	debugfs_create_x64("set_led_fault_failed", mode, parent,
+			   &craye1k->set_led_fault_failed);
+	debugfs_create_x64("set_led_readback_failed", mode, parent,
+			   &craye1k->set_led_readback_failed);
+	debugfs_create_x64("set_led_failed", mode, parent,
+			   &craye1k->set_led_failed);
+	debugfs_create_x64("get_led_failed", mode, parent,
+			   &craye1k->get_led_failed);
+	debugfs_create_x64("completion_timeout", mode, parent,
+			   &craye1k->completion_timeout);
+	debugfs_create_x64("wrong_msgid", mode, parent,
+			   &craye1k->wrong_msgid);
+	debugfs_create_x64("request_failed", mode, parent,
+			   &craye1k->request_failed);
+
+	debugfs_create_x32("ipmi_retries", mode, parent,
+			   &craye1k->ipmi_retries);
+	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
+			   &craye1k->ipmi_timeout_ms);
+	debugfs_create_x32("completion_timeout_ms", mode, parent,
+			   &craye1k->completion_timeout_ms);
+	debugfs_create_bool("print_errors", mode, parent,
+			    &craye1k->print_errors);
+
+	/* Return parent dir dentry */
+	return parent;
+}
+
+/*
+ * craye1k_msg_handler() - IPMI message response handler
+ */
+static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct craye1k *craye1k = user_msg_data;
+
+	if (msg->msgid != craye1k->tx_msg_id) {
+		craye1k->wrong_msgid++;
+		if (craye1k->print_errors) {
+			dev_warn_ratelimited(craye1k->dev,
+					     "rx msgid %ld != %ld",
+					     msg->msgid, craye1k->tx_msg_id);
+		}
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+
+	/* Set rx_result to the IPMI completion code */
+	if (msg->msg.data_len > 0)
+		craye1k->rx_result = msg->msg.data[0];
+	else
+		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+
+	if (msg->msg.data_len > 1) {
+		/* Exclude completion code from data bytes */
+		craye1k->rx_msg_len = msg->msg.data_len - 1;
+		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
+		       craye1k->rx_msg_len);
+	} else {
+		craye1k->rx_msg_len = 0;
+	}
+
+	ipmi_free_recv_msg(msg);
+
+	complete(&craye1k->read_complete);
+}
+
+static const struct ipmi_user_hndl craye1k_user_hndl = {
+	.ipmi_recv_hndl = craye1k_msg_handler
+};
+
+static void craye1k_new_smi(int iface, struct device *dev)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
+	if (!craye1k)
+		return;
+
+	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	craye1k->address.channel = IPMI_BMC_CHANNEL;
+	craye1k->iface = iface;
+	craye1k->dev = dev;
+	craye1k->tx_msg.data = craye1k->tx_msg_data;
+	craye1k->ipmi_retries = 4;
+	craye1k->ipmi_timeout_ms = 500;
+	craye1k->completion_timeout_ms = 300;
+
+	init_completion(&craye1k->read_complete);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err(dev, "Unable to register IPMI user, iface %d\n",
+			craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	mutex_lock(&craye1k_lock);
+
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
+
+	craye1k_global = craye1k;
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	mutex_unlock(&craye1k_lock);
+	if (!craye1k->parent)
+		dev_warn(dev, "Cannot create debugfs");
+
+	dev_info(dev, "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
+
+	mutex_lock(&craye1k_lock);
+	if (craye1k_global) {
+		debugfs_remove_recursive(craye1k_global->parent);
+		kfree(craye1k_global);
+		craye1k_global = NULL;
+	}
+	mutex_unlock(&craye1k_lock);
+}
+
+static struct ipmi_smi_watcher craye1k_smi_watcher = {
+	.owner = THIS_MODULE,
+	.new_smi = craye1k_new_smi,
+	.smi_gone = craye1k_smi_gone
+};
+
+/*
+ * craye1k_send_message() - Send the message already setup in 'craye1k'
+ *
+ * Context: craye1k_lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "ipmi_validate_addr() = %d\n",
+				    rc);
+		return rc;
+	}
+
+	craye1k->tx_msg_id++;
+
+	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
+				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
+				  0, craye1k->ipmi_retries,
+				  craye1k->ipmi_timeout_ms);
+
+	if (rc) {
+		craye1k->request_failed++;
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
+ *
+ * Context: craye1k_lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	WARN_ON(!mutex_is_locked(&craye1k_lock));
+
+	rc = craye1k_send_message(craye1k);
+	if (rc)
+		return rc;
+
+	rc = wait_for_completion_killable_timeout(read_complete, tout);
+	if (rc == 0) {
+		/* timed out */
+		craye1k->completion_timeout++;
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
+				u8 *send_data, u8 send_data_len, u8 *recv_data,
+				u8 recv_data_len)
+{
+	int rc;
+
+	craye1k->tx_msg.netfn = netfn;
+	craye1k->tx_msg.cmd = cmd;
+
+	if (send_data) {
+		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
+		craye1k->tx_msg.data_len = send_data_len;
+	} else {
+		craye1k->tx_msg_data[0] = 0;
+		craye1k->tx_msg.data_len = 0;
+	}
+
+	rc = craye1k_do_message(craye1k);
+	if (rc == 0)
+		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
+}
+
+/*
+ * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
+ * @cmd: Cray E1000 specific command
+ * @send_data:  Data to send after the command
+ * @send_data_len: Data length
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
+			      u8 send_data_len)
+{
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
+				  send_data_len, NULL, 0);
+	if (rc != 0) {
+		/* Error attempting command */
+		return -1;
+	}
+
+	if (craye1k->tx_msg.data_len == 0)
+		return 0;
+
+	/* Return last received byte value */
+	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
+}
+
+/*
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SUBCMD_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: true if we are the primary server, false otherwise.
+ */
+static bool craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return true;   /* success */
+
+	craye1k->check_primary_failed++;
+	return false;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, -1 otherwise.
+ */
+static int craye1k_set_primary(struct craye1k *craye1k)
+{
+	int tries = 10;
+
+	if (craye1k_is_primary(craye1k)) {
+		craye1k->was_already_primary++;
+		return 0;
+	}
+	craye1k->was_not_already_primary++;
+
+	/* delay found through experimentation */
+	msleep(300);
+
+	if (__craye1k_set_primary(craye1k) != 0) {
+		craye1k->set_initial_primary_failed++;
+		return -1;	/* error */
+	}
+
+	/*
+	 * It can take 2 to 3 seconds after setting primary for the controller
+	 * to report that it is the primary.
+	 */
+	while (tries--) {
+		msleep(500);
+		if (craye1k_is_primary(craye1k))
+			break;
+	}
+
+	if (tries == 0) {
+		craye1k->set_primary_failed++;
+		return -1;	/* never reported that it's primary */
+	}
+
+	/* Wait for primary switch to finish */
+	msleep(1500);
+
+	return 0;
+}
+
+/*
+ * craye1k_get_slot_led() - Get slot LED value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_GET_LED;
+	bytes[1] = slot;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 2);
+}
+
+/*
+ * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = use fault LED, 1 = use locate LED
+ * @value: Value to set (0 or 1)
+ *
+ * Check the LED value after calling this function to ensure it has been set
+ * properly.
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SUBCMD_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+/*
+ * __craye1k_get_attention_status() - Get LED value
+ *
+ * Context: craye1k_lock is already held.
+ * Returns: 0 on success, -EIO on failure.
+ */
+static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+					  u8 *status, bool set_primary)
+{
+	unsigned char slot;
+	int locate, fault;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (set_primary) {
+		if (craye1k_set_primary(craye1k) != 0) {
+			craye1k->get_led_failed++;
+			return -EIO;
+		}
+	}
+
+	locate = craye1k_get_slot_led(craye1k, slot, true);
+	if (locate == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EIO;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	*status = locate << 1 | fault;
+
+	return 0;
+}
+
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 *status)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	if (mutex_lock_interruptible(&craye1k_lock) != 0)
+		return -EINTR;
+
+	if (!craye1k_global) {
+		/* Driver isn't initialized yet */
+		mutex_unlock(&craye1k_lock);
+		return -EOPNOTSUPP;
+	}
+
+	craye1k = craye1k_global;
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k_lock);
+	return rc;
+}
+
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 status)
+{
+	unsigned char slot;
+	int tries = 4;
+	int rc;
+	u8 new_status;
+	struct craye1k *craye1k;
+	bool locate, fault;
+
+	if (mutex_lock_interruptible(&craye1k_lock) != 0)
+		return -EINTR;
+
+	if (!craye1k_global) {
+		/* Driver isn't initialized yet */
+		mutex_unlock(&craye1k_lock);
+		return -EOPNOTSUPP;
+	}
+
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	/* Retry to ensure all LEDs are set */
+	while (tries--) {
+		/*
+		 * The node must first set itself to be the primary node before
+		 * setting the slot LEDs (each board has two nodes, or
+		 * "servers" as they're called by the manufacturer).  This can
+		 * lead to contention if both nodes are trying to set the LEDs
+		 * at the same time.
+		 */
+		rc = craye1k_set_primary(craye1k);
+		if (rc != 0) {
+			/* Could not set as primary node.  Just retry again. */
+			continue;
+		}
+
+		/* Write value twice to increase success rate */
+		locate = (status & 0x2) >> 1;
+		craye1k_set_slot_led(craye1k, slot, 1, locate);
+		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
+			craye1k->set_led_locate_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		fault = status & 0x1;
+		craye1k_set_slot_led(craye1k, slot, 0, fault);
+		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
+			craye1k->set_led_fault_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
+						    false);
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		if (rc == 0 && new_status == status)
+			break;	/* success */
+
+		craye1k->set_led_readback_failed++;
+
+		/*
+		 * At this point we weren't successful in setting the LED and
+		 * need to try again.
+		 *
+		 * Do a random back-off to reduce contention with other server
+		 * node in the unlikely case that both server nodes are trying to
+		 * trying to set a LED at the same time.
+		 *
+		 * The 500ms minimum in the back-off reduced the chance of this
+		 * whole retry loop failing from 1 in 700 to none in 10000.
+		 */
+		msleep(500 + (get_random_long() % 500));
+	}
+	mutex_unlock(&craye1k_lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+int craye1k_init(void)
+{
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.7


