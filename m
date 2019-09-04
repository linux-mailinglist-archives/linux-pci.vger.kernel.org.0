Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE57AA7B99
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 08:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfIDGWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 02:22:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34857 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDGWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 02:22:32 -0400
Received: by mail-io1-f67.google.com with SMTP id b10so41771785ioj.2;
        Tue, 03 Sep 2019 23:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ha13jbBTJ78NMGOciyWwaZeX7xMQMX408d8EPNxVmIs=;
        b=LfD5oJENpa1oAY/gb/OD2LLz+K2jKvTt8+yeSZEVcHtD1k9VN/Ifr6qI4QB8BZzyjx
         QOpxxSZ6JJO4O96hJMv8Tq0eL98tb6W+nr6YpnIISDuQcid+4C0k+PfhPVU5r44gSsrr
         fScRxF2Bxw5otqKfBRhz8GHIIvGmHxXkhOg6OnYFAZeCv/QWY+jAVM0DitJzZ8cOrBNB
         RQiJq6TKmigyAjxNiJ6+9viTdOt2pX/FyEU65PNHjFu8MAWmhSAeWFTLiph+ci8vDj4z
         9ZQ39kdDrm4CwcYC4xXV2LBBogfQfOE3iwCxflTIil9N9yKriFL1l1uQ9NUdsjD9JDps
         oVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ha13jbBTJ78NMGOciyWwaZeX7xMQMX408d8EPNxVmIs=;
        b=qFILi6/8WWk26A7lWwN+9eVGOmJ4A83jUT6ymhap7A6o4Psu3O/4Hih78p/yWJfypW
         F4xbAHeUHn/VfVPSsn51IMJAJE+ZL/1e8a+4RDs4hUhV72id18005FW9Ahi75LZIskSq
         Hs0PE0MibguhK8jNeszo2BsdotChJZzVaRi6dmVvW4kLbPIwTf+XOKPIPYP3CvTSkhC5
         ACnggehFAZ454di8TycM3JAXcpHhk4N3ehtzGLKCQXcZVBL7FTVCwoLFHYs2azjd5G01
         OtSi+lZx/J/rdK3k4ojhrtrvDU3wEjnWCDht/qk0VJpC2CS0Y/aBpLsacfLFu0q2iSLS
         Tw5Q==
X-Gm-Message-State: APjAAAXd9a1okt4pt/lHlechqwSkNvLcUfD5Zd28HZQLfxUGkZQxzPxq
        TGKRPp3y+itWH3yHz0pxWOg=
X-Google-Smtp-Source: APXvYqyGF/nT7hMCagXQoT3al4s5E9hCIUwMr8muaqs6rrZkEfVxma8D+VTyjUf4JfEBbaY11AwnVw==
X-Received: by 2002:a5e:8c01:: with SMTP id n1mr1049078ioj.152.1567578151734;
        Tue, 03 Sep 2019 23:22:31 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id t5sm17061967ios.33.2019.09.03.23.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 23:22:31 -0700 (PDT)
Date:   Wed, 4 Sep 2019 00:22:29 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Don Dutile <ddutile@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v2 2/3] PCI: sysfs: Change
 permissions from symbolic to octal
Message-ID: <20190904062229.GA66871@JATN>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-3-skunberg.kelsey@gmail.com>
 <20190814053846.GA253360@google.com>
 <b4c0d5b4-7243-ba96-96d1-041a264ac499@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c0d5b4-7243-ba96-96d1-041a264ac499@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 15, 2019 at 10:37:13AM -0400, Don Dutile wrote:
> On 08/14/2019 01:38 AM, Bjorn Helgaas wrote:
> > [+cc Bodong, Don, Greg for permission question]
> > 
> > On Tue, Aug 13, 2019 at 02:45:12PM -0600, Kelsey Skunberg wrote:
> > > Symbolic permissions such as "(S_IWUSR | S_IWGRP)" are not
> > > preferred and octal permissions should be used instead. Change all
> > > symbolic permissions to octal permissions.
> > > 
> > > Example of old:
> > > 
> > > "(S_IWUSR | S_IWGRP)"
> > > 
> > > Example of new:
> > > 
> > > "0220"
> > 
> > 
> > >   static DEVICE_ATTR_RO(sriov_totalvfs);
> > > -static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > -				  sriov_numvfs_show, sriov_numvfs_store);
> > > +static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> > >   static DEVICE_ATTR_RO(sriov_offset);
> > >   static DEVICE_ATTR_RO(sriov_stride);
> > >   static DEVICE_ATTR_RO(sriov_vf_device);
> > > -static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > -		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> > > +static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> > > +		   sriov_drivers_autoprobe_store);
> > 
> > Greg noticed that sriov_numvfs and sriov_drivers_autoprobe have
> > "unusual" permissions.  These were added by:
> > 
> >    0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
> >    1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> > 
> > Kelsey's patch correctly preserves the existing permissions, but we
> > should double-check that they are the permissions they want, and
> > possibly add a comment about why they're different from the rest.
> > 
> > Bjorn
> > 

Hi Don,

> The rest being? ... 0644 vs 0664 ?
> The file is read & written, thus the (first) 6; I'll have to dig through very old (7 yr) notes to see if the second 6 is needed for libvirt (so it doesn't have to be root to enable).
> 
> -dd
>

Were you able to see if the unusual permissions (0664) are needed for
libvirt? I appreciate your help!

-Kelsey
