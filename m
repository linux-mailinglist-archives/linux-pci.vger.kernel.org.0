Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB668C9BA
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 23:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFWpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 17:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBFWpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 17:45:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA97303D7
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 14:45:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87C93B81625
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 22:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136D5C433EF;
        Mon,  6 Feb 2023 22:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675723527;
        bh=kWSGDillvjdiSffL4az/NdNLWHdq5uJAfghZzZgdCKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnYfyb38v80M9zpa4rk/ZmUWgvrGGM4clafpLOBYJmbL7IvzxckJ2Cd5U/yl1Hr3R
         3qqVHzIB7uaGvf2e2gonMY4ZrYSpvUslWnTSlgehKHOPzHxz/mDyCNS1X6QQwQfoKu
         3VzS8kt8vzzVU+VYiAXVWM8qjjA6zhXXaICnlklpQtDZn05ZRGRo7yV3J8SDd6TOxD
         p/uJkrvLEIuGZcGcy0dmROt9yq37xRUac0UVuHHj1kjJHe5Y23jtA7izviylBXacOQ
         TSALUbSYixP4zVJ9jnQXiaxdHejeYmTsIlgtmFt/zYksm8nOe2B8yuOXgi17BGMRX+
         4sxNm+lSOFQJg==
Received: by pali.im (Postfix)
        id 4E1F7875; Mon,  6 Feb 2023 23:45:24 +0100 (CET)
Date:   Mon, 6 Feb 2023 23:45:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230206224524.pz7pjma7q2fuwv2l@pali>
References: <20230114164125.1298-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230114164125.1298-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 14 January 2023 17:41:25 Pali Rohár wrote:
> People are reporting that pci-mvebu.c driver does not work with recent
> mainline kernel. There are more bugs which prevents its for daily usage.
> So lets mark it as broken for now, until somebody would be able to fix it
> in mainline kernel.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Bjorn: I would really appreciate if you take this change and send it in
> pull request for v6.2 release. There is no reason to wait more longer.

Ping? Any comments?

> 
> I'm periodically receiving emails that driver does not work correctly
> anymore, PCIe cards are not detected or that they crashes during boot.
> 
> Some of the issues are handled in patches which are waiting on the list for
> a long time and nobody cares for them. Some others needs investigation.
> 
> I'm really tired in replying to those user emails as I cannot do more in
> this area. I have asked more people for help but either there were only
> promises without any action for more than year or simple no direction how
> to move forward or what to do with it.
> 
> So mark this driver as broken. Users would see the real current state
> and hopefully will stop reporting me old or new bugs.
> ---
>  drivers/pci/controller/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 1569d9a3ada0..b4a4d84a358b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -9,6 +9,7 @@ config PCI_MVEBU
>  	depends on MVEBU_MBUS
>  	depends on ARM
>  	depends on OF
> +	depends on BROKEN
>  	select PCI_BRIDGE_EMUL
>  	help
>  	 Add support for Marvell EBU PCIe controller. This PCIe controller
> -- 
> 2.20.1
> 
