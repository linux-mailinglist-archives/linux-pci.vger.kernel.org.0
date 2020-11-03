Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30BB2A5063
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 20:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgKCTsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 14:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbgKCTsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 14:48:20 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599ED223AB;
        Tue,  3 Nov 2020 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604432899;
        bh=bXMJFyfw+FNXyHRc5tYigurM8UxL/0+jUxPYBTID90A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IjkxjKQCg1olfsbUBLnHt1RwWnl5FYwoQhlH3KVPvkTqYUAxwAL2vCeN8x5IZ9Qwi
         irJ9Jfl8pY4Xxi++9mpV4pexT/VGGksPHsbZtwgkVVfsCwkrn3oCRasMMoKklUXmty
         ihKPNN3Kl1qfER0Hxf1HhqeSru/s8uuikHOIRmxc=
Received: by mail-ot1-f42.google.com with SMTP id l36so9124094ota.4;
        Tue, 03 Nov 2020 11:48:19 -0800 (PST)
X-Gm-Message-State: AOAM532uGcL+eeJn/OXIq2Dd6bbbqOcSTzzoif+NRLRj0EM/nSE9PkEw
        LhRVEKYQqX1x62EnSRxPUk/98mFE+yAVgtylXg==
X-Google-Smtp-Source: ABdhPJykk+1CmTJiX1rVki4BdtzGhHBD1kMcVah9N6xLLsyuRsiTbYnkYTNHR4+zFVAH3zebGgvXxCx9aHLfCnXyUQ8=
X-Received: by 2002:a9d:6e0c:: with SMTP id e12mr5793797otr.129.1604432898566;
 Tue, 03 Nov 2020 11:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20201029053959.31361-1-vidyas@nvidia.com> <20201029053959.31361-3-vidyas@nvidia.com>
 <CAL_Jsq+3Ek9SRbsTqEmjiZtszvi7Er=TNgOt8t=0OESva2=sTg@mail.gmail.com>
 <902c0445-9fed-8e61-3aba-0e87988eb8df@nvidia.com> <DM5PR12MB18357E6BF282C9C65278460EDA100@DM5PR12MB1835.namprd12.prod.outlook.com>
 <CAL_Jsq+jH_bwv2dQrY-O4PTD1kK=BMObLjH_NFmfG8kQUUpD8Q@mail.gmail.com> <DM5PR12MB1835187E112C8854D4483E42DA100@DM5PR12MB1835.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1835187E112C8854D4483E42DA100@DM5PR12MB1835.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Nov 2020 13:48:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-0vKJMCzTGa-1LJbgAA9m7dNaie_=dG9kX3jQxGmB+w@mail.gmail.com>
Message-ID: <CAL_JsqK-0vKJMCzTGa-1LJbgAA9m7dNaie_=dG9kX3jQxGmB+w@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 2, 2020 at 4:38 PM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> On Mon, Nov 2, 2020 at 21:16:52, Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, Nov 2, 2020 at 9:12 AM Gustavo Pimentel
> > <Gustavo.Pimentel@synopsys.com> wrote:
> > >
> > > On Mon, Nov 2, 2020 at 14:27:9, Vidya Sagar <vidyas@nvidia.com> wrote:
> > >
> > > >
> > > >
> > > > On 11/2/2020 7:45 PM, Rob Herring wrote:
> > > > > External email: Use caution opening links or attachments
> > > > >
> > > > >
> > > > > On Thu, Oct 29, 2020 at 12:40 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > > > >>
> > > > >> DesignWare core has a TLP digest (TD) override bit in one of the control
> > > > >> registers of ATU. This bit also needs to be programmed for proper ECRC
> > > > >> functionality. This is currently identified as an issue with DesignWare
> > > > >> IP version 4.90a. This patch does the required programming in ATU upon
> > > > >> querying the system policy for ECRC.
> > > > >>
> > > > >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > >> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
> > > > >> ---
> > > > >> V3:
> > > > >> * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
> > > > >>
> > > > >> V2:
> > > > >> * Addressed Jingoo's review comment
> > > > >> * Removed saving 'td' bit information in 'dw_pcie' structure
> > > > >>
> > > > >>   drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
> > > > >>   drivers/pci/controller/dwc/pcie-designware.h | 1 +
> > > > >>   2 files changed, 7 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > >> index b5e438b70cd5..cbd651b219d2 100644
> > > > >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > >> @@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > > > >>          dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > > > >>                                   upper_32_bits(pci_addr));
> > > > >>          val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > > >> +       if (pci->version == 0x490A)
> > > > >> +               val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
> > > > >>          val = upper_32_bits(size - 1) ?
> > > > >>                  val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> > > > >>          dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > > > >> @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > > > >>                             lower_32_bits(pci_addr));
> > > > >>          dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
> > > > >>                             upper_32_bits(pci_addr));
> > > > >> -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> > > > >> -                          PCIE_ATU_FUNC_NUM(func_no));
> > > > >> +       val = type | PCIE_ATU_FUNC_NUM(func_no);
> > > > >> +       if (pci->version == 0x490A)
> > > > >
> > > > > Is this even possible? Are the non-unroll ATU registers available post 4.80?
> > > > I'm not sure. Gustavo might have information about this. I made this
> > > > change so that it is taken care off even if they available.
> > >
> > > The Synopsys DesignWare PCIe IP is highly configurable, therefore is
> > > dependable on what the design team has configured for their solution.
> > > Although Synopsys doesn't recommend the use of non-unroll ATU, the
> > > customers are free to select what they want for their design.

Then given the feature is not really tied to the IP version, using
version wasn't really a good choice. A better choice would have been a
quirk flag that platforms could set. Perhaps called
'iatu_unroll_enabled'...

> > Okay, then there's a bug in the driver if the version is set to 0x480A
> > or later and non-unroll is used:
> >
> > if (pci->version >= 0x480A || (!pci->version &&
> >        dw_pcie_iatu_unroll_enabled(pci))) {
> >
> > Probably can just drop the version checking. The detection should always work.
>
> Hi Rob,
>
> The "detection" is based on the assumption that the read value on
> PCIE_ATU_VIEWPORT register is 0xffffffff (which is a hard-coded value by
> design), if it's true then the iATU is unrolled and the function returns
> 1, otherwise is non-unrolled returns 0. So like you said it should always
> work, however, this code behavior was changed by Kishon on the following
> patch 2aadcb0cd39 ("PCI: dwc: Fix ATU identification for designware
> version >= 4.80"). His patch makes me believe that on keystone platform
> the read operation on that register causes some unpredicted behavior
> leads his platform to crash/abort, that's why he created this alternative
> version approach to avoid the "detection" algorithm.

Ah, h/w designers and their love for bus aborts...

> From what I'm seeing the only drivers that use this "version" approach
> are the keystone and intel-gw (which probably doesn't need it).
>
> To summarize, this is a workaround so that the keystone driver doesn't
> break independent of the controller IP version.

Keystone is also broken in another way. The dts files claim 16 in and
out regions, but the ATU region is 4KB. It would need 8KB for 16
regions as unroll has a stride of 512bytes for each region.

Rob
