Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8587A5EAB85
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiIZPqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiIZPqR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 11:46:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37E7223;
        Mon, 26 Sep 2022 07:31:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 121DD68AFE; Mon, 26 Sep 2022 16:31:29 +0200 (CEST)
Date:   Mon, 26 Sep 2022 16:31:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        William McVicker <willmcvicker@google.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller
 support
Message-ID: <20220926143127.GB19031@lst.de>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru> <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru> <YwzbARMkb/69+l2d@lpieralisi> <20220912000211.ct6asuhhmnatje5e@mobilestation> <YzF8N/jzkWsjcgdD@lpieralisi> <20220926124924.4vodhncnuaorrlwj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926124924.4vodhncnuaorrlwj@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 03:49:24PM +0300, Serge Semin wrote:
> @Christoph, @Marek, @Bjorn, @Rob could you please join to the
> DMA-mask related discussion. @Lorenzo can't decide which driver should
> initialize the device DMA-mask.

The driver that does the actual DMA mapping or allocation functions
need to set it.  But even with your comments on the questions I'm
still confused what struct device you are even talking about.  Can
you explain this a bit better?
