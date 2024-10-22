Return-Path: <linux-pci+bounces-14965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F039A9621
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 04:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C07EB217D7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B13811E2;
	Tue, 22 Oct 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaFrnyQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C61EB31;
	Tue, 22 Oct 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563450; cv=fail; b=BrW7tgdcitnoetQV0a6ZPiAEXrrDcvVp1fe8JAJTvPNUvEsWbf55KdUKQt+INfsxStlXLpdVrjcr6EeCbu1buunvo1TRPgcWS0Z48JZMeF00Px5L29TDfHtsgpQnCEkKmZKtYJVLRdcMqHSQFS6wlnPSTelDut7eN6Tt9IqgfJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563450; c=relaxed/simple;
	bh=tvn4GieikV2kjPxN3qLkVop9yP5/dxA3TbFQ5zJIrhY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ddkz8CTP6gqSL3dWD5M7Hp1L0RxJ1xz6cRA+yMLZiUcQPtbH+8j+30X4Kfmy0AEv/6NYMsW8K0XaR/1fTIodI03GN6d5ZZlm0Z7WHg0Q3yTKaVD34zu4p2C1/vK4YX7PVMISL+eHLl37jIMsuixsUmvbvI7oexNxBzJgYpxFino=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaFrnyQ9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729563448; x=1761099448;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=tvn4GieikV2kjPxN3qLkVop9yP5/dxA3TbFQ5zJIrhY=;
  b=aaFrnyQ9dg4p1F/3LrTovBltCfOh/x4+AF9G8UDVqv8StiLSUJWAKw7F
   9dZ5WqdkmPMSzVI9SUxfEA6gbN1P+BodmD4ha0AgUa90N82oOCyanzT1e
   KtsC2AsFoCBbTWDc3Uz/141fOsC0ZY+iroqjWT5S/yu8VskzbmiVDd/lL
   EJoJo32AiPKGR6LXIAGd1HP0v9J8y0TUfHX7M1qoPjuIFFxT+BZ2Wl36N
   hMZgLFKeDYCLrQ4njlDo4WC6sw+gZi2MBFMNu6W/h1JHnXOQ7OKnm/EsH
   LsJNFX9BCemK3UyAHCq+PFjSA+JEFuoBmcDfvgd3X22vLmpOr9t1RQN3Z
   Q==;
X-CSE-ConnectionGUID: 3nANObmkTGevaEm2aspg0Q==
X-CSE-MsgGUID: MdbxagaES+eNnXSS9NMdCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29187476"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29187476"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:17:26 -0700
X-CSE-ConnectionGUID: yYbut1aVSyC1i/y6H7LDqQ==
X-CSE-MsgGUID: ndEoL1FlQKCHkMufz+D/eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84316805"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 19:17:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 19:17:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 19:17:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 19:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7Xl0cFEMUR75RJZzH2vsid+t+6w20wfCoLX197Q4sLTpC1ItCULIIKOL4oihxxOTgrUBiM/Yz+WhNpuR9qniMrZN99XViwz8SniWQyjehj0QIenM6LyWtKQyYPNa9SL5ORYH97o+Byk/Rw/AsrRJjcP3+mzZUSk3Fl/HdveG14UKKNxgoPRVOBx5wxMyMu27YBUF1j/DM1dg5zuqVscQs5h1yrP3mXbHq69mqkQUZMHhnKlKNxbVfhRkQz047TlQP3In8eK8bJmzkdjWRKKDh+FdwlZJl8vCZx+8tR0CGdxknQ5F9U0mz/LC/P4/qvjczXJqnhATu30FKO5cncoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvn4GieikV2kjPxN3qLkVop9yP5/dxA3TbFQ5zJIrhY=;
 b=MZ7PeQAsn6Izao7VgHu+cN2j6ZQkYePlHjYByXNs4gxT5nXeXomcHBG3Sb3oTUW44mooPR0K/zOeaeHBZ2J59jTzHMkVPxsvm3dfPM5Onova6pRz7IXACv0MYuO7t+8P3wAb8Z01QywhIE6wGmySl8KLk+5aU5ojJNXU3KAvcCks+iGWTs0CDmiu5ZAolB3OjLc9L9rEMAyoK6n5Pd7p+B6mj1QG7GtrMbwj8PhXsTDpcBZ6NyXN6fQCYFoU8vvX4sDJVeSZQT17C0Mjz3DEeF0a01mPck6kfPFAHa2ExaFFo0jxxqaRL+r6rJ3LiBiH6i+I/LF35EaCo9B/Xfl6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 02:17:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 02:17:06 +0000
Date: Mon, 21 Oct 2024 19:17:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 02/15] cxl/aer/pci: Update is_internal_error() to be
 callable w/o CONFIG_PCIEAER_CXL
