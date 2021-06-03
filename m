Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6A39AE92
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 01:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFCXZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 19:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFCXZV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 19:25:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 908D4613F9;
        Thu,  3 Jun 2021 23:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622762615;
        bh=vZ1xmVnHuzsQKfrQixTnvBSOe+G6brZcsOPAUugAzF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UuONi5HOZd+gb0KU7ZxRmjOA/EtTPa5LxazaHT+y8wrMkIdeUEqK1yh3aVIoLOtt0
         i5fZTB701rPVDzhkTiobN+PgqzOaDKWTTdd6cI5cDgLAnnIxhyf/Ad7w7R34jYhn0C
         mz2zX1LhaDt298fNmpadaa9KPYxLOGH6YdJeRT10lKbwOxmiNTujr95AI51ff8gWtY
         1dZUC1h78tDlvAOw8A8Fs9CQVCO2ont4npY+oMlBIxMAY3akj4VuHM/aLl3+jr/kSg
         ToR/ecHFH8NPOzhcQ6j/JZMDBQvxmBOq01YXvZDEfz9MGhqE6Yj1Vb2CrvdUjearGx
         PygfauH3TLNpA==
Date:   Thu, 3 Jun 2021 18:23:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override
 is not NULL
Message-ID: <20210603232334.GA2153375@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603000112.703037-6-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, FYI]

On Thu, Jun 03, 2021 at 12:01:11AM +0000, Krzysztof Wilczyński wrote:
> Only expose the value of the "driver_override" variable through the
> corresponding sysfs object when a value is actually set.

This changes the attribute contents from "(null)" to an empty
(zero-length) file when no driver override has been set.

There are a few other driver_override_show() functions.  Most don't
check the pointer so they'll show "(null)".  One (spi.c) checks and
shows an empty string ("", file containing a single NULL character)
instead of an empty (zero-length) file.

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/pci-sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5d63df7c1820..4e9f582ca10f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -580,10 +580,11 @@ static ssize_t driver_override_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	ssize_t len;
> +	ssize_t len = 0;
>  
>  	device_lock(dev);
> -	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
> +	if (pdev->driver_override)
> +		len = sysfs_emit(buf, "%s\n", pdev->driver_override);
>  	device_unlock(dev);
>  	return len;
>  }
> -- 
> 2.31.1
> 
