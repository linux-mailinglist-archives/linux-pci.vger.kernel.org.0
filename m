Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177BA5B4EC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGAGUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAGUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pGxQgejDkjhKcnTzKZVy7GhQS3WeCxr1uacobJGzUto=; b=cEA64W8VmyDrqRoh7om1ftdVn
        AkTWbNUzNPYOSiyfsYKIepeLMKblZYxA9XOpWY2otVARi53GzcFnTkdXTuWtS13/fU7gXvVjXYl59
        gFz1u0IBWLRw6OvkmTTdSNQWPmgQbpzehEAtOwRy+XfYtp72X1OPFrrd2VgjizsnKOAtKqT6t3Uod
        Cg9h7Wr0JCLWzoL/ASQlmiJzSeepom8Pg0iJ0aN4JEAZfnJI9FV0d21V/NCWjZ2VNMWKpkcPhB5Dp
        6VfsYpI8j/QORPqaFQMUcF5a0iYRF0A1l9k7nwJBYXtsTODp2SKJ4eyluCkTq/d7JzE7Sy2oFRCcH
        VXACXoXVQ==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpfx-0002tC-0a; Mon, 01 Jul 2019 06:20:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 03/22] mm/hmm: clean up some coding style and comments
Date:   Mon,  1 Jul 2019 08:20:01 +0200
Message-Id: <20190701062020.19239-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

There are no functional changes, just some coding style clean ups and
minor comment changes.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
 mm/hmm.c            | 62 ++++++++++++++++++++-------------------
 2 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 740bb00853f5..7007123842ba 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -21,8 +21,8 @@
  *
  * HMM address space mirroring API:
  *
- * Use HMM address space mirroring if you want to mirror range of the CPU page
- * table of a process into a device page table. Here, "mirror" means "keep
+ * Use HMM address space mirroring if you want to mirror a range of the CPU
+ * page tables of a process into a device page table. Here, "mirror" means "keep
  * synchronized". Prerequisites: the device must provide the ability to write-
  * protect its page tables (at PAGE_SIZE granularity), and must be able to
  * recover from the resulting potential page faults.
