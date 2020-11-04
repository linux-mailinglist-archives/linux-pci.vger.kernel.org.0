Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4682A695B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKDQWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 11:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbgKDQWh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 11:22:37 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1321D206D4;
        Wed,  4 Nov 2020 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604506955;
        bh=5T3o008IqLba0FOqaSx4iPCQuyKS97qNtxWoYeXR6Ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ellmeg/FtXoZGaFEkLfwCPCDcBXnQPy50bjuyL+V6V6gPKPzhty1CZiPYxN6mFAsb
         kuCotLUEyDiqVVbP9BapsphgTxQLCjRNbhbWzrLHyyCeRLLjWZgOMx3MCbeeYaAIV1
         no97ghsNuAJ7ba+i1teafW3wfohi+4rh76hdFGms=
Date:   Wed, 4 Nov 2020 10:22:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, robh@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Message-ID: <20201104162233.GA341405@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea9b090-b938-b5eb-e8da-0bf9d15238a3@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 04, 2020 at 05:13:07PM +0530, Vidya Sagar wrote:
> On 11/4/2020 2:37 AM, Bjorn Helgaas wrote:
> > On Tue, Nov 03, 2020 at 08:57:01AM +0530, Vidya Sagar wrote:
> > > On 11/3/2020 4:32 AM, Bjorn Helgaas wrote:
> > > > On Thu, Oct 29, 2020 at 11:09:59AM +0530, Vidya Sagar wrote:
> > > > > DesignWare core has a TLP digest (TD) override bit in one of the control
> > > > > registers of ATU. This bit also needs to be programmed for proper ECRC
> > > > > functionality. This is currently identified as an issue with DesignWare
> > > > > IP version 4.90a. This patch does the required programming in ATU upon
> > > > > querying the system policy for ECRC.
> > > > 
> > > > I guess this is a hardware defect, right?
> > > Yes. This is common across all DWC implementations (version 4.90 precisely)
> > > 
> > > > How much of a problem would it be if we instead added a "no_ecrc"
> > > > quirk for this hardware so we never enabled ECRC?
> > > Well, on Tegra for some of the high fidelity use cases, ECRC is required to
> > > be turned on and if it can be done safely with these patches, why shouldn't
> > > we not enable ECRC at all?
> > > 
> > > > IIUC, the current Linux support of ECRC is a single choice at
> > > > boot-time: by default ECRC is not enabled, but if you boot with
> > > > "pci=ecrc=on", we turn on ECRC for every device.
> > > > 
> > > > That seems like the minimal support, but I think the spec allows ECRC
> > > > to be enabled selectively, on individual devices.  I can imagine a
> > > > sysfs knob that would allow us to enable/disable ECRC per-device at
> > > > run-time.
> > > > 
> > > > If we had such a sysfs knob, it would be pretty ugly and maybe
> > > > impractical to work around this hardware issue.  So I'm a little bit
> > > > hesitant to add functionality that might have to be removed in the
> > > > future.
> > > 
> > > Agree with this. But since it is a boot-time choice at this point, I think
> > > we can still go ahead with this approach to have a working ECRC mechanism
> > > right? I don't see any sysfs knob for AER controlling at this point.
> > 
> > I don't want to do anything that will prevent us from adding
> > per-device ECRC control in the future.
> > 
> > My concern is that if we add a run-time sysfs knob in the future, the
> > user experience on this hardware will be poor because there's no
> > convenient path to twiddle the PCIE_ATU_TD bit when the generic code
> > changes the AER Control bit.
>
> Agree.
> Can we add it to the documentation that run time changing of ECRC settings
> are not supported on this (i.e. Tegra194) platform (or for that matter on
> any SoC with PCIe based on DesignWare core version 4.90A). By 'not
> supported', I meant that the ECRC digest part may not work but the normal
> functionality will continue to work without reporting any AER errors. I
> tried to emulate the following scenarios on Tegra194 silicon and here are my
> observations.
> FWIW, I'm referring to the PCIe spec Rev 5.0 Ver 1.0 (22 May 2019)
> 
> > What is the failure mode in these scenarios:
> > 
> >    - User boots with defaults, ECRC is disabled.
> >    - User enables ECRC via sysfs.
> >    - What happens here?  ECRC is enabled via AER Control but not via
> >      DWC TD bit.  I assume ECRC doesn't work.  Does it cause PCIe
> >      errors (malformed TLP, etc)?
>
> Since DWC TD bit is not programmed, for all the transactions that go through
> ATU, TLP Digest won't get generated (although AER registers indicate that
> ECRC should get generated).
> As per the spec section "2.7.1 ECRC Rules"
> 
> ---
> If a device Function is enabled to generate ECRC, it must calculate and
> apply ECRC for all TLPs originated by the Function
> ---
> 
> So the RP would be violating the PCIe spec, but it doesn't result in any
> error because the same section has the following rule as well
> 
> ---
> If a device Function is enabled to check ECRC, it must do so for all TLPs
> with ECRC where the device is the ultimate PCI Express Receiver
> 	Note that it is still possible for the Function to receive TLPs without
> ECRC, and these are processed normally - this is not an error
> ---
> 
> so, even if the EP has ECRC check enabled, because of the above rule, it
> just processes those packets without ECRC as normal packets.
> Basically, whoever is enabling ECRC run time gets cheated as transactions
> routed through ATU don't really have ECRC digest
> 
> > Or this one:
> > 
> >    - User boots with "pci=ecrc=on", ECRC is enabled.
> >    - ECRC works fine.
> >    - User disables ECRC via sysfs.
> >    - What happens here?  ECRC is disabled via AER Control, but DWC TD
> >      bit thinks it's still enabled.
>
> In this case, the EP doesn't have ECRC check enabled but receives TLPs with
> ECRC digest. This again won't result in any error because of the section
> "2.2.3 TLP Digest Rules" which says
> 
> ---
> If an intermediate or ultimate PCI Express Receiver of the TLP does not
> support ECRC checking, the Receiver must ignore the TLP Digest
> ---
> 
> So the EP just ignores the TLP Digest and process the TLP normally.
> Although functionality wise there is no issue here, there could be some
> impact on the perf because of the extra DWord data. This is again debatable
> as the perf/data path is typically from EP's DMA engine to host system
> memory and not config/BAR accesses.
> > 
> > If you enabled ECRC unconditionally on DWC and the sysfs knob had no
> > effect, I'd be OK with that.  I'm more worried about what happens when
> > the AER bit and the DWC TD bit are set so they don't match.  What is
> > the failure mode there?
>
> Based on the above experiments, we can as well keep the DWC TD bit
> programmed unconditionally and it won't lead to any errors. As mentioned
> before, the only downside of it is the extra DWord in each ATU routed TLP
> which may load the bus (in downstream direction) with no real benefit as
> such.

