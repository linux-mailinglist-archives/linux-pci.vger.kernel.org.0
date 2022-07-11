Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B523D570AA8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiGKTWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGKTWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5677A63;
        Mon, 11 Jul 2022 12:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B899614ED;
        Mon, 11 Jul 2022 19:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568B9C34115;
        Mon, 11 Jul 2022 19:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657567351;
        bh=J/H2xXJjCH3eLd5IhkiUbe3NMMpH9Fpiv7ItYslsl/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dj/tZlk/PJ+Jifhi+hEfdaYGT2BNdohdDg9RPYfEOtC/pW4GX4oypqHjA1vVFJVJn
         s4at5cu4WayAf6yu72GHH7irUFXdLXvjAkCL8j/Q3bf5ZI1S+hrLL3wEEm8gDyJyih
         1EiJZxUu91yCjskcpaqOSm2OBV1JDXODXgdOBWm2KEDJQleATSsFOZhKgwGELoRDHe
         /+/zJvnUI4cc3M9CtwTIaSMlgRCtt7kDDNUIdp4NuD730R4s2K/9lYM8dZ7PHQ9cWi
         agAKaOcsWrlDDD1MOFdTknnkYoEZ6cYzTkYKlawHY9aM/DzeSru46khARmtX13gohK
         RVgV27CfJgKoQ==
Date:   Mon, 11 Jul 2022 14:22:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH] PCI: qcom: Enable clocks only after PARF_PHY setup for
 rev 2.1.0
Message-ID: <20220711192229.GA678639@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c8d3e8.1c69fb81.26eee.0249@mx.google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Robert since I resolved a conflict in his patch, -cc stable]

On Sat, Jul 09, 2022 at 03:03:34AM +0200, Christian Marangi wrote:
> On Fri, Jul 08, 2022 at 06:01:55PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 09, 2022 at 12:27:43AM +0200, Christian Marangi wrote:
> > > We currently enable clocks BEFORE we write to PARF_PHY_CTRL reg to
> > > enable clocks and resets. This case the driver to never set to a ready
> > > state with the error 'Phy link never came up'.
> > > 
> > > This in fact is caused by the phy clock getting enabled before setting
> > > the required bits in the PARF regs.
> > > 
> > > A workaround for this was set but with this new discovery we can drop
> > > the workaround and use a proper solution to the problem by just enabling
> > > the clock only AFTER the PARF_PHY_CTRL bit is set.
> > > 
> > > This correctly setup the pcie line and makes it usable even when a
> > > bootloader leave the pcie line to a underfined state.
> > 
> > Is "pcie" here a signal name?  Maybe this refers to the "PCIe link"?
> 
> no i was referring to PCIe link. Fell free to fix it if it's not a
> problem (or if you want i can just resend)

I fixed it.

> Think something went wrong in the rebase as the patch fixup is reverted.
> 
> 11946f8b6e77a6794c111aafef7772e9967d9a54 is still wrong.
> 
> clk_bulk_prepare_enable must be after 
> writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
> so in the post init.

My error, sorry.  I updated it, current head:

  1a88605a3efd ("dt-bindings: PCI: qcom: Fix description typo")

Robert, your patch that I updated is:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom-pending&id=cdb32283bcf202d0db512abb80794056d44e7e9f

It would still be nice to get an ack from one of the maintainers for
this.

Bjorn
