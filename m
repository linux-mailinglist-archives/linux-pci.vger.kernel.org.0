Return-Path: <linux-pci+bounces-26634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F504A99E4F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188155A5034
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D8153598;
	Thu, 24 Apr 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXTmHgVN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5778C2701C3;
	Thu, 24 Apr 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745458455; cv=fail; b=ljpUMka+F64crAYQUqBbeCBosrKqeQmYTRvZsA0bEl14QdBfjavY78130JM92NG7Yk799BbJmWlYfCk1Llw6t0UbwsBmE13xepHRoZjRYQa7Lf03+vYyBaP+ily9Vh5hgYRrhcS6KtHOM9FocBODXQs3FmXPkgOwJZR7hS8EvYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745458455; c=relaxed/simple;
	bh=P+Nd9TaPPjqCkYkaO9XxKeOa5oKSN+7lokfkVdIrpjU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kb3RfjXukUdmqSQMikcu8+dtaT0COXTyEozMu7CWmrcQ+3xpFSDKkWFA438Na7/XvORMv+2z8vc+STBQG+ymmuUoBn3KERA4G0SoPLL6/kLaf0bNoHkOQzIAdJDSTHXO+IJkIZHyQfFrNxuzz8Ei0k54I5mUBY9e9oGlD5NMFn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXTmHgVN; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745458454; x=1776994454;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P+Nd9TaPPjqCkYkaO9XxKeOa5oKSN+7lokfkVdIrpjU=;
  b=eXTmHgVNC6tmomIM3Pxe2N3OFxfUOtRa6T0dfYFudyFGlRiO/SE5q+HD
   +avIZ8IRiGp79Ux/7tQY5x2Ob+u75Z+yjtc/ZGzRUKLU8mmQVQ63M+YYA
   EHzh08vuA6j+yNT78LRtPMCTGa8ZGpE15FnVcNmq2GbVZ6NGuNYK2ADPz
   8osqXSjn2A8qSTdZfmDUwwtYHPq/o0izb3dwThAQK5voGlWduzQszKZ39
   zErg47mH87Fek2gYtWdF2r2O1hUUjx2zodgrn54ekIpPmIvU2ghVFYjrn
   97gp2wcZbpykUU56ZNn+g4zigs6nuSKz5GUULT65hojmwevz5aIO3xIA5
   g==;
X-CSE-ConnectionGUID: OSQyTJBWSBu5sHjWsToBHg==
X-CSE-MsgGUID: wNYwTa+AQp6RTzLcapooqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46781199"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46781199"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:34:13 -0700
X-CSE-ConnectionGUID: 7FNgschDQHuvsH0KhQRUbQ==
X-CSE-MsgGUID: 2DCvaaX6Ry+rkNQZZUHE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137326087"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 18:34:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 18:34:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 18:34:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 18:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPqR0I0QcAWChRPLK0bTTlXjaTk2JVEYU1Jzvws3mbpPjscjSjbJC3DUY4f5oCnsbQbTE35GYLt50B4Q6D5hBn8A9XsQtLDTvWIhL9QPGnmLtLnOV7sFtGTWwSLZljm26RITqDlhaLwxtvAWNPYlCEs/vY04bWQ6VLQECQ2jMwXwHn2hy/UODZEHcB7MMaj9kpNZyNVFJZzoY1yjl5Igu6uCAlj1hMeodApLCyW1aSyx29iFuasVw3MbwGzi7w4t62PWN2ZGzFC6ImTcZRLNYbyyg2IDD3AMYKHCfvnQgxx+VD++E1npu6vISwk571tNKNy3TC2Sh/UwD2RjgCo8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH3Z/MAU+qvOC6B0adDtMtYuS7MOTUfMaa3G6icBuD4=;
 b=Nz2vqKkdtnm6wXkU7vrOISmkW4HteYoGCUB4mCpvaoGnGIAA40ke8s9Fozl7VkVSfllUwFA7v3dnp163/ssCjHMZBCH2W9NEwQA640yZ4jFxsJMAMHrohYml0c4yZvJA9ajf087dDT5IDxWP+2ggu7JJsHjxqhBKj6eALnesPWVvUOuaTRKGGQSN9EZCY3IIy0F+pPZidAlLYE6woK2kSrr2wJgp3ovlDRKRQ4BgomNeyCPoxGwaJ462Z0PIJ4FY/TqW15Xhlsk7DWXh4gkeXU5OOjKPpChJFfcTaylIvAsWnEAQ8kPlT+pRcgYg3t7FzjCMyaiBFYuTdTlePcgtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 01:34:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 01:34:09 +0000
