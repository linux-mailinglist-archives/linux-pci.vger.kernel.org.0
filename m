Return-Path: <linux-pci+bounces-25375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A79A7E07A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A3717C6A8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F41A1AAA0F;
	Mon,  7 Apr 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oa0DmJQG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676F11B2182;
	Mon,  7 Apr 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034460; cv=fail; b=UPT80paVAV1vA9tZB23LSwUcaBGTvyJS7OmgzCiiynfm47w/B9BHMS8Xj/J4t2AedC3rfY3dymcFX/JADwSu0oRu8alp1oWwlZmWl3OSwr1U9Dcnw835ycWyqVxQSGHkm8lMfROozmUtOBdqDna86Rwy0r53CXTQrx+bVCUzYng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034460; c=relaxed/simple;
	bh=45Um8yhrYXtiSkhP/EgjY1HO3c/GvBDodHmi04ukiSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/B8hlayOEx5bTUJNRfJwHEo4YFvqnYQdoe0qMv6+GHqF/l8gUodtd1cPS9uw6K/ZXxFp8UC+axPbRCPt5sSyE2pl7FVzxwApJRPK8JK8zH2q3dmdUYZ+HaS0Ul6+Tr3rQD4w0ReyS+7AF4L/Y1DAj8/n428yFuDfGZbRxC/fWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oa0DmJQG; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/gFwmXQSlAFfPF6kx78g2JCpAQJSQtwSOb/tgqBd45vcEjnkGTlQP20JyavpnO/i3eFkoj11n2nZhtbXHHFe9fLPwvCa99IDv5zbHoT4SbWS6muTX8yARGltAPBpNAJn+Y8ov9D1xYzqdhwhI2nEktVXFBVI4gsMxHor5uvD0nlGDoRnnCgcOZB2q7Z+TWZNdsh2ZmJZfSga3E6GHQpkehVZqSAyHNshu/DgzGEtdY5aNzmYzmlMpY3BLOhQyAs+leLpv+p5WQWLtG4YCVB6PZmLANZHGTsV6HQ0HIutG0lGMEO6VDJ9PQj038HzaIDSUFmMnqTmby56BDs414pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZFIGXnNOsG92RBHOEPzCqO+k/UzHJs1bdJbwMevIjQ=;
 b=o7Wy1/f3tfXDabZvOTtLkgI3gUhFtrvFEqzFmMsu9tLylM4rJPOyXDvMAY2zj+wl1gZ6ffZ3XwwMVEvEPNF9MU22vIG9QvKmT/bHamDdDBSyQOcAw9QYt3VogY1y1xLxh3FMYk8kLflrK4R+wCIb5FD4Zt5lvxgKbaT8SQzIEM/8YiSfbIwjLgdbAkw9dEz/FDGY21vpImVvbwX5hzWRgT4yHWxi0OxZlovQD0Qvnjmo0fl4kNKp+F+5hQbkeOJjyim/Ru0bvYb0qF7MWTlZIWYK7lujadIlgvFOW/k4UFlMUX6yT7giqWRGZTwUxpnognA5Bir3w2jdazShjT4ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZFIGXnNOsG92RBHOEPzCqO+k/UzHJs1bdJbwMevIjQ=;
 b=Oa0DmJQGazIUxcuiyy/iYTrY4GWy9A5DvbSX2srXl5ccM/0EKgJQpfUcVFr2Gozdensm4i2g2KdaTmg1EY5W4wFK8opczrAB9DP4m6BjOpG3D8kRjV7iTYjvbGk9Q6Y927LhEhZgTCG7l90dQM1VQQ4rzeUZ2p++kSmoRLSZ32Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 14:00:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 14:00:54 +0000
