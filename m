Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0626E543D84
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 22:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiFHUY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 16:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiFHUY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 16:24:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715915A3D8;
        Wed,  8 Jun 2022 13:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FF8AB82ACF;
        Wed,  8 Jun 2022 20:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDDAC34116;
        Wed,  8 Jun 2022 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654719863;
        bh=kjulfUSLLMXAENNBuRnDb2ttG1bjGhev/8nPL0ukd74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Tj82SFOEBNhE2C99Z3s8glLZg5Va/8Cv4lQtee1XdyPOMUb9RuyCumchv0GXMjW7p
         JpGMGfKwoE1c6gEhf24mZksjoCU9iMMtC9u99/Xfg2rPeVrfQiQOjy7Os+WDAKoLg7
         Y/jNwAETXYr1edF430gwK6G04XgUXz1ho9ylWCT+sTT91WrJWmBzCt46wTIOXsRnKE
         2R0khovDUQtfXUmjvnBjlTLJTlB3wOLwcyQRncSRzoLHbtv3gHdOrUbTqfoSNyqC5D
         OhRL4RTQrqspVbJrSdkVHs0zS6i/2xvFRFKU6ju6UrRXbZ6ZXCBXbvHEb2xlzj4JDv
         UmKIF5Hio4pug==
Date:   Wed, 8 Jun 2022 15:24:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v6 0/3] PCI: IPQ6018 platform support
Message-ID: <20220608202420.GA418223@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNFo9QCExiA9T4Mn4t5vvir79xF3R9F6OLZa0m5Bzpte3w@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Stanimir, beginning of thread at
https://lore.kernel.org/r/cover.1644234441.git.baruch@tkos.co.il]

On Tue, Jun 07, 2022 at 03:12:19PM +0200, Robert Marko wrote:
> On Wed, May 11, 2022 at 4:03 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Tue, Apr 12, 2022 at 05:12:59PM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Feb 07, 2022 at 04:51:23PM +0200, Baruch Siach wrote:
> > > > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is
> > > > ported from downstream Codeaurora v5.4 kernel. The main difference from
> > > > downstream code is the split of PCIe registers configuration from .init to
> > > > .post_init, since it requires phy_power_on().
> > > >
> > > > Tested on IPQ6010 based hardware.
> > > >
> > > > Changes in v6:
> > > >
> > > >   * Drop DT patch applied to the qcom tree
> > > >
> > > >   * Normalize driver changes subject line
> > > >
> > > >   * Add a preparatory patch to rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL,
> > > >     and define it using PCI_EXP_SLTCAP_* macros
> > > >
> > > >   * Drop a vague comment about ASPM configuration
> > > >
> > > >   * Add a comment about the source of delay periods
> > > >
> > > > Changes in v5:
> > > >
> > > >   * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)
> > > >
> > > > Changes in v4:
> > > >
> > > >   * Drop applied DT bits
> > > >
> > > >   * Add max-link-speed that was missing from the applied v2 patch
> > > >
> > > >   * Rebase the driver on v5.16-rc3
> > > >
> > > > Changes in v3:
> > > >
> > > >   * Drop applied patches
> > > >
> > > >   * Rely on generic code for speed setup
> > > >
> > > >   * Drop unused macros
> > > >
> > > >   * Formatting fixes
> > > >
> > > > Changes in v2:
> > > >
> > > >   * Add patch moving GEN3_RELATED macros to a common header
> > > >
> > > >   * Drop ATU configuration from pcie-qcom
> > > >
> > > >   * Remove local definition of common registers
> > > >
> > > >   * Use bulk clk and reset APIs
> > > >
> > > >   * Remove msi-parent from device-tree
> > > >
> > > > Baruch Siach (2):
> > > >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
> > > >   PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
> > > >
> > > > Selvam Sathappan Periakaruppan (1):
> > > >   PCI: qcom: Add IPQ60xx support
> > > >
> > > >  drivers/pci/controller/dwc/pcie-designware.h |   7 +
> > > >  drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
> > > >  3 files changed, 160 insertions(+), 8 deletions(-)
> > >
> > > Hi Bjorn, Andy,
> > >
> > > any feedback on this series please ?
> >
> > Any feedback on these patches please ?
> 
> Finally dug the CP01, and for me, it works, so:
> Tested-by: Robert Marko <robert.marko@sartura.hr>

This mainly affects pcie-qcom.c, so it looks like Stanimir should have
been copied on this, but wasn't.  Please include him on the next
iteration.

This will also need to be updated to apply on v5.19-rc1:

  03:21:47 ~/linux (next)$ git checkout -b wip/baruch-ipq6018-v6 v5.19-rc1
  Switched to a new branch 'wip/baruch-ipq6018-v6'
  03:21:55 ~/linux (wip/baruch-ipq6018-v6)$ git am m/v6_20220207_baruch_pci_ipq6018_platform_support.mbx
  Applying: PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
  Applying: PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
  Applying: PCI: qcom: Add IPQ60xx support
  error: patch failed: drivers/pci/controller/dwc/pcie-qcom.c:1531
  error: drivers/pci/controller/dwc/pcie-qcom.c: patch does not apply
  Patch failed at 0003 PCI: qcom: Add IPQ60xx support
