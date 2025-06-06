Return-Path: <linux-pci+bounces-29098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F5AD03FD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAE23A3A40
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD272B9A5;
	Fri,  6 Jun 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VuYiwzgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59371805E;
	Fri,  6 Jun 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220069; cv=fail; b=sTugOvqjA6ETbpA0vKQLUjfRdx0iKpjOg0bd2WNHH73ZagqZcL8P2rqTimmansXoRlsNiHjLQwBcVJUDhSEnsspD4W0SGI8GTW6lSOvOFr0vNhlFUxKUL7mA/qB0/T/THeRKEQgh1pfT3Pa5S7mm3potX3t84ifwMQnapJJHr5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220069; c=relaxed/simple;
	bh=Vj0t7ZE+4F0/p+N37nf9BVJzi9CeHG4JGgnGIl/qlGQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ISEGKGRK/wu/fUbc+S0sLpCoKHZGdCftNOkYmrF6VKbFra/ub5avNa38wr/qHVmmGIeRXXMVBpDYIzqwlirAGuSkd6R3c/W6cNCYUvlOVEgY3YvEMQI3BRxhv5XxUDSn8XDUSoQ10ocn5tz7sBivRG4JSlOipbb+1r/gEhezQ6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VuYiwzgT; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPSl2qNURD8KoIbg5sYrMC49rQxrbsMUygut73iOCjzJECDPVU5swXUulgEJivh6HdLIsx7DUgYNsUufRxq/LFFaCf9+bPtPSx2p602JLmYOjKwzzwsLZzD1Z4aVFtWkUyn7NSCryZUu9mWokIB6YwKOk45szBAoxS3Bec4vORZIS1303Yl2JH0Eu+dxlc/frIyYuoutu5ZJ5cj39b1yTfl0lq/eo+OQyxMmUT84ayRgpyXOdSZsEsY1DEzIrX3CMyK/27TxqeNsXIZ3122o09C0hfBZkKg7PxV1mYtckSCKk+3Ghg1m4XN1KL+WEsNgSoJwx/CeHXNiDyZYuskKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aInr3UHkwzT81LywngyBOXH52U4TVJaT5ljIRK2aLbg=;
 b=wptdTLBQQHTj1gAoro0PRRODfIB4BZSNjeZqT0vJt/CJkCkyu1tLd+1JxcfP4r8fMz3JpnVqHsGg7HzCY0u7Apz/dtwNjRbDytXR1ZR/tpQglQa9JrCv5skGlDHrQCmSnUpU/+EqR/gnLttb0tPFgmXk50+v5AXepiN1DJ8xroglgc/lLx9BTHPytZHhI9fXzE0Gal8wp6AOTLbxMxuS5Wr7ZYaXlHikfYghdqqtr+awKD5dM5lmkJlQpILxGrCP+Fr/G4xRBrJdLxgbaajZsrnvm58c950R1y7/wtfA/zIpRAZwvV25P7q9HeChZP9807+rUMnXMnc036vxTc3TXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aInr3UHkwzT81LywngyBOXH52U4TVJaT5ljIRK2aLbg=;
 b=VuYiwzgTMXZV9oY6dmlpCnVNrqeuNP6i2i8VpM7J+k6z7w2ZyykhZ6frtt5eLcOlDQPf6BRsKOAuobTLlWHo5h2XfzQq4Vj/QeqZjEWHe6qi33dIOROd60kCVGrMdoz0UyWNnlXn3iejO+aAFQiA2ml6qisgHWqOHkEIZU/XACQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Fri, 6 Jun
 2025 14:27:43 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 14:27:43 +0000
