Return-Path: <linux-pci+bounces-8054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71E8D3D18
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A91284783
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936181836D1;
	Wed, 29 May 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLMIkLb6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E97156978
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001500; cv=none; b=dAREw7BjnhazbCQNz0jcvnVdst8Cg73q4LBk6g736GKURs5ba6Y7/zjiPOZpPKDz7pAhaN6CyXxs/3WMAdEzO4D8H55jho3EhiP8YG8TkWNRS2X/ohGEaLNSZwjVBrYzJ2uXOgJZjhVDZN0sh9dAVA4Srj1t1gBVhEUiTY2X5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001500; c=relaxed/simple;
	bh=/5hlxRuwXt8HgF+iJor5GR5ly7JaVMXw+7q7oBHupso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHDagm9pqqT69nVTirEC5tZ7XzTCCU7TLM1GcEVI+KG85xy16DUN77tO6XwYEPPo0uTdyES7A2rO5L+3tivw1/WVFBXWn4XUzroUp8q5t7+UrvcI6NeqwsxZs9QcPAPo+oGI8CPkAVW5seY2B8JtjRrkfFHpHsex2uMp5KEGBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLMIkLb6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717001499; x=1748537499;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/5hlxRuwXt8HgF+iJor5GR5ly7JaVMXw+7q7oBHupso=;
  b=ZLMIkLb6DaV08r7AXRcdXwanFFPOx5Fyv1x4E0CHGrenPKvwkWGDOvGO
   AFwfls5m4RBV4dULAh5fPVpjEf9KpYAuCIYgaPt5w0BEyZJS/6PeFgfRu
   Pgb7XpQdrjdc1Q8ouLThcgtBuxExA+5g2CSiyKKwnlAtbrVAWg0GJRzi/
   8ShF2JumTeNvGM/OfRwx8VlDbYESzrrYzk8R2/2s9PMTx94BCxrGPaXge
   A2MvVGfMyjZ2TAZGEHGuSt7Es8FDGUAuLrgnvbSaIec/vJsWHj5Sk4H4L
   1kE54s5YEo/TO+IBcu+s9e6BqCjd1MnTV5VWuY6g3S0P74n1LoA5O5Qkk
   w==;
X-CSE-ConnectionGUID: +9Ms8HeYR/CXO/EaL5Yogg==
X-CSE-MsgGUID: Prx+cGkmTx2GgO7agCvsSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24553054"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24553054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:51:32 -0700
X-CSE-ConnectionGUID: jST4o/xKSn+4HzF8w2tRQw==
X-CSE-MsgGUID: 6WYra3KORvuiO1dTg7l7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35964438"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 09:51:29 -0700
Date: Wed, 29 May 2024 19:51:34 +0300
From: Imre Deak <imre.deak@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Saarinen, Jani" <jani.saarinen@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	=?utf-8?B?5p2OLCDmmJ/ovok=?= <korantli@tencent.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: Lockdep annotation introduced warn in VMD driver
Message-ID: <ZlddFhB0ZiFpcCUH@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <ZlXP5oTnSApiDbD1@ideak-desk.fi.intel.com>
 <20240528155228.00005850@linux.intel.com>
 <877cfdkpom.fsf@intel.com>
 <DM8PR11MB565579189DD400BACDF5493CE0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
 <DM8PR11MB5655FA22F73644AD0520EC16E0F22@DM8PR11MB5655.namprd11.prod.outlook.com>
 <5fbf60dd-4ad1-43f1-a3e5-451e9481883e@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fbf60dd-4ad1-43f1-a3e5-451e9481883e@intel.com>

On Wed, May 29, 2024 at 09:08:33AM -0700, Dave Jiang wrote:
> 
> 
> On 5/29/24 8:36 AM, Saarinen, Jani wrote:
> > Hi, 
> >> -----Original Message-----
> >> From: Saarinen, Jani
> >> Sent: Wednesday, 29 May 2024 16.49
> >> To: Jani Nikula <jani.nikula@linux.intel.com>; Nirmal Patel
> >> <nirmal.patel@linux.intel.com>; Deak, Imre <imre.deak@intel.com>; Jiang,
> >> Dave <dave.jiang@intel.com>
> >> Cc: 李, 星辉 <korantli@tencent.com>; Jonathan Derrick
> >> <jonathan.derrick@linux.dev>; Bjorn Helgaas <bhelgaas@google.com>; linux-
> >> pci@vger.kernel.org; intel-gfx@lists.freedesktop.org
> >> Subject: RE: Lockdep annotation introduced warn in VMD driver
> >>
> >> Hi,
> >>
> >>> -----Original Message-----
> >>> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Jani
> >>> Nikula
> >>> Sent: Wednesday, 29 May 2024 11.06
> >>> To: Nirmal Patel <nirmal.patel@linux.intel.com>; Deak, Imre
> >>> <imre.deak@intel.com>
> >>> Cc: Jiang, Dave <dave.jiang@intel.com>; 李, 星辉 <korantli@tencent.com>;
> >>> Jonathan Derrick <jonathan.derrick@linux.dev>; Bjorn Helgaas
> >>> <bhelgaas@google.com>; linux-pci@vger.kernel.org; intel-
> >>> gfx@lists.freedesktop.org
> >>> Subject: Re: Lockdep annotation introduced warn in VMD driver
> >>>
> >>> On Tue, 28 May 2024, Nirmal Patel <nirmal.patel@linux.intel.com> wrote:
> >>>> On Tue, 28 May 2024 15:36:54 +0300
> >>>> Imre Deak <imre.deak@intel.com> wrote:
> >>>>
> >>>>> Hi,
> >>>>>
> >>>>> commit 7e89efc6e9e402839643cb297bab14055c547f07
> >>>>> Author: Dave Jiang <dave.jiang@intel.com>
> >>>>> Date:   Thu May 2 09:57:31 2024 -0700
> >>>>>
> >>>>>     PCI: Lock upstream bridge for pci_reset_function()
> >>>>>
> >>>>> introduced the WARN below in the VMD driver, see [1] for the full log.
> >>>>> Not sure if the annotation is incorrect or the VMD driver is missing
> >>>>> the lock, CC'ing VMD folks.
> >>>>>
> >>>>> --Imre
> >>>> Can you please provide repro steps and some background on the setup?
> >>>
> >>> Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P
> >>> LP5 RVP.
> >>>
> >>> Kconfig: https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14842/kconfig.txt
> >>>
> >>> Just booting with the above commit is enough.
> >> It seems fix do not fix as seen on
> >> https://patchwork.freedesktop.org/series/134183/
> >> => https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134183v1/index.html?
> >> See those red not where both are red stil and also both dmesg (boot.log) look
> >> still identical.
> >> So eg:
> >> base build:   https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_14846/bat-dg2-13/boot0.txt
> >> pw patches: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134183v1/bat-dg2-13/boot0.txt
> >>
> >> Dave, thoughts?
> > Also Imre tried with 2 PCI patches together https://patchwork.freedesktop.org/series/134193/ 
> > And still not good for those 4 systems (mtlp-9, bat-dg2-13/14 and bat-adlp-11) :
> > https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/index.html? 
> > Dave, Dan, thoughts? 
> 
> Can you provide the dmesg from the failure system with the 2 patches applied please?

For the above 4 machines, mtlp-9 not having the originally reported WARN
(at pci.c:4886) only some other lockdep issue, while the other 3
machines having both the originally reported one and the other lockdep
issue:

https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-mtlp-9/boot0.txt
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-dg2-13/boot0.txt
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-dg2-14/boot0.txt
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_134193v1/bat-adlp-11/boot0.txt

