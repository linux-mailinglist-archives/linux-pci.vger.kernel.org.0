Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414B7CAD5F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjJPPW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJPPWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 11:22:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D48B4;
        Mon, 16 Oct 2023 08:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79232C433C9;
        Mon, 16 Oct 2023 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697469733;
        bh=DowPxR62zPnMI4kLLinoy26En/26UZyXsXLcIQU2wuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IT+fImRQPlOYJhujnsfj2sgXczN1y/eLhEkCdVka5yvLsmoLpXAFOeLZA323k82r4
         LKjE7pUNRXRN3PNlWylJClZv6rdXLo2KKMyfWU20LEQW1Yz/KNNKKZyJFxNZJo5nnC
         7OlqaVZbNAyEXsd7/p5NMe69Z+N2SJ4erubRNTz/gX9hBiO0QgQz0LQ6KHo6r0PbcS
         F2nj1ESGbj+JNTDtgRGqQva8Dgnp46ZWHOzayojG4VvUslIxI735LUwwovy5nQdYJw
         t2s79YhK/Z8o31cA1qEnKUvSnfx/LHRucRQFMQzxEUdk3RsMCFhbM/kVbtmITguiJD
         TwAanPPal3P/g==
Date:   Mon, 16 Oct 2023 10:22:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 2/3] PCI: layerscape: add suspend/resume for ls1021a
Message-ID: <20231016152211.GA1209639@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS1Mhe9JOsY2JJER@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 10:45:25AM -0400, Frank Li wrote:
> On Tue, Oct 10, 2023 at 06:02:36PM +0200, Lorenzo Pieralisi wrote:
> > On Tue, Oct 10, 2023 at 10:20:12AM -0400, Frank Li wrote:

> > > Ping
> > 
> > Read and follow please (and then ping us):
> > https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
> 
> Could you please help point which specic one was not follow aboved guide?
> Then I can update my code. I think that's efficial communication method. I
> think I have read it serial times. But not sure which one violate the
> guide?
> 
> @Bjorn Helgaas. How do you think so? 

Since Lorenzo didn't point out anything specific in the patch itself,
I think he was probably referring to the subject line and this advice:

  - Follow the existing convention, i.e., run "git log --oneline
    <file>" and make yours match in format, capitalization, and
    sentence structure.  For example, native host bridge driver patch
    titles look like this:

      PCI: altera: Fix platform_get_irq() error handling
      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
      PCI: mediatek: Add MSI support for MT2712 and MT7622
      PCI: rockchip: Remove IRQ domain if probe fails

In this case, your subject line was:

  PCI: layerscape: add suspend/resume for ls1021a

The advice was to run this:

  $ git log --oneline drivers/pci/controller/dwc/pci-layerscape.c
  83c088148c8e PCI: Use PCI_HEADER_TYPE_* instead of literals
  9fda4d09905d PCI: layerscape: Add power management support for ls1028a
  277004d7a4a3 PCI: Remove unnecessary <linux/of_irq.h> includes
  60b3c27fb9b9 PCI: dwc: Rename struct pcie_port to dw_pcie_rp
  d23f0c11aca2 PCI: layerscape: Change to use the DWC common link-up check function
  7007b745a508 PCI: layerscape: Convert to builtin_platform_driver()
  60f5b73fa0f2 PCI: dwc: Remove unnecessary wrappers around dw_pcie_host_init()
  b9ac0f9dc8ea PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
  f78f02638af5 PCI: dwc: Rework MSI initialization

Note that these summaries are all complete sentences that start with a
capital letter:

  Use PCI_HEADER_TYPE_* instead of literals
  Add power management support for ls1028a
  Remove unnecessary <linux/of_irq.h> includes
  ...

So yours could be this:

  PCI: layerscape: Add suspend/resume for ls1021a
                   ^

This is trivial, obviously.  But the uppercase/lowercase distinction
carries information, and it's an unnecessary distraction to notice
that "oh, this is different from the rest; is the difference
important or should I ignore it?"

Obviously Lorenzo *could* edit all your subject lines on your behalf,
but it makes everybody's life easier if people look at the existing
code and follow the style when making changes.

E.g., write subject lines that are similar in style to previous ones,
name local variables similarly to other functions, use line lengths
consistent with the rest of the file, etc.  After applying a change,
the file should look like a coherent whole; we should not be able to
tell that this hunk was added later by somebody else.  This all helps
make the code (and the git history) more readable and maintainable.

Bjorn
