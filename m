Return-Path: <linux-pci+bounces-34857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D5B378E1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C141B6719C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7C30CDA0;
	Wed, 27 Aug 2025 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDY4ArcW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF3185B67
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266788; cv=fail; b=T0TrZlH7ATYJrfXyut9qSJIcWkIKBBI82LzyA9p0sv6QF+q1vibLSj1Fllopug65AGNw9/TIBm2lHrnkigupubr8KwayWUSXe6ER/L88fhN9tY8+XWxRPGbX10lYVuceweKf19QDtk1QvbrtpUgrp2uIBIQ9XCj5vNGzbKW34Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266788; c=relaxed/simple;
	bh=a5p9Rx8+fR/34SPsnBEbHbVvg0P2HSXjFx5Si23VNH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADDKhmwv7fm1a+WPG41KcAPMa8tHk3ItwOTD+V6u1vwd/O+sGulpnufQD872/URjZQztujzjhBrmN+Tz3VyYQHX1u1f3Jpvm+4gAAfUSAKrFIBQADX/g1mj9z0CyDiIdOPvy+CvimmNSI2y0Gjrj6bQKTPyyEZ6L/PR7q0X9Duw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDY4ArcW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266787; x=1787802787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=a5p9Rx8+fR/34SPsnBEbHbVvg0P2HSXjFx5Si23VNH4=;
  b=CDY4ArcWxMt1YEG1IT/K3ZTpLm3NXf++vvK+dDmQWklwY7NWN29bQ/Cz
   75ezrMebOj11bglIyg3WwfIzNC3wfLT4xAEb+mHoyIbvSxCOYxtRPkq0r
   7zhsPLwYCvlfVLH0ApAdBbHdz1EJjvPm6pAhAZhSzItUlGwgjku5wTaC+
   BBlhLogDFPhyn1aYB09OVmwTp2Z7Y7TjOuVcICH4RMiHj7o0/+sEkap4Y
   JcCNdhLA8VelRko6A6vMzGVd4WJ1zM5ez9HuMXeXVdh8VTyJ7567iXTsp
   Y7L6damovti+/O2O9bVkdXEzEZcDa7aF+tPRtaCb+9G7WjmGlGet2FEJc
   Q==;
X-CSE-ConnectionGUID: Ao3HXQ7TTcyvf5DspafMgQ==
X-CSE-MsgGUID: ATAHaWsKR9u91Jw/Km1wzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61150967"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61150967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:06 -0700
X-CSE-ConnectionGUID: JtH4tCGrT3KIWEoJXABQeQ==
X-CSE-MsgGUID: rJGby+tFT3aVsx//KRRAGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="175043332"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEbczq0ccZHkllJ0gpwO/nSevyLVqBHgMAH/zFlskCjhLadAPHkcf/1P09hlEZyxqm84AmE/iVERjEHfkcEgj2kzD60vYz3DGuMV8jXq6M+XlnhMRIkfiFFUuWKDp781TePX7sCkmo5l8mdh5lI+kQVpg3nQ2AQ+x3jmQ3BV5QITgQANjCcSIPo7qldmLoZpuLtFVWne0jFJh171bUp+0k/W1mN5uJGUVgjOo1iZmwc2YQ9iuAabdwnvXy9F13Naw6QN3dTdgm6pDrTL6jGvmlrOj9KQxRJcBuJy08y49R7bWOAHNmz6cwvkweouBF8viskxP3rzIywiUlP4NfIcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hu0YlEDOmjgwGceTvhjoyxQ63vwpEw6c0eTx8ZIu+g=;
 b=lUA5gmEnmuK+nFWMDIlhR68VV27CwMNRd0DlbJT1Lf2zbY9qELy/W8XYZcsE2dzPLl0xPF4XEvq4vldMBO4dWMnaDvpuKj1X9XCJ5mMQi9stfaHFxMeTBGuMlkyFH1nuFtFNe36C2bnJv/6M6XxilKJEIyZ4SgUsm2Bdv6I03ZZOw7I0ffo2h/ojlTeUb8jZcgJzP+9xiGoIeAas4G1npmEPhaSYy1f+2X2TE0P9nH+jA8GKUCp+MfnFmhR2e14g8IfRDWSlhe4Ucw7uqCBOR9UWU91OEL8ED3A6+guLaIwY2Q/TdHaU2WspLjDt+ip1h3zyXqQDOzV2SqW/4+X/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 03:53:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:03 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>
