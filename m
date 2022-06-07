Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B353FFC1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiFGNMh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 09:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbiFGNMe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 09:12:34 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F211EC63
        for <linux-pci@vger.kernel.org>; Tue,  7 Jun 2022 06:12:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y16so14167539ili.13
        for <linux-pci@vger.kernel.org>; Tue, 07 Jun 2022 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcxZtplXwk/Z+TT8W9hddhp2FUJFjSAJiAMtVESFwX4=;
        b=1R9AiW1gY1VYK6kYFNaQEa0cCcVv0mg4PT8PsSFrmYE8qP50U/W8QnvoV8a3AAiuY/
         6AE3+OpXx+GOb6NGUe8ynFndhTMVnvEd+lz2Ufhrj35oREogwN7e8iAHXyGibeX0qGQe
         Mc3O1gPlG+6DN56TdUTVkO+LFlhq0niqSzLCQ+9IxXf3J157h8Ncm4NBLnm6M3LHv0Sw
         IOvovO5h/4xOaWe8MHBozd6uGQENdjNERulvpkYnGKBDYA7j+M6905myRyL11P1J3v2z
         CWFAj3Y3JgP7/y4FItqBEAw5Rd9w78cklOruPWiyG0Fz2W3oVXsI4xUJgPnD4USc75Vj
         vG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcxZtplXwk/Z+TT8W9hddhp2FUJFjSAJiAMtVESFwX4=;
        b=7TUyVKCd7VSYoqo9JqIe6Dwe6ROMADS5nHvLDld1RKRJqM1Zb/aXfkrNGXi5zVtn60
         QPrIikgnJ/3E4MrrUrZ3nI855qUU9wNVSdzohqeCNl8U7gwHgUgx5L1jRqenxxNMZ6Tt
         t8XBvUjsD8jYfZ1fYrOYhaoskNPisMpyfhi+M+plNWrVSTqzdhH+z1dgmmxOmn40PeAG
         D4Onj8TbjM5G6DN/iV253rlc8jbC54bYIR+ZjWz6qHLYwCEV7gcBramphXjYQVih5TeX
         pxcXtQD6ofKRau2q5boHcjiuz/aDyDF8LuITKClkxsvrYcRfd63gys6LBwE1d/8OgB9v
         I/Ig==
X-Gm-Message-State: AOAM533Mz5htjr4dgzvitqvDnvvXv3EacMCd7CuLjWFCDK2SBD1swHGo
        HLxzlT2I65w0d4M8n2dtZ52nWABWTz65LQQKlc3o8Q==
X-Google-Smtp-Source: ABdhPJw95CeU2MDQe4i7N7oPLkSanT5aQWwJEN3LpDbgGCXPYQoyGBGQkxeiSbtBzI0UNRW9Pns5C3y7Zo+8caz+foE=
X-Received: by 2002:a05:6e02:19cc:b0:2d3:e20f:4959 with SMTP id
 r12-20020a056e0219cc00b002d3e20f4959mr17071989ill.40.1654607550608; Tue, 07
 Jun 2022 06:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644234441.git.baruch@tkos.co.il> <20220412161259.GA7109@lpieralisi>
 <YnvCGD4RwuyPkTfK@lpieralisi>
In-Reply-To: <YnvCGD4RwuyPkTfK@lpieralisi>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 7 Jun 2022 15:12:19 +0200
Message-ID: <CA+HBbNFo9QCExiA9T4Mn4t5vvir79xF3R9F6OLZa0m5Bzpte3w@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCI: IPQ6018 platform support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
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
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 4:03 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Apr 12, 2022 at 05:12:59PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Feb 07, 2022 at 04:51:23PM +0200, Baruch Siach wrote:
> > > This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is
> > > ported from downstream Codeaurora v5.4 kernel. The main difference from
> > > downstream code is the split of PCIe registers configuration from .init to
> > > .post_init, since it requires phy_power_on().
> > >
> > > Tested on IPQ6010 based hardware.
> > >
> > > Changes in v6:
> > >
> > >   * Drop DT patch applied to the qcom tree
> > >
> > >   * Normalize driver changes subject line
> > >
> > >   * Add a preparatory patch to rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL,
> > >     and define it using PCI_EXP_SLTCAP_* macros
> > >
> > >   * Drop a vague comment about ASPM configuration
> > >
> > >   * Add a comment about the source of delay periods
> > >
> > > Changes in v5:
> > >
> > >   * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)
> > >
> > > Changes in v4:
> > >
> > >   * Drop applied DT bits
> > >
> > >   * Add max-link-speed that was missing from the applied v2 patch
> > >
> > >   * Rebase the driver on v5.16-rc3
> > >
> > > Changes in v3:
> > >
> > >   * Drop applied patches
> > >
> > >   * Rely on generic code for speed setup
> > >
> > >   * Drop unused macros
> > >
> > >   * Formatting fixes
> > >
> > > Changes in v2:
> > >
> > >   * Add patch moving GEN3_RELATED macros to a common header
> > >
> > >   * Drop ATU configuration from pcie-qcom
> > >
> > >   * Remove local definition of common registers
> > >
> > >   * Use bulk clk and reset APIs
> > >
> > >   * Remove msi-parent from device-tree
> > >
> > > Baruch Siach (2):
> > >   PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
> > >   PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*
> > >
> > > Selvam Sathappan Periakaruppan (1):
> > >   PCI: qcom: Add IPQ60xx support
> > >
> > >  drivers/pci/controller/dwc/pcie-designware.h |   7 +
> > >  drivers/pci/controller/dwc/pcie-qcom.c       | 155 ++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
> > >  3 files changed, 160 insertions(+), 8 deletions(-)
> >
> > Hi Bjorn, Andy,
> >
> > any feedback on this series please ?
>
> Any feedback on these patches please ?

Finally dug the CP01, and for me, it works, so:
Tested-by: Robert Marko <robert.marko@sartura.hr>

Can we finally get this merged or at least looked at.
IPQ8074 will also benefit from this.

Regards,
Robert
>
> Thanks,
> Lorenzo



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
