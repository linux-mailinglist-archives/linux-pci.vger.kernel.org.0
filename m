Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED04379890
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEJUuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 16:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhEJUuf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 16:50:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74E7D61469;
        Mon, 10 May 2021 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620679769;
        bh=XF65myxk1R6rOg5TYwVWxf8E6nFqE+GuICaIhKIyTog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UspqD4CbBTKGiecvztlrhHTjyY3LdvOoM1sn035adapkriaaOEu5mQUViPdRN5f2H
         DWVamS6jnyXPA68W4SAni6LBuK6r6PhY4WdYz9fwxOInHjWlHU+3eZtw0NCaLXXsJn
         Za7Xb96U6hO7Xfrz8Rmp784Lhnq2w35HLxJ9MLX3frLcvPLASWrxK6JyA11YasEfR9
         AThLYbn1CA/RGCJ6bbrJMnNbR9/EgZk9qw8cCV4B/9BRQGkhyRzQ9pbkPW2s4ZB1QH
         EpqDIlVsUSiIe3BUX9u7UfygdpaE1FFe5OtfjOUlWFZRlTHt5i7QtFaIzROvYJZS61
         ZuLHnxnCLxD9Q==
Date:   Mon, 10 May 2021 15:49:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: dwc: Visconti: PCIe RC controller driver
Message-ID: <20210510204928.GA2299570@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510074736.jlxq44o3duwlmylo@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 04:47:36PM +0900, Nobuhiro Iwamatsu wrote:
> On Thu, Apr 29, 2021 at 06:10:40PM -0500, Bjorn Helgaas wrote:

> > > +#define  PCIE_UL_EDMA_INT3		BIT(5)
> > > +#define  PCIE_UL_S_INT_EVENT_MASK1_ALL  (PCIE_UL_CFG_PME_INT | PCIE_UL_CFG_LINK_EQ_REQ_INT | \
> > > +					 PCIE_UL_EDMA_INT0 | PCIE_UL_EDMA_INT1 | \
> > > +					 PCIE_UL_EDMA_INT2 | PCIE_UL_EDMA_INT3)
> > > +
> > 
> > Please wrap the code here and below so it fits nicely in 80 columns.
> 
> checkpatch.pl allows up to 100 characters, is this a PCI driver rule?

The general rule is "match what's around you."  So I guess that makes
it a drivers/pci/ rule.

> > > +	pp->irq = platform_get_irq_byname(pdev, "intr");
> > > +	if (pp->irq < 0) {
> > > +		dev_err(dev, "interrupt intr is missing");
> > 
> > Make your error messages consistently capitalized (or consistently not
> > capitalized).
> 
> Sorry, I didn't understand this point correctly.
> Does this mean capitalize the first letter of the message?

Some of your messages are capitalized and others are not:

  dev_info(pci->dev, "Link failure\n"
  dev_err(dev, "Failed to get refclk clock: %ld\n"
  dev_err(dev, "Failed to get sysclk clock: %ld\n"
  dev_err(dev, "Failed to get auxclk clock: %ld\n"
  dev_err(dev, "interrupt intr is missing"
  dev_dbg(dev, "Applied default link speed\n"
  dev_dbg(dev, "link speed Gen %d"
  dev_err(dev, "Failed to initialize host\n"

I don't really care whether they're all capitalized or none are
capitalized, but they should all be the same.  Otherwise it just looks
sloppy.

Bjorn
