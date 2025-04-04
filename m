Return-Path: <linux-pci+bounces-25320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8CA7C655
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 00:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92A53B6F5A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Apr 2025 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3619E998;
	Fri,  4 Apr 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="mobGXy3W";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="LKtVYdzZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138F2CA6;
	Fri,  4 Apr 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.155.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743806182; cv=fail; b=RmzQLDRc/21YU+AJfu1/bnL9De9rU0oGAGoe3g5akZ+eIK2o9qMgXxa22DlMKMHTcekaBRQ7MmJ5uBKDwtdZ5eJiEZSBVesqA3i0chmiaNXRaQhUtJuXKEdQpet5C80mcSTYZtf2AuWvZMToLFHzkuBbTbhgk/+DJG54RhPhHpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743806182; c=relaxed/simple;
	bh=HDnVwrIjHPUSuSjsVOtXJcK2aUV4NEY0qEO2Xs6wNpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eez0w1Nog8jGsuh7FyA2kmJ2GT2UGPbA3+lYg70J4O503ONqeqpZtsjsFgcxrCEdtZ4e1rUYJgtfVSpkiRwY0WFM8W2YhQm8csPQlWdScvvPGpQ32E3Ag9mMle4PwbvHR/iQAw78oEaKfD2ZJRQs11d4peVqEnuZGSCt3xe+e6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=mobGXy3W; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=LKtVYdzZ; arc=fail smtp.client-ip=67.231.155.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0422210.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534A99bf027534;
	Fri, 4 Apr 2025 15:16:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=mobGXy3WNTKZLeChVT+jBY9n3u3Bob36Bn6ew4inU4lvckd22un7x9M4wN+3UuePn0tu
 8zewmfeJFkhiYKr9mKoIyTIprMvFfoYWejr1jYEF44zFF7WNx/4RmeaLYrMLAe9F8tnl
 qMVZYwlXXEMy8xX4LqAKhf7OKRKeB7EyDHTaZC9Leo9PoW1KN8ekGhP9rBQ7dE4ADP0D
 x7rhavzfqM7aKuCYp7+DU0sB4GlqNVv5lVBe5yYsRUQydw1wus2tDsvh3zXSUYa78O1g
 dMMTYdJSl2v/5gcPkIVWewAP8onfOOPC2iEX1l2xakEa+dhp1fYKmeeMSeeGmBor/BTA mg== 
Received: from ch1pr09cu001.outbound.protection.outlook.com (mail-northcentralusazlp17011028.outbound.protection.outlook.com [40.93.20.28])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 45t2cd22s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 15:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adrXzPFou/YH/owjFhsleVRfoAC1njr4SYIbvIkmatVqWgJKZC/mTTWIy1fhNmN6sv/9bhFQmc+q18LH7Kg59kBpHdsxb9NkonpTe1HN0yNvr/l+HFMULoHsWKTb0GK7H82zmUEuuOA+PldvRWRlhoIF+qsLWcxCaWG8Z9NQjPCvAkvbv4tjS4HeQ3L09A6+FN9dxFKp+j6EgBozg1kER6LLyVgkm+SFADeOY+1f/bAhB+1HBsqos/0C//gr7K59yuEFGJnXPPjmjr7vVy6mguHZJ2amY+SPOBgcV60NXEm3RtYXH5PxsRs82yRAHBSvlJZOJC5IiexjoRhPX1D31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=qRpAqYkT6PS4IbCbnP6tfIHVqglcoh7fibO6DD54NI/kpMNAYyJIYv4aLzwMsQFaTtcTUyu146rQfn7A/4zFQjtZWzVzjje7zeuh7k882YTxj9HPRn6W66Q6yx2sOezVtP5j6AHnLyxy6mXZMAKX8pHTF1Eawq8/ThIMuYm/03BgDcqa8YsKPKmGnhRSCELSdRrdMouq3Jy4N22/7KrQ1NOeXZXZz4izv7zKtgzf8kNd0ezibjIeeJT9s9ih1BRZ/zNdvxKP1C/KlprFIhTGCEn3EvMRp6y6UxRsjZWoHl1ZcHJq94xIyGUhmAm2w5+A99RzEIzsfKcRCfuDLF2K2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=LKtVYdzZMvDWFj4SDp66Z5GPZ967+GAcGrJ34o+obqPXPpZZf/diTMJulbdtZbbFSg4mZdpUE9DuL38hg4tNZPuPr1aS56+ftiUPjfXOevrbV+Zfy/NqXmaFprULawVvsWp9yQY6z78dS7iI/aZbvC0q2WgCVYABguTlERdVTIA=
Received: from BY3PR09MB8834.namprd09.prod.outlook.com (2603:10b6:a03:346::22)
 by DM6PR09MB5927.namprd09.prod.outlook.com (2603:10b6:5:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 22:16:15 +0000
Received: from BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39]) by BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39%7]) with mapi id 15.20.8606.027; Fri, 4 Apr 2025
 22:16:14 +0000
