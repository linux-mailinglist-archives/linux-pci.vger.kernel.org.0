Return-Path: <linux-pci+bounces-32437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8765B093FF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D39A612C9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB497207A0C;
	Thu, 17 Jul 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ih4iq7ES"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C72116E7;
	Thu, 17 Jul 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777259; cv=fail; b=fjY7XMO2gzCNqrRZBPViV7uBo6DIrUfjR1rcLBsGinxRGzN7VRYE0D5hdA4EEmXCQdxJbqYZymJlzkCfglLgNnZ+9uIegIiP/G1CyPJ5Knjs9vg98nX8vAV+8tXmcYodZtIJZRcAfOO0gh8pmN/VSHA+nwEJOpPzO3a+DiF8pRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777259; c=relaxed/simple;
	bh=trR2GOy/pmhq4mHhUyJWH4mxBtOMyY6ruUdG839o0wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRx/D6q+f1y02uLNswmpeBBYQq+R81SgVlFouB5Jxa5gsBIFo6kwAFmGL+8zSOzd4FS4f51nX0DK6oCrtu4pAXqv3nC+puPlECjfqwPv5v6fFkrJYOU6PjwhNvJBxyPtUylPWFfnKKnALU4+RZqcDH0HgvXWS098+0tE0F+sVgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ih4iq7ES; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752777258; x=1784313258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=trR2GOy/pmhq4mHhUyJWH4mxBtOMyY6ruUdG839o0wk=;
  b=ih4iq7ESkxfaHVtIKw0kkAFhzAYKiHtQN8Xs/rcQlIWet/OSfQnImr9E
   PO/vt7LWa9GVgCpZX7wTza2U9rdFeiZyYBtC3rjHK+7ft3Mdle90F6d0m
   dcPx9Xjfm28CaG3RY3UuaINGhxYnLjtm/+J4SfCh26SvBfTZA1AYZ+f5/
   mJ6TNHk5JHzPw6QS8PHafyZLJ/Hp6VlXvDuaXCFXDmzqidKpxQvWvrY2y
   moiZA/u2CmP0H7ZvAji5GnJ+qeziPOsy0/65RkdOc8j7kenxQhrHZ9KE7
   uPbLGnA5od6mzBSQZpAVYNPApWRCyqIU42VSTBs72ggD7PkQEdy/ZE+u+
   w==;
X-CSE-ConnectionGUID: eEtQWxA3QeCUVuLM+jYpTg==
X-CSE-MsgGUID: Pm8+Ff+LROWUYtXQNSsGww==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54924077"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54924077"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:14 -0700
X-CSE-ConnectionGUID: uDHajVnsSxKPSqEFOFMzOg==
X-CSE-MsgGUID: dI6HiZASSOOxHHUWefDNcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157254626"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:34:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:34:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+5/IEWrQyFwUSfe+CY+I9P3X2AMhOAys8EXDmvKwzbwSiKygnWZo3QUVecSZB/PDz+l5KJKebu+pD6AIy9UAa3FzLXjWA5YC8JzRjCA3To3mxH+TbwfxuFyu6/gArVBswGfKd4UWSERPt86MvpR6ayja6hssGCZuLSrYQO+Fl4z12fmsVRxPJJM67XMvCEKRq1tSILsVlCnjgUzI+VCTiWQTwxSv5LHT3gLMEICgNAozcIP4IuCDkejCpofPNGHPXjET6Tro3RXiVTvdAJL3LVzn4g7RGkEdx8KY5aEMWaJrcymbkpeFsR0aLrU+0iDImJ6aSiETOuMASX6/z+18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpsU/aPLBls6dfV/Q9e9bz0DU7CQmn1Y1fldfyfQCsI=;
 b=p2fj9GkvI9WKzYYLF1jCZXG5qBIZIaAWrQQarZetbkg/miIbtyKCPp8W/sPeSEoofGgXVJHgUbmw2OJjoZKSBOOp9QAJpLYmWj3YMbxj6hcCpykAqc9WK4V4EHg6ohvnGjq3sLbsUmTT+1mfuspHq9/bOT/c51ASlH2Ej/XF5l8QVoB99rsp9bq3rthi6v0PXTOfO/l+r/hExKzWoq5yQF6oZoGwWCyzWIeDfa8Ots48cjOMDae6ayxCN7HzSpFFP3pSW7+9ngl9Z/j7c/uvaiQDw5dl/2g/WGdcrCM8a8Rog+Eidysb5JjZZItAFfizBhv3GWlUNXHzGP5RtovgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:34:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 18:34:07 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: [PATCH v4 06/10] PCI: Add PCIe Device 3 Extended Capability enumeration
