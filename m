Return-Path: <linux-pci+bounces-40440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D756C38711
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 01:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC82A34C658
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2619BCA52;
	Thu,  6 Nov 2025 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wz4HzDJo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9EC6FBF
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387928; cv=fail; b=FKfai21QudcFaWDiHVzIOiOE/Kcqmd3l7BSBBC6F3Qycd+FblHCjj2GDdU0+PTkn4mVI9zr3widO22n6vhnCA3CcY4hxDiijVzJMlyU4JdYf34UgmFaxjDrChMwuzQiArqtuoJaddl/HS+/XiEj9FYYQmu1QddgpvWkgFmCJ00M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387928; c=relaxed/simple;
	bh=KC8sJFukH4mIGichGguxRwczQt/90fm2A2XrCe9JZ1M=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=KFlBSVSvPHYR7PNOS7+X593/vY0YukXC+XwZGoVWjebUnNhOvy2Gn/crfc/D5l5/mmKPMfSVrtM6v8mzpr0ersMHi94C1cacfdGCjFY5BPzgjj6uxSpnuH7tWmFEzv9ComrK81yXR6OCqa7y/DBokhbvRSWa2FKVZsGhHSE/5a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wz4HzDJo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762387926; x=1793923926;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KC8sJFukH4mIGichGguxRwczQt/90fm2A2XrCe9JZ1M=;
  b=Wz4HzDJoTRRzeQ95j5Xon/F2XFOPPfASUjWkTDKBYscoUm85H4fvI2kh
   r43Qd7WtJx3mZl9avS27kSTbQgBIoehiAfOzw/ruhjXyJHWc+tfMJLW36
   WSYXTxKxov2Vd2CGLZCWp9uMlw7adIHK8CBP/VEDI5zUV3aCeefySLXrC
   9UenL1BDOMTaXqqGU2LwnsJ2AdFE/4HiH5+lms75YPES3JAegO9paBxI7
   D3pXRpiaOuCtESAXDsy4MMcU+hezXsg22ZfB3tM0OB7YZfTv9JJ7uvl+z
   lKnfOrrAQjv0Yhs4N1eNnKH6CNpdVmIWu8BgEkt8PtQc7JPSwsPvgTrYB
   Q==;
X-CSE-ConnectionGUID: /dCCGFI0RIS6kg4x7cNYKA==
X-CSE-MsgGUID: H1M8oJHBRR2w0GCVMwFcZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64551863"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="64551863"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 16:12:04 -0800
X-CSE-ConnectionGUID: ftChhmPwRuG2GrqCQeTX3w==
X-CSE-MsgGUID: mvp2j/k/T/CywMMU6lrU2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="186853576"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 16:12:04 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 16:12:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 16:12:04 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.28)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 16:12:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5L4dZxR4tbZniAPS9sdlQ78EFgL5IZNdBgJ84VoR/lhJpFPOv+VrfgldWn3shEThM0DNUQN24Fw4LX9CnwW1lfsP1KSAExjbd1ze0i7QL6WO5h3b4Idn3h7Zlq97BMjnOkXXKrtsK5ohnhFhE3AuWiRVgLws4GC3jSGvsDEGftiwLafmykFnrZlQTGu1AptNKz8uPQ3ncM5IUbgHq6srLHpsXQNWyvKgOuYny83DGhD7YnPxmmjoMqjy4Vnu/+L570TAmqo9myrt8PhvdaO3jYBCmXDhFbZtJzNGh2+zolbArxMkg6MDaopI2Fa4hTimuJn6KT9E91978iGK5u/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg4xXpdtXzeNO4J9yoJD0DCwjGeP9ib7N2JIiuLM79A=;
 b=yeMYpwFW7bQtrLmXNjnuOxBtURbtqpwpMdkFCBu/AthVkYnhR6LhV6uouVnx1fcpfsbRmSWmbUlb5fw/+UEx2+CnetuH0FhPXkkLVzYNAbTP+dGNcWUj6ZYDS8yikbokU/mhsQzYdT8wSoTzR0F6a4HKYkUVKD+TE39SM/FqUYnyv0p2x9pmyM1AY0FYwFXl+imDKeo0jBIQc3XaxK5Fl9GahSBsWdq/iGGyRsud0r3lxw2s7Azt7jcVgHjAWO+fUEjK32/yCt7ezmku6c3kr5ryT3Ol3RQOoX1eD5XztkytdDvMgfTnzShN/gmTHFQJBfkOwM07FQrdHxoxCdsx2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPFF3DEC9799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f61) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 00:12:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 00:12:01 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 5 Nov 2025 16:11:59 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>
