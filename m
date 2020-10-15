Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432BF28ED34
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgJOGw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 02:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOGw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 02:52:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C731CC061755;
        Wed, 14 Oct 2020 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j6yfA8UT8xWaEF0uYRUzRwVGZR9uDhBP+4UPoxN1m44=; b=u0D5TbT8MHtyTx6if7jno7uKHO
        AQrmZQC1nsy4Nx8oqwqZrjPBdHbNJxcCJRgP8TqLRZ10J+r0sKphzFPNw37W+QsOXQ4uXyKKpk0Oy
        5j1PYKs+/URTsmM7a8MrvhiM+0WaMc+iHZPORfcIPUOrBY6yhSYZJuNEBWAt7jw1zWfP50/0GumDU
        6JEjzXXvwHSKOX49f+sweDCRjrdtqte9UD3fY99x2PU+C9ms2kJeUDLz11HrESovPI43AIiYwGylC
        RG47sYHQjF5MHhMBNqqyZsbkRtIpwFtXtiqdLeXWsVjD6U/tSSWk/VCFaE2L9gT93H7oi32Ds4MrM
        ad/N8GYA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSx7e-0003y7-RK; Thu, 15 Oct 2020 06:52:22 +0000
Date:   Thu, 15 Oct 2020 07:52:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
Message-ID: <20201015065222.GB12987@infradead.org>
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>  /* PCI error reporting and recovery */
> -pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -			pci_channel_state_t state,
> +pci_ers_result_t pcie_do_nonfatal_recovery(struct pci_dev *dev);
> +
> +pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));

Now that both functions have descriptive names (thanks for that!),
the "_do" component of the names can be dropped.

> +pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> +{
> +	struct pci_dev *udev;
> +	struct pci_bus *parent;
> +	struct pci_dev *pdev, *temp;
> +	pci_ers_result_t result;
> +
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +		udev = dev;
> +	else
> +		udev = dev->bus->self;
> +
> +	parent = udev->subordinate;
> +	pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> +
> +        pci_lock_rescan_remove();
> +        pci_dev_get(dev);
> +        list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> +					 bus_list) {
> +		pci_stop_and_remove_bus_device(pdev);
> +	}
> +
> +	result = reset_link(udev);

Some of the indentation seems strange here, please use tab based
indents everywhere.
