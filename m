Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34F972897F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjFHUcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFHUcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 16:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C4172E;
        Thu,  8 Jun 2023 13:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B73F9611DF;
        Thu,  8 Jun 2023 20:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0E1C433D2;
        Thu,  8 Jun 2023 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686256320;
        bh=1RqGVzFb6a0hRJWcznS5x9vBHE44EJMeA+YKttGcow8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gIOpWI80FmqzFtZVg38yG1QIJP2RwTpLWQPrXuKUUgAfATPw8GgGvpJWWvjml5ZdU
         GmGzZz7P+Mu2d3+P+NR7JXXJb/kLiQLhgRj5DZt4yWO9sMY85i2Hxbj0GqDOFwTg7j
         rMqpYl2mAzECUIrcrj6847iVzjugcf5dzTdh0X2NaM7s2bLp4Gt6cFg2pzflMvYZlG
         aMEE4TrWZ2hfeWEHQkfy+Z65IvzMm7pM9739R9kwRsmJW0maQVdwGq0m/vk9Xs4fSS
         G8fg8Q1KpF/YUeSUSWIyR4lfpOBlT5k1+qiEIEcFYGF187cmvGK8WPukbQOGkePKW7
         V/+tk4BmZnJeA==
Date:   Thu, 8 Jun 2023 15:31:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     rjw@rjwysocki.net, gottwald@igel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH] PCI: PM: Extend Elo i2 quirk to all systems using
 Continental Z2 board
Message-ID: <20230608203158.GA1213764@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519085853.1079-1-linux@zary.sk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Stefan]

s|PCI: PM:|PCI/PM| in the subject to match history.

On Fri, May 19, 2023 at 10:58:53AM +0200, Ondrej Zary wrote:
> The quirk for Elo i2 is also needed by EloPOS E2/S2/H2 which uses the
> same Continental Z2 board. Change the quirk to match the board instead
> of system.

I would mention 92597f97a40b ("PCI/PM: Avoid putting Elo i2 PCIe Ports in 
D3cold") here since it has more details that might be relevant.

Is there a problem report we can point to here?  Oh, I see you chimed
in on https://bugzilla.kernel.org/show_bug.cgi?id=215715.  Let's
include that link here, too.

This also needs a Signed-off-by tag; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.3#n363

Maybe also a stable tag since 92597f97a40b had one.

After we have the above tweaks, I plan to apply this unless somebody
objects.

Bjorn

> ---
>  drivers/pci/pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ede93222bc1..c779eb4d7fb8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2949,13 +2949,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>  	{
>  		/*
>  		 * Downstream device is not accessible after putting a root port
> -		 * into D3cold and back into D0 on Elo i2.
> +		 * into D3cold and back into D0 on Elo Continental Z2 board
>  		 */
> -		.ident = "Elo i2",
> +		.ident = "Elo Continental Z2",
>  		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
>  		},
>  	},
>  #endif
> -- 
> 2.39.2
> 
