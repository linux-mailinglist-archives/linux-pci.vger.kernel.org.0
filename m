Return-Path: <linux-pci+bounces-18391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C787C9F10C4
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BE62836B1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95251E1C1A;
	Fri, 13 Dec 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fd0N/Bnx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B417B500;
	Fri, 13 Dec 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103332; cv=fail; b=OY2DVl/FPIh+lWLXZR8cfYH2zzi7ZdiZDMUXI42cM1WtSyEZ5MRcEZ6Y3h58edP+glYv/mrNvo3DBckSg0Ghs0Um7Bt9LXwt92pcSrj7TTsl43dUajDB9ye3YNeL2wjJlm6Swh98dqzADUzs52cVq1pBtwYPFzFbHHy/RfU/kvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103332; c=relaxed/simple;
	bh=P13d9YOieMolpfjJkQrChZb/F6q8gJ8u1wdi8InW9Vc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmhIZ7Ot1XhPZaWQUVCTF/K/bvAESjz6S3x//PrZ+25ubN8rGVAHvu7yf+IxpZ2wzUCezIyO7o/wwcf4twfwNDzgsH74MTvmsx56gKoS9EPfVmmxVc1y1E8pF+jAIWci2mN4aVJhFFPobc6G2RP1huioN3ed0YaAjGZfw5dF+wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fd0N/Bnx; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtod9SlI59WWmjZXRywIj7932Y6eKl7hRXugQBftW3jpi1VTj3UMCsJeqiJJqVHsAufHEq90roXfgdELlx0KUcg5WtR8JZ7OTkgfpZ+vTQJVxp6LBxs7j+s0gKYnSkV0uVZ1o+5npaXv9T4TkIQsagqXnaeMFtyZc4SVjXPLpOpnprAEjOca4JAV6qeEkYGlCza6pGtwRbVqQn4XiSNkanyJwscpfwTccIXgRkt6xZiKHpVvb5EfawvC2msXYAVJVvlS2zBvuFt5W9Sxk9ob/HcuXz2gPkjwiJ5ZU1hJEDmHNVAod9bqVv8WpOGtEAl8/7OOQkEbb/T0ZyB190LsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVcdp6B/J97/0j2YXqOV/vgMwti54qEYLb9etdrXAYo=;
 b=R9FaFbOnYw87S0iOY/bVD5OhPtdP4kFRhzy1hnnMrFccVWFE+3cZD45lV+wyt6AZX6Vki0AuQUze7q36TBnyp7HNQxBaIk8RXbFHhkRK4CIwcntWUkYDQX3CyIE8V6d3ZEBuU7Ixr4l4SgG06rhWvApkuOJ+oyFkpYv99H88xQyJgSfZo1C9lD78+qbVvR24xGcE1PsfL2i6+uhzG5wCzgSV9LjNqWOVzJT/NxRCx2WnFVyD7BiQRVimxPM8iav1Fz44jNvXt1mHpA3/Z/+t9h4bXaWCjmwZll1zF4jMUO3Tnv7qfWmquTTOZpiioXpBTZeSF4rI9hDhsFrFTr5nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVcdp6B/J97/0j2YXqOV/vgMwti54qEYLb9etdrXAYo=;
 b=Fd0N/BnxJ5jdy6nKsjBbNCOsE74C2wHWLIXuHSjgwVC8eqOj1VfeQpVGxRovyBnfENqE5oXs2iqkEUffuVodTHi+bTDgXtppQgd2vyIa6XM81Te77YiIiWhN8jRC3wnKEVmK15hHmaXvQPz8bOCg3d5YQRr3OxReZMuDVOuMVtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:22:08 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:22:08 +0000
