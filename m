Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065B330B0EF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 20:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhBAT4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 14:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhBATuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 14:50:08 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563DC061573;
        Mon,  1 Feb 2021 11:49:19 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 28E9322F99;
        Mon,  1 Feb 2021 20:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1612208956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwS7M5DVuVgIp79W7J+1nUCnHx61grFZNqdoFSservc=;
        b=jfjC5UQX2h4RSHu6T7RZ/nYdN9hdMuqbKuhhMXE6S8LYTxZZP00hnKmVKgGqCUfBuK8MCs
        1o1ZA0YAmytg9kG4IgWDdQX410Y3GNYy3T7LHzDEB30OZLX0Ty5u+9NdWGZDFzu6VdV1Yy
        2405m45kM0WBRI7g5S69bUv9gdTmkzI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Feb 2021 20:49:16 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v2] PCI: Fix Intel i210 by avoiding overlapping of BARs
In-Reply-To: <2477c66eafbd97207693b83b60fa0a3c@walle.cc>
References: <20210115235721.GA1862880@bjorn-Precision-5520>
 <2477c66eafbd97207693b83b60fa0a3c@walle.cc>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <e8647a2cd4bfbcd42c27183d1c8984a0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am 2021-01-17 20:27, schrieb Michael Walle:
> Am 2021-01-16 00:57, schrieb Bjorn Helgaas:
>> On Wed, Jan 13, 2021 at 12:32:32AM +0100, Michael Walle wrote:
>>> Am 2021-01-12 23:58, schrieb Bjorn Helgaas:
>>> > On Sat, Jan 09, 2021 at 07:31:46PM +0100, Michael Walle wrote:
>>> > > Am 2021-01-08 22:20, schrieb Bjorn Helgaas:
>> 
>>> > > > 3) If the Intel i210 is defective in how it handles an Expansion ROM
>>> > > > that overlaps another BAR, a quirk might be the right fix. But my
>>> > > > guess is the device is working correctly per spec and there's
>>> > > > something wrong in how firmware/Linux is assigning things.  That would
>>> > > > mean we need a more generic fix that's not a quirk and not tied to the
>>> > > > Intel i210.
>>> > >
>>> > > Agreed, but as you already stated (and I've also found that in
>>> > > the PCI spec) the Expansion ROM address decoder can be shared by
>>> > > the other BARs and it shouldn't matter as long as the ExpROM BAR
>>> > > is disabled, which is the case here.
>>> >
>>> > My point is just that if this could theoretically affect devices
>>> > other than the i210, the fix should not be an i210-specific quirk.
>>> > I'll assume this is a general problem and wait for a generic PCI
>>> > core solution unless it's i210-specific.
>>> 
>>> I guess the culprit here is that linux skips the programming of the
>>> BAR because of some broken Matrox card. That should have been a
>>> quirk instead, right? But I don't know if we want to change that, do
>>> we? How many other cards depend on that?
>> 
>> Oh, right.  There's definitely some complicated history there that
>> makes me a little scared to change things.  But it's also unfortunate
>> if we have to pile quirks on top of quirks.
>> 
>>> And still, how do we find out that the i210 is behaving correctly?
>>> In my opinion it is clearly not. You can change the ExpROM BAR value
>>> during runtime and it will start working (while keeping it
>>> disabled).  Am I missing something here?
>> 
>> I agree; if the ROM BAR is disabled, I don't think it should matter at
>> all what it contains, so this does look like an i210 defect.
>> 
>> Would you mind trying the patch below?  It should update the ROM BAR
>> value even when it is disabled.  With the current pci_enable_rom()
>> code that doesn't rely on the value read from the BAR, I *think* this
>> should be safe even on the Matrox and similar devices.
> 
> Your patch will fix my issue:
> 
> Tested-by: Michael Walle <michael@walle.cc>

any news on this?

-michael
