Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED042603086
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJRQJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 12:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJRQJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 12:09:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B53AA3CD;
        Tue, 18 Oct 2022 09:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97716615FF;
        Tue, 18 Oct 2022 16:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D0C433C1;
        Tue, 18 Oct 2022 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666109342;
        bh=GM6MSYEr926mJXjI6RLujQbUK1lPFH8a6M91n4+Nf+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qKKvld+uoC2djWFzFuyPcWZBEda3UQIIR3gfS2YnjIncpcRBsEPANnOWC+F2Jhe7R
         YUM5Ex1zpgY79zIW5DEApHHdi5Ipq4UH+l9ipp5vfII1XpkPu/Rc5VilAc2r3QtX62
         lew5v0kCCQsHMInMtaQmhXUmUe3mG2yuhP2EmBt83O+QLO/Jowg9KtQ4u87F4gmGL8
         tXWR2oArseCaV9qzf+h/0SBBnUlBntPf2YH2tH4/vaZg3nBSoMPOykvLv9LSqfxkm3
         3Q3rZSxWclvn6phWaI8dOHxB2M6JaTri71EJjRVgySreTCafAwBIjOvq5Lipga64l/
         fo0LEJWxzpfSA==
Date:   Tue, 18 Oct 2022 11:08:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for modular builds
Message-ID: <20221018160859.GA3805344@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07B/cHkyvw3M4NV@hovoldconsulting.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 18, 2022 at 05:10:53PM +0200, Johan Hovold wrote:
> On Mon, Oct 17, 2022 at 12:34:22PM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 17, 2022 at 01:47:05PM +0200, Johan Hovold wrote:
> > > Allow the Qualcomm PCIe controller driver to be built as a module, which
> > > is useful for multi-platform kernels as well as during development.
> > 
> > There are two different goals here, and there's no real reason to
> > bundle them together:
> > 
> >   1) Make qcom a loadable module.  This is a hard requirement so
> >      multi-platform kernels don't need to build in all drivers
> >      statically.
> > 
> >   2) Make qcom unloadable.  This is a high want, possibly even a
> >      requirement for developers, but is not really a big issue for
> >      users.
> > 
> > There are different changes required: 1) requires the Kconfig change;
> > 2) requires .remove() to be implemented.  Since there's no requirement
> > that these be done together, let's split them into separate patches.
> > 
> > Then we can make sure that at least 1) gets done, and if for any
> > reason 2) isn't safe or breaks something, we can at least bisect and
> > if necessary revert it without losing 1).
> 
> Implementing 1) in itself requires more than simply splitting this
> patch. And I don't think we should be making life harder for developers,
> as well as users assisting during debugging, by going in that direction.

If you're saying this patch can't be split, can you elaborate on the
details of *why* it can't be split?

> We have tons of modules in the kernel and very few that cannot be
> unloaded. Anyone who doesn't trust root to not unload modules can
> always disable unloading completely using CONFIG_MODULE_UNLOAD.

This is all true, but IIUC, the issue is about unloading IRQ
controller drivers, and this doesn't address that.  I don't have a
clear understanding of the issue, and it would be nice if a patch that
specifically added unloadability could elaborate on that.  Then we can
decide that "yes, this is a risk, and we're willing to accept it." An
argument that "tons of modules do this" totally avoids the issues of
this particular case.

Bjorn
