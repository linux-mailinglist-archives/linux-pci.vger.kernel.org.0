Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398A553D90
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355243AbiFUVXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 17:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356150AbiFUVXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 17:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6F31DD9;
        Tue, 21 Jun 2022 14:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64877B81A9A;
        Tue, 21 Jun 2022 21:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEF8C3411C;
        Tue, 21 Jun 2022 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655846036;
        bh=6Gh2pfurCknNYy+OdSh2vMrQ6/Z8HMsRC+9OhdQ5eCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iXri0HcOwQfMFDHjHbPtrDp82vO3VYJcai9ZVqW2Gy+mKVrGY/oKkEh67UAXH371h
         Z1BnwUs1pfvNsuCBMHxN4Ce8H01DGoUOLzCMsXi/CtmGgh5V87WYu8fgO0zcm07+UC
         Ks8ycNNycGU7AKWNVG4KpOOhK4xijnQxoqShuNOdQOHyDj75yz+Zw2PwaHVfhd1zlQ
         r9tVnxklH1/mUz0FvAFOZZfeGtQVaKsP1yXnAyUAxZs8pjnOhU3710bby7GqRtJNta
         Fx02Q9l/BXpHKggDGyz3TRY01ADhZ2LV0webIIvfR19VPViOlxYbx3pboEiA+bgWdP
         irsqESke3Kjhw==
Date:   Tue, 21 Jun 2022 16:13:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Message-ID: <20220621211354.GA1332400@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df@epcms2p5>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 05:38:21PM +0900, Wangseok Lee wrote:
> On 17/06/2022 07:59, Krzysztof Kozlowski wrote:
> > On 13/06/2022 18:29, Wangseok Lee wrote:
> >> Add description to support Axis, ARTPEC-8 SoC.
> >> ARTPEC-8 is the SoC platform of Axis Communications
> >> and PCIe phy is designed based on SAMSUNG PHY.
> > 
> > No improvements here. On v2 I gave you link pointing to specific
> > paragraph of our documentation which you need to apply - wrong wrapping.
> > Is there something unclear here?
> > 
> > Please
> > do
> > not
> > wrap
> > in
> > different
> > style.
> 
> I think i misunderstood your review comment.

Krzysztof was pointing out that your commit log:

  Add description to support Axis, ARTPEC-8 SoC.
  ARTPEC-8 is the SoC platform of Axis Communications
  and PCIe phy is designed based on SAMSUNG PHY.

only fills about 50 columns, and if you run "git log", most commit logs
fill about 75 columns so that when git adds 4 spaces of indentation, they
fit nicely in an 80-column terminal and take advantage of the whole width.

It's easier to read when all the commit logs are roughly the same
width.  So please wrap yours to something like this:

  Add description to support Axis, ARTPEC-8 SoC.  ARTPEC-8 is the SoC
  platform of Axis Communications and PCIe PHY is designed based on Samsung
  PHY.

The PCI driver the commit log is:

  Add support Axis, ARTPEC-8 SoC.
  ARTPEC-8 is the SoC platform of Axis Communications.

  This is based on arm64 and support GEN4 & 2lane.
  This PCIe controller is based on DesignWare Hardware core and uses DesignWa
  re core functions to implement the driver.

  "pcie-artpec6. c" supports artpec6 and artpec7 H/W.
  artpec8 can not be expanded because H/W configuration is completely differe
  nt from artpec6/7.
  phy and sub controller are different.

This should be similarly rewrapped to fill 75 columns.  The short lines are
a signal to the reader that "this is the last line of a paragraph, so
expect a new paragraph to follow."

But in commit logs, paragraphs are typically separated by blank lines, so a
short line followed not by a blank line but by text that *could* fit on the
previous short line is a confusing signal.

This similar to the Wikipedia style:
https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Layout#Paragraphs

The PCI driver commit log should also join "DesignWare" and "different",
which are currently split across lines.

> I will modify it as below.
> s/SAMSUNG PHY/Samsung phy

"PHY" is typically all caps in English text, e.g., see examples here:
https://en.wikipedia.org/wiki/Physical_layer#PHY

Bjorn
