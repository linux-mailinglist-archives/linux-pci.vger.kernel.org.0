Return-Path: <linux-pci+bounces-25286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0CBA7BA0C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F5E3B9E50
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BF1B0F17;
	Fri,  4 Apr 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUZtNH7X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBOO+p5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15A1AB6C8
	for <linux-pci@vger.kernel.org>; Fri,  4 Apr 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759182; cv=fail; b=ckopbY5a+m1IS9EB4o72qfuazb1WLHUwX5aCC2STKzNlYXugL3kzLyd0kgUKD5Cpl7JidgI1y9SYUNAHKg4ydKYmErCxOrw9g7+L3Ku4mTubfibKEV2+6da+/IKkz6o4H0VVeTRw6ol1tgz4oJISWJMgesVXm3bYctcOBMqcFGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759182; c=relaxed/simple;
	bh=f1RxuE8l7JMENsGPyj2pxWJOVg+q5c/l26Js6UO2bXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WNPtO2qToFiwQWo9X41hDW5N0xUeIh8oUQ7Foobix7+nz/XJxguiHz7UhbRqs8WzPQvsJX3EmEhcrutB/vfIC4qh3kGMeskui0FkIe2pHTx0hRVZ8xq+uqEw/BQinLJdB/Of6o899s8rpphqypPF1TwM7KQ8bFrmsHBS7OGpuUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WUZtNH7X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBOO+p5a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5348N4mw024643;
	Fri, 4 Apr 2025 09:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xjK/1/3CkXVTl1tRm4197MnFQPrTGafSYy0Qd8aQJKg=; b=
	WUZtNH7XociEOoALybqesUp5IQzxiruRSuOfEFmeDlpNTyVpEl2dHhNmeS0gYa1Q
	FbKBhHmkLLAEhpPWaVKC49kLvIKEaPREHIo55sZ0W/rOc2vopicbnx1AkyxJbbI6
	KeRj6K/78wwxPLk3m5OIxt7PJKN5XIg6NllWv1wEjAwuLpIadj3SGx09Wbtc3B+w
	DjXfiJwwLToCNR9HeFwjAOEXb4MbH42gMKRzP8LFx7PVuNZkxD71h88bIH6nYeL6
	wcpmQdv4gSMxtrUnubzA6JvhkaQ+/qZVvpgILERKkZOfujFG02rCx+e+jbuxutVT
	yrFQHzdwtMyh4kMsoEVg8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsf2t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:32:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53480RZn036133;
	Fri, 4 Apr 2025 09:32:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2nttv5d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsErF5B1VbJF3h9CfbP58B3ZcX52oXX1Im0V+F+Oumy8nmCC4Sk6Z3Yj0SASEdfsqOYx9bWdiHcOA3BNZr4F83Lb35ltvQ+I+FKfezFd7ycG5YKY5LKGVaXfkIXF535YVcyJ9Wh0nAlDgFt9Ib9baaPtVPCJFy2GQs+IIQc+aBZ6JUlNKLy41AxWESnTMRS7n+VnCoqVxeaITadq/HP0zdbgoHkWvFl34YcDgMsHOK79P7Bim+h5YT9BAHlCf8KMSHh0sDaKYXvOdWU/ieLGJ7WRQaLd1LNsPJD5feHRAGYfEv8AV61d3FbyCiC0PbLJn5qt93vKHAzbNOKYSznuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjK/1/3CkXVTl1tRm4197MnFQPrTGafSYy0Qd8aQJKg=;
 b=auPVj/pGt7QBa1SN215NNVcXpi9xvtiFgtS0xPBIZPqT88cEvtP34hB80Xj7tJn4Syq3GdcLq5K4oJn8iGZwyxJJUDr2FiZIKmGuiUxli/CaY6f0vExTha+hjzZJx7+TIgpLoc7MVvERV4k3Woj0CZKMZ+P2qRKxYmhCUt/9vhZTnGwvlMkqLYEUf5kbUSrQvlpKhKfsxf2f648Xmf1Kyp/LpRrCIyTeOdhu1obhQqtpoSW2xrYOYGwsc92YEQ3gQZLioWXS68quhrQ5CIUsL7elBZgprFkvrzElHcQA/fa1QjOB2iM0o2ZK83KzhH7gsRuYDY43OGTv5pFOCN+vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjK/1/3CkXVTl1tRm4197MnFQPrTGafSYy0Qd8aQJKg=;
 b=qBOO+p5a1BmDcXioPA2ftcbuUHvrfFCmNFb4E+v5rzVuK9xOOCzG69Yj8ErPTDmIa2MjJr7xynXyNpdcKLu08J67qzsf3pWyXz+NkQo2F5ZGfjza1xRefzMT4Cjo3nFljbeZyevkR6XNuXy8h5xQ/GNsnib8r7Mnf7WNls7I2Zw=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by IA1PR10MB6097.namprd10.prod.outlook.com (2603:10b6:208:3ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 09:32:37 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%4]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 09:32:36 +0000
