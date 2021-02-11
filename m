Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF663318ADF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 13:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBKMhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 07:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231659AbhBKMc4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 07:32:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C56EB64D79;
        Thu, 11 Feb 2021 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613046736;
        bh=mkeXLrPmROC3BA32Pp/9MxPWe1zUBG4cvAtSytkL2bM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ok0v9O0h5Y6rCji7GqB0MfLWSMGZ0birfjFj+G0Kpqv56WlRihdGpwAJhYEPm8cPy
         Pi7Xd1M75Wp8rfirOm9C6Rt9a5HrjRsOvR+Dmbxqb/eD6o9wFz8mIfXowlQLWt2jJw
         usNeg9Qu0M7XM9fzFy6bn5Qcj1Hc09/W5RbJAzn0=
Date:   Thu, 11 Feb 2021 13:32:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leon Romanovsky <leon@kernel.org>
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
Message-ID: <YCUjzeR1ZMX2uVH7@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <20210211114243.GH1275163@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211114243.GH1275163@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 01:42:43PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > Add Synopsys DesignWare xData IP driver. This driver enables/disables
> > the PCI traffic generator module pertain to the Synopsys DesignWare
> > prototype.
> >
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/misc/dw-xdata-pcie.c | 394 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 394 insertions(+)
> >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> 
> <...>
> 
> > +MODULE_LICENSE("GPL v2");
> 
> "GPL" and not "GPL v2".

There is no difference, please go read module.h.
