Return-Path: <linux-pci+bounces-33484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C6B1CE2B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1039F721A64
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B11E0E0B;
	Wed,  6 Aug 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFG1QZQz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643A21FF57;
	Wed,  6 Aug 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514171; cv=fail; b=CXUfQ61+0Cu9Zq7J+ql5FyymGmZ1MifB2nSg36wzkcrBQUwA2L3rg/1Fc25mOP41sxozXlcz7NELZowNSun6FYchlT10HXuXVB2fK9TAf74eXs8TLe7u3qLz+wOVDrgl3sJOaUR+xz/+hkQd4iNpXG3EHS3ZpVXMKNMKXexDDmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514171; c=relaxed/simple;
	bh=nPBfC8zFpJ9i4ngAgUzjJsjpdBJ0kbO8gNAxyRjGbtk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=noc/hyT/iEhczBgUulYm+muT0Tb/SlSql4edNzjMBxlh5OD5cYJ9ku/6ELw2rK0RDO3NLsfJ2HXZuhGUdlblYxSaipYqZRdEiJ8IAZeLVw4x7AcNgxtj+hO20s43uSVtCYbAyEl9Xd9NNPNEP3ld9H+2rTEbNEuP9BO3mwXKrlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFG1QZQz; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754514170; x=1786050170;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nPBfC8zFpJ9i4ngAgUzjJsjpdBJ0kbO8gNAxyRjGbtk=;
  b=NFG1QZQzkl9jYK4OgHqDpr3CPJCPJ6FbhwooEjhWrM8kKLOUUnzRvarC
   nZryEfa97Rr4qP1By4k/aYMr/+fpGIP9/jE0hb8JgH03Ln+2tKPDfgSDH
   6uQSZWd26V8eB4NYZbBaxsy9Hdnhdf7fL5HBs7rmxBXbgeQXxrqV5h1vB
   L06FxIwveCSs0Ix9mZqBDLDvRT+ZSId3F0JXEqyfpO2Pj8ScVfob4f6NH
   Wevp7YuLTMGBDMgLvfHAx8q5cGhL86lRR+JCOfvizqlr4gPo4oqqwcaJf
   HBKiMUGBwvWikRAeCvspJNzf9NNpIcFcm9l+DS4ESDm1+zs8DI7gHfhg7
   A==;
X-CSE-ConnectionGUID: MX5OcKnwQ56yYEsd83VbAw==
X-CSE-MsgGUID: 71j/0BIJQPq6f/RbpX9Nsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56983593"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56983593"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:02:49 -0700
X-CSE-ConnectionGUID: qMg4uIDXQpOJwO78K+qWHA==
X-CSE-MsgGUID: 1eOAnLXUQr6gLe3Ekyd38A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="188546467"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:02:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:02:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:02:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.51)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgi7D0EcERfEGRrEa3X5hMR7cMF+To6Qto9cK1FyGAnujYjQ3IITyDXO7hzO7f/CUWwUKss0yTh3/ACfBCfzjNZdGkjsQjAwDSXR8ZTKD35Xm2Lm2OtZitqxJ2TjCo3zJTCya0xyu/MhPre6WcZk/3p+vSArlPwsbBSVP/faaqYOO6Xy3YFdEaoTPAERiCY1EFvVWoOwbaFyUbi/QKNWgqDhstr6CIsHtUzM/G7WzlsFejWLyRxLdFyU4bvJ497k53PQpa3/eawNtsYHn11pa6PJ29GQnYJsOAjcdxbjBIDy1OeKYYwGaDlugg6+XHStg0J2nVtWc6OH/rag3SIn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxe82ePHL8+zpJZNsfQKBYjIn5OmV3KlpKVBTwTN8iM=;
 b=dmbv5GFS5jtM5SzWHCmP/PauzA0WpbgRsmuHbwcQKhqUAzTMwCPqZOv0n4NpOl9OWQ62AUxUIiBvGIqDvVWheEz37h5ri/bPLxWPhNmAeluivP8H6TpbYFaBBw5sDT+HqTBE/LmSJ3Xifg8aMeFTM43Q/DLYH0DMemQTpP0ZQYmSqx3c4NGeRQFNySBne5N6ygk4O8C6+sXogvr1+UlvGJ68uselCA3w27nre2u8rve4YPVexgfg5yc1+8SiiODTWNMIFXHryb87gUYOnrQksO5G4/StagVsBO03TEjaIch85vUTCBEzMUkcCUfvxQRX/f3PUle+2Sy6h7i1Veg3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 21:02:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:02:43 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 14:02:41 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, =?UTF-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Message-ID: <6893c2f1a8e3c_cff99100be@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250729162310.00001fbb@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-7-dan.j.williams@intel.com>
 <20250729162310.00001fbb@huawei.com>
