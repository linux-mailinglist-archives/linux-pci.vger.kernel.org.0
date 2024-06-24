Return-Path: <linux-pci+bounces-9205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5B91566D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 20:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D51D1C21EA2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 18:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CA19F488;
	Mon, 24 Jun 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAtFZlBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF291A00FE;
	Mon, 24 Jun 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253326; cv=fail; b=ZY/cqKFtIKmepsR4XpNFOx/1KbTqw+mA9/WeyhSr0WPrDYCpipvWe/KehvOFT3H/F26yyYt3Uy+q54yNs+8aAeYU6Vdi9xE+flW2akm+OK30qsifYn4n33zPkF+VKiE8Lpey26fWFZsMY0IfclrraYwPQ/aWVObfxPSmmGjgVi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253326; c=relaxed/simple;
	bh=dfva8uz+0f8UW3izRNiSuBZ7WBiqPOmldCmN9CVF1tU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FKyQ2IiRVLEKpLnvJZiW0dyYfid+Ho/rv7M0zBb94VJwqyDZ2I6iNWZiUofVRJMFlmlTJeVkUVKKqWMFEirobmilYe0fqDTWqxY5iGvQay7MeAsDZyk80eIbRDEV9O+h5tI9dsPimraLKgTfe9SQLutMK2AD6uAghi7AzcdFqQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAtFZlBI; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A420+JkOmECrDw4p6YCdsBi5n+noZgJj1rF5sNCu+hJei7tD+tZreVLFzan/RQowGt9O2nSgrAexZ54/83ylJougsZNzHeToGjlFHekUfJk1P1ei2UXLeMyQwNuqZ4h6sfdwgPBavmG9R9GoA7Zs+TwPq+7CmyZmMYjN/+VMryFRiAaDVTOT+vXQOTOUWiPcESZbNTSpo7mPEVRQZCNjIMk+nXMxJG31utvoiGlu9O1vQlVPK4LGHCjDRzl/2Oc5hBHTAf9cXBvMrgj4YhN2SoTzK8/WfWD4H5sqpkWZiXxtCHiUeGAXtsu+14X/Ktl31n7ZZzvzeS6j9xb1KaYguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VfJDJVSQjlZLG042LOLIPBtB9llFPzfFyKmD4/T0gI=;
 b=nAqINEreKrqpuehKsDicmVianRH8xRTRPu+X5BXGX5jWXpyHnVtdKJ2kpov5CQYZCnoxVzu5jlVvug5iV5kRpVPwlLKbLcFRDeRZVeE8oGXALVn6wruW0sKmKZBKAM8hl8xWiOCz2n5nYJBmboVIX3278aUEFd/0vfiViwDGkARVnNJu12hhCGardY7f2H3YI73ojBdajCslARqeZ5X6xYs4c85l/o9nCZ2xY7RKCFvQofEEDQnITaqzycacbh7rxYcHNi4no5x9/Ng2sQprWh1V3B3EuQ7ZkIHDrkR52/VP93lj2sfzH5XkFSANw3ib496mtJOuEV/nZp0MRPZ4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VfJDJVSQjlZLG042LOLIPBtB9llFPzfFyKmD4/T0gI=;
 b=MAtFZlBIFMy/Hfde4hQB/xhmOSIkJkp6vWhO65EJ9D435xwZBg2+G64eVryB2vhR4nRlRGUlrYx5PNDfa8Dh+/XbSYBaKVhQBRW3fiUMb1GIIPAteD6SpPQfuY2vIncbml4cERh0URFEEtQybnB/7lw5igNYB2dsyyNdDezG2ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 18:22:02 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 18:22:02 +0000
