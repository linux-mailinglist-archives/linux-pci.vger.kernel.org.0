Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E77CFCD3
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjJSOfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjJSOfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 10:35:08 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B835132
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 07:35:06 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1BDC82800A261;
        Thu, 19 Oct 2023 16:35:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 113305F021; Thu, 19 Oct 2023 16:35:04 +0200 (CEST)
Date:   Thu, 19 Oct 2023 16:35:04 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Message-ID: <20231019143504.GA25140@wunner.de>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de>
 <263982e90fc046cf977ecb8727003690@realtek.com>
 <20231018094435.GA21090@wunner.de>
 <02ee7e47166a463d8d4e491b61cdd33f@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ee7e47166a463d8d4e491b61cdd33f@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 19, 2023 at 01:49:50AM +0000, Ricky WU wrote:
> [    0.267813] pci 0000:00:1c.0: [8086:a33c] type 01 class 0x060400

Cannon Lake PCH Root Port

> [    0.275241] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000
> [    0.275315] pci 0000:01:00.0: reg 0x10: [mem 0xa3b00000-0xa3b00fff]
> [    0.275782] pci 0000:01:00.0: supports D1 D2
> [    0.275784] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.276490] pci 0000:00:1c.0: PCI bridge to [bus 01]

Device below Root Port is initially a Realtek RTS5261 card reader.

> [    0.395968] pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> [    0.396009] pcieport 0000:00:1c.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+

Root Port is hotplug-capable.

> [   43.180701] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   43.180709] pcieport 0000:00:1c.0: pciehp: Slot(8): Card not present
> [   44.403768] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [   44.403772] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [   44.540631] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802

Card reader is unplugged and replaced by SanDisk SN530 NVMe SSD.

> [   51.682628] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   51.716800] nvme0n1: detected capacity change from 495050752 to 0
> [   51.793382] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [   51.793392] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [   51.928633] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000

NVMe SSD replaced by the card reader again.

> [   54.872928] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   56.146581] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [   56.146584] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [   56.284632] pci 0000:01:00.0: [15b7:5007] type 00 class 0x010802

Card reader replaced by NVMe SSD, second time.

> [   60.635845] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   60.676842] nvme0n1: detected capacity change from 495050752 to 0
> [   60.748953] pcieport 0000:00:1c.0: pciehp: Slot(8): Card present
> [   60.748958] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Up
> [   60.884619] pci 0000:01:00.0: [10ec:5261] type 00 class 0xff0000

NVMe SSD replaced by the card reader, second time.

> [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   63.912118] BUG: unable to handle page fault for address: ffffb24d403e5010

Card reader replaced with NVMe SSD, third time.

So it took three tries to reproduce the page fault.

Thanks for the log, the issue is a little less murky now.
But it's still unclear what the root cause is and thus
what the proper solution is.  I think this needs more
in-depth debugging, see my previous e-mail.

Hope that helps!  Thanks,

Lukas
