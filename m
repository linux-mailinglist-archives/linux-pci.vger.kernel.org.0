Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BBC57E31E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiGVOjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiGVOjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 10:39:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939B97D77;
        Fri, 22 Jul 2022 07:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9F5B82916;
        Fri, 22 Jul 2022 14:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87015C341C6;
        Fri, 22 Jul 2022 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658500740;
        bh=eiB7i1+lHAZ3IzGRYI2S0vUT3rNwvvRkbUMghXNlfzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I5ImhMAGhFuuBa7iVxqz4dSQPAGI0nvv3GrOvY46KSzygUn7eeijlkGrAD1xMLWaS
         ocx/bngVQsVG92GUB0ZFFPhlWGUOITw6i5Bzw8QkRY7qxqYpYOIF1pJFODfEy/qSiv
         stPP0t9E0ZBm6cf6i/t8RfyYkeAwv4l6yhSSiwJVt6CoQWrF3UmdAKwIAXfuAuzCkZ
         KVNCv/2aCEZ7h0NDyeDiFfm3Rc39X0d8gkOWn+Emhoi7r3JHW0yAaIDPvWwz7UNX8E
         PGi9HWCS3yu957cHHCBhKztAkJ6EX1F+dKP4dNN6jqZANVoqOQP2EW6O4cylpDuYp/
         qPBNO2h2NEsOg==
Date:   Fri, 22 Jul 2022 09:38:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20220722143858.GA1818206@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 03:26:44PM +0200, Johan Hovold wrote:
> On Thu, Jul 21, 2022 at 05:21:22PM -0500, Bjorn Helgaas wrote:

> > qcom is a DWC driver, so all the IRQ stuff happens in
> > dw_pcie_host_init().  qcom_pcie_remove() does call
> > dw_pcie_host_deinit(), which calls irq_domain_remove(), but nobody
> > calls irq_dispose_mapping().
> > 
> > I'm thoroughly confused by all this.  But I suspect that maybe I
> > should drop the "make qcom modular" patch because it seems susceptible
> > to this problem:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom&id=41b68c2d097e
> 
> That should not be necessary.
> 
> As you note above, interrupt handling is implemented in dwc core so if
> there are any issue here at all, which I doubt, then all of the dwc
> drivers that currently can be built as modules would all be broken and
> this would need to be fixed in core.

I don't know yet whether there's an issue.  We need a clear argument
for why there is or is not.  The fact that others might be broken is
not an argument for breaking another one ;)

> I've been using the modular pcie-qcom patch for months now, unloading
> and reloading the driver repeatedly to test power sequencing, without
> noticing any problems whatsoever.

Pali's commit log suggests that unloading the module is not, by
itself, enough to trigger the problem:

  https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/

Can you test the scenario he mentions?

Bjorn
