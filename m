Return-Path: <linux-pci+bounces-6601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ADE8AFC6E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489A6287ECC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1E2E62F;
	Tue, 23 Apr 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TA6zrdpJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516C1C6BE
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913844; cv=fail; b=E7gBtDo+HgnDo6TRndTsBvYiLXf+cIHlbMgEFjDjUPFYOoCpUuKcD7nWB6iGlwRlyQKKdIfwatEdnLlFi+CGOPhJp5rn2iIg0iSsV2G9AoFvVWFYXxkCblWgGVTKwm25FtquYMSfuNB/Qq21IS3VgOOWAIMSd8KDogXL0l+PbtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913844; c=relaxed/simple;
	bh=37eI6jvMgD5qyNjkd3vq4fnMD90dB1wGuVXQX1MzxwI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8lboyphuAyJpTmfmTisM20Ds5DnIGByVUwFvHxPJLNWsljauPc2Uqk4VJ6LW9leoBwQ9MA74bLsb//WaYFgGmZOYDxVwQ45ICvV7xEeJuryCH/iKHqSFjwWiFAnIA0ufx6T4mECoxxux561bXwoHMUoZ02NpatL6m6VO28hCLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TA6zrdpJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713913843; x=1745449843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=37eI6jvMgD5qyNjkd3vq4fnMD90dB1wGuVXQX1MzxwI=;
  b=TA6zrdpJXu2a9ws3RaUY9BB6S4mZtM7XrmzpBLf/ARS4q3/1k7wcHsth
   CMtGHB4DO8tHoelzHrVhr4qvyuqWtpV+MwsrkDPVCYAv8ZMYu4cGCeSw2
   Bpuy0xflZkzLOTvDDiVdHiIRNrg6CZAEzjslaNPm9vG/9LInDw3MJ+NCx
   cDRoKoLqXHPL6HI4N/RniSqerenDbXVKHd9YpleUOSqrsijlPfiW/rGU8
   CWfWqIoKpe4Ut9SHsbnvsddQNra0um/Q5zjy4nIWMHj5qWZ3Zp/ot4NqT
   BJwozByHfaLazvfmTrBm/R+vEsZr89+NIge+nOc0IaP0GPWcCNF8NAGA2
   Q==;
X-CSE-ConnectionGUID: YZx7qat9TpG7F0jB9lzlGw==
X-CSE-MsgGUID: 5FyEWcHySl+0lWFSXb54Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9396406"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9396406"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 16:10:42 -0700
X-CSE-ConnectionGUID: xJiwikQ4SF+SDVKvVCPcow==
X-CSE-MsgGUID: M58QcfKcR9SzY7ZNE79oTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61972483"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 16:10:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 16:10:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 16:10:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 16:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iidmWll5+SECq4dsFxjkz5+EpItsDquihCaoYOUJuqtbbfKFiL3DIn6ynMbrRR8pIkjASoTtxWWfPFE6v4ZyXq2Tt3ltuonSAPTjvPdHmOKcQT1tw6w+OeJOXm2rN2Jty2CZrL2LeFAy1MCdDL1IJnyOs1wTfigEPxFtF4UJChSgWO1fWnGuPdFl3nahTC0gsnFJS2vZYITwYRJfnVEYjtSbAPtCoZI6GVW6U9b80DVaZXzFPHHPAaF94HsQS+PCCDEwukKfq354nivhz4OUPg6zKlxf1jGz2gowpTBg2egz7MdPp8P1HU+x9FMB2xDQ2Jj5F4FyLuvtJcV4pB3YDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f62qB+bQ3KzcXSeqZCWTgU/hObuW3yf/gP+o7lvW8g=;
 b=ZdAZeKY5bugYTnKYDZey9jnwOOu4GDjmAdXtre3Y40dFdP1A8vULK0RbWkXV7Ze8pTPyBAPVRcwuMxMeThc6Wka8DFROIokUt5Zk3DUgZ774l8F4MNZiOG3hqpSrR3M1SWTecAsHuB5Eb6isx51xdH9A5a16r2ImqoXvZEIhTGuqHjE1Zmcl50DH+2a3CDzTBESmJh+z+T7nLXrKEStVOGQfzDX/vFbBJuu4B0Cr4G45BU4hEEOQggbULD+4HKu2irjgwHlKw9wT2QsXRWUQfZ6u4sAtvPU7jinJuJN20NvdpsseChXjRA7VQKPDAyIN3sBdPaA59vwlLQjvPexe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 23:10:39 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 23:10:39 +0000
