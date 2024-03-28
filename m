Return-Path: <linux-pci+bounces-5356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB828908D6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 20:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32850291A50
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12CF137906;
	Thu, 28 Mar 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOB++p9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822F5338F;
	Thu, 28 Mar 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652606; cv=fail; b=t+LZGOopSroLumskI0Nz4F7NoUajgKX+ai+2esYvbvOepBjASxcieqkrJPTyF7wyTloL1Nti65hkIyA3IXG7QzbtQp35KDH7CEahPFFDsUPj710dYHzmPWGYatXrANRObOQmOUnyVEamcHQ4sCo1DV8TyYi9Be4xJGchiKqIfDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652606; c=relaxed/simple;
	bh=7ImVReZxdw7X0XgbssCxkhzfQAGYcU/TeiG+g1Sg6EU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oPiSjZkX9rkLvzqJ6+Sf7ZSNVkzSn1O+DL1HVZddMvNfg7GkHTBEcLztWdF0yQYvfv/H6j97cDqixgS4j0LV8GoX4nY5ZcIP0UN1U03lhDajXkQ7j4xhQGqUT/K+YHjnh4zCFnhNfR26vO5m0fy32bwiuTp8NSxjo82knKxbODs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOB++p9R; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711652603; x=1743188603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7ImVReZxdw7X0XgbssCxkhzfQAGYcU/TeiG+g1Sg6EU=;
  b=mOB++p9RREAu8Gl8yYlmca+pmta2EYBJShQhxZcf9oAx8LpMI7xyxsH1
   gY5avwPLlL83oiabmKvK3XIwrP2AfJqYpJhMQWtw2v/FG9VEdI4z6gdr4
   sO2WFklqEN6Fsc/6gfKt5ePELuT6P70dAY5VuxaADYr5P7K3bp98juYWr
   pUTvxKNuHXvX2E3umeWWT60qzJKdv8H+fYJYRG2gO5lwuIobgKyDW8GRx
   gcdQQYhBcoJQTGemVobPxtkpNAN5EccJMPgJMAt0+/KEptzvihoM8aeUI
   pTUlm+e39e31aDqhxPb4VPOhwDT3zUVCEe6/lzJtwfYM76MmX0ExWMjw2
   A==;
X-CSE-ConnectionGUID: LSgUOmD3TWKIpjLI82xkJg==
X-CSE-MsgGUID: C804xo/+RCKIOFRq5d8wJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="18208874"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="18208874"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 12:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21246602"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 12:03:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 12:03:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 12:03:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 12:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+yAWLdZ7N63iF/NpvfkyoB9NZrLNmgmFQQbVzoCbJ9jPnBCKCKTG+1fAeltfEFY+KNMgBHE3rBJhEoJPmd+80wB+ij8HGXiCJKTbSd3fSyTO3vZSo9NSZTUGyhkzi6qU6rQ1/feMrDytCQDqfJOg5+IkzBgoIdcoqV5X6LJpEyLlBp/hvMEbwhvUnoSDs1Fc0Aw8X0LlfZ96oau3C2Hi3koiGQNVaMZuPo7tbACBSnx32kIsekAjg3H+hmBCF9dFejLDq7bMr1jAvqyLJUDcmW18bFvlfRrraz4cPFeomOSxWQKEMR3ksLPKBNzzia693pwDMFLQr9u+TWrlhepwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F58mWd2c5GPlnnChffoDxDxHMKfrDEdVu1rHAwV6iBQ=;
 b=P9Dad9QQzp7jc//9OW9ChtSE33ZbkbSRTt/3TtuNwrJbh434jH506Y1Llm7JNiMeY9cFIwc5kyZVfKF3wAEYxreiWopRiTELnCysiXvrfsVC/9G0CHHz16Q1KRu9wAV1IwCPHsIbyQkZv7TeA2CCzMfmwKsBfwJ3dATw3qcdY15zTaVRJHGZ6U6w6imDylTKlaozxIe5Y5nWfWo6xokbhOO9y/NuklfhSKn1PvAXMTvo0uBmtbHKtr7QjL8yr3KwBYOyKzElTteuhA3Nx068/X1ZUdb5Td5IeVhrnx9Jm2vre4zV5C83eRjpfNg4gxfUwViImDZ5hwDFSAY2a68Xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7162.namprd11.prod.outlook.com (2603:10b6:303:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:03:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 19:03:19 +0000
