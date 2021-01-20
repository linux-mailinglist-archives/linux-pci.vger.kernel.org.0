Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745192FD499
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 16:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbhATPx0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 10:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391080AbhATPvA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 10:51:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3458A23340;
        Wed, 20 Jan 2021 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611157819;
        bh=fBMJEpbeW4fb/1FlOYEHbgt7kuNpM9yvsa0KQlOyNHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVDEo4KsJGh9Tb7AghreIaMDU7L2aWJ3JG12Owy6S7VImj/ocpgKYdJi60PF5PL62
         7sqM05TbpFlQmxpSRTG6zyXqcgypIF0Vyru2eqoZWpaobq5HkF71Tglq8cfKC2+eiz
         y5jqwpHIo4RnlZox0OB2ct7qBFD4P+r9pxfNoVNA=
Date:   Wed, 20 Jan 2021 16:50:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
Message-ID: <YAhROU8A8ZHduptZ@kroah.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 08:23:59AM -0600, Rob Herring wrote:
> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc> wrote:
> >
> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > deferral. Convert it to builtin_platform_driver().
> 
> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> shouldn't it be fixed or removed? Then we're not fixing drivers later
> when folks start caring about deferred probe and devlink.
> 
> I'd really prefer if we convert this to a module instead. (And all the
> other PCI host drivers.)
> 
> > Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> 
> This happened!?

It's in linux-next in my tree, but is looking like it might be reverted
soon.  But finding these issues is good.

thanks,

greg k-h
