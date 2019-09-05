Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA91A992F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 06:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfIEEEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 00:04:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45962 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEEEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 00:04:37 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so1505208iog.12;
        Wed, 04 Sep 2019 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M+IGfEYSGyyuOm2Prrx3ef40BKfyapHE5e/ScRcmzZ4=;
        b=V7VsEvi/mTFLoVUoQ8JLQj1QujYpPOCL9e787N9xm/AzDYh+OHJL3axrAjBWP9MT/d
         JGq20Sh718b741p8V1bPov0ywDuoE0aYrf58KXcjIh6nUAjNOPspMFghC2V9Uc1v+MiI
         ZzcW3Ssp/w1hnmqU6i3U1FeJqtJw0elEYzIavAomftnsumWK1z6kzzfqKHJpsIEiuc41
         s1KlGOmvVNZ0FLMrP3NJ/1i3l72CxOlFzSMOCXv1PWQiM1SgmZZz7uFmDxnQmOx0pjzl
         oW7RvjMuf2YgOqE3/Ibe4sB4OPsx0VEBWkWIZxGXzfJ83H1oQUP8pgomcQxTprxMveJq
         9y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M+IGfEYSGyyuOm2Prrx3ef40BKfyapHE5e/ScRcmzZ4=;
        b=XDmjX66GoMrqVzy9mLIoq0zUJMmNfiT2UuKoldXqMieMB8AAqwiOfaSo3o4wFprqiy
         HCtLGdIdPQQ1MDgroxViyHiWIsN3qQWr3HONcBtvvLBHNeyCFrz+jcW/0tLOfRVP3mz9
         c9G6e90IINt04HJwyxdRGgJOBXQwBn4qXx6FHdOYfCSB/Wyom3+5iSKhIFXAug16qlt4
         unpPU6E7GmG/JoV/PxjhKSesRpVLUKiCegCHIvfM/Q+/iNu7qyyj6Qzs+XUE/57j5VRu
         TWgkQ1Qg2Jgr7H+IT7UOtlNd2j0xN9M/Y7GYkCUIWlSy2cJhOhmVVOnpqeMeJ6PpaeKS
         Hf8w==
X-Gm-Message-State: APjAAAXiFkq5KyG6L/7QCVwwyu9V6mYPsRelrT74eRQsp7ofkox134JJ
        NLFAoRmSF5Eb10HP6tWu12lZsPqFNqY=
X-Google-Smtp-Source: APXvYqwTBzAOGP++Zt5gDzo0QxhcCRLghE7yC41c3bvkCvuDJODZ35HCgyCv3A0si3LLgXSQEJfnqA==
X-Received: by 2002:a5d:8cc1:: with SMTP id k1mr1785446iot.286.1567656276246;
        Wed, 04 Sep 2019 21:04:36 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id m67sm2047286iof.21.2019.09.04.21.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 21:04:35 -0700 (PDT)
Date:   Wed, 4 Sep 2019 22:04:33 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Don Dutile <ddutile@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v2 2/3] PCI: sysfs: Change
 permissions from symbolic to octal
Message-ID: <20190905040433.GA117297@JATN>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190813204513.4790-3-skunberg.kelsey@gmail.com>
 <20190814053846.GA253360@google.com>
 <b4c0d5b4-7243-ba96-96d1-041a264ac499@redhat.com>
 <20190904062229.GA66871@JATN>
 <850cf536-0b72-d78c-efaf-855dcb391087@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <850cf536-0b72-d78c-efaf-855dcb391087@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 02:33:44PM -0400, Don Dutile wrote:
> On 09/04/2019 02:22 AM, Kelsey Skunberg wrote:
> > On Thu, Aug 15, 2019 at 10:37:13AM -0400, Don Dutile wrote:
> > > On 08/14/2019 01:38 AM, Bjorn Helgaas wrote:
> > > > [+cc Bodong, Don, Greg for permission question]
> > > > 
> > > > On Tue, Aug 13, 2019 at 02:45:12PM -0600, Kelsey Skunberg wrote:
> > > > > Symbolic permissions such as "(S_IWUSR | S_IWGRP)" are not
> > > > > preferred and octal permissions should be used instead. Change all
> > > > > symbolic permissions to octal permissions.
> > > > > 
> > > > > Example of old:
> > > > > 
> > > > > "(S_IWUSR | S_IWGRP)"
> > > > > 
> > > > > Example of new:
> > > > > 
> > > > > "0220"
> > > > 
> > > > 
> > > > >    static DEVICE_ATTR_RO(sriov_totalvfs);
> > > > > -static DEVICE_ATTR(sriov_numvfs, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > > > -				  sriov_numvfs_show, sriov_numvfs_store);
> > > > > +static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> > > > >    static DEVICE_ATTR_RO(sriov_offset);
> > > > >    static DEVICE_ATTR_RO(sriov_stride);
> > > > >    static DEVICE_ATTR_RO(sriov_vf_device);
> > > > > -static DEVICE_ATTR(sriov_drivers_autoprobe, (S_IRUGO | S_IWUSR | S_IWGRP),
> > > > > -		   sriov_drivers_autoprobe_show, sriov_drivers_autoprobe_store);
> > > > > +static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> > > > > +		   sriov_drivers_autoprobe_store);
> > > > 
> > > > Greg noticed that sriov_numvfs and sriov_drivers_autoprobe have
> > > > "unusual" permissions.  These were added by:
> > > > 
> > > >     0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
> > > >     1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> > > > 
> > > > Kelsey's patch correctly preserves the existing permissions, but we
> > > > should double-check that they are the permissions they want, and
> > > > possibly add a comment about why they're different from the rest.
> > > > 
> > > > Bjorn
> > > > 
> > 
> > Hi Don,
> > 
> > > The rest being? ... 0644 vs 0664 ?
> > > The file is read & written, thus the (first) 6; I'll have to dig through very old (7 yr) notes to see if the second 6 is needed for libvirt (so it doesn't have to be root to enable).
> > > 
> > > -dd
> > > 
> > 
> > Were you able to see if the unusual permissions (0664) are needed for
> > libvirt? I appreciate your help!
> > 
> > -Kelsey
> > 
> Daniel Berrangé reported that libvirt runs as root when dealing with anything PCI, and chowns files for qemu needs, so there is no need for the 664 permission.
> For all I know, it's a simple typo that was allowed to creep in. :-/
> 
> Feel free to modify to 644.
> 
> -dd
>

Thank you for checking into this and getting back so quick! I'll cc you in
the patch. :)

Thanks again!

-Kelsey
