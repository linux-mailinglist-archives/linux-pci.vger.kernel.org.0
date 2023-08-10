Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03177747D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjHJJb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjHJJb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 05:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B349FD1;
        Thu, 10 Aug 2023 02:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D68C64F5E;
        Thu, 10 Aug 2023 09:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310DCC433C8;
        Thu, 10 Aug 2023 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691659886;
        bh=JUX0IsKVB3BGt/Yi7I6dUFuvLsEYKbdTWuXM+2O2eYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7EqxGo3qR2eGkJ8lB/ZAafvQzAGNICLKOljnlUaHYdXoGJcytqszWFnu8Gbf3wFP
         Dcav5707Yzkz0R2HEH3YWx9q6P+QjxaXRGCMjr4ongNDs3qHvKXNH7XtZ4ngiD0/yW
         CUD7kqaWuui6gEW7lo914Jv0apUAFZpiU0wCiEuA=
Date:   Thu, 10 Aug 2023 11:31:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Fix nomenclature for USB and PCI wireless devices
Message-ID: <2023081059-omen-hence-c554@gregkh>
References: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
 <2023080940-overhand-fondly-7ef7@gregkh>
 <cce342f1-55b9-49ba-81a9-cc9e83735ff9@rowland.harvard.edu>
 <6f63b0f1764428d400fe512d33957a578629ff04.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f63b0f1764428d400fe512d33957a578629ff04.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 11:29:57AM +0200, Johannes Berg wrote:
> On Wed, 2023-08-09 at 10:05 -0400, Alan Stern wrote:
> > On Wed, Aug 09, 2023 at 02:16:48PM +0200, Greg KH wrote:
> > > On Tue, Aug 08, 2023 at 08:44:48PM -0400, Alan Stern wrote:
> > > > A mouse that uses a USB connection is called a "USB mouse" device (or
> > > > "USB mouse" for short), not a "mouse USB" device.  By analogy, a WiFi
> > > > adapter that connects to the host computer via USB is a "USB wireless"
> > > > device, not a "wireless USB" device.  (The latter term more properly
> > > > refers to a defunct Wireless USB specification, which described a
> > > > technology for sending USB protocol messages over an ultra wideband
> > > > radio link.)
> > > > 
> > > > Similarly for a WiFi adapter card that plugs into a PCIe slot: It is a
> > > > "PCIe wireless" device, not a "wireless PCIe" device.
> > > > 
> > > > Rephrase the text in the kernel source where the word ordering is
> > > > wrong.
> > > > 
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Can you accept this patch, or should I ask Johannes Berg or Kalle Valo 
> > to merge it through the wireless subsystem?
> > 
> 
> Given that it touches pretty much only wireless drivers, I guess we
> should take it? For -next, though, so since Kalle usually takes drivers
> I'll wait for him to get back.
> 
> But the potential for conflicts seems low too, so I guess either way is
> fine.

I provided my reviewed-by as I assumed it would go through the wireless
or networking tree.  Otherwise, yes, I can take it, your choice.

thanks,

greg k-h
