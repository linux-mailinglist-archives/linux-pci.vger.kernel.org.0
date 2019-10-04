Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39F4CBB43
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 15:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbfJDNIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 09:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387874AbfJDNIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 09:08:05 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17D5215EA;
        Fri,  4 Oct 2019 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570194485;
        bh=HhQ69B1WDttqkP35gsTsi8yNjEKoaJWoVrSxdX3Mblg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SeSYW+Q8gv30sLvK4tKZE1hvuDAvospSwtjV7/z2VkMpHqizNd3HB1rr5g7soVPuV
         l3/L2MKWk78SuBIGkQK+uMguRzosy7vTa1Gy445Z3E21q0el4egfijlmQq82XRAKy6
         Zl5YLo4H3pJZXiBN2Y8j6+GQaP0EYiwbwPIrizjI=
Date:   Fri, 4 Oct 2019 08:08:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 0/6] Patch series to support Thunderbolt without any
 BIOS support
Message-ID: <20191004130803.GA41961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003121946.GS2819@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 03:19:46PM +0300, mika.westerberg@linux.intel.com wrote:
> On Fri, Jul 26, 2019 at 12:52:58PM +0000, Nicholas Johnson wrote:
> > Patch series rebased to 5.3-rc1.
> > 
> > If possible, please have a quick read over while I am away (2019-07-27
> > to mid 2019-08-04), so I can fix any mistakes or make simple changes to
> > get problems out of the way for a more thorough examination later.
> > 
> > Thanks!
> > 
> > Kind regards,
> > Nicholas
> > 
> > Nicholas Johnson (6):
> >   PCI: Consider alignment of hot-added bridges when distributing
> >     available resources
> >   PCI: In extend_bridge_window() change available to new_size
> >   PCI: Change extend_bridge_window() to set resource size directly
> >   PCI: Allow extend_bridge_window() to shrink resource if necessary
> >   PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
> >   PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
> >     window
> 
> Hi Bjorn,
> 
> What's the status of this series? I don't see them in v5.4-rc1.

They're still on my to-do list but are currently languishing because
they touch critical but complicated code that I don't understand and
nobody else has chimed in to help review them.  Testing reports would
also be helpful.

It's been a long time since I've looked at these, but I wonder if at
least the incremental step of adding the parameter to set the
MMIO_PREF size separately from the MMIO size would be more
approachable.

Bjorn
