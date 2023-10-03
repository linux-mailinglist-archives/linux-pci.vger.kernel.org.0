Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42AB7B724E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjJCUHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjJCUHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 16:07:47 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E517EA1
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 13:07:44 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C0EFC2800BBF9;
        Tue,  3 Oct 2023 22:07:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B44184497E; Tue,  3 Oct 2023 22:07:39 +0200 (CEST)
Date:   Tue, 3 Oct 2023 22:07:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Make d3cold_allowed sysfs attribute read only
Message-ID: <20231003200739.GC16417@wunner.de>
References: <20231002181025.82746-1-mario.limonciello@amd.com>
 <20231003094407.GG3208943@black.fi.intel.com>
 <6291393a-b830-4a37-ad2a-1e23b6ec778e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6291393a-b830-4a37-ad2a-1e23b6ec778e@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 11:30:54AM -0500, Mario Limonciello wrote:
> On 10/3/2023 04:44, Mika Westerberg wrote:
> > On Mon, Oct 02, 2023 at 01:10:25PM -0500, Mario Limonciello wrote:
> > > Before d3cold was stable userspace was allowed to influence the kernel's
> > > decision of whether to enable d3cold for a device by a sysfs file
> > > `d3cold_allowed`.  This potentially allows userspace to break the suspend
> > > for the system.
> > > 
> > > For debugging purposes `pci_port_pm=` can be used to control whether
> > > a PCI port will go into D3cold and runtime PM can be turned off by
> > > sysfs on PCI end points.
> > > 
> > > Change the sysfs attribute to read-only and simplify the internal kernel
> > > logic to avoid needing to store the userspace request.
> > 
> > I wonder if this ends up breaking some userspace apps? Not objecting
> > though, just wanted to mention ;-)
> > 
> > One thing we could do is to taint the kernel or log a warning if
> > userspace touches this but allow it to do so.
> 
> If we collectively decide it needs to stay RW for userspace compatbility
> then I'll respin it to keep the store call but ignore whatever is written,
> return -EINVAL and emit a pr_warn_once() that it's a no-op.

I'd suggest to return 0 to avoid even the faintest ABI change whiff.

Just emit a warning once explaining that the feature is deprecated and
mark the attribute as such in ABI documentation.

Thanks,

Lukas
