Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B379DD02EC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfJHVik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 17:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfJHVik (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 17:38:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2BB32070B;
        Tue,  8 Oct 2019 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570570719;
        bh=11TBIQmvDjjaIrom74PlC3QwYOcWo8Yzh1UnY6FDcXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vdS3XsDJMxwTYD7JXt7NUIntQHVBVRlNiQi5xBv/fgLTIFcGeDhw+C0HfNW4Wjwh7
         e+5qQwwp5LH8xUShakUgnUp7sCPg45gIVCt6ehJz+iXM6t+iqJVkhY+7zczyZ6lYul
         hBlMiNvw4LndkopNyp9a7E1JajpgAU8UTqbUqXNQ=
Date:   Tue, 8 Oct 2019 16:38:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     CREGUT Pierre IMT/OLN <pierre.cregut@orange.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Donald Dutile <ddutile@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] PCI/IOV: update num_VFs earlier
Message-ID: <20191008213835.GA230403@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003221007.GA209602@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 03, 2019 at 05:10:07PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2019 at 11:04:45AM +0200, CREGUT Pierre IMT/OLN wrote:
> > ...

> > NIC drivers send netlink events when their state change, but it is
> > the core that changes the value of num_vfs. So I would think it is
> > the core responsibility to make sure the exposed value makes sense
> > and it would be better to ignore the details of the driver
> > implementation.
> 
> Yes, I think you're right.  And I like your previous suggestion of
> just locking the device in the reader.  I'm not enough of a sysfs
> expert to know if there's a good reason to avoid a lock there.  Does
> the following look reasonable to you?

I applied the patch below to pci/virtualization for v5.5, thanks for
your great patience!

> commit 0940fc95da45
> Author: Pierre Crégut <pierre.cregut@orange.com>
> Date:   Wed Sep 11 09:27:36 2019 +0200
> 
>     PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes
>     
>     When sriov_numvfs is being updated, drivers may notify about new devices
>     before they are reflected in sriov->num_VFs, so concurrent sysfs reads
>     previously returned stale values.
>     
>     Serialize the sysfs read vs the write so the read returns the correct
>     num_VFs value.
>     
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=202991
>     Link: https://lore.kernel.org/r/20190911072736.32091-1-pierre.cregut@orange.com
>     Signed-off-by: Pierre Crégut <pierre.cregut@orange.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b3f972e8cfed..e77562aabbae 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -254,8 +254,14 @@ static ssize_t sriov_numvfs_show(struct device *dev,
>  				 char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> +	u16 num_vfs;
> +
> +	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> +	device_lock(&pdev->dev);
> +	num_vfs = pdev->sriov->num_VFs;
> +	device_lock(&pdev->dev);
>  
> -	return sprintf(buf, "%u\n", pdev->sriov->num_VFs);
> +	return sprintf(buf, "%u\n", num_vfs);
>  }
>  
>  /*