@@ -105,10 +105,11 @@ struct hmm {
  * HMM_PFN_WRITE: CPU page table has write permission set
  * HMM_PFN_DEVICE_PRIVATE: private device memory (ZONE_DEVICE)
  *
- * The driver provide a flags array, if driver valid bit for an entry is bit
- * 3 ie (entry & (1 << 3)) is true if entry is valid then driver must provide
+ * The driver provides a flags array for mapping page protections to device
+ * PTE bits. If the driver valid bit for an entry is bit 3,
+ * i.e., (entry & (1 << 3)), then the driver must provide
  * an array in hmm_range.flags with hmm_range.flags[HMM_PFN_VALID] == 1 << 3.
- * Same logic apply to all flags. This is same idea as vm_page_prot in vma
+ * Same logic apply to all flags. This is the same idea as vm_page_prot in vma
  * except that this is per device driver rather than per architecture.
  */
 enum hmm_pfn_flag_e {
@@ -129,13 +130,13 @@ enum hmm_pfn_flag_e {
  *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
  *      set and the pfn value is undefined.
  *
- * Driver provide entry value for none entry, error entry and special entry,
- * driver can alias (ie use same value for error and special for instance). It
- * should not alias none and error or special.
+ * Driver provides values for none entry, error entry, and special entry.
+ * Driver can alias (i.e., use same value) error and special, but
+ * it should not alias none with error or special.
  *
  * HMM pfn value returned by hmm_vma_get_pfns() or hmm_vma_fault() will be:
  * hmm_range.values[HMM_PFN_ERROR] if CPU page table entry is poisonous,
- * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table
+ * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table entry,
  * hmm_range.values[HMM_PFN_SPECIAL] if CPU page table entry is a special one
  */
 enum hmm_pfn_value_e {
@@ -158,6 +159,7 @@ enum hmm_pfn_value_e {
  * @values: pfn value for some special case (none, special, error, ...)
  * @default_flags: default flags for the range (write, read, ... see hmm doc)
  * @pfn_flags_mask: allows to mask pfn flags so that only default_flags matter
+ * @page_shift: device virtual address shift value (should be >= PAGE_SHIFT)
  * @pfn_shifts: pfn shift value (should be <= PAGE_SHIFT)
  * @valid: pfns array did not change since it has been fill by an HMM function
  */
@@ -180,7 +182,7 @@ struct hmm_range {
 /*
  * hmm_range_page_shift() - return the page shift for the range
  * @range: range being queried
- * Returns: page shift (page size = 1 << page shift) for the range
+ * Return: page shift (page size = 1 << page shift) for the range
  */
 static inline unsigned hmm_range_page_shift(const struct hmm_range *range)
 {
@@ -190,7 +192,7 @@ static inline unsigned hmm_range_page_shift(const struct hmm_range *range)
 /*
  * hmm_range_page_size() - return the page size for the range
  * @range: range being queried
- * Returns: page size for the range in bytes
+ * Return: page size for the range in bytes
  */
 static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
 {
@@ -201,7 +203,7 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
  * hmm_range_wait_until_valid() - wait for range to be valid
  * @range: range affected by invalidation to wait on
  * @timeout: time out for wait in ms (ie abort wait after that period of time)
- * Returns: true if the range is valid, false otherwise.
+ * Return: true if the range is valid, false otherwise.
  */
 static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
 					      unsigned long timeout)
@@ -222,7 +224,7 @@ static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
 /*
  * hmm_range_valid() - test if a range is valid or not
  * @range: range
- * Returns: true if the range is valid, false otherwise.
+ * Return: true if the range is valid, false otherwise.
  */
 static inline bool hmm_range_valid(struct hmm_range *range)
 {
@@ -233,7 +235,7 @@ static inline bool hmm_range_valid(struct hmm_range *range)
  * hmm_device_entry_to_page() - return struct page pointed to by a device entry
  * @range: range use to decode device entry value
  * @entry: device entry value to get corresponding struct page from
- * Returns: struct page pointer if entry is a valid, NULL otherwise
+ * Return: struct page pointer if entry is a valid, NULL otherwise
  *
  * If the device entry is valid (ie valid flag set) then return the struct page
  * matching the entry value. Otherwise return NULL.
@@ -256,7 +258,7 @@ static inline struct page *hmm_device_entry_to_page(const struct hmm_range *rang
  * hmm_device_entry_to_pfn() - return pfn value store in a device entry
  * @range: range use to decode device entry value
  * @entry: device entry to extract pfn from
- * Returns: pfn value if device entry is valid, -1UL otherwise
+ * Return: pfn value if device entry is valid, -1UL otherwise
  */
 static inline unsigned long
 hmm_device_entry_to_pfn(const struct hmm_range *range, uint64_t pfn)
@@ -276,7 +278,7 @@ hmm_device_entry_to_pfn(const struct hmm_range *range, uint64_t pfn)
  * hmm_device_entry_from_page() - create a valid device entry for a page
  * @range: range use to encode HMM pfn value
  * @page: page for which to create the device entry
- * Returns: valid device entry for the page
+ * Return: valid device entry for the page
  */
 static inline uint64_t hmm_device_entry_from_page(const struct hmm_range *range,
 						  struct page *page)
@@ -289,7 +291,7 @@ static inline uint64_t hmm_device_entry_from_page(const struct hmm_range *range,
  * hmm_device_entry_from_pfn() - create a valid device entry value from pfn
  * @range: range use to encode HMM pfn value
  * @pfn: pfn value for which to create the device entry
- * Returns: valid device entry for the pfn
+ * Return: valid device entry for the pfn
  */
 static inline uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
 						 unsigned long pfn)
@@ -394,7 +396,7 @@ enum hmm_update_event {
 };
 
 /*
- * struct hmm_update - HMM update informations for callback
+ * struct hmm_update - HMM update information for callback
  *
  * @start: virtual start address of the range to update
  * @end: virtual end address of the range to update
@@ -428,8 +430,8 @@ struct hmm_mirror_ops {
 	/* sync_cpu_device_pagetables() - synchronize page tables
 	 *
 	 * @mirror: pointer to struct hmm_mirror
-	 * @update: update informations (see struct hmm_update)
-	 * Returns: -EAGAIN if update.blockable false and callback need to
+	 * @update: update information (see struct hmm_update)
+	 * Return: -EAGAIN if update.blockable false and callback need to
 	 *          block, 0 otherwise.
 	 *
 	 * This callback ultimately originates from mmu_notifiers when the CPU
@@ -468,13 +470,13 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
 /*
  * hmm_mirror_mm_is_alive() - test if mm is still alive
  * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
- * Returns: false if the mm is dead, true otherwise
+ * Return: false if the mm is dead, true otherwise
  *
- * This is an optimization it will not accurately always return -EINVAL if the
- * mm is dead ie there can be false negative (process is being kill but HMM is
- * not yet inform of that). It is only intented to be use to optimize out case
- * where driver is about to do something time consuming and it would be better
- * to skip it if the mm is dead.
+ * This is an optimization, it will not always accurately return false if the
+ * mm is dead; i.e., there can be false negatives (process is being killed but
+ * HMM is not yet informed of that). It is only intended to be used to optimize
+ * out cases where the driver is about to do something time consuming and it
+ * would be better to skip it if the mm is dead.
  */
 static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
 {
@@ -489,7 +491,6 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
 	return true;
 }
 
-
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
@@ -562,7 +563,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 	ret = hmm_range_fault(range, block);
 	if (ret <= 0) {
 		if (ret == -EBUSY || !ret) {
-			/* Same as above  drop mmap_sem to match old API. */
+			/* Same as above, drop mmap_sem to match old API. */
 			up_read(&range->vma->vm_mm->mmap_sem);
 			ret = -EBUSY;
 		} else if (ret == -EAGAIN)
@@ -629,7 +630,7 @@ struct hmm_devmem_ops {
 	 * @page: pointer to struct page backing virtual address (unreliable)
 	 * @flags: FAULT_FLAG_* (see include/linux/mm.h)
 	 * @pmdp: page middle directory
-	 * Returns: VM_FAULT_MINOR/MAJOR on success or one of VM_FAULT_ERROR
+	 * Return: VM_FAULT_MINOR/MAJOR on success or one of VM_FAULT_ERROR
 	 *   on error
 	 *
 	 * The callback occurs whenever there is a CPU page fault or GUP on a
@@ -637,14 +638,14 @@ struct hmm_devmem_ops {
 	 * page back to regular memory (CPU accessible).
 	 *
 	 * The device driver is free to migrate more than one page from the
-	 * fault() callback as an optimization. However if device decide to
-	 * migrate more than one page it must always priotirize the faulting
+	 * fault() callback as an optimization. However if the device decides
+	 * to migrate more than one page it must always priotirize the faulting
 	 * address over the others.
 	 *
-	 * The struct page pointer is only given as an hint to allow quick
+	 * The struct page pointer is only given as a hint to allow quick
 	 * lookup of internal device driver data. A concurrent migration
-	 * might have already free that page and the virtual address might
-	 * not longer be back by it. So it should not be modified by the
+	 * might have already freed that page and the virtual address might
+	 * no longer be backed by it. So it should not be modified by the
 	 * callback.
 	 *
 	 * Note that mmap semaphore is held in read mode at least when this
@@ -671,7 +672,7 @@ struct hmm_devmem_ops {
  * @ref: per CPU refcount
  * @page_fault: callback when CPU fault on an unaddressable device page
  *
- * This an helper structure for device drivers that do not wish to implement
+ * This is a helper structure for device drivers that do not wish to implement
  * the gory details related to hotplugging new memoy and allocating struct
  * pages.
  *
diff --git a/mm/hmm.c b/mm/hmm.c
index c62ae414a3a2..4db5dcf110ba 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -153,9 +153,8 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 	/* Wake-up everyone waiting on any range. */
 	mutex_lock(&hmm->lock);
-	list_for_each_entry(range, &hmm->ranges, list) {
+	list_for_each_entry(range, &hmm->ranges, list)
 		range->valid = false;
-	}
 	wake_up_all(&hmm->wq);
 	mutex_unlock(&hmm->lock);
 
@@ -166,9 +165,10 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 		list_del_init(&mirror->list);
 		if (mirror->ops->release) {
 			/*
-			 * Drop mirrors_sem so callback can wait on any pending
-			 * work that might itself trigger mmu_notifier callback
-			 * and thus would deadlock with us.
+			 * Drop mirrors_sem so the release callback can wait
+			 * on any pending work that might itself trigger a
+			 * mmu_notifier callback and thus would deadlock with
+			 * us.
 			 */
 			up_write(&hmm->mirrors_sem);
 			mirror->ops->release(mirror);
@@ -223,11 +223,8 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
 		int ret;
 
 		ret = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
-		if (!update.blockable && ret == -EAGAIN) {
-			up_read(&hmm->mirrors_sem);
-			ret = -EAGAIN;
-			goto out;
-		}
+		if (!update.blockable && ret == -EAGAIN)
+			break;
 	}
 	up_read(&hmm->mirrors_sem);
 
@@ -271,6 +268,7 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  *
  * @mirror: new mirror struct to register
  * @mm: mm to register against
+ * Return: 0 on success, -ENOMEM if no memory, -EINVAL if invalid arguments
  *
  * To start mirroring a process address space, the device driver must register
  * an HMM mirror struct.
@@ -298,7 +296,7 @@ EXPORT_SYMBOL(hmm_mirror_register);
 /*
  * hmm_mirror_unregister() - unregister a mirror
  *
- * @mirror: new mirror struct to register
+ * @mirror: mirror struct to unregister
  *
  * Stop mirroring a process address space, and cleanup.
  */
@@ -372,7 +370,7 @@ static int hmm_pfns_bad(unsigned long addr,
  * @fault: should we fault or not ?
  * @write_fault: write fault ?
  * @walk: mm_walk structure
- * Returns: 0 on success, -EBUSY after page fault, or page fault error
+ * Return: 0 on success, -EBUSY after page fault, or page fault error
  *
  * This function will be called whenever pmd_none() or pte_none() returns true,
  * or whenever there is no page directory covering the virtual address range.
@@ -911,6 +909,7 @@ int hmm_range_register(struct hmm_range *range,
 		       unsigned page_shift)
 {
 	unsigned long mask = ((1UL << page_shift) - 1UL);
+	struct hmm *hmm;
 
 	range->valid = false;
 	range->hmm = NULL;
@@ -924,28 +923,29 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	range->hmm = hmm_get_or_create(mm);
-	if (!range->hmm)
+	hmm = hmm_get_or_create(mm);
+	if (!hmm)
 		return -EFAULT;
 
 	/* Check if hmm_mm_destroy() was call. */
-	if (range->hmm->mm == NULL || range->hmm->dead) {
-		hmm_put(range->hmm);
+	if (hmm->mm == NULL || hmm->dead) {
+		hmm_put(hmm);
 		return -EFAULT;
 	}
 
-	/* Initialize range to track CPU page table update */
-	mutex_lock(&range->hmm->lock);
+	/* Initialize range to track CPU page table updates. */
+	mutex_lock(&hmm->lock);
 
-	list_add_rcu(&range->list, &range->hmm->ranges);
+	range->hmm = hmm;
+	list_add_rcu(&range->list, &hmm->ranges);
 
 	/*
 	 * If there are any concurrent notifiers we have to wait for them for
 	 * the range to be valid (see hmm_range_wait_until_valid()).
 	 */
-	if (!range->hmm->notifiers)
+	if (!hmm->notifiers)
 		range->valid = true;
-	mutex_unlock(&range->hmm->lock);
+	mutex_unlock(&hmm->lock);
 
 	return 0;
 }
@@ -960,17 +960,19 @@ EXPORT_SYMBOL(hmm_range_register);
  */
 void hmm_range_unregister(struct hmm_range *range)
 {
+	struct hmm *hmm = range->hmm;
+
 	/* Sanity check this really should not happen. */
-	if (range->hmm == NULL || range->end <= range->start)
+	if (hmm == NULL || range->end <= range->start)
 		return;
 
-	mutex_lock(&range->hmm->lock);
+	mutex_lock(&hmm->lock);
 	list_del_rcu(&range->list);
-	mutex_unlock(&range->hmm->lock);
+	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
 	range->valid = false;
-	hmm_put(range->hmm);
+	hmm_put(hmm);
 	range->hmm = NULL;
 }
 EXPORT_SYMBOL(hmm_range_unregister);
@@ -978,7 +980,7 @@ EXPORT_SYMBOL(hmm_range_unregister);
 /*
  * hmm_range_snapshot() - snapshot CPU page table for a range
  * @range: range
- * Returns: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
+ * Return: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
  *          permission (for instance asking for write and range is read only),
  *          -EAGAIN if you need to retry, -EFAULT invalid (ie either no valid
  *          vma or it is illegal to access that range), number of valid pages
@@ -1061,7 +1063,7 @@ EXPORT_SYMBOL(hmm_range_snapshot);
  * hmm_range_fault() - try to fault some address in a virtual address range
  * @range: range being faulted
  * @block: allow blocking on fault (if true it sleeps and do not drop mmap_sem)
- * Returns: number of valid pages in range->pfns[] (from range start
+ * Return: number of valid pages in range->pfns[] (from range start
  *          address). This may be zero. If the return value is negative,
  *          then one of the following values may be returned:
  *
@@ -1179,7 +1181,7 @@ EXPORT_SYMBOL(hmm_range_fault);
  * @device: device against to dma map page to
  * @daddrs: dma address of mapped pages
  * @block: allow blocking on fault (if true it sleeps and do not drop mmap_sem)
- * Returns: number of pages mapped on success, -EAGAIN if mmap_sem have been
+ * Return: number of pages mapped on success, -EAGAIN if mmap_sem have been
  *          drop and you need to try again, some other error value otherwise
  *
  * Note same usage pattern as hmm_range_fault().
@@ -1267,7 +1269,7 @@ EXPORT_SYMBOL(hmm_range_dma_map);
  * @device: device against which dma map was done
  * @daddrs: dma address of mapped pages
  * @dirty: dirty page if it had the write flag set
- * Returns: number of page unmapped on success, -EINVAL otherwise
+ * Return: number of page unmapped on success, -EINVAL otherwise
  *
  * Note that caller MUST abide by mmu notifier or use HMM mirror and abide
  * to the sync_cpu_device_pagetables() callback so that it is safe here to
@@ -1390,7 +1392,7 @@ static void hmm_devmem_free(struct page *page, void *data)
  * @ops: memory event device driver callback (see struct hmm_devmem_ops)
  * @device: device struct to bind the resource too
  * @size: size in bytes of the device memory to add
- * Returns: pointer to new hmm_devmem struct ERR_PTR otherwise
+ * Return: pointer to new hmm_devmem struct ERR_PTR otherwise
  *
  * This function first finds an empty range of physical address big enough to
  * contain the new resource, and then hotplugs it as ZONE_DEVICE memory, which
-- 
2.20.1

