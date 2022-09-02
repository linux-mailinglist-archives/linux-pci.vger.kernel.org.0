Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A59F5AB886
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiIBSrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 14:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiIBSrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 14:47:05 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9349D41BE;
        Fri,  2 Sep 2022 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=PqVz82vunw7RduM37pHXxkZOsTDf9dFgFE3ITMuOtdI=; b=JataSn/skoSH64/P2bM9NmNrAx
        mtcVSJPKUZre0aOJvsQWYO+m3EToEpFrs1dRNUkw3+G/Ex+d7h2xidgzqDIolkfvqfYKNmwMgQ6N2
        nfOvHRz1L7uBTrWccDr+1s2raUkJLHrtuW5Q1MZgSQWd/puBO+3hmKiiOx3snBgxeIpGio7Qfh1jG
        kfY2bRCTReU/XgwV/0rdcflfSW3goRF0dY7BScNu/mTlToq4FFVx7eUCEY2vhw8UQp9Vg7mnpAhfD
        3X+fPIysjV3e6PZb+4GD+nOkpjQnnjwKYXAgvOnMNVwOcVxoklWjjHcYj1l8vBM0/aFmAlKglKlMH
        jZ9FIP4A==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oUBgz-00Eklo-54; Fri, 02 Sep 2022 12:47:02 -0600
Message-ID: <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
Date:   Fri, 2 Sep 2022 12:46:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
 <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
 <YxGad5h2Nn/Ejslc@kroah.com>
Content-Language: en-CA
In-Reply-To: <YxGad5h2Nn/Ejslc@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-01 23:53, Greg Kroah-Hartman wrote:
> On Thu, Sep 01, 2022 at 01:16:54PM -0600, Logan Gunthorpe wrote:
>> This surprises me. Can you elaborate on this classic issue?
> 
> There's long threads about it on the ksummit discuss mailing list and
> other places.

I've managed to find one such thread dealing with lifetime issues of
different objects and bugs that are common with mistakes with its usage.
I've dealt with similar issues in the past, but as best as I can see 
there are no lifetime issues in this code.

> I have never used devm_add_action_or_reset() so I can't say why it is
> there.  I am just pointing out that manually messing with a sysfs group
> from a driver is a huge flag that something is wrong.  A driver should
> almost never be touching a raw kobject or calling any sysfs_* call if
> all is normal, which is why I questioned this.

In this case we need to remove the specifc sysfs file to teardown any
vmas earlier in the remove sequence than it would be done normally. Whether
we do that through devm or remove() doesn't change the fact that we need
to access the dev->kobj to do that early.

>> But if it's that important I can make the change to these patches for v10.
> 
> Try it the way I suggest, with a remove() callback, and see if that
> looks simpler and easier to follow and maintain over time.

See the diff at the bottom of this email. I can apply it on top of this
patch, but IMO it is neither easier to follow nor maintain. Unless you 
have a different suggestion...

Thanks,

Logan

--

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a6ed6bbca214..4e1211a2a6cd 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -206,6 +206,23 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
 	.page_free = p2pdma_page_free,
 };
 
+void pci_p2pdma_remove(struct pci_dev *pdev)
+{
+	if (!rcu_access_pointer(pdev->p2pdma))
+		return;
+
+	/*
+	 * Any userspace mappings must be unmapped before the
+	 * devm_memremap_pages() release happens, otherwise a device remove
+	 * will hang on any processes that have pages mapped. To avoid this,
+	 * remove the alloc attribute from sysfs which will call
+	 * unmap_mapping_range() on the inode and teardown any existing
+	 * userspace mappings.
+	 */
+	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
+				     p2pmem_group.name);
+}
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -257,19 +274,6 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	return error;
 }
 
-static void pci_p2pdma_unmap_mappings(void *data)
-{
-	struct pci_dev *pdev = data;
-
-	/*
-	 * Removing the alloc attribute from sysfs will call
-	 * unmap_mapping_range() on the inode, teardown any existing userspace
-	 * mappings and prevent new ones from being created.
-	 */
-	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
-				     p2pmem_group.name);
-}
-
 /**
  * pci_p2pdma_add_resource - add memory for use as p2p memory
  * @pdev: the device to add the memory to
@@ -328,11 +332,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		goto pgmap_free;
 	}
 
-	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
-					 pdev);
-	if (error)
-		goto pages_free;
-
 	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
 	error = gen_pool_add_owner(p2pdma->pool, (unsigned long)addr,
 			pci_bus_address(pdev, bar) + offset,
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 49238ddd39ee..a096f2723eac 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -471,6 +471,8 @@ static void pci_device_remove(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_p2pdma_remove(pci_dev);
+
 	if (drv->remove) {
 		pm_runtime_get_sync(dev);
 		drv->remove(pci_dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..1c5c901a2fcc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -774,4 +774,12 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef CONFIG_PCI_P2PDMA
+void pci_p2pdma_remove(struct pci_dev *dev);
+#else
+static inline void pci_p2pdma_remove(struct pci_dev *dev);
+{
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */








