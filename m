Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFF5234F1
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiEKODO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiEKODN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 10:03:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC8B62230;
        Wed, 11 May 2022 07:03:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB54ED1;
        Wed, 11 May 2022 07:03:10 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 423BE3F66F;
        Wed, 11 May 2022 07:03:08 -0700 (PDT)
Date:   Wed, 11 May 2022 15:03:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: IPQ6018 platform support
Message-ID: <YnvCGD4RwuyPkTfK@lpieralisi>
References: <cover.1644234441.git.baruch@tkos.co.il>
 <20220412161259.GA7109@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412161259.GA7109@lpieralisi>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 05:12:59PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Feb 07, 2022 at 04:51:23PM +0200, Baruch Siach wrote:
> > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
> > ported from downstream Codeaurora v5.4 kernel. The main difference from 
> > downstream code is the split of PCIe registers configuration from .init to 
> > .post_init, since it requires phy_power_on().
> > 
> > Tested on IPQ6010 based hardware.
> > 
> > Changes in v6:
> > 
> >   * Drop DT patch applied to the qcom tree
> > 
> >   * Normalize driver changes subject line
> > 
> >   * Add a preparatory patch to rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL,
> >     and define it using PCI_EXP_SLTCAP_* macros
> > 
> >   * Drop a vague comment about ASPM configuration
> > 
> >   * Add a comment about the source of delay periods
> > 
> > Changes in v5:
> > 
> >   * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)
> > 
> > Changes in v4:
> > 
> >   * Drop applied DT bits
> > 
> >   * Add max-link-speed that was missing from the applied v2 patch
> > 
> >   * Rebase the driver on v5.16-rc3
> > 
> > Changes in v3:
> > 
> >   * Drop applied patches
> > 
> >   * Rely on generic code for speed setup
> > 
> >   * Drop unused macros
> > 
> >   * Formatting fixes
> > 
> > Changes in v2:
> > 
> >   * Add patch moving GEN3_RELATED macros to a common header
> > 
> >   * Drop ATU configuration from pcie-qcom
> > 
> >   * Remove local definition of common registers
> > 
> >   * Use bulk clk and reset APIs
> > 
> >   * Remove msi-parent from device-tree
> > 
> > Baruch Siach (2):
> >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
> >   PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
> > 
> > Selvam Sathappan Periakaruppan (1):
> >   PCI: qcom: Add IPQ60xx support
> > 
> >  drivers/pci/controller/dwc/pcie-designware.h |   7 +
> >  drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
> >  3 files changed, 160 insertions(+), 8 deletions(-)
> 
> Hi Bjorn, Andy,
> 
> any feedback on this series please ?

Any feedback on these patches please ?

Thanks,
Lorenzo
