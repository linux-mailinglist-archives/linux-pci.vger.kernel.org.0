Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7590E705724
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjEPTct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEPTct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E53C0A;
        Tue, 16 May 2023 12:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129996373F;
        Tue, 16 May 2023 19:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF40C433D2;
        Tue, 16 May 2023 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265567;
        bh=WBnwfoUdwMV1Gu+XaFHfWeScAtyaISLBR5Bwfq3CzQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lnx2M4IFPeFpS0vIWlzOSuxKenTmpzWiVrEcOMTLCpwMMpiDt20WgxmFFj0sh4I3U
         G1H4Dc2COxind+KG4cfY5aN2MWvrStV/rIefo0lXw9av/CUDRnkLyLXfNhuiYc8YpC
         eWLDCr/Av6FsPZOK4IHFEZdiJj8A7jjPfTAmaJVLVemLg55a+rvw54Y696IsfnMq4j
         hkCMNtRU+yQIa28y+Bfzs8nuN3p+cwIuv7IB98De50VRRrG7JLFpXZr0o9GQBMBBoC
         FnlYFwlEWIx5uqA57dpYCGiqhY9k2sjodskyMFYAPV0mBTsjLilqmAC+93rI5sq5iO
         3HP2/lHYWQ2lw==
Date:   Tue, 16 May 2023 14:32:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Acid Bong <acidbong@tilde.cafe>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, stable@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Asus X541UAK hangs on suspend and poweroff (v6.1.6
 onward)
Message-ID: <ZGPaXfV6+RUb6fXs@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5B9D233-A082-4C60-9DCB-2B0A2081C089@tilde.cafe>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 16, 2023 at 01:26:23PM +0300, Acid Bong wrote:
> >Can you collect the complete dmesg log and output of "sudo lspci -vv"
> >and post them somewhere (https://bugzilla.kernel.org is a good place)?
> `lspci -vvnn` output is linked in the head of the thread. Append .txt to make it readable in the browser (I only understood it after the upload).
> 
> >Ideally the dmesg would be from the most recent kernel you have.
>
> Speaking of that, a couple of questions:
> 
> 1) Should I post them with or without pci=nomsi/noaer? The problem
> with disabling it is that it floods the logs so fast, that they
> reach 700M in 5-7 minutes, and, when rotation is enabled (my
> parameters are default, up to 10 copies 10M each), all pre-flood
> data is lost instantly.

You're seeing AER logging, and that's what I'm interested in, so if
you could do one quick boot *without* "pci=nomsi" and "pci=noaer",
that would be great.  Then turn it off again so you don't drown in
logs.

The snippet from [1] shows a few messages related to 00:1c.5, and it
would be useful to know if there are errors related to other devices
as well.

Something like "head -c500K /var/log/dmesg > file" should be plenty.

> Also I'm currently bisecting the kernel with MSI disabled in the
> config. But I'm keeping the parameter in the bootloader for cases
> when I'm using Gentoo's prebuilt kernel.
> 
> 2) Can I delete messages by ufw? They contain MACs of my router,
> laptop and cellphone and I don't really wanna share them

Sure, delete those.

> 3) I'm not savvy in logs, how exactly should I share dmesg? `dmesg >
> file`? /var/log/syslog? I already know kern.log doesn't contain
> logind and some other messages that are present in dmesg
> 
> 4) Should we continue in this thread or rather start a new one?

Good point, a new thread would probably be better.

Bjorn

[1] https://lore.kernel.org/all/CRWCUOAB4JKZ.3EKQN1TFFMVQL@bong/