Subject: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Date: Tue, 26 Aug 2025 20:52:54 -0700
Message-ID: <20250827035259.1356758-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035259.1356758-1-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba12c5a-e9fd-4c69-8494-08dde51d38fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pYJmAMWzyHbc3Y+Lm7OH3aMYJ9GexBrDytRV3B+W4+TcKHSFHVKBNdKtZvzK?=
 =?us-ascii?Q?GKBWagQmBpZa8A4wPoeUXvJlDalNCjzz0Bl7ftDXTV728aM5OKCmrE2Kaujn?=
 =?us-ascii?Q?zid1fQJ16cugxWdisMJ9nkyA8kC7YbW7j98ElDILvRpSoPSOS3x0rPFKLZ1c?=
 =?us-ascii?Q?EEh4W9QZGZof6qS9+obfcn1p3EXOX08elIOILqpzG0DbA0PuZcO0AhkC1vrP?=
 =?us-ascii?Q?Ta5myySl/A+5EyvEZEWI6kaDcri4qBcbc6fWklIFbGr9rW8ThjHYWHAjla4q?=
 =?us-ascii?Q?0GD/KjeP2ky+OTf263wA4ML4XLLZ9LNYJGoVmbDzsveRlDWQSBdHlOmUendZ?=
 =?us-ascii?Q?uRnlKQEM79ehRUsxMlu6NUYIrplJJ5L/W60UIrZL12Mh+XGSfqhESluCeCH1?=
 =?us-ascii?Q?z84sneOwqJu8pVe+1LzaBx8gkBclAcMhe7xvnQMSSh7gHqcvGzQl3k6TXVAh?=
 =?us-ascii?Q?seK8MygIX4l9umE5o9n03QQeOecEg1LWkwMmX2d9Sa7k/6LPne/KzkDvWQPt?=
 =?us-ascii?Q?hdyH59ul7H9KwO1pT5+oJVSmp2qQN3Qi0X40wiisvFm+m9p0+DJSxSALj+eQ?=
 =?us-ascii?Q?2tZASGv+TW17IiIOh9PGmAAEXMU6rTQLWEVdzDVevVvC7nQUJA/7XSwDry95?=
 =?us-ascii?Q?WwURbxZDOMs9vuICnNBlMJuDwMqZZidkVgJGIjblD9ypn/TmJghM6G+3nrZG?=
 =?us-ascii?Q?8c546qz8vpeiqlF42G0c/gFzQVUhyGYc1iWqS4g6y5GUep83uF0zB5Yg8HfU?=
 =?us-ascii?Q?3nUvh9IwZ+3dOUnA3oBBb1ykFcDD+9v0jVjcuLCwJFj+uBNes08WYrr1k3O+?=
 =?us-ascii?Q?3bb0quIjsyHmQ/6E3U7uX5uyIXvE561jD76nvV4prLIhqMMG/cp1SfSGudVA?=
 =?us-ascii?Q?D9YmRQ/LzkgffBcSHIr0oXU4jrJe7OORZfodGllRUAZM+Rdobogb5lihqGE2?=
 =?us-ascii?Q?ZM+UPmazIDu8gE9o+i7RjcX1GmWXTt5X6p7oFyXvnYOC1XUkiPGr4YuSLGd1?=
 =?us-ascii?Q?G81VJG/pXPumwrwO0Q21Ktoc3GtMCdZ9/+Nysw8K0QfyJ7YmcUdjU3LJ5ObF?=
 =?us-ascii?Q?ekt1MdItLxL1HskcHtUxQRjIT7cROLG44xdeZtn83NE84ux1OoOJdWPTINJC?=
 =?us-ascii?Q?4N+AXFNc00xqcggBD6siGKYcfkScZo23tMOyb3yh6ufka8wHuw8jhkELNTcQ?=
 =?us-ascii?Q?uTUWK/7FLSwoLSZemJgzqC6YTnm6QgVvzkiCHqV6AuNv9XGyQ0c/LKz6YHS6?=
 =?us-ascii?Q?6Uq8q/Nlz9/qk1ZZMYnutKG7Kd8EhJEOQ+liKGdoTUUh3xzz/Jxb/qnwecGL?=
 =?us-ascii?Q?xw+TBMR2JbtxNetCCMHFasazlZUS3tPwqs9rSSqcoPDDj5jXJDL375YtyL7X?=
 =?us-ascii?Q?KjQkUCnl7sqLDbQPCjRRcFQDDRb5rZDdy6j1XSPilNje+2r8KivlS4d+D4Q0?=
 =?us-ascii?Q?mhhsY0RG3Ls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQTvwQy7fquIeKkMZUfNQv35gK9WSx3dV/O/Qv3iQSKcTWj5TBa3ZS1kB/Fz?=
 =?us-ascii?Q?B5ZFFrCNT+Z7zsT2E0SO9DEiQtnWjYqQG5OqM8kei6L4zF/2VAVbqOAQx/AL?=
 =?us-ascii?Q?ORpcSDtF3WtKHOnO5UbnkAX/D5yPhGC0w2qZSre1zA+SRY9OWvq6RXjzLnn6?=
 =?us-ascii?Q?Ojy1lt2EmavqsBPC97aRtQ4JstD285r/+2DxZY6E0ZkpvGGqzC25ok9oRKx5?=
 =?us-ascii?Q?aTfFXEBC2hhqfvc4Z0Mpb0Jurm55XnT5XumS6DJjJYHXblr62vPPDOKzQx32?=
 =?us-ascii?Q?4EpCgLxh5PnBbZeeq0qRhnPorwGhnWtvWLdNJMHhmcTTUWU+kVd8eap+Jw0Q?=
 =?us-ascii?Q?pTsgBJST3n23RSH9bSdgjhbsOF/xyaPopa9PRCffym+Bg/wrXT23YpC5pOQt?=
 =?us-ascii?Q?qtOWKs/uwHhwbdeaZumKMs7lS7apEMtiVZDXMDyKPy2WfA6+/4C+Vm3pNSxY?=
 =?us-ascii?Q?0sPoofYAqTJtVXBIji6qTY85SU4zQOsVqZ60Kgzs2yR7EURaW9f/eYKt/ZMY?=
 =?us-ascii?Q?Oa+Hp4ZB+C4UgWiqGjo2bWfeDbkWFPTwP+OFMGNvlVx6fifExRPbaM2Mzc3x?=
 =?us-ascii?Q?3w3jo3o0gtRX4TTFOwhMA0agfjnpSqfUVkyDDyfUOdi2Wgqe6nTxlkKfymq3?=
 =?us-ascii?Q?linLlff/7+7fe7uSAXO/hSYnLkQU/9C6W6Q4as/P+miXKUnylkNp9qKNspwM?=
 =?us-ascii?Q?DtDcqUuT/eVdd3agrd/P1bIzkNheigMLfm9RXjmr+vLl7jqTjPbw5n0n1l8q?=
 =?us-ascii?Q?sndbyFa9w2sdPvl9F/dfa8CUDU/OSKP4W/RENBf/lWsA3sdfNCC7l8vS4xVb?=
 =?us-ascii?Q?oMYVGvMHVpTiS763zuCeE0LYwuO910zRsgj+lt6gjagpxMqXyVjrVs9QvdLi?=
 =?us-ascii?Q?fHN4EG/Jl6y2T5EZO8BLXKFVhL6XPgLM3H+lysnRSxEY4QZhONkAD1WP+VIG?=
 =?us-ascii?Q?qOlsiKkrFNLLwOhkwxUIBHhocvIXLUIy4axeJ6VjqFMOY4WKG7vrQnae5cbF?=
 =?us-ascii?Q?Lj9Drt7AcVuiQI9JXFIR8mDRs0+VABLOCvnapPfpW8/t8AMtSRcaaBN55iWr?=
 =?us-ascii?Q?TXyfX7enJFVakN3mqAOTqpIKt24CSj0xmPuQwwf3CtYrTy2f0EAUWOSVBOF4?=
 =?us-ascii?Q?SewSscFlywsfbEo+ssYS++oJcMTxcfrN1coe6W7oleSzsajn4+TzxqO9p9hH?=
 =?us-ascii?Q?qU1zJtGYkjYDH1EwEwqUryK0xk9nXNUNGsZ+71jxbr6D+p7vzejPSfW9iOwV?=
 =?us-ascii?Q?yXc0bTX2HBm5wYhns21MiO63+bQEeOIO1ZalhPVSZdC2KwW2wiGugmlS/IlJ?=
 =?us-ascii?Q?kFq6xCcCWgOW5I8vZIDX0PqF0FJjybSGQBsBf6PhwH3UcuU3T9WissT8+7aK?=
 =?us-ascii?Q?/XrZzYJGtVYJv/bSW4N+Zgj6n4zjuu6ZJnrppOcybKBeL9Dl7J2hsB7cINzF?=
 =?us-ascii?Q?wSY+c9daA0szDfPrPlhhgfWV7Pxq+w9+RL21UDgta511we9h2P00ij2QRMBY?=
 =?us-ascii?Q?YDb4p0NLCcDoavxLYRU6geH+kWjny6DE+CTNMdelRqLvcAQQdberCO4/Pa0k?=
 =?us-ascii?Q?np1rlOExMpF7r+vjnXaW3/47VsLRWv85M5stWdMvb0C9GN3iJ1ujxxWd5M3s?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba12c5a-e9fd-4c69-8494-08dde51d38fd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:03.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A8acj+X/8f1Axdjs8itnmtutjUgQPwwPgA+qf4CP2C9Vycjj3X29WX8i4LrfSdYQGNEdS2H4F6kbDjP00z60A5MdFjuAVVNGWw+768+LHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

