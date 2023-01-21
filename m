Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6F6764E8
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jan 2023 08:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjAUHVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Jan 2023 02:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAUHVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2023 02:21:54 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6686E0FE
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 23:21:52 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 46FA4100D942B;
        Sat, 21 Jan 2023 08:21:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1921C56B98; Sat, 21 Jan 2023 08:21:48 +0100 (CET)
Date:   Sat, 21 Jan 2023 08:21:48 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Cc:     Anatoli Antonovitch <a.antonovitch@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alexander.Deucher@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Message-ID: <20230121072148.GA13969@wunner.de>
References: <20230113170131.5086-1-a.antonovitch@gmail.com>
 <20230120092824.GA2951@wunner.de>
 <d14fd1b2-41c9-75bd-5b76-d2c396c1ebb7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14fd1b2-41c9-75bd-5b76-d2c396c1ebb7@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 04:35:01PM -0500, Anatoli Antonovitch wrote:
> On 2023-01-20 04:28, Lukas Wunner wrote:
> > I've just submitted an alternative patch to fix this, could you give
> > it a spin and see if the issue goes away?
> > 
> > https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/
> 
> The patch has been tested on the same setup.
> Unfortunately, this alternative approach with optimization and simplified
> locking is not resolve the issue in
> https://bugzilla.kernel.org/show_bug.cgi?id=215590
> 
> I have uploaded the log dmesg_6_2_rc4_hotadd_aer_fix_a6bd101b8f84.txt into
> the bugzilla for your patch.

You're now getting a different deadlock.  That one is addressed by this
old patch (it's already linked from the bugzilla):

https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/

If you apply that patch plus the new one, do you still see a deadlock?

Thanks,

Lukas
