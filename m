Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BF589A84
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 12:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHDKgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDKgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 06:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63A24087
        for <linux-pci@vger.kernel.org>; Thu,  4 Aug 2022 03:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED9DC61668
        for <linux-pci@vger.kernel.org>; Thu,  4 Aug 2022 10:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C34C433D6;
        Thu,  4 Aug 2022 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659609408;
        bh=ES/iHojojwBeWATmvF586pssKR6IM+n64XwkRqabZhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4iODQzk2o507TOyNZ9YdPnsp04nepRb1NxsdHFTlYs/YDfMvZ8e9NeSAY+Hx3QXD
         a94/Suuw4dA3lc/FiB/JntVvRyacRO62LwWgCezjrPJwwl6MRNEDCeLfJhGSzaHRcR
         Tv8O0aWvDnbGdjrq2DADM4dC58LzfY8CWIEHxiI9RR0svVp5rAKEVU1PUrECDD8U+M
         cFmNIskF2+eG98FoKaiyyV5LbstQSgDcYj3pmAZKYZ0zQqKj8vQ7VZYOmfEoG9Z9cN
         XV2ypNTCRPsBNmA9scCo7+pFa4VElC6sG8Aa6dlq/RaiURX8XM2T+fYz58F/p57jbY
         1EO4L9RyDM0qQ==
Date:   Thu, 4 Aug 2022 12:36:41 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: arm64 PCI resource allocation issue
Message-ID: <YuuhOdV09R+K5ui/@lpieralisi>
References: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204dda77248a7c95787e27fc7a382f514341c88e.camel@kernel.crashing.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 02, 2022 at 02:07:00PM +1000, Benjamin Herrenschmidt wrote:

[...]

> The case back then was that there existed some (how many ? there was
> one real example if I remember correctly) bogus firwmares that came out
> of UEFI with too small windows. We could just quirk those ....

There is just one way to discover "how many" unfortunately, quirking
those can be more problematic than it seems.

[...]

> The alternative here would be to use ad-hock kludges for such system
> devices, to "register" the addresses early, and have some kind of hook
> in the PCI code that keeps track of them as they get remapped.

That's what x86 does AFAICS (pcibios_save_fw_addr()), even though
it is used in a different scope (ie revert to FW address if the
resource allocation fails).

> If we want this, I would propose (happy to provide the implementation
> but let's discuss the design first) something along the line of a
> generic mechanism to "register" such a system device, which would add
> it to a list. That list would be scanned on PCI device discovery for
> BAR address matches, and the pci_dev/BAR# added to the entry (that or
> put a pointer to the entry into pci_dev for speed/efficiency).
> 
> The difficulty is how is that update propagated:
> 
> This is of course fiddly. For example, the serial info is passed via
> two different ways, one being earlycon (and probably the easiest to
> track), the other one an ASCII string passed to
> add_preferred_console(), which would require more significant hackery
> (the code dealing with console mathing is a gothic horror).
> 
> Also if such a system device is in continuous use during the boot
> process (UART ?) it needs to be "updated" as soon as possible after the
> BARs (and parent BARs) have been also updated (in fact this is
> generally why PCI debug dies horribly when using PCI based UARTs).
> Maybe an (optional) callback that earlycon can add ?
> 
> Additionally, this would only work if such system devices are
> "registered" before they get remapped... 
> 
> Another approach would be to have pci_dev keep a copy of the original
> resources (at least for the primary BARs) and provide an accessor for
> use by things like earlycon or 8250 to compare against these, though
> that doesn't solve the problem of promptly "updating" drivers for
> system devices.
> 
> Opinions ?

You may also want to look into IORESOURCE_PCI_FIXED even though the
last time I looked into I found some broken logic (basically the
immutable/"fixed" BAR resources should obviously take into account the
PCI tree hierarchy - upstream bridges, etc., which I don't think
IORESOURCE_PCI_FIXED does - how it works remains a bit of
a mystery for me).

Lorenzo