Date: Wed, 23 Apr 2025 18:34:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, <corbet@lwn.net>,
	<bhelgaas@google.com>, <kuurtb@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <vkoul@kernel.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<sanyog.r.kale@intel.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <dan.j.williams@intel.com>,
	<andriy.shevchenko@linux.intel.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<Dell.Client.Kernel@dell.com>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 3/7] docs: sysfs.rst: document additional attribute group
 macros
Message-ID: <6809950dbfbcf_71fe294f3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
 <20250423175040.784680-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423175040.784680-4-david.e.box@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a18593-aaff-42c0-1e9a-08dd82d01bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FXdTPDaYFWfz7BF7P4GoX+qyOshHOloA2whHni+B7A9Py97Tl3sqqVN3NNOa?=
 =?us-ascii?Q?eB45ezT2VhtTtqpctmHVYSJnM7Mgnf/KS/YAof2dkhteSqm9cgyHBplhQOHw?=
 =?us-ascii?Q?7K0gS0IhxSxVbLhBor4eRSuq7Kp9tpmRf3LtIlDxMLWwH25LdUORkMlUc62W?=
 =?us-ascii?Q?93CU/AhtWKBkL4SmJEjDljJdgybU6cTTwliNgMJNGNlmGO2K8/xtqiGjiT0G?=
 =?us-ascii?Q?4kHH1dpT4ZOKS0MA4chS2fXmqSrJPulhd7HhN2PkomqTBNdyZvwIPjQdp2Cw?=
 =?us-ascii?Q?rRI8kOE3Go12bD+wdBsQXzz1dWbPWnp/wzoxmLC5vpCE9rACgpZZ3YITQWqu?=
 =?us-ascii?Q?217dqmBuvAN+mlExRmhxTOUDXjBo2uJVJg8C0eZ9fz0b9AwPipY5mfrTF8Qn?=
 =?us-ascii?Q?9XrjeeXPv01aytxryliTJe6ICalAYp3/H7lE/6xwxE2RhWpZdSy6wnaIoLQK?=
 =?us-ascii?Q?gJcOfBQvOoM7CevSNd51TKEMxDGWuk72JTzkg02aZhdZUXTlY2XybRZ202KA?=
 =?us-ascii?Q?DF/+uBcHneQ6QAcve6qIfsNEYfKMgJYTtJ0eR6aNAfcoasGSuz4xVZaAz/Qm?=
 =?us-ascii?Q?/g/Q7WRXmVuvGHvvOt+xtbhnWayBD54U+m7i+BZREwySAkKk54FPTFtVAFc9?=
 =?us-ascii?Q?qYBdCE0z+X6tN0GoA62u4npE2H0vQUxtDIiv8rVmLK2qpgwJ7IGtBsF6TU2n?=
 =?us-ascii?Q?zWmEsRTPDFtQIDXLN9ZnYJFzZJAe44AyEguxmuID9N2j5MC+XcyXZSh2zEc6?=
 =?us-ascii?Q?yWxFkV46y50wrBx2kXTBWKRWnYEk9gGFRKvXo/qQRdj8LnFEcVZBM6XN/7eG?=
 =?us-ascii?Q?q2/Cm+ed4S6mKRQLJXfgLMq96hvKGV3lSzbtPIqcVtVB2No8tbrYuQvHFt5X?=
 =?us-ascii?Q?QcVj8PJjiN4qmxr1q3z18GsIBWrfNsJ0zIm/q+onhdAXk+YOw+ZHUO84MWWW?=
 =?us-ascii?Q?FUmz0KU3ijTVhnedp3kLFluqmowqSRfgpJYYnQPIUoD8p0EdcuPfg/7BV2Qd?=
 =?us-ascii?Q?S28iz20nMjh2z3+Fv2lRDrRZ6HthvU4zqMkp/d2ugCiBsgYqSswfezOAOLEM?=
 =?us-ascii?Q?U7f/24bfXCsi0D4ArNcAnK9vzBqEboOIkZUvd4nDMk//dnOHXz598Y0FzDUQ?=
 =?us-ascii?Q?rRed0/81DVdi/fU+a9un1pOaEoza1L7Bb3cXDXuLshohLkQMdZo9e7d0h9rd?=
 =?us-ascii?Q?w976GqeY38r2OVZX9XwDns0wsfMMZFTHa6jtzGOq3ywUEc0MdUOQECWoqXra?=
 =?us-ascii?Q?NKR6oj/WQNYSHYXBTA5ge7Exqpwg/K16vRhFrbFHAlQAsjwHkyDt1Dcb7ceU?=
 =?us-ascii?Q?bWgwnbscBdXw9fL1AmLksTotfmvnaVx3/aZGrh6FWuYph/bf25vw1WPUPB8Y?=
 =?us-ascii?Q?iQHm+dO/hnqd4rDyCkdOmTlCJe6gDJ21P7Wy3R2kXdTy1+OJu+P11ozMaPk+?=
 =?us-ascii?Q?FNBp9wIF8GNoCHoL7whohJARPYd84leuLN0KSGmefIHhCLLY5kLbnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WasXv4lvTCthLmjamzV35Hp1yqiCXflM90DBNFvaer1eLKo9LKLM+dT+I+TZ?=
 =?us-ascii?Q?IViGYrttjyX0rXSTsv1BLOziuHm/zElH/VU1KziQ83ikBCs1eMNzCPGHeS3C?=
 =?us-ascii?Q?Y3e0UE3Pzzf3Fhknv2sd53SxgJTUgjg8e2udAOdXWAAz/hY0xV1ZcltcUDqq?=
 =?us-ascii?Q?S9L8gnQBUvMNJZwEBqROQwdLdPDriLiEvW2k3A0/jrmjxIS+TGNX/F3dXSKk?=
 =?us-ascii?Q?N5qfFzc8IIbzNEyv2np6HcsUmhouqzNLh8vKIRvCuypl2tEbmL5FHwhN5qd/?=
 =?us-ascii?Q?huNLThEGq5OBTEom2y/SkzauIPmjevroaq/RMnu75/5eQFbvMxzkriQic3gy?=
 =?us-ascii?Q?gJQax9jDg35IGKFm6kEeAZdExaGUVrtZvRX+V/gbB/DyeeSQsoQDgcxJBxVS?=
 =?us-ascii?Q?vDk1QFqGw+LdDSPeuRG08U6JLCspV5WoGgUNbnfm+X849f3Mm4HhQEnPD4cL?=
 =?us-ascii?Q?9s06sDlTUILFwkh8cGu3/tyRw7TcCizYPE54SyUh3a2k6bXMPCQ3NL6WqTlT?=
 =?us-ascii?Q?WjUhKZM5pMRSiCh3fT54benKEvzwacOEa7Kish2rgOTJ8UeGi8WeJMEptN0W?=
 =?us-ascii?Q?gY6CyppmuBZiccCPc6czB5CqfiDkSQfwoNLVYEzfL00kSeZd6fhpkMdRdfx+?=
 =?us-ascii?Q?Qf5YGj1Qui9k7vZgdpqF09XYyrbaRQwYi3ohZh32YVECNAxFgUOMO7QrellR?=
 =?us-ascii?Q?36kla6MerjUci+4j+Qshy7/j6jn3FIM8r4KSBkSJrFQKClsDKPzO9J8Y5BYf?=
 =?us-ascii?Q?tL40dro326xY5dCLKLRtDQR1CsordHBdwoCre3xtTfTmUHQa43Y+Mwfy4EAE?=
 =?us-ascii?Q?wbiPx7mBkUeeYfgkhPLGmSMytFLamoQDNKKPu1HahmVDvGOPEWSFnkUp9Yxf?=
 =?us-ascii?Q?ElkkVXvszRCL2IkP+1H1GSlWoCwJ1nZtyRxjb9/uWPIljIAogefSyxWjFkJ4?=
 =?us-ascii?Q?TF72OD7xkp6TIYZESnYFNsUu9rZCTfiEsTJbzxzIj5AUrpomyzUSVBbFarMt?=
 =?us-ascii?Q?56xYL4WUe/FRyZuTYU4X9GYjbDzLwLjgwa1NcpZy2yM4HUc1R9PjGgri0Wd5?=
 =?us-ascii?Q?2grTj+5zJAqJDenw5hxlSyYbZ2KhVZt0FgZycM3DHiLjfvc7fEFvowYTMDFv?=
 =?us-ascii?Q?llEITPGXjSizdCPc/Cdl8DcSrNVrU87fUvRktFUSFOhNRT9e/TiQ/YVY99K4?=
 =?us-ascii?Q?gi3ufExzoXoCbYPhYnHbt/UnXDuchgYn2+Tns7I2m4UpVlOxuyRGVxdkPNvh?=
 =?us-ascii?Q?Om0v7kCFZmIi/IzkKwmqPATo2rLbDaNpEipSkqLei52rJzm4bTxU6JKvVwG6?=
 =?us-ascii?Q?VycC2p1W28fqV9ILk+IXRLRvvWtq1X3P/dj/pJT4anhSVu3kQcIAUeMDiONN?=
 =?us-ascii?Q?g2oadd/gUqCNPWuBiB0cJ7j2tRpaziFJ9k/O9HIp4uXdHPFvGdV+0M4dOpeD?=
 =?us-ascii?Q?cJOuSi3AHwe0HO1ESlWoovjk+72kMeV5JFizCJCHslLG0a1HeNgWSwKMhNrV?=
 =?us-ascii?Q?jiG/HihI2chXRNji9gbUjqhnYJcbkvQ6brrbMQBtE4kPBYZcwkj5EXmpoX62?=
 =?us-ascii?Q?QCdeZfjCONG9INPt5RUyW7L+yxclFX1VChkbBjadOEOgWxS7UemFfmzY57L1?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a18593-aaff-42c0-1e9a-08dd82d01bd7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:34:08.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj8n1ZatfCv5+Qp/zy2yABX394p+brxZSWgR1AuvOnZo2fFwEtxhGHTsxEUpio+exdRf8iKh2MFiSK6kewMmQnWDc+s9EuWOVM/yyTCbvC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com

David E. Box wrote:
> Add documentation to Documentation/filesystems/sysfs.rst for several sysfs
> helper macros, including recently introduced and previously undocumented
> helpers.
> 
> Document the following macros:
> 
> 	__ATTR_IGNORE_LOCKDEP
> 	DEFINE_SYSFS_GROUP_VISIBILITY
> 	DEFINE_SYSFS_BIN_GROUP_VISIBILITY
> 	DEFINE_SYSFS_BIN_GROUP_COMBO_VISIBILITY
> 	ATTRIBUTE_GROUPS
> 	BIN_ATTRIBUTE_GROUPS
> 	NAMED_ATTRIBUTE_GROUP_VISIBLE
> 	NAMED_ATTRIBUTE_GROUPS_VISIBLE
> 	NAMED_ATTRIBUTE_GROUP_COMBO_VISIBLE
> 	NAMED_ATTRIBUTE_GROUPS_COMBO_VISIBLE
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  Documentation/filesystems/sysfs.rst | 244 ++++++++++++++++++++++++++++
>  1 file changed, 244 insertions(+)

Looks clean and useful, thanks for taking the time to improve the
documentation.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

