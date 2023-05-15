Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30702703EDD
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbjEOUvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 16:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbjEOUvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 16:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2707EDD;
        Mon, 15 May 2023 13:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F7762537;
        Mon, 15 May 2023 20:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C992BC433EF;
        Mon, 15 May 2023 20:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684183880;
        bh=gAaxqdEUQkw8LfkOGDpq841oskaFlCAl0W84Cnjnr8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ESlXR15gAAalNchEl/7wvfkLF+B8S5CEYoCOTnFbUGWKUOZk7RR0NJDykrQ7DACYG
         5iNjd6FDUWrQ3tX0mvwBJoFv2S3aSvK7kA/3FueeLzUgEu/7evw6ce4BqRY+k/Wnfj
         frX6fiVx0W1+FyF5mEUThyQgypPAjtgrjtOmX945fjemDFV74fer0HVhiHM+ATR+E2
         AwHXRIY4Bd08I7Xsd7xbfdlnLe9iLuhwkqELvVUibgqbxTqenyNt65hVDTDPcBixYB
         uwtESfvOKJjzlw0hF650zwi4Bl6SRIatK5vUItA4Gvl7PRd+Rf1wCb3SdGpymXFZnq
         RvF3qujEiZwvg==
Date:   Mon, 15 May 2023 15:51:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Acid Bong <acidbong@tilde.cafe>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, stable@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Message-ID: <ZGKbRo9shUcR0myC@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CRWCUOAB4JKZ.3EKQN1TFFMVQL@bong>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci; thread at
https://lore.kernel.org/r/CRVU11I7JJWF.367PSO4YAQQEI@bong]

On Fri, Apr 14, 2023 at 12:07:42PM +0300, Acid Bong wrote:
> > Thorsten
> > why do you pass pci=nomsi
>
> It's a workaround for another issue i've been facing for about 2 or 3
> years, since when I first tried out Linux (started with loading Kubuntu
> and Mint live images). Without that workaround Kubuntu didn't boot for
> me - on kernel 5.8 it only reached the graphic installer part, but hung
> after language selection menu, on 5.4 and 5.11 - didn't even reach the
> graphic session. With Mint it was more severe - the screen was flooded
> with PCIe errors, like so:
> 
> 	Apr 10 18:47:08 bong last message buffered 3 times
> 	Apr 10 18:47:08 bong kernel: pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask
> 	Apr 10 18:47:08 bong last message buffered 5 times
> 	Apr 10 18:47:08 bong kernel: pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask
> 	Apr 10 18:47:08 bong last message buffered 13 times
> 	Apr 10 18:47:08 bong kernel: pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask
> 	Apr 10 18:47:08 bong last message buffered 5 times
> 	Apr 10 18:47:08 bong kernel: pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask
> 	Apr 10 18:47:08 bong last message buffered 6 times
> 
> `pci=nomsi` saved me also during Debian installation - without it the
> live ISO just crashed mid-installation.

Likely "pci=nomsi" or "pci=noaer" are not related to the
suspend/poweroff issue, but I'd really like to fix the AER problem
anyway.

Can you collect the complete dmesg log and output of "sudo lspci -vv"
and post them somewhere (https://bugzilla.kernel.org is a good place)?

Ideally the dmesg would be from the most recent kernel you have.

Bjorn