Message-ID: <88557c78-9ead-4a5b-942f-5bd0213356f9@oracle.com>
Date: Fri, 4 Apr 2025 11:32:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sargun Dhillon <sargun@meta.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250321015806.954866-1-pandoh@google.com>
 <20250321015806.954866-7-pandoh@google.com>
 <e028eed2-440d-4094-bbf4-016ae5c0acf0@oracle.com>
 <CAMC_AXWSXLwnS7-KbK=xFR+r84s+VCYYEegBVFCqehx21L4AeA@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXWSXLwnS7-KbK=xFR+r84s+VCYYEegBVFCqehx21L4AeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|IA1PR10MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0295949e-8320-4f90-6047-08dd735ba2a7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MzlPUElqNFZaZnd5WXVmNkM1QmErd1I1THZQbkw1L0d1WC9wYzNBMldOcHdi?=
 =?utf-8?B?L3RNV0ZQY2EvT20xMjdFQ2Z1eW5ydHRmSTFDbXRxbkdQeGVaeEE2MnZic3FQ?=
 =?utf-8?B?M1RmcG80RXNIcnFKNkdSMnVnVGpTVjhrZXdVZHBQVVdESEhqdHgrK0diODRD?=
 =?utf-8?B?VkxZZVJOMDN3NVIxV0cvd0xaQk43ZnFMZjAxM3BIQTJMc1YxdkxDc3RqOS8w?=
 =?utf-8?B?NU1ONHVBUW4wZzRnTXVOZmdGS0h2WW5EeklzckkxeURXSkdCNk5leWROOGdE?=
 =?utf-8?B?S2FsQnJTcVoxcEJEM3FqTkdwQ2xCVklMZ2wzSVI0NUZSOEdHR1JPVnFRcEZT?=
 =?utf-8?B?SFNZd3c1eXM1QUxvUUJ5VWp6VHArQlFFcXJldFFrV0xORGVpK3FmWXNzRXJa?=
 =?utf-8?B?S0ZvaFkyL0V6ZDRVdDh4dGxxTFRkU1R0azBzaWVlQ3JoREJ4STA4aFFtWGNo?=
 =?utf-8?B?cWZSNTArWGFVOFlQL2xQVVVHTStqZWdJZGlIcFV1MkxURVNzYU1tM1hzV3U2?=
 =?utf-8?B?NDZuSCtSUllYWFFNcEU4ZVFJNHdWdE5iREpNRUNjNHJHNmF6dXhZSTdLMTBy?=
 =?utf-8?B?K0Q5L216b3JkM3dhVW8yclNLaGVvdzYrQm05TmFGajlvS1VMeTlFaG9ncU5i?=
 =?utf-8?B?NWM0NFdRRGRNS3h4U1Avb0J4RGFNMmJNSnJmK0tBTS9BaHZTam8zd3NZb0Ru?=
 =?utf-8?B?OUhhbGIxaEJERFR0RUphbkh3UjJGaWJxSUFBNlhYMzBQdHAycTdINjc5dThL?=
 =?utf-8?B?SjBBTmlUcVpqeEcvRHlrRXBsbkoweFpvem02UUhDNkp0enZLMFdLcGVudFRK?=
 =?utf-8?B?UEJYd1ozSXRraEhlVXlMUXhCa2NLQ0o5S0JjOE1EYkxZTUdEcWhIajlhd2VZ?=
 =?utf-8?B?MDNaZ1ltc2dySEtOcnVJZm9rakZSK1dDcVpMQzFxQk9LN1QzN0krOVFHVVlL?=
 =?utf-8?B?NmJlZlRxR2xmTWM4S1FsSCtoT3pobXh0QmN6aUJsNEJZSE03RzY1Y1N3TzZn?=
 =?utf-8?B?TTNrQjFQRkZQWG1STnVmY0RWZkhBcFJnVVByOFFLZERzY2owdWU0MHVDRUR3?=
 =?utf-8?B?N1RUVExwdjMwVTRnMUZqMnV0elJjVlRjQ1YzQU9malJzczBFMktpWkY3T3lU?=
 =?utf-8?B?cy9adnlxa2QyVXF0YmJ3d2tLU1NhSEx1RDd4Y1BiaEpGdVlMT242dUsyazlw?=
 =?utf-8?B?YkVKL0hqdGxhNitJTGhtZjNGMnY0NVlJejhoZWRRY1JBcUxnSWh1MmNzcmc4?=
 =?utf-8?B?MVVtcHZma2F0WlJOVGI5bW5oR2tNKzJCRzV3R1EzWjR2ejVENmpsbnRhMGUx?=
 =?utf-8?B?MEJaZlZYcURJaWRsUjBJSzJhdDdZMm5vQzFtQkEwUEpvdVNIbUJhYUVmd0xp?=
 =?utf-8?B?Sm92YmhiOEk0ekREbHVTUDl1YjhLaDh1OXFTSDhkeDNnM0R4VnB2Nmt6bGk1?=
 =?utf-8?B?a2JHSGxGNHVzcXhPdjNRTTFtcU9hbVNtc083QnBCVGJvREZLTGY1R0VHcVhX?=
 =?utf-8?B?SDErbUZzYzVWNFdveVIvWnFOeTJOVjVWeSt1SGlOUmVSKytSVXZROFpTUTM3?=
 =?utf-8?B?ZCtKZEM1Y3BwK1pqOGVFNGZRZW5EZ3hySE55TW0yaE1EUzhRbk55cTlnV2Zk?=
 =?utf-8?B?K0NWRGVHa1JHZERLdVgwTmFDZzJDK01seWxqWnR3dm1sUkY5cGJvOWNRRitj?=
 =?utf-8?B?VkNyL2sxTkdkQUl3SjVXNFNEN2hKalZ2M1ZxQ1FHaGUvajViTVdtK0treWhm?=
 =?utf-8?B?VFNHSHhQaFZoZkVkNjh5d3MvM0IrVTZoQ3ZKZzlPcXFlc2praTdyWXFCVERh?=
 =?utf-8?B?c1ZhUjk3Mkp0cHJ5OGdCOXF1bFNjbnhRUHl4WGJyVGxYMHIrYnFrNXU1NFZ1?=
 =?utf-8?B?WDVvdDE0MFdwcDcrZW9XY2hjV3JXZEw1Y1RBZmlKNTQ1Unc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eDdYeXdOanVvOU5qbHR4cDBXY2dRY3djYWRUOTdIZkV3dS9TWGNaU2FLUGlE?=
 =?utf-8?B?NjE3Z0lla1Y1TmJVdXBjQjgvT281d3RkVWhIZ3o1WmVhSUUxRS9EOGhzcUxM?=
 =?utf-8?B?a2prV1Fza2dDTlVqQmNLMFFtbXdJczVubUZIaVgyeUhReEQ4anpPU0dvYVZT?=
 =?utf-8?B?VENGVmRHcTR3MlkxS2wzeTFzM3lMT1RBZ2I2TCtIM0VUUkVhVzZjM0ZnQ1Zn?=
 =?utf-8?B?Mlg2RDlOSFd6b0c5azdaY3pjZUxqZmd5SjVWRG1lWkI0ZTBTWnk4dy9rZVFm?=
 =?utf-8?B?cjRYbUJ1QTloem1PZUpCcXBteVFVY3lSWktqSHkxSUEvYWNwS1VVb2R0TU1U?=
 =?utf-8?B?cUFXSWM1dFg1eWMyQTNwTkpzUDdLVEdGS25EUnRzTkVTMVRKRUI0ZDB5L1lK?=
 =?utf-8?B?REtvelZFbnkwdHpDUWVRME1MOXp4MXZtWXFWMHE1T2Zvc29WbU5nMzhjNi9D?=
 =?utf-8?B?OS9KTEpiVHBMQkUwME93enN5WEdzNnkzM0tZZkNGL29uREczQ2dTU2t5QlFu?=
 =?utf-8?B?VjlzVE8xZ1lBRERPRXlhT3Z5V1FWYTZIaWpZWjNZaXp1enQ5VjloaDJTdjd0?=
 =?utf-8?B?cGpUcTBFOU9sTmx1V3NNK3VrRjFkNzZGUDF6aURNRll3VW5NVFZBdWFobW40?=
 =?utf-8?B?dUt0dnFlZ3B3cWhpSlR4ZVF4cUhETk9kMkN2VTE0aTl6MmFHK3dHTGIwdTQz?=
 =?utf-8?B?NmxCZkZEYUpwTkE2OGlDNkxpR2FUTDhjRVRxV1AxTHExNDJUZEV0OGRNOVlz?=
 =?utf-8?B?WkRZYUNGOXRKb0tjUVlGVlZlV2pmZUwzaG1sVFlXSFFrK0ZFbHlORkwyTUsw?=
 =?utf-8?B?NG9lRmRLQWNlMGFCL0JpKzNrQjF3dk5XV3BHM2ZGaU1TYVgwdFRRcVIwUWY2?=
 =?utf-8?B?cG5LSjJ0NzAzMkJvMmh4VjNJMXY5TWdMNjVWVXVUZzdQRUFlbTQzYzdkek1H?=
 =?utf-8?B?K2ZjeTBYUXAxVG0yYmJya0VhMnRzVG5LSUQwZTRmTVNPUUJqTE5meE1kdnJ5?=
 =?utf-8?B?bEdaTVJNM05rMjJ6VEM2UGxvZzZ5bHlVS01GdHVrcFdvM05GeFloazFGQnlU?=
 =?utf-8?B?d283SWt6S2lmTTlvbWJkbUVhdjRwdmMwNXpMNjdOYkZpTm9TTlQ2NWdZVWpZ?=
 =?utf-8?B?OFFHWk1PRkdvVk5WNlREM1pQc1YwYTl6OEV0d3ROMFIyVTRLYy9FdFNKa1lm?=
 =?utf-8?B?S0NVcTJ4WEpkN2RIaXZPWmhNNnFSczl4NkUybnBSOG96Q1B5YW92U0N1Z1VK?=
 =?utf-8?B?Y1ZCaGVoOHBET2tRdHpMaXdXdkNoNnd4OGc5RElTYm5McGFhQ1hKakVDa3hG?=
 =?utf-8?B?RFRUZVB5c2c4MlpUdjk4Sk5mOUI0U0hTNFMvb0hPdW1CSUF1d2xnTkM1c1VS?=
 =?utf-8?B?SjlxdVZZQW5PVk9QMWdsL0dublo0aWdtVzVHU1B1L3dGcW9QbHg3TlFEb2M3?=
 =?utf-8?B?ZkF0Mm9DektodUxWYVBRd2tmOXR2dFdvQmwycFhJcC9jaGEyK3RtL3ZJL05r?=
 =?utf-8?B?SzNVVmQ1WmFxdGhSVVYvZndnVVJ2M3hIV1NDdmNRcHV5QnE1U21tZlRrMk9N?=
 =?utf-8?B?OFo3Q28yTkpYYkJ0ZTNhVUQrdGQzLytXelNFUXZoVi9LL2dobjhUSzNOQWJQ?=
 =?utf-8?B?Z3c0Tld0WnB5NGovWlRvcTdSbndIZURMWjQxRVorUU9lVU5nK081OE12aXlq?=
 =?utf-8?B?UWlHZjE3T3A1bzdZa3U2YWc5V3dxU2FXOSt4UXRQYlcyNUFIYkMrN2RDTUtI?=
 =?utf-8?B?N0lXbFFvZmVyc1F3YmVLWXEwRVZQK0dxUWF4UUVtNmlMOEIyTmZaV1BLQWJi?=
 =?utf-8?B?SFVMRXNEelNjQitlQk12L0MwUlVETUgrM1ZsQnlhazA2T1l2N1cvUjJYUUxT?=
 =?utf-8?B?S1VGdkhGQmpTR2k5U2Z0aS9sSGpGWVFkbHc4UzFZOTAzc0h0TS9BMWdjZzB6?=
 =?utf-8?B?VDRzNGJLYVhNVEE1LzI4cUo1TmZvcjhKWjdWS0FYS1QyRWZEZVZ2S3JvMGFj?=
 =?utf-8?B?UkYzbVJsb2VzWElmMzdvaDlZQ0lFK0dYZDBxN3VpRWlmMEpOQlNYMFJmNGtk?=
 =?utf-8?B?MVJYVUdWMU1kK0VsMFUrRHByaTRJZ05JUTBHMllkRW5uOGlKU0I0K21LRXFL?=
 =?utf-8?B?U2szMUFDb1ZNai84SGFsTE5zZXNBVWxJMDF3MFpaYlFmL1h3Vm5ML1g5d21l?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i04+fULI3oc83c+5SrqRX8hwtpKt8W/4JGqAQl+SrN/YY2wDJN7XC4MZMJbtjxVHdrxsh4rb1igNwXZLZOBU2ccfLKoCGEp7xeJdLGy8pco7cBmeVvqU/+oYoXVpIRkA6D+WHdlzJXyC1XkCeOGaKiSlWLY6YbLahv8ctIPxiUCHs7qBvlKo5cggUbg+sTb7l5wk44QTNQey166x/36XxLY+Qj9CLtXGNUYmJIfa5OBROUtFIYP0ncJT3KYg8qqB1MJqcK2WSEXrTknB1qOhgTgqhYtEZ88jwXFILvKngi/NUiym/C2jzNh2Ge84+uvoSzXu7tYbkBnfknuJe13lCycw3Vdnb41iA3yNcX96C79GDUaMTb0dzqSpW1VCfB6dNDe/2nyFf3DS5w6Wgx6mddqFzxaEA3/UXTlbeCj1bk96Z2ZCBezbFY/Y3+OSaMYKfOu60CUpe4eL0qKLvNKvAY6a1lgWuhu2EJors+czSnDJIfiIUfPkH2cKkB88tEHyw803jeQUpu8mwOf4vLq/tLF0VqoPIBz+limpE7s55kaTSivNR3S4H5UZrmSv8wz8B1a1Gp0SdSugEuQDpQ1tcM0O/YUe3Nou8nkWuBMqN84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0295949e-8320-4f90-6047-08dd735ba2a7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 09:32:36.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTlQpvr7EeeA3WS9tw5IzkmTVtiLUsf8qIVR8U+TemelTfQOwVYBuoxiVOpGHxKdKi4emndJR1ugZI7xNyMQZ4R+EC0eNIxUMMyiKnSu/ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040064
