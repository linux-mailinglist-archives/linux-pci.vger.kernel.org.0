Return-Path: <linux-pci+bounces-41701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20218C71739
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 00:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BDA7E297AB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AFB30CD88;
	Wed, 19 Nov 2025 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0zhK4gf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6E307AEE;
	Wed, 19 Nov 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763595416; cv=fail; b=ZtkJ1eJ1zTsBDti+r7pHWD28kepaz+B1Lpw/eeH4JA1Ae7IR8zYH+Ucz2YWRugRdr7+ZMZ3wjpxQtd2q9T5o/vn1XLBzPl4bS6u4hoSKG3E5Fza5FWaKbMdDkWuo9wn/9uwxGDlzcZF3G+dMAnY6iKtTlBBbJZ4yAxQ0hD/ds4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763595416; c=relaxed/simple;
	bh=0zdApxgAdyQKqyszczQVNMz07ZTW3nv8zYhtRMovtZg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Ho0uXPRpgAlqvdLxYwXoiCrNL5zTUjYF9fidG8pR78+bdnZSR34zMpNOmNhHCuvBW55d8+e5sc+mldI4QeRXthbCg2wY3gv9HhUYmsCHpQvSrPDVc8aCGsatWTKRwOcMPn1fFxA5aEgSXavsOiuZhUSOQydRNI1bAe8CjWyPHDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0zhK4gf; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763595415; x=1795131415;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=0zdApxgAdyQKqyszczQVNMz07ZTW3nv8zYhtRMovtZg=;
  b=h0zhK4gfysB15hYzXOUwbskWNPEb+zBJfpS5xu3hnVaa6XLE85iihLn2
   xqQ5K11f4qmQb4olU0ELFnJnrBAZbLxFFiodG1x0TXoPZVEUE9IGxF2s8
   MzEJiRZOIgXpQX0sXZRm0FllQvEb9iq80mF4GJjxnpGIAno0ZC3q+nMqI
   +BChqp6F/WNNGI2qbXkYY0Zl0M1bhscSD00rUF+2eRN+MuTHyBVzTbr3S
   cD7nWgoP4QHycOiBT1xTijeJK0Mvon6pmxjZsM3vayiHXC/LssQXwmCD2
   OmVTOWEXVWZq+BgftDh7+ZFsqQWrA/O/46+wQw4C3DS0N3vm/GmfEA1a5
   g==;
X-CSE-ConnectionGUID: BenZFCajQMCxithK9gRGPg==
X-CSE-MsgGUID: 2A7MAcfJQ5uV588yR0Fznw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65691533"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65691533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:36:54 -0800
X-CSE-ConnectionGUID: W/xbIbhqRcmnRdsJ/WNPQw==
X-CSE-MsgGUID: p+FW4jbBRXqHgsJmBEsnMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="221846157"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 15:36:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 15:36:53 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 15:36:53 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 15:36:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJ0k8RqKFulmh/PLLIAHKjDScI2DOR2HF8EZgtA3NRklo2OM0A6z2ovNh+fjDKDqYI4X2hSKH4g/3CI+5wg3PLZo1Js80rakTCgB/RC6AGHo1X2kN0Blik02MhySwCUCe2KkNJp3IDkbsPeYrD4km7SnuGMUTnsEw1pUujxRHpLNVP0d6bMMALC4jZuYLEK5dmBErEVzDxlqVfRBed961FBvMNaOy53zurJoM7czoNSJAJN/kINeZdLy4HmaNnVESz2huj0qk9p6G7NzYnYgt8E20+/un9cf/cd6PCSx+fFAcJiKvBcsX9BLHqrB5msfWrf/D2mmwUMaJVbxifi/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8aBLczi2Yih6/dOpmuGLSyPai4IsCYG8O542WU3YUg=;
 b=e173Dd8UO80ugVDULUCVVlMe7OxuuzFakn0vvVaJ4LJ914UsBsoWioei+24g7WZjOfV7jv5TUZ3tk/a6rr8eHPbNnTaMLLg4vlJKnxPVJwD0IpY7TKqzInmQOlR0OGGO1kSFV86Hcd+gSt7JUsWWTnOCzmEIfkiT40ug1VSZ90ra1OOuGEH4hWL9VzLYNQM/s0SlXlObtl2UbYzOGV55xB+M74yv0ZWSUhXUonNFU0QhRohPJ6zUup0d3j/q1bWmnekPlhsbHdiJhK0YIEiHNAuPeEMfynU9fgkW6CViH8Wx0SK0HHvP2gEJZcatmThOwe9rE1Y7dKhJI+AtmR69/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 23:36:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 23:36:51 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 19 Nov 2025 15:36:49 -0800
