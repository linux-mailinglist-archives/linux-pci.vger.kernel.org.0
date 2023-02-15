Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91AB6979D4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjBOK2m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 05:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBOK2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 05:28:41 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E1366A3;
        Wed, 15 Feb 2023 02:28:40 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bh15so15370565oib.4;
        Wed, 15 Feb 2023 02:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yB8OFTfKD97aA5eOyH0KqfD+FWu2DzdqnSZBMyYeG0=;
        b=jb760RmY2mhZp9FN8h0OdqgTxR3SOPTWq/yiTljm6AokXf9of5Gzv2bZsDnFB23SQH
         E7USeo8jaYplkVWJOUaLwEPAR9Ccu0/8A9wKEn/E03VxuuUjod2y4rMkrGqhOPz28sm7
         kKtAi0E5Da+z/RKtyYLW+/4MVWi9o5SChsWjkf692ZGyLOFZEXmSL7qZtTXJrOTYbA+6
         Z0UwlZWYVQP8KbvPipWLrXrFNxzPIs9/ELq0n0JEYbvZCZC/Bb/7NsMGrJr1tLYYjyGR
         dG4t//fwr+t3G451kZLqYVDupbCSADFd2k+PvX6Uk2L5Jjn3lzuOmIHJCPYnGLSWUC5D
         a/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yB8OFTfKD97aA5eOyH0KqfD+FWu2DzdqnSZBMyYeG0=;
        b=U3jTDUI33WcE6ZEM+2KXfcOZXIlAjgUMZcUPzEZbQ/R/JwkJrXQXg5Sf3aepeF1AaI
         BUQf9H2L9pZiBwhApFPgzGRxPCcqwhV+TqU2Mf+NMopP1dS/bhAEOc0ZKfQkz9Pg0bp1
         x/AVdBWQN1oahfC99YPjGpYAYZPxrp6V4Lid7DdYgr284Nlp7Dor/foufolZlbleiFat
         +tgTvf9Og9WaxJViOLRthW/SVLHK4tdQO31Qd7XUwkyFzaprOKv6M6/ruJnEG6Jigc7I
         xw69FTmXf1TpENIWzIOJ6M76xhI7FkN03OMY/FJ/JHfHqdiBqahlRfd4TYcddxcZt9V0
         pz9A==
X-Gm-Message-State: AO0yUKWmXGCHrzstZ7s6CzgaTyqLyr7Wk+cQUz4KP6rNtiZOkQKQIF+u
        8jYvDc9Ha17C4I2lpupUiKYO6Dm+EYsmipEbmD0=
X-Google-Smtp-Source: AK7set8o82EF1RLdVxbKXwpb+W7OYj03kXyJab+ucP4FZwnFuHDzcmNItuleSEY+TdxxhHbCBhAnK/CkOwkljsDsIn8=
X-Received: by 2002:a54:4508:0:b0:37d:8b23:1d1b with SMTP id
 l8-20020a544508000000b0037d8b231d1bmr167210oil.110.1676456920180; Wed, 15 Feb
 2023 02:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com> <7b8a8d38-feef-d2af-f23f-6b2b46f78110@opensource.wdc.com>
In-Reply-To: <7b8a8d38-feef-d2af-f23f-6b2b46f78110@opensource.wdc.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Wed, 15 Feb 2023 11:28:03 +0100
Message-ID: <CAAEEuhrzysR-xfx7X-gVqUdi17R1YiWxyBM+0asQxtyZ9PQozg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller driver
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 2:51 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> Note about that: with your series applied, nothing was working for me on
> my pine Rockpro64 board (AMD Ryzen host). I got weird/unstable behavior
> and the host IOMMU screaming about IO page faults due to the endpoint
> doing weird pci accesses. Running the host with IOMMU on really helps in
> debugging this stuff :)

Thank you for testing, I have also tested with a Ryzen host, I have IOMMU
enabled as well.

>
> With the few fixes to your series I commented about, things started to
> work better, but still very unstable. More debugging and I found out that
> the pci-epf-test drivers, both host and endpoint sides, have nasty
> problems that lead to reporting failures when things are actually working,
> or outright dummy things being done that trigger errors (e.g. bad DMA
> synchronization triggers IOMMU page faults reports). I have a dozen fix
> patches for these drivers. Will clean them up and post ASAP.
>
> With the test drivers fixed + the fixes to your series, I have the
> pci_test.sh tests passing 100% of the time, repeatedly (in a loop). All solid.
>

Good to hear that it now works, I'll try them as well.

> However, I am still seeing issues with my ongoing work with a NVMe
> endpoint driver function: I see everything working when the host BIOS
> pokes at the NVMe "drive" it sees (all good, that is normal), but once
> Linux nvme driver probe kicks in, IRQs are essentially dead: the nvme
> driver does not see anything strange and allocates IRQs (1 first, which
> ends up being INTX, then multiple MSI one for each completion queue), but
> on the endpoint side, attempting to raise MSI or INTX IRQs result in error
> as the rockchip-ep driver sees both INTX and MSI as disabled. No clue what
> is going on. I suspect that a pci reset may have happened and corrupted
> the core configuration. However, the EPC/EPF infrastructure does not
> catch/process PCI resets as far as I can tell. That may be the issue.
> I do not see this issue with the epf test driver, because I suspect the
> host BIOS not knowing anything about that device, it does not touch it.
> This all may depend on the host & BIOS. Not sure. Need to try with
> different hosts. Just FYI :)
>

Interesting that you are working on this, I started to patch the RK3399 PCIe
endpoint controller driver for a similar project, I want to run our NVMe
firmware in a Linux PCIe endpoint function.

For the IRQs there are two things that come to mind:
1) The host driver could actually disable them and work in polling mode,
I have seen that with different versions of the Linux kernel NVMe driver
sometimes it would choose to use polling instead of IRQs for the queues.
So maybe it's just the
2) The RK3399 PCIe endpoint controller is said to be able only to generate
one type of interrupt at a given time. "It is capable of generating MSI or
Legacy interrupt if the PCIe is configured as EP. Notes that one PCIe
component can't generate both types of interrupts. It is either one or the
other." (see TRM 17.5.9 Interrupt Support).
I don't know exactly what the TRM means the the controller cannot
use both interrupts at the same time, but this might be a path to explore