Message-ID: <db80cc07-b3e9-49b3-8415-7ab815b0dbd1@amd.com>
Date: Mon, 7 Apr 2025 09:00:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327171335.GA1436609@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250327171335.GA1436609@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b89af5-bf96-43a8-6cc6-08dd75dc9ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTNUVlFZSElaR3JTVnNLZzREQ0Z4MFIvUytDeVJZYTNiTkRKY2wzT05KaHdD?=
 =?utf-8?B?bk5PWERnRE9qekR5bk9EVW03clBNczhYWXcweXkyeDlzUmlhcE5URU5Fa3Ez?=
 =?utf-8?B?N215MHQ1bU1iRmEzZXJQQUlEWlp5OHJaZjBHanlscHJiT25XcHA5UERRdHNZ?=
 =?utf-8?B?YUFMSzFFVDViQW9KTnRKWXRWV3FMZ0JETmMxNVYzZjRONDVqdlN1eWhPYmw4?=
 =?utf-8?B?SXVjZkI5QVN3VUNTTUlHU2lJanZFQStsY1A4RDBRMG1HY2cweTdKSXFaR3hx?=
 =?utf-8?B?YWdINGVtMEpiN25iMWhDZXZvL0QxeWtnOVo2M2Nmam1FK3kxNzVvdHBRRVl0?=
 =?utf-8?B?cnlrY0xRbGk3WDJLR1FQbVVLdldyTVNiMmVPdnFZUUtEMkZZNEZiYVcvSFJZ?=
 =?utf-8?B?b3pmaS8zQVFJWURvTHJkQ1U0T2J2RGhDVmZHZEU3U1JWRU0yWkc3ZDJYbWVk?=
 =?utf-8?B?RGxJejVPYmRGSm9RdUl2TldFUUk5R2tQZmRLbGQwOWMwRjk0NzVLNjczbC8r?=
 =?utf-8?B?UmVNMmU1c3pQN1MwS1ZBZm9pZDA2NmgrVkFMVWh2UVpGUHU2YW4vc1FFNWMv?=
 =?utf-8?B?aUhyVEpQTFNSby9POGQvcmRMdjRkVGd5eWZLdWxmWjgrdmFJRWNKQmFmS0V4?=
 =?utf-8?B?Q1dIZmR4NFBtY0RqTXVjcG1VNDNrcXR4bFVvZ3RvUkZjWnVHLysraTh3L3NZ?=
 =?utf-8?B?OEw1OTNRU01JdlRsVlByT05aSHNJTnl5RTc1UGt1aEh4NlF4UkJSNnc5OVBE?=
 =?utf-8?B?S25ibTNLaWNzVjlOLzNxLzdOY0VlalhRMC9ZeXFPTlplcExPZUd1eVlaaU1j?=
 =?utf-8?B?Um5vdS91dllBdzFxWUdFcjJvY0pnMTJ4cFpvRDFsSWorVnRkVVlTVVFkY2Vm?=
 =?utf-8?B?TkV3TUh6MnBDaDVpcWE2a0hZa0tVMmpjVCtJRDV6ZHhHOTVmUUh6RDBIYVRl?=
 =?utf-8?B?dloyUFloSVV4dS9nK2dvVEplQ2g1aGhVbkErSHM4TWh4ekhhTUdoMkdBY2xv?=
 =?utf-8?B?eEluOXdiQWhVSHJuZ2ZyUzMzQzBJVU40NWo0dTZraHhSaStUM0tuQ01RRHRL?=
 =?utf-8?B?N2JUbmFwSkNVeHlwam42VUQrbDU5QUhLbG5hdGZpSU1jblE0SmFmRmt3dUIy?=
 =?utf-8?B?TWtaSnZZQkt0WkdVUXVLM0pRQ0ZZNzZoakRydjdxWWgyb3BDMjA4Yk1LTzcx?=
 =?utf-8?B?OC9LTVNIUlBFY214V2ZrZGxlalROQSsrcWZVMmpObkxiZFFiMWFaT0g4T0JI?=
 =?utf-8?B?dEVKVC84UTByU3NoWlZyL1podmtXZ0hoSEJzbDVXcVZRRUV5d2JteHJqOGVX?=
 =?utf-8?B?eWN5ZVBsa0ppZFdyczBHTGpHeUptaXBxSElTLzd6TEkvYnpMVU4zSUVsUllJ?=
 =?utf-8?B?WGwxZjlQY1czcmxhb0ZqbmRSaGJoWkNUS3FFdVYyYzhVRjkyZkFxd0ZRek4y?=
 =?utf-8?B?VEFDV1dHVlRYb2xpSEtsVjZ3S3dNUG1LcFAyV0dHNUdSQnBWYTNpUnpDaWw3?=
 =?utf-8?B?dUdZVDJ0KzdpWnNWZHBvdWxtTmMrNnRkSHNZcU11WVFOdVprNmg4Q0VuVmxI?=
 =?utf-8?B?aU1JbTR2cnFveStIRXlxRzVmeFdENTVxbDE5QlpDMUwrZlNGSm9rbzhmd2hY?=
 =?utf-8?B?WWFVZU5ZVjU3SUMyLzg0aUVkYUwwVGJoTngvdENhY1BJNVhEZUJRNnhST1VM?=
 =?utf-8?B?NVVYbCswRXR0UjNFL3FWMGw3KzdQckhtSVh1NVVPSzY3SmlEQXZvMXJqK3pK?=
 =?utf-8?B?NmhRYUJJSWpuN2pzRUkvOXZrMmUwTkZDRkkrYnpKRWVTMDdWRlRaUXpEN29E?=
 =?utf-8?B?Wkl0OHVqUEExcU9EL2draG9scFpsYVRCMDRXU2h4VXE3R2ZPaTcxWFZWeDlO?=
 =?utf-8?Q?4QQzqzNcViHbk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTdwSkw4YllWYlgzUVRKVU9LelkzWmxiQUU4RTR0YmRoU2F2ZkltYzdlWnVP?=
 =?utf-8?B?NXFRTVdLZDJUeEFzcEhRRllsd2Y5K3RHRGlaRWNuM0sxMXZJcGdQZDdscmN4?=
 =?utf-8?B?RTdJc3k4dDZtYklSeG8zaGprN2FxTnpXY3FxeTdPdHA5NzJDdzZOaG1ZRmtp?=
 =?utf-8?B?bnoxb3ZHWjRhSUpvS2V5TVZ2cWF3b0dCSmpUU056K3ZIYVFQcUVkTjFDb2JD?=
 =?utf-8?B?VUNta1hmTXdYN3I2cFRiRmhlaEpVS2ZWZzdESzNxSUk2U292LzVYNWtUdzAr?=
 =?utf-8?B?U1RTbFVoSzBxZFRyVTZVTWd4cEhQQmtGRTVtYlI0bFNNdThJTit5NWtiQU5H?=
 =?utf-8?B?Y0daS3FGWk52T0QwZ1ZXL09XbERkV3FqWnFzck9qbWZWdFNqSzY0cFZ6NFJq?=
 =?utf-8?B?ZzF3NjZmT3dkMW9JdE1OZnZGd1ZteHFtL2wwZWg3WDAxUGxKd2FwaWN1TVVn?=
 =?utf-8?B?eDZRQnhSdTNuMFRNNGN2YTRUWVdabWQybUR2UnZGdVJpMkhUUXByVnlvczBB?=
 =?utf-8?B?azdJSytUUEFxc0k1Z1VvOVJBYllhVUk4NHZ2eDMvOXJma1lOQUZOaGRPUnJG?=
 =?utf-8?B?Wit3dUhuVXdUYlB4djFhNDlldmM4OUVmSVo2WjVkTTlLTHNNL29qU0VBcVBu?=
 =?utf-8?B?MGpGVmZRd0IxYzZOcC83VFl0dU1ITTFNSTNhSkF4ditGSk9pZFN0ekwwTkxn?=
 =?utf-8?B?ZFZpbHFxR0pZSFlKVzAwRDVTaWt0OGVRWWhkV3VBZmJnOTdQcC9NbkFyYldI?=
 =?utf-8?B?QmR0TFpNdG9WOTAwWk5rT0x3blhBNnkrUjFCL2RGMGVlSkY0M3ZaT1FPaUhW?=
 =?utf-8?B?ZW9EaVhoKzVVL3BoMXlpbEJRVDk4SlE2bDBsNlVmSzdxLzdFdHFmUFkxWnk4?=
 =?utf-8?B?WEg4YzNsK0VINmgxWGpzTDVwWXZzakNjN0MyZVVsOVo2N29nTkJTaG9XRTB2?=
 =?utf-8?B?ODZZWm5UWXVYaWN0R1FuOGptbVg1c2E1UGo1WUlUYllHK2UrSHA4dzRPM0tD?=
 =?utf-8?B?L1puQUl0QnJzT0tlWWFOSk5seFNUOWRvQzdUNllMRTdjdzYrSU1vSzlHUm5t?=
 =?utf-8?B?YWdlUnNSWHYrZEsydi9NT2dKMVZSZVhXa3pZZnV4N1J0RkZVY0t3NXpTQUtR?=
 =?utf-8?B?eU1kMUpNdkdHV1Bmc1l2aXl2WXZOSGFCMFd2QkZKa2V4N0I2SWw4WnVEVGNL?=
 =?utf-8?B?YzhZNkJZSmk4Nms3ck94ekdTRHpGcGpWbXZPSVY5YjZFNzlFSE1NVlF3dHFi?=
 =?utf-8?B?QnF2Q2JXaFlicXM3b1lES3dOMGNPWVZxRFhHK1hNU3RnZFZMTmJjTXhrM0dD?=
 =?utf-8?B?aUVzeHlaMkw1cDlaYjJUblRMMGFKdGt1OHh0cUJHQkR1a1dEWWFWNWpTVlo3?=
 =?utf-8?B?Y2N2MmloVWFSdUhxaVNZTlA4TU8vejVBVlpud2NHd2hwSmNCWXlsWXVKeEQv?=
 =?utf-8?B?aWtadGFYK3Vzb1dmMkM1KzJrNUZ6TVBUb0ZPZU80MXA4cVpOVUhwR0ZQU0RP?=
 =?utf-8?B?a3FuQllxR05LTVQ5U3ZPeFo2RXcwRnFvdVFHVVlxQm1oTW9qdjJkRVIrVHN0?=
 =?utf-8?B?eFlKZU96Ny9vUmVBZTFnTVdQSmlleG8waUNhdGNvR3BWVHArUllBemRHYk5l?=
 =?utf-8?B?Z3ZVamx2cEQvVjVmL2pjSUM5TWdnVHkyRGZCcVRXZGMzdzJONkpHMGdSSW9t?=
 =?utf-8?B?ZURXRW5tUGZ3VjhQMnBJejZTNXhnUEtmSlZlbEsxNTA0NDhPQ1poVUhjV1I5?=
 =?utf-8?B?SUNnWDFoRGRpK2RSYVJrcFB3NmppQnloak1oVzhQZWFPbkdSNFVHNWhPdHIz?=
 =?utf-8?B?WGljOEpsYWt3cmlNUHVXblc2R2MyZ3JqL1M2ajY0aHo4WXlkQVUwRVlVek5J?=
 =?utf-8?B?UXl5TzVFREtjRGxnanEzK05XdnZQa3JKcnNUb0xsNzAxN3d2WjJmRmVrN21a?=
 =?utf-8?B?U0h5K3dzMThzSTI0blY5YU9LZUdIU2RMeTJlR3lqdFVoRCt6bWhnTVBEYjVq?=
 =?utf-8?B?L0szajU5VDNrSW9vQzVKY0owbWNxRkViQzZ1U1FmQnpFMGlvbnRMczVJa3Na?=
 =?utf-8?B?STBFL1p2ZU5qaWNlVWxmRnQwMzJydzRCaldoa0wyMk9MV3Q5TWptS3lSc2FZ?=
 =?utf-8?Q?gvmXz3rXCZM+UEV9PwfRKSPZX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b89af5-bf96-43a8-6cc6-08dd75dc9ca5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:00:54.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSJiyso1tp+/6wQocHc77uQiSCpRLxil9A+GPhllPp6Z6z+7Xzx9mIGPz3IS0AQc39q/GfeDegQ/TYOYVr2QzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000



