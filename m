Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECE730658
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjFNRyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 13:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFNRyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 13:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF891FCA;
        Wed, 14 Jun 2023 10:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2442B63BC8;
        Wed, 14 Jun 2023 17:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FD7C433C9;
        Wed, 14 Jun 2023 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686765274;
        bh=LFs3KEZ5mEDZ0GKDFGF6FsGRPB1VvFwyU8SZxXVA1jQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OGKEksRtQMIQsiEhIMdy1AQENzhlaMyT8TuTUHNjyWoO1YxlYsVpOnmiOrW2/6WKi
         W3DfsnpaNM4Zyz9CAi4TNCTC3PAeUuvseGgogMKeb0REh/X6IrXM8cj4KHY7byTj4V
         vaNUtGhXO2ncwSEtIDMMkGka+rlbGyNQxooRik/i0mpBIKONx8lvy39LHmk5bQOR1W
         kGvEVPEAYMfVoowJwaq4JR4VKzNuCOnLQzkZLbsa9MPsw89dqO/jU/Ap97Wu9EfOt1
         4SN+8fn1gj7/oGp8BPnppp9ctL3MOFkZZoJkEsx4BcwAVNkEvLU6NjRqkQniPfNe4N
         +0xphPJf44Djg==
Date:   Wed, 14 Jun 2023 12:54:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ondrej Zary <linux@zary.sk>
Cc:     rjw@rjwysocki.net, gottwald@igel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH] PCI/PM: Extend Elo i2 quirk to all systems using
 Continental Z2 board
Message-ID: <20230614175431.GA1395151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614074253.22318-1-linux@zary.sk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 14, 2023 at 09:42:53AM +0200, Ondrej Zary wrote:
> The quirk for Elo i2 introduced in commit 92597f97a40b ("PCI/PM: Avoid
> putting Elo i2 PCIe Ports in D3cold") is also needed by EloPOS E2/S2/H2
> which uses the same Continental Z2 board.
> 
> Change the quirk to match the board instead of system.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215715
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> Cc: stable@vger.kernel.org

Thanks, I applied this to pci/pm for v6.5 with the following subject
to try to make it easier to connect to product names:

  PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 578bf0d3ec3c..0fb0116ae69f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2956,13 +2956,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{
 		/*
 		 * Downstream device is not accessible after putting a root port
-		 * into D3cold and back into D0 on Elo i2.
+		 * into D3cold and back into D0 on Elo Continental Z2 board
 		 */
-		.ident = "Elo i2",
+		.ident = "Elo Continental Z2",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
+			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
 #endif

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
