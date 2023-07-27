Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195B765E55
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 23:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjG0VkN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 17:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0VkM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 17:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B0211C;
        Thu, 27 Jul 2023 14:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD58F61F58;
        Thu, 27 Jul 2023 21:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9558C433C7;
        Thu, 27 Jul 2023 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690494010;
        bh=mjTnkk3b0rI1iOPv/Erll2f7p8nHIqeLrpilD6C+YDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=os6lgqeRlhps0lkDpycX0VCi+KYZNetLU7PqLKFkIOaKx75In/LdmyInZ+Cik2SRz
         s4BVM2SjHyK7IUERS4hwnVBBFsmu7iN7w95b3n4hVqqls79hSbB/BCyShUhRiCqVBN
         Rx96krUKwgicAcTwrbGQJZMgbt54TSSIDRudtnoghTiZksUJljgQjFvT1BOQUgp6OX
         SAiSBelfmexQEfqYN//OtdJ6nyYU0vc0J+qGFgkbKn5vgJcEVaO2a+OfcEjx651AdA
         1a7OKyB3BtkfaUSeEHcv+RouKXEWVwyuta8AAa2nEaFmjvGVk0blN+GDAR1UZVef42
         acC1VYKjsqxYg==
Date:   Thu, 27 Jul 2023 16:40:08 -0500
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
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230727214008.GA797783@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725204633.GA664368@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, Maciej since they've worked on similar delays recently]

On Tue, Jul 25, 2023 at 03:46:35PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 24, 2023 at 06:48:47PM +0800, Kevin Xie wrote:
> > On 2023/7/21 0:15, Bjorn Helgaas wrote:
> > > On Thu, Jul 20, 2023 at 06:11:59PM +0800, Kevin Xie wrote:
> > >> On 2023/7/20 0:48, Bjorn Helgaas wrote:
> > >> > On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
> > >> >> Add StarFive JH7110 SoC PCIe controller platform
> > >> >> driver codes.
> 
> > >> However, in the compatibility testing with several NVMe SSD, we
> > >> found that Lenovo Thinklife ST8000 NVMe can not get ready in 100ms,
> > >> and it actually needs almost 200ms.  Thus, we increased the T_PVPERL
> > >> value to 300ms for the better device compatibility.
> > > ...
> > > 
> > > Thanks for this valuable information!  This NVMe issue potentially
> > > affects many similar drivers, and we may need a more generic fix so
> > > this device works well with all of them.
> > > 
> > > T_PVPERL is defined to start when power is stable.  Do you have a way
> > > to accurately determine that point?  I'm guessing this:
> > > 
> > >   gpiod_set_value_cansleep(pcie->power_gpio, 1)
> > > 
> > > turns the power on?  But of course that doesn't mean it is instantly
> > > stable.  Maybe your testing is telling you that your driver should
> > > have a hardware-specific 200ms delay to wait for power to become
> > > stable, followed by the standard 100ms for T_PVPERL?
> > 
> > You are right, we did not take the power stable cost into account.
> > T_PVPERL is enough for Lenovo Thinklife ST8000 NVMe SSD to get ready,
> > and the extra cost is from the power circuit of a PCIe to M.2 connector,
> > which is used to verify M.2 SSD with our EVB at early stage.
> 
> Hmm.  That sounds potentially interesting.  I assume you're talking
> about something like this: https://www.amazon.com/dp/B07JKH5VTL
> 
> I'm not familiar with the timing requirements for something like this.
> There is a PCIe M.2 spec with some timing requirements, but I don't
> know whether or how software is supposed to manage this.  There is a
> T_PVPGL (power valid to PERST# inactive) parameter, but it's
> implementation specific, so I don't know what the point of that is.
> And I don't see a way for software to even detect the presence of such
> an adapter.

I intended to ask about this on the PCI-SIG forum, but after reading
this thread [1], I don't think we would learn anything.  The question
was:

  The M.2 device has 5 voltage rails generated from the 3.3V input
  supply voltage
  -------------------------------------------
  This is re. Table 17 in PCI Express M.2 Specification Revision 1.1
  Power Valid* to PERST# input inactive : Implementation specific;
  recommended 50 ms

  What exactly does this mean ?

  The Note says

    *Power Valid when all the voltage supply rails have reached their
    respective Vmin.

  Does this mean that the 50ms to PERSTn is counted from the instant
  when all *5 voltage rails* on the M.2 device have become "good" ?

and the answer was:

  You wrote;
  Does this mean that the 50ms to PERSTn is counted from the instant
  when all 5 voltage rails on the M.2 device have become "good" ?

  Reply:
  This means that counting the recommended 50 ms begins from the time
  when the power rails coming to the device/module, from the host, are
  stable *at the device connector*.

  As for the time it takes voltages derived inside the device from any
  of the host power rails (e.g., 3.3V rail) to become stable, that is
  part of the 50ms the host should wait before de-asserting PERST#, in
  order ensure that most devices will be ready by then.

  Strictly speaking, nothing disastrous happens if a host violates the
  50ms. If it de-asserts too soon, the device may not be ready, but
  most hosts will try again. If the host de-asserts too late, the
  device has even more time to stabilize. This is why the WG felt that
  an exact minimum number for >>Tpvpgl, was not valid in practice, and
  we made it a recommendation.

Since T_PVPGL is implementation-specific, we can't really base
anything in software on the 50ms recommendation.  It sounds to me like
they are counting on software to retry config reads when enumerating.

I guess the delays we *can* observe are:

  100ms T_PVPERL "Power stable to PERST# inactive" (CEM 2.9.2)
  100ms software delay between reset and config request (Base 6.6.1)

The PCI core doesn't know how to assert PERST#, so the T_PVPERL delay
definitely has to be in the host controller driver.

The PCI core observes the second 100ms delay after a reset in
pci_bridge_wait_for_secondary_bus().  But this 100ms delay does not
happen during initial enumeration.  I think the assumption of the PCI
core is that when the host controller driver calls pci_host_probe(),
we can issue config requests immediately.

So I think that to be safe, we probably need to do both of those 100ms
delays in the host controller driver.  Maybe there's some hope of
supporting the latter one in the PCI core someday, but that's not
today.

Bjorn

[1] https://forum.pcisig.com/viewtopic.php?f=74&t=1037
