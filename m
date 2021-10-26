Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF07343BD11
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhJZWO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 18:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235479AbhJZWOy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 18:14:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EA1A60187;
        Tue, 26 Oct 2021 22:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635286349;
        bh=f0InZtaTABxRgkFDwD56MVn+oTu5irhQQZAi/3/msj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eVfyP8FqtA1n8D5OWXStSgLXfcOCjjhtfYG0iGz3qdEhj5eWlVY36hYXHgbrnGk1c
         /wGfKE4R39glaSVOjwEltUtX8dtkN/LNJ2rxHvpYIsEijHp8IlV8CYby008Gpf7hu3
         WsCX48aQGbKxfz6bBLBCHYjrZwUXVaCRUmoaMVqiV3PeRXiiSTrWG0X+UJKC/Ve8+N
         L/vw6E/9+3zM7zULxQ1jCW4OZ7OUqGNdxJPXT/P+JbNOgnnN9kSo/HrOAGtOVYqPd/
         FPgvXv1OZ6gumSOki3100RYLSrH4qh84lRoH5EZubf1On6j3YJHDiWJGY9Uyp65/DA
         Ouq0E0VNMuwrg==
Date:   Tue, 26 Oct 2021 17:12:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Slivka, Danijel" <Danijel.Slivka@amd.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Message-ID: <20211026221227.GA172193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510225733.GA2307664@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 05:57:33PM -0500, Bjorn Helgaas wrote:
> On Mon, May 10, 2021 at 03:02:45PM +0000, Slivka, Danijel wrote:
> > Hi Bjorn,
> > 
> > Yes, I get segmentation fault on unloading custom module during the
> > check of error handling case.
> >
> > There is no directly visible access to res_attr fields, as you
> > mentioned, other than the one in a call chain after a check in
> > pci_remove_resource_files() which seems to cause the issue
> > (accessing name).
> >
> > Load and unload module will invoke pci_enable_sriov() and
> > disable_pci_sriov() respectively that are both having a call of
> > pci_remove_resource_files() in call chain.
> >
> > In that function existing check is not behaving as expected since
> > memory is freed but pointers left dangling. 
> >
> > Below is call trace and detail description. 
> > 
> > During loading of module pci_enable_sriov() is called, I have
> > following invoking sequence:
> >
> > device_create_file
> > pci_create_capabilities_sysfs
> > pci_create_sysfs_dev_files
> > pci_bus_add_device
> > pci_iov_add_virtfn
> > sriov_enable
> > pci_enable_sriov
> 
> OK.  For anybody following along, this call path changed in v5.13-rc1,
> so pci_create_capabilities_sysfs() longer exists.  But looking at
> v5.12, I think the sequence you're seeing is:
> 
>   pci_create_sysfs_dev_files
>     pci_create_capabilities_sysfs
>       retval = device_create_file(&dev->dev, &dev_attr_reset)
>       return retval		# I guess this what failed, right?
>     if (retval) goto err_rom_file
>     err_rom_file:
>     ...
>     pci_remove_resource_files
>       sysfs_remove_bin_file(pdev->res_attr[i])
>       kfree(pdev->res_attr[i])
>       # pdev->res_attr[i] not set to NULL in v5.12
> 
> Later, on module unload, we have this sequence:
> 
>   pci_disable_sriov
>     sriov_disable
>       sriov_del_vfs
>         pci_iov_remove_virtfn
>           pci_stop_and_remove_bus_device
>             pci_stop_bus_device
>               pci_stop_dev
>                 pci_remove_sysfs_dev_files
>                   pci_remove_resource_files
>                     sysfs_remove_bin_file(pdev->res_attr[i])
>                     # pdev->res_attr[i] points to a freed object
> 
> Definitely seems like a problem.  Hmmm.  I'm not really a fan of
> checking the pointer to see whether it's been freed.  That seems like
> a band-aid.

This patch does:

  +			pdev->res_attr[i] = NULL;
  +			pdev->res_attr_wc[i] = NULL;

which I think essentially relies on the fact that kfree(NULL) is a
no-op.

I'm going to drop this for now because I don't want to rely on that.
I'd rather avoid doing the kfree() altogether.

IIRC this happens when device_create_file() fails, and it likely fails
because of a race when creating the sysfs files, which would explain
why we don't see lots of reports of this.

Bjorn
