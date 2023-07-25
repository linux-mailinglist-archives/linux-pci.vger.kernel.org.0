Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B0B7624C8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 23:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGYVtd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGYVtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 17:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE171FEB;
        Tue, 25 Jul 2023 14:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE9276186A;
        Tue, 25 Jul 2023 21:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E68EC433C8;
        Tue, 25 Jul 2023 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690321770;
        bh=wvQn3+vfatEE94wZppEmqQCo2ZDZzADNKAHxArXYbSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dw0O1jwfdcV80JDUixD/4nRJSXX4YLfrhuGxPJa9nZqH9t+z6UEj7NN4pRrMW4Iv7
         mjuaWYuta9YHhVQWIShdc/lTRNU2W4e4Bg3zoND+Wi2ZXiwdklh8jgm5Fuhxufplq2
         W/zGiPx7WlHT40tloHpIWfkyHSeESwNBbZNSci0Lpb5oWvAYE1YNIqzAJWnil0lYrS
         lMi/wvHtNQwuXU/2bxwaU0pmSosoSHH3FzsbFpHyAYxk1TrGv/inMpZ2dkh2wSYJLq
         i54xcrt+bhRWI9MwqcAzwxMcvCLq2GOih2S3T0IfCQH9Sta23DWT1ea2QVFUfpmWuc
         eJjcPF9Rcqbag==
Date:   Tue, 25 Jul 2023 16:49:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        loongson-kernel@lists.loongnix.cn, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
Message-ID: <20230725214928.GA666846@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee44ec4e-df97-c327-b83b-fe56eb2c120b@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 22, 2023 at 04:11:07PM +0800, suijingfeng wrote:
> ...
> In the future, we may want to expand VGAARB to deal all PCI display class
> devices, with another patch.
> 
> if (pdev->class >> 16 == PCI_BASE_CLASS_DISPLAY)
> 
>          // accept
> 
> else
> 
>       // return immediately.
> 
> 
> Then, we will have a more good chance to clarify the programmer interface.

I would prefer not to expand vgaarb to deal with all display devices
unless they actually need the legacy resources like [pci 0xa0000-0xbffff].

But maybe the consumer of these interfaces relies on vgaarb even for
devices that don't need those resources?  If so, please mention
examples of where they depend on vgaarb.

I expect the vgaarb interfaces are used by things that need to emulate
the option ROM to initialize the device.  If the device has a
programming interface other than 0000 0000b, the option ROM should not
be using the [pci 0xa0000-0xbffff] resource, so vgaarb should not be
needed.

Bjorn
