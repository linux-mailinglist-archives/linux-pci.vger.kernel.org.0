Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7714F311
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgAaUKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 15:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgAaUKs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 15:10:48 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21258206D3;
        Fri, 31 Jan 2020 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580501447;
        bh=Yfe3SiYX9Jqed9ID89P3vq+VrtND+ktJGlD/NZ3M9F0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jtnI7IyrGU1WaYkedz5AnggQhdzLl8qH1FD+Cfamoqx6neFIZXNAC2fnKl3y+tlCl
         gaAY3Jlnfk9M2E2eogrF+qjrKEliHnxE7s1Wj7v2f1Kn7JDCL0nnmHFyjlLSSivaND
         CwvK2AGfE3U/y3ggkJvgqsrRWD7qmStD1lu6BFr0=
Date:   Fri, 31 Jan 2020 14:10:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 09/26] PCI: hotplug: Calculate immovable parts of
 bridge windows
Message-ID: <20200131201045.GA67143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9112d99415bdbd626362c63a3c473bafcc5ec26.camel@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 04:59:44PM +0000, Sergei Miroshnichenko wrote:
> On Thu, 2020-01-30 at 15:26 -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 29, 2020 at 06:29:20PM +0300, Sergei Miroshnichenko
> > wrote:
> > > When movable BARs are enabled, and if a bridge contains a device
> > > with fixed
> > > (IORESOURCE_PCI_FIXED) or immovable BARs, the corresponding windows
> > > can't
> > 
> > What is the difference between fixed (IORESOURCE_PCI_FIXED) and
> > immovable BARs?  I'm hesitant to add a new concept ("immovable") with
> > a different name but very similar meaning.
> > 
> > I understand that in the case of bridge windows, you may need to
> > track
> > only part of the window, as opposed to a BAR where the entire BAR has
> > to be either fixed or movable, but I think adding a new term will be
> > confusing.
> 
> I thought the term "fixed BAR" has some legacy scent, and those marked
> with flag IORESOURCE_PCI_FIXED are fixed forever. But a BAR may become
> movable after rmmod-ing its driver that didn't support movable BARs.
> 
> Still, the IORESOURCE_PCI_FIXED is used just a few times in the kernel,
> so the "fixed BAR" term is probably not so well-established, so I don't
> mind referring all non-movables as "fixed": both marked with the flag
> and not. Will change all of them in v8.

Yeah, "fixed" is a relatively new idea and not part of the actual
spec.  And you're right that "immovable" is slightly different because
sometimes it's a consequence of lack of driver support.

This probably isn't a big deal either way.  I think there are two
cases: (a) IORESOURCE_PCI_FIXED resources (i.e., legacy things that
can't be changed because they don't have BARs) and (b) BARs that can't
be changed because there's a driver bound that doesn't support moving
them.  Either way, we have to treat them the same for resource
allocation, so I'm not sure it's worth differentiating at this level.

Bjorn
