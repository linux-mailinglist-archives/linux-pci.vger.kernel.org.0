Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF02A5548
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 22:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbgKCVH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 16:07:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbgKCVH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 16:07:56 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164C5205ED;
        Tue,  3 Nov 2020 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604437675;
        bh=kNkkSf7GPZiZAoqJ4K7JDQg+4mkspW6utqW9bsMXaRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DBZAyCEzm0RNhkKpX+AaNvGVOqS0tWxzITpV2mfMXesSYXmDA3qzmQzZtjy0RoAKs
         VQMnfwlCsfbxQrO7ISxXza9qO5LEIQJ5AUVtAkJGs/MxcvS3VXYimKr5744Y5WlSES
         qZY5aZFyJYD09m4QBV9cj1Ua/WwKyvophPASsMnU=
Date:   Tue, 3 Nov 2020 15:07:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, robh@kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Message-ID: <20201103210753.GA264744@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad86fd8c-ea49-fa87-b491-348503d0bd52@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03, 2020 at 08:57:01AM +0530, Vidya Sagar wrote:
> On 11/3/2020 4:32 AM, Bjorn Helgaas wrote:
> > On Thu, Oct 29, 2020 at 11:09:59AM +0530, Vidya Sagar wrote:
> > > DesignWare core has a TLP digest (TD) override bit in one of the control
> > > registers of ATU. This bit also needs to be programmed for proper ECRC
> > > functionality. This is currently identified as an issue with DesignWare
> > > IP version 4.90a. This patch does the required programming in ATU upon
> > > querying the system policy for ECRC.
> > 
> > I guess this is a hardware defect, right?
> Yes. This is common across all DWC implementations (version 4.90 precisely)
> 
> > How much of a problem would it be if we instead added a "no_ecrc"
> > quirk for this hardware so we never enabled ECRC?
> Well, on Tegra for some of the high fidelity use cases, ECRC is required to
> be turned on and if it can be done safely with these patches, why shouldn't
> we not enable ECRC at all?
> 
> > IIUC, the current Linux support of ECRC is a single choice at
> > boot-time: by default ECRC is not enabled, but if you boot with
> > "pci=ecrc=on", we turn on ECRC for every device.
> > 
> > That seems like the minimal support, but I think the spec allows ECRC
> > to be enabled selectively, on individual devices.  I can imagine a
> > sysfs knob that would allow us to enable/disable ECRC per-device at
> > run-time.
> > 
> > If we had such a sysfs knob, it would be pretty ugly and maybe
> > impractical to work around this hardware issue.  So I'm a little bit
> > hesitant to add functionality that might have to be removed in the
> > future.
>
> Agree with this. But since it is a boot-time choice at this point, I think
> we can still go ahead with this approach to have a working ECRC mechanism
> right? I don't see any sysfs knob for AER controlling at this point.

I don't want to do anything that will prevent us from adding
per-device ECRC control in the future.

My concern is that if we add a run-time sysfs knob in the future, the
user experience on this hardware will be poor because there's no
convenient path to twiddle the PCIE_ATU_TD bit when the generic code
changes the AER Control bit.

What is the failure mode in these scenarios:

  - User boots with defaults, ECRC is disabled.
  - User enables ECRC via sysfs.
  - What happens here?  ECRC is enabled via AER Control but not via
    DWC TD bit.  I assume ECRC doesn't work.  Does it cause PCIe
    errors (malformed TLP, etc)?

Or this one:

  - User boots with "pci=ecrc=on", ECRC is enabled.
  - ECRC works fine.
  - User disables ECRC via sysfs.
  - What happens here?  ECRC is disabled via AER Control, but DWC TD
    bit thinks it's still enabled.

If you enabled ECRC unconditionally on DWC and the sysfs knob had no
effect, I'd be OK with that.  I'm more worried about what happens when
the AER bit and the DWC TD bit are set so they don't match.  What is
the failure mode there?

> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > > V3:
> > > * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
> > > 
> > > V2:
> > > * Addressed Jingoo's review comment
> > > * Removed saving 'td' bit information in 'dw_pcie' structure
> > > 
> > >   drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
> > >   drivers/pci/controller/dwc/pcie-designware.h | 1 +
> > >   2 files changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index b5e438b70cd5..cbd651b219d2 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > >        dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > >                                 upper_32_bits(pci_addr));
> > >        val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > +     if (pci->version == 0x490A)
> > > +             val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
> > >        val = upper_32_bits(size - 1) ?
> > >                val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> > >        dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > > @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > >                           lower_32_bits(pci_addr));
> > >        dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
> > >                           upper_32_bits(pci_addr));
> > > -     dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> > > -                        PCIE_ATU_FUNC_NUM(func_no));
> > > +     val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > +     if (pci->version == 0x490A)
> > > +             val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
> > > +     dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> > >        dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> > > 
> > >        /*
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index e7f441441db2..b01ef407fd52 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -89,6 +89,7 @@
> > >   #define PCIE_ATU_TYPE_IO             0x2
> > >   #define PCIE_ATU_TYPE_CFG0           0x4
> > >   #define PCIE_ATU_TYPE_CFG1           0x5
> > > +#define PCIE_ATU_TD_SHIFT            8
> > >   #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> > >   #define PCIE_ATU_CR2                 0x908
> > >   #define PCIE_ATU_ENABLE                      BIT(31)
> > > --
> > > 2.17.1
> > > 
