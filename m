Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDD59BFA9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiHVMp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHVMp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 08:45:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1893341B;
        Mon, 22 Aug 2022 05:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9FB1CE1284;
        Mon, 22 Aug 2022 12:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0170FC433D6;
        Mon, 22 Aug 2022 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661172354;
        bh=ZuieiRPC9CArVV1OmJfFIGJRDuSJ/3o0U41DRi5sjzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyTdz2y9jkLcaoPI+W0iipfxB7MXxlXcqRUyJZgw6Uw22bty4Qtu0DsSRZ+dUv9Jp
         YJbdqXq0LrNxG7ax3OUcofawTlUJ11gxMuEUnOv2IovZYYHKcsk+UVe3itqHQegJU1
         aYNADCYblwqFo90YWta3ilHTs/ef+++PlmPBfdMEw+zG+TqQv2UC6GhOYQNqmlUpnN
         eU6cwH3i8QiDCvGoyoOco+egYFA2GQ9tFSzXLllsFQDBq+Lj6klcpE/IMH0FdCLr8F
         1DZb3TdPPUAuTTysn1UFzfm587koMS4kV1/WNEuzgeEDoOYUKiE1cBmj+1CbkbLhFO
         utuGUZCzs61Uw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ6oR-0001kf-4V; Mon, 22 Aug 2022 14:45:51 +0200
Date:   Mon, 22 Aug 2022 14:45:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] PCI: qcom: Sort device-id table
Message-ID: <YwN6f+xOJIW0liGu@hovoldconsulting.com>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-9-johan+linaro@kernel.org>
 <YtAny03L/RLk9nv6@xps13>
 <YtEaqHT7NdXPhK+y@hovoldconsulting.com>
 <YvvAfQJChCVX4cPH@lpieralisi>
 <20220818200530.lab2zlcaetekcclq@halaneylaptop>
 <Yv8/6x7pgrBhzdbQ@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv8/6x7pgrBhzdbQ@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 09:46:51AM +0200, Lorenzo Pieralisi wrote:
> On Thu, Aug 18, 2022 at 03:05:30PM -0500, Andrew Halaney wrote:
> > Hi Lorenzo,
> > 
> > On Tue, Aug 16, 2022 at 06:06:21PM +0200, Lorenzo Pieralisi wrote:
> > > On Fri, Jul 15, 2022 at 09:43:36AM +0200, Johan Hovold wrote:

> > > > Perhaps Bjorn H can fix that up when applying unless I'll be sending a
> > > > v3 for some other reason. This series still depends on the MSI rework to
> > > > be applied first.
> > > 
> > > I can do it while applying. A link to the lore archive for the MSI
> > > rework please (I don't think it was merged for v6.0) ? I was away for
> > > two months, catching up with threads.
> > 
> > I don't see a reply to this, so here I am following up out of interest
> > for getting this in mainline for my x13s laptop to use.
> > 
> > It appears the MSI rework[0] (which is in the cover letter here so I
> > know I grabbed the right thing) was applied in 6.0:
> > 
> >     ahalaney@halaneylaptop ~/git/linux (git)-[remotes/upstream/HEAD] % git log --oneline --abbrev=12 --grep=2436629 v6.0-rc1 -- drivers/pci/controller/dwc/ 
> >     cd761378e62c PCI: dwc: Handle MSIs routed to multiple GIC interrupts
> >     db388348acff PCI: dwc: Convert struct pcie_port.msi_irq to an array
> >     226ec087497a PCI: dwc: Split MSI IRQ parsing/allocation to a separate function
> >     3c62f878a969 PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
> >     ahalaney@halaneylaptop ~/git/linux (git)-[remotes/upstream/HEAD] %
> > 
> > Just a friendly FYI, hope that helps!
> 
> Thanks for the heads-up, I will merge this series then.

I was out-of-office last week so thanks for digging out that link,
Andrew.

Johan
