Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE396BD98A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 20:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCPTum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCPTul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 15:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C6C6C188;
        Thu, 16 Mar 2023 12:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB0FB62104;
        Thu, 16 Mar 2023 19:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0590BC433EF;
        Thu, 16 Mar 2023 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678996239;
        bh=moLvtDcS2t0hYUwb9GPaqpFg5LnXXKhW5777Gh63RF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bACMCg7rlfffyva7/AnZ9DFx6GD8gcLpUyR5uwB7d53qst8LAUPe+H0f2WhpORKI3
         frZOtCpHNTUSLCd6mUJ8FWi5Y3ZM3kJJUYXhprnWPcN7mvBb7qQrkJqQUBEuMnjZ1r
         mSox0SsJgEmUs9Bn5rEeA0GPLtRNlp6e3i0w3PdhrFDBp2h4Fy8TYVLtfb7rjX52ov
         c3135VSwyhAxT5n6fecCbGxYJy7tjB3oEGHPBpWOb+eVbPpSYGDhw3ZE3gzuHB8eEq
         bzC0VgB458HEEX2Sr6Bwahm1vBzQOaszWp87nedPgAvUbm8AVozDhAGCeAtf4hABwF
         yE5EjSn6jN8lw==
Date:   Thu, 16 Mar 2023 14:50:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH] PCI: stop spamming info in quirk_nvidia_hda
Message-ID: <20230316195037.GA1849341@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316143122.2377354-1-kherbst@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 16, 2023 at 03:31:22PM +0100, Karol Herbst wrote:
> Users kept complaining about those messages and it's a little spammy on
> prime systems so turn it into a debug print.

What is a "prime system"?

I'm a little surprised that users would really care about the message.
But I do see comments like these:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836308/comments/15
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2002206
that suggest the message happens frequently, maybe if we're resuming
the controller after runtime suspend?

Maybe this should be a pci_info_once() sort of thing?  I think there's
some value in knowing that we're changing the BIOS configuration
outside the purview of a driver, since I assume BIOS had some reason
for hiding the HDA controller.

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Cc: nouveau@lists.freedesktop.org
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44cab813bf951..b10c77bbe4716 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5549,7 +5549,7 @@ static void quirk_nvidia_hda(struct pci_dev *gpu)
>  	if (val & BIT(25))
>  		return;
>  
> -	pci_info(gpu, "Enabling HDA controller\n");
> +	pci_dbg(gpu, "Enabling HDA controller\n");
>  	pci_write_config_dword(gpu, 0x488, val | BIT(25));
>  
>  	/* The GPU becomes a multi-function device when the HDA is enabled */
> -- 
> 2.39.2
> 
