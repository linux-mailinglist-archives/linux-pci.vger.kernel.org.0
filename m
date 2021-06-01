Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828BB397AFB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhFAUHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 16:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234816AbhFAUHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 16:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 370C1613C3;
        Tue,  1 Jun 2021 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622577951;
        bh=KR8R8Zdxc5/u4M59leRzahXKLRI8a+3iGb05vJUZQP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HHc9m0JJClL8SS+lv9Clyz0639Zb5EWDNg7+X0TVvsL3Q2NjemD6Wj0e8jkHYTJhe
         fF84VGyijMMCqZ/iUTYJ+N3dSiDHYozfrRIF5NXK97oDNG3w1J6G7OWJAg+0OialyW
         aQWc74JEFjqqIsbQZzk6i2sFAKv12fr3PyivT+T7WD+haYdv6eqjpNvOLeECgqhqD0
         ymhTD2jEncppql0EXK7yFaf3nuoMlbbUQ3wzA98Ft1kLb3npFxBMgbFmUHLdaF1PyZ
         9vdgTen1Gxe5vEZfIbRHOJJMhnFBWBOHrBR8bWE3OguBTQPTp7weWtBvmManCXk262
         klY67kGZJEDeA==
Date:   Tue, 1 Jun 2021 15:05:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210601200549.GA1965100@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505163357.16012-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 05, 2021 at 06:33:57PM +0200, Pali Roh�r wrote:
> Atheros AR9xxx and QCA9xxx chips have behaviour issues not only after a
> bus reset, but also after doing retrain link, if PCIe bridge is not in
> GEN1 mode (at 2.5 GT/s speed):
> 
> - QCA9880 and QCA9890 chips throw a Link Down event and completely
>   disappear from the bus and their config space is not accessible
>   afterwards.
> 
> - QCA9377 chip throws a Link Down event followed by Link Up event, the
>   config space is accessible and PCI device ID is correct. But trying to
>   access chip's I/O space causes Uncorrected (Non-Fatal) AER error,
>   followed by Synchronous external abort 96000210 and Segmentation fault
>   of insmod while loading ath10k_pci.ko module.
> 
> - AR9390 chip throws a Link Down event followed by Link Up event, config
>   space is accessible, but contains nonsense values. PCI device ID is
>   0xABCD which indicates HW bug that chip itself was not able to read
>   values from internal EEPROM/OTP.
> 
> - AR9287 chip throws also Link Down and Link Up events, also has
>   accessible config space containing correct values. But ath9k driver
>   fails to initialize card from this state as it is unable to access HW
>   registers. This also indicates that the chip iself is not able to read
>   values from internal EEPROM/OTP.
> 
> These issues related to PCI device ID 0xABCD and to reading internal
> EEPROM/OTP were previously discussed at ath9k-devel mailing list in
> following thread:
> 
>   https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
> 
> After experiments we've come up with a solution: it seems that Retrain
> link can be called only when using GEN1 PCIe bridge or when PCIe bridge
> link speed is forced to 2.5 GT/s. Applying this workaround fixes all
> mentioned cards.

I *assume* this means the device was running at > 2.5 GT/s in the
first place, and when aspm.c retrains the link to configure the common
clock, we downgrade to 2.5 GT/s, so the device is now slower than it
used to be?

Is that slower speed acceptable?  Is it better to be slower with ASPM,
or faster without ASPM?  Or maybe it could be faster *with* ASPM if we
avoided the common clock config and the retrain?  I think that would
give up some of the benefit of ASPM, but maybe it would still be
worthwhile?

If the device was running at > 2.5 GT/s to begin with, obviously there
is *some* way to get there.  This patch implies that the hardware
automatically trained to a higher rate after power-on (which I think
is what PCIe hardware is *supposed* to do) and something prevents that
from succeeding when we retrain, or maybe BIOS did something different
than what Linux is doing, or ... something else?

Maybe the device can only retrain to 2.5 GT/s or from the current
speed to a higher speed.  This sort of experimentation could probably
be done with setpci.

> This issue was reproduced with more cards:
> - Compex WLE900VX (QCA9880 based / device ID 0x003c)
> - QCNFA435 (QCA9377 based / device ID 0x0042)
> - Compex WLE200NX (AR9287 based / device ID 0x002e)
> - "noname" card (QCA9890 based / device ID 0x003c)
> - Wistron NKR-DNXAH1 (AR9390 based / device ID 0x0030)
> on Armada 385 with pci-mvebu.c driver and also on Armada 3720 with
> pci-aardvark.c driver.
> 
> To workaround this issue, this change introduces a new PCI quirk called
> PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1, which is enabled for all
> Atheros chips with PCI_DEV_FLAGS_NO_BUS_RESET quirk, and also for Atheros
> chip AR9287.
> 
> When this quirk is set, kernel disallows triggering PCI_EXP_LNKCTL_RL
> bit in config space of PCIe Bridge in the case when PCIe Bridge is
> capable of higher speed than 2.5 GT/s and this higher speed is already
> allowed. When PCIe Bridge has accessible LNKCTL2 register, we try to
> force target link speed to 2.5 GT/s. After this change it is possible
> to trigger PCI_EXP_LNKCTL_RL bit without issues.

This basically feels like a "it hurts when I do X, so stop doing X"
patch.  We don't really know what's wrong; we've just determined
experimentally how to avoid it.

