Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF8D74050D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 22:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjF0Ul3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 16:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0Ul2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 16:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6F10D8
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 13:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCB9611F9
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 20:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D89C433C0;
        Tue, 27 Jun 2023 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687898486;
        bh=F8uktb/1sTuNLltdxIuUiOWdR1cxJT7PxFB6uKMz/wU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YYO5L9txzsFQbpn/6w+bajR5ZT6rKZg9+Dq3fAidrkJEsJOlPAl1I5YBNfYdBZwYJ
         KODCTw2Yl5YdjgAt7KhSBGmMCWUjmJAoDCZ5yyBJR4BVL6MbDeiXAdrP4HwC6tW+KN
         WMvZAsSh13h0mKqO2M/o1aS6Nj5hdFxsnO+hcx8YRmpgyALWequx+yLqUxh0N04QoB
         8j4Y4qlxG6s/IXg0XF2yHRIh+v7ZcNALn3jGOZxcEktkK3iQiJf/o4k5ioBOQTRCMQ
         Jinoj9jwjoXbs5KNfaRxv+a2hQYIxAOCM39mIRXKjXMiBGBrTLjGcp1Zn0kc29CMCR
         K+zg7ToZJGygA==
Date:   Tue, 27 Jun 2023 15:41:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thomas Witt <thomas@witt.link>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20230627204124.GA366188@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627100447.GC14638@black.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 01:04:47PM +0300, Mika Westerberg wrote:
> On Tue, Jun 27, 2023 at 11:53:33AM +0200, Thomas Witt wrote:
> > On 27/06/2023 08:24, Mika Westerberg wrote:
> > > Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> > > for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> > > due to a regression that caused resume from suspend to fail on certain
> > > systems. However, we never added this capability back and this is now
> > > causing systems fail to enter low power CPU states, drawing more power
> > > from the battery.
> > 
> > Hello Mika,
> > 
> > I am sorry, but your patch (applied on top of master) triggers the exact
> > same behaviour I described in
> > <https://bugzilla.kernel.org/show_bug.cgi?id=216877> (nvme and wifi become
> > unavailable during suspend/resume)
> 
> Thanks for testing! Can you provide the output of dmidecode from that
> system? We can add it to the denylist as well to avoid the issue on your
> system.

To me this says we don't completely understand the mechanism of the
failure.  If BIOS made L1SS work initially, Linux should be able to
make it work again after suspend/resume.

If we can identify an actual hardware or firmware defect, it makes
good sense to add a quirk or denylist.  But I'll push back a little if
it's just "there's some problem we don't understand on this system, so
avoid it."

Bjorn
