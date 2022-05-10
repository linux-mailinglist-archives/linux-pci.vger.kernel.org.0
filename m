Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5C520EA6
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiEJHiv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240961AbiEJH0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 03:26:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081439833;
        Tue, 10 May 2022 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FceqXWmZ8bGiO02Mvg6pdY1ldbGSoSPohpsyX45vO1Q=; b=PTQeh3EJrJwHtiCSpNamFAZgC6
        83sJi4KjX/0Gvl/8L8xcZ8gPFuwQRjdsPc1Td9wEgHybaAKZfVyRIQV7n2Wz4Gz+qtVKxNJPyM+dI
        tuOLvFSK5ZDxokgb9UtY7RG6kwhhfSQlLUaSTWj9mtK1nt4YvV1PkVE9cBdcYzv0BMreiPS8cO3xi
        Imj2ANqt5qo9i6W8ossHkyJa1r3qNBIepPVby+8iBsdLgZ23LRYSHDQY7ps9kfdBuIndzRC3tujJ7
        7ENOzxSVrnsLe7CIztnla2DICFiuG7w/9P2MBHZNOUMc8x+Y7iT4+vFHv9xOGSmdUJo0+ljY3sKvf
        Xj27w8gQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noKCB-000Kdp-AF; Tue, 10 May 2022 07:22:11 +0000
Date:   Tue, 10 May 2022 00:22:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Message-ID: <YnoSowR8qbrYc6DL@infradead.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
 <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
 <20220509180917.0f0ae851@xps-bootlin>
 <YnlIs312R4Temgu3@smile.fi.intel.com>
 <b476913d-896d-309c-f304-3ab37b81b4a9@gmail.com>
 <CAHp75VedNAG4EqPkCp-mCSUNJiKPNgaJEtsHQkWimyaYh0Nueg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VedNAG4EqPkCp-mCSUNJiKPNgaJEtsHQkWimyaYh0Nueg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 10:40:12PM +0200, Andy Shevchenko wrote:
> > hotpluggable card?  Do the systems that you anticipate plugging the
> > card into support hotplug?
> 
> Any PCIe card is potentially hotpluggable (seems nobody actually cares
> in 90%+ drivers in the Linux kernel). But what I have heard in a
> thread (not this one IIRC) is that the card may have pluggable modules
> and it would be nice to change configuration and notify OS somehow. I
> might be mistaken if it's the case here or not.

Well.  M.2 for example is not hotpluggable, as are soldered on BGA
devices or a lot of not quite PCIe devices that actually sit on CPUs
or shipset components.  But for all but the last category an upstream
bridge could still be hot plugged, so not supporting it in drivers is
indeed generally speaking a bad idea.