> Currently only PCIe ASPM kernel code triggers this PCI_EXP_LNKCTL_RL bit,
> so quirk check is added only into pcie/aspm.c file.
> 
> Signed-off-by: Pali Roh�r <pali@kernel.org>
> Reported-by: Toke H�iland-J�rgensen <toke@redhat.com>
> Tested-by: Toke H�iland-J�rgensen <toke@redhat.com>
> Tested-by: Marek Beh�n <kabel@kernel.org>
> BugLink: https://lore.kernel.org/linux-pci/87h7l8axqp.fsf@toke.dk/
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=84821
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=192441
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209833
> Cc: stable@vger.kernel.org # c80851f6ce63a ("PCI: Add PCI_EXP_LNKCTL2_TLS* macros")
> 
> ---
> Changes since v1:
> * Move whole quirk code into pcie_downgrade_link_to_gen1() function
> * Reformat to 80 chars per line where possible
> * Add quirk also for cards with AR9287 chip (PCI ID 0x002e)
> * Extend commit message description and add information about 0xABCD
> 
> Changes since v2:
> * Add quirk also for Atheros QCA9377 chip
> ---
>  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/quirks.c    | 39 ++++++++++++++++++++++++++++--------
>  include/linux/pci.h     |  2 ++
>  3 files changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ac0557a305af..729b0389562b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -192,12 +192,56 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
>  
> +static int pcie_downgrade_link_to_gen1(struct pci_dev *parent)
> +{
> +	u16 reg16;
> +	u32 reg32;
> +	int ret;
> +
> +	/* Check if link is capable of higher speed than 2.5 GT/s */
> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &reg32);
> +	if ((reg32 & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +		return 0;

I guess this means "if the link is already at 2.5 GT/s, no need to do
anything."  Right?

> +	/* Check if link speed can be downgraded to 2.5 GT/s */
> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &reg32);
> +	if (!(reg32 & PCI_EXP_LNKCAP2_SLS_2_5GB)) {
> +		pci_err(parent, "ASPM: Bridge does not support changing Link Speed to 2.5 GT/s\n");
> +		return -EOPNOTSUPP;
> +	}

Why is this check needed?  Per PCIe r5.0, sec 8.2.1, all devices must
support 2.5 GT/s.

> +	/* Force link speed to 2.5 GT/s */
> +	ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
> +						 PCI_EXP_LNKCTL2_TLS,
> +						 PCI_EXP_LNKCTL2_TLS_2_5GT);
> +	if (!ret) {
> +		/* Verify that new value was really set */
> +		pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &reg16);
> +		if ((reg16 & PCI_EXP_LNKCTL2_TLS) != PCI_EXP_LNKCTL2_TLS_2_5GT)
> +			ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		pci_err(parent, "ASPM: Changing Target Link Speed to 2.5 GT/s failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pci_info(parent, "ASPM: Target Link Speed changed to 2.5 GT/s due to quirk\n");
> +	return 0;
> +}
> +
>  static bool pcie_retrain_link(struct pcie_link_state *link)
>  {
>  	struct pci_dev *parent = link->pdev;
>  	unsigned long end_jiffies;
>  	u16 reg16;
>  
> +	if ((link->downstream->dev_flags & PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1) &&
> +	    pcie_downgrade_link_to_gen1(parent)) {

I assume (correct me if I'm wrong) that this would work equally well
if we set the *endpoint's* target link speed to 2.5 GT/s instead of
the upstream bridge's?  I think the log messages would make more sense
then, since the problem is really with the endpoint, not the parent.

> +		pci_err(parent, "ASPM: Retrain Link at higher speed is disallowed by quirk\n");
> +		return false;
> +	}
> +
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>  	reg16 |= PCI_EXP_LNKCTL_RL;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..4999ad9d08b8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3553,23 +3553,46 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>  			mellanox_check_broken_intx_masking);
>  
> -static void quirk_no_bus_reset(struct pci_dev *dev)
> +static void quirk_no_bus_reset_and_no_retrain_link(struct pci_dev *dev)
>  {
> -	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> +	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET |
> +			  PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1;
>  }
>  
>  /*
> - * Some Atheros AR9xxx and QCA988x chips do not behave after a bus reset.
> + * Atheros AR9xxx and QCA9xxx chips do not behave after a bus reset and also
> + * after retrain link when PCIe bridge is not in GEN1 mode at 2.5 GT/s speed.
>   * The device will throw a Link Down error on AER-capable systems and
>   * regardless of AER, config space of the device is never accessible again
>   * and typically causes the system to hang or reset when access is attempted.
> + * Or if config space is accessible again then it contains only dummy values
> + * like fixed PCI device ID 0xABCD or values not initialized at all.
> + * Retrain link can be called only when using GEN1 PCIe bridge or when
> + * PCIe bridge has forced link speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.
> + * To reset these cards it is required to do PCIe Warm Reset via PERST# pin.
>   * https://lore.kernel.org/r/20140923210318.498dacbd@dualc.maya.org/
> + * https://lore.kernel.org/r/87h7l8axqp.fsf@toke.dk/
> + * https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
>   */
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x002e,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0042,
> +			 quirk_no_bus_reset_and_no_retrain_link);
> +
> +static void quirk_no_bus_reset(struct pci_dev *dev)
> +{
> +	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> +}
>  
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..fdbf7254e4ab 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -227,6 +227,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>  	/* Don't use Relaxed Ordering for TLPs directed at this device */
>  	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +	/* Don't Retrain Link for device when bridge is not in GEN1 mode */
> +	PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 = (__force pci_dev_flags_t) (1 << 12),

I know this is entangled with the existing PCI_DEV_FLAGS_NO_BUS_RESET,
but unless there's a better reason to use pci_dev_flags, I'd prefer a
new "unsigned retrain_gen1:1" or similar bit.  

Whatever you do, I'd like to avoid the double negative of "*no*
retrain when *not* gen1."

It does make me wonder whether the bus reset would work on these
devices if we set the target link speed back down to 2.5 GT/s.

>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.20.1
> 