Date: Thu, 17 Jul 2025 11:33:54 -0700
Message-ID: <20250717183358.1332417-7-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717183358.1332417-1-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1980d680-2877-4661-55bc-08ddc56083e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk42OFc2ai9iTVVVNWVBNFBZNXI1KzhJbEdhYWhuN003RnhIWjVvZXdrVSt1?=
 =?utf-8?B?bGpaWTlDOTQ0TStqRk93bTlCM2YyN2N6UHdjMTN2c0pka1g5aGlybGE5bHp0?=
 =?utf-8?B?T3k3eXJBOVp5RDd5TkI5MGQ1c0dXekVwN2JRbTNLdFRpZzRjRjhaT01RVmRz?=
 =?utf-8?B?enRmdUUzQjRMN1lrek8vZTRFVzZoek95bDVFeHpaOGhFejI1bU5GSU5id1dL?=
 =?utf-8?B?bHhneHJTWllnYnZNT0xzemVGVEszUC9pVnZaNU9Bc1Z1ZlZFQ0xROE1BZnU2?=
 =?utf-8?B?SGJYTVRhMTgwSmJoOWhJOHcvVm9vNS9BK1pOZXlGbEUvRkVvSEtKMDByMmlV?=
 =?utf-8?B?S21lclB3eHFZRmNZT0pwRHUrWDUzZTNmUUtWV0ZzRjF4aFlXR2U3QTRhSTIw?=
 =?utf-8?B?UmFQWmxDREpDOU5pakFDNThRTng4RHhtQnk0V0JnMmMxQlZXZmtnQTY5c3lv?=
 =?utf-8?B?d29HOEJIUllQY2ExZjlDUDBtRDlXMkN3aTdwckFacnc4Vm9Eb3RSM3lxOWMr?=
 =?utf-8?B?Tm1VMDVvbE96eDN2bGdMdUwyelV4MytxSGRIY0hCWWppQkM2VE1LOUt3Qkow?=
 =?utf-8?B?SS90MHBJMWROejFKN01WSGIvMVNITGhycmxEamE5VlRQQStOZ3dTL1lhN3cw?=
 =?utf-8?B?dytTOHRFS1hGcVVMNjN6cUI4UzZZYXIyYU5qNHJmZ1R5NHFiME1FeVNIZE96?=
 =?utf-8?B?cVdpUFd5NHpvczJvM0lSeENidWxOWGswRkpCQVhvOFZITXowblZhS3ZtTURj?=
 =?utf-8?B?djFFdzR0MTVoN3FTOTlMUlRBK1pkdUtLNGlpcDRIcFZoanQ5a0RhMXpnOHh2?=
 =?utf-8?B?YUdlZDZ0anJ4c3FhWGtmaDl3ZUFxZ2hLOHc4VUVvT1lock54T3RLOEZsWW5x?=
 =?utf-8?B?YWNnSUJFd0wvbTU4RjJwWUF0WWd5MXpTWjhrWUJML01sZVM2RUlWaDdJS2JL?=
 =?utf-8?B?SjUwQlpDYi9XRkVXZHZUclk3SkVtQUl0aW5WTTNMMnFtc3VsOExzdXR3M054?=
 =?utf-8?B?UkhRTS9pZ050Nll5R3plQTNvV09vMEo2MTJWTktFUVNnenJsM3VUSFJ3djB4?=
 =?utf-8?B?VnlpYXh5elNEL1ptTHJLbUlvOTNmMEM1QTlpSDEvRjE3T3N0Zm1HcDJHVWth?=
 =?utf-8?B?R1FYS3ZPNnRidDlIR1MyWld2K1RtZHZtSC80aWlocXFrMlhsdGRzZnRFS1ZL?=
 =?utf-8?B?SUtQSnloSWF2NWZQMUp6UnIrbVFNaFJQazhZY2pPUFo1UnAzNGt4d2tRVlBB?=
 =?utf-8?B?RDlDL2huMmFtOVBpQkNGeUFPc3NNNUZZUk9qalByV1lYb05zUExEZWNaK0Zj?=
 =?utf-8?B?UVRnUzRVTjFTNnQwaVVqY1lzNXJwUjBLV2lGT29kSEhCNC9nWkdBRk9JVWVE?=
 =?utf-8?B?bUdNamlYQXRjdUdrUHFPUWN6Z0U1Rzk1RFRQcDNLVWFWaXZQSVpJb1JsSWRr?=
 =?utf-8?B?V1lBTGwrYXR4ZHQvd0wzYlFKMHRpelJlaCtXUWZoRTdPZDVWOHJiZ1VLODJ4?=
 =?utf-8?B?cEQ2QVIzSTZPanplOFpwREU4ZHJSNVVhbmw3K29FdXhhd3FYbHpwMnlxQWpS?=
 =?utf-8?B?QkpQVEJueWdlTVgzb2NjQjhadnc4WGczU0RNZ2ZGNHRibXhSb09FeXU3c0lK?=
 =?utf-8?B?U29NTGxCVVplWHRJKzJGWEt6SVEzTlpCTWY5ek5VV0xTWUhvd3JRS05QbnRz?=
 =?utf-8?B?U3IvbnFoZVVHVnZWTmd0TkpKN0VhOThqY1ZnaUR3NVB1ejRncVJ3WVJjRi9r?=
 =?utf-8?B?SndKWEdYczIxSzErQURtZGMrWmlPVi9qZjY1ODBFSFcvMGgrSW1Yc2puYXcz?=
 =?utf-8?B?V01raExTTmJOOEhCeHNSR3VPc243bjFVN1ZFc29Ca1daN2tsTFFVTVdOSUR2?=
 =?utf-8?B?aGYwMUVaUU90VDRFQXZMR2kwbkpTakJ0d3ExZ0lFemg2RWxaaEVGaENqeGQ4?=
 =?utf-8?Q?TM4xT3ydMNo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFJTktXZSs2OUNBQ0lOR1M3c0hYaXBVVE43THFKeWpvS2twSVV1WnMrdGdm?=
 =?utf-8?B?cTFKVjJrY09LTEFnazNFNGF0NEFvUlB6d3pWdzA1dFpNQ2FPNW9YbmlOYnlw?=
 =?utf-8?B?UnN4U0M3bXQrbGtuajhCTFFXYVlFQmxqUDgvdzhQdmtsT3poTmN6MFN2ZXBk?=
 =?utf-8?B?YjNzaEY0VFppckFGamlyVFIvQ3QvTUFJeklPQlFpWjBxb2JMazY0czhSaXhn?=
 =?utf-8?B?UUlUMmxEdWdpQVorQXRuZnNxWVl0Y1dOcWlzU3FMRURoNUdCVnpoM2xtRDY1?=
 =?utf-8?B?Y3o1c05rTjFsY296RmE2SDZNQUNBd21MK1NGbExObDhKUUpJRFpVVzVnZzg1?=
 =?utf-8?B?bnE5UGdOdnVpNHphakpqQWJZZ1pXQVRPMFE0cXY5S01sakJFY3FBTm5QMk5B?=
 =?utf-8?B?TFBuQ3I5SEppOWJRYlBUUUJ3bXZPTnlKb3dxZkhBdVU4WGVXc2tuN0JycVpG?=
 =?utf-8?B?NnJROWZFOHIzNTAxUDljazFHRW5SZktvd0psN2R3Qi9TVVh4MTlWZGcvS3hV?=
 =?utf-8?B?VjRqbmxXRHk4TVh1QzAwS3QwY3BTelJsSUZ1Z2pBWEJSemJCVkordDIvOWNm?=
 =?utf-8?B?T2p6ckZXWUdydEg3MWdVM2V5bUVheFBDMkFLcWhFOUVSS3dObnE0SXphVUQz?=
 =?utf-8?B?Q3JKdmdZbVNLUWN4a1lSdkZLSmgxYitSUTR2emdsWVdjd25zeERLL3oxWmRG?=
 =?utf-8?B?cjhHYkg2b1hlbnNDcHhRZUtWQlZpOUt6NlI1d05pVFFDNXBFU3ZTbnpVY0VN?=
 =?utf-8?B?eE1HZGNBcVAvK01wWTFUMGJCdEU2QVhvdEhyVmJjWnUvMGpEeTJISG1RRHoz?=
 =?utf-8?B?UUE2b0xFUDEvZTJRbTc1Tkk2MVRwZEw3Y2ZibHhoM3pDL1p6NDczZXUwOTdk?=
 =?utf-8?B?UUd5ZXY3Qk9jSXIvL3BocmU2NXBTR0ZVcTVBT2dSSmg4QTdBUFFJazlFWU1s?=
 =?utf-8?B?WERLd2pBOU9FNEdIeUlDdmtyZk9vQ2pTa01nN0pmV1RncnlhU0hXMytkMGVV?=
 =?utf-8?B?KzZ3U1pBb2lKVWMvVkF3VTRTazh2Y0RVQUtHem1aNnFmeU5QVFNvZmgyVnE1?=
 =?utf-8?B?TXBpTmZZcUx0WVZYUmNYbm1SL1lKTjVpenFIOXM2QkFVSW5uNko4dW1ZdEk2?=
 =?utf-8?B?aG01WU9hOVpuS1E1Z3daUVpKZW5qUkVOSUZYeUtVUE83SVgvMVVpMy9VbmIw?=
 =?utf-8?B?bjZNQkJJMzBRTDd3Uzh2dXJ3RWtYVi82U0M1L0RFdTNLUDNLbU5rbWR4Uzhi?=
 =?utf-8?B?SlFpMlVqRzZOWUJKSy95Y1FlTHZxaGxsclhRY0Qwd1gxNkpUckJHRUpjVFVR?=
 =?utf-8?B?MVJjRVBXQnNlbVBkZHRSR2s5Mk03czVlQlBKWmFZSk5DaHMxR3phb1U3Uk9U?=
 =?utf-8?B?c3JVczcydmxSQVZEZEpXWGJhbVRxR0pLbGd0aVZNdk5EbkJuY0FuRTdtZ05C?=
 =?utf-8?B?L1huelJtcmRkUUVTUmZDMCtMQndhRmJBenVWRzhBZUJoZXMzeGRua2cxbVZI?=
 =?utf-8?B?VGh1Nk9vWXZBa2ZYL0pkN0I4cWpKZkpOL0FsWDRucDZJbWNXTTB3KzB1S1p1?=
 =?utf-8?B?QWExcXloclhSbUYxZlBCZm1PaEFBZTk1a3I5Z0FDYnBwdzRDaExOR09JbFZX?=
 =?utf-8?B?VFd5YXRLWWJRRFZpMjUwZmlKWGZFcjR3SnpUM2NiYzN2UnBRdTFvdTFFVGJJ?=
 =?utf-8?B?ZkZCR1o2TkpPbzFwdXJRTlhYdStxbXBkU0owUFcxV2ZNV0NrLzQ4WkdIbXc3?=
 =?utf-8?B?Wnk0ZU1FV3JSRVBKNFo2aGhXRjVsNjhWMHc1eG5xcVhndktrSk5hejFlbEZD?=
 =?utf-8?B?ZVhKWXlnVzhmdkxyUE1hdzkrOHhoZFVmU3d3WWVaUWluUlgxalBobURlc3Va?=
 =?utf-8?B?Z0t6bnIyOEx1QjRZSmIyMmhzcVJnTHMxeWZPSjZubnhDR1VSOUV2bitueDNZ?=
 =?utf-8?B?dmlHcGl4d3ZjVncwbnNHUFgrbTBpZzJZUHVIUlNRbms0OG91UnlkOEpPeWVP?=
 =?utf-8?B?NFFLK2lwekdmbFlHMmRBRHNEMG5RN2VJQ0ROb21IditDcHJxclBSZWFVQWJq?=
 =?utf-8?B?TVJCVDFiRzd0Szl0T1kvOEQ1dUlhZGg4OWpTK0o0Mk4wcTRrQ1pzWkxUNmlO?=
 =?utf-8?B?QkZIczR4UFZSa0lscEkwaUMvRHE4RVZXMVB5ZlB4LzlaTVJBamd6SVlwSnAr?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1980d680-2877-4661-55bc-08ddc56083e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:07.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CScgvOWcS+mEDddvEu7Np84QSUydHO6/J1SSyYHMhVnGpWGFN3pZYvSGhF+q9u1Tmp+0x/ZoPNxlIBPpu7gNoZ8WvBcRuRIDkdHv4BYlCWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
