Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73662AABDE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfIETTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:19:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33787 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbfIETTQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 15:19:16 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so7380318ioo.0;
        Thu, 05 Sep 2019 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4H+00FT86KrBzGBMAaG9YsNmL5V94Ah1j6tp52OR/sw=;
        b=f7haY2GvKD6nxZRpfDo5gXI0ooTqGftYaSp6ea3u9qATfG+es1jipb3BN2fu5XvHDb
         /irP4iDQUg6qLcuBL6SqBjxKuX/wynwscBscUuuXWtdUCggn06SdMAe0i3BVf/S8ZXTt
         N3DY4dXzPPYc2D2HhC1yKESBbeDbCn5YUq3UkOURhfq7DpjhWapEmjNYweYSaxvdNUds
         EBsPp1Y3YyPpgbZ8d6uCBZC0KFeddahzYzePXvTyTp4yXySA6lPSzHFYuhK5AWC/KyIS
         pGXkpIViKVnhKJQ3XKHx4OZSJ4vBEH+3dLZzpftMatJZretC9YnpJZ16oAyaQKcvS4Kf
         qUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4H+00FT86KrBzGBMAaG9YsNmL5V94Ah1j6tp52OR/sw=;
        b=AUqy5Sa3MrIXQUNHF1r1kAleVVoNoYO+9DhLyt4+Gdu4FCwlO5k7EnmUhsoRO98CH7
         TOt6SmK/kaqDUuqCEJFyDXwGWOrce8CFHtqJx7KEWz7/8Dpp1qGaQVGYGFwV7A/zyK7P
         KMCnkN9rvoDCPALCeVcc1BUgokrQyPFNtXZKgZXjas2F0CTsXOlbsKWrKCVBM49PUJ/D
         TfaDvmUhkfB5PmKlj57x4TxOQfEzisGRZQ+UVhzBIzLGcTdRCFhxFGGMzvKGI4uNiSYj
         TJ11d/pGUBMQBm9YteEWOJs6Rm3b2QHInrfBodA/unTNu7G6EXPRnvaWoiWesUvXymUY
         KClg==
X-Gm-Message-State: APjAAAUM5rOEaAE28bwLw3c7dRcltkLGwpXg81Ig7Du1tjSlJNDLvHmA
        zfxPfFRGBv4eKzjOZ4r5wc8=
X-Google-Smtp-Source: APXvYqwp2zRVbrf3LYNWyPxCicokLZGgXuAfgfKU8xg3M/8pD7dLvulPGBWH9w23x3znuX/Xr1jGDQ==
X-Received: by 2002:a6b:1542:: with SMTP id 63mr3357746iov.35.1567711155659;
        Thu, 05 Sep 2019 12:19:15 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id b7sm2487324iod.78.2019.09.05.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:19:14 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:19:13 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Don Dutile <ddutile@redhat.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bodong@mellanox.com,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, berrange@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI/IOV: Make SR-IOV attributes with mode 0664 use 0644
Message-ID: <20190905191913.GB22813@JATN>
References: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
 <37736cd8-fc9f-5896-030a-d7957cc68113@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37736cd8-fc9f-5896-030a-d7957cc68113@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 12:24:19PM -0400, Don Dutile wrote:
> On 09/05/2019 02:32 AM, Kelsey Skunberg wrote:
> > sriov_numvfs and sriov_drivers_autoprobe have "unusual" permissions (0664)
> > with no reported or found reason for allowing group write permissions.
> > libvirt runs as root when dealing with PCI, and chowns files for qemu
> > needs. There is not a need for the "0664" permissions.
> > 
> > sriov_numvfs was introduced in:
> > 	commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")
> > 
> > sriov_drivers_autoprobe was introduced in:
> > 	commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to
> > 			      control VF driver binding")
> > 
> > Change sriov_numvfs and sriov_drivers_autoprobe from "0664" permissions to
> > "0644" permissions.
> > 
> > Exchange DEVICE_ATTR() with DEVICE_ATTR_RW() which sets the mode to "0644".
> > DEVICE_ATTR() should only be used for "unusual" permissions.
> > 
> > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > ---
> >   drivers/pci/iov.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index b335db21c85e..b3f972e8cfed 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -375,12 +375,11 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
> >   }
> >   static DEVICE_ATTR_RO(sriov_totalvfs);
> > -static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
> > +static DEVICE_ATTR_RW(sriov_numvfs);
> >   static DEVICE_ATTR_RO(sriov_offset);
> >   static DEVICE_ATTR_RO(sriov_stride);
> >   static DEVICE_ATTR_RO(sriov_vf_device);
> > -static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
> > -		   sriov_drivers_autoprobe_store);
> > +static DEVICE_ATTR_RW(sriov_drivers_autoprobe);
> >   static struct attribute *sriov_dev_attrs[] = {
> >   	&dev_attr_sriov_totalvfs.attr,
> > 
> Thanks again for the cleanup.
> 
> Acked-by: Donald Dutile <ddutile@redhat.com>
>

Glad I could contribute. Thanks for your help and the
acknowledgment. :)

-Kelsey
