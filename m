Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCE439C249
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFDVX6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 17:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhFDVX5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 17:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C89FC611AD;
        Fri,  4 Jun 2021 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622841731;
        bh=PUDS1LX1g2/cA5rbPUUtQNVnGSRWVHuo2k/SadWrLaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DnkOdjMlJI3lkYnrnqlx67z36V6vLTPI+wHSCGm4gsKhboOqtH/+ZZp93dm9nD0YX
         eLPZGO66noHP88yeWU603JlwtADoadvOUbQM6nuA0Z2QvshmrIAII7fqg31JU2+HFR
         pIKv6c1HipBn2y3G52GKaCPrWWol0Z5BVfgNwQW/Z+CFogtsKyeYm10SNJcq4jl6in
         RQYIo3pfAX16WXrYoRtCFecVHY+8tOCO3yOB9zIRYr41r1Wh5q8L8Vmfguyz9DEgan
         dSTCygPkiPViIXHBPYQTs6jvnawJsAVk3eTKikAmrAdTWu3T3NFyA86zLMtZJCuFsC
         91yvAGaWf+NZw==
Date:   Fri, 4 Jun 2021 16:22:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kw@linux.com, kishon@ti.com,
        mparab@cadence.com, sjakhade@cadence.com, pthombar@cadence.com
Subject: Re: [PATCH] [v2] PCI: cadence: Set LTSSM Detect Quiet state minimum
 delay as workaround for training defect.
Message-ID: <20210604212209.GA2240608@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528155626.21793-1-nadeem@cadence.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 28, 2021 at 05:56:26PM +0200, Nadeem Athani wrote:
> PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
> another protocol. For example, link training fails if lanes 2 and 3 are
> assigned to another protocol while lanes 0 and 1 are used for PCIe to
> form a two lane link. This failure is due to an incorrect tie-off on an
> internal status signal indicating electrical idle.
> 
> Status signals going from SERDES to PCIe Controller are tied-off when a
> lane is not assigned to PCIe. Signal indicating electrical idle is
> incorrectly tied-off to a state that indicates non-idle. As a result,
> PCIe sees unused lanes to be out of electrical idle and this causes
> LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
> occur. If a receiver is not detected on the first receiver detection
> attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
> again moves forward to Detect.Active state without waiting for 12ms as
> required by PCIe base specification. Since wait time in Detect.Quiet is
> skipped, multiple receiver detect operations are performed back-to-back
> without allowing time for capacitance on the transmit lines to
> discharge. This causes subsequent receiver detection to always fail even
> if a receiver gets connected eventually.
> 
> Adding a quirk flag "quirk_detect_quiet_flag" to program the minimum
> time that LTSSM waits on entering Detect.Quiet state.
> Setting this to 2ms for specific TI j7200 SOC as a workaround to resolve
> a link training issue in IP.
> In future revisions this setting will not be required.
> 
> As per PCIe specification, all Receivers must meet the Z-RX-DC
> specification for 2.5 GT/s within 1ms of entering Detect.Quiet LTSSM
> substate. The LTSSM must stay in this substate until the ZRXDC
> specification for 2.5 GT/s is met.
> 
> 00 : 0 minimum wait time in Detect.Quiet state.
> 01 : 100us minimum wait time in Detect.Quiet state.
> 10 : 1ms minimum wait time in Detect.Quiet state.
> 11 : 2ms minimum wait time in Detect.Quiet state.
> 
> Changes in v2:
> 1. Adding the function cdns_pcie_detect_quiet_min_delay_set in
> pcie-cadence.c and invoking it from host and endpoint driver file.
> 
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c   |  4 ++++
>  drivers/pci/controller/cadence/pcie-cadence-host.c |  3 +++
>  drivers/pci/controller/cadence/pcie-cadence.c      | 17 +++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      | 15 +++++++++++++++
>  4 files changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 897cdde02bd8..dd7df1ac7fda 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -623,6 +623,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
>  	/* Reserve region 0 for IRQs */
>  	set_bit(0, &ep->ob_region_map);
> +
> +	if (ep->quirk_detect_quiet_flag)
> +		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
> +
>  	spin_lock_init(&ep->lock);
>  
>  	return 0;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index ae1c55503513..fb96d37a135c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -498,6 +498,9 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  		return PTR_ERR(rc->cfg_base);
>  	rc->cfg_res = res;
>  
> +	if (rc->quirk_detect_quiet_flag)
> +		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> +
>  	ret = cdns_pcie_start_link(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to start link\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 3c3646502d05..65b6c8bed0d4 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -7,6 +7,23 @@
>  
>  #include "pcie-cadence.h"
>  
> +void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
> +{
> +	u32 delay = 0x3;
> +	u32 ltssm_control_cap;
> +
> +	/*
> +	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
> +	 */
> +
> +	ltssm_control_cap = cdns_pcie_readl(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP);
> +	ltssm_control_cap = ((ltssm_control_cap &
> +			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
> +			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LTSSM_CONTROL_CAP, ltssm_control_cap);
> +}
> +
>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>  				   u32 r, bool is_io,
>  				   u64 cpu_addr, u64 pci_addr, size_t size)
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 254d2570f8c9..ccdf9cee9dde 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -189,6 +189,14 @@
>  /* AXI link down register */
>  #define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
>  
> +/* LTSSM Capabilities register */
> +#define CDNS_PCIE_LTSSM_CONTROL_CAP             (CDNS_PCIE_LM_BASE + 0x0054)
> +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(2, 1)
> +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT 1
> +#define  CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
> +	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
> +	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
> +
>  enum cdns_pcie_rp_bar {
>  	RP_BAR_UNDEFINED = -1,
>  	RP_BAR0,
> @@ -292,6 +300,7 @@ struct cdns_pcie {
>   * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and	RP_NO_BAR if it's free or
>   *                available
>   * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
> + * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>   */
>  struct cdns_pcie_rc {
>  	struct cdns_pcie	pcie;
> @@ -301,6 +310,7 @@ struct cdns_pcie_rc {
>  	u32			device_id;
>  	bool			avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
>  	bool                    quirk_retrain_flag;
> +	bool                    quirk_detect_quiet_flag;
>  };
>  
>  /**
> @@ -331,6 +341,7 @@ struct cdns_pcie_epf {
>   *        registers fields (RMW) accessible by both remote RC and EP to
>   *        minimize time between read and write
>   * @epf: Structure to hold info about endpoint function
> + * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>   */
>  struct cdns_pcie_ep {
>  	struct cdns_pcie	pcie;
> @@ -345,6 +356,7 @@ struct cdns_pcie_ep {
>  	/* protect writing to PCI_STATUS while raising legacy interrupts */
>  	spinlock_t		lock;
>  	struct cdns_pcie_epf	*epf;
> +	bool                    quirk_detect_quiet_flag;

1) I don't see this being set anywhere.  Are there follow-on patches
that set it?  We try not to merge things until they are actually used.

2) I typically use "unsigned int foo:1" in structures for this ancient
reason [1].  But it's not always practical, e.g., with the
avail_ib_bar[] array above, and I do see that this follows the
existing style in the file, which is good.

[1] https://lore.kernel.org/linux-fsdevel/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76-NcjTj-g@mail.gmail.com/

>  };
>  
>  
> @@ -505,6 +517,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	return 0;
>  }
>  #endif
> +
> +void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> +
>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>  				   u32 r, bool is_io,
>  				   u64 cpu_addr, u64 pci_addr, size_t size);
> -- 
> 2.15.0
> 