Date: Thu, 28 Mar 2024 12:03:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>
References: <201384aa-a7a3-415a-9159-a615e8b3cc53@intel.com>
 <20240328173855.GA1571809@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240328173855.GA1571809@bhelgaas>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7162:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Nvp+biYyE/aKxF4KxLGs1zBNIAOkXgxLf0qoMiSFM6CxZtbnPEAdZJWaw5QfMv5hlaf1SLB8NoVOVs/DcaxSlS0G1I3dTkaaxKggGvyGem8W/wT7mQ7g2nPn2oiREq5Ks7Zwp8yfM7TthZtbyTTAPpgW8hrJGrb7oqTRNQdUNxpBj7NuQcClUM6kCxbuzYQN/VHAFAQZIprSBPsUzmfwEmti3xv29JQzRvKewZAWZyNM+aV/xFtzhLi6BZhAbb6vEupc6krJUVjlRW/b+wbES6nwwumZjgG/9jY8zTwxkv44xvK6UFf0WkSsIeAz3d/4lMWtob2SHsX2rHMfc3g/zmj8Kkqag5weacQIiivFDm+tasp/6+whiogaOJF3P/g6uWMHJ8H1DtFBItIN/Ka5Mkw42drdnPMCxo5ewEpEwn7Az6ojiBBhuWDd6jdGOQGmRrZhtnwULeYr0JPqARxdGUl4HEWkAaEh/4oVJNrZQhuIxPFUgB68YPfyunv+57Cwqfa/AMOU8wo7C/n0hIDbPjQmCm9tlhsJQp7wwqBVjUvAYVTVIjRPnFdTh0aamDUdNlp3R3+C8In/F58cZrrAPNWcRghqzYVAYrI4W7A12I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQC1bxM+f79G97A9ZqQeaDr3c7AlTttp3uoI+OJiBEo47gEXropmFfSFnJrU?=
 =?us-ascii?Q?V9m0cJ/ORCdeA+yYuvhP6zZ77T1DX2jBdJ/GbVdcetIMsvxtCdfy3sPHfHuH?=
 =?us-ascii?Q?rpKUrtFckILE/eowta1kNR7HbRxPPbIF/617/sRdeVvQjPVh5GIR0CVisZOc?=
 =?us-ascii?Q?EQa0285CsW6ic1jNoXuzm6WESo24JYAtWsQggzy1QIb29gHlGUeJu0zWn/wg?=
 =?us-ascii?Q?/iqYBRs/sUP0N6ZJYmNnWEooelL9etKZjTMiIkICu4wM3GSdELXFrJf5boGj?=
 =?us-ascii?Q?72Fn+/E6431buEgbAai+NbiGD0DfFpGJf07OPJPwORzvS5a6fe8Ks+LZI9/s?=
 =?us-ascii?Q?L2OP2xSwmssq4BLC5tK2Gqa+XPmVSYgxE9FSr7yCQi58qDBu1mfHku7z6xEC?=
 =?us-ascii?Q?LWThZWv+r/gJfPDo5b0+gZ5i8VMrMCBibRoWaa3eMR67zBvEKOrrRJAydgCc?=
 =?us-ascii?Q?Jpp5oqysEsHcWfT+BxL/Yv7CyA4Oz+eGn/5f2eQk3y+t6vL0w7AGlmxjE7pT?=
 =?us-ascii?Q?APADCcZYvLhsLX0pMvxTiwRYRLyRbI9LLd4QqLGq4VtEsmkadv9YOc7MFueE?=
 =?us-ascii?Q?q2V8EKwaDEY5q+nIZjaLwFZdABMm4FRa96iqF40araKDkC5GroXNLID3+SS5?=
 =?us-ascii?Q?P+aaC4ynLMSTz827EMR71xc6FNdEL2bITjEcLoB06CwlQulo3QUXazan2pCZ?=
 =?us-ascii?Q?24jsbWrc+JrwTgMIakbNsiA9lELeEifMBJePkDPle+kwK57RPdQWryyi1qad?=
 =?us-ascii?Q?ZAWv6h2/0byJY8ElHWNPeu3o2AO1EI9p+zQAUrQhtWBhOCkUjHRrYyIWj4zV?=
 =?us-ascii?Q?TmYB2dpnV7lFCCziGfN59dEZj0CCXu682KFgHQdubXoj4z1w5XdBdol5lOZ3?=
 =?us-ascii?Q?UtqR/cVLjyr7N/cWlyrX+wcTFhkaCfDxQyXGLe4O8wT0ORumh3AgBwCB6zuY?=
 =?us-ascii?Q?IvWWrQmS+0w33M4m277BIpPJHW2K9m6oPTxkLAA4ofdHy5/G0uzM8nt3PDvU?=
 =?us-ascii?Q?aMZQFIGMihg/aAvkM6WIT7hcO+m9WSVIn9GDhPw3HYVh5XB6PFqoVrZ4WnmG?=
 =?us-ascii?Q?jQHqvQ8s9HJcMC59t/mk0QTts7ZRhXrjO6g4QdfheKJBxQYdfJsbKrHdzjd7?=
 =?us-ascii?Q?PzN0u77/hKPtfyNOesdU4vha6f8iAyg6ZJsbGSqvZykDKYBHO1pFaMqR3+Vb?=
 =?us-ascii?Q?OYhrCIpV3RfenjsL9XTzG12Y8URu/sMrlh1wMtUtEOPpNP7KabnJSNyGd50G?=
 =?us-ascii?Q?Ti1diQvoEu0//gWyDF0R7YExjvi5keXFT1ZJl8WKBtXzdTOn/uCRoARfliM3?=
 =?us-ascii?Q?J3iMMwftbsQVAAcIovHcbH7P7i/KihsMMP1uO0EaTbakKuC3oDAXYHsc1Gn8?=
 =?us-ascii?Q?r+fc62hcySpnd/GhMNVW5RGN8Rf8RPjyAvLCe0Cy6bnWVrE5APixs/FbxBn3?=
 =?us-ascii?Q?R9bHoepuvrlbnQ6xvk0yXtoCs3ixX7RzDcrfm9hoTTGryyUGGkbgbSXENha4?=
 =?us-ascii?Q?96XhoRJSdmknJ9v8YEzQVKK0cXlLpmBYHo1nakv/niCVgJCCmbvzRhvt5dWn?=
 =?us-ascii?Q?YZd614/eVlRWhHW4eBwuBkKvTojRthtf0S9fvlspaKItcf+HZVCXXOIouQmp?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 840e0cbf-12b4-42dd-0b77-08dc4f59bb87
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:03:19.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSSJow6eBZaC6R82Vgy82p1hIqxZL4Bql2Jp2G6SKhx9MJHsj4wknD9SsJa18AXf0mo9rRZ2WPWNUJEEatprPWFb64ioTts7fQrDHKKwYNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7162
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Wed, Mar 27, 2024 at 04:57:40PM -0700, Dave Jiang wrote:
> > On 3/27/24 2:26 PM, Bjorn Helgaas wrote:
> > > On Mon, Mar 25, 2024 at 04:58:01PM -0700, Dave Jiang wrote:
> 
> > >> With the current behavior, the bus_reset would appear to have executed
> > >> successfully, however the operation is actually masked if the "Unmask
> > >> SBR" bit is set with the default value. The intention is to inform the
> > >> user that SBR for the CXL device is masked and will not go through.
> > > 
> > > The default value of Unmask SBR isn't really relevant here.
> > 
> > Changing to:
> >     When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
> >     appear to have executed successfully. However the operation is actually
> >     masked. The intention is to inform the user that SBR for the CXL device
> >     is masked and will not go through.
> > 
> > > 
> > >> The expectation is that if a user overrides the "Unmask SBR" via a
> > >> user tool such as setpci then they can trigger a bus reset successfully.
> > > 
> > > ... if a user *sets* Unmask SBR ...
> > > to be more specific about what value is required.
> > > 
> > 
> >     If a user overrides the "Unmask SBR" via a user tool such as setpci and
> >     sets the value to 1, then the bus reset will execute successfully.
> 
> I'm not super enamored with the "if a user overrides" language because
> a driver may change that bit in the future, and then the suggestion of
> a "user" will be misleading.
> 
> It doesn't matter *how* it gets set to 1; it only matters that SBR
> doesn't work when "Unmask SBR" is 0 and it does work when "Unmask SBR"
> is 1.
> 
> > >> +/* Compute Express Link (CXL) */
> > >> +#define PCI_DVSEC_VENDOR_ID_CXL				0x1e98
> > > 
> > > I see that you're just moving this #define from drivers/cxl/cxlpci.h,
> > > but I'm scratching my head a bit.  As used here, this is to match the
> > > DVSEC Vendor ID (PCIe r6.0, sec 7.9.6.2).
> > > 
> > > IIUC, this should be just a PCI SIG-defined "Vendor ID", e.g.,
> > > "PCI_VENDOR_ID_CXL", that doesn't need the "DVSEC" qualifier in the
> > > name, and would normally be defined in include/linux/pci_ids.h.
> > > 
> > > But I don't see CXL in pci_ids.h, and I don't see either "CXL" or the
> > > value "1e98" in the PCI SIG list at
> > > https://pcisig.com/membership/member-companies.
> > > 
> > I'll create a new patch and move to include/linux/pci_ids.h first
> > for this define and change to PCI_VENDOR_ID_CXL. The value is
> > defined in CXL spec r3.1 sec 8.1.1.
> 
> I saw the CXL mentions of 0x1e98, but IMO that's not an authoritative
> source; no vendor is allowed to just squat on a Vendor ID value simply
> by mentioning it in their own internal specs.  That would obviously
> lead to madness.
> 
> The footnote in CXL r3.1, sec 3.1.2, about how the 1E98h value is only
> for use in DVSEC etc., is really weird.
> 
> IIUC, the PCI SIG controls the Vendor ID namespace, so I'm still
> really confused about why it is not reserved there.  I emailed the PCI
> SIG, but the footnote suggests to me that there some kind of history
> here that I don't know.
> 
> Anyway, I think all we can do here is to put the definition in
> include/linux/pci_ids.h as you did and hope 0x1e98 is never allocated
> to another vendor.

Oh, true, I think this should be PCI_DVSEC_VENDOR_ID_CXL, because afaics
it is still possible that 0x1e98 be used as a non-DVSEC vendor-id in
some future device.

In other words I think the CXL specification usage of 0x1e98 is scoped
as "DVSEC Vendor ID", not "Vendor ID".

However that would mean that a future 0x1e98 device could not publish
DVSECs without colliding with CXL DVSECs.

I note this footnote in section 3.1.2 about the 0x1e98 value (all caps
emphasis is from the spec, not me):

---
NOTICE TO USERS: THE UNIQUE VALUE THAT IS PROVIDED IN THIS CXL SPECIFICATION IS
FOR USE IN VENDOR DEFINED MESSAGE FIELDS, DESIGNATED VENDOR SPECIFIC EXTENDED
CAPABILITIES, AND ALTERNATE PROTOCOL NEGOTIATION ONLY...

