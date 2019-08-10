Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABA088E8A
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 23:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfHJVcW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Aug 2019 17:32:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38585 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJVcW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Aug 2019 17:32:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so146136881oth.5;
        Sat, 10 Aug 2019 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMMb34sW1+/kTHjwNTUYc8ygL+j2F3tAzUq276SdPcQ=;
        b=m/mv+h8gJmjIfilAGa7N0MBfbVDijQrZlYukgcoA+OQVvhLo5fAJJpTyYqFU+q8m8q
         ZQZzHv9Q0ELJMl1d52Uh1eM6u+Z4eZayqf47tAC89dIKzgWTkzEWX7HtHmGogi390Sw1
         hMS+Slkjbam/Bs5aEd8stuKw2lVDGSUHCJBF0++NH38EACEaheerm3/6Mf3nvmXJD0iB
         NQopo3vw+OUJlsxC5Tg/K6LDQcPUbRnLkvMfohWhBSPLoi9vAQ/gvcphXrwWNgCdng25
         u+Mbz5Db1gRkiGncbUZzkLtBi+WD2t4gZnKR7J8WxqCEI0J6bkdc+NTl3Ig3kR3N9Phr
         tjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMMb34sW1+/kTHjwNTUYc8ygL+j2F3tAzUq276SdPcQ=;
        b=bHSTyr/rTI1EuFbKJJVx0d0R6/myOEsoD9ANj3lxUOprznZZEqXDJKwFroATs8ppF8
         zyqu0APwsw79oCHiOV/p5mnPKqrpCRQHtT4VgVrByvRmtFZ7egw4mSVKMvgmiRX9QUji
         LFoOEdO3mhvJgLTXjbvyI7enROWzw9XZKAjHr0b53QbDttswmVtrH6pUu68VOyWuqpta
         JK32GBwUjOxNyR3OF6dZR0iklS9CC7+UC+XxvJ0TvT/qbyIrea8ZS6/cg/B9mv2ONtZZ
         n9MBndXOUCdVzmTjy0YUE2DfLr11oeDT2Zce3NCU78SNBFY4bSSUuJ171gyN/+rM3Sv1
         UAjQ==
X-Gm-Message-State: APjAAAU8nBfwMpB4hvTCL4iBqUG/RWmRCorIoKuQlhRoy1oUxjp5BpW4
        O4lbqSjJMPzp0UWNmwB+Lpz1bBZp4vk=
X-Google-Smtp-Source: APXvYqx0M/yrwTyNG9+H8R33UpKx7McM0MI/sO7LbMBEoESu3njm//f/B+mrSANQ1ecvNGZmdcb5lw==
X-Received: by 2002:a6b:e013:: with SMTP id z19mr1490934iog.141.1565472741271;
        Sat, 10 Aug 2019 14:32:21 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id t133sm145838112iof.21.2019.08.10.14.32.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 14:32:20 -0700 (PDT)
Date:   Sat, 10 Aug 2019 15:32:18 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] PCI/IOV: Move sysfs SR-IOV
 functions to iov.c
Message-ID: <20190810213218.GA55952@JATN>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190810071719.GA16356@kroah.com>
 <20190810171525.GG221706@google.com>
 <20190810172409.GB4482@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810172409.GB4482@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 10, 2019 at 07:24:09PM +0200, Greg KH wrote:
> On Sat, Aug 10, 2019 at 12:15:25PM -0500, Bjorn Helgaas wrote:
> > On Sat, Aug 10, 2019 at 09:17:19AM +0200, Greg KH wrote:
> > > On Fri, Aug 09, 2019 at 01:57:21PM -0600, Kelsey Skunberg wrote:
> > > > +static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> > > 
> > > DEVICE_ATTR_RO() please.  This is a device attribute, not a "raw"
> > > kobject attribute.
> > 
> > This patch is just a move; here's the source of the line above:
> > 
> > > > -static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
> > 
> > I certainly support using DEVICE_ATTR_RO() instead of __ATTR_RO(), but
> > that should be down with a separate patch so it's not buried in what
> > is otherwise a simple move.
> > 
> > > > +static struct device_attribute sriov_numvfs_attr =
> > > > +		__ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > > +		       sriov_numvfs_show, sriov_numvfs_store);
> > > > +static struct device_attribute sriov_offset_attr = __ATTR_RO(sriov_offset);
> > > > +static struct device_attribute sriov_stride_attr = __ATTR_RO(sriov_stride);
> > > > +static struct device_attribute sriov_vf_device_attr =
> > > > +		__ATTR_RO(sriov_vf_device);
> > > > +static struct device_attribute sriov_drivers_autoprobe_attr =
> > > > +		__ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > > +		       sriov_drivers_autoprobe_show,
> > > > +		       sriov_drivers_autoprobe_store);
> > > 
> > > Same for all of these, they should use DEVICE_ATTR* macros.
> > > 
> > > And why the odd permissions on 2 of these files?  Are you sure about
> > > that?
> > 
> > Same for these.  It'd be nice to fix them (and similar cases in
> > pci-sysfs.c, rpadlpar_sysfs.c, sgi_hotplug.c, slot.c) but in a
> > separate patch.
> > 
> > I think Kelsey did the right thing here by not mixing unrelated fixes
> > in with the code move.  A couple additional patches to change the
> > __ATTR() uses and the permissions (git grep "\<S_" finds several
> > possibilities) would be icing on the cake, but getting the SR-IOV
> > code all together is an improvement by itself.
> 
> Ah, ok, that makes more sense.  As long as this is patch 1/X, I'm fine
> with it :)
> 
> thanks,
> 
> greg k-h

I'll set up a series to cover these changes and submit it as a v2. Thank
you for reviewing Greg and Bjorn!

Cheers,
Kelsey