X-Proofpoint-ORIG-GUID: 7FDC8Pm2mAzwH-hJUTbNDQiLQFKNNmK5
X-Proofpoint-GUID: 7FDC8Pm2mAzwH-hJUTbNDQiLQFKNNmK5

On 21/03/2025 19:41, Jon Pan-Doh wrote:
> On Fri, Mar 21, 2025 at 6:46 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>>
>> On 21/03/2025 02:58, Jon Pan-Doh wrote:
>>>    void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>>> -                  const char *level)
>>> +                  const char *level, bool ratelimited)
>>
>> Ideally, we would like to be able to extract the "ratelimited" flag from
>> the aer_err_info struct, with no need for extra parameters in this function.
> 
> I considered this, but pci_print_aer() and dpc_process_aer() both call
> aer_print_error directly without populating info->dev[]. I thought it
> was easier/cleaner to pass it in vs. populate info->dev[] and then
> read it.

We decided to not rate limit DPC and with my patch, eventually, 
hopefully, landing upstream, we will stop caring about pci_print_aer() 
altogether.

>> It looks like we ratelimit the Root Port logs based on the source device
>> that generated the message, and the actual errors in
>> aer_process_err_devices() use their own ratelimits. As you noted in one
>> of your emails, there might be the case where we report errors but
>> there's no information about the Root Port that issued the interrupt
>> we're handling.
> 
> Your understanding is correct. I think the edge case described is
> acceptable behavior:
> 
> 1. Multiple errors arrive where the first source device is ratelimited
> 2. Root port log and first source device log are not printed
> 3. Other error source device(s) logs are printed