IIUC the issue only affects traffic from the Root Port to the
Endpoint, and traffic going upstream is unaffected.  Here's what I
think happens based on the RP and EP settings, please correct me if
wrong:

  1)  RP TD+ ECRC_gen+       generates ECRC
      EP     ECRC_check-     ignores ECRC
      EP     ECRC_check+     checks ECRC

  2)  RP TD+ ECRC_gen-       generates ECRC when it shouldn't (defect)
      EP     ECRC_check-     ignores ECRC
      EP     ECRC_check+     checks ECRC (may signal errors)

  3)  RP TD- ECRC_gen+       fails to generate ECRC (defect)
      EP     ECRC_check-     ignores ECRC
      EP     ECRC_check+     handles TLPs without ECRC normally,
                             but cannot detect ECRC errors

  4)  RP TD- ECRC_gen-       no ECRC generated (as expected)
      EP     ECRC_check-     ignores ECRC
      EP     ECRC_check+     handles TLPs without ECRC normally

If my assumptions above are correct, this defect never causes extra
errors like Malformed TLP, etc, to be signaled regardless of the AER
ECRC_check settings.

The only functional problem is that in case 3, the EP *should* be able
to check and signal ECRC errors, but it cannot because the RP doesn't
generate ECRC.

Case 2 is a performance issue because we add the extra dword in every
TLP going downstream.  That doesn't seem unreasonable since this is
just config and BAR accesses.  The EP may detect ECRC errors when we
don't think the RP is even generating ECRC, but in general we won't
enable checking in the EP unless we also enable generation in the RP.

So I think setting the DWC TD bit unconditionally seems like a pretty
good solution.

> Please let me know where can we go from here.
> I can push a different patch to keep DWC TD bit always programmed if that is
> the best approach to take at this point.
> > 
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> > > > > ---
> > > > > V3:
> > > > > * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
> > > > > 
> > > > > V2:
> > > > > * Addressed Jingoo's review comment
> > > > > * Removed saving 'td' bit information in 'dw_pcie' structure
> > > > > 
> > > > >    drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
> > > > >    drivers/pci/controller/dwc/pcie-designware.h | 1 +
> > > > >    2 files changed, 7 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index b5e438b70cd5..cbd651b219d2 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > > > >         dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > > > >                                  upper_32_bits(pci_addr));
> > > > >         val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > > > +     if (pci->version == 0x490A)
> > > > > +             val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
> > > > >         val = upper_32_bits(size - 1) ?
> > > > >                 val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> > > > >         dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > > > > @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > > > >                            lower_32_bits(pci_addr));
> > > > >         dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
> > > > >                            upper_32_bits(pci_addr));
> > > > > -     dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> > > > > -                        PCIE_ATU_FUNC_NUM(func_no));
> > > > > +     val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > > > +     if (pci->version == 0x490A)
> > > > > +             val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
> > > > > +     dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> > > > >         dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> > > > > 
> > > > >         /*
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > index e7f441441db2..b01ef407fd52 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > @@ -89,6 +89,7 @@
> > > > >    #define PCIE_ATU_TYPE_IO             0x2
> > > > >    #define PCIE_ATU_TYPE_CFG0           0x4
> > > > >    #define PCIE_ATU_TYPE_CFG1           0x5
> > > > > +#define PCIE_ATU_TD_SHIFT            8
> > > > >    #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> > > > >    #define PCIE_ATU_CR2                 0x908
> > > > >    #define PCIE_ATU_ENABLE                      BIT(31)
> > > > > --
> > > > > 2.17.1
> > > > > 
