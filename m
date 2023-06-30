Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35A37442C5
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjF3Tjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 15:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3Tje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 15:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816953C3C
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 12:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9F3617ED
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 19:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8ABC433C8;
        Fri, 30 Jun 2023 19:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688153972;
        bh=s4k8aYGAEajFQD3DmJz7/b4slcIkcLh2XNSQpk3RNts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F4hv04PaDjtV51keWIPtvtHo7GMllMSKYujaQDdME9rpm20OyEZ1ik15UnL42RCZR
         lCLlE8gGW5orTkhFjmUv9os1lJQbKhM+8qHwdY8cYZEKHWjKKF79GkdGkTQDTJjSyh
         3FYtvCHNUTzt+BBtw6RD2dQK0ul4yg4XeBQZ2dfkBuCSYOlN+y6+G0Irb/vwbjJVgp
         trhQSE3gUkHZHwh70Oio2Rw8nQccrtrCjqQ3lDkQD9cVSidzBiTlzqsgvWuI72TW4e
         mIvEbzcd5ipuvHGVGiTs36M02GWWGmzzlRwmbsXMkdgTQHNkID3tmaL/lrpPAxlQY7
         ocsnWOLopumww==
Date:   Fri, 30 Jun 2023 14:39:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: When it rains it pours
Message-ID: <20230630193929.GA493696@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6faf3773-d974-4822-152c-0af2247cabec@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 30, 2023 at 02:30:56PM -0500, Limonciello, Mario wrote:
> Hi Bjorn,
> 
> For the _REG change that went into Linus' tree I was recently made aware of
> another system that it helps.
> 
> This system was appearing to hang during bootup which evaluating the USB4
> _OSC.
> This hang happened on both the 6.1 LTS kernel and 6.4 final kernel.
> 
> In looking at the BIOS debug log shared by the reporter I noticed that
> the kernel isn't hung it's just that the BIOS was waiting to be given the
> ability to access the config space.
> 
> Backporting just that _REG patch onto 6.1 LTS kernel fixes the issue.
> 
> I'm encouraging the BIOS team to try to come up with a cleaner failure path
> for the lack of _REG being called.  However there is always the possibility
> they can't or choose not to and people try to boot older kernels and fail.
> 
> Given how severe this boot issue is compared to the original suspend issue
> that prompted the patch I wanted to gauge how you feel about the risk of
> taking this change back to stable.

I think we can do that.  But the patch is already in the pull request
for v6.5, so we'll have to wait until Linus pulls it and then ask the
stable folks to pick it up.  I don't think it should be a big deal; we
just need a mainline SHA1 for it.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?id=v6.4#n64
