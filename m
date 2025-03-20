Return-Path: <linux-pci+bounces-24236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F031A6A937
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1BE3B1811
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C81DED47;
	Thu, 20 Mar 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cq5+m7A5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i6BN0yIw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB681C3C1F
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482684; cv=fail; b=hjq2P8NA8WyYsC50ZWeBP7Q9Zpm6fUpqVox86yFeQTjVDq2+iaDnls6ZNlwxlzv+1BQ31JyL0Ma4VgOG0kdNi+/9b8p9dz3tb2VDGCkC20F5/i3nO0gBmuuybHJh+rr9KNw0uKOYhPStTrmAP78vBhdgPobISXhWbGey42uiNNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482684; c=relaxed/simple;
	bh=Vcu858TXRybeFAWZqyf6TRuOyYmZaE7+wVzAGdxRivk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPhB7ukGw5w6HoSZX5zWPdrTQJH4dBBmZ5Fg4Z7RVcPgh4UnIfqV+tf1d49ofsMzqRsOv/FKFfFCHKnnxbOMY5qn/t9Y18/pSF+gFpO8LCIVGrDinb9s/xlGf0dBP5hLLKAGx5IeHq4oZASW07xqALavYfTvgdST5fVl1NWF4eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cq5+m7A5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i6BN0yIw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMhFF024111;
	Thu, 20 Mar 2025 14:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XmAB8k0A5FdAb+Uq0hE8rN0YxFnV2bCThU5jhyEFGdM=; b=
	Cq5+m7A5GP6npRXLO+mxridRU41KP44qn+ZrJMOWS5zUYGwLuXJcpQgVaMEeDTbn
	dzfHa/liJovlG04W1w6hPcLaqt93/S62B8FGIx50dfLFi5TZBuph8AT1y0rt2v9A
	TJd/3Ud8PUXjBYrE8TpGeZyOBAdMqJIN3HaoZFdDQvrJyVq7MHUqeIi/2LEa26Pp
	WEzQ/ZPWJx4rkKC1o4nZIhpgVMgzd+uDmY8Cz9eEH9J3a4+p0IHCBopOsBXCkTfj
	eI6YZFn5CMdm97zL7UxlfYH4yLJPOZRAzNqnZ0SP/K1s4EE8sVUyXSRpvVgrchnL
	rHxEcLPrzOctjdNpZq+fhw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbema9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:57:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE8fHe022438;
	Thu, 20 Mar 2025 14:57:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc8p7af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO9jK2cuiGIzs8uQPzc8q3VlAMFyyZweS7a4NX5kPbam2k4O1OPQ1dDgSjGieWp9f47U2XWHz6tK48+Vp1fFq+k/S2UDSDoBkYuxhsdLAIjyrchhe8ME4BJX0m2M0kjTsrqeMMy4zYVT9UFxYF2tCw2Nd+Cmnennv4PM58N5ejyoRb1W1UMjw4H5f0fFglIl0/0lIAJFzKqtwXbkTzNBpMsoeNy6+PhJdNGtC828YJrkskYVatXWn37Dg7BHARhNvkCHYOnCks0R7OyM3CmmzmymwMpwqkIWMxAd2eZPghYfJIMuzpRBfFBv30xeP2RbdBo2Th/iHfsyeAmUhrcupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmAB8k0A5FdAb+Uq0hE8rN0YxFnV2bCThU5jhyEFGdM=;
 b=yMZ2pPuxlnNeb8gHEd6us2I0behgz4cynPtq7Mivdjhe+RCZyEZtsg8r4CDThMeX6JPopg4jXvcKik3D03SHYWjSlraRL+biXYr37CHbKUatkT3oaXFeW/fozUkLWFabi8efjtdw//cDMBulMXSE/4OLoRfs30zPh/JVupt36/PC1oVVC13SQuX/v7+W3cWZL5q9P8yiiB7ycxqphQaSQovl6W8B1M3j42B4gKFGIeP17w6sGbeRQarGF2aszdDlKB6+JIbVvPMIFN7HOhM9pn/jn61IzaQdlMHvlr3zTWBJB66wOQI4kmVk4cwVAxetnVMCaemx+9Nmfwz7m2ZiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmAB8k0A5FdAb+Uq0hE8rN0YxFnV2bCThU5jhyEFGdM=;
 b=i6BN0yIwYI6AnRPL+aFbN+1SDWivG+9bOqW5axu6eiq7vgH/GAHqwpO0lYSvFoeiw7ApzmXGaCWcZPhPMclWKHcDSXtmZrWSX0Fx9wGDDPBo00u1RPIXHJKuPRpH1w4QOkqpMWH/pAX0ZKgUKH3uwZEMbVwNzpXlvpNLKXFzt3Y=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CY8PR10MB6876.namprd10.prod.outlook.com (2603:10b6:930:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:57:42 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Thu, 20 Mar 2025
 14:57:42 +0000
Message-ID: <e214a067-b152-4dba-900f-361e4daca594@oracle.com>
Date: Thu, 20 Mar 2025 15:57:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] PCI/AER: Add ratelimits to PCI AER Documentation
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
        Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-7-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320082057.622983-7-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVP282CA0015.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1fe::13) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CY8PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: afa2a441-6d20-4cf5-db87-08dd67bf90c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym45MlNTL285TXdUMi93c2N6VUFWbVlxRWVhZml5bXRkN1NESDZIM3drc1Ru?=
 =?utf-8?B?SVFjVm13K21FSDlYbFViWitDQ1BqdHArY3RRLzNOU1QxZU9VT1hPSVZkR2My?=
 =?utf-8?B?Zkl3U2lNK29NTkFFK09QeWl5anZSRittUnMwSUVoUE1mVmZYZWxlTGw5bmlN?=
 =?utf-8?B?RHhJaEVDVWllUldONEJwaERFaU1IOFlvNlFPVkkxYkMydlJYWnNyL0h3cHlP?=
 =?utf-8?B?c0x6OG9PUkEwREljdVhOMDJiTUZ1WDJCK1o1cDFzdy9PRDluOUQvZEVnOFZX?=
 =?utf-8?B?TVIrQ3VNcTBDbTEzK1ZCU2x4OTQwS2NsUU1LdG5JMlI5dnM5RFBsVHN2SEpy?=
 =?utf-8?B?dWwzbUlML2NFY3RrbmdYN1I5bFE0dkpxaGl0RnhjaTA2S01FYTJESUZJbW9M?=
 =?utf-8?B?b0Z4QWtkdGNob0VVZ0ZTejR5N0h4QWtkZU9WakFPZ29WVTBXN0FEb0pFOWh1?=
 =?utf-8?B?eVdJUXFJT1JGV2c3V0ZhMUhJNjNkejQ5K0Jic3JZN2pOZFJSZGZsVGp0MzZ3?=
 =?utf-8?B?K2lWelZyNUR4NGFoZFJ0dU4xdk80OVdsZFdBbVpiZTVLeWdTQ2NvU0tMWk1G?=
 =?utf-8?B?b2ZrOWRkNUxzVzVhMzFQd1NLcDc1cUJWY05ScnJGd0xEazg0QmFESnA3Y2R1?=
 =?utf-8?B?MXJZSVpJbUVnblM0SXBoZkhNL0NjenY1cDBoV1c0MjQwZlI3QUw1WjZ6WS9V?=
 =?utf-8?B?ZVF5VnlzYU5USXRxZ3h3WmZDMitCL0pkNzBrbm9WNjQvYkdveTdBa081UUFo?=
 =?utf-8?B?S0FBMUhibUpjTFRaOXJoQkFWa1IxY1RCTFlqT3hQUjMyYldMQ0h4eUhlTG9m?=
 =?utf-8?B?dWZEMHo3ay9WeitSeFovWjZmWGxKZ1IvZmh1cDBQeC95NEZQMlBLTEJ4Nkhp?=
 =?utf-8?B?ZzhsSTR0QzMwbUE1U05wb3hxaUQrc3FnbnQzSk5tQWQ0REp1U240ekkzZm92?=
 =?utf-8?B?YW1TbXFua0tRaTRFQnVkeGRudmZNQW56bEpsZnFpb0VyV2pKS0RRRXhRb0hM?=
 =?utf-8?B?MFY2VFRHOVNZZU53MUw4OVlTQVJzS0R2NTlsY2NVYW82dVEvc3hLS0tEUlp6?=
 =?utf-8?B?eEt6TE1LQnVvSEFBTDVaUGRMWW4yNGtjbGlBKzZTek16dVBIcXBVdHY5WUpJ?=
 =?utf-8?B?cVIzWk1ZSmJweVltZUF1L3F5U0ZlNVNjeUdKRVFoYnpMMTMzMFBPTFBvRGhV?=
 =?utf-8?B?dWNDQ1U2ZVNraUE5SmpVNDRWVEpXdi9qNzJTRGhVa3YzN0J4T1JCRFdvRUFF?=
 =?utf-8?B?TUtST2JqdWluOEYxdzRuU3NYL1NsODdGZmJiYkRhYjFTcWEwVkZJb1dLa0Na?=
 =?utf-8?B?bE56QlNTNkorRE0wQ016bXQvNFBmTzRyajRqTnpqSlZFWXZRN1YwSy93UTk3?=
 =?utf-8?B?a1crYjU0bUNSYlBjRWoxNStzSEMvcXpJeVJUTC9Wb2pKWkNPVE04bStkYnQ4?=
 =?utf-8?B?RFRCeFFoWmhEcDhPUTFrMWRBODJKd1VreC90M3FKaFEyQ3ErcTBMY1lPVnNo?=
 =?utf-8?B?VlZkRDJTdEF0N0J5TmY3RllJM04zRVFpL3R5RnUveUttS25Bbk9helYxMlFE?=
 =?utf-8?B?NzJ3Sy9CcjhKa3lTd0JxcjZJSGhmNWJJOFpPKzE4WnFNTDMrRmJzR2NCVEJK?=
 =?utf-8?B?VGFnL3REaWdOR2Z0dXQrdlBIenJ1TzlURzdLTUQzcUp0d1hIbzNReGtPd25y?=
 =?utf-8?B?dXNGanRHMHg1TXE1cHFWZ21qT2RZOEV3QWxmMWhCa0s5MnlzODQvamhoKzkw?=
 =?utf-8?B?LytQaW83VE9FYi9URWhqZnlNMmNBTmNneXhraWRKSGVTZHh0UllJQW5VN0RG?=
 =?utf-8?B?aVB0QmplN3BjUlRGYTBrMUVVME53QkwrUEx0ekJta3FESzNDT0dzUWlKSk9y?=
 =?utf-8?Q?z2kWFImxW3O46?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0ZqUzVBT3JydUh5VzZXZG5xWGk2UTNSWEJleU5KZFlrRE9peklJZGpjYk5J?=
 =?utf-8?B?amlSeEllUlBYbHo2VThzbnVPQzFDNVpoK3FWMFdrMlZlWWFYbGc0eUpMTFN6?=
 =?utf-8?B?ZW93WW5hbHduS2hlWXMvL2dTZFdhR1ljZk5vUWxpMVp6SVowdTNTUzdGY2RH?=
 =?utf-8?B?QWxBdTBBRGxCVEpZRXo3QUVIa2VZT3RVcHJUcUF2YVFjSzFXd3lTWEFuVlFB?=
 =?utf-8?B?enUybVV5elp0UE1jdHlobmFnVkp6MnVvZWhHdGg0bEVvYWZQbjBkWG00SFdL?=
 =?utf-8?B?cFJjZnpKU0luSmVHT0RCNm1DQk1qY0VxYThHR3ErNW94ZFdTdTc1VHJLdzQ5?=
 =?utf-8?B?L3ZDKzgwWlpXeWhGVjN3bklNVDNFcHZtd1dVMHdlbTVhc01YL2F6MWhUVDV6?=
 =?utf-8?B?RUsrUkdveno4bFpPZFA4SFlPM2N0SW1WdjhYSUlkUHp4T3lvMU9iVDNpUmlR?=
 =?utf-8?B?aFdlUjB3OVcwY2p5RVhwaFlpQ0JGc0RDUndaSkZ3dzh1UzZjdU9seWRWN01y?=
 =?utf-8?B?SURPd2t0WGF3U0lYRytaVnJqTUZKOGpxbVE5eTZ4WEU5bW9Ic3d6bHhVYVBU?=
 =?utf-8?B?OEE0UTJucnNPSkhoam9uZUZhbHcyLzQ1QTUrd0lEUEdwWnJpYWFzVE5ubXV2?=
 =?utf-8?B?ekFPdkZjK3FGYVd3c3JnU241RzJrWUEvenE1MmxzMXF0Tit1M2w0TVBUVjhQ?=
 =?utf-8?B?ajJhZTRvWmVMTjg3VkdlVDlBN2graENzSm9xNnIxWlB4RzlrNWZDRTZKRTlR?=
 =?utf-8?B?MXU2VVpyLzFDTlQvQW80RFN5TXRBeDlnRDk2WjVKbit3aVkyaWphQ1B2OWl2?=
 =?utf-8?B?ZlY5TTg0SHkxZGhDU3dVT2U5RGtBd3NlbVk0VklXczZNdE1Fc2wxS0pIakpP?=
 =?utf-8?B?Y2I3TERyeGFFUG8ybDI5eXhHdlZWNGVXY1phUjJHdCtIYUtmUGFRQVUzZTZD?=
 =?utf-8?B?WVdScnJWUVEzQmZVNTRMaEZBVnJ5c3psa2lpeXYyalMvaEtJbitaYnhYdmxS?=
 =?utf-8?B?a2NJaVIyNHpUNG5FTVdnNmJreXBtVTlwNE95T2Uza0N6VEFKcFFYc3VSZ1Nx?=
 =?utf-8?B?aktFZWxDL3VESlZEU0t2Yk5kT3pYQ0VrTUNMdE9OWkhjSHdkd25RVmNUSW1D?=
 =?utf-8?B?MlFPQmpybkZsNzhRVUdUVzA5czJ2ekhwdDdRZmlzVVBjVzQvVkJmeG00VnlG?=
 =?utf-8?B?a2VuZDQxcjVqWEJzVnQ3d2s3M2xvQlZQbTVqa3FJWVhxaFNJMzlFVjdpdnpl?=
 =?utf-8?B?UWVKdmVLMkZObUVNbWFhT1YwL0xTME9ERC9aVUN2ckJMSzRUR1hHcVh1eWdF?=
 =?utf-8?B?WXZJeHJyWElQdFdDTzdObEJ1bFV3Q1YxWWJKRy9yMUdsWmF3MTlUbGw3dEtK?=
 =?utf-8?B?aFh4ZysrdjlOTXpFZmVsZUJtVHpiMXptTmFLallZczVqUDNpWUhsTmpuTzhX?=
 =?utf-8?B?enUxWE1Wd1UvcmEzelFYN1Jla25xamY2VXlZUXZBTGZSVmhBWW9sMG81UUxk?=
 =?utf-8?B?QVMwSGQzeUxJRG5OVGtwODA2RDFHdy81NGdrZTFBVnBBU0gvL2lGNFE5R0Zw?=
 =?utf-8?B?MVIwOHBEb2RCYXlFVGRKOWxGbWZzZjRwQmxlUXVjUlMyVkNkREswZkVmdGZs?=
 =?utf-8?B?V01VS3NHY1ZTVVBWUGU0TFpSK2NrZkVzdEZEQVkzU1JmR3dSZDdmRjZVT3dj?=
 =?utf-8?B?VGFORzhsdEdncXZqUTJzS1Uyb2thcEMrRGhKSUluSFQxaVRITmZGbDRFZG5O?=
 =?utf-8?B?eDBLbDhmYWtSUkpCRWtyMnYwQW9NUWp0dkZaM0xLcmZNT1V0SmJyaUdTRjlT?=
 =?utf-8?B?OG55MXdCdURTWnBlWHFWQUhydGNla0U2Q0E4MVpYdDhWT2c3dDVMME5aWXQ1?=
 =?utf-8?B?L3JtcUNoMDJVSEdIVU9acUoxTk5BZTduQUlSRDBkSlNTenI4SEc4L2M4WWZx?=
 =?utf-8?B?eWZDeWI1ZVBVdjNKeDJpYlN4V2dRVmNpZUdlNEt0YStJVDN5bmtKTFNnV3Q4?=
 =?utf-8?B?YVRqRHhzVHJwbm9tekN4c3hIZitvNHdlMkZxTStRbTVETldMUWNFaHNIQjhW?=
 =?utf-8?B?VHVlcEJWWHFkN0hMZ3BWck1NRFpUaXJCMG82K0VtUGF0ZnMzK1B0Um5BVU1v?=
 =?utf-8?B?ME5tbElhM3Yrd0FoSHQ0c0xQTmx3TGREVUxWVDJrT1dDS2VBN3BWcTVPam14?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/ydYaF19GWy/eyB3Zya4V/0+uEX78+Hz3W5jcNm/XF1WoElsRGwRLwnULiyQueS/vcg6PUEsbrTdrzmMH3pWiHWtZ6XMqZBQCyMC49WZFiOzChYBScEDVmhs0H7sQK6+HnP+lKwerNvV5ue5uGDE/4joVNQ8uBoEvDz1PcbIDWTGZHgnHQqdjuS0T+sANdy90kPY8MMZyzNfVI7uZCwtG6rrsesvDiOcRkTiiW8uVg5R+BBXUNXDozlGHID62xKIjTfFZddcNH6TLqIrgK6fR8Hpc3EQXRKKdlbHcnUonBrLNtwl6GOLXubOTrF4c99JklUKSGG3fPWot5MeUlGWYadYDHjt4ZSct778WGpDEDpMzbghnSA4Crol276muFv89GkUal+oFUVEd3/uryTp0etz7cyVso1MJEBI2clecJWpvDvh7yMYDYfCcfLFNpk7YAyNPuEpd//y6UC6ztsUrWyojztim56Vv/Nm79GWC9Qax2fwjQPHK6z5jCfR/zkz5bOYEgy+WDiBB4PG+uBKB+8eW2bW252svzFOhTY0Tynk9VWQsAJM3Cs60HkdKZHAYWKxo90aOHxqtMWGeHFovKL9NVM7XYjzh/5AipvXS9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa2a441-6d20-4cf5-db87-08dd67bf90c5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:57:42.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qxwmqkgzrd6n97mugVNxyNSI/LebNXsEje38n9KnDOSRDIVreVX5EfC2WfqqClyM1Lc0Rn31S6d7Uc4x7VOLInxe8eT0FMBnGrS3SH9v/Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200093
