Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886357FFC2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiGYNZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiGYNZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 09:25:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7E05FD5;
        Mon, 25 Jul 2022 06:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41933B80EC9;
        Mon, 25 Jul 2022 13:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A4C341C6;
        Mon, 25 Jul 2022 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658755538;
        bh=qrNmI0+Xi+leg5oQ8lCWj5IMys4zFhzyyUUPjKowDQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjV2jFZAh5LeAxLAXTzPUIDAOPSRfx8adWMLvncWhPIi8+8nk5pkhsSrtoGljxlXv
         df7RE1rdESD0AXyST3Fn9C7VXlPn+ilAmwBDS4ueIpUJO2hmL6jzbWJ7O5dWAhbha3
         0Hk0m/LaaEaYf1t3FlFlegWo+Jr0sNspRb/udpgWyVyyv/ak3+GCRXmxiKUTewnxkx
         UDXvfZQ4WoWgmph0tEQ8T6CUnUknAQZh7+PIFpExApROf+bqMHjsFtgkpwt1Z8UiXT
         a5yb2KYJwHeZfpryFYMTDWsg7bCwyIsvHL5JF30K8z1iec0QNZgk7MbLjID+C0pBF6
         q1CsuIDsBG+Lg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFy5l-0007Zq-GE; Mon, 25 Jul 2022 15:25:49 +0200
Date:   Mon, 25 Jul 2022 15:25:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
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
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
References: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
 <20220722143858.GA1818206@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722143858.GA1818206@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ +CC: maz ]

On Fri, Jul 22, 2022 at 09:38:58AM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 22, 2022 at 03:26:44PM +0200, Johan Hovold wrote:
> > On Thu, Jul 21, 2022 at 05:21:22PM -0500, Bjorn Helgaas wrote:
> 
> > > qcom is a DWC driver, so all the IRQ stuff happens in
> > > dw_pcie_host_init().  qcom_pcie_remove() does call
> > > dw_pcie_host_deinit(), which calls irq_domain_remove(), but nobody
> > > calls irq_dispose_mapping().
> > > 
> > > I'm thoroughly confused by all this.  But I suspect that maybe I
> > > should drop the "make qcom modular" patch because it seems susceptible
> > > to this problem:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom&id=41b68c2d097e
> > 
> > That should not be necessary.
> > 
> > As you note above, interrupt handling is implemented in dwc core so if
> > there are any issue here at all, which I doubt, then all of the dwc
> > drivers that currently can be built as modules would all be broken and
> > this would need to be fixed in core.
> 
> I don't know yet whether there's an issue.  We need a clear argument
> for why there is or is not.  The fact that others might be broken is
> not an argument for breaking another one ;)

It's not breaking anything that is currently working, and if there's
some corner case during module unload, that's not the end of the world
either.

It's a feature useful for developers and no one expects remove code to
be perfect (e.g. resilient against someone trying to break it by doing
things in parallel, etc.).

> > I've been using the modular pcie-qcom patch for months now, unloading
> > and reloading the driver repeatedly to test power sequencing, without
> > noticing any problems whatsoever.
> 
> Pali's commit log suggests that unloading the module is not, by
> itself, enough to trigger the problem:
> 
>   https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/
> 
> Can you test the scenario he mentions?

Turns out the pcie-qcom driver does not support legacy interrupts so
there's no risk of there being any lingering mappings if I understand
things correctly.

Johan
