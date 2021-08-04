Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE53DFFAA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhHDKxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 06:53:41 -0400
Received: from foss.arm.com ([217.140.110.172]:59188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237653AbhHDKxj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Aug 2021 06:53:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BF2013A1;
        Wed,  4 Aug 2021 03:53:26 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF84F3F719;
        Wed,  4 Aug 2021 03:53:23 -0700 (PDT)
Date:   Wed, 4 Aug 2021 11:53:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v7 5/7] PCI: cadence: Add support to configure virtual
 functions
Message-ID: <20210804105318.GA31443@lpieralisi>
References: <20210803050310.27122-1-kishon@ti.com>
 <20210803050310.27122-6-kishon@ti.com>
 <20210803114530.GE11252@lpieralisi>
 <be907fe7-4095-e28b-5575-76629edc30f0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be907fe7-4095-e28b-5575-76629edc30f0@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 08:26:42PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 03/08/21 5:15 pm, Lorenzo Pieralisi wrote:
> > On Tue, Aug 03, 2021 at 10:33:08AM +0530, Kishon Vijay Abraham I wrote:
> >> Now that support for SR-IOV is added in PCIe endpoint core, add support
> >> to configure virtual functions in the Cadence PCIe EP driver.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> Acked-by: Tom Joseph <tjoseph@cadence.com>
> >> ---
> >>  .../pci/controller/cadence/pcie-cadence-ep.c  | 241 +++++++++++++++---
> >>  drivers/pci/controller/cadence/pcie-cadence.h |   7 +
> >>  2 files changed, 217 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> >> index 912a15be8bfd..791915054ff4 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> >> @@ -20,7 +20,18 @@ static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
> >>  				     struct pci_epf_header *hdr)
> >>  {
> >>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> >> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> >>  	struct cdns_pcie *pcie = &ep->pcie;
> >> +	u32 reg;
> >> +
> >> +	if (vfn > 1) {
> >> +		dev_dbg(&epc->dev, "Only Virtual Function #1 has deviceID\n");
> >> +		return 0;
> > 
> > Shouldn't this return an error ?
> 
> Since the same function driver could be used for physical function and
> virtual function, I tried to avoid adding any additional case specific
> for virtual function in the function driver.
> 
> If we want to return an error here, then the function driver should be
> modified to not invoke writeheader for vfn > 1.

Well, I see it the other way around. If writing the header for vfn > 1
is an error it must be reported as such and handled accordingly.

As it stands - it looks like we do nothing and everything is just
fine, which is weird.

Thanks,
Lorenzo

> >> +	} else if (vfn == 1) {
> >> +		reg = cap + PCI_SRIOV_VF_DID;
> >> +		cdns_pcie_ep_fn_writew(pcie, fn, reg, hdr->deviceid);
> >> +		return 0;
> >> +	}
> >>  
> >>  	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
> >>  	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
> >> @@ -51,12 +62,14 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> >>  				struct pci_epf_bar *epf_bar)
> >>  {
> >>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> >> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> >>  	struct cdns_pcie_epf *epf = &ep->epf[fn];
> >>  	struct cdns_pcie *pcie = &ep->pcie;
> >>  	dma_addr_t bar_phys = epf_bar->phys_addr;
> >>  	enum pci_barno bar = epf_bar->barno;
> >>  	int flags = epf_bar->flags;
> >>  	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
> >> +	u32 first_vf_offset, stride;
> >>  	u64 sz;
> >>  
> >>  	/* BAR size is 2^(aperture + 7) */
> >> @@ -92,26 +105,50 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> >>  
> >>  	addr0 = lower_32_bits(bar_phys);
> >>  	addr1 = upper_32_bits(bar_phys);
> >> +
> >> +	if (vfn == 1) {
> >> +		/* All virtual functions use the same BAR config */
> >> +		if (bar < BAR_4) {
> >> +			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG0(fn);
> >> +			b = bar;
> >> +		} else {
> >> +			reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG1(fn);
> >> +			b = bar - BAR_4;
> >> +		}
> >> +	} else if (vfn == 0) {
> >> +		/* BAR configuration for physical function */
> >> +		if (bar < BAR_4) {
> >> +			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
> >> +			b = bar;
> >> +		} else {
> >> +			reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
> >> +			b = bar - BAR_4;
> >> +		}
> >> +	}
> > 
> > Code in both branches is almost identical except for what is
> > assigned to reg, it is not fundamental but maybe it can be rewritten
> > more concisely.
> 
> okay.. let me think.
> 
> Thanks
> Kishon
