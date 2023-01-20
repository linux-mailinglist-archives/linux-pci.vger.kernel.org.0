Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF462675C21
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjATRxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 12:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjATRxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 12:53:06 -0500
X-Greylist: delayed 30190 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 09:52:25 PST
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF7B4E02
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 09:52:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 75A6C3000CAFB;
        Fri, 20 Jan 2023 18:52:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6482A295F; Fri, 20 Jan 2023 18:52:10 +0100 (CET)
Date:   Fri, 20 Jan 2023 18:52:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>,
        Keith Busch <kbusch@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Allow marking devices as disconnected
 during bind/unbind
Message-ID: <20230120175210.GA18331@wunner.de>
References: <3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de>
 <4b6fc160-5380-d451-6aca-f3a9d636736f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b6fc160-5380-d451-6aca-f3a9d636736f@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 20, 2023 at 10:41:13AM +0100, Christian König wrote:
> Am 20.01.23 um 10:19 schrieb Lukas Wunner:
> > On surprise removal, pciehp_unconfigure_device() and acpiphp's
> > trim_stale_devices() call pci_dev_set_disconnected() to mark removed
> > devices as permanently offline.  Thereby, the PCI core and drivers know
> > to skip device accesses.
> > 
> > However pci_dev_set_disconnected() takes the device_lock and thus waits
> > for a concurrent driver bind or unbind to complete.  As a result, the
> > driver's ->probe and ->remove hooks have no chance to learn that the
> > device is gone.
> 
> Who is reading dev->error_state in this situation and especially do we have
> the necessary read barrier in place?
> 
> Alternatively if this is just opportunistically we should document that
> somehow.

dev->error_state is read by pci_dev_is_disconnected() and by various
drivers.  None of them has a specific read barrier AFAICS or is using
the device_lock to protect read access.

For pci_dev_is_disconnected(), the read is indeed opportunistic.
It's an optimization that prevents the kernel from performing
a lot of non-posted requests to a removed device and waiting
for them to time out.  Or worse, having them be received by a
replacement device.


> > That doesn't make any sense, so drop the device_lock and instead use
> > atomic xchg() and cmpxchg() operations to update the device state.
> 
> You use xchg() instead of WRITE_ONCE() for the memory barrier here?

xchg() implies a full memory barrier to ensure that the new state is
immediately visible to all CPUs.  WRITE_ONCE() would be weaker,
it's just a compiler barrier.

The desire to immediately make the state change visible is why we
absolutely do not want locking here.


> > As a byproduct, an AB-BA deadlock reported by Anatoli is fixed which
> > occurs on surprise removal with AER concurrently performing a bus reset.
> 
> Well this byproduct is probably the main fix in this patch. I'm wondering
> why lockdep didn't complained about that more drastically in our testing.

Well I guess I could rephrase the commit message if you feel I'm burying
the lede.

Thanks,

Lukas
