Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F03E544D66
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiFINWS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiFINWR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 09:22:17 -0400
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7285825F5;
        Thu,  9 Jun 2022 06:22:15 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 18F7A44051C;
        Thu,  9 Jun 2022 16:21:59 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1654780919;
        bh=4lmVetWEizyXy3Pcuz2UbHUUHYh1KNwujq3JDVAhUY0=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=UJI4vR8Zfb7oVVfnOiz41PthhfILl1KVnFTBLuvNZVn82JWIlUMmB2xlmU4cZXjey
         6Bg2yZSDDQXf8zYA1ylkOLtPogQRPqLgwvDuxXzqLJtYiP+tv3ccL9RtcUpWW+RuBU
         hQZ+stxFV+SKPtvJyG0OQE8SfeXlQkNWjunLIZr8eJAMtwtQ+CFhQfb1Te8e7Vg3kU
         ILHa/PWNDASm4ao8XmEzi/YPBkj7DPnA/hKAihrzOsX5w0vgdbvIMxvykB94ndTBfA
         dxwhJph4Pms//iDVJcfmcx5K6j26xFH/DouH8SCHBfLyY17dEJ/w+iD52eQOhCviiw
         yUWKybm+/HOlQ==
References: <CA+HBbNFo9QCExiA9T4Mn4t5vvir79xF3R9F6OLZa0m5Bzpte3w@mail.gmail.com>
 <20220608202420.GA418223@bhelgaas>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
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
Date:   Thu, 09 Jun 2022 16:10:45 +0300
In-reply-to: <20220608202420.GA418223@bhelgaas>
Message-ID: <875yla55vg.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

[ Changed codeaurora.com addresses to their quicinc.com equivalents ]

On Wed, Jun 08 2022, Bjorn Helgaas wrote:
> [+cc Stanimir, beginning of thread at
> https://lore.kernel.org/r/cover.1644234441.git.baruch@tkos.co.il]
>
> On Tue, Jun 07, 2022 at 03:12:19PM +0200, Robert Marko wrote:
>> On Wed, May 11, 2022 at 4:03 PM Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>> >
>> > On Tue, Apr 12, 2022 at 05:12:59PM +0100, Lorenzo Pieralisi wrote:
>> > > On Mon, Feb 07, 2022 at 04:51:23PM +0200, Baruch Siach wrote:
>> > > > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is
>> > > > ported from downstream Codeaurora v5.4 kernel. The main difference from
>> > > > downstream code is the split of PCIe registers configuration from .init to
>> > > > .post_init, since it requires phy_power_on().
>> > > >
>> > > > Tested on IPQ6010 based hardware.
>> > > >
>> > > > Changes in v6:
>> > > >
>> > > >   * Drop DT patch applied to the qcom tree
>> > > >
>> > > >   * Normalize driver changes subject line
>> > > >
>> > > >   * Add a preparatory patch to rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL,
>> > > >     and define it using PCI_EXP_SLTCAP_* macros
>> > > >
>> > > >   * Drop a vague comment about ASPM configuration
>> > > >
>> > > >   * Add a comment about the source of delay periods
>> > > >
>> > > > Changes in v5:
>> > > >
>> > > >   * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)
>> > > >
>> > > > Changes in v4:
>> > > >
>> > > >   * Drop applied DT bits
>> > > >
>> > > >   * Add max-link-speed that was missing from the applied v2 patch
>> > > >
>> > > >   * Rebase the driver on v5.16-rc3
>> > > >
>> > > > Changes in v3:
>> > > >
>> > > >   * Drop applied patches
>> > > >
>> > > >   * Rely on generic code for speed setup
>> > > >
>> > > >   * Drop unused macros
>> > > >
>> > > >   * Formatting fixes
>> > > >
>> > > > Changes in v2:
>> > > >
>> > > >   * Add patch moving GEN3_RELATED macros to a common header
>> > > >
>> > > >   * Drop ATU configuration from pcie-qcom
>> > > >
>> > > >   * Remove local definition of common registers
>> > > >
>> > > >   * Use bulk clk and reset APIs
>> > > >
>> > > >   * Remove msi-parent from device-tree
>> > > >
>> > > > Baruch Siach (2):
>> > > >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
>> > > >   PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
>> > > >
>> > > > Selvam Sathappan Periakaruppan (1):
>> > > >   PCI: qcom: Add IPQ60xx support
>> > > >
>> > > >  drivers/pci/controller/dwc/pcie-designware.h |   7 +
>> > > >  drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
>> > > >  drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
>> > > >  3 files changed, 160 insertions(+), 8 deletions(-)
>> > >
>> > > Hi Bjorn, Andy,
>> > >
>> > > any feedback on this series please ?
>> >
>> > Any feedback on these patches please ?
>> 
>> Finally dug the CP01, and for me, it works, so:
>> Tested-by: Robert Marko <robert.marko@sartura.hr>
>
> This mainly affects pcie-qcom.c, so it looks like Stanimir should have
> been copied on this, but wasn't.  Please include him on the next
> iteration.

I somehow missed the pcie-qcom.c standalone entry in MAINTAINERS because
the same file also appears on the general qcom entry. I'll add him on
v7. Hopefully that will improve the fortune of this series.

> This will also need to be updated to apply on v5.19-rc1:
>
>   03:21:47 ~/linux (next)$ git checkout -b wip/baruch-ipq6018-v6 v5.19-rc1
>   Switched to a new branch 'wip/baruch-ipq6018-v6'
>   03:21:55 ~/linux (wip/baruch-ipq6018-v6)$ git am m/v6_20220207_baruch_pci_ipq6018_platform_support.mbx
>   Applying: PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
>   Applying: PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
>   Applying: PCI: qcom: Add IPQ60xx support
>   error: patch failed: drivers/pci/controller/dwc/pcie-qcom.c:1531
>   error: drivers/pci/controller/dwc/pcie-qcom.c: patch does not apply
>   Patch failed at 0003 PCI: qcom: Add IPQ60xx support

I'll rebase on v5.19-rc1.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
