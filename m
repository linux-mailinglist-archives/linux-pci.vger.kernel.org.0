Return-Path: <linux-pci+bounces-21865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E4A3D013
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 04:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64FC1890F00
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CC2AEF5;
	Thu, 20 Feb 2025 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnQ+tEYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA518DF93
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022123; cv=fail; b=kdNDTSQ0msHrDMlDtoGqp0brO2R+IrEt7wkm1z/+Ap0RbE/Th1wyNh2k7CpRMzOgGAANjZiryLqNi/0ItT94eJAXzh50iCYQUc/jI8qqgWjQXMTq9hZe4wkBirGjCHOZ5mNFyhy9a+5IJz1zF3JcJK4motkBRt62PBv+k/x5QCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022123; c=relaxed/simple;
	bh=uHH1ALaTufKirhNugKr4uJi+XgJ5eQvkflmJYykGpUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qpVQLn8nlin18IEgHn4S6gDNQMTfl0Y7UpSlqe2ZsMwLboP7lE8XmPXt1RFo5VhSU+MHEupOPfHGNocO/2WA1kl8eLcaG9VNPkjlQ6NA49oLVkvppPnK2/dmG84xZKbcDlGtwAJEDPGGkx1092KyGxC+sITnRWjMFBMlmAyrUqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnQ+tEYJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740022122; x=1771558122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uHH1ALaTufKirhNugKr4uJi+XgJ5eQvkflmJYykGpUI=;
  b=FnQ+tEYJ7uVN9VjOUQMh9q6TriHcWXEykrbEt6bBhaHw9XzOoyzasjQ2
   c7hiklAilBOEIhkvbV9Ox4bsxifnzDM+TBJU09rufFr9g3FhpuLOR3r22
   NYQwiqBc4gG2iKdBPWg6g8QoUA3op5hPHTOIf1nsqO/n4B8b3JtCL99tI
   0BslO1O0Hp0poIM3nMgQwPSIJOPzMZwjwz87r4eNvEO+1vc5Ye/w4SoE5
   +0JQTc96SWpWm+hX9/q67OEblmTMc09pOMfG6s29fZ75R7T+Sa4zzsHbl
   KwWS0fNROT3zqyW9ICc8VEeFwC1bGKO5iJWiS/0oZQydOYTiTE7dVg6oO
   A==;
X-CSE-ConnectionGUID: jyz9CU1DS8KjVwGGs+Y/uA==
X-CSE-MsgGUID: FoY6WvxISPWGQGqeeRHH8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51768480"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51768480"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:28:41 -0800
X-CSE-ConnectionGUID: XzlWgNTXTjWK/mTvNexcGA==
X-CSE-MsgGUID: ZrbVNNhTTbuLpmSTHWXhVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145798650"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:28:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 19:28:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 19:28:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 19:28:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzL0FOZCewq7qj7yv8wXLbOa4Byp9/wiQKT2gp+tdmS3nP41U7FCVzAeM8X1+KVsEsAS0bK6X0AKzQ7OoqzzEEHY1/UXPctxL+ToXTW7dZGba90Lgl8HWtK11jrkRtb7D6QeRais9Gg0BBLKJy0KdoVJ6aOYmoXnbTaCYYB4vYO9yxUioIbG2GDBp45xtxCmAA7ljjOSRUj3sf19iLXWL0JEz+NkoDepz5+pNa6fSw7+aCiAg4WjZtD+P75t+Y5xZ2Ax4cE6r847FUCOfb5jGCIP/JHwMUczW2JQQ4NYXRiMPunV7bGy8H2rINGA0QJu5ZBXD5TG2fo2gyfil/OwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQye1+ZLGxaPfUcgI2ysssVFvNg+CL5R6xuu9Wl3sRs=;
 b=FL1FE3j2gppjCJTztvklGvu0Z4TDCh2HTBJnzuXow6d7tCHs1P86AGDsr0zo6gV9KmjofLqKZzZmM2mPZ/yBO0VSangavDbQbYf5hCpXkadPZ6DBTBtr/g4AJ9pkb1hS5MtRd6rV3Wgzi1cFv6GA1mhTSWGMEGsWACCCfsb4Q0hutSBhcKmsyTBjBcqgYWu6hnzCEsYpVP8qWES8TMLM4mMJEscKj5H6X77yCxTNK/AFtpkIdrsM8Cst3MeE45zkZx9R34woHN+bCYy1vTolU4NIjh2y357xikpJwHWLomRirPaqoKN10bHgHKRrbjdzywgIS+IomnF4paCXOu7Lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 03:28:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:28:37 +0000
