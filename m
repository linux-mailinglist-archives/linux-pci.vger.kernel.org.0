Return-Path: <linux-pci+bounces-41026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD991C549D8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D597A4E3679
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06E2E03EF;
	Wed, 12 Nov 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaOyBbZW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EC2DF6F7;
	Wed, 12 Nov 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982844; cv=fail; b=ndjRqX292c0ktiLLRYb/1gOtzZLm3PIUJtsQ9lbyjZ+zQC4/aeGF1wKJr//HltUDlAt5s65nI1IAzZ1DzmtqeSe1zx5e1uUJaXU+uHWSv4AZb5oa59fJDi2pI84fuIg/qlzzWCbxGIMgRWydeMwfYuAFZDmC4kt+4MCTD8kQHYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982844; c=relaxed/simple;
	bh=ofgZU0tmhNGbCjK5AozfRL9mIee6k3zAZn2WViwVXkY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=gtss9veZY61st9xcBEB3xBrADiCmcGhLcHoF5HY06ahU1PUJIlzDJwdYjmc5Z+v5ct6zvZNSZEtY5PI8NthZVtAKdd3Tg7QrwY9M3WHsEBcq/QLzeH8WVnrNyRyWEaUHrXyHICF66nwrn2POfkEAJNkUEULxjIHbr6WPyHjWVFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaOyBbZW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762982843; x=1794518843;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ofgZU0tmhNGbCjK5AozfRL9mIee6k3zAZn2WViwVXkY=;
  b=KaOyBbZWjDopMO5up9wo066nkn6oeTa4OGfWXnRBwSp1DH4DgXtUjabJ
   hRPsWltwA9TbSO01D3akbZ87glBVJZA3BID52WVpf8Qr6G54NH07xWDll
   b/wQOZTwGBtBaZZVvzFQAWKH6/FE1feWOikecMtBttnsHVcJemqHh5Yl/
   f/kRfQi4r0yIPb+5lWy2D3kugWiIAWU6y5VT2D/mbRHh1MEpGqGAsn4DU
   S+BYvx9d8HQH2To7f81nNTapTvpvGoZYv7VSoypmoLnivJzOH7HUHWNxE
   ctraGr0t4ht9L61ffZ9J91n9ZvAsKco4LfMr4fjjRlq1f4DcaIHR88d1C
   Q==;
X-CSE-ConnectionGUID: yPnOzwEdQ8a9JcbTI0ykkA==
X-CSE-MsgGUID: T58t13jgTQOoVEXjdwOFEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76161684"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="76161684"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:27:22 -0800
X-CSE-ConnectionGUID: Ip3Uhx7QS8yv8G327P5e/Q==
X-CSE-MsgGUID: obPNIj3qTYimjKqKAKrD7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189106147"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:27:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 13:27:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 13:27:21 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 13:27:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvDcAjBrjdE0WV+5yJASX5DL55NGCJFGWjfvoT5nvlCko//9+hYRLcjY5HpXBFnfkRkyoLL3AdXL0W3OVyTPpgLwYGxgrdAloH3yGTydinLlNUezCOXGIcb91ETLXZtM9410eBSrwLB/vhXJbVA48s2ENemfua1VTx/A586EpUN5dej7A3u1KLVOGWQO3/C3vF5trWhOj7Sn8fGExTl7+ggf6Ob01wJAPV0hWmhuiEfPN/3PmAi44IuImcR01RoZ+imzfhguaZ9//5RsMe0w2FV4YxCDXpp10IhlV8l0XQ+b6LYM3N0muQqoLk2t17xDU2Gx3u8k0SB0vifK3FuWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VY9lJmqj6Jq5nP5dGbaf7nNuzkO579T6BZL4iftvck=;
 b=wFbaqi9p0D1eQFCLGpZXjyG7nkNV/61ITgbUGbBo8edZ6zLb6VU8Y2Cdy0ZVXDGGQTpT6oQ25xfMBnSa3DPUOUccfyeG0lVYW7espJkZZEEu+3Ma0NBPCh6WYnagS2QctEeSIKvOqhdTjknO9QIrI01QS5VbJFuI6yy21DSlGR/LLtpfqxGaYgie5ht95xmkOyJjwzed08N74SQTXMgj3kSBHM5Yt+U4CVe/uh5Aj51Bv2BfBG/9Pz8WynQb9dHD5tw/KTSw+JLdXFNjhGMJtslMB7Z+biJvFAfJXAjyhE8MdRlUtzLDat2TsVGvRSKNPECsaLuqCTmfL+NqN7GC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 21:27:18 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 21:27:18 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 12 Nov 2025 13:27:17 -0800
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dhruva Gole <d-gole@ti.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Frank Li <Frank.Li@nxp.com>
CC: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Alex Williamson
	<alex.williamson@redhat.com>
