Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310AA5FD266
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 03:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJMBOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 21:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiJMBNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 21:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E415DFA2;
        Wed, 12 Oct 2022 18:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA498616D1;
        Thu, 13 Oct 2022 00:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03566C43470;
        Thu, 13 Oct 2022 00:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665621886;
        bh=DKXGPgqaiPkIBCBB26ELdj+CVTTMyMJ9i/fnIjLcUSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dd8sa6U0NOxibXKaQPEphZ/krmhRr7n/v6yTSTggiHzhkANlzBGhvELS7Lc0sh0xC
         QVq0tY3jJIkGA72yx9C//YeMqqngoNAyhC/IBtyDk9akrtRxupxyB6/3thQHA/ICRn
         mvll3qWTTRY9TXaUhroH0/6ctovHTbOsRPHqNdVTZhGHJygefMwtlstZQEp5XaqebW
         w9i5JInzE1jJx7D3ZXzvda+TPBDV85RLS3EJGfhe/K23HkKbQukeC0sQ30+segWurZ
         P1jXEFp17hWIh3cW2D8XmvBlSvrfAmpBeteq9pN1Ul4mFn4P2U3YkCsuAmmpOq0D8X
         D6CeUf8YcsmdA==
Date:   Wed, 12 Oct 2022 19:44:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Kevin Rowland <kevin.p.rowland@gmail.com>
Subject: Re: [PATCH v7 1/5] PCI: qcom: Add system suspend and resume support
Message-ID: <20221013004444.GA3135316@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ace1ae-26d0-4157-b7eb-8dff29895180@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, Kevin]

On Wed, Oct 12, 2022 at 07:36:52PM +0530, Krishna Chaitanya Chundru wrote:
> On 10/6/2022 2:43 AM, Bjorn Helgaas wrote:

[I'm declaring quote text bankruptcy and dropping the huge wall of
text.  The IRQ affinity change you mention seems to be the critical
issue :)]

> > The PCIe spec clearly envisions Refclk being turned off
> > (sec 5.5.3.3.1) and PHYs being powered off (sec 5.5.3.2) while in
> > L1.2.
> > 
> > I've been assuming L1.2 exit (which includes Refclk being turned on
> > and PHYs being powered up) is completely handled by hardware, but it
> > sounds like the Qcom controller needs software assistance which fields
> > an interrupt when CLKREQ# is asserted and turns on Refclk and the
> > PHYs?
> > 
> > 5.5.3 does say "All Link and PHY state must be maintained during L1.2,
> > or must be restored upon exit using implementation specific means",
> > and maybe Qcom counts as using implementation specific means.
> > 
> > I *am* concerned about whether software can do the L1.2 exit fast
> > enough, but the biggest reason I'm struggling with this is because
> > using the syscore framework to work around IRQ affinity changes that
> > happen late in suspend just seems kind of kludgy and it doesn't seem
> > like it fits cleanly in the power management model.
> 
> Can you please suggest any another way to work around IRQ affinity
> changes.

One of your earlier patches [1] made dw_msi_mask_irq() look like this:

  static void dw_msi_mask_irq(struct irq_data *d)
  {
    struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);

    if (dw_pcie_link_up(pci))
	    pci_msi_mask_irq(d);

    irq_chip_mask_parent(d);
  }

That was an awful lot like Marc's suggestion [2] that the
pci_msi_mask_irq() should be redundant.

If it's truly redundant, maybe pci_msi_mask_irq() can be removed
from dw_msi_mask_irq() (and other similar *_mask_irq()
implementations) completely?

Bjorn

[1] https://lore.kernel.org/r/1659526134-22978-3-git-send-email-quic_krichai@quicinc.com
[2] https://lore.kernel.org/linux-pci/86k05m7dkr.wl-maz@kernel.org/
