Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55067511B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjATJaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjATJaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 04:30:03 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6DDA19A0
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 01:29:35 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 75FAA300160EC;
        Fri, 20 Jan 2023 10:28:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6C1681D7C40; Fri, 20 Jan 2023 10:28:24 +0100 (CET)
Date:   Fri, 20 Jan 2023 10:28:24 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Anatoli Antonovitch <a.antonovitch@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Alexander.Deucher@amd.com, christian.koenig@amd.com,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Message-ID: <20230120092824.GA2951@wunner.de>
References: <20230113170131.5086-1-a.antonovitch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113170131.5086-1-a.antonovitch@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Anatoli,

On Fri, Jan 13, 2023 at 12:01:31PM -0500, Anatoli Antonovitch wrote:
> It is to avoid any potential issues when S3 resume but at the same
> time we want to hot-unplug.
> 
> To fix the race between pciehp and AER reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=215590

I've just submitted an alternative patch to fix this, could you give
it a spin and see if the issue goes away?

https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/

That alternative approach is preferable IMO because it also solves the
problem that marking devices as permanently offline isn't possible
concurrently to driver bind/unbind at the moment.  Additionally,
the alternative patch simplifies locking and reduces code size.

Thanks and sorry for my belated response.

Lukas
