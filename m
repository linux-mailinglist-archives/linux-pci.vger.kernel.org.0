Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4530855B54
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFYWgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 18:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYWgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 18:36:11 -0400
Received: from localhost (236.sub-174-209-17.myvzw.com [174.209.17.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E68B205ED;
        Tue, 25 Jun 2019 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502170;
        bh=erg06t1vXLhlnRWJqBiac6VQHBryWbFqbZtliiEvC8A=;
        h=Date:From:To:Cc:Subject:From;
        b=ZH231qYqv4dClsoXSlBZ0gaa8XZykQRduRpyNYFwBb7jLCRN+yFtBQYqg9TdtXtGU
         Qdm+BayxrhD8y1wMSJuENkeV8rFmAedWCE+btnJ95Gsi3rNXwCk6ewKXd9aGwI6qy/
         wAq/74RXi4bL8Bc8KWLfunYqqJwCwlMYkjVsuwDE=
Date:   Tue, 25 Jun 2019 17:36:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: mmap/munmap in sysfs
Message-ID: <20190625223608.GB103694@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg, et al,

Userspace can mmap PCI device memory via the resourceN files in sysfs,
which use pci_mmap_resource().  I think this path is unaware of power
management, so the device may be runtime-suspended, e.g., it may be in
D1, D2, or D3, where it will not respond to memory accesses.

Userspace accesses while the device is suspended will cause PCI
errors, so I think we need something like the patch below.  But this
isn't sufficient by itself because we would need a corresponding
pm_runtime_put() when the mapping goes away.  Where should that go?
Or is there a better way to do this?


diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d27475e39b2..aab7a47679a7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1173,6 +1173,7 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
 
+	pm_runtime_get_sync(pdev);
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
 
