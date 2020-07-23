Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9522BA22
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 01:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgGWXUt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 19:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgGWXUt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 19:20:49 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A13F206E3;
        Thu, 23 Jul 2020 23:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595546448;
        bh=i+Ceq41gViZl1zByQdcr9xsP75TCnNB51e/Bimh3Pr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EUcPK8R06MB++pnG74f+WhK4FLoWCqF2rEiQLgNYL6JcGZD/G19DSnX331wUy8Qt6
         N9OBWObPxdpH6xfO/UyAsdwJwaERNeXFdian/Vl7i5UotFzUK6JbN1kYjXmpRD7NIP
         1OxYe9M0ym7P3o3cjtxrd8hEvHPW6wIJK3byTYqU=
Date:   Thu, 23 Jul 2020 18:20:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, zhangliguang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, linuxarm@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Message-ID: <20200723232046.GA1468652@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722103952.1009-2-shiju.jose@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 11:39:51AM +0100, Shiju Jose wrote:
> CPER records describing a firmware-first error are identified by GUID.
> The ghes driver currently logs, but ignores any unknown CPER records.
> This prevents describing errors that can't be represented by a standard
> entry, that would otherwise allow a driver to recover from an error.
> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> version 2.8).

> +#ifdef CONFIG_ACPI_APEI_GHES
> +/**
> + * ghes_register_vendor_record_notifier - register a notifier for vendor
> + * records that the kernel would otherwise ignore.
> + * @nb: pointer to the notifier_block structure of the event handler.
> + *
> + * return 0 : SUCCESS, non-zero : FAIL
> + */
> +int ghes_register_vendor_record_notifier(struct notifier_block *nb);
> +
> +/**
> + * ghes_unregister_vendor_record_notifier - unregister the previously
> + * registered vendor record notifier.
> + * @nb: pointer to the notifier_block structure of the vendor record handler.
> + */
> +void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
> +#else
> +static inline int ghes_register_vendor_record_notifier(struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
> +{
> +}

If you made CONFIG_PCIE_HISI_ERR depend on CONFIG_ACPI_APEI_GHES,
you'd be able to get rid of these stubs, wouldn't you?  It doesn't
look like there's any point in building pcie-hisi-error.c at all
unless CONFIG_ACPI_APEI_GHES is enabled.

> +#endif
> +
>  int ghes_estatus_pool_init(int num_ghes);
>  
>  /* From drivers/edac/ghes_edac.c */
> -- 
> 2.17.1
> 
> 
