Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E213F2E9C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhHTPMo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 11:12:44 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:39971 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhHTPMn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 11:12:43 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 96B7722205;
        Fri, 20 Aug 2021 17:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1629472322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2eDUoxB5xMh/Sao7EA/guMPzvomiMUF6SN9C2zr2a8=;
        b=r/GEuIwEReoi8tVm8Zqy+uV6vGSjS4l3Zbcs/0IwG8w7UPVgwmyp4OVjYXtsxnK01BaqtQ
        iOBjPJCLDjZPO5uFQpuo24D8+g/HGm08ufJ0n201SGUa0WhGLAmi2WRYVUfVKa7RtPXSmQ
        0Ch4WZAVMA9rVRc9qckVvJHd5A8uSPM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Aug 2021 17:12:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
In-Reply-To: <d2c7ec0e416dd6bb6818892750bff6d7@walle.cc>
References: <20210201222010.GA31234@bjorn-Precision-5520>
 <d2c7ec0e416dd6bb6818892750bff6d7@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5d41bad0e0607e68d9189667a45f7519@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-03-15 22:51, schrieb Michael Walle:
> Am 2021-02-01 23:20, schrieb Bjorn Helgaas:
>> On Mon, Feb 01, 2021 at 08:49:16PM +0100, Michael Walle wrote:
>>> Am 2021-01-17 20:27, schrieb Michael Walle:
>>> > Am 2021-01-16 00:57, schrieb Bjorn Helgaas:
>>> > > On Wed, Jan 13, 2021 at 12:32:32AM +0100, Michael Walle wrote:
>>> > > > Am 2021-01-12 23:58, schrieb Bjorn Helgaas:
>>> > > > > On Sat, Jan 09, 2021 at 07:31:46PM +0100, Michael Walle wrote:
>>> > > > > > Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
>>> > >
>>> > > > > > > 3) If the Intel i210 is defective in how it handles an Expansion ROM
>>> > > > > > > that overlaps another BAR, a quirk might be the right fix. But my
>>> > > > > > > guess is the device is working correctly per spec and there's
>>> > > > > > > something wrong in how firmware/Linux is assigning things.  That would
>>> > > > > > > mean we need a more generic fix that's not a quirk and not tied to the
>>> > > > > > > Intel i210.
>>> > > > > >
>>> > > > > > Agreed, but as you already stated (and I've also found that in
>>> > > > > > the PCI spec) the Expansion ROM address decoder can be shared by
>>> > > > > > the other BARs and it shouldn't matter as long as the ExpROM BAR
>>> > > > > > is disabled, which is the case here.
>>> > > > >
>>> > > > > My point is just that if this could theoretically affect devices
>>> > > > > other than the i210, the fix should not be an i210-specific quirk.
>>> > > > > I'll assume this is a general problem and wait for a generic PCI
>>> > > > > core solution unless it's i210-specific.
>>> > > >
>>> > > > I guess the culprit here is that linux skips the programming of the
>>> > > > BAR because of some broken Matrox card. That should have been a
>>> > > > quirk instead, right? But I don't know if we want to change that, do
>>> > > > we? How many other cards depend on that?
>>> > >
>>> > > Oh, right.  There's definitely some complicated history there that
>>> > > makes me a little scared to change things.  But it's also unfortunate
>>> > > if we have to pile quirks on top of quirks.
>>> > >
>>> > > > And still, how do we find out that the i210 is behaving correctly?
>>> > > > In my opinion it is clearly not. You can change the ExpROM BAR value
>>> > > > during runtime and it will start working (while keeping it
>>> > > > disabled).  Am I missing something here?
>>> > >
>>> > > I agree; if the ROM BAR is disabled, I don't think it should matter at
>>> > > all what it contains, so this does look like an i210 defect.
>>> > >
>>> > > Would you mind trying the patch below?  It should update the ROM BAR
>>> > > value even when it is disabled.  With the current pci_enable_rom()
>>> > > code that doesn't rely on the value read from the BAR, I *think* this
>>> > > should be safe even on the Matrox and similar devices.
>>> >
>>> > Your patch will fix my issue:
>>> >
>>> > Tested-by: Michael Walle <michael@walle.cc>
>>> 
>>> any news on this?
>> 
>> Thanks for the reminder.  I was thinking this morning that I need to
>> get back to this.  I'm trying to convince myself that doing this
>> wouldn't break the problem fixed by 755528c860b0 ("Ignore disabled ROM
>> resources at setup").  So far I haven't quite succeeded.
> 
> ping #2 ;)

ping #3, soon we can celebrate our first one year anniversary :p

-michael
