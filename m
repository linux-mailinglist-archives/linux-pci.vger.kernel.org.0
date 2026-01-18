Return-Path: <linux-pci+bounces-45147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B4D39A81
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 23:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 723A430056D4
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082630DD1F;
	Sun, 18 Jan 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBmXo+Xn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572A30C345;
	Sun, 18 Jan 2026 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775358; cv=fail; b=o9xokcnFcpRMFEvdXmL3d+jTbie41kRfkI40hjA3Ff/CprJPS63PbtMizO70r11fE/vk3CDBmR4X3mXz14PAMvU/HEc4+cbvzy0ERkVNoQ0TdYASEoULiUw2YtM8f9gX+d+OTdQ9uze2LGUJNLcbjUda65xlp/lMfWm2coSU/dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775358; c=relaxed/simple;
	bh=1H2HOrtQo4UU6+GWlIp2xbZPvPvCHPfytcliotxmDaU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ihYiDL26OorlKMJbRE6BbcEx+Fzj5wnPc3gR7WfdZdjEJbYlmkRJ/pOoaxNrNKU0mEiBg+AiZSSUEOxDsfEqdggLw9VUr51cjj14lm94+DKMmum/zH3G1YpoccJ5lrQnIF0kqwYUmMNQ0rT0DCAcMdyzvvGiGiitnAKkTo2HifQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBmXo+Xn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768775356; x=1800311356;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1H2HOrtQo4UU6+GWlIp2xbZPvPvCHPfytcliotxmDaU=;
  b=oBmXo+Xn2Lja3CrrofHUzNy8aSE82Qdz/hLShJR1nxTZk2WDtD/drQjX
   CKkci6nsI2HL2EkBFtjr7xJ0hfISD2CrIIbsfSjlDkU0lNdgEowxwfu31
   lcSi6TkK6pM3/Rj47Td7C+WvOPADlQHSim86dcCZVcFvB5p0SiQZUdcK5
   sIv4ISE912W52J5fg32faiAZsK2dTicxbYmqCAlAoJz/AMvv7Gbd3A8Om
   z4Yfk0PDFgFq6cKtYLqQNyhHsZj93O+VAsiE1tHI4BfVCRCE109NpnS9x
   mz1sWg9Ubok/w5HGF4kEA7Tvdpy8K9+ssuYJ+BwaOVmmHQdRt7bXN+RyK
   Q==;
X-CSE-ConnectionGUID: KJe+lIY7RD6XSbeWNng8bg==
X-CSE-MsgGUID: 8GUXUX3nRxeTAW5ZTPRjZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87407437"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="87407437"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 14:29:16 -0800
X-CSE-ConnectionGUID: WQgpRToSQ4Wci/R3gPIxGg==
X-CSE-MsgGUID: HHmFJzryRQG2DnwOoSv8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="210570579"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 14:29:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 14:29:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 18 Jan 2026 14:29:13 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 14:29:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THpNmLwYjNlVfDRY/UjzXE0EkJXgKph0cGnQQxwT1CQbFvv1m+dxdN8vlrEcA3NfvgcoMCfzRAI1CSsJVwkA1fuQ81LDr/0smCb9guSOJboEZlKWqkLv0c/gq6ZoIn9cL9cPAUJ9rRCCtR787inftNVvgo0rY6YYmk/A1fcreLImlMeNQ1SvBPRIPUHXi9DvN5BZ43ZVGXbdSHXmwchm51CiQcYRZffux4GlY68yj49QIo576jkDPlBq8Xnn4w9SDWGM8QZQX5/6eyjQA/OaIBNyyoIHGT3egQuChBFLETD+XCtd0d79wC0UfVs1kkoUmVKVyyoqOWINeDULg7OcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+t04eEGAHyuZ9lPztZOWSN78h9sTUUmaEfhc6tQDno=;
 b=Mu1B7YO6g9uMD9HFouFTLoQMwCbCDbt62LA2rPEjOS65ZgsvcHVjS5jzdrUYNWnFg528i7Snxa666fQhZiyQDklPabI6y5rBDYE2LiXFm+QMsCQsA1l+cKO4WIvHpyrcIvqlKGr1Q+4yJN+SqR3mQv9SwGiIgfLkk3VX11ZVciUUe8HvII8XwHP6I5+dpE39IFSqWubWIqsaJOZNE8e295JogJXHK6BiIbmSmsNNIkOP/JbXo4x8aLHRm9VoISD9WJAUdCZELxJrDgScQa8p092IMVhWFtkxwoQ8C3VowhVaS4REuDnXC022PIY9pWzF6Fbmmq2OogqGPLwTbCfg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 22:29:07 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9520.010; Sun, 18 Jan 2026
 22:29:06 +0000
