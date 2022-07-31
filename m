Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842658607D
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jul 2022 21:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiGaTCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jul 2022 15:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGaTCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jul 2022 15:02:21 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D33EE0E
        for <linux-pci@vger.kernel.org>; Sun, 31 Jul 2022 12:02:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1EBE4116BE5D9;
        Sun, 31 Jul 2022 21:02:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DC7B62ED8EB; Sun, 31 Jul 2022 21:02:15 +0200 (CEST)
Date:   Sun, 31 Jul 2022 21:02:15 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Harald Dunkel <harri@afaics.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: problem on reboot: pcieport 0000:00:1c:0: pciehp: Slot(0): No
 link
Message-ID: <20220731190215.GA19323@wunner.de>
References: <4013c5d1-5b47-ae2f-1071-17a7b13a3dbe@afaics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4013c5d1-5b47-ae2f-1071-17a7b13a3dbe@afaics.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 31, 2022 at 07:25:06PM +0200, Harald Dunkel wrote:
> 	kernel 5.18.14 (built from git)
> 	Qnap TS-559 Pro II, 4*3.5 HDD + 1 SSD, /boot is on USB stick
> 	Intel(R) Atom(TM) CPU D525
> 	Debian Sid
> 
> On a reboot after some runtime my Qnap TS-559 Pro II shuts down cleanly, but
> after the kernel and initrd are loaded again it writes an endless stream of
> messages to the console
> 
> pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
> pcieport 0000:00:1c:0: pciehp: Slot(0): No link
> pcieport 0000:00:1c:0: pciehp: Slot(0): Card present
> pcieport 0000:00:1c:0: pciehp: Slot(0): No link
[...]

Is this a regression?  Was it also present on older kernel versions?

The PCIe Root Port 0000:00:1c:0 is hotplug-capable and is constantly
signaling an interrupt.  Upon checking the Slot Status register,
the PCIe hotplug driver discovers that the Presence Detect bit is set,
i.e. the hardware signals hotplug of a card.  However when trying
to bring up the slot, the link fails to go up.

What's the Secondary Bus number of that Root Port?  Is there a PCIe
device below it or is the Presence Detect bit just a phantom?

If you open a bug at bugzilla.kernel.org and attach full dmesg and
lspci -vvv output plus an ACPI dump, we can analyze the issue further,
but I suspect this is a BIOS issue (vendor probably forgot to disable
that Root Port) and you need to ask your vendor for a BIOS update.
It doesn't look like a bug in the kernel to me at first glance.
If your vendor is unresponsive, you can try removing the offending
Root Port via sysfs on boot.

Thanks,

Lukas
