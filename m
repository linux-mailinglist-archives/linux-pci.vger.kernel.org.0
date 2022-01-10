Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A18489508
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 10:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbiAJJRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 04:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242612AbiAJJRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jan 2022 04:17:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAEDC061751
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 01:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4953561225
        for <linux-pci@vger.kernel.org>; Mon, 10 Jan 2022 09:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85716C36AED;
        Mon, 10 Jan 2022 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641806252;
        bh=I6CA+wzhkholummADzrWOLHSeE/iqhS13t7Dpb5uFi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifTD9CZdUjAD/+ZOVp48sQrPq+x2B47ZgZtyjt5QT9/7YQrvvBnHqffzZ+saXWOtA
         EXK/j5mHFQRCj2LBrqSqZ1sBD9nb4ypR6DjhCnfS7LnYREtbvsx2stCdIotVlpk8CS
         8iE1+cwGiegfrHLSr+KE0ptFDRT0RFfW6AdptbilnYj0S0+7YRZYE5lQAs73P9SsdD
         tVkigm3lhQWggPO5M8mJZJITf0DM/6CBoTuKPEnEF++Wiv8OP0wzL7tAkczAVwDKGQ
         wRtRo0cas7/S8BN1PY3xVM62n3VZ+ZczXp2QJ1aw20nKW8kAKgHH8KZLGilQEhh7qv
         +p6O7ylpnivCA==
Received: by pali.im (Postfix)
        id 18212A52; Mon, 10 Jan 2022 10:17:30 +0100 (CET)
Date:   Mon, 10 Jan 2022 10:17:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Zachary Zhang <zhangzg@marvell.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: aardvark: Implement emulated root PCI bridge
Message-ID: <20220110091729.owxno5ck3bihlrzj@pali>
References: <20220107212736.GA404447@bhelgaas>
 <20220107231734.GA426583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107231734.GA426583@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 17:17:34 Bjorn Helgaas wrote:
> [+cc Pali; sorry, I meant to cc you on this but forgot]
> 
> On Fri, Jan 07, 2022 at 03:27:38PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jun 29, 2018 at 11:22:31AM +0200, Thomas Petazzoni wrote:
> > 
> > > +static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> > > +{
> > > +	struct pci_sw_bridge *bridge = &pcie->bridge;
> > 
> > > +	/* Support interrupt A for MSI feature */
> > > +	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
> > 
> > Only 3.5 years later, IIUC, this is the value you get when you read
> > PCI_INTERRUPT_PIN, so I think this should be PCI_INTERRUPT_INTA, not
> > PCIE_CORE_INT_A_ASSERT_ENABLE.
> > 
> > Readers expect to get the values defined in the PCI spec, i.e.,
> > 
> >   PCI_INTERRUPT_UNKNOWN
> >   PCI_INTERRUPT_INTA
> >   PCI_INTERRUPT_INTB
> >   PCI_INTERRUPT_INTC
> >   PCI_INTERRUPT_INTD
> > 
> > Bjorn

Yes! We have a prepared patch for it and Marek now sent it:
https://lore.kernel.org/linux-pci/20220110015018.26359-2-kabel@kernel.org/
