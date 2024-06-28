Return-Path: <linux-pci+bounces-9411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA191C6DA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 21:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0943D1F220BC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 19:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D1770E1;
	Fri, 28 Jun 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHsfzGRu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553C74059;
	Fri, 28 Jun 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604140; cv=fail; b=WZV32rj2QaYty7WkMf/U2dNwMXdZCjjWm4gv/YaZfWKKnJ1ILfLsEgsSsLD2m7XtDi5JcPuohoHWrucG9AHfL3RwWm418DyRQ8z8tH9yA2ZFh8Hu87KdnL8OuGMvf6qXYB5T5WJLUDhXXHATWUQ+zFBwpIngWKLXOKyB0i270mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604140; c=relaxed/simple;
	bh=lGp2nLZRkNYNCsr2twMWK6dUmuP22BYw5nY6iYkI5TM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLCwXhvSNCgqhMB4LNSG83fMMHjEo06TZLWLWwsf0z+FUoZj6r3/Z4fV+9jLEPx70WQeZeC+Vj7GUcXLXpCIGcKjRv0hZq2FXu5qe2kxWoKT7503XCknb9iEzRJWH/7tdAsRlhHWFNV+X35ArrSi4EwH0NK3tAP7Oj2h7Q+8m4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHsfzGRu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719604138; x=1751140138;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lGp2nLZRkNYNCsr2twMWK6dUmuP22BYw5nY6iYkI5TM=;
  b=hHsfzGRunU5TJInqb5Isgbw2n58q98vLrxUHPsPazSfXudFIWNkzA4Oh
   XUDTYHEZnU/fhhgatMByWvVpq57i2ka7GxJ9CckCBlRi8tB3/ZXjIuEfL
   /7NgsdOnGxdKsWsMR3F351/hJhbJjmxD++zaaBoetkeEpM+pA6gL+XErV
   3cmA5z4K1sJbGM0LrjwILmiNyZf+uc2u2hHEgBtUjNNuiTu2/NdJ5dHaq
   jmChn0T3n0rvTcHdlNJmn6BzEfoKVy1msagUC95Au9UFXhDt4BAxr4Sy7
   lSljIzu7tvwlStDYhlEc/9hsfXW6kb5KXxYYQ9et3XFcaO75th+Z7MH2j
   w==;
X-CSE-ConnectionGUID: A6k22ylKTK+h8awb98bH7A==
X-CSE-MsgGUID: QnVcvcSjSda5CBKVHffTrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27932929"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="27932929"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 12:48:58 -0700
X-CSE-ConnectionGUID: QTaSEaInSGSFyAtMe4lAow==
X-CSE-MsgGUID: YzW8wycGQaGNc73/oew8OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45257162"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 12:48:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 12:48:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 12:48:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 12:48:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 12:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEfTadZDZoxN35IpWfE/Dwn1TGnqtysiN6xE1PWZfOrxg/6XoidbVPUNDBLNKCcz9yUnn9krNLknr56mGDiC0PkzHh7hiCDPZ+DHrzuidQR/nCCzOt+c/mjYijvq/iZ4cZNNkqC7HcdnutE7Q8zdXwH3zT4FZB0A3UZTbqmoH4KZPXt69lNVJDphMntanDy3biSmqg4MuR4ncpuJY+ifc4cYSHuKwQN8B3UCNfEGmG6q1bNQ/a9TBl0w1b5JXYfySxBnznhXrRTKppBf6HEknOfDRABqnu0B6bB6rjVaBTKxe9MJdXLq++WHoHHpPXcYRLcKZlkUULg58wk0OOqQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pWK7hmSf0Nit/NJIM+PHYbRSuSG3xvPu7rvqFB096o=;
 b=Q4O/NyG+2z25oiUTGuNKo6J7LEBmhE0aytXFTbaVCNsKP7mbS/vXeia6qmvcgglNuqtCDc4qXOpDXYc4AeDf84D89QKwxrvKZTHH8VGJX7YpKe1QlXvxGHDHZyEbmlDIgV4tWrX3bcr7bqusrV5IpsNfehbVUXr1+zZYpYaRqofc8/arZmeDqmNZezqZf1PcCDcS1uP26zWSIUq3iA+QCA9XTpVAJcQtxa7WEHSG5Wct3LStRJMqlPIAfNZfcfpuTMBa//7z8FITSd21t8gkqVqSe6/IOmm/pBFu4RQ0Z7u+V7Mq2dCfjLMk+xsMVRCAimuya5EWPxb3g+Y9MoMRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 19:48:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 19:48:53 +0000