Message-ID: <af218185-3fdb-4e96-9f15-aa9d8bdcdda6@amd.com>
Date: Fri, 6 Jun 2025 09:27:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
 <ced413e5-6a98-4d6a-9c49-1a0603a1bb98@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ced413e5-6a98-4d6a-9c49-1a0603a1bb98@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:806:20::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d68ccc-92c2-4890-3953-08dda5064ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUlVYnpBam5KNUtCMC8zTmpWdUxuY01DSU5XTU9zK0NHQnZod0YyY1FTbjRS?=
 =?utf-8?B?RWFxTWYzMXR4TzNSend6THRjSTRyU2hsN1h6Syt0bTVBRHdBNFRvSmdFODhz?=
 =?utf-8?B?WFNRS2tka2d3amgwWlpseXFXUkhURlZMVjZFZnVtVzVkWWtobUluMEh1Nml5?=
 =?utf-8?B?ck1Ob1dFMXJZenZudUlldjlVd1p0VDhwOTFaU1JlVVJHV3pkSXg2RGNuNU5Y?=
 =?utf-8?B?MUVMRjVVNktXc0Rmcm9IZU9wYWVQNEJ2dGdEZjF3OUFUK3FVS0dJK2NsZ2Zu?=
 =?utf-8?B?RkRXbXNLQ0c4K0R3d1QwbEZxcmpXODJnUDFCMklrOGpSOEl3bHZNUEtuckdX?=
 =?utf-8?B?WXdoRVVCUE5mQnlSUzdmUU9yOGlHcnNWOEdoMHNaN1MydkF5T0kxcW43ZW5s?=
 =?utf-8?B?c2JqdnVJam1kVTVxT3BnbzZBYm03bjhLcTF1YVJTbldQdW0ydStQdFFnekF6?=
 =?utf-8?B?dW9OZnFwUXZEYVUvMWpva0VINnR0UkFDV3YzSW02cHRSZ0c4cEptUmFzcnMr?=
 =?utf-8?B?R2lIeURDekJyTW1uZUhkUlJSVitjT0ZoTnNBSGpwSXBWYUZMdUpYbHVGVm1W?=
 =?utf-8?B?dnptMGNadVJYNVJSUzU3L0djQTNvZDJJRlY5SG40WGpjQzhqbUUwQmVpYmZv?=
 =?utf-8?B?YVQ0OEVRRW5DSXlvTlBrMHQ3aVNxSG5vV3lFQ21ZOUNObmlmKy9tVndQcGZu?=
 =?utf-8?B?SGxpcllPdnFaVnhucktGZnJURjkwcXFta3lJVVZjSVlOb296OFBEaWdCem1U?=
 =?utf-8?B?RWI2L3N1TlhnTFhUV0hmVktnZVVGUGo0VWxVWWhJYmNEY2JaSldJNk5QTitr?=
 =?utf-8?B?TjZOcytUcDNjYzl2VzZYWlVyeXVSK0NKeFBDNncwdFNyN3pESW1pUFJPMHIy?=
 =?utf-8?B?aGJlWWdYNVB4QU53MUZiWWtpeDRwWDhMTGFiR1prc0J0ek1jc2hNdjN5OWMr?=
 =?utf-8?B?WWRFdGVkclNQeVg5MFBhV05hUnNJcTBMSWhpVjZVTkVIN0MrdkNSaXRKSXZC?=
 =?utf-8?B?eFltT3dLMVQ0emxjaUxNM0VCSXpyVDQxRDVOTlFVZ096Z1RvSFJTdUdJa3M3?=
 =?utf-8?B?c0hLSVVIQWdsYVlkeVI2Tzd1MjFJQ2dZM016Z250VEZFa2ZJYjBBMzE4aGJs?=
 =?utf-8?B?YmRvSzJMMWVGbXVlWDZjZlVUUEdxQXAreDk4eW91VllsQ2M2WjZLeHRiSDdU?=
 =?utf-8?B?RXNhaE0rMk0rbVpwbHpZc0puNlZKenBCTjk0cHdkSTRKc0g1UnFVNUgyWTUy?=
 =?utf-8?B?WWJyM2FyaDQzSFFpZWlZdDBHUEtUSU5RNThtbzk5VWlkaG82YVRldHNOdkRO?=
 =?utf-8?B?SWkydEsvSjFUb0VwaVlDQllqU3FRUGVrWHpFeVI0NjNVdEc5VnFJMExZaSt6?=
 =?utf-8?B?TDlVVUlXN0Fkb0tqajQwdUt0QkZma0VTS01Cek9IRjltZlJqRWpxSk1zR1JU?=
 =?utf-8?B?Vi9hblNpTnYwSThwUXU2T0UrYVpEZ3V3VC9YOWhpZFU0cE8xeExRRDVxRzEr?=
 =?utf-8?B?eDYySUJhQkxzeWplVG5QTFUxVlFFN2lIUGRCZ215Y3lvZHRleXFvOHhLRmJt?=
 =?utf-8?B?Q1BIcnN2TStpUFZLcTdqcHVLZW9FNzE2cXZXOWZ2aktoN3NmemJsNk40NTZH?=
 =?utf-8?B?RkFLQk1CQmJkK3gvaTdPc25KNU1NQkhZQ2RrbCtKNEVOUVU3U0FQaWRrTjBl?=
 =?utf-8?B?QS9STWJEenlIOXoyQTBTZlRkOHVMZVhlVndpWmU2Unc0aTVkOWxaSUp3WG4x?=
 =?utf-8?B?RnZDNk5CSTJLRkdoMXJZQXVtQ0FsQzB5MnFrUDgzTVVJWTRpNUI2N2NZRXdl?=
 =?utf-8?B?MmxiWXk1MHVlR3ExLzdiRXdIczZkQ0JIaEJ3azhtclVQdHFnVnJOMjJKWW5F?=
 =?utf-8?B?aDNzOEFZNisvUmNMZHp4SXRTdXdLN1ZtUWtCMGpZKzQ5ZWJpOEhHNU5qejVT?=
 =?utf-8?B?NUFuSk5CRC9Jci9LRTNQY0JGbWR1bmNha3pBbHN1L3pRUCtOWUxhVHdLWWlt?=
 =?utf-8?B?WnVEQ1dwS09BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFGbTZDcUI3cDQ0c2RFaUxaNXlZUVBydExMWHBOSHBhZW5Lc29tUlRrVXh3?=
 =?utf-8?B?blFackVibG5GWEMydHFYbU1lQlNQak00Rmx6QzcvbEpOSkN0V1Y4UDNaTlNE?=
 =?utf-8?B?WjVUNzgzeFgwcGJEdzlQM1JGQmgvVlJpZFhhZU5BQkhsZzd3a3E5RnRBaklS?=
 =?utf-8?B?U25xbUVYRVNseXVBeEt5NmRQQWpPY1dvOEIzK0hDSWFlWDc1Ukc0a1NVd0NC?=
 =?utf-8?B?cjdmYndSbC85dk5rc3ZTQjU0cHQ1eFdNWVhDd0V4ZTMrWkF2Yy9Na0NqV3Iz?=
 =?utf-8?B?Q0E0RFlkRjhvRlBCN3VFWlZac2tTMWVTUGcxdEd2TnE0TUJyd2J2VXNtazFm?=
 =?utf-8?B?VXJXdlkrZXJUV1pyT2pTMjZtQXROVis0cmxBRjVNdit0ZzNkOFR1U3RxNnpa?=
 =?utf-8?B?R2hYTFhnYWJpZlpUWHNXcGpGays5ZUgzUGJKdUFob0dCSUtDM0lYL3RLcXVS?=
 =?utf-8?B?dlR2V0NiQzJPU2VtYWpYd25xSlIyQ3lUM0U0L2Q1am5sMk9kN2NhamVJRDZV?=
 =?utf-8?B?NkR5a01mR1UvcnlmOVZPRE1hd1d4SVpybFNObEhEVU1hczJ0YXI0SHB4VXRT?=
 =?utf-8?B?SGppUjR3Z3k0Tm92UEZjQ1RVcnAvMzFYa0tpQ1A0a3BQK3ZRdmJDTWYzMkZR?=
 =?utf-8?B?bW5VTW9Cbm9EU0Q3aktqRjAwaSt3akVyTnBlSzIwMGZ1ZXhKV3AxVTRhem1M?=
 =?utf-8?B?V0FNNGdVWVFQcnFiNHh4RjlFUHlyL09RL21FZE84dDhOZ1BJTGFJcVo1YlV1?=
 =?utf-8?B?YUhFTFRLUjVpSDZ2SEdZRWlGWXM1QXMvcGJnMlBBS1F2V1R3TUZLOXpuY2FD?=
 =?utf-8?B?ZFl6a0JPdGowOTNxOElZbUZ1QU4xY0Z6bytSOUV2NGJqNHRsa2RLYXRKSHhi?=
 =?utf-8?B?WGlRbTRHUmh5a1N3UmNUOUtvME43WHVaOU1WUmZUN2RoeElGVllPRHN6LzFY?=
 =?utf-8?B?Wm9VaWRLVjVaOCtOWXpoa0k3dmUxYnFXbW5SUTh4V0lmME9EVGJRdlZ1K0t6?=
 =?utf-8?B?czZsVkx3WmkyNHk2NHlGZU1IV3BkbFlSbUNBREFETVUvZDhQaTQwaVd3SzVy?=
 =?utf-8?B?NS93bEFncnU2TUlNV2tWNjRPUGs5Z0tmejJyRlV0azFsTTVSdmdlYllOSDgz?=
 =?utf-8?B?UmE1WjR0YVUwVmJhUjZwZk1Bc1l5cmNEa2V6ZUtFMTFTeHRZanhPWnhYNG5h?=
 =?utf-8?B?QUVjbzlldTZjNUZPRTJ3M0hpM2lzUHJMc2MvM3AwZWhRVHFQNUFRN0lVL3lU?=
 =?utf-8?B?SUlmTjZzd0QrdmFCNDJLbUNkVlNHV1lLVUdMZzlHZjY5cUN4RXZOcWtHR3BQ?=
 =?utf-8?B?a3A4LzRPSVl1QXAvc29Ua0RnSEltRFFZZjhIUzhCNEpocjV6UERoZ2ZtUThz?=
 =?utf-8?B?RFdsOUxQem85NkNHc3p1SHhpenNkM2JxcDZDdzBrbzF0VnFkUmhtWW1RSDJi?=
 =?utf-8?B?SnB1WExoRzhuSDFlNm5wdG9yamtpc2xVcVZYU0NmRGZmZUs5clFXOS9VbWYx?=
 =?utf-8?B?dTMvTG1OMC85NGFKaU05clVxYmpVUDg2WTAzUDlTMHV1NUE0VHRlbHdaT0lZ?=
 =?utf-8?B?UUxYTW53WHZHWUxqK2FqZklBR3ZOWS9EM3M0elNINTZFcE5pVElvTlNLTTR6?=
 =?utf-8?B?elhCeWNYZklGOTdrYzV3OGdMZFhKUkF1ZjJ0R0dDYkhFTE56VHIwcHIwekJB?=
 =?utf-8?B?YUlqL0FNeFZRdTFhcHQrNVlvaFhnSDExcnhCeFEzbEhtZmNFTTNQZG5Ld2Zl?=
 =?utf-8?B?cGdFNWdNSUd6ekRjdkdwN2ZOVlZ3cXltMDR5c09zRnJVTTJXRkxHRm1VaE9l?=
 =?utf-8?B?WHhaZU1acTN0dGJsWEJxanFpZ20xRG9FWEJ0YjRQQkVDaEZkOVhrWHErVGtm?=
 =?utf-8?B?T3pmNjZWbmttSEllSmM5eWo5TW41eC9xZWJTNnhoR3ZUNTcyWmVTc0krVnZI?=
 =?utf-8?B?d2hSRUNLRUxQRFBYeTVsNkhhQXZRYk83ODNwNnFKTFExaWFvUTV4WXd5Uytu?=
 =?utf-8?B?TXNiS05HZnVHQTcxb3hqR1Q3dkxqbWhXTldkNk0yd1BHblZPWHRYc3E1dC9Q?=
 =?utf-8?B?bno2VkxBdjdrVTYzT1dTTW9mNVhUWVE2aEwyTGdDMWYwQytCT3Z6WEp6U2VU?=
 =?utf-8?Q?XRYIFIcagsuUKT3DJ+dXNMyEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d68ccc-92c2-4890-3953-08dda5064ce5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:27:43.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73vvKrXuNOZaTw4+Pb6e9lQ36fU+9pZWOxKqAvhDTm5HKtCT753FJKTYx+f+p8J6C1UMNqcyIimO+3tG4BOMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762