Message-ID: <8b5781f0-3eca-452a-b89d-e6c3a8ba924c@amd.com>
Date: Fri, 13 Dec 2024 09:22:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, Li Ming <ming.li@zohomail.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-16-terry.bowman@amd.com>
 <8a87754c-bb27-37d9-2423-cce6170de496@amd.com>
 <15da313a-b289-fb06-2f1b-eba5dfe5d30c@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <15da313a-b289-fb06-2f1b-eba5dfe5d30c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb51e5f-1256-44a1-1948-08dd1b89e8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkNEeUU0TFo1K2pwNUg5WXhZMm9zZGZ3YXZzbmFoQmJDaEpwOFErTXFDQVJq?=
 =?utf-8?B?SGY0Rk9jWlFvY0d3Z2FGcXpnSXh3LzVHNFlTUWxRVnVJZDIwQnY1Wnlidm5F?=
 =?utf-8?B?VDF6aXhYbXdXb0pyWVg0UXVWbFg0cXl1bkp6VkY3VWxYWTBadFlsZnFQaWp6?=
 =?utf-8?B?cmRBTmhDL2pvcWxCK0Iwd1d2VVhuS3N0SWJycHlnbVRPT2xES0JQakpic1hG?=
 =?utf-8?B?Rnp3OFhDRHlyQS9DTG1pL2F0a1Q3K2h5L2VpSWdpelV6VS8yOEdGSGprWHlW?=
 =?utf-8?B?eElrUUd3V1pFSzg4cXk3c2d0UVAzbW1hVHVyS0c1VUNIaG1lKytmbjU3Vjlo?=
 =?utf-8?B?MjFPQm5XVlY0S0laLzlaSDNFVkZWZkxTTVljMGdzNE9VSEY5QmxFMFhJZTRn?=
 =?utf-8?B?MjhKdFpta3l1dmtVTWpOWVVtY0dHNjlTaldFNHF0STZXeVdrM0QvaVVNcURV?=
 =?utf-8?B?aXU0M2JwdXMvanVwalNFcEo2VFVtTWpKTHhIYm44TUM1NFBjNTBVN08rREdK?=
 =?utf-8?B?ZkhHK1RzYVNJanRlbk9pNmFnRlBzcmVFOEZKVkk4TDdxeC9ITGcyWUpwYWJn?=
 =?utf-8?B?RVN2aVEvc2J2ZUo4c3B2WHAvVzRYbXVERVdaNENmcHNkSHgvZW9nYk9DVVRK?=
 =?utf-8?B?VUNEY1ZpZmZzTWNxTU9rM3I0OXRTTG4xWHBRZFFBNEt0Q0J6SkM0M1FqUlQv?=
 =?utf-8?B?dEtNRTZVejRZMzRtNWc4QmxlWklZOU9xakRwOHNiWHZxZ1NnalAvSUVlREVE?=
 =?utf-8?B?QnpxcHlkTlFlZ2licXpUWFgzMU1SR2JwTGxZLzBWNDVRNnF1RjNXbWxlaHY0?=
 =?utf-8?B?TjJ4VWxlYVVxR25CelpNeVdRbk84Y0lUWjEzaGRGU3V1Vjh3aUNPSXZVLzZY?=
 =?utf-8?B?S0JOY3BpSHgzUUdXSkVGUmR4YXN6cjQ5bFBoZ0EwMkRMMFdhU1JPaTJyd1dV?=
 =?utf-8?B?eGx3dXdNNW1FZEt2ckNpeXVaRFFLaUpzQVdvYlFLTUoxK2pYTmdSWmhxeDNH?=
 =?utf-8?B?a2VBajhmMVpadmFFdElZR2tNcjltQytZTUdweWFTQlpUVWxzbU1RZEJYRlFX?=
 =?utf-8?B?VHVPeC94dnByQWNHYTFrMjBQMjBwT1huVlFjVC9tV0JNYVV3bXcxd2QxeUVs?=
 =?utf-8?B?anBRRFBQU3hIQktMREhHek04N1FXa2lOUk5oMnp3WUlHMlNmbTVHRExlZGpu?=
 =?utf-8?B?QzRROVNRRGUwQlNMODQrRU9wVDZZOUlmenUxazhhSklCeDYrbjVGaTlYTHdP?=
 =?utf-8?B?cXJPRERPZmt0d01EektHN2pOUjZFUTBTK0tTK1A5MjdKbkVmY0lyR1lBM1Ri?=
 =?utf-8?B?ZEZxcjFRVjhWejEwNjQvQWlmRi9PaVBkV1JZeloyQ2tvOSs2QTE1NUlEbUZ5?=
 =?utf-8?B?TWE1M2FmN3VhdTFZa3FObWF2cDNBeHY0Qy9qSnZvdWRUdml5SUxwNDhRRmNl?=
 =?utf-8?B?U25iNFBibGoyUFlOOWhFTHQwb1ZtZVlIc2VET0VXK1IxZ3dwVUpqSTNDMWR0?=
 =?utf-8?B?R0VnQlhqVWlpVUNyaXhJMGJqL1pZbVpDaHZvUElqQ0c4MVdsWm8zS0dCdXRM?=
 =?utf-8?B?WGxCakV2aFBOM0pMWHhxR3dxN1M3cTk2NjRrNTlCbit5a0gvelNJZWhyWUNU?=
 =?utf-8?B?bk13TTZUY3ZCL3ZrUDNKdk0rMFNGTXlnLzhqMWNEU2JHS1ZLRlJYUDJxWUFR?=
 =?utf-8?B?VFN5SVlpNnZYUmQxNktHTGt6S3lzYXliL2IvdnRnQWl2VzFDNEE4d0trYW0z?=
 =?utf-8?B?QUZISStBeEIwMTlPK3h4Zlo2dFhyaTRrVlNhSnpKclhzSGNSYks5NVhvVDIv?=
 =?utf-8?B?TEFLTXI0ZGdFR0lsbkFCVWE2MjNZaGQvUlNjbHhOSmlzbnM4VFN0RndYeGF1?=
 =?utf-8?B?U0FOcTlOdGNBL3gwU2tQaU5EbnNFZmpDODZ0MVVNUFAxb1dhVHdHZEJqclFD?=
 =?utf-8?Q?SHq7OH0E8BY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnByR3dxTTNGTFdEQlJtcllPMllvdlMyWFlpNVpzN3RIbnhpbU4vaUFlQmFo?=
 =?utf-8?B?a1ZuUHRPVzcvSmpuTW5PVkhhU1BZNnZhWW1maGhmdVhHOUJQUWhMSUx3Qm10?=
 =?utf-8?B?ZWNCVjZRQTh2ZmRxUjI2YXRoTDIyUC80TGV5V0tZMUIwSENUQVNraU1HRlJy?=
 =?utf-8?B?ZE9JNEZCcVhpdzBqZThMNitnYm5CZ1FTS2NldGpzaUVFU2orbWM3Yk1Ua1Ux?=
 =?utf-8?B?OVprOVJJbkVWbXZHT2t5dGFOSk40dHR4KzFML20yb2gxbmU0eDVtMWZsZW14?=
 =?utf-8?B?dWEvVXpQYThRZFFTYTJpai9xdlBHTDVPYWtIR1BxV0taSVRRV1RaZ2htWTgx?=
 =?utf-8?B?eTF5ZDZSeW54TldkaWlzSStqeGtnRmZtWWJqR2tDMnV4YnJFZHVBUnMvNFNN?=
 =?utf-8?B?WGluSmNQRytQSGJOekhHaHV4OVI5WGdOM0pETmVScmErYnJkV3M2TjdZOVRq?=
 =?utf-8?B?cGVOd2lGdWt5WklFMC9xbVE5dndPSnZWbjF5MitxOG4wMjgrVmMydnoyWTVo?=
 =?utf-8?B?bGtRcnVvdEp2SGg2NE12UkdiSkRnVXZpeEwvZUd1S21vRzMwejJhRHhvUC80?=
 =?utf-8?B?VDNQTjQyMGNVTm4rMHdYcmFzYk5Ha0FVUXhwMW96UnJWNzAvd0ZLdlZQQXJu?=
 =?utf-8?B?c2svSDNUMEYrNjNSKzF4REtrbkZIdUkveTFMQ1hoeWZBcEFZMkQ4c29UK2Ni?=
 =?utf-8?B?RHZOZldyek1kbmQvdjA1bmE0SEJuM0hIbnZrS0lyWjlic2o3c3p1NW9remw1?=
 =?utf-8?B?c0VBTTduMGZtTU9TM0hIQmFYZUdiM0FnVUZqcGcvQkM2SXpZTU9XSFJXalRW?=
 =?utf-8?B?VXM1ejdIMUtTUjg4OWlxc3Y5VmYzS1dCOTRpbUpDWHJqNnlQc1VVTmZ1dkth?=
 =?utf-8?B?Z1o0THR4NHg1MzZ4QzFpUnBKQ0FtdWl0UHFFQmlXUmFYRncvLzQwekNNWVFv?=
 =?utf-8?B?dDZaUTlINC9hYjlWay9GTnQ3d2dzZDljbmxqN1poSHdMd1ltd0ZkYmZzVnd2?=
 =?utf-8?B?czlTVVMyMHRzSjF2VE9DelRLMWdSRkxjS0UzU0loYjhBTXNqRkhkQ1hBUEpF?=
 =?utf-8?B?YUhvZGp0eDNvMEFBbkRraFFvaW4vZTZzTXhONW5Ua0lxdEV2SlkveUhSeTZC?=
 =?utf-8?B?WHZybFp0Y2RhUE5oeWU3Nnc5STBoMGd0VGlrdG05OTBUSUV5UDBaMW9mMjFj?=
 =?utf-8?B?anZra1F2aXY2M0R1ZUUyckJkR21oWlg0TlVIN05kR04vVzFzaE5ydWtXUVVY?=
 =?utf-8?B?L2dSMmgrblo1UTRONFZvWlo1ZGV3M1A2NFFQanhjV2Q5K3ZSd3lGYWtoVVkz?=
 =?utf-8?B?b0cwZ2JWSm5XUGZyWHZGU29MRHR5dWVjN1UxZk9TTkVQMFI2cE5GT2UrcHRC?=
 =?utf-8?B?TWFwcnhTQm1xek1VRVFHdzF1ZnBOaVErVzN5bC9SSi91UEdrUkIvNHhLcVNK?=
 =?utf-8?B?cFk4eDRDVlYyTm1OUDVIeDhFV0d4STJSenBzcWgzVkV0aENyN3k3Q2d5TFZn?=
 =?utf-8?B?SzBhd3ZpTExrdlh1dTRRNWxjMDlFc285VUc0SGhPUmN5OEM0a1dEL0oxM0Fh?=
 =?utf-8?B?YlI5TDNNbEhnQ08xTWhCdG5KSzNFVFBIRVZENzd5Y1k5dVdiSkFsdnl3alIz?=
 =?utf-8?B?ZVk4bzJzZms0SEpNSjZsc1lkVnNtZU5abWVpZWxLQnhKbmRJWkFSQ2ZQbnZi?=
 =?utf-8?B?MXBiN3NWZnY4Qll3U3RuS1A5aWZVVTV0enppaWNQam4yczIyTkRXcmhGOU5W?=
 =?utf-8?B?THRPQUNKUk9iTXV0TDVTcHVpVHpndURhS3g0cVBKdER3a1g3WS9yTlQzUzlZ?=
 =?utf-8?B?SDk0M1ZNUTZReUVqV0dCbS9PSyt0Zmo3dzJpeFFyb3pUWVNhMkV6UWw1b3A2?=
 =?utf-8?B?ZmY4dDdmS3NYRThhQ0srVVRoTGRBR212ZlR5TzMwYmdDOGlsaGNzc1Jxd3Na?=
 =?utf-8?B?R0Z4Z2wxdTNmZ1lTS3cwSFE1NEZFemVwRVhMSEMxbzhnZ3FNNzhqbVJ3bzZk?=
 =?utf-8?B?WHBqSFJBaitsZGQ5Z2pIeSt5c3BuSjdsMzNPVEpXUlpoUEVtZUlDTzhPU3oy?=
 =?utf-8?B?dWRKL2RKK21PYmRsNEJWSlRzNzdadm5kQkJXTFdkV2dQckgxTmRudEl5N25F?=
 =?utf-8?Q?LSDCcv6TZx8o9SnCKGjMXT/Ge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb51e5f-1256-44a1-1948-08dd1b89e8b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:22:08.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srA0DkIcXEHX8vp1GcjDPWsABleL4bFuUNPar2TG/ubPKosc57FIo3AsXW3KmMpTzJ2skLzg7n3BX7I2fLpaRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123




