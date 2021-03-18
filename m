Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2B340BA4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhCRRWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhCRRWW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 13:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A821D64E37;
        Thu, 18 Mar 2021 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616088142;
        bh=dc75pwbsctWQPsOF4qhXgHwdNZ7A2PS9JI4jzCZQtD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZquC8xKhoSzFRHEFApwcMDGqaxFIaw1hdX8EMc6uJcHjXZz7Bvai5zy5e/xpSEV+
         9x+OWs1JUskfQZ+s0rAit/FFHL3zuzREq4oKeFq4qIUaTBfzGJRtzZ4md5oCjA+nxe
         t3lV5Kz9peMkKTeQZeXyxeXls3WFApHPH3T7nqFmfpkfx0YQHXYM1cBMCn/GaLK0V2
         0b9fNDz0Ck/GrLwPBIjrWPr7RDW+2Cw1XFOOitESs0PRhNfgz62wxwdpF1pix/5PkC
         PSJ6PIDL6J2V9jYUVHDcGqQQXObkEXSe3mKFURT0a9iHgCwoJ36co6UuYqscCeG8nA
         1QfpjO0Z06xkw==
Date:   Thu, 18 Mar 2021 19:22:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFOMShJAm4j/3vRl@unreal>
References: <YFGDgqdTLBhQL8mN@unreal>
 <20210317102447.73no7mhox75xetlf@archlinux>
 <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318103935.2ec32302@omen.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 10:39:35AM -0600, Alex Williamson wrote:
> On Thu, 18 Mar 2021 11:09:34 +0200
> Leon Romanovsky <leon@kernel.org> wrote:

<...>

> > I'm lost here, does vfio-pci use sysfs interface or internal to the kernel API?
> >
> > If it is latter then we don't really need sysfs, if not, we still need
> > some sort of DB to create second policy, because "supported != working".
> > What am I missing?
>
> vfio-pci uses the internal kernel API, ie. the variants of
> pci_reset_function(), which is the same interface used by the existing
> sysfs reset mechanism.  This proposed configuration of the reset method
> would affect any driver using that same core infrastructure and from my
> perspective that's really the goal.  In the case where a supported
> reset mechanism fails for a device, continuing to quirk those out for
> the best default behavior makes sense, I'd be disappointed for a vendor
> to not pursue improving the default behavior where it clearly makes
> sense.  However, there's also a policy decision, the kernel imposes a
> preferential ordering of reset mechanism.  Is that ordering the best
> case for all users?  I've presented above a case where a userspace may
> prefer a policy of preferring a bus reset to a PM reset.  So I think
> the question is not only are there supported mechanisms that don't
> work, where this interface allows userspace to more readily identify
> and work around those sorts of issues, but it also enables user
> preference and easier evaluation whether all of the supported reset
> mechanisms work rather than just the first one we encounter in the
> ordering we've decided to impose today.  Thanks,

Alex,

Which email client do you use?
Your responses are grouped as one huge block without any chance to respond
to you on specific point or answer to your question.

I see your flow and understand your position, but will repeat my
position. We need to make sure that vendors will have incentive to
supply quirks.

And regarding vendors, see Amey response below about his touchpad troubles.
The cheap electronics vendors don't care about their users.

Thanks

>
> Alex
>
