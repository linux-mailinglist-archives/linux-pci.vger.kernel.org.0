Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2C36F97F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhD3LmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 07:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhD3LmT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 07:42:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 659E6613E7;
        Fri, 30 Apr 2021 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619782891;
        bh=Wx8uUkIc+TmCmqIqN5QNZvGHuWhtRr4leDR++xqZL4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRX/tU70kJHuFC31GVAGmRXG+BIQ0EjAKxQkV57hlk1VdvOHz7wIxnddzPS4y3dle
         ftBYIzbKK9AzRZ2yIbKG94B6IXCzaz5a9WbwDlhr5e9nT6XJApFOGVS8my8mXsvgep
         eXmJslO0fRSQ/sffJnEzLrquydfssNxvhRWfTMYYy7s/LaPfhWG0FafQvrbl83ooaL
         SyrG8xS+ndoJIlN871XFFtawjTFFJnbD/q6PJ9UtIbbX59X1oE5vfbUPaLgTuXpAjG
         ozEAC8nRqrqgoEVfZevbC+m2T3RN1VLgUR55r6pWffXVTY6cwKnwl/j0ebjP1CU9eo
         ERX+0EzRqeLmA==
Received: by pali.im (Postfix)
        id B019C883; Fri, 30 Apr 2021 13:41:28 +0200 (CEST)
Date:   Fri, 30 Apr 2021 13:41:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210430114128.zctpyinwhvk6iobi@pali>
References: <20210326124326.21163-1-pali@kernel.org>
 <20210427105525.23277-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210427105525.23277-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now I have tested another card ath10k card QCNFA435 (QCA9377 168c:0042)
and after link retraining it cause Synchronous external abort and AER
Uncorrected Non-Fatal error when trying to load ath10k_pci.ko driver.