Message-ID: <413d99f0-0af5-477e-a3cb-84f0955407d0@intel.com>
Date: Tue, 23 Apr 2024 16:10:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240423212626.GA458714@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240423212626.GA458714@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SJ2PR11MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 938d53dc-59f0-4bd8-5ffd-08dc63ea976b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REgrdWNpUjUxZURLVElQR0dYWXQ5OXBvdDhNTGpZT1Z6UlpPRDlLUHRVajhj?=
 =?utf-8?B?d1F6N0pEdWtubSswK1RldGJteGhZOUFsNldVVjR5RlVjaEsyQTNlM01Bbm93?=
 =?utf-8?B?NTIxRWFUNjFvckxpVm82RXFJaTNSTDU0TmZaby9pdk9taHM5cm9wL2RjQzVw?=
 =?utf-8?B?akk4UkR2NmJVd2V6MitzNTM3dFI4aExqMjZ1eHllY09MdW5vdDFEWGdsSzBT?=
 =?utf-8?B?T013ZXdoTGhveXowUUVvWXFGcmdaUmhGd2tmdVIwWmFHODJpb2N2dGdydXox?=
 =?utf-8?B?WXNnWHVvSUhiTU1NNEV3NXdIUGFlRFhNSU4yUU4yM3kzb1FKVUNzVSt3QVFx?=
 =?utf-8?B?S1hjRkVOT0tycUg4VzB6MncxN0ZNM08wK0lNT0RmVStYSUMyRGZUTng2b1Q3?=
 =?utf-8?B?T1ZBMGVqSE5xWHZyd2kyWElzNmh2cTdBOFQrTUNxNHFLUkdBQU55OXBQVHMv?=
 =?utf-8?B?akRUYVVoTFJ2bTdIQ0V6cS9qVjg3N09mQzVVTGg4TUZwb3poQjdVTnl6cHRi?=
 =?utf-8?B?QnNtTWpQUmxxOXZzdGdhL3IzNElhU2RQcEFFdHpTT1hRYWJYbjZhWmxkU3lL?=
 =?utf-8?B?TkF2d3NJOUhjYjV5YVZ1L2tjbkJkYU14K3daL3B0OFVXa2I2T01LYWh4eEc3?=
 =?utf-8?B?amE3YTZCQ2hHelJzdVl5T3ZhMUY3Rm9lNDVtYnBpbDJVeml4WDVNRU5yMnds?=
 =?utf-8?B?MkNRRUw5bHNUb0g0NE9rMnY5UkxpZVltT1RZRG9iSHUzd1dpWjhJOTV5NUVX?=
 =?utf-8?B?clN6VXBnUldzMDFPV0JTRmtQZEd1VmlFd3VZOG0wa0RSUXEzdmRJN3FXQm5K?=
 =?utf-8?B?ZjVpR0NhZXZBSWNJNW1uVWtHSVpoM3lpVUNUVGsvY2dJZmxQUGVsUS95REFN?=
 =?utf-8?B?aExxbEZ4Q3lia1hER0s3TzBkQlhiUXlPMzRpZXRkOEZWS21wR1pYdjlDaXVr?=
 =?utf-8?B?c0dydUZkTklQelJVMEN2c3N5NjgwWG5pOFRZWWJRVHFTY3VyUDV6RDZYTWNC?=
 =?utf-8?B?L2ZuM0M4TVFjL05UcHl3N0RhK1pTUHhkcFh4N2l1dEprWnhPUXEydWpYSFdZ?=
 =?utf-8?B?SkYwdUxFbTNjSHFPNVBYejlyZDZHNGV3RUpRWWxlY0J5MEg3a2EvK1BhRUlE?=
 =?utf-8?B?WDRKaHl5MEs4aHRiRTVLTEdJN1FjTlJvYXVVcWlEUWNIRVFQdVQrQTlCNDFT?=
 =?utf-8?B?cnpGM09QMjdXSnBZdlY0eUJ0cjlSU09TTlN5eDVOVXFBc2d4ckIrc2FWTkVV?=
 =?utf-8?B?cnZFWnhzMVIwZ05VNDczS2FPckdGcVFGVHJXU2NmNmpEQlh5S0tKOHFvekV5?=
 =?utf-8?B?cEgxOU15Z3BlWDJPOTV0WnVUMkt6RFVnUllsblB5SEFtQ2IzL2l0bVFhemd6?=
 =?utf-8?B?MHNmVllLYVN4SW1wZUJaMlEyeWZ0dlA0VEY1SEFWTFZZQnY4L3haak9OdXRO?=
 =?utf-8?B?M3lQTUZVK1J4VlYzUVl4ZTJrZ0UwZTI0bHV5WVpIcDJHamJ4UkNKekJrUlda?=
 =?utf-8?B?K1JNNnBQaUFZZEUxM1VmZWsvSllxeFVWN1pRUXpDc0xWSFlsR3d5cUloUkU4?=
 =?utf-8?B?RkdjVTg4TlJ1OGNacUE2em8wb0x0SmhVRmhRMnpadGVoUE9Kd1Q4bTVTVS9G?=
 =?utf-8?B?YmhlS1gwd1NiUFRxaHFUd3JUbHF3K1FrMXJ0aGd2ZUViSXloU1RNRFJ3L21F?=
 =?utf-8?B?cVpPeFAwbDFFcmM0ZXI4b2RzSmVaRFRWRXF2bTZRY0FWd2I0NWJQNk9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtwOCtlYVlpYWo0NkdreGhYbFZ2WWNhUXl3U2oxM1lBOWFOTzNQcFRQQzhK?=
 =?utf-8?B?Rm5QSkErUXVWVVZVKzJaZ1BIK2NWbHZmWjkyaVkzQ2s0d1gyT2puRjBrMVZu?=
 =?utf-8?B?cmZSRmVQa1FTY05nbll5SG1uVERXbTUrUEhQQk9kSHZFZEVjUkRiclVsS2lt?=
 =?utf-8?B?TjhuMUNDcVhRdmhpZ0owZ2lmMHhOR1AvVnJoQ0N2ZzBSamF4SmVSR21CUE56?=
 =?utf-8?B?MmY4N0tWSzM4RHpkT3puNmh4VlQ1RmRTblh5STFlamtya0lRMUV5RzcwTzU2?=
 =?utf-8?B?K3ZpVjlGeWdWSzVkME53ZGVBQitaTlFTdVV6TmlOQ0g5RXRLc2tKQjJjR1ZS?=
 =?utf-8?B?dnlYZWdtM0NXTkZ4WmlTdkhDMXRobHczcUhvbjJONUhad3lrRXV1Zm9UQTdU?=
 =?utf-8?B?RmFnRTM3UjlxanNKcENuT2czNWFOQm9IWXJYTHptc0N5N0xuUG00U3VRaXVv?=
 =?utf-8?B?ektQeW9NeVF1UW9qN0NpbmJlTjBMU2NRbjBvS2hpU2YwWVlEZ3VqNmxSMmQ4?=
 =?utf-8?B?S25USTJlN3BaNkFaWTRTbzR1YXp3eEdFbWdvZ2NBRDFZNG5za1ZnM3dVR1FF?=
 =?utf-8?B?VU4yNngxb3IrcnU2Y05KWjZoU3lGNWlEUzZLL1ljTHQ2Q2pTeEdNYW1WYXhT?=
 =?utf-8?B?OTU5NWpIUDJDS202OGR0Ti91S2R2bVJjUzd5UjNpRURhQ1Rrc2YrSGJpZzFP?=
 =?utf-8?B?Sy83MmIrRzZ0YUF1cHJmenZDMXduazdjYmMyOVk0dk1HRUxaV3lxblFiNFpS?=
 =?utf-8?B?UGNEaGIwa2dKcVF6cFQ5OFJlYWEwM05XWmhxZ2x4MUg3VXRiZWxMQzBxNVpB?=
 =?utf-8?B?SEVhNjR5MUZPRW1Ld3I5QnFPeUNKQlhZOHUxVGxmS0k2dWY1MDZ1bEZ4RmRD?=
 =?utf-8?B?c2pnRHExeERyZUtpaFRMeWV3TGQ2c09oaHlHTUd0NDRsOUJZSVd4bVUyZks0?=
 =?utf-8?B?a2d6OU1UQWIwZFdDNU9jNCtvZnJtNnIxYkFkcklaOTNjd0VubnNFTi9Bc2dY?=
 =?utf-8?B?TXRuRkxIU0t4bmlNQlRMRnJrRUlVbHZpMFJpeGgydGh3OEF2UndyajA1NCs1?=
 =?utf-8?B?OUVWcVlBcHlJd3lTeHJQcGdlU05WLzMzczMxRy9WV01MTVd0REVvTm0wR3pW?=
 =?utf-8?B?ZEN6RFRPNWI0bjM1ZlUzRUVlKzBUVjJYLy9GOTRpeStrbVg0WjRLS2UwQk81?=
 =?utf-8?B?Ukw2K0lXS0pwZkttNURpUjZFakJXQ0dDMTRWeFM4VThSLzFVVGwwT2c1UXhu?=
 =?utf-8?B?NFpBQTBEYkl0eUJOelc4VEYvZnhpVElOeEllMjFiSlp0VGRjVHl5WDhCNnBC?=
 =?utf-8?B?UW9HTklmNTdtN2ptKzBDOXFGRFBZaGgzRFBCdkZkR0N5b1dxSytJSFV2eGlI?=
 =?utf-8?B?T3FGQzExU3lzWHU5eWNkUTJOSXdmWnZZU3FsL1VlTEJKSlF3dU01a2RmdzVq?=
 =?utf-8?B?Rmc4V1dhWUlSeFZTcG5aeWxBWmc1RG5wR2lmWmR6NXdIZkJlQzN4YTJHeXph?=
 =?utf-8?B?SkV5WkFJVFRXa2VVdmR4eHp3ZTdJS2lnaUhwUytlNDBkOWdBcmluTmMxVEkr?=
 =?utf-8?B?aUNGdWtWRjdjdkxwM29uYzFEYVFCV211OWhxVjJHL2FyOVBFWjRvWStwakhU?=
 =?utf-8?B?UFE0L1VKNDJWaDAxR0hBLzErNDR0RDcxNXhoVEVCV0lDUmd4UE5oeXpYcDUy?=
 =?utf-8?B?Z0ZJNU1Tc2dUQ2VxUFZRV0dTUG4rMUdaUjRWWFVtSEhZZHlRUDBvOGZ3ZWdC?=
 =?utf-8?B?V29qVThzR3V0QWhuZlNNdjlENkxrVk1xVjhpd3JTajlUVGtpcW5UcXN4MW8r?=
 =?utf-8?B?SnhUd0NhUDF5ZXNGMmVjeExXeTFYRzR2WVNLalJ2dEhFK2t5dDNVb09GRGcy?=
 =?utf-8?B?MWRodG80RUxqTG52SVJtd3VUOHZxTUJ2b3hYU3BpdGJWbVBic2Q0NFEzM09a?=
 =?utf-8?B?aTBmY0pDek4xSk5SSVRJT0hUeGtGTW9SbUZkUG40RkovQjJUejE5TmUva0tx?=
 =?utf-8?B?UUtTQjBBQ1BveG5IVFZaaGxva3R4L21PUk9QcHI2dVJSL0FuNW0vaWNPalZk?=
 =?utf-8?B?clprYVRnQW14Ty96N2RZVVFoUVZtR3JZNFE0OFRtUG9mcmtvQkF2c0dxb0ZZ?=
 =?utf-8?B?NzBjejNRQlpEeWF4bi90cE04b0NPOTFpMnJSK0R4WG8waHBKeU1FTzlVWEsw?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 938d53dc-59f0-4bd8-5ffd-08dc63ea976b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 23:10:39.4478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkK9qaL5iAZ3uY6H8kv1Vx97jwa2KH5C5G/Ccq0kwCTYzCIeQw6rJ6I3M2aG5lGa5JKg1tHnKinUeZphRTvhxDN6nuL+8qqW7WGUUBB5IQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com

