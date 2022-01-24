Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E456497BA3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiAXJOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 04:14:09 -0500
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25579 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAXJOH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 04:14:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1643015642; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=k/j0EJ06gczTqmlcshx20z+tVEL9pO+bkrKrb6fK3E9ZPvj/j7W4aFiSoDqCvmfu0yxFbPVK/cWZ35nuTs7UrTq2la9ExsiRNIAJtMi8qN/ZAVDsS9OWroaZj7XNNp7I+5UNcswT79+1iCydonk2yLkRAfAKghOc8K2yU4JLDlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1643015642; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=U8A0dtvg6TohkVkKtEhYVqMU71y3ASnbHjmsZP+utv4=; 
        b=fL4k26Z7UcMXlcoIDCeouixRao4nBp+UGVLJZrCVqsiyk6zx0GzkcCJWDK95TaveR5lW3T2TDIX1MYBqXWvb/ybnS7SxzEQpMAmtNvyIfEqMYNjp5bVK4gF1DUt/ANDEZJq66PXfnX5FYkl1Fv4KG421sD+/kvnH5lqYB1mD+UI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1643015642;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=U8A0dtvg6TohkVkKtEhYVqMU71y3ASnbHjmsZP+utv4=;
        b=IuXJQ78x6jp6NF8f6SxVHqGXOrgzpIytKIoteUl0JU4ilc1+sflcmEhwhm9NJtfs
        cFczlObFKBWjCXfeIneP6HA0mJ6tHlYYsngjkMyp9Rk1l9I6L8kxsbQImGKQbB0MR2Q
        M5BYOPV8kly2Fg7T7oN5esreFw0nR6Jc1rAbk0nU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1643015641448282.8096019549862; Mon, 24 Jan 2022 01:14:01 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Mon, 24 Jan 2022 01:14:01 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:14:01 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Tom Joseph" <tjoseph@cadence.com>
Cc:     "linux-pci" <linux-pci@vger.kernel.org>
Message-ID: <17e8b5d194e.e9ac398343632.1408175412712504541@zohomail.com>
In-Reply-To: 
Subject: [Question] why should alignment be added when doing
 kzalloc/dma_alloc in pci_endpoint_test_copy/write/read?
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Kishon

-	src_addr = dma_alloc_coherent(dev, size, &src_phys_addr, GFP_KERNEL);
-	if (!src_addr) {
+	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
+					   &orig_src_phys_addr, GFP_KERNEL);

I noticed in the changes below from this commit[1], you allocate "size + alignment" dma buffer instead of "size" only, but IIUC, the size of dma_alloc_coherent doesn't need to add the extra "alignment".

Is the alignment here used to reserve memory?

I have no K2G EP, but when I use cadence's controller as EP, and use "size" instead of "size + alignment" for alloc size, it doesn't have any problem, and crc32 is correct when using userspace tool "pcitest"[2] to read and write 1-300 bytes.

Hi, Tom

On cadence PCIe's userdoc 4.5.6.8.4. AXI Region Base Address Registers, it says axi_addr0's [5:0] bits are used for the programmed value of size:

> The programmed value in this field + 1 gives the region size. Minimum value to be programmed into this field is 7 as the lower 8 bits of the AXI region base address are replaced by zeros by the region select logic. Minimum region size supported is 256 bytes.

Is this why cdns_pcie_epc_features's align is 256 bytes. So, should dma_alloc_coherent's size below be at least 256 bytes?

[^1]: https://patchwork.kernel.org/project/linux-omap/patch/20170818145810.17649-15-kishon@ti.com/
[^2]: https://www.kernel.org/doc/html/latest/PCI/endpoint/pci-test-howto.html

Regards,
Li
