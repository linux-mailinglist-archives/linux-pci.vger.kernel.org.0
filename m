Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD279473DD7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 08:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhLNH5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 02:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhLNH5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 02:57:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74653C061574;
        Mon, 13 Dec 2021 23:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=no8JKGCvChBkQWrs+AsGfzyWb9saA1grQmCWxF8NUHE=; b=ni235uJZ33bhmBUV5a9kLT3C07
        GB2Cg7YVvCyUj+86tix3/YYKpUMZvtRSPPrK891OdF1QbsqeO+383O5i95xTU9XXETVWxlItRbpdX
        dKEQ781vE0LWT7QKTwDTgOonAMEWOkg6aoi5nCh7NhX5+atQD4UTdayPVz26C7pEuxy7u2FfqrmXW
        RDMrGn54hlyfDQfS6HKpJGes3OJz07t9Y9AY+Rnd7nBa5s63XBsMt9jVKELpBxMX7UadI8KWdjeMC
        LXiIOhkwEWy3YB+KbjH0J80aubBp0ZVKpNmZtMKr7VhS1ba7tX+5kOWjIciE7PkG4ACXUAaqYK2YC
        DnLXHVlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mx2g7-00CwXu-PN; Tue, 14 Dec 2021 07:56:51 +0000
Date:   Mon, 13 Dec 2021 23:56:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, michael.a.bottini@linux.intel.com,
        rafael@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adhitya Mohan <me@adhityamohan.in>
Subject: Re: [PATCH V3 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
Message-ID: <YbhOQx60Qz/tLUKU@infradead.org>
References: <20211209201235.1314584-1-david.e.box@linux.intel.com>
 <20211209201235.1314584-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209201235.1314584-2-david.e.box@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 12:12:35PM -0800, David E. Box wrote:
> +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> +{
> +	int features = *(int *)userdata;
> +
> +	if (features & VMD_FEAT_QUIRK_OVERRIDE_ASPM &&
> +	    pdev->class == PCI_CLASS_STORAGE_EXPRESS) {
> +		int pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +
> +		if (pos) {
> +			pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
> +			pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);
> +			if (pcie_aspm_policy_override(pdev))
> +				pci_info(pdev, "Unable of override ASPM policy\n");
> +		}

This is completely unredable due to the long lines.  Just return early on
the two conditionals and it will all be fine.