On 3/27/2025 12:13 PM, Bjorn Helgaas wrote:
> On Wed, Mar 26, 2025 at 08:47:05PM -0500, Terry Bowman wrote:
>> The AER service driver includes a CXL-specific kfifo, intended to forward
>> CXL errors to the CXL driver. However, the forwarding functionality is
>> currently unimplemented. Update the AER driver to enable error forwarding
>> to the CXL driver.
>>
>> Modify the AER service driver's handle_error_source(), which is called from
>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
>>
>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
>> masks.
>>
>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
>> as done in the current AER driver.
>>
>> If the error is a CXL-related error then forward it to the CXL driver for
>> handling using the kfifo mechanism.
>>
>> Introduce a new function forward_cxl_error(), which constructs a CXL
>> protocol error context using cxl_create_prot_err_info(). This context is
>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
> This only touches drivers/pci, so I would make the subject prefix be
> "PCI/AER".
Got it. Thanks Bjorn.

>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
>> +{
>> +	int severity = info->severity;
>> +	struct cxl_prot_err_work_data wd;
>> +	struct cxl_prot_error_info *err_info = &wd.err_info;
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
>> +
>> +	if (!cxl_create_prot_err_info) {
>> +		pci_err(pdev, "Failed. CXL-AER interface not initialized.");
>> +		return;
>> +	}
>> +
>> +	if (cxl_create_prot_err_info(pdev, severity, err_info)) {
>> +		pci_err(pdev, "Failed to create CXL protocol error information");
>> +		return;
>> +	}
>> +
>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);
>> +
>> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
>> +		pr_err_ratelimited("CXL kfifo overflow\n");
> Needs a dev identifier here to anchor the message to something.
Ok.

Regards,
Terry

>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_prot_err_work);
>> +}