On 12/12/2024 4:44 AM, Alejandro Lucero Palau wrote:
> On 12/12/24 09:44, Alejandro Lucero Palau wrote:
>> On 12/11/24 23:40, Terry Bowman wrote:
>>> The AER service driver enables PCIe Uncorrectable Internal Errors 
>>> (UIE) and
>>> Correctable Internal errors (CIE) for CXL Root Ports and CXL RCEC's. The
>>> UIE and CIE are used in reporting CXL Protocol Errors. The same UIE/CIE
>>> enablement is needed for CXL PCIe Upstream and Downstream Ports 
>>> inorder to
>>> notify the associated Root Port and OS.[1]
>>>
>>> Export the AER service driver's pci_aer_unmask_internal_errors() 
>>> function
>>> to CXL namespace.
>>>
>>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>>> because it is now an exported function.
>>>
>>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>>
>>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> ---
>>>   drivers/cxl/core/pci.c | 2 ++
>>>   drivers/pci/pcie/aer.c | 5 +++--
>>>   include/linux/aer.h    | 1 +
>>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 9734a4c55b29..740ac5d8809f 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -886,6 +886,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port 
>>> *port)
>>>         cxl_assign_port_error_handlers(pdev);
>>>       devm_add_action_or_reset(port->uport_dev, 
>>> cxl_clear_port_error_handlers, pdev);
>>> +    pci_aer_unmask_internal_errors(pdev);
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>>   @@ -920,6 +921,7 @@ void cxl_dport_init_ras_reporting(struct 
>>> cxl_dport *dport)
>>>         cxl_assign_port_error_handlers(pdev);
>>>       devm_add_action_or_reset(dport_dev, 
>>> cxl_clear_port_error_handlers, pdev);
>>> +    pci_aer_unmask_internal_errors(pdev);
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>>   diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 861521872318..0fa1b1ed48c9 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -949,7 +949,6 @@ static bool is_internal_error(struct aer_err_info 
>>> *info)
>>>       return info->status & PCI_ERR_UNC_INTN;
>>>   }
>>>   -#ifdef CONFIG_PCIEAER_CXL
>>
>> This ifdef move puzzles me. I would expect to use it when the next 
>> function is invoked instead of moving it here.
>>
>> It seems weird to have such a config but code using those related 
>> functions not aware of it.
>>
>>
>>>   /**
>>>    * pci_aer_unmask_internal_errors - unmask internal errors
>>>    * @dev: pointer to the pcie_dev data structure
>>> @@ -960,7 +959,7 @@ static bool is_internal_error(struct aer_err_info 
>>> *info)
>>>    * Note: AER must be enabled and supported by the device which must be
>>>    * checked in advance, e.g. with pcie_aer_is_native().
>>>    */
>>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>>   {
>>>       int aer = dev->aer_cap;
>>>       u32 mask;
>>> @@ -973,7 +972,9 @@ static void pci_aer_unmask_internal_errors(struct 
>>> pci_dev *dev)
>>>       mask &= ~PCI_ERR_COR_INTERNAL;
>>>       pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>>   }
>>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, CXL);
>
> Forgot to mention all these exports are changing in 6.13 with the second 
> macro param being now an string, so just
>
> EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>
>
> Not affected in the codebase linked to this patchset, but I hope it 
> helps you when getting weird errors with a newer kernel.

Thanks for the heads-up?

- Terry

>
>>>   +#ifdef CONFIG_PCIEAER_CXL
>>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>>>   {
>>>       /*
>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>> index 4b97f38f3fcf..093293f9f12b 100644
>>> --- a/include/linux/aer.h
>>> +++ b/include/linux/aer.h
>>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int 
>>> aer_severity,
>>>   int cper_severity_to_aer(int cper_severity);
>>>   void aer_recover_queue(int domain, unsigned int bus, unsigned int 
>>> devfn,
>>>                  int severity, struct aer_capability_regs *aer_regs);
>>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>>   #endif //_AER_H_