On 6/5/2025 7:27 PM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used
>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce function cxl_create_prot_err_info() and 'struct cxl_prot_err_info'.
>> Implement cxl_create_prot_err_info() to populate a 'struct cxl_prot_err_info'
>> instance with the AER severity and the erring device's PCI SBDF. The SBDF
>> details will be used to rediscover the erring device after the CXL driver
>> dequeues the kfifo work. The device rediscovery will be introduced along
>> with the CXL handling in future patches.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c |  31 +++++++++-
>>  drivers/cxl/cxlpci.h   |   1 +
>>  drivers/pci/pcie/aer.c | 132 ++++++++++++++++++++++++++++-------------
>>  include/linux/aer.h    |  36 +++++++++++
>>  4 files changed, 157 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 485a831695c7..d35525e79e04 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/aer.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>> +#include <cxlpci.h>
>>  #include "trace.h"
>>  
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> @@ -107,13 +108,41 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +
>> +static void cxl_prot_err_work_fn(struct work_struct *work)
>> +{
>> +}
>> +
>> +#else
>> +static void cxl_prot_err_work_fn(struct work_struct *work) { }
>> +#endif /* CONFIG_PCIEAER_CXL */
> I wonder instead of the ifdef block we can just do:
>
> static void cxl_prot_err_work_fn(...)
> {
> 	if (!IS_ENABLED(CONFIG_PCIEAER_CXL))
> 		return;
>
> 	....
> }
I have a TODO request from Jonathan Cameron in the previous series iteration to address the
same #ifdef cleanup. Jonathan recommended introducing drivers/cxl/core/aer.c and moving the
CXL related AER logic to the new file. Are you OK with that solution?

