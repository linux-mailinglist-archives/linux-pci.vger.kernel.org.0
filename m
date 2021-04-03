Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253AC353352
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 11:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhDCJuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhDCJuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 05:50:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78EEC0613E6
        for <linux-pci@vger.kernel.org>; Sat,  3 Apr 2021 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rJkxlwOV7vZGpPFthy4ZNz31A3cKfocUp9A0EFMibKg=; b=b5AoxChxDX1faIuQccAA9AMGvJ
        VyxqpKpeXTEL4nuvydRJy4ZZDm/PdaT9PpzOxDOj4xl1+RRKD3lMxmW7Vqcpb6gORXI/2AXpt6GND
        IWBdqHOTNSwKx9sICZSoH4SYPIaVIdypHCUykp5RiPd3UpUmYT2xQ5yGyc9d98Q8+sajQDftSDoX7
        /9iCB0P2zLC4NS7ta6ZFz7V/rYQUG5W1Xq4G7O/aoIwPr2QIGGUTOzRwzCzHjPACjgtUqnmfbN6Fa
        LERE5NLx7OTlMXKBqfwLKsGVmYtQlhmBX6jO1ouJZtY1OF/HyREXGkebPc9x+3wEhvUXS0Zjv/vPe
        cpu7hqmw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lScvE-008k3f-Qw; Sat, 03 Apr 2021 09:50:31 +0000
Date:   Sat, 3 Apr 2021 10:50:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: Enable 10-Bit tag support for PCIe Endpoint
 devices
Message-ID: <20210403095028.GA2082662@infradead.org>
References: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
 <1617440059-2478-3-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617440059-2478-3-git-send-email-liudongdong3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +	ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
> +	if (ret)
> +		return;

Wouldn't it make sense to store the devcap value in the pci_dev
structure instead of reading it multiple times?

> +	/* 10-Bit Tag Requester Enable in Device Control 2 Register is RsvdP for VF */

Please avoid the overly long lines.

> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT &&
> +	    dev->ext_10bit_tag_comp_path == 1 &&
> +	    (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ)) {
> +		pci_info(dev, "enabling 10-Bit Tag Requester\n");

I think that printk might become a little too noisy when lots of
devices support this capability.

> +	unsigned int	ext_10bit_tag_comp_path:1; /* 10-Bit Tag Completer Supported from root to here */

Another crazy long line.  And why not just name this
10bit_tags?

Also a lot of this walk the upstream bridges until we hit the
root port code seems duplicatated for different capabilities.  Shouldn't
we have one such walk that checks all the interesting capabilities?  Or
even turn the thing around and set them on the fly while scanning
the topology?