Message-ID: <6914fbb5a6ce_1d911001b@dwillia2-mobl4.notmuch>
In-Reply-To: <5068916.31r3eYUQgx@rafael.j.wysocki>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
 <20251112063941.kbg44srt5f7rfkjb@lcpd911>
 <5068916.31r3eYUQgx@rafael.j.wysocki>
Subject: Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter
 guards
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SJ0PR11MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: eea81b73-8f16-4f56-20cb-08de223241f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejJaMHZ5VUJSTUozYWtZazFTQTJOOCtnWFo5dzMwRWFscUtRTFFBNzlERnk1?=
 =?utf-8?B?a0E4L2hTTTJGSDBLbU5aTWsxU1pJWWVVTXF2NTFDSVB2R29BaWJHT0ZhSWtU?=
 =?utf-8?B?SWt5ZnEyTTlYbk55UzdLU05MVHgzeG53Zzk0WlBSblBrWE1DTldYZVdSNjFT?=
 =?utf-8?B?VGF4cXBuSnZPMU9SaUVhSFZPVTZqeGUxYXM0Znlxb2RmdGR1U0RTNlNpdTJj?=
 =?utf-8?B?Y2dicUVaRm42Z3dXMDRxc3N2cEpXSFBzL0ovcFRYOWdsN1gzcm1UT1NQWEsy?=
 =?utf-8?B?NTJDUUdwRXFOYmNqN1dpMTRQKzUxczVOSGtKd3FDTWtHSE9GeDhwREljdVM2?=
 =?utf-8?B?UUY3c1BUK0ZzdGl2VGdPNXkvb2J4aUtUOGtMT21Pd1p2bjZwOFdYUHgwMXhj?=
 =?utf-8?B?aERZK0tVaDJ3blRXejFURWQ0ODlrdFVwWjhJcFN3NFBERDhmUWkvNkJKRlIw?=
 =?utf-8?B?bG90djlCb1dtV0lGem4yWTRqVmxydEJWRDVTZmhpSXdST1o5TEFtcjN5UmtI?=
 =?utf-8?B?dlY1RjdYZTdxaURwRjZlZzV5amJWTE8vN0RDVlhWUGF5TXNkWVJhZGtDb1lX?=
 =?utf-8?B?b2U3MzlUdnpnRW4vL1duTmwrK3RWb3pnTlBiN1JtVEVqckM0MndITStnZXJT?=
 =?utf-8?B?NW5kZXk3akJ1R3Exc0NnRGxZMGtXRmh2RWxEZGFQbVhzY0pMTTlSN1Q2ZEFZ?=
 =?utf-8?B?b3N4OExkL0ZoRVpNZHJrWkM4SVFsRDBsalgydVA4NUJPMEFodE9SWHQwWGxv?=
 =?utf-8?B?SEdid1M3ckJRbGhNQWZaY0lMWEdmanFzb1pTM0JONXM2K201NUxBRFUxQTli?=
 =?utf-8?B?YjY5N0JMYUNTK3MxK3hGdFQ2YjNPckNRRittV0pBNXpMODQvSml0SDJHU1pL?=
 =?utf-8?B?aGkwZFIvUk5yS3Q3RXVxWW8xbkRIRmdJRmp3OWkrOW9QWGw5ZDIxOW5IV2x3?=
 =?utf-8?B?RlEzOHNQLzZPRER2Ym90QVJiNlJ2YzNUUFVTaXRQRk5QNndrMThObWMwTEIv?=
 =?utf-8?B?TDV6b3NZbHZTSmkzMjYvbWhqVHdPNldYVnpoMFo2QStMaWhzdmh2RFEwRjJE?=
 =?utf-8?B?aUpBSlNYaUhVY2NkN210Yk5lRXNsdHFVUExpKy95MWlFeHFkS2IxY0JLa2Fo?=
 =?utf-8?B?akVjMEUrcVRHOTUwVkFLUDQrKytQSWM2bmFuWWdmRUM2cU9sS29BbFdPMm1h?=
 =?utf-8?B?QXZ2RDdIdnU4bVJJUWdRZWI3R1dtcGJoT2RJREFzaWxnTDZDdGJxbmRWd29O?=
 =?utf-8?B?V09qVnV3NmZJVzNyNnF1dWJDT1pZcEp2VWVYeWhzRk9LVDJrWm8rU2ZyUjlq?=
 =?utf-8?B?aURPZFpVdmxBbDluTmREVi9DbTNvdk5wWmRsTWhxTVRPRlRYNms5Szh1S0lj?=
 =?utf-8?B?U0pMYmhua2lZVTdIbHVQbzYwTDUrMmoydkoxcXg5QlloNU04bDBTT2FvOWpx?=
 =?utf-8?B?VFYyQmZwUnAxYjN4cW1nUmZGQ2RtckFORmZsTVFkYWJsL3dxTHkrU0V1dzl0?=
 =?utf-8?B?eDhNQStuYTNtM1Fkc2RXSVhicXF4Sk5MVFpoVkZtWEtyUXFTZ0QwemJ1Uk9S?=
 =?utf-8?B?ZlpaZmJTNEZPMDZ4VHBRU3lYYUF4eGFmQWgxMlFkblVkTEwzR2lkcVJMbFF1?=
 =?utf-8?B?YUExQlFkNkh2cUVicmtrc0d4cWhSUjI4ODcyK2RZQnJlT2l4ZHJCVjFpRzN0?=
 =?utf-8?B?K213Y01GcFdOR2Y1TzU3T2s5TlE1b0ZtcWdLNkI1TWZ4V1hHK3JYSlVUQUF2?=
 =?utf-8?B?czVLQm03bVRHcEFtbWRUR1ZqYytKSmE3VjNyMGFsWmhIc0lYYVpBUmlUVmQ0?=
 =?utf-8?B?UUJLUGhrajBDVlFjVUt0RGNaOWI5UXFFbVJvVWdjQVo2VWQ5d3FmY1B0RFRn?=
 =?utf-8?B?dXphZnYzWEJIODdOOGxPM0pDOVQ5alhaaERXdjlFMUp6WFRudXFmdWRGRDlM?=
 =?utf-8?B?WjRKQ1NyMnZMQVZhSzFBTUtVS0tTeEg4L0EvWWRROGc0dlUxNGNSbVFhRjVV?=
 =?utf-8?B?TXpEaEY0Q09RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNMYmpwTDVoWFVZZ2ZFTzJpcTZ2b3J1QnFVSXdEUTRheW5FOXQ3K1hQTklo?=
 =?utf-8?B?eDV1b0l5Z0IxODVnVXN0MTlhTmdYeFh2bVpiOGlPQTlJeFVqRDVoMkt3ZmFn?=
 =?utf-8?B?T1h1U2tkK2wza2QyOVJ3OXdESnVxVWpXd2NNaUpDMDQ3YVYrQ2cyOXlidUt5?=
 =?utf-8?B?OG1lQXZTODNETEdVelNRdmNiUXBKRTFQQytOUFZLZTExemp5SkZ6dnBtT1JR?=
 =?utf-8?B?VzVucTkwWStlakxQL0RIMGpKNUlNOS96Y0lMYnUvRVZxQWVqcUhaTHpsaWhC?=
 =?utf-8?B?WXI2TGlNMWxZU3h1TzNYWDYzd0VJMW93aHRxYTNmeWw5VWM2d2t6VWJEUXNW?=
 =?utf-8?B?bm1Tclk2dFZMNm9qdEJyMmVvTU1EUUY2L0FqYng1SmV1NkUvU1ZUbjU5Wlph?=
 =?utf-8?B?dWYxZzVEZ29VcDhIV3U2T2NzQXZTZ0FwUnBiR0hCVEFCSUsrVzZVZjdWb2VV?=
 =?utf-8?B?RVE4cXhLY3Z3ZzdPQVVuUE5Ga2VZNUJqMkZQMnE4YlpLS2ljU3BPbVdQTXFx?=
 =?utf-8?B?SjFvbjdhRkJpa3NRVTZyYlpLaUNFMWVCMk9TRGVDbEZ3NVZtYnAxUGhOM1RE?=
 =?utf-8?B?SEhhSXh1UmF5ZEcyVUUyTnJuanF2MWI2c0g0anlzRTZLdXFrSWdoQ1RHMkJK?=
 =?utf-8?B?aXhsV0QvU3MwVWNQWjhKZVBORm5ZM1RqNG1ZSFozOHdLdkpGbEJuZlJDUTNW?=
 =?utf-8?B?ZWJUcUFoa2RzU2drN1VmRERCQkgwVEd2bTlEQU15d3FHMlJCZFQydjc4Y0NF?=
 =?utf-8?B?Tk8wYktRN2N2Qkc2R2ZHcG5XQWNTM0JUbE5VQ1d2dkZzcSthOTZhOXdkNE1M?=
 =?utf-8?B?c3d4VGcvTmplb0l2VVBPQXBFL2UvWTF3dUhvQjNnek5lMVFEN0N0MEtvSGN1?=
 =?utf-8?B?eHFYYi9zUERQRTN2YXFmNzZZRDkxb0xZRWlqK2taVWNsM0ZVUUwwSUtMaFhV?=
 =?utf-8?B?MEViaDdzMk5sU3NNVEdOczV3cmx4S3BlV3lKRU5OZy9sVnhMdE93NVVKY0Ix?=
 =?utf-8?B?UXhlRGZreUp5azgzbUlnNy9NU2o3OVRUUjJYM0IxdW9VT2E1a2E1OFVtNVFF?=
 =?utf-8?B?ZkUyRXdsUnB3SldFVjZkM2lOZVhkcDVWT1RvSzlEalNKNUMwRWx2RkRsL3pB?=
 =?utf-8?B?Ty9ucDdncTUwRjc1M0FvMGpaQmpKRzEyWHB0RHdRNmlhUW5OQzhXS0hSZG10?=
 =?utf-8?B?UUw5MFhIN3g1TlZUN1luOVFDYVJMNXA3NDEvdmFMQnZHcVB4R2Y1NzZ1VDRL?=
 =?utf-8?B?YzRMMnMwNUtUcGZxQ0RVMWlwTzZmYk1tK0xOQW9McjBSa29yYUxHeXUwSkNO?=
 =?utf-8?B?c1EwTXlmZHFFME9tWGZGdnU3WjBhK0VuZm5YVXYwdFFxQS9ENm1RYkV4aFRn?=
 =?utf-8?B?Q1JocGhrUkRIaHZ2c2E3VGc0cEtmeVBlWlQ5RjYzM0tIZkdSVnJsRjdKSUQ2?=
 =?utf-8?B?R09TaGx5YmI5K2Z5MGV1Y1RFUGN5UnVPRzJVY2h6c1k0TWMwSVdsVGw5L2Ji?=
 =?utf-8?B?c0RZcWlJQ1NWTGhJdlhuSndMV2VtcUl4enYxY3JweHpyaHZzRytzNUdFVkRL?=
 =?utf-8?B?VnYweU1WUWZzK1lYRE5WUytQczNBMEhNQ1ZQQjd3bFVBYTZzS256QTBCV1lQ?=
 =?utf-8?B?ZWpZV2VadFRGY2c0UlhYZC84eGZaTGk2bHhYV0M1TTFjc0xpMCtWQTdTTGdR?=
 =?utf-8?B?N3ZGcnlQeUY3c1lHV295NURGMHM0WGZBaStSc1g3blN3bld4bG5YRDNNNlpY?=
 =?utf-8?B?VlVvbzdTN2tnNGZvVU9ZMHFjOUlpUGVZaUVYRThWNXljUFhKR1VES2pxbTJ1?=
 =?utf-8?B?dmJsQkZIVHBRVTFGREpBQnMxcG5VNzdYNUFic2k5QWFudVdOTFVvVVo4dVh3?=
 =?utf-8?B?ZElrVFI1MzRwbllEdVd0QXBRVVhnL2FnemppM3BKRXhFVmlsZVFpSHFYTzd1?=
 =?utf-8?B?cE0zcWZCbEI0YXRFZ3JBaXFLWHNOUndMN0ljdjNkTGxhYlVhVm00dnJNTkpp?=
 =?utf-8?B?c0YxN0h0aGhJUjM4QUJCSHhHbndkSE1PN0REZHQ4QTJxZ2lKZEZrSnRBSEQw?=
 =?utf-8?B?ejdBVUpleWdYU1FJNXJPZFhkY2RocW9OakJxL09XYVZ5MGE3RWtJUU00Z3l5?=
 =?utf-8?B?eFVNVjd4WDU5VnVHM3U2MDcvQ1llQXF0eWd4R25nUkd6UWUwRjdtZkRWa1E1?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eea81b73-8f16-4f56-20cb-08de223241f0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 21:27:18.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt7CPtWdCgvbyNrcNVDWT136qrtYbsVzBj5eA7MNCY0ViNAQ60v2i6QW/PIaWD3yQnxIB21wC8ed3cFeuqlBnRn0dW83MNWRMnWjOqDItSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Wednesday, November 12, 2025 7:39:41 AM CET Dhruva Gole wrote:
