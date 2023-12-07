Return-Path: <linux-pci+bounces-634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E48092B5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 21:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE041F212E5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95450264;
	Thu,  7 Dec 2023 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BABDhGje"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18A50248;
	Thu,  7 Dec 2023 20:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D638EC433C7;
	Thu,  7 Dec 2023 20:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982038;
	bh=szsXL9Pkyj4AVfw+UsXxMv2rdIObYfpxXnQD6RrB26Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BABDhGjeDklAokNm+6dGqWNnZfxS3OO2Vc3g2Y+0ipyVsnBwl0U98CGmYZstopMuq
	 E8i88OMhYZnALskRuMHpJ2CNniaeZ0NGLWFqjpI7P05HYTqLDzCIFUzz0u0FURk7v2
	 p/KaNNFB51Liqer6Jc/o5I4JIL9b6ozn1mPSw4vv/1zzvivbFuGkfVI+67ktZE4TnX
	 UXZVVLEAWRhaPsMVE5S5FHw+xdc09hx0cSW4EIIP4RP7RBi9nIDBH6SopoPsiEAUzm
	 iPRc8TR+1Rfgeq7H5DBoF9WxMVuP4rD4F6GbBcVlLFZ+JqzW4b3SCn9aBp3Zlqj/SE
	 GD7C2o9DZgltg==
Date: Thu, 7 Dec 2023 14:47:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michael Bottini <michael.a.bottini@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231207204716.GA764883@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081512.19387-2-johan+linaro@kernel.org>

[+cc Kai-Heng]

On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> Add a helper for enabling link states that can be used in contexts where
> a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> 
> This helper will be used to fix a couple of potential deadlocks where
> the current helper is called with the lock already held, hence the CC
> stable tag.
> 
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> Cc: stable@vger.kernel.org	# 6.3
> Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++++++++----------
>  include/linux/pci.h     |  3 +++
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 50b04ae5c394..5eb462772354 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1109,17 +1109,7 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> -/**
> - * pci_enable_link_state - Clear and set the default device link state so that
> - * the link may be allowed to enter the specified states. Note that if the
> - * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> - * touch the LNKCTL register. Also note that this does not enable states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> - *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> - */
> -int pci_enable_link_state(struct pci_dev *pdev, int state)
> +static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  {
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> @@ -1136,7 +1126,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  		return -EPERM;
>  	}
>  
> -	down_read(&pci_bus_sem);
> +	if (!locked)
> +		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_default = 0;
>  	if (state & PCIE_LINK_STATE_L0S)
> @@ -1157,12 +1148,48 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
>  	pcie_set_clkpm(link, policy_to_clkpm_state(link));
>  	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> +	if (!locked)
> +		up_read(&pci_bus_sem);
>  
>  	return 0;
>  }
> +
> +/**
> + * pci_enable_link_state - Clear and set the default device link state so that
> + * the link may be allowed to enter the specified states. Note that if the
> + * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> + * touch the LNKCTL register. Also note that this does not enable states
> + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + */
> +int pci_enable_link_state(struct pci_dev *pdev, int state)
> +{
> +	return __pci_enable_link_state(pdev, state, false);
> +}
>  EXPORT_SYMBOL(pci_enable_link_state);

As far as I can see, we end up with pci_enable_link_state() defined
but never called and pci_enable_link_state_locked() being called only
by pcie-qcom.c and vmd.c.

Can we just rename pci_enable_link_state() to
pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
we don't end up with a function that's never used?

I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
in qcom and vmd to enable ASPM is an ugly hack to work around this
weird idea that "the OS isn't allowed to enable more ASPM states than
the BIOS did because the BIOS might have left ASPM disabled because it
knows about hardware issues."  More history at
https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/T/#u

I think we need to get to a point where Linux enables all supported
ASPM features by default.  If we really think x86 BIOS assumes an
implicit contract that the OS will never enable ASPM more
aggressively, we might need some kind of arch quirk for that.

If we can get there, the qcom use of pci_enable_link_state() could go
away, and the vmd use could be replaced by some kind of "if device is
below VMD, get rid of the legacy x86 ASPM assumption" quirk.

Bjorn

