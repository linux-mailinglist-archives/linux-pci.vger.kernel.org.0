Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76726DB495
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 21:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjDGT41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjDGT40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 15:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD6BBB8
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 12:56:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680897342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qMmFaekNr3q+zCcENmDC1SqlYs/nIRPB6KdQau9pfo=;
        b=xQ4njX8AvzkqkU6hlZNmSsk3G1qO8lzKBxlxHkkWXMjrULAgDpVwOW6ZPl0xxnAcfW+9hg
        eCM45wCPLXRLmgdS8Ig/3PcD/UpmiLp9rDsLgMByVIkwRVCArrEssLMZIufGcE+dAJnigk
        AiGDsMdXFJztVRNCraJvK3655G9NS9e5LPA9AghGdK+ZaORfXZWBNeOGjFbREXBZ2s1StN
        taa4NnZbQaSaf4He028InGAoptJicNmKCmHcrIOgzCygNZxK9ZXY2EemQMU4N0Q9WrQGQZ
        flHih1LQmQ9gPvmKUSa8Gj/e9Xuyw0S/z/Ep7B6Za5tARHj7xWV5tiPgna3etg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680897342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qMmFaekNr3q+zCcENmDC1SqlYs/nIRPB6KdQau9pfo=;
        b=/Wc7z28UBqar/sm1SOFuCsYVmRnr2f0jmw3iB3tc2CSbkP/oSRKQLA6DoSBG6yFarKZxAq
        Y86+dH56ktl3MdDg==
To:     David Laight <David.Laight@ACULAB.COM>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCIe cycle sequence when updating the msi-x table
In-Reply-To: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
References: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
Date:   Fri, 07 Apr 2023 21:55:41 +0200
Message-ID: <87edovtqki.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 07 2023 at 16:17, David Laight wrote:
> The function that updates the MSI-X table currently reads:
>
> Now I'm not 100% sure about the cycle ordering rules.
> I've not got the spec here, and I recall it isn't that easy to
> understand.
> I can't remember whether reads are allowed to overtake writes
> (to different addresses).
> I do remember that reading back the same address was needed to
> flush the cpu store buffer on some space cpus.
> So it might be that the final readl() won't actually flush
> the write to the mask register.
> (The same readback of 'the wrong' address also happens elsewhere.)

It's guaranteed that all writes to a device have reached the device
before a read from the same device which comes after the writes is
issued. The write and read addresses do not matter.

> But there is a bigger problem.
> As the comment says writing the address/data while an entry is
> unmasked must be avoided (because a mixture of the old and new
> values could easily by used for the PCIe write cycle).
>
> But it is also quite likely that that hardware checks the masked
> bit before/after reading the address+data.
>
> So masking the interrupt immediately before the update and/or
> unmasking immediately after could also cause issues.

No it does not, because the writes are strictly ordered.

So the devices gets:

   1) write to control register with MASKBIT set
   2) write to LOWER_ADDRESS
   3) write to UPPER_ADDRESS
   4) write to ENTRY_DATA
   5) write to control register with MASKBIT cleared

#1 disables the vector and the device is not allowed to use the msg data
from the table entry until the mask bit is cleared again.

If the device gets that wrong then that's a bug in the device and not a
kernel problem.

Thanks,

        tglx