> > On Nov 07, 2025 at 19:35:09 +0100, Rafael J. Wysocki wrote:
> > > Hi All,
> > > 
> > > The runtime PM usage counter guards introduced recently:
> > > 
> > > https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wysocki/
> > > 
> > > and then fixed:
> > > 
> > > https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wysocki/
> > > 
> > > should generally work, but using them feels sort of arcane and cryptic
> > > even though the underlying concept is relatively straightforward.
> > > 
> > > For this reason, runtime PM wrapper macros around ACQUIRE() and
> > > ACQUIRE_ERR() involving the new guards are introduced in this series
> > > (patch [1/3]) and then used in the code already using the guards (patches
> > > [2/3] and [3/3]) to make it look more straightforward.
> > 
> > The patches look okay to me,
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> 
> Thank you and Jonathan for the tags, but since Frank is not convinced, let me
> bounce one more idea off all of you.
> 
> Namely, I think that Frank has a point when he wonders if PM_RUNTIME_ACQUIRE_ERR
> hides too much information and I agree with Jonathan that may be misunderstood,
> so what about defining the wrapper macros so they don't hide the guard variable
> name, like in the patch below?

I had been reluctant about offering an enthusiastic tag on this series
given that information hiding, but with this change:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

However, I prefer that the scope variable declaration vs usage
(reference) cases should maintain visual separation with an operator,
i.e.:

        PM_RUNTIME_ACQUIRE(dev, pm);
        if (PM_RUNTIME_ACQUIRE_ERR(&pm))
                return -ENXIO;

Otherwise we have a case of different flavors of *_ACQUIRE_ERR
implementing various styles. I initially looked at hiding the '&':

http://lore.kernel.org/681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch

...but it grew on me precisely because it provides a clue about how this
magic operates.

