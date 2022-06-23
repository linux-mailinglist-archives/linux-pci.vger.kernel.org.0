Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA61558B51
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiFWWku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiFWWku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 18:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BAC517DE;
        Thu, 23 Jun 2022 15:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03C061EF8;
        Thu, 23 Jun 2022 22:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7225C3411D;
        Thu, 23 Jun 2022 22:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656024048;
        bh=nnitVTYwb6+eE3UB/jXxlIFf+kvi+dKql4XS6JwuRC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CEYhBM5bT3+v80LqWsNgMQ9sp4oZ+tv0FfvSIjgvPo9lyF98+Ufy9q7UGF8a4pgcG
         u58UTOJA32YKvXpZuA/e/rgm7hpyiemTwP9Wj4algR9uMmhlrfSbzOfAeW/a7IpVr3
         Yw6+1Uq841ZylEkdJQiO2mGnpdruKV5PEU7MBPvgEZYsSwkSHm+LUx1F8K1KziwpKl
         yE0d59WYHjhMTFRWwjANXIXr1xHjGzEZmBUXT+au8cYBn8wWmMgdz+bhmbiqb+g/Pz
         2IojuMlqT8helRtpHc1vTpAZqsz9psc6o6t0iBUkBExZEdiOHwxy0FOqLPm0YU5OAJ
         vbl/YYpgdllEg==
Date:   Thu, 23 Jun 2022 17:40:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v6 0/6] RZN1 USB Host support
Message-ID: <20220623224046.GA1484281@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623223912.GA1484125@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 05:39:14PM -0500, Bjorn Helgaas wrote:
> On Fri, May 20, 2022 at 11:41:49AM +0200, Herve Codina wrote:
> > Hi,
> > 
> > This series add support for the USB Host controllers available on
> > RZN1 (r9a06g032) SOC.
> > 
> > These USB Host controllers are PCI OHCI/EHCI controllers located
> > behind a bridge.
> > 
> > Regards,
> > Herve
> > 
> > Changes v2:
> > - Convert bindings to json-schema
> > - Update clocks description
> > - Remove unneeded '.compatible = "renesas,pci-r9a06g032"'
> > 
> > Changes v3:
> > - Remove the unneeded patch that calls clk_bulk_prepare_enable()
> > - Rework the device tree binding (conversion from .txt and RZ/N1 support)
> > - Use the RZ/N1 SOCs family only in the driver match compatible string.
> > - Enable PM and PM_GENERIC_DOMAIN for RZ/N1 and add the missing
> >   '#power-domain-cells' in sysctrl node.
> > 
> > Changes v4:
> > - Remove patches related to PM enable and #pwower-domain-cells as they
> >   will be handle out of this series.
> > - Add Bob's reviewed-by on patch 1
> > - Add Geert's reviewed by on patch 1 and 6
> > - Rename clocks and make the 'resets' property optional on RZ/N1 family
> > - Reword some commit logs and titles
> > - Fix dst node location (sort by node names or unit addresses)
> > - Fix the USB PHY node name
> > 
> > Changes v5:
> > - Rename clocks ("usb_" prefix removed)
> > - Add Geert's reviewed-by on patch 2, 3, 4 and 5
> > 
> > Changes v6:
> > - Include schema optionnal part (ie 'if:') in a 'allOf:' block
> > - Modify commit log on commit 2/6
> > 
> > Herve Codina (6):
> >   dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
> >   dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
> >     r9a06g032
> >   PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
> 
> Applied the first three patches (above) to pci/ctrl/rcar-gen2 for
> v5.20, thank you!

Oh, just noticed there's no ack from Marek or Yoshihiro, the
maintainers of drivers/pci/controller/pci-rcar-gen2.c.  Let me know if
you object!  If you can ack it, I will amend the commits to reflect
that.

Bjorn
