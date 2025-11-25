Return-Path: <linux-pci+bounces-42079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04007C86CC3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 20:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83073A80C2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886B334C1B;
	Tue, 25 Nov 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oGVfoszL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HEQ6MQz1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF33329C70;
	Tue, 25 Nov 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098643; cv=fail; b=uppWoziBxd1L+O5IS7qExcFUiVQAWpA+AQBzz9y1QGZIh/AlEJxHP/LTUF/VysdJ/U4TMriHUcr5HFdFhl6NK+I0vAMth9tnqXTYXy81k0sObB37yHKcWt5JEbfOpS69GwGMGwRDO4LtG6+mSAKlxg2GePet1ry222/qvRfPN7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098643; c=relaxed/simple;
	bh=VNTs9qgqsZskr3sY1cUazCV0A9duQPum9b7CM2oAkXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YprOM6oc7/VV1y1zMLT/g8Xcm9E3sth+2cZyfJYA6EpQxWQQBZFSUaF24U9P5av4g0QzvroG4DcuEtSBxDXcglrDnNkj/LVQ4wokjg6TnjRTD6DAvULYnc+DVOzWbVpzkFqiIUZcQjzNAVXfKZHQprUImPr5/twanSUnKJQUbyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oGVfoszL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HEQ6MQz1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APHmMoB4069944;
	Tue, 25 Nov 2025 19:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/OC++75WE57/ZT9j0H/bnSuTijH2vssCBUXnZ14ti7g=; b=
	oGVfoszL1Duu7R3zpKgigpVvlONWJ0w/7hac6+PmZ0wF4Scb2sifg4Uj6zhEEEor
	X8ZyduB1plrutG+3EYDoCAJZ6QIuOx4eg1ZztL62HS2+tBH/Y+A+oPKnlmtSSN96
	W44dstxByOzfmwaZcLeXqvGFqNCIHtXz2wXCaEasnZd6OZfou0gKXpKn/89TZ9He
	mkRuhF8OSObi87eveperKdtmsM9VxeDTnwATy86OB5rff4efUazpqIA0HAucvkxF
	awwo/SNbu6Q3QRoFlsBZK4E3OY4ZUfCOeugpVhtFqFPbS44b+oStHW/SzRswbi2i
	nFi8TZUNd63mXNZeg/jLzQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddfq7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 19:23:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5APICpv5032063;
	Tue, 25 Nov 2025 19:23:27 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m9ydc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 19:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqel5UmoWWfjXH47PTuaXhKHiLul1FbkibRc9GEvBoS5mNhBmpQQY8BVMsAR/yRgMjABYopyXweHkg9A3gr54WO+m9xyfKl88/iJtP//hvhpuDJXylUns0HCTru4dXQ2sKq8kyzynPQTxNu9Z7yPFctBLdgBOhclfGlx5xX5onF6ymkzDyvbjH4vvNW3vSMLxFICxzOjtzRhFHAAvkYhTB9SI33pG2wJZqZfx1XJbBDMUi91a/kM3OHMMruGQGfbkZCjabnhgdB5YiMTIbN6Vcb0yXclbJetXJL3Vswh/InaMPPLMyncn01xAK+tuVck7EU2/EApy3msCC2jnyD6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OC++75WE57/ZT9j0H/bnSuTijH2vssCBUXnZ14ti7g=;
 b=e9zJ8bBXo173YHqdT5uk8mL3/gKh9/CdSXSfkS1YivEHqtp9EqyYVyHio7b5Hh9Js0YXoeg4aSZ9YbkOxG7F+Wy3SBpewZRokZWApGSR3uRUdzchz2/ekkoKApw2zQ1g/jiWgc0/yG2vI/ScLZ/AgWgoWPhI71Y63iO5BFDdlcds+cEYesQP6pPMvFv7iMbN89URoi9Gcx9eY67TXZLs9Nt/zko9q6nai/eGcGTajycoiLaiMxzUat7EQMMElyg1mj5vEQh5QTkviNF53Lc4hhEBjLhG4TZC1vTHcms24LJOMPwL6OlbcK8LJTs3eVsYTyZzVVWIq6hePKdBaLGclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OC++75WE57/ZT9j0H/bnSuTijH2vssCBUXnZ14ti7g=;
 b=HEQ6MQz1CYUbYMiWlxxFciD+TH7GmFWn0Xp/OyQkdHY7W56MgnRMUfeEznadloKIzGLMuaoMlyYRsthBfCXpW45nddslgD6V3AaRZCHFPKaCS+ld/yRDlBQQ/86TTTGefJ0eZ81i5nqzAS6WDQiwR3umh5lb9G+JcBEaKhFsnGI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH3PPF730141699.namprd10.prod.outlook.com (2603:10b6:518:1::7ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 19:23:24 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:23:24 +0000
Message-ID: <d4e5b6d8-c69f-4fbc-8da6-bc2c2fb2a550@oracle.com>
Date: Wed, 26 Nov 2025 00:53:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing
 to Gen 1 during hotplug testing
To: Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        bhelgaas@google.com
Cc: Jiwei <jiwei.sun.bj@qq.com>, macro@orcam.me.uk, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, guojinhui.liam@bytedance.com,
        helgaas@kernel.org, ahuang12@lenovo.com, sunjw10@lenovo.com
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
 <3fe7b527-5030-c916-79fe-241bf37e4bab@linux.intel.com>
 <tencent_4514111F8A3EF9408C50D9379FE847610206@qq.com>
 <3d7c3904-a52e-9602-3ad2-29b5981729c7@linux.intel.com>
 <Z4eLh24IkDrAm6cm@wunner.de>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <Z4eLh24IkDrAm6cm@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH3PPF730141699:EE_
X-MS-Office365-Filtering-Correlation-Id: f577d38a-f19b-4556-667e-08de2c581a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk5lci9XZVlGak1oK2RLSXZXR0gxV3NLQlRhdDVQNjBTQk1aSHVMeGIzM1lw?=
 =?utf-8?B?T25RU05QTHA1UWZ0djdKTUlMQjZ5dnp1TEJFN3hkMElSRmlYeGEyNEtyNjRp?=
 =?utf-8?B?UkpJckUra1lKUzhjOFFwdjR0amovOTRjWFlBR3lWWjVvNjdGbWtmdUVIYUxi?=
 =?utf-8?B?MHpEbUpnYXNEVVRaUzBKQS9JVThqNFFPSFVCTG1JNlN0cTVyVjE3MUxRbG5B?=
 =?utf-8?B?U1V3L1IvNHFubDBWb1dSWUlrZmswZktHOGNVRHpwaUg1NFpqZmJzUDJNck1q?=
 =?utf-8?B?ZVl0ZjRpd3VZd2pBamFGMldPajNuT0F6d2FXV09aajZsVnB3Q1hlRGk2RjZm?=
 =?utf-8?B?UEc0OG0yVUZ4cFdGYTFjVEIrSEcySDZzRm5mSXhlYWdaUk9YT3JaczQ0cnMr?=
 =?utf-8?B?WFhhQlorN1F1cnZKQXhnY21ydnVFc2x6NmJaRXlwZDRrbW15ZE5kNlBDYVJQ?=
 =?utf-8?B?azlhNTh0N2dmVEY1WTMrcEJMN1NBeWRtRkZJTDNjd2xpdTA1SHFTTmVzSzBY?=
 =?utf-8?B?R2oyZFNUZjlZUEdra2ZwVmpxdXpQc0dBQ01RM3A2OFZmZUExYjdBSEhsczI1?=
 =?utf-8?B?MHN1YUgzejg5SnpsMDl2bTZQbWlRemppNGNVeVIvNkdqTC95TGszS3RJVEtP?=
 =?utf-8?B?dExXNzd0Q3pObmh3RFlXSGV4Qm5ZRUVESjVacUpXTjMzZDVuVlBiVmRHUEhE?=
 =?utf-8?B?QlRLOTBwWnJub0R2bks4MjVMU1R1aUpheHg3VE1hL0dxeUhHNWEzVk9Iakhs?=
 =?utf-8?B?R0VGYXg4aWExREd4a0xtNzBGaytUekhyRjdRQVZJQ0d3NkxXY2V6YWgzMUh4?=
 =?utf-8?B?OCtwcjFpOGJ4WDFhYllTdGtwdGlWVGd0cy9Jbm96aFVGNEtNU1FXdjdGckZw?=
 =?utf-8?B?MTJUMmQxZmVxRTNaZEp4RWg2MTZlMzRMd0t0U3I2c1J6SURUU3IycjYxMm94?=
 =?utf-8?B?K0tkbmhrQnh3QTJnby9YN3hvZFNNRGVMdkU5Ujg3V3VZZjc5bktvN0dWMWRY?=
 =?utf-8?B?WkJnMkNSejZ5Ylp4dWdIdllqMmVYK0t6V3FtYlE1L1lQeC8vSUpoMm1WYWkw?=
 =?utf-8?B?U1VnZmhXTjRpNlAyWkFLN0RpeEhhNUliRXMxTzl3eXllWVpUUlpyc0Z1L3J5?=
 =?utf-8?B?V1ZvOW5raGc4aFpsQmYwSnQrRXd0NnA3S2NGMmtrQTB5bUZKY1dxUVp3WXZW?=
 =?utf-8?B?bFZVU0o2S1IrcFZTVHgyaVBEQldLVUpUWVIvQXNaZXNXTnB3Nnczb1o1TWV1?=
 =?utf-8?B?TnphQUFSMWJvMllEaU80aEtBZ0l0Mk5PUUJ3L2tVNnlpem1CYlorc2ZPbW9H?=
 =?utf-8?B?L1RqOVJhUmhIOEd3U1VUekJaQys5bmtiWkd6endGQXRLZFJLVTRaeUpBeUxD?=
 =?utf-8?B?YnU5eHcwNFQ0czE2SkNUbGlOUUJRd3ZtaVJDVzVUY0hIU0tpb2dJcmUwbkpB?=
 =?utf-8?B?RHF4ZzVBYnQ0ZFZTZnMvYnp6ek0wOXVNQUlJVnh3L3JrVzc0NFdHRXNpeERN?=
 =?utf-8?B?dmZuODhSNzFjaHliOTlDTTNEMXhjSWR4V0laWkpHdWRzVE16TitzallIZzhF?=
 =?utf-8?B?TW54U1Vab3F4V2JNeHh1T21oVW0rdmdITGZyOG1mTDhBY2ZaUUlHdDd4RFpN?=
 =?utf-8?B?M2pKQWlIUkgrS2FPblFVWnFFUlVyMTJORGlQdllZV25ITEp6VUEwM1FjUXFu?=
 =?utf-8?B?Qy8zWHZxRHFQQlV4SmNrVC9MS2Z0THNvS3BOV3RpMnJncElURU1McHI4c09O?=
 =?utf-8?B?RERTY21XUGZ1c2s4V2lTejNSalVTQkRDd3QzbmM4aDZtZHVyWlEzZldJVW5T?=
 =?utf-8?B?MHRISFBvUE1lb0h3NzZsOGk1SHdCNWt2VUJLdXQ2eWI1M3JUMmhVMkVSSTY0?=
 =?utf-8?B?ZFc0RVFVSVNhdllmMXdLR1R3UHJWaURlWGNldFN4amFRZENjVTA5ODd5U3J5?=
 =?utf-8?Q?GsQk7qC4OuFgbTYCVAg7M61ig1dMge/F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejhKUGlrVnZKVE8rbTlrQ2t3aXlhY1NQaUVhaW1jakRCNTIraUVWWi9aWVN3?=
 =?utf-8?B?d2ZSNnlDeXA5N1I0QS91ZTA3WjAyWGJOM2M0Z0dPZnJHQkxHeVBkWXpOSTNF?=
 =?utf-8?B?S0w0NU5Vc0orckQyeERYV1ZTYVIrRXJ6Mm5xMmVNMk1GZGxhZSs2dG5Xcnc5?=
 =?utf-8?B?eFp3VW10cEM0eWNxMVE0eXdMNzVyZDdrN1g2STFGK1NvS094bTFVZ04ralVo?=
 =?utf-8?B?QnRpOUFFNmZBOThoeDVENzZiUVBDUGNoMlE1ZGZ2WSttcllHV3Y2QUhxRjdU?=
 =?utf-8?B?eGg1c3JlcDIxR1BMRG9pa1F0WFVSRERqb3BlRkdwNFlGQVJsK2kyU1p3VStY?=
 =?utf-8?B?ZE11MkxEVGdFckJLYUJrSXNGT00zUmRWZG5MS0h5TFZHcEZmYjVZd2tqWml5?=
 =?utf-8?B?cVVBa0txMVRlN21Pdm5jWHd5N2Z4MjFaZVZkMXRKL3JsZU9pVVQydXdIR3dp?=
 =?utf-8?B?d2lDK2h6MUhveGZ3NnptcytXMk9XSUZwOURIbHF0OTg1c1FpVklqdHlnWTUv?=
 =?utf-8?B?S2pXQkJHVHBQTkNmenNxOHNXTWVHd2xhWjlENHhiN2lmd2NrMG1DRjZvNzVE?=
 =?utf-8?B?MHRPVERGYlhuV0JYRmI3OFR5d0phT01Wb080ME1haUVUZ3lCWlJFNng5N2FR?=
 =?utf-8?B?dkJGYW1YQU50RGp4U1V4Vy9OVW8raWdRcFFWSVNjSklwM3Q5bzBDMzJJNWxw?=
 =?utf-8?B?c0Q0ZDduVjlWcUxpYjVGdk4xRzA1UjZBbnkvV0xkQjVvdlIwMCtoeVc1UVY4?=
 =?utf-8?B?SytpRjhYV2xxNGlxSGthY05XNmRUTUdSQUFITXJ1NHpGK3BNLzExZWlvQ2lC?=
 =?utf-8?B?Y29pVkw3ZmdWTDIyakQrdkl6KzZpNEZsZUJLQzJ3bERDU0xEbGZoK0w1eVpx?=
 =?utf-8?B?L1F6OExhL2dkalkxUVdiTXRma0ZZdkl0K2xLQ0RxRjFFU3A1ZEJFajVnRDRx?=
 =?utf-8?B?bmZvT1N4Vnl0bDFqNGkwMXVTRHRDZEdiV0JUN0l2em1LK0N3WjVMUTNJZlBz?=
 =?utf-8?B?aHpFQU1DUklVWHpxTUpKazI2SjBZM3psZFdBZVdWUUM3cml6Z0VJR1pYNGxm?=
 =?utf-8?B?cFVHSkVTMVN0cHhKTFl2OXdwODNSQ2J1dDA4ODgvbDlmMllRR00xRys1WUQz?=
 =?utf-8?B?SkdtL3E3NDV3WXhqNEY2U3YyM2szeWxoOVQvUEVxbStkWlJIaFFBSDVFMFUx?=
 =?utf-8?B?NHVzbTNrY1VkaExpS3I2NjBVa1M4T0xmNVgvZTljbzJxaldRS0pINFNEbGVF?=
 =?utf-8?B?KzZwMzlvdGRBd0lWdlVyS1lDaEc4MURHdEFlZlZQTy9oYzM3ZkNwcDZ6UjlD?=
 =?utf-8?B?WXZHNjJuRVMvTHZ2dU9RU0hiZ3JlbzJ2MC9EZ3U5MUJ5M2tuUGRXeUdlZmVu?=
 =?utf-8?B?YnVRMlJlQ3kxYlEzQXRpSWU0YmdLTk5OTzVqTlVCaXk2M3h3RTdXejdvV3U0?=
 =?utf-8?B?UENVRzVzWG5SVUJZTzhLYWoydU1sSDZORi9tUElqeGNmbzMxdk0wVlJRSzhj?=
 =?utf-8?B?eDI5MFF5Yk00b3FYdmRMWHUrR0VvUlVwM3ZxR1BnMmhWUW0zZVdjSUR4d1Rl?=
 =?utf-8?B?U04zTk4vMkx5aWtIY1hKRzRSNlhya3ZWNXJGcjM4T1N0MUNNK0ZqNEorWHZ1?=
 =?utf-8?B?SUJRQzUvUTdPNHdXaHgzcHpHMmJqb2p6cTVROUUwOGNoOVFMazgrNnFuajVD?=
 =?utf-8?B?TE5KNEdwTmVHeFpJZ3NzWjRnNC9zWUFTalZ2bXdrcjBMWGdOa0xiUmtIbElG?=
 =?utf-8?B?V0p1d1FtV2NGZGhxcXdESHFwN2ZXRXphT2xiMVBtL0pMdytYRTJHT2VIbnBN?=
 =?utf-8?B?czNaNHp6cEc0YmJSRzlDNEhBTmh3UHAxZkZqOG9OZFMrOXZiMUJkdVBWUGhC?=
 =?utf-8?B?N2pXUS9sSklBaFRTT01WeDFDOXE5VVAzSmt6S2RXQzduaTFlRWd3MTVuZHdm?=
 =?utf-8?B?cXBRMWxjNDdHK2M0cS83cEhDcTZ4ZkM3bnZUckoyK09mMFRoVzNPdkNpUkZx?=
 =?utf-8?B?bU5SSy9UUlhqUzVkOTFIM0p2eEw0UnR0clVzNzRLR1VrZmpKS21GUiszYld0?=
 =?utf-8?B?MGVYOVg0UTlZcVYzdHFDOHR3eVN2eHlEY0J2OWhRVFg1OVB4NWlOZjZBR1Fx?=
 =?utf-8?B?VHh3QWh5Tmx3Y1hSYWl5WnBxWHVZaDVKM05lSFFtdlhWWUtOQnVSTTZlTm0x?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vivU1vwTSUi8uZOJMK0e80T6hyzTfJvREOBos0A8Hk1PynD4neuJymFBzbuC5jFQqC8jFzAC03Gibmem8dt2Fr8DKxUc+G0nagwEyR1C7X9MTD7sNHHSj1tPrnO8sdY4JpeWRb46v2trnna0dKR9wfzwPlo5fjA/vS75sc/MpF1J7+UTW5pWBmTLAF+mNRIuEJTa+bltLIePCibqGOj+6hhCXkVNB8+EU3/Z+GebWMLpMo7z67a5lFSOhCieJb3fgtyI5EbdwkAIxxf2NmqY6u8TDcw+CRDlw1wxUKehF9dj69Q+W1aLBOztukoRPcR5ILsvxQ0HGeXY13iD2PrI/wQdXHTTxYqaCOmkxTxB4V8b5IkZSlcOju0bdchZ0QHzejCSOqW9jmjDnViBc6TQ0UjpACXozirvgdnergiE6TqKTloNaXi4KApe0OnFRfvusUriMA+TBld5QkqDCVQBFu3PwPxwOJTtj/06Hpcjl/VuTfOp49fyDV2DS5Oq0ZFPNctSR7l4fxRFnE8FJXESanEYPxFiSBFoA5a8H2YicIJJv59T2hxFDYEeUiNP028uZbBwSvOODZA0ooDdh4gQCoXh6+GW9h3ifeUB5PEVDl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f577d38a-f19b-4556-667e-08de2c581a60
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:23:24.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plPNRmv5xClSbNxrQZLaMfr+4+TxougWxROjNVQ2J0O5B5jvi1Pq4XBJ2tFnrX+lub7cePLvG9qCsYiZsLANGo02Y2hzIRZ8bruTk232t90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF730141699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250161
X-Proofpoint-GUID: 7aLs_M09IIyTuZf2YtFzaJ_HG3Uvbi2Z
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=6926022f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e1P0oExWscM97Nom4JkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfXzpM/Lk04O4mZ
 02Rilg/BfZAiN1Y52YxoP/B87HsFInmw1ocDSIX+NbeLdq+YFmqTs7WXvQTFPk6lfVr2gzajndH
 nSnV2DcxnM3lZco+7OxG0mX9NuvO2ughdJucZdvMxtPq5YhaxoJpjmaqhNCSNt9mTL81mR6MatG
 woANcfwVKEQq69qAIoK5nDsI/qoaaUDdZsIijdOseIAeVSizuzbHWEZXnkm3ef6m9L70uNLi9O/
 GJLpc+7ksyqB2s84vsJHhHkP08X0axE+D/XwaXIEhzQW22dZw9U2tPcEzfolL293i/HnX1tWFxQ
 bxIPzEgfeBXqI3QZ5JnLzFPnZyRwNTtg7Qr4x4mHkELL/U4Yujm18bK7t9Hv8KUrJrVktxN2+pT
 NxNvGRunYeQCHmxZ8NpTfSuPTfZWGQ==
X-Proofpoint-ORIG-GUID: 7aLs_M09IIyTuZf2YtFzaJ_HG3Uvbi2Z

Hi,

On 1/15/2025 3:48 PM, Lukas Wunner wrote:
> On Tue, Jan 14, 2025 at 08:25:04PM +0200, Ilpo Järvinen wrote:
>> On Tue, 14 Jan 2025, Jiwei wrote:
>>> [  539.362400] ==== pcie_bwnotif_irq 269(stop running),link_status:0x7841
>>> [  539.395720] ==== pcie_bwnotif_irq 247(start running),link_status:0x1041
>>
>> DLLLA=0
>>
>> But LBMS did not get reset.
>>
>> So is this perhaps because hotplug cannot keep up with the rapid
>> remove/add going on, and thus will not always call the remove_board()
>> even if the device went away?
>>
>> Lukas, do you know if there's a good way to resolve this within hotplug
>> side?
> 
> I believe the pciehp code is fine and suspect this is an issue
> in the quirk.  We've been dealing with rapid add/remove in pciehp
> for years without issues.
> 
> I don't understand the quirk sufficiently to make a guess
> what's going wrong, but I'm wondering if there could be
> a race accessing the lbms_count?
> 
> Maybe if lbms_count is replaced by a flag in pci_dev->priv_flags
> as we've discussed, with proper memory barriers where necessary,
> this problem will solve itself?
> 
> Thanks,
> 
> Lukas
> 

We are testing hot-add/hot-remove behavior and observed the same issue 
as, mentioned where the PCIe bridge link speed drops from 32 GT/s to 2.5 
GT/s.

My understanding is that pcie_failed_link_retrain should only apply to 
devices matched by PCI_VDEVICE(ASMEDIA, 0x2824),
but the current implementation appears to affect all devices that take 
longer to establish a link.
We are unsure if this is intentional, but it effectively allows such
devices to continue operating at a reduced speed.

If we extend PCIE_LINK_RETRAIN_TIMEOUT_MS to 3000 ms, these slower 
devices are able to complete link training,
and the problem is no longer observed in our testing. Therefore, 
increasing PCIE_LINK_RETRAIN_TIMEOUT_MS to 3000 ms seems to resolve the 
issue for us.

Would it be acceptable to increase PCIE_LINK_RETRAIN_TIMEOUT_MS, from 
1000 to 3000 ms in this case?


Thanks,
Alok