I find it inconsistent. I won't block the series on the basis of this 
change but wanted to point out that such a thing can happen.

(...)

>> The way I understood the suggestion in 20250320202913.GA1097165@bhelgaas
>> is that we evaluate the ratelimit of the Root Port or Downstream Port,
>> save it in aer_err_info, and use it in aer_print_rp_info() and
>> aer_print_error(). I'm worried that one noisy device under a Root Port
>> could hit a ratelimit and hide everything else
> 
> This is not a 100% translation of Bjorn's suggestion as I share your
> concern (1 spammy device ratelimits and hides other devices).

I understand.

>> A fair (and complicated) solution would be to check the ratelimits of
>> all devices in the Error Message to see if there is at least one that
>> can be reported. If so, use that ratelimit when printing both the Root
>> Port info and the error details from that device.
> 
> I mentioned this as well[1], albeit briefly. I'd opt for this if my
> initial solution isn't satisfactory. You could make it more
> complicated by substituting the source device, if it is ratelimited,
> to a non-ratelimited one. However, it's not good as it changes the
> default expectation that the root port log would have the source ID.

Oh yes, that sounds overly complicated. I have some doubts about missing 
Root Port logs in that specific case (even if they are confusing and may 
point to the ratelimited source), but let's go with the series as it is.

All the best,
Karolina

