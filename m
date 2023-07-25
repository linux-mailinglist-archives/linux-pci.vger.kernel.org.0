Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA92A7623DA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjGYUql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 16:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGYUqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 16:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ACE1733;
        Tue, 25 Jul 2023 13:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 374D4618EA;
        Tue, 25 Jul 2023 20:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52251C433C7;
        Tue, 25 Jul 2023 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690317995;
        bh=DLA6OAhIubZj4rPsH89WQo5bkfHHHDQZqjjyCtICNoo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P15Cwmwe3zkRSOi5sZtydKCn1t9svJ7FkJvS2yQHsKRGfMJkIIclKL2pya708tdZX
         GQHGK+uoG4Azgywc3NbM0ZpCVsvXzPzSxjCHGNcx+ul6KwyfoOVqRh2d14cZEAIu0B
         hOmkVXnZIvjLrAfjx3Gpx14hBhXdGaHHmEXZXbbrLlJDUBfpVVi9C3xPD6LSHIsGFS
         uVmLUS6rhZehpMLjrHlzigGCOLy/lfmCZ5SAJ/IzehRg3Rga74lZuUgW/MCNzt/wrI
         XfLXr3vTl6GHefhiXXY17tG/8QAyR7G4zNFRLPXyB5pKCqfZno8JBKVncxYxE/qGss
         8j67/qhKSCN4A==
Date:   Tue, 25 Jul 2023 15:46:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kevin Xie <kevin.xie@starfivetech.com>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230725204633.GA664368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a687c273-48b1-651e-313f-d8140732c5d8@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 06:48:47PM +0800, Kevin Xie wrote:
> On 2023/7/21 0:15, Bjorn Helgaas wrote:
> > On Thu, Jul 20, 2023 at 06:11:59PM +0800, Kevin Xie wrote:
> >> On 2023/7/20 0:48, Bjorn Helgaas wrote:
> >> > On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
> >> >> Add StarFive JH7110 SoC PCIe controller platform
> >> >> driver codes.

> >> However, in the compatibility testing with several NVMe SSD, we
> >> found that Lenovo Thinklife ST8000 NVMe can not get ready in 100ms,
> >> and it actually needs almost 200ms.  Thus, we increased the T_PVPERL
> >> value to 300ms for the better device compatibility.
> > ...
> > 
> > Thanks for this valuable information!  This NVMe issue potentially
> > affects many similar drivers, and we may need a more generic fix so
> > this device works well with all of them.
> > 
> > T_PVPERL is defined to start when power is stable.  Do you have a way
> > to accurately determine that point?  I'm guessing this:
> > 
> >   gpiod_set_value_cansleep(pcie->power_gpio, 1)
> > 
> > turns the power on?  But of course that doesn't mean it is instantly
> > stable.  Maybe your testing is telling you that your driver should
> > have a hardware-specific 200ms delay to wait for power to become
> > stable, followed by the standard 100ms for T_PVPERL?
> 
> You are right, we did not take the power stable cost into account.
> T_PVPERL is enough for Lenovo Thinklife ST8000 NVMe SSD to get ready,
> and the extra cost is from the power circuit of a PCIe to M.2 connector,
> which is used to verify M.2 SSD with our EVB at early stage.

Hmm.  That sounds potentially interesting.  I assume you're talking
about something like this: https://www.amazon.com/dp/B07JKH5VTL

I'm not familiar with the timing requirements for something like this.
There is a PCIe M.2 spec with some timing requirements, but I don't
know whether or how software is supposed to manage this.  There is a
T_PVPGL (power valid to PERST# inactive) parameter, but it's
implementation specific, so I don't know what the point of that is.
And I don't see a way for software to even detect the presence of such
an adapter.

But I assume some end users will use adapters like this and expect it
to "just work," so it would be nice if it did.

> As the Thinklife NVMe SSD may be a halted product, and the onboard
> power circuit of VisionFive V2 is no problem, we decided revert the
> sleep time to be 100ms.

Even though the product may be end-of-life, people will probably still
try to use it, and I would like it to work.  Otherwise we end up with
frustrated users and problem reports that are hard to resolve.  But I
don't know where to go here.

Bjorn