Date: Wed, 19 Feb 2025 19:28:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67b6a162bfe3f_2d2c294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <yq5ay10oz0kz.fsf@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yq5ay10oz0kz.fsf@kernel.org>
X-ClientProxiedBy: MW4PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:303:8f::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0608eed6-6c88-4d12-4600-08dd515ea991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7BGhuRLGhLPfPbwzawZACbObgFDySm5qYaObi/z510hbPCpiNDeejdsuTQV?=
 =?us-ascii?Q?rYGGW2TEW3F8gfW/ubHs4+lvxQMbjF/hLONgH1mPbXZMRgzH77ikDr7qM07E?=
 =?us-ascii?Q?diAT6scQhyypw5zC8YL7m1OMPwAu9dPzA7VGCCVUixLFF6mIMgkFxZADulVf?=
 =?us-ascii?Q?l4MesfRhUyfDpJ4YbQzNuWkinhOkFs9vcmhIb8z+67kengg4HjjtAF0+jhvq?=
 =?us-ascii?Q?FyLmkpon8uiTqWvy6j7qBK1FTTT1NvaD8wpMzL/H1wNp0oLQcGADz/z5yhgy?=
 =?us-ascii?Q?7GaqUXVP9ZYiVXhaH6dxWE8eTa+V2K3+kADTaY9nUNc+terfXyjUXBRPoysv?=
 =?us-ascii?Q?HgMdA+DgxmB1yMfK+siLG7k8iz5fTtEAAKUj8HuUeCFoKM1tvekfWKxUf50Q?=
 =?us-ascii?Q?Ez3MS/BisjPEZRTXNFYFBQcQa0raAeLPblHttUIho1khn6u2pL6Hxfwz3Tyc?=
 =?us-ascii?Q?V3hJH+FrGywwSCNjnrZDvuM1IAmu6C4JP7cqnzQFsEz4HxDic9MSEHKgOIV8?=
 =?us-ascii?Q?/WEFVJYAPhfUgLb0IzS4vram4yXZuDqCSabocVF0BEPhYGHW7K9aA8JYIicI?=
 =?us-ascii?Q?nO5+KH0A1Ya/yXWsC7X8ovrjTEMPsSV8/gyb6Z62AYCJMTpYlTjg+jGJnmI4?=
 =?us-ascii?Q?ivix+vSwvuXE9B5bCfVEy6azdKmAM+VCZGYy78OXGCPSfIotOIkq37q+fqKh?=
 =?us-ascii?Q?xbLknLNI4OP/xMSHO1CuB+GNfu8MykxJeFenJY7ATwSZRWSOiXCz3CmXHVPi?=
 =?us-ascii?Q?s24Pr8ThhyRvj21MLgc1pKFQe3CQSY+cpx3Iubz4TM3pNc/04IAmwU/JVZuX?=
 =?us-ascii?Q?yg5inXOMFz7PW5mXoM69TUg+LPHDqj88F0P9zSiM+FhC6ZAJ2efDtWOJfjSu?=
 =?us-ascii?Q?G40Q4g3/AJ+FUF00Uc9/oJ9WNvdXDznhRv81KNug7qZxOyfVlavVfsDkh+mB?=
 =?us-ascii?Q?EvqLTl0x3jhBOY703KshCEFhF9KkewSV1yJMaGPucT2W2KO+L5ZDKctHrg11?=
 =?us-ascii?Q?h56RE6K1MdiWmp00jzBRtj2RWgiuiFHtMr6YjhNec+/DW/BCaMsdeT1unYdd?=
 =?us-ascii?Q?NN6PEq3ZraeDVJc4QdswXCnrnXhgxMvJJHdf1xbtOfG3K5YHi4y7PrWN4tvs?=
 =?us-ascii?Q?BV9pWwMGB3RQ2s3cY3OxQCfnHIVD3Qridm+kLQJA4Ivhs47qZfI8JmNHACuG?=
 =?us-ascii?Q?sKOTZCiqSdCJLis168wKpUjdad67Kq6PGAf7sgX9H+xk6xSgQusgcXVs41Jw?=
 =?us-ascii?Q?n8LFbXLtieWBeVQXr7ooJm8I5iA+zqqOHzKZaoTriTpZbbH2ptXBaVzGLkXi?=
 =?us-ascii?Q?eJxgZwlC6O+QTByoyOQ7XpIDouZ8NrD+ZvAf01B6LtKcwXKeAO3+xjNqoABK?=
 =?us-ascii?Q?ESYMmDydWWWGzdhpMTkeFUWTKu4a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TC6l35ALoMkRBSMmxraS5VbCYcXiNaFEzDZJJgGrr+smai1r3Wfg/ebaWa0d?=
 =?us-ascii?Q?GfAGtXRQ065uWI0m1IJyiQknctunWROop4WGtPDk+YWGlgM057udtQU17oVk?=
 =?us-ascii?Q?Jk6r/vTXn6eJ0r0yYof1V0jx1JBXtyVX0JcSrPjyLJ8EmxCCfrq3XpticNOk?=
 =?us-ascii?Q?30HpNf2R0R0BaGW+7lOlCXIjC23Eb/BzeUlP5IzAPf74brqNxHWlVsPgjREE?=
 =?us-ascii?Q?zcxKwnqoMAFqA5qD/c3udalPpHZ1j+yI2RQOBGW8+7cZtZl+MOCuVsXXSCwk?=
 =?us-ascii?Q?itVAVO5jyep2z1cnU3Qm8dmtCePqUSvB7vsrwa9IuA+3K0Obg6Zf//5qztBR?=
 =?us-ascii?Q?1oglU9O9K9itGJ1/6u5+AV2TOl50Mf+Jx5voYTBybx6LTGycaUE1mPxC6219?=
 =?us-ascii?Q?wl7+mwmAIAMHv++1h5QufxN6SC2u7biJ8L01BpBG21k3PCvJ9sIw7oZyVoLj?=
 =?us-ascii?Q?6RG+hJYo4NMiPmrzJUu324G+94PeWZz0vsknt/8vs02RNiFb23Bd5dt1BVCI?=
 =?us-ascii?Q?g0O7520cgwkm8F9qrtgI4JILLPMDFlSukadZAo7xpyTPOXzyaPwU08oJkHYi?=
 =?us-ascii?Q?nEyHGsW9yz+dGmT3kcGuhfSdPEpY+tilff9NRqfXtEE91hPXwR0NXTwbVn8n?=
 =?us-ascii?Q?A5V98iceIG8nEmIUtphurV71v5Fzs4eBtxmtct+7+UhnE0/XiLVIvofGuwsY?=
 =?us-ascii?Q?LkPXE5IUGy1rQQy+VA660bOb2OaPfmCsyomfm7GF9FcFnnZ2OLVPeSrQd+cg?=
 =?us-ascii?Q?6k4DGpxHn54IouBoJEhx60jPMi19t70qdlD/DSz7qkr+t80L59EvXCmQthuf?=
 =?us-ascii?Q?+vMbXrMUAzxOomNsTEJpe6R/4OXJo56cWioibzTyVdnsHj2tJnRtG/7XH1YR?=
 =?us-ascii?Q?If8knAlsJz0Lc8eFQCbz+NWbWnGmHSGqMr5sE+Wf++z6Vzf3dm+0pfHBWPqC?=
 =?us-ascii?Q?q2OzJVnFE/5fA6MyGRAW29JbM+EVgOpASEpvuP4VK/W3Mv2ni0IzqFfF34Vj?=
 =?us-ascii?Q?xBDKSS41bHaNqBtUAfcdemAbzlJAhCAqKuhx17fhubJz1jjZJsiFrx+kTQuQ?=
 =?us-ascii?Q?r5ptOxKGvUdnI1tl6w8q9+nxrCW607HLXFaAFsGkrHZomuyc979fX3XY9oD/?=
 =?us-ascii?Q?aZQeE1Zoh4z8xcreiE9v+v4IIZmIkEvkn9cSXnct1DmgW3yr6ACl/sCbNWrl?=
 =?us-ascii?Q?XnLQ1XYsT1ONxtt9KO9e6uZ4LovGCaBJTCmx7wNSa8t8Oe4EasIV99s2bguF?=
 =?us-ascii?Q?ckeafRFbDZG+mKmjdNeBWClN11yQXtKVMFDMWpEPoaLxIX8lCIc26cgQEExd?=
 =?us-ascii?Q?KJMdnS1Y5qizQtLaLlhc/ZHEhCHosDvRtvKDIBxDxVOXDBMf1NlQzDdS02fA?=
 =?us-ascii?Q?s31TTrIdGphASOg+P8IFA+x5zun1QC6Ab/2ckITe1kFWPGjJHP3rVsHDkFJN?=
 =?us-ascii?Q?hkkY6FA0+cHg3CvibIrQclvdCGA/AvvIKUAESqguqpw/Z2ZiGX+oprKaCxjL?=
 =?us-ascii?Q?NB00cK69Q6q1q2uVSv8179EtLWcRbts7pjnAula3TdYTp4xMz2hlwSrWVV9i?=
 =?us-ascii?Q?CpYJN5vcL+JaFM/JmgeyPvw0H0jGu2+W1BpvRDpghczPlpfzcx5QFx3TlFAg?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0608eed6-6c88-4d12-4600-08dd515ea991
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:28:37.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUjjpKTFCb6/WorYOb4R1vKkG4gwFJNCPAMhpxj1GWuZtpgF4WI4KXgWsmkXBn/mKRBWIZxiacubEIMpqvP+PSGRkN69db1rp/RBo8pubLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7364
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> 
> Hi Dan,
> 
> Dan Williams <dan.j.williams@intel.com> writes:
> > +int pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide,
> > +			 enum pci_ide_flags flags)
> > +{
> > +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
> > +	int mem = 0, rc;
> > +
> > +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> > +		pci_err(pdev, "Setup fail: Invalid stream id: %d\n", ide->stream_id);
> > +		return -ENXIO;
> > +	}
> > +
> > +	if (test_and_set_bit_lock(ide->stream_id, hb->ide_stream_ids)) {
> > +		pci_err(pdev, "Setup fail: Busy stream id: %d\n",
> > +			ide->stream_id);
> > +		return -EBUSY;
> > +	}
> > +
> 
> Considering we are using the hostbridge ide_stream_ids bitmap, why is
> the stream_id allocation not generic? ie, any reason why a stream id alloc
> like below will not work?

So recall that this design is meant to support both native and TSM
initiated IDE establishment. While in the native IDE case the kernel
could just pick a free id, in the TSM case the kernel is told the id
that the TSM picked during its IDE establishment flow.

My expectation is that if Linux ever supports native IDE then
establishment that would be modeled as just another TSM that just
happens to be a kernel software backend rather than a TSM provided by
the platform.

For now this function just sanity checks that the TSM is not handing out
duplicate ids, and to record which of a limited pool of ids is in use.