Message-ID: <e546d486-8c33-4b65-846a-123674df1a11@llnl.gov>
Date: Fri, 4 Apr 2025 15:16:12 -0700
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 RESEND] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2e31f750-5ff1-45e9-bf68-47530a957596@llnl.gov>
Content-Language: en-US
From: Tony Hutter <hutter2@llnl.gov>
In-Reply-To: <2e31f750-5ff1-45e9-bf68-47530a957596@llnl.gov>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To BY3PR09MB8834.namprd09.prod.outlook.com
 (2603:10b6:a03:346::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR09MB8834:EE_|DM6PR09MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfe12b1-8a00-4d10-9365-08dd73c65006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MC9xY3hDTnM1M2J3eUlvdEt5SEY1SW9Ha2dZSnF4SFhObVpBVGMwTmptaC9Q?=
 =?utf-8?B?SWZJQ0I4eVZLbDFaRXoxZis0TjV3ZFhBa3FMbHBkTVJkTmg0UGhkcWxHLzNT?=
 =?utf-8?B?V2EyS1E3dWJuZGdWaVRodkhpcUJuVUlvQzRKMVU1akZGK0xqcG9UdVAxZDBN?=
 =?utf-8?B?VlEvZnEwMEV2ZzQzbHg2VjU2VXpCMFJMRnMybG1oVW9lOENnY24rMnBYalN6?=
 =?utf-8?B?bGZUU2QrbncxSUdHenFlT0tCaUg0c1BHb1BTUEo4NytQSWVaYzdLVzl0SGg4?=
 =?utf-8?B?cm9nQnRJaU01NGt3RzQ5dVR5RlZxL0pTZ2lNdk1UOWFoR1NKaHlaRk5XYjR0?=
 =?utf-8?B?U2ZJNHM5WGNTV2NwQjdqeDZIR21hR1N1NUJCbVdtKzcrUnNmRTlyNU8zemhI?=
 =?utf-8?B?MWdWeTlTaThManFlRTFHWTNMOTNHTWFmV2toanVlZVMyWURSS2YzNkJoeWVs?=
 =?utf-8?B?b0RQeVJibVNEZGFXZVcxT2ZvV3FzTTBCQUU3TGNyalVWTU5LU2Rld2MrUlIr?=
 =?utf-8?B?UE9FKzMyc3UzRm1kVnZZMTJLNmlaSjNtVlFHRG9vcHUxWnFJZE5jUnVHTklH?=
 =?utf-8?B?aTJySHRkNjdrMEwzZjQxUDBEV3o0ZXB0K3JZK0gwQlhPczNHOUgxNFlWY1hs?=
 =?utf-8?B?RHVqcm9JOFBEN0pESmRaV0x4NFovbUdraWpkdFF2L3QxR0lTQU1vczJkRTFa?=
 =?utf-8?B?cDVMYmNmZjZpaEU0R25hT1AxRlNsSjI3T2IzSFJZcjhQMm1SMFg1MklGNDdH?=
 =?utf-8?B?bDllcWQxenJFU25QT1hJeDh4elpycWtFbll4dCtJQzlYRVBoUTdHM29vSVNx?=
 =?utf-8?B?N0g0MnBkVW1GRmNkMFQ1Nzl5NlJxVS8ycVc1UEk5SGp3QW1ha0JnV25GQkR5?=
 =?utf-8?B?QWNzT2FHbFBiTnlIT2VNL2pzc2RyblFvOVpNM1JUUktnWHNsSWtQNFRGcmJs?=
 =?utf-8?B?OW1xcjZtRkV3L3hKWGtsTm5uNFNnaGpkSnpOTVZYV28rS1Q4Y0NkcC9jQWcw?=
 =?utf-8?B?RjQ0N3kyajZXQVZmd2w4SGtjeEYxK1FyZXRZZmwvZ3Jzb3doQnVqbVpON0N0?=
 =?utf-8?B?S04rbHU3WFNEK3c5SXM4VnE4NWVFUitjUmEvYjN3bVRmWkVCTHhnc3ZPSzBN?=
 =?utf-8?B?ZW1neFpZZEZmNDZaeit0S29uTDBMblZkQWcvUnZmZS85UVFDa0p3aHBraDR0?=
 =?utf-8?B?YzhEUWc5Ums3MkhEc0tkeVJwWHgzYWY1ZGcyRklrUnpubHlHekxKMkJBUTlY?=
 =?utf-8?B?ajBBMjhqVE01T011ZUJHNHBQMVI0aklybUdqUXBzN0hyQWVmSG9SQ1p3cTFy?=
 =?utf-8?B?RnRDQ0R0a2ZnZzRrK3RqZzhScE5qTHcvdG5kamZubVJCSkZ1MDcvb1cweHAw?=
 =?utf-8?B?L2x4Mjg0cWxob1ZmaGkvZ3JFM3cwTWxmdzlvZDN4eW5IMVdwQkFEdHR0QVRX?=
 =?utf-8?B?Y2k2Y1NJOEpPZmVRd1plYm1FclBJUys5WFdLWWZGSE1ycDVPRjFSUE5VcEcx?=
 =?utf-8?B?U2tDRFJtZ0tWV3FTSTJONUVhV0gyWktHN3VvN2d3Uk9SdzlOc3AxQ0ZnL1dO?=
 =?utf-8?B?SXBTZWxhdEVVaVFTcUJ1bDZaZVprSEFPdTlxMXczNmdCdTBNeG5rUy9mZUdF?=
 =?utf-8?B?ZG84aDZlTUltcmlJcWtWcllTN3BTcUFBMUVYSXR2Y2RFVUkxMUVSZXlOUGNx?=
 =?utf-8?B?M2hMZUNJN1QzN2tzdGxOR3RYSmt0SzF6ZmtzazBVR1hTejl1d2UrWUk5dSsw?=
 =?utf-8?B?blRJS0dEeTNuQ0Z0NTdBc0RzdnZFODRNOTRNTVlBdjBKU3FaTnorcy85Nmdt?=
 =?utf-8?B?WmVqZUhpWHJrejVwOWJEN0VUZEFCeGtmYURNTzVMc2pORmNiaThUdjVyQTlk?=
 =?utf-8?Q?5cgDJS0rMf91B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR09MB8834.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkdNcWxxYUkwWHJFTUJ5dnVDWjAydWZNcE4xVlIzeDREK1pqY1dFZTVnNEZT?=
 =?utf-8?B?MHpheEQzRUtPcFo0WnZYcVB4QlRiZW51SkVDa1VJYk9lSUF3ZkY3ZEdiYkpV?=
 =?utf-8?B?QVB4RGZaL2JxN2pzR0x6N1pnd3BEVnNlMEFBWFdCdXVKenRxT2k3bFFLODY1?=
 =?utf-8?B?NlhzeXo3MTZPUS9MK1l2TTFiMjV4NFdFMnFoRGdCWXlvcUtrdm0vUHl4aGk5?=
 =?utf-8?B?L1A0Q3U2V05uYkxrUHRCeHo2SDQ0V0NzWDNoSksrK1owVTVPTklKakNJZ0Rs?=
 =?utf-8?B?MzhMVGxjR0dVdVBsamR2OFcyaGpYeXZsYnM3dmh5V0doR205VEtOTmdiQTg2?=
 =?utf-8?B?dnNLQnhzcVY3NUxCbUFOUWJGY3l1ckpDU2RQWEVSc3lPOWtqSHRJa3J5V3FP?=
 =?utf-8?B?MXVLbXNCUDRCM2FIODBSbzhVMDErL0d1OGJWcU1iOUVJSWpWMHhzVFF5d2lP?=
 =?utf-8?B?ZDB1M20zNHdXZVR0ekhXMjRmVWdQdWFwTTFLenJ5a2RBeXYwdHdEQmU0R01Y?=
 =?utf-8?B?Z1ZuMGtMNzJiSjJOQWZpYjFkcUMxSlE4K3ppNXhqTzNmT0JEWE5uM0ZHU2tm?=
 =?utf-8?B?K1I4M1dkY0JpUXpyL1U5RWYyaFhrYmhSL3pUQm1Cek03ZFkrbElyRVo1NFJk?=
 =?utf-8?B?bDhYc1BGbTljTDgvYVZyU1NlYVdSa1RDOTVaNEJlQzJZaTFvaHZKTzAxQmxM?=
 =?utf-8?B?eFUwZWovaHUyQ1hrd1FKVS9uRVE2R3oxMWx2THc2ZTZzcml5d2ZCK3BpbTN5?=
 =?utf-8?B?clI4SzBFK2lHblI0ZkYxU1d2YjFVYVB2OE5JcGF2UllJbVg2MnpTMzFYeUhY?=
 =?utf-8?B?OVVNUU5OeGk5Y0c0OENjMGFsZ2dSeXFPSEFuYUdDOWtoWUNXUWtkVFczOVJo?=
 =?utf-8?B?UkpicndjZnlrODc3MnFjMzJUdDJTS0tabDZwTmJ4N0wwWVlJUFZJUjVtdmRR?=
 =?utf-8?B?NWlqRHpQU01mSXY3SFZ2RVQ0UjVOZFRDRzFEMlYvYnlKOU5FMElkWjF0ZE5Y?=
 =?utf-8?B?ZGhza0M2bkhPeUY1Q1pORmFVamlTZEtOSEplZWgydVp4SXY3VG92VGlPSTBC?=
 =?utf-8?B?Mnd2Rjl4dWp1cVBQSUFoTmtQVkJlZ3BSQUduaFk3YUFCNUt6bWlydnErSU11?=
 =?utf-8?B?WlF0Wlc3OVVkcWVqQTJlK04yM1F1WEhZM2ZtRHBpcFVKbVJaY0ZsRXFlTnVB?=
 =?utf-8?B?UnlVY3ZVU3R3YnRKVnRETzRGbG5mbzdLMjFmejF6RVphbUtpUlZnUjNDdVVO?=
 =?utf-8?B?RVZBdVBIaGthcVdnVGZyY1lsVTNjaE5DMndxeklUMVFtYkNvMDJnNUw0allS?=
 =?utf-8?B?L2E5UklDTzdvUU5qamZQaDRqZS95eVpNdmZUTmhWUmp5TVlXeEFMOFp1TG4x?=
 =?utf-8?B?bnUxUXBjMTE5SGlYbTFsM2R1Z3lUTm1GaStTUlByclhEbEp4RHNnakhieG41?=
 =?utf-8?B?dkNEZkZyNk9mNHBIWlExRkRrc0Z6M2dyRE5McDdQYm5hR0RyNVk5MG8zTmRs?=
 =?utf-8?B?WjRjVEZKejlsUEhrbVluNzg3dUtLSGdUcG9ZaUk4by9zNWpnaUEzMzVLRzE3?=
 =?utf-8?B?RytOcFMwVDB4OXZPZks2WnVwRUJvT1VFUWdnZWs3MXRMWW41ZWVPNjZDZElx?=
 =?utf-8?B?ZGZNMklJU21qclBxN0ZHR2pRQU5IWUV6REZ4OFdLMWErNnp3SlRpK212alNN?=
 =?utf-8?B?Mm5tYS9SQ1dwWm1qclY3Y2t3Y2JNRlRFa2RUYk1laFA0NUFmdFJkL0NYbDMy?=
 =?utf-8?B?SUliaDgzOVA2V1pRM3JBQzdxRGVJK2JpZDZGdU9GZkJxK2ZXQmdaWnVkYm8y?=
 =?utf-8?B?SkRnOXNmTWk5M1VGS2hrdkhVR2dpYjFsNW1FNkZEbHJHQVNqZU9wczdOU2Y0?=
 =?utf-8?B?dVNXN1lBZWkvQm91clRNUjZmTUpBT3NMTnBTbXpqVEEyYVFJZ0hZNVZITFZn?=
 =?utf-8?B?UUtQVC83TVJaeFdUS1M3ZFpVVnlkM1o3YkxVMzVGNVBPZUxBbkllODdiUm95?=
 =?utf-8?B?MVkwQjdUR2hXSExXamlxc1VEWm1QeXBIZzNDWFBrMHFhM01nY3VHTHd2dHFy?=
 =?utf-8?B?NENLd3Q2Wnk4a3BnY2p4NkIvcHRDZm92bjNvVkNWRXR5dkFqTnVTb3JrUVBp?=
 =?utf-8?Q?x1MESZMr5HFNJrr70imm2mRr2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Zu6A9krAQqLakINQyWORCkrkOorzMo/RubQLwJ2BXpEQ5wKcFPpjo7S3881IuYvua9O4sZJavqTDgYrS1LPLBxB7PE3w1ifUx++NcW51wvEdsLM2pIQ3A/sYyV0gYmRfnokI1Sm5u72nGY5yFcBkY+339SKaehFynDF7mz3BmyiX3haWx1HAxL8uEv801HMf3kb7qIQDkSAvojFo3YDN65FR6vdNsJJRNX17bxC6Bx8OrpZA7EUTpRoPygcysThltwu4jCyp37RF97YecTLHOXAwqa1MVARsiw3p3vr6l1mkZ+ufLbuLLQOwg1Ro7mOw/q80fCE/HTOfYx8T/raVZZbrulyrGYylFmeMeP8gkhU11MEIUbAyGXNbmYWPEP9aMNRC6cLbkZMjAywkTVd0GJNtfNVyyDsHcidV+kmKN5ucu7Rjqs9t2NLos/iT6FgLi4fQccVaUwbCkZRFsCprSFvgMN2jD/sFkIJ0ST6+ZIThcgVmfhbeSEoCmuNDgdgrdwB/t/fVCZ1UevOUfsVN419//S9Mp2i5eLGl6N2XiQ8+R9Ex0M57ghXO+gLSQij4NzTCu5GXaQXGodxdUAkz+gN5cqycQcBIJ/dvefm18pY7sDV2wF+Bm4KHYDcW5lNUGYntZYaoeONCCw7mtAQOQ==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfe12b1-8a00-4d10-9365-08dd73c65006
X-MS-Exchange-CrossTenant-AuthSource: BY3PR09MB8834.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 22:16:14.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR09MB5927
X-Proofpoint-GUID: PyoCv17DYBEO1rIS9vIr-I2pvi735-rh
X-Proofpoint-ORIG-GUID: PyoCv17DYBEO1rIS9vIr-I2pvi735-rh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504040153

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
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
 drivers/pci/hotplug/pciehp.h            |   7 +
 drivers/pci/hotplug/pciehp_core.c       |  12 +
 drivers/pci/hotplug/pciehp_craye1k.c    | 659 ++++++++++++++++++++++++
 7 files changed, 717 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..1b83c43a548c 100644
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
+		2 = blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
+
+		Using the pciehp_craye1k extensions:
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
index 25c86f47353d..a33920820c62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6122,6 +6122,11 @@ S:	Maintained
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
index 123c4c7c2ab5..75c77cec0b21 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver is it not possible
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
index 273dd8c66f4e..ea68ae041547 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -198,6 +198,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+bool is_craye1k_slot(struct controller *ctrl);
+int craye1k_init(void);
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..9a7a7b320810 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
 	}
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	if (is_craye1k_slot(ctrl)) {
+		/* slots 1-24 on Cray E1000s are controlled differently */
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
+	}
+#endif
 
 	/* register this slot with the hotplug pci core */
 	ctrl->hotplug_slot.ops = ops;
