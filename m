Return-Path: <linux-pci+bounces-28145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A53ABE61C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1A8A40B6
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396F3242D89;
	Tue, 20 May 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+bNYjCZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA11A238F
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776701; cv=fail; b=EzBJJ0xDoyV5dDb9y6/nlCSZGPp2LONoGUj7slU5jeG9SbAWoZia0UZ5t0j9PtuYR0DZD3BsQrg8IHnOS5d1Sw9FaLF70BW1XvKxvqiXlPtKWBSU6LCPSfWKSNptpoxHEbzUU/4BjRPWZyEhag3EK8ld2szwev/QnYBKyufBtjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776701; c=relaxed/simple;
	bh=Q6k3Kl9la9LvwHPxJ4uqA4FhXWOutNgFkljpFLOpsAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=neS/kIDY4TQa4G4Oox1qlD0YaZ6KWGHGPnBWAeDcgeUwsA63+ktbTNMpUe8HzbW/jHajjNPdo1Z+HbmbqdfNNn1GVD7Dxyvk+Fj3ZYkNKyTzcpJ+PKZGo4uvDT1WgcZrAGN8tcHeqwMf9OGn8ehnCbN0TmzHCZwtjdBdX+jvdfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+bNYjCZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747776700; x=1779312700;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q6k3Kl9la9LvwHPxJ4uqA4FhXWOutNgFkljpFLOpsAA=;
  b=S+bNYjCZ0I5t+72oiBbQ9Jou1/t0okdi62oSUV23uo20BKkGUGGL0Muo
   GOSJbys9W7d/ZFpazYAsZVH0ShEwVN8xWOICf0xSTabeVOTo13UNjZrBl
   YDeUJa4ohX/gc9Jtq6w+XvzqEJ80JTSxtnTuV8jiJvIe72jVvNjA8DiVg
   Ah5x5zLMylAvYTYpJIJaXuYw+b10rwE4mw8Pn15BP6HHbGU/a8nLmwTvR
   tgIV2QDxqh0TN+zwLh0aVasXXw3k5IdZrdEP7WbM7lPFs8vz4pG2NameS
   x3fpDfrF2uBQLrS3b6jo7kmuGJ9LWvDhOC+s+G7eiEx1OKI1dUJE2OEkQ
   g==;