Subject: Re: [PATCH v4 06/10] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ca89ee-b1c6-4402-93e1-08ddd52c9671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXg5ZDlaMDZ2OThwaythWTJIRjNhUDRxMjQ4NjMxZHhUQkpRZXBTOHR4aWN0?=
 =?utf-8?B?dkdTS0tTTHNWZHNTS3RlbnBXTlVEb3l5d1hJWjlrVmgzZnd3aTdMc2ZZRXBm?=
 =?utf-8?B?ZDFPZWxsMGJxSWx0TzlSd3J2WEE4TmpmYWJPdlpmWXh6MWNWZzlJcWhPTDZC?=
 =?utf-8?B?ZHhHb25sYndGM3U4TENPVjhTakdoUDRrOUJETFFSV2JRWGZTakt6WWJrWXpH?=
 =?utf-8?B?dXdVVUZ5a3FNb3NrTjdkZlM1eHkvZ25RYjMwK3VJWW96cU1jdkhiNVFvUGYx?=
 =?utf-8?B?aXEvOStpbTZ6WnFoaHd5VmJFNDBuU0ErYzhpeDZxYTlqVmM4SXBuRTIrZHdj?=
 =?utf-8?B?UHd2MjBHODFkNDVsWS80b2NXMnJSV1d6K2RDTnNmbjRxVlBIazBtODMwSmhr?=
 =?utf-8?B?OFJNL0Y2bE4yb3BGY25BL3Z0dG1LR0V2WmhkdTdzS09PelJKZUplcEVFeVZE?=
 =?utf-8?B?QVhFcGlMSzNneFlTZTI5STlCSVE1OTkyblNLWFNkbjZMeEJCd1lvSURQWEFU?=
 =?utf-8?B?K0QzOEQ3MUY1S3o5M2taNDE4SVBubW1oWjBKcHA1aUtpUmRFYWphbUFaMFB4?=
 =?utf-8?B?QTNOMkdmRzlHK0ZieWh1RlJkdm9zZmxJWGFoQjdKb0ZhRU9tTkJ6MjQ5SEF2?=
 =?utf-8?B?dHpHQkt6MVZoU0ovK0FMN1FvTEwzRWJhMkZPOWp3WkNZSTdnZVFxWkNlZEN4?=
 =?utf-8?B?UWh6WWx5U1VZSlVMTlJSRVNCRmlOL1N6OVRud2RtREhWbmZaYnVXdk9wUlgw?=
 =?utf-8?B?bTJGUzBzeHIyZmVkSGdQTmdGRTVWc09uM29IWndnT1BZL2lKTzNhTFBoL2d4?=
 =?utf-8?B?K3FwV0xSdUk3ZjR4UjdmUDY0bDByVmJpN2JxQm9PY3Y4UGUyb3Q0UkxiK1B0?=
 =?utf-8?B?TnBQeGc0QzRrUlZiSlorT2U0a0VxQWJCbHRCd0ZLMVhXM2luOWYyM1ZLbUYx?=
 =?utf-8?B?cTI0aWt5ZGl0Z0tGTmpKUXRhc01IcXkzekpXbEZJR1N4MHdYMVZRdlRHT1hp?=
 =?utf-8?B?TEV2K0E3eVN3a0tpT0xaaEpVcXA3QkJqaGJLckdZVGt1VWx3SGdTdmwzMzA0?=
 =?utf-8?B?QW1FWWU5VFV1TS8rVlZpRmtsQzNiL052NDF2L281WGZtSzFNZDIyRWVVLy9r?=
 =?utf-8?B?K0VIOTlIWDFQNFVRR0t1cVdoTDR1TTVGS2NNcUpxOE1Oc21RWXdNeFQ4ck84?=
 =?utf-8?B?cFY2SUZYL3pyWmMvM2JzbEtMK0FUWC8vU3hvS1hjNjRkM2ZBZ1VWZXlzWUhi?=
 =?utf-8?B?T05iZHNWR3gzT1BYbGFqYndHL2FrMGFnaCtCa0lFSUhVRU5QbVZSOGtHSmQv?=
 =?utf-8?B?alV0a0Z2bi91eFI4eGNpNlE1OWpLMi93bDQzNnduOTNSNUNVZjE2Y01GM2da?=
 =?utf-8?B?a3MxcnF3SGJlU3FxNjhEZzlIWGUxYUozT00wQmNMYnFRcEplYkJibHExZDJy?=
 =?utf-8?B?N0lIWStMaHVLZGxXMk1rTjZnVTVlaDNnblQzRktCL2l0Z0wxa2tBTHJ6RjJN?=
 =?utf-8?B?RmcxTjRWaXVwdG8vbGsrY0ZGUHcxY2Nkd1prUG1BdzNUaVFPZHFPOGYzVlJC?=
 =?utf-8?B?dnpHUHVod1o5SjBWYzVKNmwweVhPZ3c4eGtPMDI5WkdCMFg2V1dkNnBHKzFw?=
 =?utf-8?B?TkpXVGk4bTBrWng3eTZXTElwZUM1bGVnNFBSV1ZsclhTV1Rmanl1TnpIcTJS?=
 =?utf-8?B?YnpHL2xkU2VkRWlNbXVScjRJQ2JPNFI1dXBuYWw3NEk3SUtNdEdVZXBRZkZi?=
 =?utf-8?B?MVozdjBNSTZWQTNDcDdiS25rK0RoaWcxYi9jMFFVbC9UQjVXMG0vV2UzR3FR?=
 =?utf-8?B?K1krQlArRHdPZ2ExV1RZa3pxWEluZUE1bWxjRGVJbXUvOXVpcXh2QVRqdnVT?=
 =?utf-8?B?SFlHSVF5NjRYQmZpUFRMWXQyQXNCQUtmVURZNXN5Sjg5ZlhCMktKVFJnR3cy?=
 =?utf-8?Q?HuhiVpQlfDc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFZSRHh3VXFrTXQxVkpncmVXeHdSRDZwVXNqby82TXZLbTcyWXp5bXRTbGYx?=
 =?utf-8?B?UjE0dVZZVU1qaVJDM0JHaUZaS0tNQWUrZWhDUnhDNEVxalVOdXZGOTZLOElE?=
 =?utf-8?B?Q2lCQWVzWHovcC9yaG5QRklieW1lMTZJYVJlekgwNGcwYlYzcHluRUQ4SGRh?=
 =?utf-8?B?cHZySldwaHgrUTZteitHVlF6QUVDSlluRm5kRmZtSi9TNGpuQWpJaDRJajVt?=
 =?utf-8?B?TXJRWFN1bUtkNTVtOTFJSTdhY0p5VU9RMFRJUHNVWlJXeHN5Zk5NajZyNGhw?=
 =?utf-8?B?SVVXM1NxTldGMVZWNXF4QmptalFKRjVaWG1ZTVhrYUlKdXJmNkwwQitBYlBQ?=
 =?utf-8?B?NnhWUHlGajc2Q1RXTTc1ang2TUUyMnhHL0t5THpPcGF1dENZVVVoMGg0eDV1?=
 =?utf-8?B?Y0h5VDVNelF5emdHZ1ZxS21FbmhMR1BFbzVVVEhUbFhMNUVHR25ydnVYUzhq?=
 =?utf-8?B?Q05HVk1oUWdtSUYwZFAzb2pJR2FyaFZqajlDeTVicWVISGdJMXFkVVZIQ0R4?=
 =?utf-8?B?a3VFMUZycjlmWDBscmxzN2Q4K3BZb0RQRUFEcVYzTXFNanF2SEJVS1NpZVpz?=
 =?utf-8?B?Q0hsZDlJOVhlc295RDRiTzNTYW9FN1hVaE1hb29yUFNLQjlLUUEzcllocC9O?=
 =?utf-8?B?Q0htN2JxcHdNQnNFYjJuRnJMMENPTlMwcm83K0thOXNWblhDQndvaUFhVE94?=
 =?utf-8?B?VWQ5bWdZQ21WMlcrT3NXN2Yzb2JTN2UvbEFQd3ppMnlCQ1FSN3pWL2U1Zm9T?=
 =?utf-8?B?WUtCbkJ5ZkhzaTNEQ0NHbnlSc2FZdkMwWXJSSDNVMkdGOXJFa21mOUtJek95?=
 =?utf-8?B?d2RmbU8zMVliK01HQyt0TjFZZWI4Q1BoeVNtNDFKaEFKYU1tRDg0Z0k2MFAy?=
 =?utf-8?B?WU4rSVVNL0hHYUptQTJlQmcvL1BlR3RsaGQ2ZjJmRWhFZnpmM1pURHVHVGFT?=
 =?utf-8?B?TVlsMlIreXN3NkZVODBEU2FUNzFxdGtzang2a3ZiV3Zid05ldlBYRklSK09X?=
 =?utf-8?B?OW1HZzZqTnlPdzhXN1djQkpJSEdGV1VkaVVCa2VMN2NkRmJFY3ZOdmlzZHEx?=
 =?utf-8?B?NHRhMTl0SnhCcEtIOE1WaHMvblRSNG5ZVFQxcFpkSFo5RndRYVhXU2FLYjNW?=
 =?utf-8?B?Y2V6SUMyT0txUnk0RzZYVUdjN3RzWVMzdXVrcjVRY0RPL3RpTkgzdHlESzJK?=
 =?utf-8?B?M2JKVC9QTW5XWVRoVWYvdk8vTElIK2FrejJBWVpSY2F6MlA4cDIrdi9CMndw?=
 =?utf-8?B?ZnhGYlV5dmwyRTFpbEdxdDhGUWhleVRSamI5cmM2L3gwQkhwalJuRHJ4cmJ3?=
 =?utf-8?B?N1hnNjdFdjBTZ05VcUhIdEFYeS9rSWlhcjVpRWJod2dNVEZFZ0E2T2lDN1dr?=
 =?utf-8?B?V3g4bEYrSk1IWXBpSFFPTWpKcDlJSk01TVRSd1l5RlpOOFRKQmc0SGVIRFhv?=
 =?utf-8?B?QXlLLzg3T3M2eDZYcEdzem9rTnBxQS9ycndYY0dPWktnd2R4UXk1RHduRWhD?=
 =?utf-8?B?WlUrZ21NbUxNZldoRzJkcXpoRExxMkRVL3N0OW9VeG9jZGgrV1JpbmhPZDRY?=
 =?utf-8?B?cjYvUW90ZHo3d08vMmRjQWZlbHFsNXdHWVQ4KzlDekxLY05DZ3V3bWFDQUMz?=
 =?utf-8?B?TCtoMURoV2NNUU83VlRJT01BWm5NTHd4ZkppclFVVFBzNXVQbk90bXR3c3di?=
 =?utf-8?B?dFk5Y1dQTEErM2tBRVdDdUI3UWoweWJzemxJVG0rZFFjdkRHYTRQcmkxcG91?=
 =?utf-8?B?UFZZbUxVaGh3Y2J2aDdWQk5ucUxseWNRVkRsTVZjS2FxekNCRUhHemFGTVJz?=
 =?utf-8?B?WUltZUxUdUcyZFR5UUVJdFhZTy9Qcm9ZMk5XakFDMzM3TDRMakFBdEgzZ3hF?=
 =?utf-8?B?a1pGWG1BT3NEeEFpZjZKTHROa0k5VGpVVzNKdDEvUjlrWmN3MDZWRS9FS0Jj?=
 =?utf-8?B?d3lrdHhUWVRNa3lEQTVwMk55dGlSa0Y4SWh1cExHdU81Q013V2lsQUdqczNy?=
 =?utf-8?B?dEFpYkgvWnRVWFl1dXVJYkJOcElTRllNN1YzZlIva3VjSUloNjJNREM2dG5x?=
 =?utf-8?B?SHJKVnBOWGEvZExQS1M5NmhpZnJSb3NEWnBjY2NEZ0UvMHRaM0lqS2lpclFQ?=
 =?utf-8?B?OCtyd1pPVlhYVXpxbHdOSFlDV3pvT01wZVkwTnV2QWdCRGo4LzZMaThaQVFm?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ca89ee-b1c6-4402-93e1-08ddd52c9671
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:02:43.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/LIuw1uwdTykqG1OfAxMEvxUdnAHT1K05C/HR8qvl8YWhfC7X53a0fxDDaXWHMhl3/Ev2ujoLBIn7JvoTcca4wYi2IpOF+jDh+bi7xxe38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > index 1b991a88c19c..2d49a4786a9f 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -751,6 +751,7 @@
> >  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> >  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
> >  #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> >  #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
> >  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
> > @@ -1227,6 +1228,12 @@
> >  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
> >  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
> >  
> > +/* Device 3 Extended Capability */
> > +#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
> 
> Similar to earlier cases I'd make these 0x04 etc just to copy local style + match spec.

Done.

