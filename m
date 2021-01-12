Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4057F2F4052
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbhALXdS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 18:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbhALXdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 18:33:17 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461FC061575;
        Tue, 12 Jan 2021 15:32:37 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EA6A623E4A;
        Wed, 13 Jan 2021 00:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1610494353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFsxw06cYzHFDF+jM+1/5pVhYtFlwy+Z9PRS2LOJagY=;
        b=F6fpOxOzj4zkHzMyVbOFiaJiUJBm1ZZHJIMw5oVwTI+XkMNKG4EE26hv49d91oKOeUgit6
        Pg6XoNl+92I/AEnux8fqy25HdwLPFIh9x2Bv3csVwKXz5A+CqCcE2dZTm8//qafNPsUkZC
        1I7NAIzEM6uu2RzxOm2wv6ppuQ6wDBE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jan 2021 00:32:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
In-Reply-To: <20210112225802.GA1859984@bjorn-Precision-5520>
References: <20210112225802.GA1859984@bjorn-Precision-5520>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <3b101fff85ec1c490e9a14305a999cbe@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-01-12 23:58, schrieb Bjorn Helgaas:
> On Sat, Jan 09, 2021 at 07:31:46PM +0100, Michael Walle wrote:
>> Hi Bjorn,
>> 
>> Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
>> > On Wed, Dec 30, 2020 at 07:53:17PM +0100, Michael Walle wrote:
>> > > The Intel i210 doesn't work if the Expansion ROM BAR overlaps with
>> > > another BAR. Networking won't work at all and once a packet is sent
>> > > the
>> > > netdev watchdog will bite:
>> >
>> > 1) Is this a regression?  It sounds like you don't know for sure
>> > because earlier kernels don't support your platform.
>> 
>> Whats the background of the question? The board is offially supported
>> since 5.8. I doubt that the code responsible to not touch the ExpROM
>> BAR in pci_std_update_resource() were recently changed/added; the
>> comment refers to a mail from 2005. So no I don't think it is a
>> regression per se.
> 
> Just asking because it affects the urgency.  If we added a regression
> during the v5.11 merge window, we'd try hard to fix it before
> v5.11-final.  But it sounds like the problem has been there a long
> time, so a fix could wait until v5.12.

Yeah sure.

[..]

>> > 3) If the Intel i210 is defective in how it handles an Expansion ROM
>> > that overlaps another BAR, a quirk might be the right fix. But my
>> > guess is the device is working correctly per spec and there's
>> > something wrong in how firmware/Linux is assigning things.  That would
>> > mean we need a more generic fix that's not a quirk and not tied to the
>> > Intel i210.
>> 
>> Agreed, but as you already stated (and I've also found that in the PCI
>> spec) the Expansion ROM address decoder can be shared by the other 
>> BARs
>> and it shouldn't matter as long as the ExpROM BAR is disabled, which 
>> is
>> the case here.
> 
> My point is just that if this could theoretically affect devices other
> than the i210, the fix should not be an i210-specific quirk.
> I'll assume this is a general problem and wait for a generic PCI core
> solution unless it's i210-specific.

I guess the culprit here is that linux skips the programming of the BAR
because of some broken Matrox card. That should have been a quirk 
instead,
right? But I don't know if we want to change that, do we? How many other
cards depend on that?

And still, how do we find out that the i210 is behaving correctly? In
my opinion it is clearly not. You can change the ExpROM BAR value
during runtime and it will start working (while keeping it disabled).
Am I missing something here?

-michael
