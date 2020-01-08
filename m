Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5C134EC2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgAHVVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgAHVVr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:21:47 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AD320705;
        Wed,  8 Jan 2020 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578518506;
        bh=NI/0EEDmS5QbvfbAKaMZQTWOoyjHvHDRvW8NzDitOPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NcCf/ebHSnRrXmFU/yRqcWrQEPUUdBzCRQnTbLB85puJkSu8GuUbGsyTYR61qeWyu
         c7eHcutvZ1/lnpmOxdJvtXpl9ArNb7YeBg0SgJiD5qFNjtp1dhMRH0mo7sNjpZzxfz
         WAxWKSbi/HY5DpdhFMDfl9hv/Ar1dYP2tR1BJDAs=
Date:   Wed, 8 Jan 2020 15:21:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH 08/12] PCI/switchtec: Add gen4 support in struct
 sys_info_regs
Message-ID: <20200108212144.GA209154@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106190337.2428-9-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 12:03:33PM -0700, Logan Gunthorpe wrote:
> Add a union with gen3 and gen4 sys_info structs. Ensure any use of the
> gen3 struct is gaurded by an if statement on stdev->gen.

s/gaurded/guarded/

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/switch/switchtec.c | 41 +++++++++++++++++++++++++++---
>  include/linux/switchtec.h      | 46 +++++++++++++++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 21d3dd6e74f9..90d9c00984a7 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -317,8 +317,14 @@ static ssize_t field ## _show(struct device *dev, \
>  	struct device_attribute *attr, char *buf) \
>  { \
>  	struct switchtec_dev *stdev = to_stdev(dev); \
> -	return io_string_show(buf, &stdev->mmio_sys_info->gen3.field, \
> -			    sizeof(stdev->mmio_sys_info->gen3.field)); \
> +	struct sys_info_regs __iomem *si = stdev->mmio_sys_info; \
> +	\
> +	if (stdev->gen == SWITCHTEC_GEN4) \
> +		return io_string_show(buf, &si->gen4.field, \
> +				      sizeof(si->gen4.field)); \
> +	else \
> +		return io_string_show(buf, &si->gen3.field, \
> +				      sizeof(si->gen3.field)); \
>  } \
>  \
>  static DEVICE_ATTR_RO(field)
> @@ -326,7 +332,21 @@ static DEVICE_ATTR_RO(field)
>  DEVICE_ATTR_SYS_INFO_STR(vendor_id);
>  DEVICE_ATTR_SYS_INFO_STR(product_id);
>  DEVICE_ATTR_SYS_INFO_STR(product_revision);
> -DEVICE_ATTR_SYS_INFO_STR(component_vendor);
> +
> +static ssize_t component_vendor_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct switchtec_dev *stdev = to_stdev(dev);
> +	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
> +
> +	/* component_vendor field not supported after gen4 */
> +	if (stdev->gen != SWITCHTEC_GEN3)

I assume the comment should say "after gen3"?  More occurrences below.

> +		return sprintf(buf, "none\n");
> +
> +	return io_string_show(buf, &si->gen3.component_vendor,
> +			      sizeof(si->gen3.component_vendor));
> +}
> +static DEVICE_ATTR_RO(component_vendor);
>  
>  static ssize_t component_id_show(struct device *dev,
>  	struct device_attribute *attr, char *buf)
> @@ -334,6 +354,10 @@ static ssize_t component_id_show(struct device *dev,
>  	struct switchtec_dev *stdev = to_stdev(dev);
>  	int id = ioread16(&stdev->mmio_sys_info->gen3.component_id);
>  
> +	/* component_id field not supported after gen4 */
> +	if (stdev->gen != SWITCHTEC_GEN3)
> +		return sprintf(buf, "none\n");
> +
>  	return sprintf(buf, "PM%04X\n", id);
>  }
>  static DEVICE_ATTR_RO(component_id);
> @@ -344,6 +368,10 @@ static ssize_t component_revision_show(struct device *dev,
>  	struct switchtec_dev *stdev = to_stdev(dev);
>  	int rev = ioread8(&stdev->mmio_sys_info->gen3.component_revision);
>  
> +	/* component_revision field not supported after gen4 */
> +	if (stdev->gen != SWITCHTEC_GEN3)
> +		return sprintf(buf, "255\n");
> +
