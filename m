Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C642525A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhJGL5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 07:57:19 -0400
Received: from foss.arm.com ([217.140.110.172]:48718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241074AbhJGL5T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 07:57:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E636D;
        Thu,  7 Oct 2021 04:55:25 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C134B3F66F;
        Thu,  7 Oct 2021 04:55:24 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:55:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v2 11/13] PCI: aardvark: Fix link training
Message-ID: <20211007115522.GB19256@lpieralisi>
References: <20211005180952.6812-1-kabel@kernel.org>
 <20211005180952.6812-12-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005180952.6812-12-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 08:09:50PM +0200, Marek Beh�n wrote:
> From: Pali Roh�r <pali@kernel.org>
> 
> Fix multiple link training issues in aardvark driver. The main reason of
> these issues was misunderstanding of what certain registers do, since their
> names and comments were misleading: before commit 96be36dbffac ("PCI:
> aardvark: Replace custom macros by standard linux/pci_regs.h macros"), the
> pci-aardvark.c driver used custom macros for accessing standard PCIe Root
> Bridge registers, and misleading comments did not help to understand what
> the code was really doing.
> 
> After doing more tests and experiments I've come to the conclusion that the
> SPEED_GEN register in aardvark sets the PCIe revision / generation
> compliance and forces maximal link speed. Both GEN3 and GEN2 values set the
> read-only PCI_EXP_FLAGS_VERS bits (PCIe capabilities version of Root
> Bridge) to value 2, while GEN1 value sets PCI_EXP_FLAGS_VERS to 1, which
> matches with PCI Express specifications revisions 3, 2 and 1 respectively.
> Changing SPEED_GEN also sets the read-only bits PCI_EXP_LNKCAP_SLS and
> PCI_EXP_LNKCAP2_SLS to corresponding speed.
> 
> (Note that PCI Express rev 1 specification does not define PCI_EXP_LNKCAP2
>  and PCI_EXP_LNKCTL2 registers and when SPEED_GEN is set to GEN1 (which
>  also sets PCI_EXP_FLAGS_VERS set to 1), lspci cannot access
>  PCI_EXP_LNKCAP2 and PCI_EXP_LNKCTL2 registers.)
> 
> Changing PCIe link speed can be done via PCI_EXP_LNKCTL2_TLS bits of
> PCI_EXP_LNKCTL2 register. Armada 3700 Functional Specifications says that
> the default value of PCI_EXP_LNKCTL2_TLS is based on SPEED_GEN value, but
> tests showed that the default value is always 8.0 GT/s, independently of
> speed set by SPEED_GEN. So after setting SPEED_GEN, we must also set value
> in PCI_EXP_LNKCTL2 register via PCI_EXP_LNKCTL2_TLS bits.
> 
> Triggering PCI_EXP_LNKCTL_RL bit immediately after setting LINK_TRAINING_EN
> bit actually doesn't do anything. Tests have shown that a delay is needed
> after enabling LINK_TRAINING_EN bit. As triggering PCI_EXP_LNKCTL_RL
> currently does nothing, remove it.
> 
> Commit 43fc679ced18 ("PCI: aardvark: Improve link training") introduced
> code which sets SPEED_GEN register based on negotiated link speed from
> PCI_EXP_LNKSTA_CLS bits of PCI_EXP_LNKSTA register. This code was added to
> fix detection of Compex WLE900VX (Atheros QCA9880) WiFi GEN1 PCIe cards, as
> otherwise these cards were "invisible" on PCIe bus (probably because they
> crashed). But apparently more people reported the same issues with these
> cards also with other PCIe controllers [1] and I was able to reproduce this
> issue also with other "noname" WiFi cards based on Atheros QCA9890 chip
> (with the same PCI vendor/device ids as Atheros QCA9880). So this is not an
> issue in aardvark but rather an issue in Atheros QCA98xx chips. Also, this
> issue only exists if the kernel is compiled with PCIe ASPM support, and a
> generic workaround for this is to change PCIe Bridge to 2.5 GT/s link speed
> via PCI_EXP_LNKCTL2_TLS_2_5GT bits in PCI_EXP_LNKCTL2 register [2], before
> triggering PCI_EXP_LNKCTL_RL bit. This workaround also works when SPEED_GEN
> is set to value GEN2 (5 GT/s). So remove this hack completely in the
> aardvark driver and always set SPEED_GEN to value from 'max-link-speed' DT
> property. Fix for Atheros QCA98xx chips is handled separately by patch [2].
> 
> These two things (code for triggering PCI_EXP_LNKCTL_RL bit and changing
> SPEED_GEN value) also explain why commit 6964494582f5 ("PCI: aardvark:
> Train link immediately after enabling training") somehow fixed detection of
> those problematic Compex cards with Atheros chips: if triggering link
> retraining (via PCI_EXP_LNKCTL_RL bit) was done immediately after enabling
> link training (via LINK_TRAINING_EN), it did nothing. If there was a
> specific delay, aardvark HW already initialized PCIe link and therefore
> triggering link retraining caused the above issue. Compex cards triggered
> link down event and disappeared from the PCIe bus.
> 
> Commit f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready before
> training link") added 100ms sleep before calling 'Start link training'
> command and explained that it is a requirement of PCI Express
> specification. But the code after this 100ms sleep was not doing 'Start
> link training', rather it triggered PCI_EXP_LNKCTL_RL bit via PCIe Root
> Bridge to put link into Recovery state.
> 
> The required delay after fundamental reset is already done in function
> advk_pcie_wait_for_link() which also checks whether PCIe link is up.
> So after removing the code which triggers PCI_EXP_LNKCTL_RL bit on PCIe
> Root Bridge, there is no need to wait 100ms again. Remove the extra
> msleep() call and update comment about the delay required by the PCI
> Express specification.
> 
> According to Marvell Armada 3700 Functional Specifications, Link training
> should be enabled via aardvark register LINK_TRAINING_EN after selecting
> PCIe generation and x1 lane. There is no need to disable it prior resetting
> card via PERST# signal. This disabling code was introduced in commit
> 5169a9851daa ("PCI: aardvark: Issue PERST via GPIO") as a workaround for
> some Atheros cards. It turns out that this also is Atheros specific issue
> and affects any PCIe controller, not only aardvark. Moreover this Atheros
> issue was triggered by juggling with PCI_EXP_LNKCTL_RL, LINK_TRAINING_EN
> and SPEED_GEN bits interleaved with sleeps. Now, after removing triggering
> PCI_EXP_LNKCTL_RL, there is no need to explicitly disable LINK_TRAINING_EN
> bit. So remove this code too. The problematic Compex cards described in
> previous git commits are correctly detected in advk_pcie_train_link()
> function even after applying all these changes.
> 
> Note that with this patch, and also prior this patch, some NVMe disks which
> support PCIe GEN3 with 8 GT/s speed are negotiated only at the lowest link
> speed 2.5 GT/s, independently of SPEED_GEN value. After manually triggering
> PCI_EXP_LNKCTL_RL bit (e.g. from userspace via setpci), these NVMe disks
> change link speed to 5 GT/s when SPEED_GEN was configured to GEN2. This
> issue first needs to be properly investigated. I will send a fix in the
> future.
> 
> On the other hand, some other GEN2 PCIe cards with 5 GT/s speed are
> autonomously by HW autonegotiated at full 5 GT/s speed without need of any
> software interaction.
> 
> Armada 3700 Functional Specifications describes the following steps for
> link training: set SPEED_GEN to GEN2, enable LINK_TRAINING_EN, poll until
> link training is complete, trigger PCI_EXP_LNKCTL_RL, poll until signal
> rate is 5 GT/s, poll until link training is complete, enable ASPM L0s.
> 
> The requirement for triggering PCI_EXP_LNKCTL_RL can be explained by the
> need to achieve 5 GT/s speed (as changing link speed is done by throw to
> recovery state entered by PCI_EXP_LNKCTL_RL) or maybe as a part of enabling
> ASPM L0s (but in this case ASPM L0s should have been enabled prior
> PCI_EXP_LNKCTL_RL).
> 
> It is unknown why the original pci-aardvark.c driver was triggering
> PCI_EXP_LNKCTL_RL bit before waiting for the link to be up. This does not
> align with neither PCIe base specifications nor with Armada 3700 Functional
> Specification. (Note that in older versions of aardvark, this bit was
> called incorrectly PCIE_CORE_LINK_TRAINING, so this may be the reason.)
> 
> It is also unknown why Armada 3700 Functional Specification says that it is
> needed to trigger PCI_EXP_LNKCTL_RL for GEN2 mode, as according to PCIe
> base specification 5 GT/s speed negotiation is supposed to be entirely
> autonomous, even if initial speed is 2.5 GT/s.
> 
> [1] - https://lore.kernel.org/linux-pci/87h7l8axqp.fsf@toke.dk/
> [2] - https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@kernel.org/
> 
> Signed-off-by: Pali Roh�r <pali@kernel.org>
> Reviewed-by: Marek Beh�n <kabel@kernel.org>
> Signed-off-by: Marek Beh�n <kabel@kernel.org>
> Cc: stable@vger.kernel.org # f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready before training link")
> Cc: stable@vger.kernel.org # 6964494582f5 ("PCI: aardvark: Train link immediately after enabling training")
> Cc: stable@vger.kernel.org # 43fc679ced18 ("PCI: aardvark: Improve link training")
> Cc: stable@vger.kernel.org # 5169a9851daa ("PCI: aardvark: Issue PERST via GPIO")
> Cc: stable@vger.kernel.org # 96be36dbffac ("PCI: aardvark: Replace custom macros by standard linux/pci_regs.h macros")
> Cc: stable@vger.kernel.org # d0c6a3475b03 ("PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()")
> Cc: stable@vger.kernel.org # 1d1cd163d0de ("PCI: aardvark: Update comment about disabling link training")
> ---
>  drivers/pci/controller/pci-aardvark.c | 117 ++++++++------------------
>  1 file changed, 34 insertions(+), 83 deletions(-)

This is a very convoluted fix; it is well explained but the number
of patches going into stable and the complexity of it make me ask
how confident you are this won't trigger any regressions.

It is just a heads-up to make you think whether it is better to
hold the stable tags till we are confident enough.

Please let me know.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 9c509d5a9afa..2c66cdbb8dd6 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -258,11 +258,6 @@ static inline u32 advk_readl(struct advk_pcie *pcie, u64 reg)
>  	return readl(pcie->base + reg);
>  }
>  
> -static inline u16 advk_read16(struct advk_pcie *pcie, u64 reg)
> -{
> -	return advk_readl(pcie, (reg & ~0x3)) >> ((reg & 0x3) * 8);
> -}
> -
>  static int advk_pcie_link_up(struct advk_pcie *pcie)
>  {
>  	u32 val, ltssm_state;
> @@ -300,23 +295,9 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
>  
>  static void advk_pcie_issue_perst(struct advk_pcie *pcie)
>  {
> -	u32 reg;
> -
>  	if (!pcie->reset_gpio)
>  		return;
>  
> -	/*
> -	 * As required by PCI Express spec (PCI Express Base Specification, REV.
> -	 * 4.0 PCI Express, February 19 2014, 6.6.1 Conventional Reset) a delay
> -	 * for at least 100ms after de-asserting PERST# signal is needed before
> -	 * link training is enabled. So ensure that link training is disabled
> -	 * prior de-asserting PERST# signal to fulfill that PCI Express spec
> -	 * requirement.
> -	 */
> -	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> -	reg &= ~LINK_TRAINING_EN;
> -	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> -
>  	/* 10ms delay is needed for some cards */
>  	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
>  	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> @@ -324,53 +305,46 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
>  	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>  }
>  
> -static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
> +static void advk_pcie_train_link(struct advk_pcie *pcie)
>  {
> -	int ret, neg_gen;
> +	struct device *dev = &pcie->pdev->dev;
>  	u32 reg;
> +	int ret;
>  
> -	/* Setup link speed */
> +	/*
> +	 * Setup PCIe rev / gen compliance based on device tree property
> +	 * 'max-link-speed' which also forces maximal link speed.
> +	 */
>  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>  	reg &= ~PCIE_GEN_SEL_MSK;
> -	if (gen == 3)
> +	if (pcie->link_gen == 3)
>  		reg |= SPEED_GEN_3;
> -	else if (gen == 2)
> +	else if (pcie->link_gen == 2)
>  		reg |= SPEED_GEN_2;
>  	else
>  		reg |= SPEED_GEN_1;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
>  
>  	/*
> -	 * Enable link training. This is not needed in every call to this
> -	 * function, just once suffices, but it does not break anything either.
> +	 * Set maximal link speed value also into PCIe Link Control 2 register.
> +	 * Armada 3700 Functional Specification says that default value is based
> +	 * on SPEED_GEN but tests showed that default value is always 8.0 GT/s.
>  	 */
> +	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL2);
> +	reg &= ~PCI_EXP_LNKCTL2_TLS;
> +	if (pcie->link_gen == 3)
> +		reg |= PCI_EXP_LNKCTL2_TLS_8_0GT;
> +	else if (pcie->link_gen == 2)
> +		reg |= PCI_EXP_LNKCTL2_TLS_5_0GT;
> +	else
> +		reg |= PCI_EXP_LNKCTL2_TLS_2_5GT;
> +	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL2);
> +
> +	/* Enable link training after selecting PCIe generation */
>  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>  	reg |= LINK_TRAINING_EN;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
>  
> -	/*
> -	 * Start link training immediately after enabling it.
> -	 * This solves problems for some buggy cards.
> -	 */
> -	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL);
> -	reg |= PCI_EXP_LNKCTL_RL;
> -	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKCTL);
> -
> -	ret = advk_pcie_wait_for_link(pcie);
> -	if (ret)
> -		return ret;
> -
> -	reg = advk_read16(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_LNKSTA);
> -	neg_gen = reg & PCI_EXP_LNKSTA_CLS;
> -
> -	return neg_gen;
> -}
> -
> -static void advk_pcie_train_link(struct advk_pcie *pcie)
> -{
> -	struct device *dev = &pcie->pdev->dev;
> -	int neg_gen = -1, gen;
> -
>  	/*
>  	 * Reset PCIe card via PERST# signal. Some cards are not detected
>  	 * during link training when they are in some non-initial state.
> @@ -381,41 +355,18 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
>  	 * PERST# signal could have been asserted by pinctrl subsystem before
>  	 * probe() callback has been called or issued explicitly by reset gpio
>  	 * function advk_pcie_issue_perst(), making the endpoint going into
> -	 * fundamental reset. As required by PCI Express spec a delay for at
> -	 * least 100ms after such a reset before link training is needed.
> -	 */
> -	msleep(PCI_PM_D3COLD_WAIT);
> -
> -	/*
> -	 * Try link training at link gen specified by device tree property
> -	 * 'max-link-speed'. If this fails, iteratively train at lower gen.
> -	 */
> -	for (gen = pcie->link_gen; gen > 0; --gen) {
> -		neg_gen = advk_pcie_train_at_gen(pcie, gen);
> -		if (neg_gen > 0)
> -			break;
> -	}
> -
> -	if (neg_gen < 0)
> -		goto err;
> -
> -	/*
> -	 * After successful training if negotiated gen is lower than requested,
> -	 * train again on negotiated gen. This solves some stability issues for
> -	 * some buggy gen1 cards.
> +	 * fundamental reset. As required by PCI Express spec (PCI Express
> +	 * Base Specification, REV. 4.0 PCI Express, February 19 2014, 6.6.1
> +	 * Conventional Reset) a delay for at least 100ms after such a reset
> +	 * before sending a Configuration Request to the device is needed.
> +	 * So wait until PCIe link is up. Function advk_pcie_wait_for_link()
> +	 * waits for link at least 900ms.
>  	 */
> -	if (neg_gen < gen) {
> -		gen = neg_gen;
> -		neg_gen = advk_pcie_train_at_gen(pcie, gen);
> -	}
> -
> -	if (neg_gen == gen) {
> -		dev_info(dev, "link up at gen %i\n", gen);
> -		return;
> -	}
> -
> -err:
> -	dev_err(dev, "link never came up\n");
> +	ret = advk_pcie_wait_for_link(pcie);
> +	if (ret < 0)
> +		dev_err(dev, "link never came up\n");
> +	else
> +		dev_info(dev, "link up\n");
>  }
>  
>  /*
> -- 
> 2.32.0
> 