# insmod /ath10k_pci.ko 
[   45.818017] Internal error: synchronous external abort: 96000210 [#1] SMP
[   45.825268] Modules linked in: ath10k_pci(+)
[   45.834695] CPU: 1 PID: 4050 Comm: insmod Not tainted 5.12.0-dirty #934
[   45.861149] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[   45.875585] pc : ath10k_pci_wake_wait+0x48/0xf8 [ath10k_pci]
[   45.887066] lr : ath10k_pci_wake.part.26+0xe0/0x110 [ath10k_pci]
[   45.901414] sp : ffffffc014c93820 
[   45.910833] x29: ffffffc014c93820 x28: ffffffc008cc68e0 
[   45.923663] x27: ffffff8000bf20c8 x26: ffffff800e578db8 
[   45.941605] x25: ffffffc008cc62b8 x24: ffffff8000bf2000 
[   45.957488] x23: ffffff800e578db8 x22: 000000000000752f 
[   45.975432] x21: ffffff800e571f20 x20: 0000000000000000 
[   45.995525] x19: 0000000000000005 x18: 0000000000000000 
[   46.011407] x17: 00000000000010f8 x16: 0000000000006400 
[   46.030872] x15: 0000000000000010 x14: 3030373030642065 
[   46.073937] x13: 00000000e8200000 x12: ffffffc010000000 
[   46.079418] x11: ffffffc0117bf000 x10: 00000000e8200000 
[   46.084900] x9 : ffffffc008cc2808 x8 : ffffffc011e00000 
[   46.090380] x7 : ffffff801ffff478 x6 : ffffffc011e00000 
[   46.095861] x5 : ffffffc008cc66a0 x4 : 0000000000200000 
[   46.101342] x3 : 0000000000000000 x2 : 0000000000000001 
[   46.106822] x1 : ffffffc011c80000 x0 : 0000000000080000 
[   46.112304] Call trace:
[   46.114825]  ath10k_pci_wake_wait+0x48/0xf8 [ath10k_pci]
[   46.120324]  ath10k_pci_wake.part.26+0xe0/0x110 [ath10k_pci]
[   46.126173]  ath10k_bus_pci_write32+0x78/0xd0 [ath10k_pci]
[   46.131841]  ath10k_ce_deinit_pipe+0x58/0x218
[   46.136343]  ath10k_pci_probe+0x1fc/0x8a8 [ath10k_pci]
[   46.141653]  pci_device_probe+0xbc/0x170
[   46.145703]  really_probe+0x1bc/0x414
[   46.149482]  driver_probe_device.part.15+0xcc/0x108
[   46.154513]  device_driver_attach+0x80/0x88
[   46.158831]  __driver_attach+0x64/0x120
[   46.162788]  bus_for_each_dev+0x68/0xa0
[   46.166746]  driver_attach+0x28/0x30
[   46.170433]  bus_add_driver+0x188/0x1e8
[   46.174390]  driver_register+0x68/0x118
[   46.178347]  __pci_register_driver+0x48/0x50
[   46.182751]  ath10k_pci_init+0x2c/0x1000 [ath10k_pci]
[   46.187972]  do_one_initcall+0x50/0x218
[   46.191930]  do_init_module+0x5c/0x240
[   46.195798]  load_module+0x1f94/0x24d0
[   46.199662]  __do_sys_init_module+0x120/0x1b8
[   46.204155]  __arm64_sys_init_module+0x20/0x28
[   46.208738]  el0_svc_common.constprop.3+0x90/0x120
[   46.213682]  do_el0_svc+0x74/0x90
[   46.217101]  el0_svc+0x20/0x30
[   46.220251]  el0_sync_handler+0x88/0xb0
[   46.224209]  el0_sync+0x13c/0x140
[   46.227632] Code: f94216a0 f9400ee1 b9405800 8b000021 (b9400021) 
[   46.233918] ---[ end trace 3619825164cb9b73 ]---
Segmentation fault
[   46.238818] pcieport 0000:00:00.0: AER: Uncorrected (Non-Fatal) error received: 0000:01:00.0
[   46.400457] ath10k_pci 0000:01:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
[   46.412426] ath10k_pci 0000:01:00.0:   device [168c:0042] error status/mask=00100000/00400000
[   46.421248] ath10k_pci 0000:01:00.0:    [20] UnsupReq               (First)
[   46.428771] ath10k_pci 0000:01:00.0: AER:   TLP Header: 40008001 0000020f e8080004 00000000
[   46.588115] pcieport 0000:00:00.0: AER: broadcast error_detected message

Adding this card into this quirk list fixes above issues for this card
too. I will send a V3 patch with 168c:0042 in quirk list.

On Tuesday 27 April 2021 12:55:25 Pali Rohár wrote:
> Atheros AR9xxx and QCA98xx chips do not behave not only after a bus reset
> but also after doing retrain link when PCIe bridge is not in GEN1 mode at
> 2.5 GT/s speed.
> 
> QCA9880 and QCA9890 chips throw a Link Down event and completely disappear
> from the bus and their config space is not accessible again.
> 
> AR9390 chip throws a Link Down event followed by Link Up event, config
> space is accessible again, but contains nonsense values. PCI device ID is
> 0xABCD which indicates HW bug that chip itself was not able to read values
> from internal EEPROM/OTP.
> 
> AR9287 chip throws also Link Down and Link Up events, also has accessible
> config space and moreover its config space contains correct values. But
> ath9k driver cannot initialize card from this state as it is unable to
> access HW registers. This also indicates that chip iself was not able to
> read values from internal EEPROM/OTP.
> 
> This issue related to PCI device ID 0xABCD and reading internal EEPROM/OTP
> was previously discussed at ath9k-devel mailing list in following thread:
> 
> https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg07529.html
> 
> After experiments we come up with workaround that Retrain link can be
> called only when using GEN1 PCIe bridge or when PCIe bridge has forced link
> speed to 2.5 GT/s via PCI_EXP_LNKCTL2 register.
> 
> This issue was reproduced with more cards: Compex WLE900VX (QCA9880 based /
> device ID 0x003c), Compex WLE200NX (AR9287 based / device ID 0x002e),
> "noname" card (QCA9890 based / device ID 0x003c) and Wistron NKR-DNXAH1
> (AR9390 based / device ID 0x0030) on Armada 385 with pci-mvebu.c driver and
> also on Armada 3720 with pci-aardvark.c driver.
> 
> To workaround this issue, this change introduces a new PCI quirk called
> PCI_DEV_FLAGS_NO_RETRAIN_LINK_WHEN_NOT_GEN1 which is enabled for all
> Atheros chips with PCI_DEV_FLAGS_NO_BUS_RESET quirk, plus also for Atheros
> chip AR9287.
> 
> When this quirk is set then kernel disallows triggering PCI_EXP_LNKCTL_RL
> bit in config space of PCIe Bridge in case PCIe Bridge is capable of higher
> speed than 2.5 GT/s and higher speed is already allowed. When PCIe Bridge
> has accessible LNKCTL2 register then kernel tries to force target link
> speed via PCI_EXP_LNKCTL2_TLS* bits to 2.5 GT/s. After this change it is
> possible to trigger PCI_EXP_LNKCTL_RL bit without causing issues on
> problematic Atheros cards.
> 
> Currently only PCIe ASPM kernel code triggers this PCI_EXP_LNKCTL_RL bit,
> so quirk check is added only into pcie/aspm.c file.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Tested-by: Marek Behún <kabel@kernel.org>
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
> ---
>  drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/quirks.c    | 37 ++++++++++++++++++++++++++--------
>  include/linux/pci.h     |  2 ++
>  3 files changed, 75 insertions(+), 8 deletions(-)
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
> +
> +	/* Check if link speed can be downgraded to 2.5 GT/s */
> +	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP2, &reg32);
> +	if (!(reg32 & PCI_EXP_LNKCAP2_SLS_2_5GB)) {
> +		pci_err(parent, "ASPM: Bridge does not support changing Link Speed to 2.5 GT/s\n");
> +		return -EOPNOTSUPP;
> +	}
> +
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
> +		pci_err(parent, "ASPM: Retrain Link at higher speed is disallowed by quirk\n");
> +		return false;
> +	}
> +
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
>  	reg16 |= PCI_EXP_LNKCTL_RL;
>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..68c5e8f4ff8c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3553,23 +3553,44 @@ static void mellanox_check_broken_intx_masking(struct pci_dev *pdev)
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
> + * Atheros AR9xxx and QCA98xx chips do not behave after a bus reset and also
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
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.20.1
> 
