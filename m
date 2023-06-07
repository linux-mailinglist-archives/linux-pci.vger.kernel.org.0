Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D99872706D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFGVTq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFGVTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 17:19:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23401984;
        Wed,  7 Jun 2023 14:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F31648D3;
        Wed,  7 Jun 2023 21:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2D3C433D2;
        Wed,  7 Jun 2023 21:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686172783;
        bh=kPvir4ZLGQOIvoukeOAmyBe+ZNEwToynta1WPvI98us=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l0CWu4k/EmTG+pvWHcMifGGTMeSBy+7GNaDZcly9c4fJJrCNY3+c8SQ929wWq+Zkq
         nUMXR9LMAA743dHVIn0MPJlPa9rwlZK39iV7jcl5BIebw+tst0VGShLGvnhuRWX/jc
         ncaXWegQgYqBAH0ZKzPZatAhQNug6N3wDoriNzzZ0JLF8mtaUZk4M0RpKVys5wED28
         Y43yN4sHHvVyoZ+Wt0k1Xd4ZACEI4gUQa6SzLuEIbhT2xGM6k9YtDgPZp0TL4l+veF
         y8LorTecMe69Qduynnv0EbaFPuMOxxJTwdhtQXWU0V/GwW06Y2Q7lYdhNxTZGQDJZ4
         oxWfQNKKOgTvQ==
Date:   Wed, 7 Jun 2023 16:19:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v6 8/9] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230607211941.GA1176583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607204923.GA1174664@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Yang Li, sorry I didn't notice your patch earlier:
https://lore.kernel.org/r/20230607093514.104012-1-yang.lee@linux.alibaba.com]

I think we can squash this into the original commit since it hasn't
gone upstream yet.  Also note that removing the dev_err() apparently
makes "dev" unused, so we'd have to remove that as well, based on this
report [2].

[2] https://lore.kernel.org/r/202306080418.i64hTj5T-lkp@intel.com

On Wed, Jun 07, 2023 at 03:49:25PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 02, 2023 at 05:17:55PM +0530, Manivannan Sadhasivam wrote:
> > Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> > The driver implements the MHI function over PCI in the endpoint device
> > such as SDX55 modem. The MHI endpoint function driver acts as a
> > controller driver for the MHI Endpoint stack and carries out all PCI
> > related activities like mapping the host memory using iATU, triggering
> > MSIs etc...
> > ...
> 
> > +static int pci_epf_mhi_bind(struct pci_epf *epf)
> > +{
> > ...
> 
> > +	ret = platform_get_irq_byname(pdev, "doorbell");
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to get Doorbell IRQ\n");
> 
> This dev_err() causes this new warning from the 0-day robot [1]:
> 
>   drivers/pci/endpoint/functions/pci-epf-mhi.c:362:2-9: line 362 is redundant because platform_get_irq() already prints an error
> 
> Maybe we could drop it?
> 
> Bjorn
> 
> [1] https://lore.kernel.org/all/20230607163937.ZTc-D%25lkp@intel.com/