> In general we want to avoid ifdefs in C files. 
>
> Also, where is CONFIG_PCIEAER_CXL defined? I'm having trouble finding the Kconfig that declares it.
>
> $ git grep CONFIG_PCIEAER_CXL
> drivers/cxl/core/pci.c:#ifdef CONFIG_PCIEAER_CXL
> drivers/cxl/core/ras.c:#ifdef CONFIG_PCIEAER_CXL
> drivers/cxl/core/ras.c:#endif /* CONFIG_PCIEAER_CXL */
> drivers/cxl/cxl.h:#ifdef CONFIG_PCIEAER_CXL
> drivers/cxl/port.c:#ifdef CONFIG_PCIEAER_CXL
> drivers/cxl/port.c:#endif /* CONFIG_PCIEAER_CXL */
> drivers/pci/pcie/aer.c:#if defined(CONFIG_PCIEAER_CXL)
> drivers/pci/pcie/aer.c:#ifdef CONFIG_PCIEAER_CXL
> drivers/pci/pcie/aer.c:#if defined(CONFIG_PCIEAER_CXL)
> include/linux/aer.h:#if defined(CONFIG_PCIEAER_CXL)
>
CONFIG_PCIEAER_CXL is a Kconfig dependent on CONFIG_PCIEAER. When enabled the 
#define is found in include/generated/autoconf.h

