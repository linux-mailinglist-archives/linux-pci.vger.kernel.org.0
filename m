Return-Path: <linux-pci+bounces-31902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD9B01224
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D5177BD0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298EA933;
	Fri, 11 Jul 2025 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM9K4lNx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE91865EB;
	Fri, 11 Jul 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208099; cv=none; b=jcw5MU9AjlKIAoGXyqz4VnOGM66evX6xD1u8fBjf2idG5xkM6ppB95Y9Lz92b+MQesXRnSAVrFQGXAc3OquMDhTG+8RXkiufLIMZG9v1VT+cW9EkED8KnHQXOdt3qCY2t2dqXlm+CN2RD2iBWo9/h/krRFkcX21DKVvKjqR0yVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208099; c=relaxed/simple;
	bh=0C/vTM5o8IziGLnZ32LREb0cwoermYkw/D2NJ31Q1Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPJE4nzPNS4wXeMpVFjgNGxahsrPzCQpYQisfdDZmMz+pedMRKIth4PXDo0XKylTCMgGoHa2H/RGU5eJMx4av5DRlN14UR2eQvIeeDkJIywx4EpIg24P0+3LF3wFrEMwzCfSJuGanbi3UGs2Mu8mzqY+hNQaTL4fRXMwN8a0qjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM9K4lNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05D6C4CEF0;
	Fri, 11 Jul 2025 04:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752208096;
	bh=0C/vTM5o8IziGLnZ32LREb0cwoermYkw/D2NJ31Q1Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM9K4lNx63NPSpJcWku7gT+TNpc/STC2mPEwXLxkY6CNZFu3oHUeQpQJTPJ7yh/BG
	 vVfKwUW1YnCt9l2SWBhwIDcq+fOWLtf/jz4y6wBiYzK84HKnNGG5tZbLMQZsNM+0d4
	 +CC4CQnXB2QZK6cvSWydVEhZVdXu1X3ZAcxvZO9UKHOhNPtyvjfgfQv7JMO1PSXsH5
	 RpPiUuRMM898YgxNMagM1cykHlL+9D64GaMlIpKxmst2VCpRURptimLoFJQDj7L+I8
	 3HuxEKFFuqgwiynVx34jdQCS+x6kY/OUwMnhPreAFRpj6BjIbIacn0k+eputxVO9cW
	 OwmD1qzHwTpRw==
Date: Fri, 11 Jul 2025 09:58:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
Message-ID: <irnkdlrmlozp7joydgnawfuivl2nnuxsb2t4osgxzbtyrfzd3n@7dhzjcd42aiw>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com>
 <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2>
 <226bab3a-54e5-94ad-9d84-0b82f9dc4e2f@linux.intel.com>
 <2a18cf9e-1dd2-4e09-81f4-eb1d07324c8e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a18cf9e-1dd2-4e09-81f4-eb1d07324c8e@oss.qualcomm.com>

On Wed, Jul 09, 2025 at 06:01:22PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/9/2025 2:40 PM, Ilpo Järvinen wrote:
> > On Tue, 8 Jul 2025, Manivannan Sadhasivam wrote:
> > 
> > > On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru wrote:
> > > > ASPM states are not being enabled back with pci_enable_link_state() when
> > > > they are disabled by pci_disable_link_state(). This is because of the
> > > > aspm_disable flag is not getting cleared in pci_enable_link_state(), this
> > > > flag is being properly cleared when ASPM is controlled by sysfs.
> > > > 
> > > 
> > > A comment in pcie_config_aspm_link() says:
> > > 
> > >   /* Enable only the states that were not explicitly disabled */
> > > 
> > > But the function is called from both aspm_attr_store_common() and
> > > __pci_enable_link_state(). So I don't know if this is behavior is intentional
> > > or wrong.
> > 
> > Hi,
> > 
> > I think it's intentional. Whether the behavior is useful is another good
> > question but the current behavior aligns with the explanation in the
> > comment.
> > 
> > My understanding of the situation is:
> > 
> > pci_disable_link_state() and pci_enable_link_state() are not symmetric
> > despite the names, never have been (this is one of those many quirks ASPM
> > driver has which should be eventually cleaned up, IMO).
> > 
> > It might be appropriate to rename pci_enable_link_state() to
> > pci_set_default_link_state() to match the name to its functionality (and
> > the function comment):
> > 
> >   * pci_enable_link_state - Clear and set the default device link state
> > 
> > Note: "the default ... link state".
> > 
> > 
> > I've already raised this concern earlier! As you see, my comment are
> > not getting addressed. I'd like to see the author does one of these:
> > 
> Hi llpo,
> 
> I replied to your comment on v3 patch[1], and I feel instead of having
> new function() we can use same API to our purpose.

You replied to Ilpo, but never got an agreement. Please try to close the
discussions before posting next rev. If reviewers forgot to reply to your query,
feel free to ping them in the same thread itself.

> > 1) Renames pci_enable_link_state() to pci_set_default_link_state()
> > 
> > 1b) If pci_enable_link_state() is still needed after that, a new function
> > is added to symmetrically pair with pci_disable_link_state().
> > 
> > or alternatively,
> > 
> > 2) Changelog justifies very clearly why this change is okay with the
> > existing callers. (And obviously the function comment should be altered to
> > match the functionality in that case too).
> > 
> > If approach 2 is chosen, it should be very carefully reviewed when it
> > comes to the callers.
> > 
> I am in favor of approach 2 which you suggested, but lets wait for other
> reviewers feedback on this. Based up on the response i will make
> necessary changes in v5.
> 

I would go for (1). It is always going to be a problem to change a legacy API
like this. We might end up causing regressions. So it is safe to rename to
reflect the purpose and try to come up with a new API that does what you want.
If callers want to migrate to the new API, they can also do it in the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

