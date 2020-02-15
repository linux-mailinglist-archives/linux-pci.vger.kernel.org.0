Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB216008A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2020 22:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBOVKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Feb 2020 16:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBOVKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Feb 2020 16:10:50 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905702086A;
        Sat, 15 Feb 2020 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581801050;
        bh=tEClT3+bvoTgI32MP1CwIfXkOx2B0xPFE4PgnQ/bh48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j47cd6VEUSwkfygxE3Fl0jZ0+y96rV6rhCOwTbxqICgBpfUFlzCgbwqGdRnYiox7C
         WKpb0mZuAn05weV4GJBx36SsMMc64S7A1LA6rWCgZ5DLfuiiSr3UJMQigOngLYguLD
         3KhIlTuEB+wKTuzoV2SkhAffzCkX+GisJYG3Cb8A=
Date:   Sat, 15 Feb 2020 15:10:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     will@kernel.org, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        joro@8bytes.org, baolu.lu@linux.intel.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH 02/11] PCI: Add ats_supported host bridge flag
Message-ID: <20200215211047.GA124796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213165049.508908-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 05:50:40PM +0100, Jean-Philippe Brucker wrote:
> Each vendor has their own way of describing whether a host bridge
> supports ATS.  The Intel and AMD ACPI tables selectively enable or
> disable ATS per device or sub-tree, while Arm has a single bit for each
> host bridge.  For those that need it, add an ats_supported bit to the
> host bridge structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/pci/probe.c | 7 +++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..75c0a25af44e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -598,6 +598,13 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +
> +	/*
> +	 * Some systems may disable ATS at the host bridge (ACPI IORT,
> +	 * device-tree), other filter it with a smaller granularity (ACPI DMAR
> +	 * and IVRS).
> +	 */
> +	bridge->ats_supported = 1;

The cover letter says it's important to enable ATS only if the host
bridge supports it.  From the other patches, it looks like we learn if
the host bridge supports ATS from either a DT "ats-supported" property
or an ACPI IORT table.  If that's the case, shouldn't the default here
be "ATS is *not* supported"?

>  }
>  
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a9de..9fe2e84d74d7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,6 +511,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> +	unsigned int	ats_supported:1;
>  
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
> -- 
> 2.25.0
> 
