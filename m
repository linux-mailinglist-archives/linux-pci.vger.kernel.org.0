Return-Path: <linux-pci+bounces-792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B07A80E783
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 10:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854FAB20920
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DD219F2;
	Tue, 12 Dec 2023 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsm7tUKQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82939EA;
	Tue, 12 Dec 2023 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702373153; x=1733909153;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J7oOLumnJZHBFS2dqddnZ8wo64mptqlvLB8nSpsJYv4=;
  b=jsm7tUKQb/17tVcTfBJUGHMxhyHTV/1s5erm7YNYBAe3bUZT2SmMQRBf
   RjMnzH5ma+IgxltPs8935aK2X2T5lOfEFJ+wW1w/v1gYq6QfxsPSXVyG3
   u5GOPI/JKeNet5zinQ9PP1dmwIReMm4e+I8B3eLhbXcHwnKYU9T2AN1yz
   9fo+D8wK+HXgzd57YNGH0/35XtMTCzBEclFyAkeAKYK2L6lWKSl1sYvp7
   CEshtN69QtTnRi2VX5JWU3uQC+IQQeDr3gCKFHHYAgkFFnevgPhBxsWqX
   m8e0qRT3dM+rcjxjYD1ms//8Pn3ubgG7xxp4M7PWKE8tdAeD9rfYjLkeO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1930671"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1930671"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="843847927"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="843847927"
Received: from tdietric-mobl.ger.corp.intel.com ([10.252.32.93])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:25:46 -0800
Date: Tue, 12 Dec 2023 11:25:44 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Johan Hovold <johan@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Nirmal Patel <nirmal.patel@linux.intel.com>, 
    Jonathan Derrick <jonathan.derrick@linux.dev>, 
    linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Michael Bottini <michael.a.bottini@linux.intel.com>, 
    "David E . Box" <david.e.box@linux.intel.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
In-Reply-To: <20231208173932.GA798089@bhelgaas>
Message-ID: <f0beb640-5c87-7c8e-64ba-908324347613@linux.intel.com>
References: <20231208173932.GA798089@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 Dec 2023, Bjorn Helgaas wrote:

> On Fri, Dec 08, 2023 at 09:00:56AM +0100, Johan Hovold wrote:
> > On Thu, Dec 07, 2023 at 02:47:16PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> > > > Add a helper for enabling link states that can be used in contexts where
> > > > a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> > > > 
> > > > This helper will be used to fix a couple of potential deadlocks where
> > > > the current helper is called with the lock already held, hence the CC
> > > > stable tag.
> > 
> > > As far as I can see, we end up with pci_enable_link_state() defined
> > > but never called and pci_enable_link_state_locked() being called only
> > > by pcie-qcom.c and vmd.c.
> > 
> > Correct, I mentioned this in the cover letter.
> 
> Ah, right.  I really don't like these exported locked/unlocked
> interfaces because pci_bus_sem is internal to the PCI core, and the
> caller shouldn't need to know or be able to specify whether it is held
> or not.  They exist for now, but I think we should try to get rid of
> them.
> 
> > > Can we just rename pci_enable_link_state() to
> > > pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
> > > we don't end up with a function that's never used?
> > 
> > That would work too. I went with adding a new helper to facilitate
> > stable backports and to mirror pci_disable_link_state(). The variants
> > are simple wrappers around the implementation so there's no real cost to
> > having the unused one.
> 
> Makes good sense.  There's no real machine cost to the unused one; I'm
> more concerned about the human cost here.

I know these were already applied but I want to correct one small 
misconcept that seems to be floating around thanks the misleading name...

pci_enable_link_state() is not really a pair/mirror of 
pci_disable_link_state() despite its name. It would be better called
pci_set_default_link_state() to better match what it does.

-- 
 i.