Message-ID: <690be7cfa9803_74f7610037@dwillia2-mobl4.notmuch>
In-Reply-To: <20251105153126.00002a0a@huawei.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
 <20251105040055.2832866-5-dan.j.williams@intel.com>
 <20251105153126.00002a0a@huawei.com>
Subject: Re: [PATCH 4/6] PCI/TSM: Add pci_tsm_bind() helper for instantiating
 TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPFF3DEC9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 37771a95-2c1d-442a-efa4-08de1cc91b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm9kODY4N2s1N3pjNVdiYUZYeU5MclpRMlN4WGRFQis5b3Z1VHVsK3FJNmsr?=
 =?utf-8?B?ckNZTUhjUmtsZ2xvbXU2VElSVEExOWt0NnhzTHVlVG1GeGdYcThnd0hHRVFB?=
 =?utf-8?B?Q3FrTkEzdDdxTjk4VlNNRmQ5KzZsL2lMV0xvLzg1UWk3OW93clc4VWRNQ2R5?=
 =?utf-8?B?cHR6UThqZ2dGY0w0NFZaSXpwTm95U25FbmdQWmxMYjExYXF1K0ZmWnlaeU9r?=
 =?utf-8?B?enhGWmJNQzE1S1dBSnFRRWFJMDlXSXRid3Vlc3dIRkx3Vjlid1I2aHJtWkJq?=
 =?utf-8?B?YmtRNkNONmJNS0ljTk1JM3NrNERTTTZZcUExVU93WnpYZlpLUUlic0E1Zndq?=
 =?utf-8?B?ZkJEUlRwZlcwM0dvQ1JkaXJOZWVHV3dBVHdrRnRoOE00QkszaVkzNU1QejFQ?=
 =?utf-8?B?RWZZN2RMeU1XUjlvR2d3dDFOS2hPUFRhMitTZStyTTZsVUowQzVtc1Jwd2hD?=
 =?utf-8?B?YzFPZXRUalk1dy9pcElucFovT2dNZmlXNmwySVpnTmMwZE83aXNBRytCM1M3?=
 =?utf-8?B?czM0MnJQRmFuMDJZdlEwKzM4NEduNEUyWU10N3pIWDg2YXFRV0lRZXBBOEI1?=
 =?utf-8?B?YXllR3J5VUVNZGdTN2c3NFgzN2lZOTQ5VUJ2dUdQK2lQZVdYbW43cnN2V2RM?=
 =?utf-8?B?YUNtdVVRb1hYdHhxYjBBZUM3UVZ4YVVFRWJiemNFZnpOa0VKM0VudCtjVjk5?=
 =?utf-8?B?TWcrQXRZc3VTMG8vVHBpVVhmU3FLdnUzd1hkMVhDKzhXWjJqQjRBbXdSWVNr?=
 =?utf-8?B?UXV1WEtjQmJ3RTlUVFhodmhkZThSZXdHQVNvcTRYU3RGTW9uNWRmbE1tZ09Z?=
 =?utf-8?B?RmF4Z2FLMXl5T3RHYkRJNUwxY2VydkZ6RXVVWk5oWkZ6a2VTWm01b3o3WEdj?=
 =?utf-8?B?U2pWQmhES2s5NzNmbDdlZThMS0I0c3JxWDZUNGdJTmJ6VHhoaE1SSmh4eXM5?=
 =?utf-8?B?RU1jMUhBcnFzN25vZDl2eDZkODNQLzVnRWNiRXBZY1ZzWTMyUnN2VnQ2ZWxZ?=
 =?utf-8?B?RmVKaGhncGYxc2V4eVlDL0VmM1ZWWS9pdU5DdzFldmVxTERwQUp3SGhqQmdB?=
 =?utf-8?B?ZTZwRkVKcmozSkJrdDlmUFNpMHNDL3RNVU1LdkYyUTdnNEk3akx3K2RoQXNN?=
 =?utf-8?B?WmZZSWJrQ2xjcFBWS2lqL2UybG4wUE40SE00ejk3ajQyMnZvbTVDZUdCNjRS?=
 =?utf-8?B?MEVneittNVZ2VUx1ZEZ6WSt1NDQ2TDlWWm9wdVg5VEpZMnM3NmtVWU1zcCs2?=
 =?utf-8?B?bWlKQlJya3FrQXU0YitXNytRbHJxYWVYa2J3SmlmcnVLZTVsRXplKzJwc0xG?=
 =?utf-8?B?QnV0NS94cTF4cnhwc2RhOHhINFFVaWhNVnhMZVFSUEZpbjF5bUZlbWt3c0ZP?=
 =?utf-8?B?dlpRRWpDalV3ZTdNMThmY2Jqb1dJWmplTUlpWDl5NmxoR3U5b2V3ZVZFekhJ?=
 =?utf-8?B?NXV3MG55akd5N3BvM1o5UEFyNjk1NHpJTW1oRjRLRFZ5ZWVMcm5meHVpaXJz?=
 =?utf-8?B?K1NEckpXc1IySWtVT21kMU9jWmRqUmxqNTJJNDFCZ2RrdWhNSkdJam41TDdv?=
 =?utf-8?B?eG91R0pnYnhEYzZ2ZUcvd2lsQktIRCtYSWp2TXlOTExqUDNBclZLeXc1N2JY?=
 =?utf-8?B?dzFIaENWdDJRb1VHRGNYNzNLcjFvb29KdzRXMVNHWkJKTXpZY1htbFdTWDgz?=
 =?utf-8?B?bUFlM3hyaUdjLzVFODFTdDR1SXZNZUZLcDlvMUUxK0RnNjlIc3JlKzhSaU02?=
 =?utf-8?B?OE4xbDUvd3IrekxmM3ozN1pVb2wwRG5nOTBkK0N3R1RESGQ0UTcxUjVlaDNE?=
 =?utf-8?B?c3kvTzQxUUs5RlZHbmkvZ2xzNGJsN1g2Q1AvdG1scWhhUlpycllubUZBMG8r?=
 =?utf-8?B?ZGowckhQRE1BbFUwVitzRnNUOXZ1YkRhdTkybFhKSEpZZzhqb085VElZQS9I?=
 =?utf-8?Q?f6jpWn2qyS4jD2yCpFwlg9C54fqKvNpw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJFVDZOa1pubTlBQjFBWmR2ZGRybVNsMWJOKzBvMWE1UTlZOXNtUVdCYXZZ?=
 =?utf-8?B?SVdXTXl1cHhjdlA5K0NzRVJ4Q1FaQlVpSzFmTzdDRS9RUEw2cGxUankrVE9E?=
 =?utf-8?B?WXM1VVVMK29ZeGsrVHdjcGhMcklhblNpbFJMVWYra01LMEtPS1MyU2o1STE5?=
 =?utf-8?B?QTNRSzVwUFgxR0pnMDAzNXFkdDdKdE5RbVM2YVRPbmRhQXREeWZTZitrYVBT?=
 =?utf-8?B?SHp0M0tFQ2NjT3RCb2dKRTlJNE1NdG5GdjgraGlZVm03ampRdmhJMmFvUFBR?=
 =?utf-8?B?enNZNUdoYW5jaU5Kc1dWdFd2eVNRUnVucjQ1REd3bUt2NGRINGJPWnliYmQz?=
 =?utf-8?B?d2FFMnp2QW9DNCtmcWwyWUtXZ1RBRUhUVGZYeFFLZ21JdXBacmpjR0tXTmRW?=
 =?utf-8?B?cGxhRERUMDdGRzNkZDdRUlNjM2RiVHNqWXFpaGJsMDJUTFJqVWhoeUV0Unpv?=
 =?utf-8?B?UlZpZXRGNXNQQlhIOGl1VGVpVE1od0dBRVVjZitwSmlkVk41UmpmWmFGdXp1?=
 =?utf-8?B?aElrbnViN3ZicWN3eHUrWTVwSFRRdmY4SGUzNk94QmVNRnFheG5Zd2xnQmFE?=
 =?utf-8?B?Q0dtZUNDcUFPZ2M5elhXR0xMaXVZL2dUTW1pa01BRVF6bTZtR3NxODNtd1ZY?=
 =?utf-8?B?OE16VTB5QVNwUFJ3dmJDaXdoc255cU5KK2NELzJPUG00K1pHTloybDhKYXNE?=
 =?utf-8?B?RjgzRlhaZlhHanBSYmIvZ1NoaUdWVkdhNXhpaXNuZVNzV2xjdE5YeWg3eHA5?=
 =?utf-8?B?RHZScGdMamUzUUtaVUVReDlKKzlQWmxyYXkxdmdldzhNNnhpSHNCdWljaDhk?=
 =?utf-8?B?SkNBL2ptclFCYW1Oam41ZzFOa0xYSTN2VG5FT1dKZGNSRXpGeHp3MGZweEJs?=
 =?utf-8?B?NDBPd3BwRTYwYkF0NkRTVmVPbmtJSW1EZU5OaGlpNTU2MHpZWVRLUUJDOUxL?=
 =?utf-8?B?RVNIaWY2c0piZVV2OXlpQU80eHRQaHN6SUlHL2t2N21UV3RTa1loOW9vOG9s?=
 =?utf-8?B?V2ZoTkhmQkQ4d08zSzYyTzZ1U1BscFYzcm5JUG1sSDhkL2dCZXhqSFJSNTZT?=
 =?utf-8?B?NThIL3hRalE4Q1B2NHBJaFUydml5dkcxYXlWTytGRWROUUxRSTczK3N5L0dh?=
 =?utf-8?B?N2taYWFWMk96U0kvSS90Wk5Qa3Q5U2NaL1RsZ2Z6SHhkQ2hRcDVYK01VRTlr?=
 =?utf-8?B?M1ZJY3EyanNBdUthMFZ5d0Z4MTNwMmZKTEZYQnZHT2IvMnF0QVFBelFFN3o1?=
 =?utf-8?B?RW5ZVG1rbzVQemYvY3Y1UCtHeEZHTU81bXg3WlQ1UUhDSUxmWFh2SU9pM0ZD?=
 =?utf-8?B?TlE0MVpBQk9SNVBDb2ZrQlVUVjJvMzVOQzliUHVSTkJFTkNWeUM4WW5MMjRD?=
 =?utf-8?B?cXlTWUNYdVhzc0o5S25sNDZMY1BIdFh4QXNQb1pCNXRhODZhM1cwMVptb2ti?=
 =?utf-8?B?MFlkeDMxVkdDMXFJZkl2ejBqcFZ0WlBjdkZNOGs1dEkzUm0wV25CMkI1Ymgw?=
 =?utf-8?B?NEhGZGJObzFUTEJFbmpNa3VsaU1SY3dYMVNnekZYVkhJOUJ6OXBOUk40bnRo?=
 =?utf-8?B?MVRGWUQ3UXVzSlMzRERSOWViSVptVFhZM2FKWWc1cS9qSXQzWnlLdUpLUS9y?=
 =?utf-8?B?R3hIMGNQcWJWYmJsR0tUREp2ZEZTSzFpL1JNa080aUc2dDBnTHByZDJ6Zk1L?=
 =?utf-8?B?NzQ4MElBN0UwVXJma2liblViY1FmcUs1SVI0TkRNdWhiZCttYXdHTmdMYkVT?=
 =?utf-8?B?dWJ5NjVTT0k0aEl3cTJpRnc2V2sxQTZxWFhmaUl6RE90T0xNcHplanJMdVV4?=
 =?utf-8?B?bjdURTREaTh4VnBMVEpmTUdPdmJWTWRxbkFaNTN2ck1QMHlpb05LNFV1SHc4?=
 =?utf-8?B?SW5jT1dNdzlXa29vQWpUZTBkdGp2SzBodDBtQm1CYWtnMVpCSURYOUlNNjFw?=
 =?utf-8?B?eTlUZjBaUlVYTm5tOG9GSTdQOHJDOHF2UjlwKy9RbTQ1c2F5Wm5qNFU0dExX?=
 =?utf-8?B?bThwZzBBTDlqTC9IMS9nc1g0cWlzR0F3aGkySENOTWl3ZmtuT21sOXMwRnZu?=
 =?utf-8?B?eU9PMG9PVzlIR2txbUY4OW53YUNCOENiR0V5aWRMWjI0NnUreFFESEJGckpm?=
 =?utf-8?B?TDFBUkMzUDZReFhnaDRVQnE0TmdZS0U2K0hiQW90cFhoUm1JOEcwcktNRjhB?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37771a95-2c1d-442a-efa4-08de1cc91b8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 00:12:01.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2O8X8ozyOJ+cnwCojiwQGrlgGIEuybs+8mZld8jeymzxV9bZHngBgW1mNbRVCFwJ+EyQzWZxekMn8/eF6OqHNlvaIJ6jC6Oxnv/uHv6qmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3DEC9799
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue,  4 Nov 2025 20:00:53 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > After a PCIe device has established a secure link and session between a TEE
> > Security Manager (TSM) and its local Device Security Manager (DSM), the
> > device or its subfunctions are candidates to be bound to a private memory
> > context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> > Device Interface (TDI).
> > 
> > The pci_tsm_bind() requests the low-level TSM driver to associate the
> > device with private MMIO and private IOMMU context resources of a given TVM
> > represented by a @kvm argument. A device in the bound state corresponds to
> > the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> > 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> > it involves host side resource establishment and context setup on behalf of
> > the guest. It is also expected to be performed lazily to allow for
> > operation of the device in non-confidential "shared" context for pre-lock
> > configuration.
> > 
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comments only from me.
> 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > index 6a2849f77adc..f0e38d7fee38 100644
> > --- a/drivers/pci/tsm.c
> > +++ b/drivers/pci/tsm.c
> 
> 
[..]
> > +	/* Resolve races to bind a TDI */
> > +	if (pdev->tsm->tdi) {
> > +		if (pdev->tsm->tdi->kvm == kvm)
> > +			return 0;
> I'd flip so the error case is out of line. Then drop the else.
> 
> 
> 		if (pdev->tsm->tdi->kvm != kvm)
> 			return -EBUSY;
> 
> 		return 0;

Looks good.

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 7df2a681ed19..001afdf00de6 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -381,10 +381,9 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 
 	/* Resolve races to bind a TDI */
 	if (pdev->tsm->tdi) {
-		if (pdev->tsm->tdi->kvm == kvm)
-			return 0;
-		else
+		if (pdev->tsm->tdi->kvm != kvm)
 			return -EBUSY;
+		return 0;
 	}
 
 	tdi = to_pci_tsm_ops(pdev->tsm)->bind(pdev, kvm, tdi_id);

