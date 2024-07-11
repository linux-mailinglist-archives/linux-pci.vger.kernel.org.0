Return-Path: <linux-pci+bounces-10184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A792F026
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1B1F21FC3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E388149000;
	Thu, 11 Jul 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihjEzcK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF418E20
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728654; cv=fail; b=QJgbkkTxEA0WzR3jwObEPOcqpIdZoI9V5jXqH0PGBzq4ZwSWz38ItGflwzQkjmE08if9BL9s5/YW8lgQzI34Y9z45Ck3FkXXWhUOIZIr72NwxJVQQJqd8/sTncQJdb9lqKHH74wA14Q7UaXknLMvFgenVKbbPP3tAbuvV5tVjQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728654; c=relaxed/simple;
	bh=CrIrR67NJ8GAu0LGwebHiYWy5Ylq5F2WcKbVx6d8Qbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I1795BPlklpcPm8IC3FGHi8ubTWwdGrJkPAXeTqJ4xxpAEwbznpsoRIXc8urVkvNvc2fv9UklU5hpnt1T7M1mu/CjrP/ujbquVZr9yDCJYaNzlXB+leda6IiafkiqrjWQuONazk93iaIwwnh4LGB+qHnnhvdJWdEzIsydl+Gevs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihjEzcK0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720728653; x=1752264653;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CrIrR67NJ8GAu0LGwebHiYWy5Ylq5F2WcKbVx6d8Qbs=;
  b=ihjEzcK00kwMWLvPLZZqr0lLR+0RO5qXCr0CodosbaWMBF8/t2E79evQ
   9XZGYl48OJ2TCV42/RB/XPaMbJECZuil+zJML970TMYG9b4BqA/+IMGjx
   /EssSGDmeTK70w/B32wYmmXfYZ0oTvhN97LDNVIyPE1HHQOpVilk5GjRT
   7JUAHae6xpd2xTwzKvXbRt45TBS2Z37nRhYI2E+EOID5gjhTX2tCL7eSN
   Q8rdBjJf+4w+4WQ19xfAQH9hSpzoAUcZLkfyxcJMB5pJtDaSmCn9D0lOh
   rPSHz4FG/k8WB1jEEzRIR+yDp797ZR//lxSp7+HaiRRpQNqc7zh9kTZdP
   A==;
X-CSE-ConnectionGUID: gS1OMWmkStauWsCCo8aAuA==
X-CSE-MsgGUID: msSunM/FRfqsz58OI2YQSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17962903"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="17962903"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:10:53 -0700
X-CSE-ConnectionGUID: ELGPgdrOTN2Yy3mOqb7cvw==
X-CSE-MsgGUID: FH2YmkrCRNOb5w34lE60+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="86190376"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 13:10:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 13:10:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 13:10:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 13:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl1dbnQBVvfA2mxN8Wd3ZkOC6Jd6MsYgPMrCA5yQ4mJQAbbkwNp371+lUM75XEcTRzpm+6kIjyIArvZxePY3/j37W6aixMhL7endOMnDE8sG3Jk8sudZ9bE1o0YTPsqqbKPs+yzwHdoolDEmoi5LDrsbF5MMVZorRFUyObI+zLzW260DfJGUSWkiNrEl7AOyOXAogDVTn6kURAEDRttdiAmsE+qBc1oUX7Jf6Mbgn2QieBv1xIQPtEUhqGfzsld3k/eVZBDbjqg0Hfkgy12bXH4uKj10fDJa5iAjkuqlxZZMdH05mpNdV/M7nSbUR6P2+oD1ooft3CNo48D6e+Cn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl5h3KgEtgi8JhjfCrgJ0grahRGdMl1146AidseME+8=;
 b=mvFGQaj6tAv+qzqLPy4mY2fbuCv0QEEESCL9w3JyFVV8pfYWz8FynIi8d9VxVYYTlk1NYV3w6y1P51kzyx7u2S/sGM0QnAQ9neReiITa4ibxGv1TCfjArYS/fl9oCc7HuyD01ulZqfGCHPYdbKU59HsywFW4W0tic8WxsdNtXmZLOCg8896yyRsHgt0NILqS/6At4ZetkCRKfew/Q538F/k+3xu/o+crBGPSpcmGHmiV1XoheZihFGZ+kNITnMJS7OnSCLB8RajUmTWe9Bgy47ey+mzojDcf34sgiIVp1/nRiCHaE06y4mjyrGkr+ZMRRwnrlF23PMcr2s3KyJMQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 20:10:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 20:10:48 +0000