Date: Sun, 18 Jan 2026 14:29:01 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: Re: [PATCH v3 0/10] CXL reset support for Type 2 devices
Message-ID: <aW1ercZMyqh2Ej5F@aschofie-mobl2.lan>
References: <20260116014146.2149236-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260116014146.2149236-1-smadhavan@nvidia.com>
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: eaca5b39-7422-4e3f-ce02-08de56e0fdda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VPvCJHquCLDhf0cxv4PziDPwibWTO1G89INRaUUOL0r4yS/uXbJgfeZZJcOq?=
 =?us-ascii?Q?e5NAoDk3xXBtnOpqQnryPMG9/xaYYPFuG7vdzxY21imipQtuXOz5+Yo8VdbI?=
 =?us-ascii?Q?sD/K6DJFrOFv0KyVBwsTrz8mpvv6n8RRajRpkTIZSwdaJQGh9JiNrn8EsUAI?=
 =?us-ascii?Q?v1yyxdOo1krAUCkT/NX1U7tNg4VcYxzPAx9nlwe5jONiUmM7xKUkViz9Tb2L?=
 =?us-ascii?Q?rI5wVmEdZddKXBIiNxCWFlAKlGN7NZGyOn4d2J3TYY+anMG/69JuNjhlpRXw?=
 =?us-ascii?Q?IRCuudPAfKush5XA2HbHra8DDltVXjTLV1gMW4wqUwovt87pM2Q1DVSqQsOk?=
 =?us-ascii?Q?4DKp1RIAWKoAmx4iPCoJQ1bM2KiQbI2cCP0QQ1UJdVHyTZyqZq2hBdzqDI5I?=
 =?us-ascii?Q?nsdhYP9mD8lR/5GapUnNUD6qypEgYSxZT6NwFw+LQrb5SUcJcBgxZcWYeH3m?=
 =?us-ascii?Q?x7goFvlkycxG0mm91BR0Md0pdtFAw4AtInaN46dR3elakfVhjWPdBWp2MYzv?=
 =?us-ascii?Q?iVNHCeeKq5m6yYYxaHujCX7CUBL95E5dZS98MJmd54WhdHLyNu2nFl9QYFUZ?=
 =?us-ascii?Q?oEDYz5N74X62U0au7aDYfKZeKSXbKGHNBpQy2j8EWsulUEn0AEUgaRfSH86M?=
 =?us-ascii?Q?5WFsMfyeoRzfCCviaTiKygW4cKL1JPX8c6l3b6LkZTiGmdMqIVXHrmjj+dib?=
 =?us-ascii?Q?xwo64ken9k8hWrYPY1CQnYnYLhsnhhKLcGNPn8fdBb6Sl16XJDSkEZGmVi/B?=
 =?us-ascii?Q?5xtEO4+d8cOE07VMWi6G6qzAh9+nWkhreEVaI65HQoz/FjQkKsANBAdIKP//?=
 =?us-ascii?Q?tKxbRZUpcsfXY38H0PKUSiC8U79X9HhxLba0Cn6LvZvWrIyZxnRCcnp02y6X?=
 =?us-ascii?Q?ELu9rHrXdtMXOBwKSxOasabAKZJI+27GFUvnEkbtMt47Yz26gJF8bL5qNgwM?=
 =?us-ascii?Q?hQUwGJtUbifxvT0HTnWeH/FkC7YkCisE4E86OzqkCDVSDB9O0EzlWNMKHsYJ?=
 =?us-ascii?Q?7UxY+iO3ZZ/shDdANvG7R5/wTyoNiyYztiz4PM1AkDRBYadrBXzWUcrGVrex?=
 =?us-ascii?Q?8ct7J4doB1UIGWr5CH+np598pASZtEeNMcSpBDzmG6wIOcIEwsAkwPjIcGnH?=
 =?us-ascii?Q?IG60lGlcGsis1fdjcc4L8WngBHZMb6tpSdUZSflsLJ+aBtS5hkFXCAROYO0H?=
 =?us-ascii?Q?vmR2Qf/x9ikSTFJYzUIHQma2T5qo61xINOizeHzjFOip22mqbj9NDbOaEVUN?=
 =?us-ascii?Q?s26Pw8uIjqOYaRG8d6efz9KpYneo5xCp224CTwdfuyXVlSt6WmVwINJfGJEy?=
 =?us-ascii?Q?yOyPvEWzLA89IMa3TMGUi+LGfsArP5HMH0FYq4Iw7JaCPsqWNd0SqdePoMcd?=
 =?us-ascii?Q?OsxS7Rk9m67Mfb4c0U8CzPpczZ7oQFdhSDeoEhqdfiBYzfOOXyv8XxEMPcmI?=
 =?us-ascii?Q?A7+bWC7asZEecAYdiLKudde+ecEpw6fP4vHhRwCS3wqOO2SGIRdOTmIV9q2D?=
 =?us-ascii?Q?rqbaHMY5RrSou8/7MbMOX0iiZDyNAcqOtmg5s64MR1QL5O1f/zWdqel2fboy?=
 =?us-ascii?Q?ZxrrxUXoRWFz39SNb3Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDvGaGTIwwuHGS4VeSj++0cc1kz0A8SgzHpAlUP9ZUL+xMrERYsJKueoWGuq?=
 =?us-ascii?Q?tILhc0xXgkUM2QF6vT+ox/V8n1UlajtNA1RiZDnvfkMWZG6plU1rBEJAD34O?=
 =?us-ascii?Q?9re2KWhwnxz8yeR+1RfBDeovbdkNJqFWTwfVnyozq5GjiRVcE45/ddPG8LK7?=
 =?us-ascii?Q?JEMY/NSRJEVZylB8JJxlJ99/t8yiLvMzECbQbHHzK4oWN/v9+G7Pd3iWh/f/?=
 =?us-ascii?Q?9q7yw0jIHXSLL3+tgRQ58lt5yWLUm/4DxaIII2TC66qP6VQPYsvZB3j0gw4O?=
 =?us-ascii?Q?02OuREF/miuPuj2G69+dyoiK5Pmy7k/UqJBB7PfHH114XVA/yWr1YUt+Gnnu?=
 =?us-ascii?Q?+aMo7y80pmo9qDkrMNPn6H/HvbaBRNNbT3+pDcokz+QV6hUQAz7G3pur/w39?=
 =?us-ascii?Q?ae0C7dlLxP7bJeFbdTIEpnWA0GWC/kqAYnyq+ZEA7q9EtFrhUF99WajxF9lO?=
 =?us-ascii?Q?aE/qf8FBghf4jn6YY58M668g023DsQP6d8LoibSGHuWuaks1LNA+CzS4SyB/?=
 =?us-ascii?Q?x0/kreMOC+YY9wSjRD/xUZPi3HJbeyfgABlJgQ8ipG/Ut8c8tnRliv25jHH9?=
 =?us-ascii?Q?MC+CajiULM6hDFfUTgeEPJJ8WMBuiYoPoKL/fQS6mhoz7q+I0d4pNNeShQQH?=
 =?us-ascii?Q?8p8LNnoJsu3xTWKFeWcn0g2NVwJBN+2LajNQlqamGnywycEJ2fhlgcEmRQkp?=
 =?us-ascii?Q?5PpRVR84eBS8MS7LZKELOAxdsyFSE8SNh5UuJp02KJO7cnpzHKcxCkvWswGQ?=
 =?us-ascii?Q?qTz3pw/vWqp6CWpRpAiomf5xpQOF4TZRKJHcjHEjTMHtYHDwbL9TLuDP8aD5?=
 =?us-ascii?Q?kE/1P5wNZpNFRLpHYiA93w64j9lXpajyjpJdX8T0aLQzfqgO//Z8AC+N4lkP?=
 =?us-ascii?Q?22suNBXxMtPr96b2gmsUOaT7T7KewNKbIzZ/nUXaS+nohFRMdM5BBeUbeQnT?=
 =?us-ascii?Q?sL9m/PHMuf9kt6wpSpQB/gqRJQrZmQ8Sx0XOabWvFWwK9wCxwYPTu8+Ff3nX?=
 =?us-ascii?Q?GKZ9AzXhNo4XBQAo8U0Dr3WTh/qJRejeH8aBb+JjWAVkYzg7jtfGzD/cLRLi?=
 =?us-ascii?Q?1YkaDDZgisRYyyaRwVtrVZrzp/RtCEcRCgUbZjPK6SXxhyKi+Qxwn6WA0Bmq?=
 =?us-ascii?Q?bPBcBoI4+12xA7TkpiMXRkDUfT8v4glghs3Dy4dqmRshajTBYt6I3qCBUwb0?=
 =?us-ascii?Q?R+RReyPp8BNpyfHVMNySYigl07cAbInu7ln0jg43+oq9jMXobsoUDaPxzxbm?=
 =?us-ascii?Q?lhkndsMyiWwLb7NGHzIrvmElvrF3RLITEf2ULoSGSAkqGfgmbdwKExpo7JIc?=
 =?us-ascii?Q?abbNVf7tPdJpIKRw/PcJDhZPgsNGTEaVmz+iLPpOZMqI3MojnH5pGDcNNEBn?=
 =?us-ascii?Q?QLn9k+Iv8AwzGMwP7Dij4sahY1fJtfOFG7CX4dyOLjq+8XtWkNTku00/EBR4?=
 =?us-ascii?Q?M3WiEv0ZGN+3e1Gb0B8N1TRrLpZbxKoGfWBZQMVWzEwZ9Zwr+D96Yzl1uKcp?=
 =?us-ascii?Q?n7s3Nu/osTdOXuSJuY+6v0GMOWsu3ZoqemuMwUnxhyrWZWkOcgZY1yUHJue3?=
 =?us-ascii?Q?kDC+ArhDj6bmpQ7js5hzfcmE9K0IXlCXYS13wyb6sd8K6gD+ylt6hXvsbkzJ?=
 =?us-ascii?Q?z1RZvJ6E15xyLTWfDVMO22cs1Z9GhC/jlYRdKJIP4nhJN1lCBRiEBD1X4dpA?=
 =?us-ascii?Q?DF5ptpK0x43HMtfNrck28u2CYYgKeyjzeQ0ExrebDcZAH76vAjDJ7jf8HC3P?=
 =?us-ascii?Q?PLbNteZ1ShTMGb08QvxcI8z637d6Js0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaca5b39-7422-4e3f-ce02-08de56e0fdda
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 22:29:06.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCDN+jP1Jl/EUhbLbaTvTjos+bsALfgIi4VsJRe29spZlJLub7EQ2Pg/mON/WvfJLNnS7m4d0ghdc6ojVTVQiH1FvlndCA/XyqacFxAlOcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

On Fri, Jan 16, 2026 at 01:41:36AM +0000, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Hi folks!
> 
> This patch series introduces support for the CXL Reset method for CXL
> devices, implementing the reset procedure outlined in CXL Spec [1] v3.2,
> Sections 9.6 and 9.7.

Hi,

Seems something is missing from the set or a dependency not noted.
It stops compiling at Patch 8 cxl: add reset prepare and region teardown

-- Alison

