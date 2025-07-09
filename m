Return-Path: <linux-pci+bounces-31759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85DAFE3C0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 11:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C337B6C8A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56028468F;
	Wed,  9 Jul 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHZzAB8b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EDF78F36;
	Wed,  9 Jul 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052266; cv=none; b=McmROtQv9VghzIgJ3PXIjETJAHsY6a5CR91mCNIcD233b0pQdeFgX8UtWqvw5ad9VqJqCG7A2gmftyyqTVoGioOErrFG2jk1GaUeXK460U5LbqtFLjBiCjFcErgmC3f4EXl20Emq/cubQ2zFXTmMmoeQynziovHIsrzam/5gUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052266; c=relaxed/simple;
	bh=e+AlNfEIWLEOUZb0WGiJuKUfwZfi9mwK1UILrKSjqnk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M7zQVWBtw8/slFSnBwYd7Muj0FMgMbGRPQxIzvM43d7QTjx/LO1w28wWGuBHGiFSf0VnVlVrr/zWJ5v83Vam2nzPe4sBzAucpdN8L8ychcERB+247D1mwRMF1nlD9Ie70eUxx5/virE37BaIswzWO2+uG8N+isIpawczLYCOfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHZzAB8b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752052265; x=1783588265;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e+AlNfEIWLEOUZb0WGiJuKUfwZfi9mwK1UILrKSjqnk=;
  b=VHZzAB8bXpVPESqBubuBtAnaqdRM2qP+WSjy0zrQQlHsgxceRt6CVRvi
   casoELT49zdjxg8Lva5eHI0AABJZbHl3/nvXO+Xcfh8O0/QRnd0OrSsVA
   M57GkwNHl9qqAppk3dyhSl0kf53QJabbZtRqGJh7yUQ19qd0670UjMouy
   9ZCTNQZLMKPcc8NKDoTHrQ72PfYUwJAoAJ3X8UjPxG5mpd29a9A55GbRu
   LDHTJqqF0uKZ4yz7zkZdNuzMC4SwZmfnJrxvRMgfWhfLyvKkyR/U2hiSW
   BqtpjpzwIKHTQdRxa5cMH2p2479jesPxwO7N/VbvfRx97H+pUvMhRi7M5
   w==;
X-CSE-ConnectionGUID: JZph60nNShWI1CkDwW7aiw==
X-CSE-MsgGUID: Qiw2/TzASUq3qpwLoT2Zlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54163409"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54163409"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:11:04 -0700
X-CSE-ConnectionGUID: 2YofaDi1Rfa2S2hif6cl5Q==
X-CSE-MsgGUID: uvbwgx//RiSED5u6g+R/jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155458540"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:10:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Jul 2025 12:10:52 +0300 (EEST)
To: Manivannan Sadhasivam <mani@kernel.org>
cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
In-Reply-To: <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2>
Message-ID: <226bab3a-54e5-94ad-9d84-0b82f9dc4e2f@linux.intel.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com> <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com> <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Jul 2025, Manivannan Sadhasivam wrote:

> On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru wrote:
> > ASPM states are not being enabled back with pci_enable_link_state() when
> > they are disabled by pci_disable_link_state(). This is because of the
> > aspm_disable flag is not getting cleared in pci_enable_link_state(), this
> > flag is being properly cleared when ASPM is controlled by sysfs.
> > 
> 
> A comment in pcie_config_aspm_link() says:
> 
>  /* Enable only the states that were not explicitly disabled */
> 
> But the function is called from both aspm_attr_store_common() and
> __pci_enable_link_state(). So I don't know if this is behavior is intentional
> or wrong. 

Hi,

I think it's intentional. Whether the behavior is useful is another good 
question but the current behavior aligns with the explanation in the 
comment.

My understanding of the situation is:

pci_disable_link_state() and pci_enable_link_state() are not symmetric 
despite the names, never have been (this is one of those many quirks ASPM 
driver has which should be eventually cleaned up, IMO).

It might be appropriate to rename pci_enable_link_state() to 
pci_set_default_link_state() to match the name to its functionality (and 
the function comment):

 * pci_enable_link_state - Clear and set the default device link state

Note: "the default ... link state".


I've already raised this concern earlier! As you see, my comment are 
not getting addressed. I'd like to see the author does one of these:

1) Renames pci_enable_link_state() to pci_set_default_link_state()

1b) If pci_enable_link_state() is still needed after that, a new function
is added to symmetrically pair with pci_disable_link_state().

or alternatively,

2) Changelog justifies very clearly why this change is okay with the 
existing callers. (And obviously the function comment should be altered to 
match the functionality in that case too).

If approach 2 is chosen, it should be very carefully reviewed when it 
comes to the callers.


> > Clear the aspm_disable flag with the requested ASPM states requested by
> > pci_enable_link_state().
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Fixes tag?
> 
> - Mani
> 
> > ---
> >  drivers/pci/pcie/aspm.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d..0f858ef86111b43328bc7db01e6493ce67178458 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1453,6 +1453,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
> >  		down_read(&pci_bus_sem);
> >  	mutex_lock(&aspm_lock);
> >  	link->aspm_default = pci_calc_aspm_enable_mask(state);
> > +	link->aspm_disable &= ~state;
> >  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >  
> >  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > 
> > -- 
> > 2.34.1
> > 
> 
> 

-- 
 i.