Message-ID: <ce191d03-c228-4f1e-b96a-0388220bc586@amd.com>
Date: Mon, 24 Jun 2024 13:21:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 ming4.li@intel.com, vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
 <6675d622447ac_57ac2942c@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6675d622447ac_57ac2942c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0105.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::13) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 76187b34-5797-430b-751f-08dc947a8b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|366013|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkZ4a1lUUTVvcXcvUUJzNU8vSDlUMHlBd1NZeGFHeFN3Z01XT0t2OHlJc3pJ?=
 =?utf-8?B?cU1UR1lmcUtqajdwdDZiUFl6cGxselNKNWlBQjFMSHRkMFBUTlRGMi9hTERa?=
 =?utf-8?B?d0xIUi9reVFGZ2N4SXBVUEU2TUVFL2NvTURqbXN4emc3bHlLaTNzYzdkNHE5?=
 =?utf-8?B?eDMyVUlXcCtvM2xIUk56bDVwT1FVZzVtRHlOd3pMeU4rd0Rrd1ovYUtTZHJM?=
 =?utf-8?B?Y3dKWWFzUFhGUllHVWdLUkhaVTRKend4VnVWTHA3cEhHSnJrUUxkK3A3WXEr?=
 =?utf-8?B?ZUFVdGYvUzE3MjRxT1pCemEyV0UzQ0c5TXJLTkZQeU5zVmdwWDJNTUdmUzM4?=
 =?utf-8?B?MTkwaDRpNXY1ekdaYVdlM2ZHVm5oWEl2cmdOeGZWemhvUkdYdlQzRlh0OE9q?=
 =?utf-8?B?RTVHOHZWUzN1cXBkbTB2eTRrQi91ZDRobXU1ZGMwd0ZiL21nZTQ3eE54dnEw?=
 =?utf-8?B?OThldkZTWHUwcVRFa0F2SDE1UmRNRXdJT3VYbGpMVDZ2dWQzRE9mTlFnbGJV?=
 =?utf-8?B?c2d0QXVQWGlxSmV6cEpwN21sOWxQUVVqRjNYQ2NhR2dNVlVad0lwa0luSmRF?=
 =?utf-8?B?TGJQcm91bndOYzdpNEt5SUNPYTlnWW5sK2owRXpOUkQ4Q2FTNXR0bkYrYUJ0?=
 =?utf-8?B?Z1ZVZ2Zreit6OEZjazBveGtiWkFzYSsxUGdHazFOZXV2d0w1UWUwYzZBYXV2?=
 =?utf-8?B?NS9YRFhzR3RUcHlLVHpYSWo3V2YrTExFK1R3cHpOR09jeGQwTXVMSnFabFhP?=
 =?utf-8?B?UUlQcDlxLzRNTEdNVDVBOS9haVlVY280SzZCU1BoMGlpZTN5VmpMK20zT1NG?=
 =?utf-8?B?NzZNMHFZZVZwMEMrS2VVVXVjbG5ONFlXWnFmY0NjZlhwbjErb1o1SlM5bHZT?=
 =?utf-8?B?T3IvUk90NUhwa2xKQ1g1bDlINE1NYzNiUjM1TWx2dHdDUEtaaEZZNjNlRFdh?=
 =?utf-8?B?ZS9HbDErU05XekpMM0lUMlRxeVBtOWp2VkMxUFZ5RnpocFVjQVFpVmNhbFRK?=
 =?utf-8?B?a2pDVXVBMDVhVTVmVEVZdVc2ZUk1bE02Q2xEOUd3MTFjRkJYTFdlOHBkdjYx?=
 =?utf-8?B?RnZuSWNIeUpick9HRkZhNkdrY2x2cThzV05ldDloYTl0alNlSEQ1TVI3MmVK?=
 =?utf-8?B?QW8zN0xOWVQ5bkRjQ1dEWG1EZnZCcHVNazJSeDQ1bElacHhYdzZ0Z0R3Z3V5?=
 =?utf-8?B?bnRqeE1UYU1uZ3J5VGtDL2JLTjZJUWFvYmRHMFp5UWxwVzFvQnVTQk1xMGZ4?=
 =?utf-8?B?dTB2L24rOVhyK0xKNDVjZk41UGlMMmtVR2FFcHFSdFpyVHhOdDJPclFhRFYv?=
 =?utf-8?B?VEhkM201dGxTWXJWdDJLbzZndU9yWjQwMEhVeUl5Z0Y4d2xlbytEMmo1N3RP?=
 =?utf-8?B?YVpmZTdwQ1hvU3ZOU2xDcEplVTBtbjZmb1RMUFdpaHY3YmMySndWUzcyWmoy?=
 =?utf-8?B?RGtITzV3MXY0emdWWEROVnJRVUlkc0c0OExGL25vVnBQdlJ2Tk5qZ2ZxZGlG?=
 =?utf-8?B?MUE4SWV3Y1lrb3Q4WFVBYU9pWDhqUFRoZ0RuaU0vZWErWW5kUHpsYW9BaWJw?=
 =?utf-8?B?TDNrM3ZRSnB0eTJub0M5VjhUcTJxaDU1ckdQU2Y1bUk5WjNIRVZVQkhpd2Nw?=
 =?utf-8?B?OVViTHZ0bFNSblFEeGNOSGhaODEza1p4WmpCZ0p3d1dPc21MMkpQelYwdFNS?=
 =?utf-8?B?TlBWb2xObGV2bGgwOHZCNU90ZXNRWUdZK1BIVnY5aEU1VWQ4V3l3YUg4ZXlw?=
 =?utf-8?B?WEM3OEo2M2t5TjBuNmN3NTgxeUhtVFdWUzFnVWhINndlSStTZXF3Vjk0aWxS?=
 =?utf-8?Q?EhUIKb5nP+Mp4M1T31Jiw8oBGgSIO5emb/H0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXU1YWdtTWVqYVo2Zk9Ldyt2RWo4cG81R1dyY1F1QVVsOE8wWFZYeDJLNm1j?=
 =?utf-8?B?NUIrb2ZUWTJlMEFoN0dwWlhwUkJ3elFDeHRjVUhRSWpNQmNDMEs1WnRYRU1u?=
 =?utf-8?B?RUNLK2N2NVhGMkZ2UTliRCtYNmxucUdKOXkyMFRhUWk5YURoK1pOcjhWWW03?=
 =?utf-8?B?NEhYVFlDNGlHL21qVnJCOVI2Z1ozeXdqNmhWMS9LZUI5VFh3VVVjeHRSVkFz?=
 =?utf-8?B?dnZNMmVqWHdPc3VwZUdkQWd5bGM0blA2TThYVmNyTWpsTkJ2ams2dndRZm84?=
 =?utf-8?B?bmVWWEFpTTFHZzNic1RiOVRBUVZzd3FFZ045NzY0cnY0THRCRUJvbStrdU5u?=
 =?utf-8?B?bDZpZlF2RkJ0Rm1NWFZFWE50L1U5NEdKWjBoYk9ha2FyTFB6QzQ3b2Fqckcy?=
 =?utf-8?B?RGJxZnp6WXZOdzR4TnVzMnFsUStHUjJrN1d0Yk85bmFFejUzRWZ4eXN6Znc1?=
 =?utf-8?B?K3V4MWdoWWRoKzNHdG5xemIzRy9kckVOaHdBeXZpRnZ4VlJiYm5sckFnRVRr?=
 =?utf-8?B?cXlJQVhlWVVxcnVETlpyYm1yZXJDY2dsVEZqQmc0MXVNQ3RsOGRwOXIxZmdG?=
 =?utf-8?B?V3RGNkxnMGtnTnFVL0FCKzhmY2Q0VmhYYjZEaDdPTEk1czY1OExEa0RrNk45?=
 =?utf-8?B?UjdNNWpLbDFUcHZ4eFBBajJ5KytuSkE2WjV1SEtYTWd6UUlDNDF4aDU2a1ow?=
 =?utf-8?B?YjErZ2FYY2VLR3kreE1ScjlSZDNnVnBGa1FLVkNmZWtjZ3dBQ2dWUUo2S2Er?=
 =?utf-8?B?bTdXc0pJMnB5N09YQTJTTHRwM1UxSm5LemZld294N2pwUUNEUituMjBTd0lx?=
 =?utf-8?B?Vyt0alB3K01idVZQSmZrQzFNczgwTUFrS2N3bHR0KzNMdGxvRUEvRnBSQms3?=
 =?utf-8?B?dWdkbTVIeTJHaS9aeFlkSDVmNUVod04rM0RSa2kvZEFRNWduR3VMS0k5SUpQ?=
 =?utf-8?B?VHZBYUZFYVJ6bjZ6azlNVkVsY2Q0ODRTc0NBUC9YaG80RElLOVdpNUR0Wm9M?=
 =?utf-8?B?S2dESFRLYjFsbmlpUjhWaDJxMlhTWTQ4S3lwOWhLUDhuMmwvSGlaNzJzWUxN?=
 =?utf-8?B?RnNJbWkrWUZvQUFEN3hudVFKMkNmeWo3b1puZ29NcXJLYnpjeWM5ZnM0NGR4?=
 =?utf-8?B?eUZDTGYrUFUzaSt3cHVyVFo0TUdWVVJaY2lkWHgwT1hwWHd4Zys5cG5DSEJu?=
 =?utf-8?B?UHBjRXNSczJPYk8yTCtEVXM4VGU0NEVIeGZzYVVrNnJLRjl1Q3U3amZDbW40?=
 =?utf-8?B?aU1jTWdyT3Z5aDR5MHRRNVVKK2FVU3FtdkxqcEUwN0lnZkEvWFJadUlheEhD?=
 =?utf-8?B?eVBFTWFxMmttQUluSXhiUkVHNnVOMlpUeVVRQW1kYXdjSlV6WWtCRXJHRSt2?=
 =?utf-8?B?aW1CWXFyQmhHL1A3Vmw5NWxEREpmQTNYS2E3dGlaWFBQeHlLUlNZeTNPdFRh?=
 =?utf-8?B?NlVNNGJyOEIza0ovUmlVTS84QnpWZm1PdEZkZVVNdERUcGtpUnZxejRNaXhF?=
 =?utf-8?B?SzFoeEgvTE9ZQVNKOVppNGJqNEtKUU8xWkI3eDNBYnpIRWh4cFNKdElIUHky?=
 =?utf-8?B?YlJCZHJYZjVtZHNpNTRCWnpHOGwvcFVQbXU2MEErRGlmeVV2dzFHSS9pTStk?=
 =?utf-8?B?dkd4VXVrQlJMZk92cXdwK0ZSRHc5YTEzQmpLMU84ZHNxWWFXeFIwZytuRFht?=
 =?utf-8?B?TTZnYUp4RmNReTQ1eWk1bG51b3ltckxUbm1DYnJSMEowNmdISzA4SEVEd3pz?=
 =?utf-8?B?OHJkT1ZyOFRsZVp0TW91WkR4bjlQN0c5RmN2Z3JqYkx0RTU5NWRJOEc4aWg3?=
 =?utf-8?B?TW1OSGcva2ZIRTlONTdRMlZNVGxJbW9hVGxPREhSOTJEbmFYdzhQQnZRMGVZ?=
 =?utf-8?B?cjFnSUlvS3JCV0h5V1p1Z2dTZS9URVZvcFVTTjFNWkREdHZzdDdhb3hLaDEx?=
 =?utf-8?B?MDJSQTB6V1AxMzJIaWZsY2pYUHowUWx6MnI4VnNVVXBaazZsbkFiUTJHbEJQ?=
 =?utf-8?B?ODU0RlNsVm0yZE9KRTJvMVUyUy9kamMyZkNPNXZSZldWM2F2MFJ2SlQ1RzNW?=
 =?utf-8?B?eEozeGtWQ3pld2FzaFJEaWMyWWs2Q2JrdzFPdWVHRm5NTDF3MVN2TzdJcnZS?=
 =?utf-8?Q?lo1BrdAjxMgkLwxwO2HpTBgL6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76187b34-5797-430b-751f-08dc947a8b0e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:22:02.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3M/tvIgxWa8YDd1dzJJ6zWVuM8CYZePy6nS0EKtwM+dnGTymsJBzTeqllcKGLreUBd2N3Yy3E3/EQQaRvNjAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

