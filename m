Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837AC39AE7A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 01:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCXCd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 19:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCXCd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 19:02:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 964E86109F;
        Thu,  3 Jun 2021 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622761247;
        bh=Mb9/VyDtnH5WnbFYwfm20BZ1qCQ3kVeZ0EyJvln1vzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CPq8nSLKT/wAoH/M+7W8poK3WO6ajm2wOkTTMLvseGFt3NO+yag8kYUuETBac+yvG
         3gHvcVTjGX5TZg+/XP0csbd5wIh+z115fdbyyiCf12fA3AjCf0jkXM94TXJUcBSyrt
         1ubOO+wMMhvv494DvyCsztVtp0Wat3U64CSCfXfoilqJjVS3D+qfnSe1oseCRt2lNV
         9dyLcfawBlc0mwh9tgbsJrtjP3xeYTEqfR5JUyrM2otRfsGy6RyADm4TPqiJSFVNyc
         IsdIMeJvlQkItubq1yxPt4XTttQ8y4BHKluGfsEt4b4ns0AQBNr2r0JcWha6XnZxD/
         Kxi0TtaIElSXA==
Date:   Thu, 3 Jun 2021 18:00:46 -0500
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
        Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/6] PCI/sysfs: Add missing trailing newline to
 devspec_show()
Message-ID: <20210603230046.GA2149598@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603000112.703037-5-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sebastian]

On Thu, Jun 03, 2021 at 12:01:10AM +0000, Krzysztof Wilczyński wrote:
> At the moment, when the value of the "devspec" sysfs object is read from
> the user space there will be no newline present, and the utilities such
> as the "cat" command won't display the result of the read correctly in
> a shell, as the trailing newline is currently missing.
> 
> To fix this, append a newline character in the show() function.

There are a few other devspec_show() functions:

  arch/powerpc/platforms/pseries/ibmebus.c
  arch/powerpc/platforms/pseries/vio.c
  arch/sparc/kernel/vio.c
  drivers/usb/core/sysfs.c

and they all include the newline.  So I assume it's not likely that
this minor user-visible change will break something.

I did cc: Sebastian, since his dfc73e7acd99 ("PCI: Move Open Firmware
devspec attribute to PCI common code") moved this code to pci-sysfs.c
in the first place (it came from microblaze and powerpc code that
*also* did not include the newline).

I notice that pci-sysfs.c is the only one that returns 0 if of_node is
NULL.  Probably makes more sense than what the others do.  I'm
guessing the others would print "(null)" which doesn't seem quite
right for a sysfs attribute.

But pci-sysfs.c also goes to a little more work than necessary to look
up of_node:

  struct pci_dev *pdev = to_pci_dev(dev);
  struct device_node *np = pci_device_to_OF_node(pdev);

when I think this would be equivalent:

  struct device_node *np = dev->of_node;

Some of the others do a similar dance with struct platform_device.

Why'd I write all the above?  I dunno; this looks good to me, no
action required for you :)

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index beb8d1f4fafe..5d63df7c1820 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -537,7 +537,7 @@ static ssize_t devspec_show(struct device *dev,
>  
>  	if (np == NULL)
>  		return 0;
> -	return sysfs_emit(buf, "%pOF", np);
> +	return sysfs_emit(buf, "%pOF\n", np);
>  }
>  static DEVICE_ATTR_RO(devspec);
>  #endif
> -- 
> 2.31.1
> 