Message-ID: <67170b1ee6d1e_2312294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-3-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0359.namprd04.prod.outlook.com
 (2603:10b6:303:8a::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fa9c55-57ec-43b4-71d9-08dcf23fa017
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eOUFd+U6MfWGxwAiXdPkwyLHo7wpEIUxNWA50KlGHfoCKuZx9AFGHwBCYxN7?=
 =?us-ascii?Q?8Qohl24W7SB6v4TFBfl/TQa4e+r/ae+GDlz3VkqXspDEpjc0qbHG0jlYrarx?=
 =?us-ascii?Q?8aVO0h45yEEuwOx8hQCI79B8KOclk9sYgGMoU9I9xAVmyGYqQPA0wQ7sPrh+?=
 =?us-ascii?Q?/xOCV3sjaXZzLDtUdMH7DG6GImeuEzlPkhgJBususfcaQKImocmhA/rvsJz/?=
 =?us-ascii?Q?PJLGYKwlNV+1RDTlcap3JnVQVB0Uq9wWtcfkZiw7GKBbPs1SOW8t/XWHY6Uz?=
 =?us-ascii?Q?vdayUKHVZadmcpaPejUZda+hP3MmtpDJ9ENKGcZNZmVc0HZzM+EWhBy966k7?=
 =?us-ascii?Q?oSnzfbLaVnSeJUW4jGrtsdMbYk5fvO+81LlIfQmCme1gSjLv4a3cXf2T6Lja?=
 =?us-ascii?Q?bpd9Hp+DZBCqYWUf7i7y2ENBoJ7o6nkoId8WgdnDDAFJvrjWSn8ZapB/xgZP?=
 =?us-ascii?Q?lYwmQy+if4GETEOQU6EiEivN3RbMdszKmYiCtnl3JbrdUcSJer1nvRQi8gXz?=
 =?us-ascii?Q?rpAcQBxGgiGacaPu2zBdXOzv4N8zcKZTtxoy1Aecxuo5Jw0igW2j2iFSgTOu?=
 =?us-ascii?Q?bVzf03Oq+ML/6En0IKWQFh4vlKCYElD6cvGgRr9J7DqCYqFhGNLrhGNjVsxB?=
 =?us-ascii?Q?hTKsQei/mHFUajS8wP42+NVI5kqA97oZZrmGoDVvGlZUXaubqOxVCKVIzsdg?=
 =?us-ascii?Q?vNpUQCRQBRFNbq6oC3f//cxnBpeMlMo/N15jPl+8C1whac7XfMa8KgL74rtS?=
 =?us-ascii?Q?vqYn8o7U3mtiCp3sIRglYxVaD9UHKBcDjGtxJUeEnnO35fSkj6FmhiC4BMnw?=
 =?us-ascii?Q?99BSdiYK1zjWYwJUvLGRULn/MrtAUBNvi3FqKwCOXtJpLEb6crrOj0B00KIh?=
 =?us-ascii?Q?OMMxj+XMhqbOXEwBzjBY+ifv9lJMGhywUbq18I+yukNepiTsEN72pBQLOiag?=
 =?us-ascii?Q?SYwr8/HlkZfTN3tXciHESQDrPEq06rTgSuRrQ4ccWMkUwFu2CCE79Ru63Fyv?=
 =?us-ascii?Q?ZvbvjQCzvaKho77ZC3zgg2V2sGlQ6PRcATG3DyKVoIf4zf45acz6LwDxwTLQ?=
 =?us-ascii?Q?/0ggsS7T4tb1JDQNzAAw+UqnmDjxbS0EbnsDFLx6h0i3nRh23BFhdJ7v1YVw?=
 =?us-ascii?Q?L0tKA+tIszU9d/xNhhdiv6B6/huSSbdzw7KY/h1NHGV60HY1HRMIyzV9d2Bl?=
 =?us-ascii?Q?CCeYqrudHcDPDnjuttThlYgp/oPlJ5IHBAh/EhA8Nr0XxUGkdB2sWIIig2Mi?=
 =?us-ascii?Q?scc6GWG6C1QjTQcFH7mzrGbKXvv4WggGAIjMdeBgEaO+RTQB54UbVAPt+CAi?=
 =?us-ascii?Q?XlyakCpKlIoC7LXtq2ERkrsfXqj9QzZpqMbZa+RKkwU7RSw50qBoeZcvrrCl?=
 =?us-ascii?Q?UKumr9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmfTgz7d87wUytltxXr8Zz5ihXD+D71L4YQE1iCJWs5QIZO0soLrd/wZn+KT?=
 =?us-ascii?Q?qhj7dTIUHcyR1IxLvwlDhHZbo4qiMFe8ASoIIlnCNxM84kDhHi3d8R1tG3Lz?=
 =?us-ascii?Q?zCS7+yuVQwHpwCcijkO5thCvgWYwnHAsYRmVSm1QUexT8lkl5ONumvuOWrf1?=
 =?us-ascii?Q?uPMYRWgXd62gyvTpl0qqigGSJSS6YNO2o99tKDclwfLfBA1rYuHss9KsI3Jb?=
 =?us-ascii?Q?uNryWk4c28+Z+3A5wzfvK4ezbytUWeB0bnIochJTeaDuRu3TOumWj68nNfVU?=
 =?us-ascii?Q?jHQEf7LxRQj88SNNx+IwAeo9kdqchh561H6xlpcJXUDqMKZOZ1ce2iV3PwvT?=
 =?us-ascii?Q?OdTJ/HKqdJXmu1ZEmr7gJqVoVNy/qhhsfrENk/6zkfxrPlQ7wQltfa7zt1oy?=
 =?us-ascii?Q?15OiKuBSaS853s5oBqoAZ3HSrXPgJNkcU/mIHKZ3aCtF5u2wZXpVhvrvIKJS?=
 =?us-ascii?Q?XwuScHuh3G/rWFlYdP73AqYH6Oa1v518+fzcpgWNxmI9umBUGX5LxJcEylah?=
 =?us-ascii?Q?hta/g0YU5093tpUyLarnE+e4t8/nkWtYib0nOfggSdzySImsDSjLUNbGVzFX?=
 =?us-ascii?Q?p9f9OzghYhYdZho0Amnnct2GDqldAPzj2Sh4/ZCl9UXt5f5UeJc0qMCo45kJ?=
 =?us-ascii?Q?MSVbe1U74Q/cj1C+27SqRBWiw1mhwX+0L0Cf4B2vcoA3TFUgQK1kVtALtgim?=
 =?us-ascii?Q?nJZbv7UdvTfZV1vt/vVjD/7qhImwpuZwwkMzAAJwZkDA+btJ0ybreHSeWqPY?=
 =?us-ascii?Q?RJyybSzwAYG2EATdguSNT8/RxPcRe/TPD/Xnurmgee5KEPyhPPUZylp8P6Be?=
 =?us-ascii?Q?Pm5LMWiKcXticR0lbJmwLAzfMY/NTRQHq+I1E+yNRTVzTR6NdRFIt3rsZJHd?=
 =?us-ascii?Q?UaOKMRztdoBmwXkBzSVmcxDFzKbU5aYzaatqygIB9EWjamLDBG7Ei0zc/L1V?=
 =?us-ascii?Q?Yh1SGCe89Uoks+nbdfQSN2az2tMSdLTcicgrmiA6ht8ZyBDQExSVIOiMf4gz?=
 =?us-ascii?Q?2rsLMRP4tMOl46bfPIOcHajJG3i20kVNoGTaJLSbjpHLi2vgOmYJTPiJWQC7?=
 =?us-ascii?Q?c1Nw+zXCO0pWLIwq9Tqid7e5Bh5KyZLtgH2+3CVTSK0rX7wRdh5bRjBr70Sq?=
 =?us-ascii?Q?MblUqr6G5ICf4ZpjwQcEL1H2N7B5A1XjSfFxhpdgt2ysrxbsTGWSET5SiQg4?=
 =?us-ascii?Q?DULJW7bFChUOluyUknebHxZ5kmyPQgwigOanO6Mvfp6zz3Y4jIJiVesAsdWF?=
 =?us-ascii?Q?o+B22wmxRPTzG37fOchfidRCcPom1hpemQfv2Cod7kiu/9q0FyJ/NffAtP1v?=
 =?us-ascii?Q?gEsew86P4VsgkDwyuZY2Xoak63FIeF0PhLAq335Ty7AkfuGmoYsH+G5CsRTf?=
 =?us-ascii?Q?PMxoaExfPlslBBhAGaoCPPdwlXs+pHy7DpOCXEu3tDD+oqRJDNw5uMlOVAgB?=
 =?us-ascii?Q?cAu6RERDVnblZWPvApOz6j5wV25UcIb5hITGqa8qZV0zDH2cPoxvD95AP1zo?=
 =?us-ascii?Q?3UUDNZ9MB+QBAVVPma5mISQtRojYN7cmb9D6EunmFG2qBeYjzkGkJb003G00?=
 =?us-ascii?Q?ZuV0DFAhpgJ9hQ/lxLnH8QBzud/7iSNMrwrT3s6lXDpcbsYFrCagxwP4KdsR?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fa9c55-57ec-43b4-71d9-08dcf23fa017
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:17:06.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbgCaDQpQr6TDHWhp7DE1bzYwLRK3wRgF2VZQHfrU2kfZ/NjkQ/5GJ3aYw1vnQbt1OY23hPKF7o3c76tLQWEVFQtEIaRwRoeT/HON5edR5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL port error handling will be updated in future and will use
> logic to determine if an error requires CXL or PCIe processing.
> Internal errors are one indicator to identify an error is a CXL
> protocol error.

I expect it would better to fold this into the patch that makes use of
the is_internal_error() outside of the CONFIG_PCIEAER_CXL case.

With this patch in isolation it is not clear that a kernel that sets
CONFIG_PCIEAER_CXL=n should distinguish PCIe internal errors from CXL
errors.

The real problem seems to be that CONFIG_PCIEAER_CXL depends on CXL_PCI.
I.e. is_internal_error() only matters for the CXL case, and the CXL
handling is moving more into the core and dropping its CXL_PCI
dependency.