X-Proofpoint-GUID: _uskm81ZdxoeQ979mUbDWkEXR_usFBFH
X-Proofpoint-ORIG-GUID: _uskm81ZdxoeQ979mUbDWkEXR_usFBFH

On 20/03/2025 09:20, Jon Pan-Doh wrote:
> Add ratelimits section for rationale and defaults.
> 
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   Documentation/PCI/pcieaer-howto.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index f013f3b27c82..896d2a232a90 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -85,6 +85,17 @@ In the example, 'Requester ID' means the ID of the device that sent
>   the error message to the Root Port. Please refer to PCIe specs for other
>   fields.
>   
> +AER Ratelimits
> +--------------
> +
> +Since error messages can be generated for each transaction, we may see
> +large volumes of errors reported. To prevent spammy devices from flooding
> +the console/stalling execution, messages are throttled by device and error
> +type (correctable vs. uncorrectable).
> +
> +AER uses the default ratelimit of DEFAULT_RATELIMIT_BURST (10 events) over
> +DEFAULT_RATELIMIT_INTERVAL (5 seconds).

This is not quite true, as we double the number of available bursts so 
we can print both the port info and an error message. We could say that 
this limit (2 * DEFAULT_RATELIMIT_BURST) roughly translates to ten error 
notifications within the 5 second window.

All the best,
Karolina