enumerates new link capabilities and status added for Gen 6 devices. One
of the link details enumerated in that register block is the "Segment
Captured" status in the Device Status 3 register. That status is
relevant for enabling IDE (Integrity & Data Encryption) whereby
Selective IDE streams can be limited to a given Requester ID range
within a given segment.

If a device has captured its Segment value then it knows that PCIe Flit
Mode is enabled via all links in the path that a configuration write
traversed. IDE establishment requires that "Segment Base" in
IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
programmed if the RID association mechanism is in effect.

When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
setup the segment base when using the RID association facility, but no
known deployments today depend on this.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/probe.c           | 12 ++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e19e7a926423..9ed25035a06d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2271,6 +2271,17 @@ int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 	return 0;
 }
 
+static void pci_dev3_init(struct pci_dev *pdev)
+{
+	u16 cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
+	u32 val = 0;
+
+	if (!cap)
+		return;
+	pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
+	pdev->fm_enabled = !!(val & PCI_DEV3_STA_SEGMENT);
+}
+
 /**
  * pcie_relaxed_ordering_enabled - Probe for PCIe relaxed ordering enable
  * @dev: PCI device to query
@@ -2625,6 +2636,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_rebar_init(dev);		/* Resizable BAR */
+	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
 
 	pcie_report_downtraining(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e5703fad0f6..a7353df51fea 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -444,6 +444,7 @@ struct pci_dev {
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
+	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1b991a88c19c..2d49a4786a9f 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -751,6 +751,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
@@ -1227,6 +1228,12 @@
 /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */
+#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
+#define PCI_DEV3_STA		0xc	/* Device 3 Status Register */
+#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
+
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
-- 
2.50.1