Date: Thu, 11 Jul 2024 13:10:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RESEND PATCH] PCI: fix recursive device locking
Message-ID: <66903c4622173_102cc294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240709195716.3354637-1-kbusch@meta.com>
 <ZpAwp7K3YtZqg2NZ@kbusch-mbp.dhcp.thefacebook.com>
 <66903bb6a8c44_102cc294d2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66903bb6a8c44_102cc294d2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 420a31d2-3109-4577-f35c-08dca1e58e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X9pUPN/DUi9sm8odifVDMSXOCh8j7OsEUmBlL1xyylwcTwDmIzsuXp12iSml?=
 =?us-ascii?Q?vQQ63t18Lbx8cx5TJpWT4MAYBhLYkf3VdsbdJ7xqoYe0u5BAbHG5/smnMmP/?=
 =?us-ascii?Q?4wHpbSbTIIRVOnFZ1G+WQxHkFOBo846BlUdsklJ8wT2KyZAh7//r5H5+yg19?=
 =?us-ascii?Q?ukXdaztHcvYkLLnGf9Xlgwl1iMJyCpm37BYjyWG3+YvT2pN+x+DYW1CE0qGz?=
 =?us-ascii?Q?e8NmU8yGxUkszZkF8hM00/qi9ptebSJoNVhSDhXl2gXx1ZCEy3W6RyDra9YE?=
 =?us-ascii?Q?CU8/R9XGDxT5eUJSwLZJ3D8U+WAh6SpXL5ZAsM6rHDSvZZ3q3w/Ycdr79rXu?=
 =?us-ascii?Q?/YUPzH3gAgNi/nQA5XRhyT48OvKPG3yv4idfJ29at6Fz4vFuTWvzpm8TP6EB?=
 =?us-ascii?Q?Mp4vph2gBtZfTzH+YZCqlXEZBZ5ePzsmJgZgkhEmOktYmMKrdfl1kypk6gMe?=
 =?us-ascii?Q?irJaHhe4+lAuJ7O5k+GUeb9tY2pNTaX9vj6cT+7JDme9hNnj5gLnY6lH/scQ?=
 =?us-ascii?Q?ln3zIkN8ICOwSCbfXARYuCk+PqLVKC3CGiw1at3eGPTqnjZZRL2lcCB3dijE?=
 =?us-ascii?Q?7MI08ZnxU0xPBNGS/wH+VmavSR3EH0WtlKOj+hpB5Zi2TiFyt4qwhWqB6xR/?=
 =?us-ascii?Q?GeHOhunY+t9NH2DTgV/A0kuPgsFi0WWzwsPvBzuFZDdE0CL/kLc7zBlHG9kK?=
 =?us-ascii?Q?8A4usbfcN9aW+jizZCYkL9RnwyMBN1WHR8+tiSEoxXAqDPytkxBhkSOP9ujg?=
 =?us-ascii?Q?YYiGwNkOu3l4iBABPLaNF8HQ5QNzglJ1HT3X8ocdvl5hSAMLc5g07MEaVyfD?=
 =?us-ascii?Q?c8ULl76igoahRULnUjY1x7L14S716F5N7NsAlDvOT4JHLgq5CRxA59EItS/p?=
 =?us-ascii?Q?+bxJg6FdxAqLVETdgsHMVUMMhzs5stmVuFKq1yuxyV/WBOhaREZAsT0UbGwA?=
 =?us-ascii?Q?ZHD9TErwEXzGoJwb/LMsF+Fxkb4uKzgnqHCo2LMCTj5+Yu95LE3LSzkOD7u7?=
 =?us-ascii?Q?UddkRJcZXJ2zrR1OPJhn39UHGpA0AbkISyC9mbNSQI7rOhLFUnZer/BlCsCO?=
 =?us-ascii?Q?IuwGrbklzzTdFFYXRW0ic7RHFsNDqUlgaYemyuimbuBUa5YbU3rP6P2SjSYe?=
 =?us-ascii?Q?YjRtLpCQn3fPbtnG7xLW7xxD2NoO8wbYI9Feu/+GlstKlC0CyhyAB4IBArfA?=
 =?us-ascii?Q?TIa9Sj7HAWk58yF09UsrcVPviMlzudiUqpVHlrokoX9hYSCbIu0vB7zmS1wl?=
 =?us-ascii?Q?1zsWIB8ddzlV212Brrb7d3oz499sGWIrHDUaROHkYJ85Vg/gDs2V4Tt2eDDA?=
 =?us-ascii?Q?tVfdPZg0BrQH1t/mw6Z7N93aNU5IVnOhNe0o3TcWMVCAug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EYuJ4YoyB3ao7W/cVgrG/rHW25x+/D/F2kAANiWXXmBqZVg1NcfPzzlcPaYQ?=
 =?us-ascii?Q?C5l4GSO2zsjbbx7l2YAjU0nzGuD7saXMWx9eIwB5xT7QKPkJ4UoBkvXiJBld?=
 =?us-ascii?Q?9ilVcLXPuzsIZvAGTwoJB+4Rabzpz/gQMHcYnvN9665jcoNE5wb4/Nomatwk?=
 =?us-ascii?Q?HHncMzmw0CjDWk1h4AffsZkHaDqeTGRe0jGune3NFAsSMW1kztLn1hknUNQ+?=
 =?us-ascii?Q?FePvIe4Kwq8MUsr4rezhYbL1yOSwHL9++QjpY3+IsyCDbOCSWnVQwoO9i2Vo?=
 =?us-ascii?Q?Cv1fUco4V21SB7M0piiXKRUk5yTIbsfxaxdV31HDMv4eaAkUzbRshlHkLY8L?=
 =?us-ascii?Q?REt1JxdjOYLzSfr2T3Px5j1r/A3L1NSbZZVw8e4NWFSAPKpZZ8Xm1a+3O55s?=
 =?us-ascii?Q?dEn3NoxG7jKogOTGDJCh6cMf4UUDVK8Nq6lZkVCAzN7mcHhmQs5aorgIix06?=
 =?us-ascii?Q?85LqOJ/9XCC58dSM9WorceG8e46yfuRcLp8/0W/TV+MgIaJB0KQ1+r2tFm3m?=
 =?us-ascii?Q?TRQBlREw8UeWwDdUyei3vDUJqBANiUm9rrz5V8RCoXiZptl/L48AOYw0HV9j?=
 =?us-ascii?Q?vfDaXUeo6i6Lpy1yZwHeQtNyhStcmgX4lsC7yEXogUcy1NQuzra1bDt4Q1HG?=
 =?us-ascii?Q?NMRlDy+pWFpCJqU/DNkArtK1XPh/ysYwkac07VDLT9NBhYkgZxN3O551Y2Bb?=
 =?us-ascii?Q?tgus/ZirEdJqVIrExXrE4bh15W8zeVwEreRKRgjfLaE3S2ioqjSOg/if5VT8?=
 =?us-ascii?Q?oRHxpVXAu29DtWQ9+YPMSw1GQSyOSXIscg6AdK8X3Lm3S7NwcNNRDceM3BrL?=
 =?us-ascii?Q?PGwpWCiHGsqUAIIiRiY6+T7NTN0f06Tac0qQWy1bZoOLZgHMK0r57WQ7w44n?=
 =?us-ascii?Q?S7DYKR2bW7QOz1OaW/p6zl/k1/PhoLTW2HVdARP9hs8t1mcsB2xmVMBIqBbV?=
 =?us-ascii?Q?iJxG63M6OXfuSgCuy3oYQm4NABWXLpK6YIwkcx0d1mfM8uOanhVHaDKbt8Pz?=
 =?us-ascii?Q?UU3BIbxRAh3AvZcYmZyJ4mMXDRzmycurOXXFCcqCKu5eV1hdkQB5+ZAzzYrm?=
 =?us-ascii?Q?NS0tjdwiWrkPhx5ZPA0kk/iYHyG2zHSBl2X0LfupoPc5rWZZNhug6sj8LKCL?=
 =?us-ascii?Q?j04Iv33SwxNj0batnI0FtcJhdEuUhpVvx93aqnZ7tX1xqyA0b9Q7EoQpe+BT?=
 =?us-ascii?Q?/tlwzeEMuxdwu1uG5WYlOvu1fLp+OwqixWmyDBmMBM8Ec4n4kTrKke2RpQUU?=
 =?us-ascii?Q?GKERNHhJ+rsAeNkEAEvZ04oXa9MIfxFsMNx8/bx2Fs3LrCvibi6CgmStpDMo?=
 =?us-ascii?Q?/Ac93VUam4STRhk8b5nWjfq+5l8N1A1CEh6hR/1onDBkOZnNtNP6actC5+NQ?=
 =?us-ascii?Q?VJcui+IDRPi63poEhD07WGAlJQ7c5PN7mCGi3sH36JldRUMxIDcDtY3tpQ0q?=
 =?us-ascii?Q?B0WWi0zWfZYH+uzWOahpsuaajG11qk1CJihZprzAJs71mkVdPrOg1Ts7GNSH?=
 =?us-ascii?Q?7G3NKepoA/ziIOxp0MxodqACDdnZljKdIavpElGWgg+I9w3U/NkK7bYcIAkn?=
 =?us-ascii?Q?BKlKaYfFsBR8UdFCowC2uBNfl9ZK3lPEBZAR/VPZjNroY9H13S5JzxpGa7Q/?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 420a31d2-3109-4577-f35c-08dca1e58e3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 20:10:48.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8VYNMheH+OzKKeHtDB7jMQEfaHhlmc3Blz2cYxIzF3fkn178/qd2z51bnw2ynqrMY2mjk1Rgpl3vWpnJMiR4KIvxsm0MzaBaY6fE8qfkCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com

Dan Williams wrote:
> > I realized pci_slot_lock() has the same problem. I wasn't able to test
> > that path from not having a pcie topology with a subordinate on the slot
> > device, but it follows the same pattern. Same thing with
> > pci_bus_trylock() for that matter, so I will make a new version.
> 
> I can take another look at that one as well, but feel free to carry my
> Reviewed-by tag on that one, and just trust that I'll scream if I notice
> something late.

Disregard, I mistook this as comment about v2 rather than v1. v2 is good
to go.

