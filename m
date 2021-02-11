Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317EE318D18
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 15:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBKOQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 09:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhBKONy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 09:13:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D8164EC1;
        Thu, 11 Feb 2021 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613052793;
        bh=6DtHGRyBqAI8PZ9S3hsYzcBIIAcIHXjF8JlH9ZbKdWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2ejRgV9dgBo+aki4H8nR5paz4z06QSz6vwWrSHWYeM9IKaxP1Q7SxbMbPBNKDcGm
         24P2VWXFNiSMcvyG5Cr6EVilQZiuvMlz/rL7MtHAaTO+Bxq7xT/bzROzE9VLaaWlsL
         HdPDrPjULFN+I0Sz2p3nzWq4kZOKwKau7rjeK1QACNCX73lBhpI1mPi1WuAYz06rlE
         ovkF+RVXCZ+Q0nnn2gpVgYp9b5m9smGsdWXLFvjZeblsEBpfQCU2UBAx3CGTQYOD2E
         8xOtIeblbs3HEkdSkivy8FT+9t1XO3okeDvWj8OFwtedfJQIR3QajbKlx5+iGbcMCV
         RtQdwkMow9e/g==
Date:   Thu, 11 Feb 2021 16:13:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <20210211141309.GJ1275163@unreal>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <20210211114243.GH1275163@unreal>
 <YCUjzeR1ZMX2uVH7@kroah.com>
 <20210211135019.GI1275163@unreal>
 <YCU42zUbtGEvYVQ/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCU42zUbtGEvYVQ/@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 03:02:03PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 11, 2021 at 03:50:19PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 11, 2021 at 01:32:13PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 11, 2021 at 01:42:43PM +0200, Leon Romanovsky wrote:
> > > > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > > > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > > > > the PCI traffic generator module pertain to the Synopsys DesignWare
> > > > > prototype.
> > > > >
> > > > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > > ---
> > > > >  drivers/misc/dw-xdata-pcie.c | 394 +++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 394 insertions(+)
> > > > >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> > > >
> > > > <...>
> > > >
> > > > > +MODULE_LICENSE("GPL v2");
> > > >
> > > > "GPL" and not "GPL v2".
> > >
> > > There is no difference, please go read module.h.
> >
> > I read and this is why I said it.
> > Documentation/process/license-rules.rst: "It exists for historic reasons."
> >
> > Historic, for me, means that new code is better do not use this.
>
> Nope, either is fine for new code, author gets to pick what they want.
> Personally, I like the explicitness of "GPL v2" for a variety of
> reasons.

Feel free to update the documentation.

Personally, I don't like two names for the same license. This is one of
the reasons why SPFX clearly marks the code license, It is why we have
"SPDX-License-Identifier: GPL-2.0" and not "SPDX-License-Identifier: GPL".

https://spdx.org/licenses/preview/
GNU General Public License v2.0 only 	        GPL-2.0-only
GNU General Public License v2.0 or later 	GPL-2.0-or-later

Thanks

>
> thanks,
>
> greg k-h
