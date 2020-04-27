Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD51B9FC6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 11:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0JW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 05:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgD0JW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 05:22:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DD920656;
        Mon, 27 Apr 2020 09:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587979375;
        bh=Pxuv+63uIXVBQfQTxfZNvzUt9zx+LD0NF0mqxrxESjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiZnlLbL+4wXJfKjJPUkYsGZ8XlotTZGKBLgn7crkXN4pezM6H8FA1oHplzieoQC8
         X8WWlQCyGPOu10+rBVEY2xyeisG4MA874EUdZkz08xhGS6zGljBiesIrFPcgfR4+i5
         87aVmpnBB9aYZwoT1ZUYlMaRY1scTI5sZ+0MMTHg=
Received: by pali.im (Postfix)
        id C35578A8; Mon, 27 Apr 2020 11:22:53 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:22:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 05/12] PCI: aardvark: Issue PERST via GPIO
Message-ID: <20200427092253.huppgr6w25jrnp4f@pali>
References: <20200424153858.29744-1-pali@kernel.org>
 <20200424153858.29744-6-pali@kernel.org>
 <CAL_Jsq+nmYMZQOUDQVO4FSU_3qg9hSJ8dOPQBymR8b-NMiAyuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+nmYMZQOUDQVO4FSU_3qg9hSJ8dOPQBymR8b-NMiAyuQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 24 April 2020 12:05:29 Rob Herring wrote:
> On Fri, Apr 24, 2020 at 10:39 AM Pali Rohár <pali@kernel.org> wrote:
> > @@ -1046,6 +1071,22 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >         }
> >         pcie->root_bus_nr = bus->start;
> >
> > +       pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
> > +                                                      "reset-gpios", 0,
> > +                                                      GPIOD_OUT_LOW,
> > +                                                      "pcie1-reset");
> > +       ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
> > +       if (ret) {
> > +               if (ret == -ENOENT) {
> > +                       pcie->reset_gpio = NULL;
> > +               } else {
> > +                       if (ret != -EPROBE_DEFER)
> > +                               dev_err(dev, "Failed to get reset-gpio: %i\n",
> > +                                       ret);
> > +                       return ret;
> > +               }
> > +       }
> 
> I believe all this can be replaced with devm_gpiod_get_optional.

I'm looking at the devm_gpiod_get_optional() code and it calls
fwnode_gpiod_get_index() which mangle passed gpio name by appending
suffix from array gpio_suffixes[]. And then mangled name is passed to
fwnode_get_named_gpiod(). At the end devm_gpiod_get_optional() handles
-ENOENT and transform it to NULL.

So via devm_gpiod_get_optional() I cannot request for "reset-gpios" DT
property directly, but I need to specify implicit name "reset" due to
appending suffix from gpio_suffixes[] array. And the only benefit is
that I do not need to handle ret == -ENOENT state.

Handling of -EPROBE_DEFER is still needed in aardvark driver.

For me it makes usage of devm_gpiod_get_optional() in this case harder
to debug code in future. As I would not be able to find a place which
reads 'reset-gpios' DT property via 'git grep reset-gpios'.

So it is really useful for this particular case to use
devm_gpiod_get_optional() instead of devm_gpiod_get_from_of_node().
