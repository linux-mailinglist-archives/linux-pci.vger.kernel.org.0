Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE74A58121
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfF0LG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 07:06:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44567 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0LG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jun 2019 07:06:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so1245959lfm.11;
        Thu, 27 Jun 2019 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qJi21Mo6g58zYgo8fMUz9qXi6d+nO3bcsbXvUW104g=;
        b=XK/30NKiJYh2h9LUIAo/MBxvj5zxprRjltaTwQ22pfwkEbGNCm7pRuNVo5Of/DANRH
         TfHmPGQis9MzOUJlG9BW4EsshBCIwY5XA+rr0UGuAigw6aKDoR4ITQmOhXckQDZ/F2n3
         4MfJ6e7E3d3B5rhEXswaUdsU+hiUR7IYWBHaB5xoQLoWkcQLBVqed3TxAtaDQFUt3tHN
         39zaoiDDeXY9QpsAFcowczybtZs6Wc72VcLDgYdFC5qbr2fQulzA6Cwlpr/dtUqOY3b6
         YVkf6V0yiWAWMyLOMa1YxLSXT3JM4kIcXmX+pHaOncjUC/d9sseqZ2hiYmXbDyZELnD+
         Zo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qJi21Mo6g58zYgo8fMUz9qXi6d+nO3bcsbXvUW104g=;
        b=XbPVlALF9+MYYhkaB9G/blk1Q3GrzzhdpV0VIbjwLBKDknpj1liPifU9mupvZGrLCl
         kaqPkZxtxPkSRYVnEDZJDVlh0mBgqwhvIJ2pKS64vYNLAY9on2WmRI9Js+mAkpmIeEJz
         mSZYSmRbcNTH+yOMeZPB9N+jWAhJeqVZr6tdLY3nS1S3YhwIMTJ/7SIghC6fkZokfFL7
         NIXvm2iUFdIYAHpJJWrEfxrNFzF9dmy8ASLUAjkuqRPYnHPrhbZHZ806m+h+aiCIruAB
         fv4DaLHCVmr80gqGMWyEgGQYGe8lHbFueskPvaBS6v4mMUCcnd9C1Stu2BLr0Nl7+6/T
         mI1Q==
X-Gm-Message-State: APjAAAVvg2h/wv9hau51nsyH0uI7nkoTfEanShOi6880rgo/0Q8Cbl7Q
        DmJqeAibGZlEtd4aWh6/XdhgHJoMk2yoFw==
X-Google-Smtp-Source: APXvYqzNAadmMThX24V2oaV8mMFiQMR9FNgpLeEjXYuFgWEVfIkps5h6NCvCqVLRUWWxbDgqmfXREQ==
X-Received: by 2002:a19:2247:: with SMTP id i68mr1742031lfi.174.1561633585377;
        Thu, 27 Jun 2019 04:06:25 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id p12sm364476lja.23.2019.06.27.04.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 04:06:24 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:06:24 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190627110624.nxwloyphithj4rmt@yadro.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com>
 <20190424100102.iyxogbsa4l7dyusb@yadro.com>
 <20190424141148.GA244134@google.com>
 <20190424145819.GL2654@lahna.fi.intel.com>
 <20190424172151.GB244134@google.com>
 <CAJZ5v0gZhgMy+oQMpEGM8bsU_57w7i3iCP1nb9PcOHxENfnwAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gZhgMy+oQMpEGM8bsU_57w7i3iCP1nb9PcOHxENfnwAw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi.

On Wed, Apr 24, 2019 at 11:09:52PM +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 24, 2019 at 8:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Apr 24, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> > > On Wed, Apr 24, 2019 at 09:11:48AM -0500, Bjorn Helgaas wrote:
> > > >   - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
> > > >     turn off runtime PM?  If we allow mmap of a BAR and then put the
> > > >     device in D3hot, that seems like a bug that could affect lots of
> > > >     things.  But maybe that's already done magically elsewhere?
> > >
> > > IIRC there is no PM magic happening for MMIO userspace accesses.
> > >
> > > What you suggest above sounds like a good way to fix it. We already do
> > > similar for config space access from userspace (if the device is in
> > > D3cold) so definitely makes sense to do the same for MMIO. However, I
> > > don't think we need to disable runtime PM - it should be enough to
> > > increase the reference count (pm_runtime_get_sync() and friends) during
> > > the time the MMIO resource is mmapped.
> >
> > OK, so if I understand correctly this would be basically adding
> > pm_runtime_get_sync(dev) in pci_mmap_resource().  I don't know what
> > the unmap path is, but there would have to be a matching
> > pm_runtime_put() somewhere.
> 
> Right.
> 
> > And a similar change in the read/write path for /sys/.../resource<N>;
> > I think this must be related to the sysfs_create_bin_file() call in
> > pci_create_attr(), but I don't see the path where the actual
> > read/write to the device is done.
> >
> > And probably something similar should be done in pci_resource_io(),
> > pci_map_rom(), and pci_unmap_rom().
> 
> In general, every path in which there is a memory or IO address space
> access requires pm_runtime_get_sync()/pm_runtime_put() around it as
> these accesses are only guaranteed to work in D0.
> 

Tested a solution based on proposals by Logan, Bjorn, Mika, Rafael (thanks all
of you, guys), I managed to fix the problem inside the PLX driver code. So no
additional quirks or other modifications in Linux kernel needed. I think
my patch can be easily rejected.

Thanks for help.

-- 
Regards,
  Alexander