@@ -404,6 +411,11 @@ int __init pcie_hp_init(void)
 	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
 		pr_debug("Failure to register service\n");
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	retval = craye1k_init();
+	if (retval)
+		pr_debug("Failure to register Cray E1000 extensions");
+#endif
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..844b36882316
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2024 Lawrence Livermore National Security, LLC
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
+#include <linux/errno.h>
+#include <linux/dmi.h>
+#include <linux/ipmi.h>
+#include <linux/ipmi_smi.h>
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
+#define CRAYE1K_GET_LED		0x0
+#define CRAYE1K_SET_LED		0x1
+#define CRAYE1K_SET_PRIMARY		0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define	CRAYE1K_POST_CMD_WAIT_MS	200
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
+
+/* Return parent dir dentry */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (!parent)
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
+			dev_warn_ratelimited(craye1k->dev, "rx msgid %d != %d",
+					     (int)msg->msgid,
+					     (int)craye1k->tx_msg_id);
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
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
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
+	mutex_init(&craye1k->lock);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err_ratelimited(dev,
+				    "Unable to register IPMI user, iface %d\n",
+				    craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	craye1k_global = craye1k;
+
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	if (!craye1k->parent)
+		dev_warn_ratelimited(dev, "Cannot create debugfs");
+
+	dev_info_ratelimited(dev,
+			     "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
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
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
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
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
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
+ * Context: craye1k->lock is already held.
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
+ * Context: craye1k->lock is already held.
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
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
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
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_GET_LED;
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
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
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
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
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
+	craye1k = craye1k_global;
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k->lock);
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
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
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
+	mutex_unlock(&craye1k->lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+bool is_craye1k_slot(struct controller *ctrl)
+{
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+}
+
+int craye1k_init(void)
+{
+	if (!is_craye1k_board())
+		return 0;
+
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.5