X-CSE-ConnectionGUID: wZGq4JyUQ+S/D3gvvVDeSQ==
X-CSE-MsgGUID: H9FgeBSaQRC3KZT6AmBJuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49434794"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49434794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:31:34 -0700
X-CSE-ConnectionGUID: b2aPqMqYTia+MUSIx/WFhA==
X-CSE-MsgGUID: iG0zjQ98R4CDdlOnLwG7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="170692888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:31:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 14:31:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 14:31:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 14:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyd3/2M8N8d668orbj6cb1f5K+HaXU3MvzFluX7kUeNf6HLr7gMo4Q+sSRSEUBlPp5Ti5huCqOrUVtAQAvwjk5OGhy3nkWbJte3sG01i3nA4x/hPFerUnMDfEcoLxzXMUqE9wQ86SjraK6WoKjvcXt85qXYJ4QCPDIu446LwIJQ7mHi4r8waXrQGJ6sSFhXxSS6U8ez1j86PF3i3xZjj/HDILOeDMDac1SQqNT5O0zSYE7hHGLL6jmxMcCQTaKv3jNUl5VaxlTsoBOhKhAIG+aAUn3xqOWdK8LnaSyJ/Mtg0MEi9U/+hev/2sCk3ZjSB17x2NqjErjjY0FWFDtrwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjULZAgwVXMhyJgkntWhGaZr2gwxNQ7I0wJmkO8MJac=;
 b=ZaQedej0Z3SyobVZ0atAG1onXah1rCd2aFyRfOcopJ31wvlXB/fcTcvcURbouh6NuMWAUyf/MGhEUzJAtDM6nzROQ21VHr0EpGJSBCLiS6D/6JRO/U89TOne1WoKkFP8lDLKx3UcxbQKChDLi0FT46uT23BKi3k5KAOLb0OL+zoTTpdrkS4Gr+fKV3oS3pH4D1T+DB1CgIi/NraWv97qudnRDT88YtbZnbWPar6Ea5oOizF6zwHyzFj+3UhjvhKDW/TwR3a2Sa+6MSuo8gYYTfvbn8hh/uf9toUFO/RNy7JGqz+eyRJDY8Y7hXjh3dAbLsNrNNYaqSQ1RITldRbUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4795.namprd11.prod.outlook.com (2603:10b6:806:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 21:31:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 21:31:24 +0000
Date: Tue, 20 May 2025 14:31:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>, <suzuki.poulose@arm.com>,
	<sameo@rivosinc.com>, <aik@amd.com>, <jgg@nvidia.com>, <zhiw@nvidia.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
Message-ID: <682cf4aa3d682_1626e100b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <yq5ar00j4kem.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5ar00j4kem.fsf@kernel.org>
X-ClientProxiedBy: BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a564f3-0f67-4d0b-ddb2-08dd97e5abe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kF1xoTwMkdUXLgHBXN7lWOpeM6IBoD4if/hD7x+AlePnG95m3woNl61Io6im?=
 =?us-ascii?Q?KgXfhH1/mMS2VMcYqASkozLQJD7y7Nw1L5Lz9Fr+jVMoZzFO12WZIHAt6BEQ?=
 =?us-ascii?Q?dmXLqhnfZ/DMR7/05+szU/jZWKUH/S4qNtS2KBBFNhfx1Fr6xC/7PRES+W8s?=
 =?us-ascii?Q?nw5M50WXXfOkmDwyWlod1eFWKfUSI9BhMQMyefFrR4PMJEGxgrK2RjSnKgZ+?=
 =?us-ascii?Q?lxcnOWwQA9otMBuaHyMfEO5UdAUXv4I9jhZyhdmXm7oWSHmDoeywShSy/Thm?=
 =?us-ascii?Q?F6sdkn/tf8r5oI9/erGsjNrh/iwnLNreyZ2aquzVnDOo8dT0PQ7flTIu+9Sp?=
 =?us-ascii?Q?FZK5oC4gw5/xCmDyDr+gbExE5tvqIGJCJuSVgKQJkknqaCZVhlt0IE5pDuF+?=
 =?us-ascii?Q?6n/A+yrozD06BOxARYDrwK5+4MPBsBoUi9SVrG9+UadjW9M1g/jfxPmw8lhT?=
 =?us-ascii?Q?ciz6GUue7wZTB+9jXa6R/DWskSMPbh523GGUxYIPWBDYkcJnDb4ZsRWtAIVJ?=
 =?us-ascii?Q?F3+jd45I6ILVMg6QdE9zWmRg5Vj/gMkmcSXrhLRTP5ppVCVL0y/c2/8LuaNV?=
 =?us-ascii?Q?rnWgrV28M7yW63f1VMspqeq6+kOzHa90ueiupvwYaC3yemtr4QXSSjzBCPI4?=
 =?us-ascii?Q?DE5BPHAX0wd9hfVV9KwmpA42D8UO80yO1Dgcohls3dukyf6vRviXXW69VnE9?=
 =?us-ascii?Q?LeF6j9K8v7owfg8pUBeeX0KGRRHWb9qGDH1pf7eaPjy/zPvxIbrl2+T99g1g?=
 =?us-ascii?Q?iit3S5WALK2gmIOC3IAK5jzk5li8JOZ2YXIPgWmsggOggbbMS3RtrXHG0G59?=
 =?us-ascii?Q?9QCDSBN8fLm05LhMN5KuKLyYiOndC7b3dph7oYLDpE7J+lYTjJS7QiMBRCzF?=
 =?us-ascii?Q?D/nlRwKDUvPHoYlsE41sjTn3zhrJB6uC72hBxpRAdiLWiItce3EwayKhTIgT?=
 =?us-ascii?Q?cmDjjsrrJ+DbQYKqLs1nd1ZDLFCOy8CgtrLZqCE4dThmQ96OOnGpMTDRZS//?=
 =?us-ascii?Q?WHQKwbInSexl5yVIfyZz84JGXPmTPXJE/7lURgHaz9/PbW/zwJVlduYwGjYz?=
 =?us-ascii?Q?jPXkdVSv2B0EDGcqrnAvmurFM5s5OPVQt1U3k7o3U75GJZNqxjejakMgogx3?=
 =?us-ascii?Q?h85LDmpsou4p27xVb69H6UelZWsSWBpD4X8ixXEpef9irfk7IA4Jynm+NLzc?=
 =?us-ascii?Q?XNxQyB/gcIKbBiEBjNssE+wllochmoDVSGIUCCZ6zka5a6e80MrKADF9Zu+T?=
 =?us-ascii?Q?NdzNN18lO7cNEjt/MNYSQRb2e/RD57Frxa9zGsrelBV8YKpnyTvwVE5qtaTW?=
 =?us-ascii?Q?WZQFhswfNUJjJW8VaUA0x+xGgCVYLrfK+ovujukiSxsVOCls7zi44S6wrzeO?=
 =?us-ascii?Q?vMWxr+3w74Cgovl2VpqIRsKo0fI3yLqsSZvlLljxj2SaItbvCOwzMFr6mUD4?=
 =?us-ascii?Q?+E6cItAjQEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERRL/Kh7xtfTtBiAM0nMj8UvDvQKM3czZok5SZ1fkaZdsWKuSI7qUCvycYK3?=
 =?us-ascii?Q?ORgWNMA/zISmCSkIaGUVBcdNN9GqsOdzJGbr4zrZOxSwLeyNMQQoLhrMGh8o?=
 =?us-ascii?Q?QaP0FYTac0iQMku6q6idpSEwO4A21fT7ipoEd2wCTwmFRYRbtrqE8TxHPNHc?=
 =?us-ascii?Q?/BOctjHXGi1cEvLN4wgGqZcR38a+CGB/VVvGB84JxKyvyqJfY4whffiz4Laq?=
 =?us-ascii?Q?fTi7YB8avlqPc1Bd2euTB6raA1ckuLNHzHKnWwiMN/Z1T4etFSm7kheTPSLq?=
 =?us-ascii?Q?/tvp1VztoHciig8VVeerUc5Lnno60AkECQtC8+VBBTB8OWcwAoL1JXUcTpLd?=
 =?us-ascii?Q?Kisk5ijn4TCUMY8j7duLWM9kDR2MfoFT3BG+q/SnPVMSFcPJgqGl5FKip9lj?=
 =?us-ascii?Q?ManZDdrT6ykISpXi4DXT3MrziI87ApvorcZjU6LQO0iYo/cAFB9nJHYZAHxT?=
 =?us-ascii?Q?Q1c/VrtNrH5B3KQsDTo1C7m27c3M0tICVVrR7NitjCUfmHJlfUnmy/OFtFk0?=
 =?us-ascii?Q?Y9dRXdv5Iw285PYhqAIGUYbPWAUIj/ja2nBuzatkrdPxXARZCbrcEVp7ntrq?=
 =?us-ascii?Q?2MI66UxiI6Kg/mt1/gyAcIRx7p0v4Vw+NByG14s1zcSJnXVJlRGyEwb9K6+n?=
 =?us-ascii?Q?DSGsQC6FeUHV/q9VCGWk172ijTLRqPH8LgNJyKwmk8UBv5a2MbZNdne8aJv6?=
 =?us-ascii?Q?9qrGTQ5YHgEn/lshcSZDDTjnol7PTYG9tW9rZpOb9RKZA2xAxjVtz4VM8mG1?=
 =?us-ascii?Q?uG6NVbmEYmLw+m9OlKSgoC4x/UPlLSf6x8I9zLgqOSdetS58PWQksJ4xLhfk?=
 =?us-ascii?Q?kWpeK1Bzh1LfldKh3ln7KzFiH8ztvlKM8OC3+YWDEro42cD4u89nkAn3uW1u?=
 =?us-ascii?Q?dEkmj32vyt26Ab0hGnSs+caHOA623n1d+2kl5ikOcajXKFtPYBdKnKESeiAR?=
 =?us-ascii?Q?dDHCrD2tQnnzZcC9G3KLoI4DQavg2Oi0Tf/MeuPyU4aiyyidFKW6s4GuRGas?=
 =?us-ascii?Q?Gv6LhFjyOJnHzC3nl2m0Ud8DogfILHibvXwVlr3S6os8frVC8CX646ggskke?=
 =?us-ascii?Q?XF7kI35K0rwvcIMslMhXnmo4i4CYFXqylJlRiCBMxrhbTKsZhQoliRJXdcVe?=
 =?us-ascii?Q?tffCbU6ztI+5ElFipstlVexHJVg3lgBDDdClJuzcngx8I8bN2dgquTL5BjC8?=
 =?us-ascii?Q?Z4yz3VcSIEVBOQB60GBsOWlo7AlShi4ijsr6WSfvGPte0QE2WX2AACQehnoK?=
 =?us-ascii?Q?JhzN03eKLY6VIHcEJmJrc0zUWkZR4V1ZBd/xwS3sjNA1M2cxyNEZ37OmdKSB?=
 =?us-ascii?Q?PpPCx8PyidbC0cr5b5fOUtNm2wmWJXE1OunhpUN/VBer1Im4JQsIeo9QBI0x?=
 =?us-ascii?Q?wIkR/d4HesW2fqHgO57O0qMagQAehmytBgmbAjoFBcP2z7a4n8NuGyk4hB+s?=
 =?us-ascii?Q?3TRhi3RZyW8TxLQ2606P9o5jIdaoL6AOSPTBtoJkCMCVRJzCV7BGS0cn14/K?=
 =?us-ascii?Q?Nf2Xw1zW6VEtaI8zm2WQDMR3F5FXin1pN+2rgFPzYjFUug2SjdR2UpscDntH?=
 =?us-ascii?Q?6ZqXom/nYWbV6z1IGXtGjAa4S1v73MoemUzvuSkBop8hBBlFdvLHJRYfrT/p?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a564f3-0f67-4d0b-ddb2-08dd97e5abe4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 21:31:24.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36VncFbXlIFqHYHNJfJMiNdwGwJ3oio5V4t4MPdLTQHdNs+dbUgAVIDb9fkka1vqDr9iNngBzmFBfKW72RXFuqaAX24N/3TqRAPW+gtsB+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4795
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> ...
> 
> > @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> >  	if (!pdev->tsm)
> >  		return -EINVAL;
> >  
> > -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > -	if (!pf0_dev)
> > +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> > +	if (!dsm_dev)
> >  		return -EINVAL;
> >  
> > -	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> > +	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(dsm_dev);
> >  	if (IS_ERR(ops_lock))
> >  		return PTR_ERR(ops_lock);
> >  
> > @@ -573,10 +690,13 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> >  			return -EBUSY;
> >  	}
> >  
> > -	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> > +	tdi = tsm_ops->bind(pdev, dsm_dev, kvm, tdi_id);
> >  	if (!tdi)
> >  		return -ENXIO;
> >  
> > +	tdi->pdev = pdev;
> > +	tdi->dsm_dev = dsm_dev;
> > +	tdi->kvm = kvm;
> >  	pdev->tsm->tdi = tdi;
> >
> 
> should that be no_free_ptr(dsm_dev)? Also unbind needs to drop that
> device reference? 

Hmmm, are there any scenarios where @tdi can outlive @dsm_dev?

The end of life of @dsm_dev includes pci_tsm_destroy() which should
invalidate all outstanding @tdi contexts.