>> +
>> +static struct work_struct cxl_prot_err_work;
>> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
>> +
>>  int cxl_ras_init(void)
>>  {
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	int rc;
>> +
>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	if (rc)
>> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);
>> +
>> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
>> +	if (rc) {
>> +		pr_err("Failed to register native AER kfifo (%x)", rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>>  void cxl_ras_exit(void)
>>  {
>>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>  	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_prot_err_work();
>> +	cancel_work_sync(&cxl_prot_err_work);
>>  }
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..6f1396ef7b77 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>  #define __CXL_PCI_H__
>>  #include <linux/pci.h>
>>  #include "cxl.h"
>> +#include "linux/aer.h"
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index adb4b1123b9b..5350fa5be784 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -114,6 +114,14 @@ struct aer_stats {
>>  static int pcie_aer_disable;
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
> Would it make sense to move all the CXL bits to a cxl_aer.c instead of all the ifdefs in this C file?
>
> DJ

Yes, this is a good idea. I'll make the AER driver related change to separate the CXL logic.

Terry

>> +#define CXL_ERROR_SOURCES_MAX          128
>> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
>> +struct work_struct *cxl_prot_err_work;
>> +#endif
>> +
>>  void pci_no_aer(void)
>>  {
>>  	pcie_aer_disable = 1;
>> @@ -1004,45 +1012,17 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>>  {
>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>> -	const struct pci_error_handlers *err_handler;
>> +	if (!info || !info->is_cxl)
>> +		return false;
>>  
>> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>> -		return 0;
>> +	/* Only CXL Endpoints are currently supported */
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
>> +		return false;
>>  
>> -	/* Protect dev->driver */
>> -	device_lock(&dev->dev);
>> -
>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>> -	if (!err_handler)
>> -		goto out;
>> -
>> -	if (info->severity == AER_CORRECTABLE) {
>> -		if (err_handler->cor_error_detected)
>> -			err_handler->cor_error_detected(dev);
>> -	} else if (err_handler->error_detected) {
>> -		if (info->severity == AER_NONFATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>> -		else if (info->severity == AER_FATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>> -	}
>> -out:
>> -	device_unlock(&dev->dev);
>> -	return 0;
>> -}
>> -
>> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> -{
>> -	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> -	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +	return is_internal_error(info);
>>  }
>>  
>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>> @@ -1056,13 +1036,17 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>  	return *handles_cxl;
>>  }
>>  
>> -static bool handles_cxl_errors(struct pci_dev *rcec)
>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>  {
>>  	bool handles_cxl = false;
>>  
>> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>> -	    pcie_aer_is_native(rcec))
>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>> +	if (!pcie_aer_is_native(dev))
>> +		return false;
>> +
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>> +	else
>> +		handles_cxl = pcie_is_cxl(dev);
>>  
>>  	return handles_cxl;
>>  }
>> @@ -1076,10 +1060,46 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>  }
>>  
>> +static int cxl_create_prot_error_info(struct pci_dev *pdev,
>> +				      struct aer_err_info *aer_err_info,
>> +				      struct cxl_prot_error_info *cxl_err_info)
>> +{
>> +	cxl_err_info->severity = aer_err_info->severity;
>> +
>> +	cxl_err_info->function = PCI_FUNC(pdev->devfn);
>> +	cxl_err_info->device = PCI_SLOT(pdev->devfn);
>> +	cxl_err_info->bus = pdev->bus->number;
>> +	cxl_err_info->segment = pci_domain_nr(pdev->bus);
>> +
>> +	return 0;
>> +}
>> +
>> +static void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
>> +{
>> +	struct cxl_prot_err_work_data wd;
>> +	struct cxl_prot_error_info *cxl_err_info = &wd.err_info;
>> +
>> +	cxl_create_prot_error_info(pdev, aer_err_info, cxl_err_info);
>> +
>> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
>> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_prot_err_work);
>> +}
>> +
>>  #else
>>  static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>  					struct aer_err_info *info) { }
>> +static inline void forward_cxl_error(struct pci_dev *dev,
>> +				    struct aer_err_info *info) { }
>> +static inline bool handles_cxl_errors(struct pci_dev *dev)
>> +{
>> +	return false;
>> +}
>> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return 0; };
>>  #endif
>>  
>>  /**
>> @@ -1117,8 +1137,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_rch_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (is_cxl_error(dev, info))
>> +		forward_cxl_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
>> +
>>  	pci_dev_put(dev);
>>  }
>>  
>> @@ -1582,6 +1605,31 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>  }
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +
>> +int cxl_register_prot_err_work(struct work_struct *work)
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = work;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
>> +
>> +int cxl_unregister_prot_err_work(void)
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
>> +
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
>> +{
>> +	return kfifo_get(&cxl_prot_err_fifo, wd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
>> +#endif
>> +
>>  static struct pcie_port_service_driver aerdriver = {
>>  	.name		= "aer",
>>  	.port_type	= PCIE_ANY_PORT,
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..550407240ab5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>  
>>  #define AER_NONFATAL			0
>>  #define AER_FATAL			1
>> @@ -53,6 +54,27 @@ struct aer_capability_regs {
>>  	u16 uncor_err_source;
>>  };
>>  
>> +/**
>> + * struct cxl_prot_err_info - Error information used in CXL error handling
>> + * @severity: AER severity
>> + * @function: Device's PCI function
>> + * @device: Device's PCI device
>> + * @bus: Device's PCI bus
>> + * @segment: Device's PCI segment
>> + */
>> +struct cxl_prot_error_info {
>> +	int severity;
>> +
>> +	u8 function;
>> +	u8 device;
>> +	u8 bus;
>> +	u16 segment;
>> +};
>> +
>> +struct cxl_prot_err_work_data {
>> +	struct cxl_prot_error_info err_info;
>> +};
>> +
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>> @@ -64,6 +86,20 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +int cxl_register_prot_err_work(struct work_struct *work);
>> +int cxl_unregister_prot_err_work(void);
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
>> +#else
>> +static inline int
>> +cxl_register_prot_err_work(struct work_struct *work)
>> +{
>> +	return 0;
>> +}
>> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
>> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
>> +#endif
>> +
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  		    struct aer_capability_regs *aer);
>>  int cper_severity_to_aer(int cper_severity);


