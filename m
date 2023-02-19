Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6C69C23C
	for <lists+linux-pci@lfdr.de>; Sun, 19 Feb 2023 21:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjBSUVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Feb 2023 15:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjBSUVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Feb 2023 15:21:48 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0017CDC
        for <linux-pci@vger.kernel.org>; Sun, 19 Feb 2023 12:21:46 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A385128039FF0;
        Sun, 19 Feb 2023 21:21:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8904436726; Sun, 19 Feb 2023 21:21:44 +0100 (CET)
Date:   Sun, 19 Feb 2023 21:21:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Anatoli Antonovitch <a.antonovitch@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Message-ID: <20230219202144.GA12404@wunner.de>
References: <1d474514-4d28-d41f-52cd-972ca7e3fc1d@amd.com>
 <20230217160358.GA3404296@bhelgaas>
 <BL1PR12MB51445CE9642195E9DEBC9CB8F7A19@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51445CE9642195E9DEBC9CB8F7A19@BL1PR12MB5144.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 17, 2023 at 06:37:54PM +0000, Deucher, Alexander wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Mon, Feb 13, 2023 at 09:59:52AM -0500, Anatoli Antonovitch wrote:
> > > On 2023-01-23 14:30, Anatoli Antonovitch wrote:
> > > > I do not see a deadlock, when applying the following old patch:
> > > > https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/
> > > 
> > > Can we revisit the patches again to get a fix?
> > > The issue still reproduce and visible in the kernel 6.2.0-rc8.
> > 
> > This old patch would need to be updated and reposted.  There was a 0-day
> > bot issue and a question to be resolved.  Maybe this is all already resolved,
> > but it needs to be posted and tested with a current kernel.
> 
> Lukas, can you resend that patch?  We can test it.

I'm working on a patch which aims to solve these deadlocks differently,
by reducing the critical sections for which the reset_lock is held.
Please stand by.

Thanks,

Lukas
