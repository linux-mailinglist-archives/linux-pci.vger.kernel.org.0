Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2100A170BBF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 23:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBZWld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 17:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbgBZWld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 17:41:33 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FD920658;
        Wed, 26 Feb 2020 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582756892;
        bh=pqBevC8oqZjyGa7o6s+vlciDsiHfkvXZhmYXugSWapY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cESNznCh24xWLYynU3EJ8TrG0XW5mDj2G21MH3flMMzwnsZVmqaxHaJhTt1am/yGm
         NaKksw/07G8HJFYA3/+Vihveu+JE1WxyOQo8kQy734smws+aihzb6v3KMwx49FFFAv
         hoUWX5JD52xfyc3YCCyZvf28YZrDDPpZ4ohoSrYM=
Date:   Wed, 26 Feb 2020 16:41:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v15 4/5] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200226224130.GA182745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cabd520-f974-2c33-4ecb-3cfd2dfb00a4@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 02:11:53PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 2/26/20 1:32 PM, Bjorn Helgaas wrote:
> > On Wed, Feb 26, 2020 at 10:42:27AM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > On 2/25/20 5:02 PM, Bjorn Helgaas wrote:
> > > > On Thu, Feb 13, 2020 at 10:20:16AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > ...
> > 
> > > Yes, we could remove it. But it might need some more changes to
> > > dpc driver functions. I can think of two ways,
> > > 
> > > 1. Re-factor the DPC driver not to use dpc_dev structure and just use
> > > pci_dev in their functions implementation. But this might lead to
> > > re-reading following dpc_dev structure members every time we
> > > use it in dpc driver functions.
> > > 
> > > (Currently in dpc driver probe they cache the following device parameters )
> > > 
> > >    9         u16                     cap_pos;
> > >   10         bool                    rp_extensions;
> > >   11         u8                      rp_log_size;
> > >   12         u16                     ctl;
> > >   13         u16                     cap;

> > I think this is basically what I proposed with the sample patch in my
> > response to your 3/5 patch.  But I don't see the ctl/cap part, so
> > maybe I missed something.

> if its costly to carry it in pci_dev, we can always re-read them.
> if its ok to use pci_dev, If you want, I can extend your patch to
> include the cap and ctl.

Ah, I see, you added cap & ctl as part of your series.  But I don't
think they're ever used after dpc_probe(), are they?  So I don't think
they need to be saved at all.

> > > Yes, ownership should be based on _OSC negotiation. I will add necessary
> > > comments here.

> > Why are we not doing this via _OSC negotiation in this series?  It
> > would be much better if we could just do it instead of adding a
> > comment that we *should* do it.  Nobody knows more about this than you
> > do, so probably nobody else is going to come along and finish this
> > up :)

> Actually Alex G already proposed a patch to fix it.
> 
> https://lkml.org/lkml/2018/11/16/202
> 
> But that discussion never reached a conclusion. Since a proper fix
> for it would affect some legacy hardwares which solely relies on
> HEST tables, it did not make everyone happy. So it might take a
> lot to convince all the stake holders to merge such patch. So its
> better not to mix both of these patch sets together.
> 
> Once this patch set is done, If Alex G is no longer working on it,
> I can work on it.

OK, great, maybe we can make progress on that later.
