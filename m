Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D357CA42F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJPJcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPJcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 05:32:15 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5497;
        Mon, 16 Oct 2023 02:32:13 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8AC352800A290;
        Mon, 16 Oct 2023 11:32:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7C3D82ED8B5; Mon, 16 Oct 2023 11:32:10 +0200 (CEST)
Date:   Mon, 16 Oct 2023 11:32:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ricky Wu <ricky_wu@realtek.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Message-ID: <20231016093210.GA22952@wunner.de>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016040132.23824-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 12:01:31PM +0800, Kai-Heng Feng wrote:
> When inserting an SD7.0 card to Realtek card reader, it can trigger PCI
> slot Link down and causes the following error:

Why does *inserting* a card cause a Link Down?


> [   63.898861] pcieport 0000:00:1c.0: pciehp: Slot(8): Link Down
> [   63.912118] BUG: unable to handle page fault for address: ffffb24d403e5010
[...]
> [   63.912198]  ? asm_exc_page_fault+0x27/0x30
> [   63.912203]  ? ioread32+0x2e/0x70
> [   63.912206]  ? rtsx_pci_write_register+0x5b/0x90 [rtsx_pci]
> [   63.912217]  rtsx_set_l1off_sub+0x1c/0x30 [rtsx_pci]
> [   63.912226]  rts5261_set_l1off_cfg_sub_d0+0x36/0x40 [rtsx_pci]
> [   63.912234]  rtsx_pci_runtime_idle+0xc7/0x160 [rtsx_pci]
> [   63.912243]  ? __pfx_pci_pm_runtime_idle+0x10/0x10
> [   63.912246]  pci_pm_runtime_idle+0x34/0x70
> [   63.912248]  rpm_idle+0xc4/0x2b0
> [   63.912251]  pm_runtime_work+0x93/0xc0
> [   63.912254]  process_one_work+0x21a/0x430
> [   63.912258]  worker_thread+0x4a/0x3c0

This looks like pcr->remap_addr is accessed after it has been iounmap'ed
in rtsx_pci_remove() or before it has been iomap'ed in rtsx_pci_probe().

Is the card reader itself located below a hotplug port and unplugged here?
Or is this about the card being removed from the card reader?

Having full dmesg output and lspci -vvv output attached to a bugzilla
would help to understand what is going on.

Thanks,

Lukas
