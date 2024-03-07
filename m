Return-Path: <linux-pci+bounces-4614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9926875793
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 20:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599A11F24618
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65841384B9;
	Thu,  7 Mar 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqD9spqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BF137C39
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841113; cv=fail; b=IhBNL8QFiHq1esCrVeNl7jpmZVwLlFxz2fccHSCA4sqdvYuWkGAHOXGlQW7Qi5i1Ysv4wbEFWBHVQnKM/Zb3DlYY+iIKga4C3dz+5iPi/9MbSzWJpFnzr96jweTLP06IWV4swGoGFAEOtUFA0MzZ4B33KVaobivVHOWGCtmqeaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841113; c=relaxed/simple;
	bh=uHdQDb3eG2eyHbXRfw/neQwJi9Hj3VCvicTUgRiw1n8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PAzpqxXN9X2jcFf4DEWuDBg9aHo347hvRoinE/iNCQicjfMe3LWarGfC+y6T9McJP67TuxHLbl3FQYQ6SRZdxaZpQ/PHoUYt3eFoR03QV1YPMitO7PfcPgx/ufMe1e5KFLT74UGFZobp1prm3iSE2uMVQBkkTEo2UD7rf/wDZec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqD9spqI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709841111; x=1741377111;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uHdQDb3eG2eyHbXRfw/neQwJi9Hj3VCvicTUgRiw1n8=;
  b=eqD9spqIUUMeJpuklS8VWzrjhCRuMJYc1H+1MK09K0tZPHL1klhvAJjx
   aTqUVDDtD8g0FiHsoCusvG1YfG1tIwl4KdE8zGfh/M84pwgorNj6AL5OG
   XPummyqFaaLfuK8UXjqGN5bjojfsJB+KrqjHY1aD5RaWFm5hWxZgIvVQE
   mAQfHHIHBe9Sbrh4NK5YVdRlFB8B/62vHoihgjglaG2YtLtufcuUtABN5
   whsp7TdRHA84ie/9Z70ITffBFOofljl+CTM3ql7jx2UJTI2BizrfBi2TZ
   rbBpg7Njw+eueZ0xQL+T3/la0WZSZmGh0hNykO7YlxJdaM6qZjQzUE53s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4414233"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4414233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:51:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="33366367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 11:51:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 11:51:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 11:51:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 11:51:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsRXH9Ekb76l2E0v5Une6VaF4fMJH/s+H48VHMhNx4uyXuRNGS9F+8W24ggtHsnnsCxGo/S7hyyuSG4+3Z+l8Bawjki9lsIROb+0xNlZ+QKLpyqznD3Cql7WQohz+8rd8xqKh1LDRjDCpXJlMoINkLR2ovoT8canRZ1Ne5rCxTiow9MECnwL5Denoxox8EEuPmpju+ZqDtoMkM2SYqtORg76cgNwiYl7ZufSjN+w53CNEa+saBguZsUy8A9sJiX9CAUyJHNAaUNGzutibA6vYkhIIHL2y7OACMENIC9Xwc/4AQ/x2GyaYzo0mzlMXF6ogDErBlrvCZh4XUb+k9osRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3YzRg2znsct+TL0wE8IVDc8JTRC+2JuNbqXFh+oW+Y=;
 b=HAE2f9DqffVdSLKPVl/f4vS9ADAmVC7Z1dcaikCG22IHmet0QKDNqzxuuyHCqZYWi/l3WaDgzNEjSsEGUCIiPf72rESKLUX+Vsx8FQjRX05bc+5yqC84ELFKwO3nEJ2D6VYWksDfu8MOM1Wz2yM8a+nP1jlFn+7LT6KKh4+rDg2IwT+B8l2hFNLCWKGeiz43iAx7255b4fGa7nJXMkY0tP7wOsoH8DC8BovqS6N82lCWTGr/dWOSV6OXaeebhPIiXW8QN9mpsxjRtyk+yL8NxtL/K21/mWJ+WbEIeH5y0vXJbps9+cOZJuKSMb/pm20CnlWq7ePfi9+ZNIInIjKeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5874.namprd11.prod.outlook.com (2603:10b6:806:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:51:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 19:51:47 +0000
Date: Thu, 7 Mar 2024 11:51:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <65ea1ad05216f_1ecd29444@dwillia2-xfh.jf.intel.com.notmuch>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
 <20240307171810.0000396c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240307171810.0000396c@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 684b6867-e4d1-4c0c-cb02-08dc3ee005b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0qpUxbw5AFHXBZ5kNvoHWLBGpLaZHWA48Azq3YUBaqBSnPuN9UryEvVV5dZ/B9gNzQakcODGjebNEBk8l5RJ/qBL3/t50SU8UuxBwBazIwPsJ4zOSAEWPggqXdWTsZbD5TReMiq8OCRXsVr+VI+eW5UHZPoOxcZTDolxTaiBqGPw5KfBsi5IcDY2YHRR9edGSjZieqHwalYAkZ0XfybYY18lgrkmDPRu/ZHRU+o/JemL1DiVaIFqJjTNd4ul40NgfwN2fPIkQQvKWz7cAr+8dR4AcKZTtRBViS4x6LxaA5+Jvgk06/VSDHIGDGtNXAobrYRnjagLe33c6FS1WdXDndAjSac0olbUGMP8jDcos9jTUgfLbO0saBuHutiURNu9G7R15DxOK+zxi4/Mkm5FsCZt09J8g2W3bi7efIbUVvY0EhQQff8jjb6Mgs66J9x87ToyANxU0WtpMpjX6tOthtQw3ALVUNP9+oEDp250ste+JAVbO7rCgyF4iKAmLWpu99McHGjgPZh0LM1L1p1jnDyxmVMH6DAdLC1Karqk7MKZHUtAxpot2Xrqd5hK4rbdT+mtfkcld1XlwC5DlIGAFfHI+QCrth9QGsvmjiPawr/yVKokuLS6lxaaSOiXhqID9xZKP8XoGDt74GnBWT2umC3C9sf7H5Ds3xOPA4tJCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?382NMxf4SfQ1JWkBT8moGO9eS6lDEmfTBgAa6y3vdlCces8lADuZX69aK7UL?=
 =?us-ascii?Q?iPCFp/hlMNVSgS56eJYHZJNOApfyxmu0eUlMara+UTud5I5/ltxi3EpC8y+D?=
 =?us-ascii?Q?cPFgQfOipZZSIlTSVXAir841OWyUvAveU2FxtNZEKIpJZT767hSMk7tgKtcq?=
 =?us-ascii?Q?S5IboTh99i6zKmnMOVih72kfhNs/odz+ljz0nMJAJ9D2tSbai3pX+23JraL4?=
 =?us-ascii?Q?Qi/WP22lpvGS7FYWv/DhTvRctiUyN4uH88t9aRwYRLHZF3JXMcGyo9DVIE+w?=
 =?us-ascii?Q?wdGWC2RvO/QV1Sb6UYhgygVdGHw79TE3KPGkHKYg5sREU/NXeNPLuOa/SWRc?=
 =?us-ascii?Q?UDlFgFWGf586qJQy4ay4rqIE5QXNyHpSrZWxkjMDs/4KP3vB18FfhX3I8R0a?=
 =?us-ascii?Q?pmSkJgiyiDHqOEnXXwzuzUzETEpAJZ9jHD//1NFjcGJiQlFzZZ3dbae1Q+ct?=
 =?us-ascii?Q?+ByzMgouvsyIbs3VT0NNGjFQh7RC0qSwmJLc6fcXgKHwMwj6MsZ1mS8U//HF?=
 =?us-ascii?Q?OBJW824QW8m48z65gxYH1KdgHwnMHJTRne4SGdU7tH7TcwZuPQnDw37WEenH?=
 =?us-ascii?Q?oHoFjYk5SXwrvalJaKVrGzkhEsdABa6OEBmYulPTqqr8b+jsTnz9o8HFFfO1?=
 =?us-ascii?Q?V6pg3NtkuCE4BDTWpREF8ZS7m74PsHQlKeIoy/nAzlbszzEDetw7TCNgsd87?=
 =?us-ascii?Q?Ef+0dViK2CREDx2uXqSRTNNjg1fzpF5/SPd6dX2qbzd3SAGHs4s2NhUKCXSo?=
 =?us-ascii?Q?prLVJuJjOJpn1WmiIPAX9dpDVxCRDZtUr22Kz1sx6At+ofU+Su3JPLUUs0K0?=
 =?us-ascii?Q?ccEC9U0uYAt6OlLHC1fqiru69li6HSXrvpEmFZob76gvHPPSEd0akfymeyiy?=
 =?us-ascii?Q?YVzxfPttn3Rxn6KvWgab+3O7OXCIg0FCTKsGLsFaTnmk0ePpvoWX0mTB6N6J?=
 =?us-ascii?Q?MKLI60Dd/f+S8NPtPoOtm9KA4BJe7ky0BNWdW+3hd55Lsa9wK3S0ullWLQ2R?=
 =?us-ascii?Q?YOSMzYBNlFT8hD4zT0O21IsarDbhemz+nHOB9UFv97xxLN26RP0fpIzgtKSg?=
 =?us-ascii?Q?i/+FGnChsIZQjFS15ySMypRrnyyA1NVNYY0sgpOftUxpJc2H/nce38rXZnlM?=
 =?us-ascii?Q?JeEeDx1hkP74BIy2dOQGVGIFxXy3HTAtPfbgBpWPgzo1RXEYbv7sxXKMFOX0?=
 =?us-ascii?Q?Dj1BpFHVQ424tQD5RvX6s4eRLXYhfvT/sX6Nb8DW5YWejjqa8cHcVAOGZFTT?=
 =?us-ascii?Q?1HEZz66T1wehb9PlMjCISP/VpHujnGdhKLNpV9lcnqtG85C3z6bMQBzDN1w+?=
 =?us-ascii?Q?hhkzPhP4pHxHT3qOZEsWu8QhrJBCeVln4GZ6Ar0Sc3KNmqO3my1YkAxiqs1e?=
 =?us-ascii?Q?px4i4pUB0L+RKYXyMAos0iHSeZLOlXcVgWRoDmqaFEkEljPD5WZ8AgdopjrS?=
 =?us-ascii?Q?qU4YzkAzGyRL+CYciWfoZH3c5Y55c/sJJ47EWJvZR2QVfXQixktbpwDi+JXW?=
 =?us-ascii?Q?V50/YVw0EttWLw8VbDtrWSHiLIA9v3NMpV6N7DYtUXUCSIlfzy+l2IXHOZpB?=
 =?us-ascii?Q?9RrDbCbPpiMNC9+vNg8fBYgK0csH7k3PHPcA8DkIeueG7cku5pUSY6sJ4Rh3?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 684b6867-e4d1-4c0c-cb02-08dc3ee005b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:51:47.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdZQqy4O/DzD8/8mE77axujVGkopsoxN4dxMtwLGTx3NfFkCx9ZNnVYurzlL5+vED4QICTFHJ6Z2zGfukEDXckDmeHX/6uOvSg0yNsjPJkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5874
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 30 Jan 2024 01:24:14 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The PCIe 6.1 specification, section 11, introduces the Trusted
> > Execution Environment (TEE) Device Interface Security Protocol (TDISP).
> > This interface definition builds upon CMA, component measurement and
> > authentication, and IDE, link integrity and data encryption. It adds
> > support for establishing virtual functions within a device that can be
> > assigned to a confidential VM such that the assigned device is enabled
> > to access guest private memory protected by technologies like Intel TDX,
> > AMD SEV-SNP, RISCV COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a device security manager (DSM) and
> > system software in both a VMM and a VM. From a Linux perspective the TSM
> > abstracts many of the details of TDISP, IDE, and CMA. Some of those
> > details leak through at times, but for the most part TDISP is an
> > internal implementation detail of the TSM.
> > 
> > Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> > CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> > attribute, and add more properties + controls in a tsm/ subdirectory of
> > the PCI device sysfs interface. Unlike CMA that can depend on a local to
> > the PCI core implementation, PCI_TSM needs to be prepared for late
> > loading of the platform TSM driver. Consider that the TSM driver may
> > itself be a PCI driver. Userspace can depend on the common TSM device
> > uevent to know when the PCI core has TSM services enabled. The PCI
> > device tsm/ subdirectory is supplemented by the TSM device pci/
> > directory for platform global TSM properties + controls.
> > 
> > All vendor TSM implementations share the property of asking the VMM to
> > perform DOE mailbox operations on behalf of the TSM. That common
> > capability is centralized in PCI core code that invokes an ->exec()
> > operation callback potentially multiple times to service a given request
> > (struct pci_tsm_req). Future operations / verbs will be handled
> > similarly with the "request + exec" model. For now, only "connect" and
> > "disconnect" are implemented which at a minimum is expected to establish
> > IDE for the link.
> > 
> > In addition to requests the low-level TSM implementation is notified of
> > device arrival and departure events so that it can filter devices that
> > the TSM is not prepared to support, or otherwise setup and teardown
> > per-device context.
> > 
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Superficial comments inline - noticed whilst getting my head
> around the basic structure.
> 
> 
> 
> 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..f74de0ee49a0
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,346 @@
> 
> > +
> > +DEFINE_FREE(req_free, struct pci_tsm_req *, if (_T) tsm_ops->req_free(_T))
> > +
> > +static int pci_tsm_disconnect(struct pci_dev *pdev)
> > +{
> > +	struct pci_tsm_req *req __free(req_free) = NULL;
> 
> As below. I'll stop commenting on these.

Hey, they are fair game, will find a way to rework this and not use the
confusing pattern.

> > +
> > +	/* opportunistic state checks to skip allocating a request */
> > +	if (pdev->tsm->state < PCI_TSM_CONNECT)
> > +		return 0;
> > +
> > +	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_DISCONNECT);
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {
> > +		enum pci_tsm_op_status status;
> > +
> > +		/* revalidate state */
> > +		if (pdev->tsm->state < PCI_TSM_CONNECT)
> > +			return 0;
> > +		if (pdev->tsm->state < PCI_TSM_INIT)
> > +			return -ENXIO;
> > +
> > +		do {
> > +			status = tsm_ops->exec(pdev, req);
> > +			req->seq++;
> > +			/* TODO: marshal SPDM request */
> > +		} while (status == PCI_TSM_SPDM_REQ);
> > +
> > +		if (status == PCI_TSM_FAIL)
> > +			return -EIO;
> > +		pdev->tsm->state = PCI_TSM_INIT;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int pci_tsm_connect(struct pci_dev *pdev)
> > +{
> > +	struct pci_tsm_req *req __free(req_free) = NULL;
> 
> Push down a few lines to put it where the allocation happens.
> 
> > +
> > +	/* opportunistic state checks to skip allocating a request */
> > +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> > +		return 0;
> > +
> > +	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_CONNECT);
> > +	if (!req)
> > +		return -ENOMEM;
> > +
> > +	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {
> 
> What could possibly go wrong? Everyone loves scoped_cond_guard ;)

Indeed.

> 
> > +		enum pci_tsm_op_status status;
> > +
> > +		/* revalidate state */
> > +		if (pdev->tsm->state >= PCI_TSM_CONNECT)
> > +			return 0;
> > +		if (pdev->tsm->state < PCI_TSM_INIT)
> > +			return -ENXIO;
> > +
> > +		do {
> > +			status = tsm_ops->exec(pdev, req);
> > +			req->seq++;
> > +		} while (status == PCI_TSM_SPDM_REQ);
> > +
> > +		if (status == PCI_TSM_FAIL)
> > +			return -EIO;
> > +		pdev->tsm->state = PCI_TSM_CONNECT;
> > +	}
> > +	return 0;
> > +}
> 
> ...
> 
> > + size_t connect_mode_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf, size_t len)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int i;
> > +
> > +	guard(mutex)(tsm_ops->lock);
> > +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> > +		return -EBUSY;
> > +	for (i = 0; i < ARRAY_SIZE(pci_tsm_modes); i++)
> > +		if (sysfs_streq(buf, pci_tsm_modes[i]))
> > +			break;
> > +	if (i == PCI_TSM_MODE_LINK) {
> > +		if (pdev->tsm->link_capable)
> > +			pdev->tsm->mode = PCI_TSM_MODE_LINK;
> 
> Error in all real paths paths?

Uh... yeah, did I mention that this untested. Will fix.

> Also, maybe a switch will be more sensible here.

Sure.

> 
> > +		return -EOPNOTSUPP;
> > +	} else if (i == PCI_TSM_MODE_SELECTIVE) {
> > +		if (pdev->tsm->selective_capable)
> > +			pdev->tsm->mode = PCI_TSM_MODE_SELECTIVE;
> > +		return -EOPNOTSUPP;
> > +	} else
> > +		return -EINVAL;
> > +	return len;
> > +}
> 
> 
> > +
> > +void pci_tsm_init(struct pci_dev *pdev)
> > +{
> > +	u16 ide_cap;
> > +	int rc;
> > +
> > +	if (!pdev->cma_capable)
> > +		return;
> > +
> > +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> > +	if (!ide_cap)
> > +		return;
> > +
> > +	struct pci_tsm *tsm __free(kfree) = kzalloc(sizeof(*tsm), GFP_KERNEL);
> > +	if (!tsm)
> > +		return;
> > +
> > +	tsm->ide_cap = ide_cap;
> > +
> > +	rc = xa_insert(&pci_tsm_devs, (unsigned long)pdev, pdev, GFP_KERNEL);
> 
> This is an unusual pattern with the key and the value matching.
> Feels like xarray might for once not be the best choice of structure.

This is the "use xarray instead of a linked list patterni". It would be
useful to maybe make the key be the Segment+BDF, but I did not take the
time to figure out if that can fit in an unsigned long. In the meantime
this saves needing to embed a linked list node in 'struct pci_dev'.

[..]
> > diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
> > index a569fa6b09eb..a459e51c0892 100644
> > --- a/drivers/virt/coco/tsm/class.c
> > +++ b/drivers/virt/coco/tsm/class.c
> 
> > +static const struct attribute_group *tsm_attr_groups[] = {
> > +#ifdef CONFIG_PCI_TSM
> > +	&tsm_pci_attr_group,
> > +#endif
> > +	NULL,
> Trivial but, no point in that comma as we will never chase it with anything.
> > +};
> > +
> >  static int __init tsm_init(void)
> >  {
> >  	tsm_class = class_create("tsm");
> > @@ -86,6 +97,7 @@ static int __init tsm_init(void)
> >  		return PTR_ERR(tsm_class);
> >  
> >  	tsm_class->dev_release = tsm_release;
> > +	tsm_class->dev_groups = tsm_attr_groups;
> >  	return 0;
> >  }
> >  module_init(tsm_init)
> > diff --git a/drivers/virt/coco/tsm/pci.c b/drivers/virt/coco/tsm/pci.c
> > new file mode 100644
> > index 000000000000..b3684ad7114f
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm/pci.c
> 
> > +
> > +static bool tsm_pci_group_visible(struct kobject *kobj)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct tsm_subsys *subsys = container_of(dev, typeof(*subsys), dev);
> Give this a macro probably.
>  dev_to_tsm_subsys(kobj_to_dev(kobj));

Sure.

> 
> > +
> > +	if (subsys->info->pci_ops)
> > +		return true;
> 
> 	return subsys->info->pci->ops;
> maybe

True, maybe with a !! for good measure.

[..]
> > diff --git a/drivers/virt/coco/tsm/tsm.h b/drivers/virt/coco/tsm/tsm.h
> > new file mode 100644
> > index 000000000000..407c388a109b
> > --- /dev/null
> > +++ b/drivers/virt/coco/tsm/tsm.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TSM_CORE_H
> > +#define __TSM_CORE_H
> > +
> > +#include <linux/device.h>
> > +
> > +struct tsm_info;
> > +struct tsm_subsys {
> > +	struct device dev;
> > +	const struct tsm_info *info;
> > +};
> 
> I know people like to build up patch sets, but I think defining this here
> from patch 3 would just reduce noise.

Ok.

> 
> > +
> > +#ifdef CONFIG_PCI_TSM
> > +int tsm_pci_init(const struct tsm_info *info);
> > +void tsm_pci_destroy(const struct tsm_info *info);
> > +extern const struct attribute_group tsm_pci_attr_group;
> > +#else
> > +static inline int tsm_pci_init(const struct tsm_info *info)
> > +{
> > +	return 0;
> > +}
> > +static inline void tsm_pci_destroy(const struct tsm_info *info)
> > +{
> > +}
> > +#endif
> > +
> > +#endif /* TSM_CORE_H */
> 
> > diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> > index 8cb8a661ba41..f5dbdfa65d8d 100644
> > --- a/include/linux/tsm.h
> > +++ b/include/linux/tsm.h
> > @@ -4,11 +4,15 @@
> >  
> >  #include <linux/sizes.h>
> >  #include <linux/types.h>
> > +#include <linux/mutex.h>
> 
> struct mutex;
> instead given you only have a pointer I think.

True, but see below I expect this lock to move somewhere else in the
next version.

> 
> 
> >  
> >  struct tsm_info {
> >  	const char *name;
> >  	struct device *host;
> >  	const struct attribute_group **groups;
> > +	const struct tsm_pci_ops *pci_ops;
> > +	unsigned int nr_selective_streams;
> > +	unsigned int link_stream_capable:1;
> >  };
> 
> 
> > +struct pci_dev;
> > +/**
> > + * struct tsm_pci_ops - Low-level TSM-exported interface to the PCI core
> > + * @add: accept device for tsm operation, locked
> > + * @del: teardown tsm context for @pdev, locked
> > + * @req_alloc: setup context for given operation, unlocked
> > + * @req_free: teardown context for given request, unlocked
> > + * @exec: run @req, may be invoked multiple times per @req, locked
> > + * @lock: tsm work is one device and one op at a time
> > + */
> > +struct tsm_pci_ops {
> > +	int (*add)(struct pci_dev *pdev);
> > +	void (*del)(struct pci_dev *pdev);
> > +	struct pci_tsm_req *(*req_alloc)(struct pci_dev *pdev,
> > +					 enum pci_tsm_op op);
> > +	struct pci_tsm_req *(*req_free)(struct pci_tsm_req *req);
> > +	enum pci_tsm_op_status (*exec)(struct pci_dev *pdev,
> > +				       struct pci_tsm_req *req);
> > +	struct mutex *lock;
> 
> Mixing data with what would otherwise be likely to be constant pointers
> probably best avoided.  Maybe wrap the lock in another op instead?

After chatting with Alexey this lock is too coarse and will move to a
per device lock rather than locking the entire interface.