To: Lukas Wunner <lukas@wunner.de>, <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <691e549161ef7_1aaf41008c@dwillia2-mobl4.notmuch>
In-Reply-To: <aR1_M_i3yIygd8v-@wunner.de>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-9-terry.bowman@amd.com>
 <691d377611d7b_1a37510056@dwillia2-mobl4.notmuch>
 <aR1_M_i3yIygd8v-@wunner.de>
Subject: Re: [RESEND v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0d69dc-d010-4717-3acd-08de27c483b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXo2VFpGQ0V5MW9LNGQzcEo5QThaMldpNkhaVkEwbHRqUTBveGhnTTB6T3cy?=
 =?utf-8?B?S1FyVCtYcXlzSEFmY3BpeTF3UktlaGFBQXRwODlJdFBzVlkrK1FKR0h2NEJi?=
 =?utf-8?B?bXR0ZjNCcXlGZmlwT2YzM0RiQzFFSTJQRjZjSjQxaVc1UUFnV2dUM21KY3NP?=
 =?utf-8?B?eGZhSmRyNFVZb1ZUR2E0ZlljRXl2R2kvdWJUSVJTcGw2bUtkSG80NEhxMkdZ?=
 =?utf-8?B?WHRTK2R5UUJDSTBUaW42RHRpZUNDZXQyOGJLb0kxanNicm5SS2E1dHUySjdV?=
 =?utf-8?B?RHdNS0locDlNSFBYQ3FpZU5oSWFkdU9SQ0JKVGR5TnY3YUFMdzVMVWZzWk9j?=
 =?utf-8?B?WjV3aTBSVVBJWjVQNzREZ29HczQxQ0lyeUpjSFdaWDNxVzBJd2JjYW5paCtI?=
 =?utf-8?B?L2lyS2xWSUMyNlNaRUQySEJ4TlVIK2p3b2RQbUY3d3hOSDJER0drY3hsNVdv?=
 =?utf-8?B?WC9BdllZb3g3SCtqRWJ3dmJFejBzSU1Pd1gvdS9qUnk0Y3d1YThIRmRNT1RW?=
 =?utf-8?B?Y08vSzl5bmtXM0ZXOVBPbVhDeE16MlVjNHNndEJOcFM0aVEvK2NMeHB2VWZW?=
 =?utf-8?B?blhzS2llTEo4QWlwcWNaRnhWcTN4MXhmNE9Lb1FEbU5pMjFLeU1Gd2kvZGtZ?=
 =?utf-8?B?Y1BTWTViZkFEVTFXc2RTWndPQ2NTSXF6NHFOR0pTMTlrbkdrL1Z0K2lKU2ZH?=
 =?utf-8?B?YzFQMUl4RWswMkNBUnp2SFFwZVVvVk9vYVZGVm9QVnZIL0w3WlNhbXJnN0Rj?=
 =?utf-8?B?b2JyV2ltemdrYnQwVVIyMUk0S0NzellYSDhmN2RiZjVhVEwrZ3N5Zm5nNmIy?=
 =?utf-8?B?TTNPWkx0cGE1cXNZME82blhZSXcxQmJUbWFuSXNGTFR5azhqcGVUU2xVTEp0?=
 =?utf-8?B?UHZMcmp3ZWFLRnFTUW9GZzY5Ly9nbE94N3JkSkwxdEhRcnh0ZjE1ZXpFN3R1?=
 =?utf-8?B?WUVSbGV5bjV2YmMvdU1EanJzS3lKaGdTcHQ3bm5qVGpwc01aNTlzbzhXODg1?=
 =?utf-8?B?R1E1dlhHWjhhQXF4bjJRdSt2eXNsYXhDZzRydlJBTDZUSTc0bUpKMWQ2bmIz?=
 =?utf-8?B?L0pnNlIxbkpDMDEzTWh5T3ZPNlRxa0ZyUi9EVGlLeEhCYW12SitGSGt5Ylo1?=
 =?utf-8?B?M2MrdlFIbW1aVmpEVThmYjVUKy9CV1d2N1FUSFJtWmpCekxGUDdnbWRGNGtl?=
 =?utf-8?B?R3Q3b3ZVLzVDTFNmL1pSNkRaWDRvTVdFZHlKZW1jcHBKMFZPRk5DbE5veVVO?=
 =?utf-8?B?N3FMTVVUdEVTVkxUZUs5MmVmODJTQzZNYUpvWlNiQjlyYnVQcDlFNThWSmxa?=
 =?utf-8?B?cWoydmp6bDFmQ1BLaXpsK1JqTEp3NDhvek1HUEZkWVJsY2lVL0tYQVJKRFVF?=
 =?utf-8?B?VnFHUEpianF2VHkrQ1haOHlvMFFxUlFwaXplSGk4cW93bjdLSlpiV2svVHRT?=
 =?utf-8?B?ek1yRTZFVzQrOTRiZE5UdXdNVklEekpERHB2WVk3UUlWUHRhU2cxTW1JV2t4?=
 =?utf-8?B?bTlhVGZaUjBaSy9NellyUlVuc1VEcDMzRE5NR0l2aThuZXk3cnFDcWNrN0VG?=
 =?utf-8?B?QmhPZW9XUUNxSHRRa0RTZnNvMGZ4dHB6MTdCakttbnp4T3IvU2lXVC9BbkpG?=
 =?utf-8?B?eWdSYlMvcnk5VitNWUVwQU1SeVlnNkFxcmJLS3lRTk5vcjF2bFkvTTFUTkla?=
 =?utf-8?B?TWtkUkEySHpxOG1mQUhEL2RhQVdIY0UzY2xMZU9MS0tVc05vT09xWmhIQ2Z1?=
 =?utf-8?B?U1d3SmJ2ZGowVEtzSTZqSDExdW4rZ3IvTThVeHRTT2Z5WElEcUphM3VOeU82?=
 =?utf-8?B?dDhsYS9zOVhrek5FaUc0S1J5YjhrQ2dUby9aL0dEaWtsdHZqK1lkY0EwVElr?=
 =?utf-8?B?b3VieXovdGZqSjNCaDVVTjYrZzFIN1c5UVpMWGpxZGZGcm8rbjA3ZWY3VVdK?=
 =?utf-8?B?S29lZWFUdVJMWUl0T0RvakZqUGc5QnJaT3BLdXFqRzFGa3dCN1dXWWJ4VEds?=
 =?utf-8?B?dTJ1VjcvVkd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlptQkVqQXNEVzFveWlEMjZQZkwyNEk0RlQzaW53V1RIamUvQ3k4T0ZlRzZJ?=
 =?utf-8?B?STVjSWZoODRyUDZUVVVwdEZBU1k5OXBLNEtNM2xVL05nSzJZUzJxSE5mbGtE?=
 =?utf-8?B?N2NjTmdGazhCc0ZVMnZ3WjNMOCt6WGE1SkFrUks3UEVoS3AxVVlnL045ZXNn?=
 =?utf-8?B?cWptOXdMZHNKZlNuQXdQdlhvZzRJYmtuOUZDaU9lQ0o2SFh3WU92T21XVHB2?=
 =?utf-8?B?VlY3UHFleGZSSGVJWmkwdnlCc1drMStMSDZnRVBzZjZlUlU4cm9URHVQZlA3?=
 =?utf-8?B?V0xjWmVoOHNGRXVValRxaGQ4TW51cE1hVzNKME5vcXUwUDdSR3dwMVJTbnFy?=
 =?utf-8?B?TWJONHpBdGdqMTM5UDRndVR0YlNJRkU4RXlPWW0zNW5leGFYZy9KR29rdFpp?=
 =?utf-8?B?eTY4Wm91ckF0N2JhSGxGNjM5Sno0a2FqZWtTRDUrcnJPWEtzV1lKdHFNOUl2?=
 =?utf-8?B?RytYdi9qbk1NYlNNRTNIYW5TQkJoWkVwT3FYVVRWeXhIcHhzTUQ1ZmVSNjhB?=
 =?utf-8?B?NlR5Rlg1WnRkZHBGT2RqM1JXbzEzOW1wUXFyaXU5OGVEejVqZzJ0NDhnSXZR?=
 =?utf-8?B?NElrRW84RThnTDFOWjBaTGtkVDh4dkpVRGZXRW5WSFN6TjhvUWRqWmJScG1U?=
 =?utf-8?B?aEVqSUxHRFBLTmVITFZtOWhCek1tb04rdVZLbHJwZnpad0hteEVVVGtvNUVt?=
 =?utf-8?B?UVJ6dDdWUmtJN3d6TUNKOGs1Z3hYQXZPeWxCNFZrc0lIVXVoZjhjV3lnUzlT?=
 =?utf-8?B?WVo1blRmdnhXeldzY2pzQ0p4QkVKTHoyeGZVd2QvZ0l3Zm04bzhGV2ZoeTRX?=
 =?utf-8?B?RDQ0emxta0VsdDZha2luRXFNNHJZaHArbDBhbmFFMnpTdG1ZckhRS0l4TWNS?=
 =?utf-8?B?T0drZ0ZjTWNNUkdpZ081S3BYVWtHVW1OYXJRNWdXV2pVT25JTElFaWVwZVpB?=
 =?utf-8?B?aW5EbDdDbm84UUxiVG1UNVByTlRVVUJ0dHBQTDJpdi9ZQWVlczl6bWpGeFBR?=
 =?utf-8?B?Q3F5cFV5dXo3ZzZCRHYzSUZUbmlYbGR4M0xMVm9BNG9GNFZPZG1TOUhEb3Bk?=
 =?utf-8?B?L2RCQVZHSUp5L3VRbER0ZUVkdVBCUUx4SGdFOEFPRkdxek03dmhGTkdVaFNR?=
 =?utf-8?B?cXgxeUY5YUFlN1ZTOEgyWVBXQ2xzZ0ZwS21DOEYrK3kzeFBSNlQ0SUgraHQw?=
 =?utf-8?B?d2lnU01sSTM5VXJHL0tvVUtHblQzNHhhbUpWcnVRTC9Ha0tYeVl4YVhycklG?=
 =?utf-8?B?UEhDZWRFUnNkTFV0MW5pVUwzVnlsMS9kdzM3Vi9NcHdEbFNKVUhZVHhaL0ZB?=
 =?utf-8?B?MGo1OGpKeHFyUUE5T0RrVGh4eVM0ak9XZHljbFlrd1JaTmYySlB3SzEvaVlC?=
 =?utf-8?B?K1M0OE8za0hKejQwUjQ5TEc2RjlNdXg3cHNwSHFzWmZiSFptSkcrblhZQzYx?=
 =?utf-8?B?Z1VXdkZDOEVVZ3pvV1pVekQxdmVkckJ4NWc5QjNmdXpxZDNYc20vaHlXM2Zu?=
 =?utf-8?B?SWN0alJaS3RZVlVLbkRpS09qWllhWjhEUmNhS2lGeFEzbytjLzZjRWtNTndQ?=
 =?utf-8?B?QjNyNGxMdnh4LzVDVmovbzZZa2ppUTlBS3RYN015OTBYYVBlWTVKV1kxMkRN?=
 =?utf-8?B?SDJNM3FHOEFSVDcveFBlYW1Yalp3YStNbHkwc2FNaEZsL0dEc1FCcjNuM1hX?=
 =?utf-8?B?SjNYdSt1bTI0NTNnWUZ1YkcvZWs2UW5vQVYwNG1pT1FBM2pXenl5bnIrMFpJ?=
 =?utf-8?B?MFVrbmdPRm1XSTZHVVo0SHB3NExYd3BEYXNZYWVwcjArdnFBRk9vTjZ2Qy82?=
 =?utf-8?B?eVpNSjJYeWlNeXA0RENaNUFNMFBDVGl3SEdLd3N6QlNGSmNMRXBHWFhqQnEy?=
 =?utf-8?B?SG91dS9OVkZZZ1VFclZ0ZjhZYzVKcmZYUkJlbTJRYVNkRGdNMTJrVVY3eENV?=
 =?utf-8?B?azNWZklwTklZYzBaYnhSRExOOTJJSlpyNERyVDVCSEdSREFNRU5TU1kyZ3dM?=
 =?utf-8?B?M2FrZC96QnY4a0pNd2VIb2hqSy9Gb0NZNFhuZDUzT1d1MlNVejR1VXUvdzgw?=
 =?utf-8?B?d0lJQVUyVlo0dUc5QzBselJ1dS9zaVppNERlWEtNMXh6ekxMczBvYlVJdHBQ?=
 =?utf-8?B?SXFuaXlpSVVWeFVJbjMxdjE1OHF2MnpXdU9EQ1FnOXZkSHBhUDc1OXNVRXh5?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0d69dc-d010-4717-3acd-08de27c483b3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 23:36:51.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9fV6fpvvTWwwpjBt9gRoYCWXYUkFSgCcx1Y4eCJx8COc7BYc/SHDIqcg9O0DH2bHdjJT/TkDHRvYYGhTsA5FjCIMTZJ9rNIeGge7QOrO6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6502
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Tue, Nov 18, 2025 at 07:20:22PM -0800, dan.j.williams@intel.com wrote:
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
> > >   * Note: AER must be enabled and supported by the device which must be
> > >   * checked in advance, e.g. with pcie_aer_is_native().
> > >   */
> > > -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> > > +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> > >  {
> > >  	int aer = dev->aer_cap;
> > >  	u32 mask;
> > > @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> > >  	mask &= ~PCI_ERR_COR_INTERNAL;
> > >  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> > >  }
> > > +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
> > 
> > I can not imagine any other driver but the CXL core consuming this
> > symbol, so how about:
> > 
> > EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core")
> 
> The "xe" driver needs to unmask Uncorrectable Internal Errors
> (the default is "masked" per PCIe r7.0 sec 7.8.4.3) and could
> take advantage of this helper, so I've asked Terry to keep it
> available for anyone to use:
> 
> https://lore.kernel.org/all/aK66OcdL4Meb0wFt@wunner.de/

Ok. I would not say no to capture that future use case detail in the
changelog.

