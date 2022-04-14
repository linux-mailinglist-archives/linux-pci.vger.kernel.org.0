Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60605002EC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 02:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiDNAM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiDNAM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 20:12:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9697115FEA;
        Wed, 13 Apr 2022 17:10:34 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AD3BA92009C; Thu, 14 Apr 2022 02:10:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9E7F592009B;
        Thu, 14 Apr 2022 01:10:33 +0100 (BST)
Date:   Thu, 14 Apr 2022 01:10:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
cc:     Alexandre Ghiti <alex@ghiti.fr>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Neill Whillans <neill.whillans@codethink.co.uk>
Subject: Re: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing
 on some boards
In-Reply-To: <bded4b1e-3404-6bcd-3289-dc8d5b4d713a@codethink.co.uk>
Message-ID: <alpine.DEB.2.21.2204140048460.9383@angie.orcam.me.uk>
References: <20220318152430.526320-1-ben.dooks@codethink.co.uk> <2442936e-a53e-59bf-488f-95eac26d1252@ghiti.fr> <85e864fd-762e-0780-f829-bfbb178ab24e@ghiti.fr> <bded4b1e-3404-6bcd-3289-dc8d5b4d713a@codethink.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Mar 2022, Ben Dooks wrote:

> > FWIW, I have tested this and it solved my issue with nvme not being probed,
> > so:
> > 
> > Tested-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> 
> Ok, great. Our test rig seems to be still working with this.

 I ran simple verification of your change by interrupting U-Boot after a 
power-up and issuing:

=> setenv boot_pci_enum true

at the command prompt before booting from the uSD card and curiously 
enough the root port comes up with the Link Capabilities Register 
reporting the lack of Link Bandwidth Notification Capability in this 
scenario, while it reports its presence if booted undisturbed, i.e.:

		LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <4us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+

vs:

		LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency L0s <4us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+

It is fully reproducible.

 Any idea what might be causing it?  I can't see it being explicitly set 
or cleared anywhere, be it in U-Boot or Linux, so it must be done by the 
device itself depending on something.  And the lack of this capability 
seems to me like non-compliance for a multiple-lane, multiple-speed 
device.

  Maciej
