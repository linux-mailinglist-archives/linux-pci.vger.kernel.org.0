Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7F39AC97
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFCVT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 17:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhFCVT2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 17:19:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0072B613D8;
        Thu,  3 Jun 2021 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622755063;
        bh=cumZ57jxkD7fOTdMazyaWdq9FCj7mvumlpdpwyKAfGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZxhjUdNmrmarVzUuCyF0eA7zULAUFNIm2sv/Ib/u5cu7Tt7dLmR87W+ZK4dcpCOrL
         m95ETUrp6N5VC1oPkoRqx4xGJDlqA3SaiXuKiskt6dJWYVZpsMO75uZX7FvRJ7m0pq
         vqb9SKNpi8VXPLs2+qGzfTwQGBVwT3gbABZdHpSaJIlIFyBdZbdNpT5ccMzMtV46E8
         v+n6mOWzEpgYK/yD3tUN94elkhUxk5JYiPIiApxvfwnsOtVgOAXxhRq3QAJi0qPBS6
         jM1P3TaKF+WYafu1NF+KjKwtJPHH0TdrVIdxRADFuY8q03KvULgCU/tS+PIJivqLDW
         9QD4lBn/Nj0/Q==
Date:   Thu, 3 Jun 2021 16:17:41 -0500
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
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/6] PCI/sysfs: Only show value when driver_override
 is not NULL
Message-ID: <20210603211741.GA2141918@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603000112.703037-6-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 12:01:11AM +0000, Krzysztof Wilczyński wrote:
> Only expose the value of the "driver_override" variable through the
> corresponding sysfs object when a value is actually set.

What's the reason for this change?  The above tells me what it *does*,
but not *why* or whether it affects users.

Is this to avoid trying to print a NULL pointer as %s?  Do we print
"(null)" or something in that case now?  I assume sprintf() doesn't
actually oops.  If we change what appears in sysfs, we should mention
that here.  And maybe consider whether there's any chance of breaking
user code that might know what to do with "(null)" but not with an
empty string.

There are six other driver_override_show() methods.  Five don't check
the ->driver_override pointer at all; one (spi.c) checks like this:

  len = snprintf(buf, PAGE_SIZE, "%s\n", spi->driver_override ? : "");

Do the others need similar fixes?  Most of them still use sprintf()
also.

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
