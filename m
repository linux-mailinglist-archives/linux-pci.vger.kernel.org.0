Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612AF28D2B1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgJMQ4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgJMQ4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2020 12:56:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED9BC0613D0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2020 09:56:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so141994pfb.4
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2020 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=K1nsHK9CkHQD5KrRCjG14Z+H7u+Ut6VhtenLPkHqaew=;
        b=HxhVGZANerXKnrnAtUGvf/3VfyW9K1vE54QZu+yHKLtgTHl+T4juSHjMo6yg2KsNt8
         r+xRCVxNjxPdcRnD6dNwn8HUEwGkkpIIVjQyx3ZhQ5jdOYkzJZdlAgKyyI8TWuIQGyxy
         l3NkK5hmi7P383CvuYBf+UHn/PBMxVyL/LeYRsBErMNlKGrK4F0ANtmkpPF3vAygttyI
         FZHLccdlYilIwo8oDcjUupeZefW6n9nwtU6Vh6teRt30SclrjAR9RRWXcFQisWTxqEf8
         xFcf07g9ehasg846DbCIm5NJmo441kH0PDiUdGoDKwPupbxnTjIY+B7r7WGRKqJJlOCJ
         zy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K1nsHK9CkHQD5KrRCjG14Z+H7u+Ut6VhtenLPkHqaew=;
        b=mf5GHOcSEl2dGFTvncv4A7NgzZjSk0RiGV86UeKhpE6YjdpBrNnjhoqbW5y3uhKsHs
         Mp4HgXH0rzZwjnIWo4PPqYSmZa0Kh0i2y6xNuZ5LTX+VftmUbnZCpjoLxTLktsLu7kEP
         OMVEy2yeSkAjJCYWnMGG6kj2nhEdo1Yu0SblVa0ShW2EuyRaG1nkXWTAwERoqlsbCL4R
         4+qOp5jz5njD0b+Q7Xu1xWtQDJ/ysSxjvx4VUCFL39dx3lf6XU30wkGHD99tYE4Lt23B
         zh63X0eHtCZJ9mujF+rAU9MLOlTxQiJ7P3pYZKP2+qn6dc1rXppedjqvOsw0oh3XivXJ
         kdNw==
X-Gm-Message-State: AOAM531Yq2Kg+winXjzeke7GShTrkjrI3rNbQ8fLclM4rWWWCvWc5Hdr
        O+gT5foqbvbB5PdBjtvOWWOD0Q==
X-Google-Smtp-Source: ABdhPJwHox5XSpr8/XFp6AULN8Y31D80FxtNrF7h6Lib95vvfVqj6KB4bf7CFAGzKMpnFbHu+nnd1w==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr346050pgi.337.1602608184319;
        Tue, 13 Oct 2020 09:56:24 -0700 (PDT)
Received: from arch-ashland-svkelley ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id q123sm182547pfq.56.2020.10.13.09.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:56:23 -0700 (PDT)
Message-ID: <d023cc5153bf855e27d7ee098e1afa0fd5ba9761.camel@intel.com>
Subject: Re: [PATCH v8 11/14] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "seanvk.dev@oregontracks.org" <seanvk.dev@oregontracks.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Date:   Tue, 13 Oct 2020 09:55:34 -0700
In-Reply-To: <20201012225848.GA3754175@bjorn-Precision-5520>
References: <20201012225848.GA3754175@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-10-12 at 17:58 -0500, Bjorn Helgaas wrote:
> On Fri, Oct 09, 2020 at 11:51:39PM +0000, Kelley, Sean V wrote:
> > On Fri, 2020-10-09 at 15:07 -0700, Sean V Kelley wrote:
> > So I tested the following out, including your moving flr to aer.c:
> > 
> > - Renamed flr_on_rciep() to flr_on_rc() for RC devices (RC_END and
> > RC_EC)
> > 
> > - Moved check on dev->rcec into aer_root_reset() including the FLR.
> > 
> > - Reworked pci_walk_bridge() to drop extra dev argument and check
> > locally for the bridge->rcec. Maybe should also check on type when
> > checking on bridge->rcec.
> > 
> > Note I didn't use the check on aer_cap existence because I think
> > you
> > had added that for simply being able to skip over for the non-
> > native
> > case and I handle that with the single goto at the beginning which
> > takes you to the FLR.
> 
> Right.  Well, my thinking was that "root" would be a device with the
> AER Root Error Command and Root Error Status registers, i.e., a Root
> Port or RCEC.  IIUC that basically means the APEI case where firmware
> gives us an error record.

Got it.

> 
> Isn't the existing v5.9 code buggy in that it unconditionally pokes
> these registers?  I think the APEI path can end up here, and firmware
> probably has not granted us control over AER.

Yes, APEI path can end up here even in the absence of AER control.

> 
> Somewhat related question: I'm a little skeptical about the fact that
> aer_root_reset() currently does:
> 
>   - clear ROOT_PORT_INTR_ON_MESG_MASK
>   - do reset
>   - clear PCI_ERR_ROOT_STATUS
>   - enable ROOT_PORT_INTR_ON_MESG_MASK

It's a bit of a mix and growing with RC_END handling.

> 
> In the APEI path all this AER register manipulation must be done by
> firmware before passing the error record to the OS.  So in the native
> case where the OS does own the AER registers, why can't the OS do
> that
> manipulation in the same order, i.e., all before doing the reset?

And you're right, the mix here imposes additional complexity for native
versus non-native. If you're not actively engaged with the code, it's
not obvious. So, yes moving it out would make more sense.


> 
> > So this is rough, compiled, tested with AER injections but that's
> > it...
> 
> I couldn't actually apply the patch below because it seems to be
> whitespace-damaged, but I think I like it.

Yes, it was a quick copy-paste to an existing email. Will work with
your branch.

> 
>   - It would be nice to be able to just call pcie_flr() and not have
>     to add flr_on_rc().  I can't remember why we need the
>     pcie_has_flr() / pcie_flr() dance.  It seems racy and ugly, but I
>     have a vague recollection that there actually is some reason for
>     it.

I'll have a look.

> 
>   - I would *rather* consolidate the AER register updates and test
> for
>     the non-native case once instead of treating it like a completely
>     separate path with a "goto".  But maybe not possible.  Not a big
>     deal either way.

Following your line of reasoning above, I think we can better
consolidate the AER register updates.

> 
>   - Getting rid of the extra "dev" argument to pci_walk_bridge() is a
>     great side-effect.  I didn't even notice that.
> 
>   - If we can simplify that "state == pci_channel_io_frozen" case as
>     this does, that is a *big* deal because there are other patches
>     just waiting to touch that reset and it will be much simpler if
>     there's only one reset_subordinate_devices() call there.

Agreed.

> 
> If you do work this up, I'd really appreciate it if you can start
> with
> my pci/err branch so I don't have to re-do all the tweaks I've
> already
> done:
> 
>   
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/err
> 

Will do.

Thanks,

Sean



> Bjorn

