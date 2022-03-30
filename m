Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A074EB836
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 04:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiC3CJk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 22:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiC3CJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 22:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793D1877F2;
        Tue, 29 Mar 2022 19:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12299612B1;
        Wed, 30 Mar 2022 02:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB78C340ED;
        Wed, 30 Mar 2022 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648606075;
        bh=AkX5e+wTeMQ4ic3oAOrKXqI5NwuiPlYRzw+ul249Sbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQy9NUUh3xga5wupjPsuzUsYwXnifgXgAWGNXxkQYScz+ZwhOBPuXmYCtaYya6ke7
         SRw8kb1ev68v+Rw/+f5TBqfDzH29FxQrA2N4GAV3iK9gp/GuBs4v+49145X2DIfObC
         hmDfngkjXkYFU59Vwi5z5BfMEhzoVhDW56Q+8f20r3tg4nToKwTlJ+q10IAhRsYfPg
         Rwkr8xnS4nRJYy/F/NlYylYWiphqUGlB18LZh29KKiRjBlFpEfG3dhk5FXW41Vr+wu
         8pmkvlFZxcfrOSLGCfwdSCin5RLbSBn4E5OB1eRffiY0w5v3YDwW+PuPERH9pawigT
         ZhunVUkzXINLg==
Date:   Tue, 29 Mar 2022 20:07:51 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tanjore Suresh <tansuresh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YkO7d7Eel4BVQOy4@kbusch-mbp.dhcp.thefacebook.com>
References: <20220328230008.3587975-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328230008.3587975-1-tansuresh@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 04:00:05PM -0700, Tanjore Suresh wrote:
> Problem:
> 
> Some of our machines are configured with  many NVMe devices and
> are validated for strict shutdown time requirements. Each NVMe
> device plugged into the system, typicaly takes about 4.5 secs
> to shutdown. A system with 16 such NVMe devices will takes
> approximately 80 secs to shutdown and go through reboot.
> 
> The current shutdown APIs as defined at bus level is defined to be
> synchronous. Therefore, more devices are in the system the greater
> the time it takes to shutdown. This shutdown time significantly
> contributes the machine reboot time.
> 
> Solution:
> 
> This patch set proposes an asynchronous shutdown interface at bus level,
> modifies the core driver, device shutdown routine to exploit the
> new interface while maintaining backward compatibility with synchronous
> implementation already existing (Patch 1 of 3) and exploits new interface
> to enable all PCI-E based devices to use asynchronous interface semantics
> if necessary (Patch 2 of 3). The implementation at PCI-E level also works
> in a backward compatible way, to allow exiting device implementation
> to work with current synchronous semantics. Only show cases an example
> implementation for NVMe device to exploit this asynchronous shutdown
> interface. (Patch 3 of 3).

Thanks, I agree we should improve shutdown times. I tried a while ago, but
lost track to follow up at the time. Here's the reference, fwiw, though it
may be out of date :):

  http://lists.infradead.org/pipermail/linux-nvme/2014-May/000826.html

The above solution is similiar to how probe waits on an async domain.
Maybe pci can schedule the async shutdown instead of relying on low-level
drivers so that everyone implicitly benefits instead of just nvme? I'll
double-check if that's reasonable, but I'll look through this series too.