Hi Dan,

I added responses inline below.

On 6/21/24 14:36, Dan Williams wrote:
> Terry Bowman wrote:
>> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
>> does not implement an AER correctable handler (CE) but does implement the
>> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
>> in that it only checks for frozen error state and returns the next step
>> for recovery accordingly.
>>
>> As a result, port devices relying on AER correctable internal errors (CIE)
>> and AER uncorrectable internal errors (UIE) will not be handled. Note,
>> the PCIe spec indicates AER CIE/UIE can be used to report implementation
>> specific errors.[1]
>>
>> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
>> are examples of devices using the AER CIE/UIE for implementation specific
>> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
>> report CXL RAS errors.[2]
>>
>> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
>> notifier to report CIE/UIE errors to the registered functions. This will
>> require adding a CE handler and updating the existing UCE handler.
>>
>> For the UCE handler, the CXL spec states UIE errors should return need
>> reset: "The only method of recovering from an Uncorrectable Internal Error
>> is reset or hardware replacement."[1]
>>
>> [1] PCI6.0 - 6.2.10 Internal Errors
>> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>              Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/portdrv.h |  2 ++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 14a4b89a3b83..86d80e0e9606 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>>  	u32 service;
>>  };
>>  
>> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
>> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
>> +
>>  /**
>>   * release_pcie_device - free PCI Express port service device structure
>>   * @dev: Port service device to release
>> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>>  					pci_channel_state_t error)
>>  {
>> +	if (dev->aer_cap) {
>> +		u32 status;
>> +
>> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
>> +				      &status);
>> +
>> +		if (status & PCI_ERR_UNC_INTN) {
>> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
>> +						   AER_FATAL, (void *)dev);
>> +			return PCI_ERS_RESULT_NEED_RESET;
>> +		}
>> +	}
>> +
> 
> Oh, this is a finer grained  / lower-level location than I was
> expecting. I was expecting that the notifier was just conveying the port
> interrupt notification to a driver that knew how to take the next step.
> This pcie_portdrv_error_detected() is a notification that is already
> "downstream" of the AER notification.
> 

My intent was to implement the UIE/CIE "implementation specific" behavior as 
mentioned in the PCI spec. This included allowing port devices to be notified if 
needed. This plan is not ideal but works within the PCI portdrv situation
and before we can introduce a CXL specific portdriver.

> If PCIe does not care about CIE and UIE then don't make it care, but
> redirect the notifications to the CXL side that may care.
> 
> Leave the portdrv handlers PCIe native as much as possible.
> 
> Now, I have not thought through the full implications of that
> suggestion, but for now am reacting to this AER -> PCIe err_handler ->
> CXL notfier as potentially more awkward than AER -> CXL notifier. It's a
> separate error handling domain that the PCIe side likely does not want
> to worry about. PCIe side is only responsible for allowing CXL to
> register for the notifications beacuse the AER interrupt is shared.

Hmmm, this sounds like either option#2 or introducing a CXL portdrv service 
driver. 

Thanks for the reviews and please let me know which option you 
would like me to purse.

Regards,
Terry