A PCIe device function interface assigned to a TVM is a TEE Device
Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
steps to be accepted by a TVM and transitioned to the RUN state.

pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
like Device Interface Reports, and effect TDISP state changes, like
LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),
these are long running operations involving SPDM message passing via the
DOE mailbox, i.e. another 'struct pci_tsm_link_ops' operation.

The path for a guest to invoke pci_tsm_guest_request() is either via a kvm
handle_exit() or an ioctl() when an exit reason is serviced by a userspace
VMM.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/tsm.c       | 60 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-tsm.h | 55 +++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index 302a974f3632..3143558373e3 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -338,6 +338,66 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 }
 EXPORT_SYMBOL_GPL(pci_tsm_bind);
 
+/**
+ * pci_tsm_guest_req() - helper to marshal guest requests to the TSM driver
+ * @pdev: @pdev representing a bound tdi
+ * @scope: security model scope for the TVM request
+ * @req_in: Input payload forwarded from the guest
+ * @in_len: Length of @req_in
+ * @out_len: Output length of the returned response payload
+ *
+ * This is a common entry point for KVM service handlers in userspace responding
+ * to TDI information or state change requests. The scope parameter limits
+ * requests to TDISP state management, or limited debug.
+ *
+ * Returns a pointer to the response payload on success, @req_in if there is no
+ * response to a successful request, or an ERR_PTR() on failure.
+ *
+ * Caller is responsible for kvfree() on the result when @ret != @req_in and
+ * !IS_ERR_OR_NULL(@ret).
+ *
+ * Context: Caller is responsible for calling this within the pci_tsm_bind()
+ * state of the TDI.
+ */
+void *pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
+			void *req_in, size_t in_len, size_t *out_len)
+{
+	const struct pci_tsm_ops *ops;
+	struct pci_tsm_pf0 *tsm_pf0;
+	struct pci_tdi *tdi;
+	int rc;
+
+	/*
+	 * Forbid requests that are not directly related to TDISP
+	 * operations
+	 */
+	if (scope > PCI_TSM_REQ_STATE_CHANGE)
+		return ERR_PTR(-EINVAL);
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return ERR_PTR(rc);
+
+	if (!pdev->tsm)
+		return ERR_PTR(-ENXIO);
+
+	ops = pdev->tsm->ops;
+
+	if (!is_link_tsm(ops->owner))
+		return ERR_PTR(-ENXIO);
+
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	ACQUIRE(mutex_intr, ops_lock)(&tsm_pf0->lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &ops_lock)))
+		return ERR_PTR(rc);
+
+	tdi = pdev->tsm->tdi;
+	if (!tdi)
+		return ERR_PTR(-ENXIO);
+	return ops->guest_req(pdev, scope, req_in, in_len, out_len);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
+
 static void pci_tsm_unbind_all(struct pci_dev *pdev)
 {
 	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 337b566adfc5..5b61aac2e9f7 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -33,14 +33,15 @@ struct pci_tsm_ops {
 	 * @disconnect: teardown the secure link
 	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
 	 * @unbind: remove a TDI from secure operation with a TVM
+	 * @guest_req: marshal TVM information and state change requests
 	 *
 	 * Context: @probe, @remove, @connect, and @disconnect run under
 	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
 	 * mutual exclusion of @connect and @disconnect. @connect and
 	 * @disconnect additionally run under the DSM lock (struct
 	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
-	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
-	 * lock.
+	 * @bind, @unbind, and @guest_req run under pci_tsm_rwsem held for read
+	 * and the DSM lock.
 	 */
 	struct_group_tagged(pci_tsm_link_ops, link_ops,
 		struct pci_tsm *(*probe)(struct pci_dev *pdev);
@@ -50,6 +51,9 @@ struct pci_tsm_ops {
 		struct pci_tdi *(*bind)(struct pci_dev *pdev,
 					struct kvm *kvm, u32 tdi_id);
 		void (*unbind)(struct pci_tdi *tdi);
+		void *(*guest_req)(struct pci_dev *pdev,
+				   enum pci_tsm_req_scope scope, void *req_in,
+				   size_t in_len, size_t *out_len);
 	);
 
 	/*
@@ -143,6 +147,44 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	return PCI_FUNC(pdev->devfn) == 0;
 }
 
+/**
+ * enum pci_tsm_req_scope - Scope of guest requests to be validated by TSM
+ *
+ * Guest requests are a transport for a TVM to communicate with a TSM + DSM for
+ * a given TDI. A TSM driver is responsible for maintaining the kernel security
+ * model and limit commands that may affect the host, or are otherwise outside
+ * the typical TDISP operational model.
+ */
+enum pci_tsm_req_scope {
+	/**
+	 * @PCI_TSM_REQ_INFO: Read-only, without side effects, request for
+	 * typical TDISP collateral information like Device Interface Reports.
+	 * No device secrets are permitted, and no device state is changed.
+	 */
+	PCI_TSM_REQ_INFO = 0,
+	/**
+	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
+	 * UNLOCKED->LOCKED, LOCKED->RUN. No any other device state,
+	 * configuration, or data change is permitted.
+	 */
+	PCI_TSM_REQ_STATE_CHANGE = 1,
+	/**
+	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
+	 *
+	 * A method to facilitate TVM information retrieval outside of typical
+	 * TDISP operational requirements. No device secrets are permitted.
+	 */
+	PCI_TSM_REQ_DEBUG_READ = 2,
+	/**
+	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
+	 *
+	 * The request may affect the operational state of the device outside of
+	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
+	 * will taint the kernel.
+	 */
+	PCI_TSM_REQ_DEBUG_WRITE = 3,
+};
+
 #ifdef CONFIG_PCI_TSM
 struct tsm_dev;
 int pci_tsm_register(struct tsm_dev *tsm_dev);
@@ -154,6 +196,8 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);
+void *pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
+			void *req_in, size_t in_len, size_t *out_len);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
@@ -169,5 +213,12 @@ static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id
 static inline void pci_tsm_unbind(struct pci_dev *pdev)
 {
 }
+static inline void *pci_tsm_guest_req(struct pci_dev *pdev,
+				      enum pci_tsm_req_scope scope,
+				      void *req_in, size_t in_len,
+				      size_t *out_len)
+{
+	return ERR_PTR(-ENXIO);
+}
 #endif
 #endif /*__PCI_TSM_H */
-- 
2.50.1


