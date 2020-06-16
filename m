Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1411FA86C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 07:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFPF5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 01:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPF5w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 01:57:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1D0207E8;
        Tue, 16 Jun 2020 05:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592287072;
        bh=UPondy/gLEeob42yBMK75A90hWsNm0WoAX0fhd+BKsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S36qoPg4Ccn1IlxtXBdfEqDkL77xw4EqbBxGpo52DJANn0SxLDqRTHMbS3hI2z64i
         gx7ZOTC+hdupxlw6FnQvel2n2QzH+BKpYDlHLVgIOucAL9T4Ubcx8KhDkWOI91R6tN
         WE6LiBCvTOoxwxm2yf564ty4NrQdJBWrQbwX0YgY=
Date:   Tue, 16 Jun 2020 07:57:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200616055747.GA2047@kroah.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616011742.138975-4-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 06:17:42PM -0700, Rajat Jain wrote:
> This is needed to allow the userspace to determine when an untrusted
> device has been added, and thus allowing it to bind the driver manually
> to it, if it so wishes. This is being done as part of the approach
> discussed at https://lkml.org/lkml/2020/6/9/1331
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6d78df981d41a..574e9c613ba26 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -50,6 +50,7 @@ pci_config_attr(subsystem_device, "0x%04x\n");
>  pci_config_attr(revision, "0x%02x\n");
>  pci_config_attr(class, "0x%06x\n");
>  pci_config_attr(irq, "%u\n");
> +pci_config_attr(untrusted, "%u\n");
>  
>  static ssize_t broken_parity_status_show(struct device *dev,
>  					 struct device_attribute *attr,
> @@ -608,6 +609,7 @@ static struct attribute *pci_dev_attrs[] = {
>  #endif
>  	&dev_attr_driver_override.attr,
>  	&dev_attr_ari_enabled.attr,
> +	&dev_attr_untrusted.attr,
>  	NULL,
>  };

You also need a Documentation/ABI/ update for this new file.

thanks,

greg k-h
