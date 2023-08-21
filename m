Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80117782F78
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHURdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHURdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 13:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7810B;
        Mon, 21 Aug 2023 10:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FED46401A;
        Mon, 21 Aug 2023 17:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5A3C433C8;
        Mon, 21 Aug 2023 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692639202;
        bh=P7TLnAKhTYRL1J+d4M8hHwwIMX7rOctfYsRcpM82WRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TKP3p7nEb9cznH5KUgLXIcMmpSvFIxXrbXI+fe0aY4VNOFr1cpwiizfGwUHiws6n9
         QnRwHu4LcZtSXvydFEA/Mvn2zmrJnu6qSlKNnPKwpjZjW++27QVadO6H6hRdo8YPOx
         1sBZzZDgDMBHxXfjLSYJzNfgLkqZduEFr1LKBsC3fJ6XXPYVCDlkSh+Y1N4wNEyt8h
         nRNinShKiZQnAAp3R6Z3Yd0oLGImp3fkqEnJnz/R5rtla2kI+iTq/y30UbmcsROoym
         ZPJQF4wH1PLk1PBX0joEExllI3vqqXpdskrgHqcc5L4jhGh92D1ELIM+ugvZrdmOtw
         8cv6bKLGMEBOg==
Date:   Mon, 21 Aug 2023 12:33:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4] PCI/VGA: Make the vga_is_firmware_default() less
 arch-dependent
Message-ID: <20230821173320.GA362442@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb7ace8-2f07-17b6-10ce-7116b05b0148@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 09:48:46AM +0800, suijingfeng wrote:
> On 2023/8/18 06:08, Bjorn Helgaas wrote:
> > > +		if (resource_type(res) != IORESOURCE_MEM)
> > > +			continue;
> > > +
> > > +		if (!res->start || !res->end)
> > > +			continue;
> > > +
> > > +		if (res->start <= fb_start && fb_end <= res->end) {
> > > +			pdev_boot_vga = pdev;
> > > +
> > > +			vgaarb_info(&pdev->dev,
> > > +				    "BAR %d contains firmware FB\n", i);
> > Print the BAR with %pR and include the framebuffer region from
> > screen_info in the same format.
> 
> I do remember that you already told me to do this in V3, sorry for not
> replying to you at V3. Most of the time, what you tell me is right.But here,
> I think I need to explain. Because doing it that way will make the code line
> too long,and it will exceed 80 characters in the column if we print too
> much.
> I believe that the vgaarb_info() at here is already the most compact and
> simplest form. Printing the BAR with %pR is not absolute necessary, because
> we can get the additional information by: $ lspci | grep VGA
> 
> $ dmesg | grep 05:00.0
> $ dmesg | grep 0000:03:00.0
> $ dmesg | grep PCI

Fair enough.  The BAR info is already there.  But I don't think the
screen_info framebuffer data is in the dmesg log anywhere, and I think
that would be useful.

It's fine if dmesg lines or kernel printk lines exceed 80 columns.

> Actually, I only add something that is absolute necessary.
> Printing BAR with %pR and/or Printing the framebuffer region
> is consider to only for *debugging* purpose.

I think printing the framebuffer region is important because it makes
it clear *why* we're selecting the device as the default VGA device.
It's more than just debugging; it helps make the system more
transparent and more understandable.

Bjorn
