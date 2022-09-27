Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096DC5ECCDB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiI0T2d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiI0T2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 15:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983DCF8F9D;
        Tue, 27 Sep 2022 12:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E56361B5A;
        Tue, 27 Sep 2022 19:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD6C433C1;
        Tue, 27 Sep 2022 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664306910;
        bh=RWNTYmqPUI3Toe7RywXbKJYXGIrSM5drU9vtypp4rp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JsA6KY+6L4i5DMZ1RDLps+SoNnbSoj03bg+ZzLr5n7OMd8s8WmkHZvT72/pcCHYNc
         P3OH616/Dc5y+xSgyKsdrFg00iL4vJ6cVhiXj6Lz8EU3jo2HJ7plZfzc/8G/dsM4mE
         y1/Opb8OBULX284ha5UmZ/iCy4UnW00/fwyCtbpZcT2nTA0vj80d8fpP4lib0RppRt
         38a9aJkLxU60KjSJAqnQ1XMSvZ0SQLAZiQUS3KnX9jPwbonxC69QWggO3nxHq8RkAB
         eUeFI4U70zSnNbkArb8xwEfFUmvfuIhODmPSmDKGBZp3ze7s8hBQNWkvcM1FAEiOTG
         dSHlv9yl3ZHSQ==
Date:   Tue, 27 Sep 2022 14:28:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] acpi,pci: handle duplicate IRQ routing entries
 returned from _PRT
Message-ID: <20220927192828.GA1723692@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220917090944.110885-1-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 17, 2022 at 11:09:44AM +0200, Mateusz Jończyk wrote:
> On some platforms, the ACPI _PRT function returns duplicate interrupt
> routing entries. Linux uses the first matching entry, but sometimes the
> second matching entry contains the correct interrupt vector.
> 
> This happens on a Dell Latitude E6500 laptop with the i2c-i801 Intel
> SMBus controller. This controller was nonfunctional unless its interrupt
> usage was disabled (using the "disable_features=0x10" module parameter).
> 
> After investigation, it turned out that the driver was using an
> incorrect interrupt vector: in lspci output for this device there was:
>         Interrupt: pin B routed to IRQ 19
> but after running i2cdetect (without using any i2c-i801 module
> parameters) the following was logged to dmesg:
> 
>         [...]
>         [  132.248657] i801_smbus 0000:00:1f.3: Timeout waiting for interrupt!
>         [  132.248669] i801_smbus 0000:00:1f.3: Transaction timeout
>         [  132.452649] i801_smbus 0000:00:1f.3: Timeout waiting for interrupt!
>         [  132.452662] i801_smbus 0000:00:1f.3: Transaction timeout
>         [  132.467682] irq 17: nobody cared (try booting with the "irqpoll" option)

Drop the timestamps; they add clutter but not useful information.

> Existence of duplicate entries in a table returned by the _PRT method
> was confirmed by disassembling the ACPI DSTD table.
> 
> Linux used the first matching entry, which was incorrect. In order not
> to disrupt existing systems, use the first matching entry unless the
> pci=prtlast kernel parameter is used or a Dell Latitude E6500 laptop is
> detected.

Do we have a reason to believe that in general, using the first
matching entry is incorrect?  I don't see anything in the ACPI spec
(r6.5, sec 6.2.13) that sheds light on this.

Presumably this works on Windows, and I doubt Windows would have a
platform quirk for this, so I hypothesize that Windows treats _PRT
entries as assignments, and the last one rules.  Maybe Linux should
adopt that rule?

Bjorn