Date: Fri, 28 Jun 2024 12:48:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Keith Busch <kbusch@meta.com>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: fix recusive device locking
Message-ID: <667f13a334844_5639294d7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240628193514.1680137-1-kbusch@meta.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240628193514.1680137-1-kbusch@meta.com>
X-ClientProxiedBy: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 9962a785-486e-4cc3-4bdd-08dc97ab5725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t2SKquySbJULR2FjiydYoDYARmB0nBqM+WYMUqLYdedChP30ZsphyejvD3bT?=
 =?us-ascii?Q?0vSaDbwCeferMMIwRWTWNEvz8MlneJek96hqWfRUx6Rf0ziDzjrq1Z3lSobm?=
 =?us-ascii?Q?W6w2Z5rLexRzV7dxA93PYXEtHPd1LeQRJ2hLY7yYXaLSE0Z7KmlD8GlClnvH?=
 =?us-ascii?Q?cD8y46MBPxY4YeMcXG1dJEbMQ/uITHhQtrgi7xaoZJr/eU+KCZLevajpUD/O?=
 =?us-ascii?Q?Y/nEe2ek2gaiYKa2vz0ll/+XRhOqcT3FmUslsBgG7qp6fs0YuLnApv0Ps+oS?=
 =?us-ascii?Q?MZvvQD/yors0Jlh6Q0PmRviiy2WRK2k/i8p6jUX5ygDMJi+SHwMTZO5jkAzJ?=
 =?us-ascii?Q?KUYTmJJWFk4LjziFjmXFY6r9fYViOAuku1JXOPDL4VMbF/G49BKTCHNUBuBh?=
 =?us-ascii?Q?dEdp3SvY3a13gmdLTDb03Hzky+gr6bAn/1wnnj2+nXxCj+eW331yKnvu8tzo?=
 =?us-ascii?Q?Sa6+1Fp8WdX4r8d5EOfjF3LJ5L5lPIx7dkODYZoqKqxyC4Qj5/w2wmNuGEBG?=
 =?us-ascii?Q?9W8WzDEHLICXBb4XD9hbyFOoYnsYgBXC8eYL/3PrRyleRKuGjHB5c7HSzhMT?=
 =?us-ascii?Q?z9jxZ0yEOEucrBs3mbjUn9H768XCPNwrP3u7SKqiXmU57HBO4hZS8fU08KnV?=
 =?us-ascii?Q?yHAlhHrw4VcQSWTsIi3SzrWxf6XvLyY/Ag+hLsHSKlWgGyN+xuBgLSyHqnyX?=
 =?us-ascii?Q?9LcCEgktpYVXYElFXrb2DrrawzWXq+oq5ZjncMQz5YfTRtslCyKgekDhkNHJ?=
 =?us-ascii?Q?sQGLUgSoGFelwzDLm/wZkJs+qeIbISgtovN4JK5tAdmYJKoV9s/1euGe8Ayf?=
 =?us-ascii?Q?Rbu2AoRSNNVBdGDL2Liizwse9zMqVdJbvyLSebzcY0bgKDFJVKSB5YRBlYWO?=
 =?us-ascii?Q?HRAi4xgSUZWXE+BkvH/O4V73AIP41CdqJLqcLOdTfdrwvG4JmWvUmxSqitNn?=
 =?us-ascii?Q?ugz/DAdvIFoh+UuABPeufW3ucKJIaW5yimA4I6Rq+7qBegwhGw/ok22Q54Co?=
 =?us-ascii?Q?mmgs7R2HS8oP4Ae53TmHTznaSmB/XqP2I5rsfSXdLELV3jJ4chBSV11et6Ae?=
 =?us-ascii?Q?aBjri+wIBZgud5U8fMHQ/qOBjdwtzP9cRpB9VdWaAnGWcSJE9UMJXTZ+g5pe?=
 =?us-ascii?Q?wBLOK+tRMcT+VX9WOqDAUeh03ipwb/zir3ncX4t4jLh5PNodkqsfpPQ7H3bW?=
 =?us-ascii?Q?QTMC+HWtAvhPTPULkKje8y3fk8zgSVTarypO8xZmH9wzoPgfdxbwR6eTCOZt?=
 =?us-ascii?Q?5bQjWAUG/Gi15+scBwkFvv4rGIdgsGNGGi7uyTN14ZoPceCaDTXuIE1jOfZ6?=
 =?us-ascii?Q?EJTgZaz502hWhxWOOVX0o7EwXklp5kWzmbfhB+wVnDVnOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZ9ERBeqh8ZaMvaSYOWvpBliQFqX4aLPcljp3y0Y+FDfXoStp7G7OnXWTylT?=
 =?us-ascii?Q?uattUyGPSITlgIohbdNA7EQ5AHSKGmPTmQ8d3vd3ZzbEqLZBv4L8/L6axZEq?=
 =?us-ascii?Q?OkfwOINyljo6dHgEhXLJSPz04EGwb/bs6aqbdjHKgmwIoW73hivWhDQg5UlF?=
 =?us-ascii?Q?iooaHMRytep7O4BmbMCy3BjU/0TArjBRBHD1vyM14fttFHsxxGhT/5QxMul8?=
 =?us-ascii?Q?YU7OhuoTnoSm5Wf4bTsXmXrp4HYt8MHRXR767B3P0Y1T5BVHQQFpY/l4H3PV?=
 =?us-ascii?Q?24Z4SH1rxLn1yO67JBsZkmVnf+NzXUzQtBtz+02FPEusYUzxGKBT/TaFQUK2?=
 =?us-ascii?Q?ZnX5i74plvYhAUFw0Av50enQ8XbdgKKRcYerjPiBcLVaqT225j9Hcbd9S0rL?=
 =?us-ascii?Q?FH0iL1DlXte8fNo3J+bLv0xz4+Fcurz6CsJy3yb9ikFcssBubj9RHhsddQpF?=
 =?us-ascii?Q?/d6FMPTYb0NU+GBr2HZXo4seYJOhwUbbb2LqM+j2yLLkdzGCeDzF85nepH16?=
 =?us-ascii?Q?8/m1CGotZ5vWI17TxVodAXgm9PPF4AJLlMblCF+19PyEythubq2atvKxXFH6?=
 =?us-ascii?Q?lv/uE1K8RqCsbirWcnIMpHy5qsjWW52n1PY/IaXLZreQ/eMLSCAbk4qNbdv7?=
 =?us-ascii?Q?hSQiAIOwj8FMpxL4E6+gakLuE2YbpgYjDKmfcrZKX3Mp3nRMZB5Vds1+X7vc?=
 =?us-ascii?Q?q8bxCncsFLQPTuC+XLFxxkrGklG9yzAfjt6Ost40ILSii87NZAd8qBzjX0sO?=
 =?us-ascii?Q?rCrK+S5Rngm+Ebv0ap6GUR9yZ2yFt/kSJ6NegQAtI6/M55GASYlJ4Wc6ShS9?=
 =?us-ascii?Q?2UvMGZ3LAYz0GKdGkqx5hFIZxLQh9YrI/r3PaByvmCX/ZqSWZHVTxq+JDWUO?=
 =?us-ascii?Q?mPmrsW871Lc8gjuGAVlOqXqTfO+7ueYMRMeNd+8Qj9jSDxQIQbkn1R1uSlJI?=
 =?us-ascii?Q?tznPX4WSDPQ2ZtYVKrp+Upmhoor7i0JKJhLkoBd/QDJweP8W4nUth+eSepg4?=
 =?us-ascii?Q?LyhRUxL6VFR5DYcoR8Ye0fkW8sHSlW4DOkX/6aG6G6AwE4UC+jjtLH45PjD+?=
 =?us-ascii?Q?yP86ReNiErz/kd2pijJGNehvCMR0RsBFS23IpOzi3N13kSgymZbLp9oVB1G8?=
 =?us-ascii?Q?MS8DmUjjirsXu/W5AEjvB8rtpR6JKflPzmPgHpG4eHXXyv9+tZAeA+c8yF88?=
 =?us-ascii?Q?yryYjsEdXS61Pq+EZYRYCsLR5IJhAfVKAp97hYv8nr9jnyhl91ENrx//T/7o?=
 =?us-ascii?Q?Gy1kAGvYIB2nFYEPShm7F1H0VEq6iLIZ8aeFjinewvfrYSmTBa6BeQ3s+39b?=
 =?us-ascii?Q?AQte5m17bAzAM5Za9Aj88/MS88/CBjfRgIsYAkwi5dcDlcFiQuQNsBkeFk/0?=
 =?us-ascii?Q?YaO6xVF++x+tIvGmFOAc8rbteaSQIhGf6OpNYue9RU1/GNd7zeapz/CBzKJE?=
 =?us-ascii?Q?LvZsuN+1LdXiw9yUsSHRcrxHTP6wL4YRFTspTgqGRHPn3wtBhBAodWaJIPk5?=
 =?us-ascii?Q?Blw3WkKQsP6pYHgD+Gy6V8WjGyS9yKwgy94p3y3TLyzEY8mauqRh9jwYgSFP?=
 =?us-ascii?Q?NmDFxmctfJl7r82C71Lqd/9NmIYX3bNCDtqEK047/foKmb9q96AT/rSss8bF?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9962a785-486e-4cc3-4bdd-08dc97ab5725
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:48:53.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+SNYJYQ68TxYGFHePoXqkVdPqB1CQNANj3+xZnR3xN5HjJfzHvlS9O6RRBmYP2W7+L3kR7uhrSs+mBiDzE6kOA8rHWpQF3N42rwo/tPvo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com

[ add linux-pci ]

Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If one of the bus' devices has subordinates, the recursive call locks
> itself, so no need to lock the device before the recusion or it will
> surely deadlock.
> 
> Fixes: dbc5b5c0d268f87 ("PCI: Add missing bridge lock to pci_bus_lock()"
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good, thanks for the fixup Keith!

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