On 4/23/2024 2:26 PM, Bjorn Helgaas wrote:
> On Mon, Apr 22, 2024 at 04:39:19PM -0700, Paul M Stillwell Jr wrote:
>> On 4/22/2024 3:52 PM, Bjorn Helgaas wrote:
>>> On Mon, Apr 22, 2024 at 02:39:16PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
>> ...
> 
>>>>> _OSC negotiates ownership of features between platform firmware and
>>>>> OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
>>>>> device advertises the feature, the OS can use it."  We clear those
>>>>> native_* bits if the platform retains ownership via _OSC.
>>>>>
>>>>> If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
>>>>> the domain below it, why would we assume that BIOS retains ownership
>>>>> of the features negotiated by _OSC?  I think we have to assume the OS
>>>>> owns them, which is what happened before 04b12ef163d1.
>>>>
>>>> Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is disabled)
>>>> then all the root ports and devices underneath VMD are visible to the BIOS
>>>> and OS so ACPI would run on all of them and the _OSC bits should be set
>>>> correctly.
>>>
>>> Sorry, that was confusing.  I think there are two pieces to enabling
>>> VMD:
>>>
>>>     1) There's the BIOS "VMD enable" switch.  If set, the VMD device
>>>     appears as an RCiEP and the devices behind it are invisible to the
>>>     BIOS.  If cleared, VMD doesn't exist; the VMD RCiEP is hidden and
>>>     the devices behind it appear as normal Root Ports with devices below
>>>     them.
>>>
>>>     2) When the BIOS "VMD enable" is set, the OS vmd driver configures
>>>     the VMD RCiEP and enumerates things below the VMD host bridge.
>>>
>>>     In this case, BIOS enables the VMD RCiEP, but it doesn't have a
>>>     driver for it and it doesn't know how to enumerate the VMD Root
>>>     Ports, so I don't think it makes sense for BIOS to own features for
>>>     devices it doesn't know about.
>>
>> That makes sense to me. It sounds like VMD should own all the features, I
>> just don't know how the vmd driver would set the bits other than hotplug
>> correctly... We know leaving them on is problematic, but I'm not sure what
>> method to use to decide which of the other bits should be set or not.
> 
> My starting assumption would be that we'd handle the VMD domain the
> same as other PCI domains: if a device advertises a feature, the
> kernel includes support for it, and the kernel owns it, we enable it.
> 

