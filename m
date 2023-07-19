Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73A759D13
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjGSSH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGSSH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 14:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FADD9E;
        Wed, 19 Jul 2023 11:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2989617D2;
        Wed, 19 Jul 2023 18:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06637C433C8;
        Wed, 19 Jul 2023 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689790075;
        bh=BtjH8sWL9n5DjUOXCUilsWd4aWNHoklU3FHjEqQvSvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tkOnohpjRtu+UdHtmqtKiGVSHWhQ/6PoSbOmhgUKeEbBDFNptjICuGJdx9vEto4X0
         IX/WA9/RYHSDgdsADsoQhDCZKILX15TTGsLblzIcT6bGaISYR3SxAFOjeKJERDL65c
         1cBm8yvXxaK9HektlpIH1Bl5Cbn9/+Y7TFfexxpJRqLuribxUAn5dTz2fFh++GnyEB
         744tC+3nOcolkPiES+hjfls/7bYxbZ+9YZ/VB0DOQRKbQ4ESCNlnuE6fXliSOUz/C1
         57B0N67q9RZ2PtWj6gyYgvJAIQBA7zEZEcrUfSW7WoRb6ZGgK5Pq+PPOjbe1RjV5xc
         08wH/snPuWAmA==
Date:   Wed, 19 Jul 2023 13:07:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/4] PCI/VGA: Deal only with PCI VGA class devices
Message-ID: <20230719180752.GA509850@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718231400.GA496927@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 06:14:00PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 30, 2023 at 06:17:29PM +0800, Sui Jingfeng wrote:
> > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > 
> > VGAARB should only care about PCI VGA class devices (pdev->class == 0x0300)
> > since only those devices might have VGA routed to them.
> 
> This is not actually a question of whether VGA addresses (mem
> 0xa0000-0xbffff and io 0x3b0-0x3bb, 0x3c0-0x3df) might be *routed* to
> the device because that routing is controlled by the bridge VGA Enable
> bit, not by a device Class Code.
> 
> I think the important question here is what devices will *respond* to
> those VGA addresses.  The VGA arbiter works by managing bridge VGA
> Enable bits, so if we know a device doesn't respond to the VGA
> addresses, there's no point in adding a vga_device for it.

Sorry, I see that I replied to an old version of this patch.  I'll go
look at this series instead:

https://lore.kernel.org/r/20230711134354.755966-1-sui.jingfeng@linux.dev

Bjorn
