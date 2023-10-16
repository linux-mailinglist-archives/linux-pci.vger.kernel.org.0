Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3587CB37D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjJPTwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjJPTwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 15:52:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C278C8F;
        Mon, 16 Oct 2023 12:52:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324E4C433C7;
        Mon, 16 Oct 2023 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697485931;
        bh=tx/j32H7gkpo8rzCPx1RKels7ySsiXUrEVypuCZW+Rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ro72ZPfsanST3avObOZJpj6KOxt93TaskAnExlLoS8adtFfn86ub5H0aC0VQUXt7K
         BMJb40xA72FR6I2b2eZj6pGeZBxLsdb/fY25gn6nx2Mx0b+zdTKV1FzkRDZbKPibhH
         IPo4RZVvqYZ+jW0p3W+0VwTUY9i1BEiRlGjlbtCCDlvNTGXd/CaGGVAN/TD0jCNNLP
         4H9FNfaIr5hXJW3ne5W9fVFCi9I2dA6ZnFFqNM/y2wSJqcNSfWEXAe3LZCe2AHnz5N
         y3K8ZIBHJsXozp2cOu78rpIl2lzPZ+RigUfGnpqc5uPXhYKgyd25yo0KlQdtWK4Tzk
         5bbBhSDPxhCKQ==
Date:   Mon, 16 Oct 2023 14:52:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v3 09/35] drivers/pci/controller: SH7751 PCI Host
 bridge driver.
Message-ID: <20231016195209.GA1221606@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016172742.GA1215127@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 12:27:42PM -0500, Bjorn Helgaas wrote:
> "git am" complained about a couple whitespace errors elsewhere in this
> series:
> 
>   Applying: arch/sh/boot/compressed/head_32.S: passing FDT address to initialize function.
>   .git/rebase-apply/patch:25: trailing whitespace.
>   Applying: drivers/irqchip: SH7751 IRL external encoder with enable gate.
>   .git/rebase-apply/patch:33: new blank line at EOF.

BTW, I mentioned all these things and more a month or so ago:

  https://lore.kernel.org/r/20230918191602.GA201859@bhelgaas
  https://lore.kernel.org/r/20230918193337.GA203483@bhelgaas
  https://lore.kernel.org/r/20230918193036.GA203163@bhelgaas

I *thought* this seemed familiar ;)

Bjorn

> On Sat, Oct 14, 2023 at 11:53:44PM +0900, Yoshinori Sato wrote:
> > pci-sh7751.h move from "arch/sh/drivers/pci/pci-sh7751.h"
> > pci-sh7751.c convert from "arch/sh/drivers/pci/pci-sh7751.c"
> 
> Note the subject line conventions in drivers/pci (use "git log
> --oneline" to see them): use something like this:
> 
>   PCI: sh7751: Add SH7751 PCI host bridge driver
> 
> with no period at the end.
> 
> arch/sh/drivers/pci/pci-sh7751.h and arch/sh/drivers/pci/pci-sh7751.c
> still exist after applying this series.  Better to have a single patch
> that moves the content from arch/sh/drivers/pci/ to
> drivers/pci/controller/.
> 
> Neither file looks like a simple move; there's a lot of reorganization
> going on at the same time.  It's really difficult to review a patch
> like that because we can't compare the content from before and after.
> 
> If you make a patch that does the cleanup/reorganization, and a
> separate patch that is just a simple move, and you use "git mv" for
> the move, git should notice that this is just a rename, and that diff
> will be tiny.
> 
> One of the reorganization patches should be to incorporate the
> pci-sh7751.h content directly into pci-sh7751.c.  Since it's only used
> in pci-sh7751.c, there's really no advantage to having it in a
> separate file.
> 
> Bjorn
> 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  drivers/pci/controller/Kconfig      |   9 +
> >  drivers/pci/controller/Makefile     |   1 +
> >  drivers/pci/controller/pci-sh7751.c | 285 ++++++++++++++++++++++++++++
> >  drivers/pci/controller/pci-sh7751.h | 267 ++++++++++++++++++++++++++
> >  4 files changed, 562 insertions(+)
> >  create mode 100644 drivers/pci/controller/pci-sh7751.c
> >  create mode 100644 drivers/pci/controller/pci-sh7751.h
> > 
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index c0c3f2824990..037ff44bd1e8 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -342,6 +342,15 @@ config PCIE_XILINX_CPM
> >  	  Say 'Y' here if you want kernel support for the
> >  	  Xilinx Versal CPM host bridge.
> >  
> > +config PCI_SH7751
> > +	bool "Renesas SH7751 PCI controller"
> > +	depends on OF
> > +	depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST
> > +	select PCI_HOST_COMMON
> > +	help
> > +	  Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
> > +	  Host Bridge driver.
> 
> Move this so the menu entries stay sorted by vendor name.
> 
> Bjorn
