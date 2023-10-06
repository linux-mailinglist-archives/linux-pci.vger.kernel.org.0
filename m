Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55467BB75B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjJFMKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJFMKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 08:10:49 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 535B2C2;
        Fri,  6 Oct 2023 05:10:47 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 899A492009C; Fri,  6 Oct 2023 14:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7CC1892009B;
        Fri,  6 Oct 2023 13:10:45 +0100 (BST)
Date:   Fri, 6 Oct 2023 13:10:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [-next 1/5] PCI: Add the pci_is_vga() helper
In-Reply-To: <42a15522-7bed-c5b1-1dc3-65446b65e348@loongson.cn>
Message-ID: <alpine.DEB.2.21.2310061246430.20732@angie.orcam.me.uk>
References: <20231005225101.GA792747@bhelgaas> <42a15522-7bed-c5b1-1dc3-65446b65e348@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 6 Oct 2023, Sui Jingfeng wrote:

> > I think this makes sense per the spec, but there's always a risk of
> > breaking something, so it's nice if the change actually *fixes*
> > something to make that risk worthwhile.
> 
> 
> Maciej mentioned that PCI_CLASS_NOT_DEFINED_VGA device should also be handled
> in the past.
> see [1]. But if no one interested in PCI_CLASS_NOT_DEFINED_VGA nowaday, then I
> guess
> the gains of this patch may not deserve the time and risk. But I don't mind if
> someone
> would like pick it up for other purpose.

 Well, if we need to determine for whatever purpose whether a PCI/e device 
presents a VGA programming interface, then I think we ought to do this in 
a complete manner.  I'm not sure offhand what could possibly break if we 
write our code according to specs and include PCI_CLASS_NOT_DEFINED_VGA 
devices in the class.

 Yes, I'm aware they won't be the latest and greatest, but they may still 
be there out there in service.  For one I continue using my 30 years old 
Trident 8900C ISA VGA adapter with the most recent Linux kernel.  The card 
serves its purpose, mostly as a glass TTY, so why should I replace it?

 Of course there are broken devices out there regardless, which won't work 
as we expect without special handling or sometimes at all even.  It does 
not mean we should refrain from making the best effort for good compliant 
devices and assume in advance that something will break even if we write 
our code according to the relevant specs.  I'd say do write according to 
specs and only try to sort out the situation somehow if something actually 
does break.

 In any case if we actually do choose to ignore PCI_CLASS_NOT_DEFINED_VGA 
devices, then I wanted to make sure we do it deliberately rather than from 
the lack of awareness of the existence of such devices.

  Maciej
