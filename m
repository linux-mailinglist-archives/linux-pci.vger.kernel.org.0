Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B835780264
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 02:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347470AbjHRAGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 20:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352560AbjHRAGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 20:06:01 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D396B2710
        for <linux-pci@vger.kernel.org>; Thu, 17 Aug 2023 17:05:27 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AA9D292009C; Fri, 18 Aug 2023 02:05:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A7BCC92009B;
        Fri, 18 Aug 2023 01:05:04 +0100 (BST)
Date:   Fri, 18 Aug 2023 01:05:04 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Tim Harvey <tharvey@gateworks.com>, linux-pci@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: imx8mp pci hang during init
In-Reply-To: <20230817171242.GA320904@bhelgaas>
Message-ID: <alpine.DEB.2.21.2308180051080.8596@angie.orcam.me.uk>
References: <20230817171242.GA320904@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Aug 2023, Bjorn Helgaas wrote:

> [+cc Maciej, smells similar to a89c82249c37 ("PCI: Work around PCIe
> link training failures") ]

 Quite so indeed.

> > [ 0.499660] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > [ 0.500276] clk: Not disabling unused clocks
> > [ 0.506960] imx6q-pcie 33800000.pcie: IO 0x001ff80000..0x001ff8ffff ->
> > 0x0000000000
> > [ 0.519401] imx6q-pcie 33800000.pcie: MEM 0x0018000000..0x001fefffff
> > -> 0x0018000000
> > [ 0.743554] imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib,
> > align 64K, limit 16G
> > [ 0.851578] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > ^^^ hang at this point until watchdog resets

 So I think it's important to figure out where exactly in the kernel code 
the hang happens; this is presumably in host-bridge-specific link bring-up 
code polling link status, which may have to be updated according to or 
otherwise make use of a89c82249c37.  It may also be something completely 
different of course.

 Can you see if you can bump the link up beyond 2.5GT/s by poking at host 
bridge registers by hand with `setpci' once the link been successfully 
established at 2.5GT/s?

  Maciej