I've been poking around and it seems like some things (I was looking for 
AER) are global to the platform. In my investigation (which is a small 
sample size of machines) it looks like there is a single entry in the 
BIOS to enable/disable AER so whatever is in one domain should be the 
same in all the domains. I couldn't find settings for LTR or the other 
bits, but I'm not sure what to look for in the BIOS for those.

So it seems that there are 2 categories: platform global and device 
specific. AER and probably some of the others are global and can be 
copied from one domain to another, but things like hotplug are device 
specific and should be handled that way.

Based on this it seems like my patch here 
https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/ 
is probably the correct thing to do, but I think adding some output into 
dmesg to indicate that VMD owns hotplug and has enabled it needs to be done.

> If a device advertises a feature but there's a hardware problem with
> it, the usual approach is to add a quirk to work around the problem.
> The Correctable Error issue addressed by 04b12ef163d1 ("PCI: vmd:
> Honor ACPI _OSC on PCIe features"), looks like it might be in this
> category.
> 

I don't think we had a hardware problem with these Samsung (IIRC) 
devices; the issue was that the vmd driver were incorrectly enabling AER 
because those native_* bits get set automatically. I think 04b12ef163d1 
is doing the correct thing, but it is incorrectly copying the hotplug 
bits. Those are device specific and should be handled by the device 
instead of based on another domain.

Paul


