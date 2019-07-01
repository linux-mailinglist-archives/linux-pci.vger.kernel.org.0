Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F825B4A4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfGAGUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfGAGUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GQ0wrJNXbAJq1gRY5iZzVR0FeSnqpZ0BaS/GHX25AaQ=; b=CBNJCwWBuKcNk77kUO69PcGQ1
        Fheh1Z+Xg24DhzvfMYqb2TO4f/GG4nhDwLO7VQu9CEvGKgXc9Iarz3uGjEuwNm9iMuGA4FlQvH1Oo
        LRyfHTFjtQKUklxLT+cxULLxgolXL+gpMwXYokInRekIQfeVJkWt3mDWg+5h3p8Dz3zMYB34y29i9
        x6g99yheC7JYCmGOquEkZWhNa/DLBU8YNoDPEDn3G0RHJQIHoRzUtWKA/g2jW3tV3nMeO3fjYty7c
        RthViFgl2FtEjFelD5gOKsZWnlG8oS8UWscXtTCH+mQj3/45N3wwTH70/Lcv8yQnLb4aBEcFaBN7Q
        pIDQNX3kg==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpfu-0002t1-M3; Mon, 01 Jul 2019 06:20:27 +0000
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
Subject: [PATCH 02/22] mm/hmm: update HMM documentation
Date:   Mon,  1 Jul 2019 08:20:00 +0200
Message-Id: <20190701062020.19239-3-hch@lst.de>
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

Update the HMM documentation to reflect the latest API and make a few
minor wording changes.

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
 Documentation/vm/hmm.rst | 141 ++++++++++++++++++++-------------------
 include/linux/hmm.h      |   7 +-
 2 files changed, 78 insertions(+), 70 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 7cdf7282e022..7b6eeda5a7c0 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -10,7 +10,7 @@ of this being specialized struct page for such memory (see sections 5 to 7 of
 this document).
 
 HMM also provides optional helpers for SVM (Share Virtual Memory), i.e.,
-allowing a device to transparently access program address coherently with
+allowing a device to transparently access program addresses coherently with
 the CPU meaning that any valid pointer on the CPU is also a valid pointer
 for the device. This is becoming mandatory to simplify the use of advanced
 heterogeneous computing where GPU, DSP, or FPGA are used to perform various
@@ -22,8 +22,8 @@ expose the hardware limitations that are inherent to many platforms. The third
 section gives an overview of the HMM design. The fourth section explains how
 CPU page-table mirroring works and the purpose of HMM in this context. The
 fifth section deals with how device memory is represented inside the kernel.
-Finally, the last section presents a new migration helper that allows lever-
-aging the device DMA engine.
+Finally, the last section presents a new migration helper that allows
+leveraging the device DMA engine.
 
 .. contents:: :local:
 
@@ -39,20 +39,20 @@ address space. I use shared address space to refer to the opposite situation:
 i.e., one in which any application memory region can be used by a device
 transparently.
 
-Split address space happens because device can only access memory allocated
-through device specific API. This implies that all memory objects in a program
+Split address space happens because devices can only access memory allocated
+through a device specific API. This implies that all memory objects in a program
 are not equal from the device point of view which complicates large programs
 that rely on a wide set of libraries.
 
-Concretely this means that code that wants to leverage devices like GPUs needs
-to copy object between generically allocated memory (malloc, mmap private, mmap
+Concretely, this means that code that wants to leverage devices like GPUs needs
+to copy objects between generically allocated memory (malloc, mmap private, mmap
 share) and memory allocated through the device driver API (this still ends up
 with an mmap but of the device file).
 
 For flat data sets (array, grid, image, ...) this isn't too hard to achieve but
-complex data sets (list, tree, ...) are hard to get right. Duplicating a
+for complex data sets (list, tree, ...) it's hard to get right. Duplicating a
 complex data set needs to re-map all the pointer relations between each of its
-elements. This is error prone and program gets harder to debug because of the
+elements. This is error prone and programs get harder to debug because of the
 duplicate data set and addresses.
 
 Split address space also means that libraries cannot transparently use data
@@ -77,12 +77,12 @@ I/O bus, device memory characteristics
 
 I/O buses cripple shared address spaces due to a few limitations. Most I/O
 buses only allow basic memory access from device to main memory; even cache
-coherency is often optional. Access to device memory from CPU is even more
+coherency is often optional. Access to device memory from a CPU is even more
 limited. More often than not, it is not cache coherent.
 
 If we only consider the PCIE bus, then a device can access main memory (often
 through an IOMMU) and be cache coherent with the CPUs. However, it only allows
-a limited set of atomic operations from device on main memory. This is worse
+a limited set of atomic operations from the device on main memory. This is worse
 in the other direction: the CPU can only access a limited range of the device
 memory and cannot perform atomic operations on it. Thus device memory cannot
 be considered the same as regular memory from the kernel point of view.
@@ -93,20 +93,20 @@ The final limitation is latency. Access to main memory from the device has an
 order of magnitude higher latency than when the device accesses its own memory.
 
 Some platforms are developing new I/O buses or additions/modifications to PCIE
-to address some of these limitations (OpenCAPI, CCIX). They mainly allow two-
-way cache coherency between CPU and device and allow all atomic operations the
+to address some of these limitations (OpenCAPI, CCIX). They mainly allow
+two-way cache coherency between CPU and device and allow all atomic operations the
 architecture supports. Sadly, not all platforms are following this trend and
 some major architectures are left without hardware solutions to these problems.
 
 So for shared address space to make sense, not only must we allow devices to
 access any memory but we must also permit any memory to be migrated to device
-memory while device is using it (blocking CPU access while it happens).
+memory while the device is using it (blocking CPU access while it happens).
 
 
 Shared address space and migration
 ==================================
 
-HMM intends to provide two main features. First one is to share the address
+HMM intends to provide two main features. The first one is to share the address
 space by duplicating the CPU page table in the device page table so the same
 address points to the same physical memory for any valid main memory address in
 the process address space.
@@ -121,14 +121,14 @@ why HMM provides helpers to factor out everything that can be while leaving the
 hardware specific details to the device driver.
 
 The second mechanism HMM provides is a new kind of ZONE_DEVICE memory that
-allows allocating a struct page for each page of the device memory. Those pages
+allows allocating a struct page for each page of device memory. Those pages
 are special because the CPU cannot map them. However, they allow migrating
 main memory to device memory using existing migration mechanisms and everything
-looks like a page is swapped out to disk from the CPU point of view. Using a
-struct page gives the easiest and cleanest integration with existing mm mech-
-anisms. Here again, HMM only provides helpers, first to hotplug new ZONE_DEVICE
+looks like a page that is swapped out to disk from the CPU point of view. Using a
+struct page gives the easiest and cleanest integration with existing mm
+mechanisms. Here again, HMM only provides helpers, first to hotplug new ZONE_DEVICE
 memory for the device memory and second to perform migration. Policy decisions
-of what and when to migrate things is left to the device driver.
+of what and when to migrate is left to the device driver.
 
 Note that any CPU access to a device page triggers a page fault and a migration
 back to main memory. For example, when a page backing a given CPU address A is
@@ -136,8 +136,8 @@ migrated from a main memory page to a device page, then any CPU access to
 address A triggers a page fault and initiates a migration back to main memory.
 
 With these two features, HMM not only allows a device to mirror process address
-space and keeping both CPU and device page table synchronized, but also lever-
-ages device memory by migrating the part of the data set that is actively being
+space and keeps both CPU and device page tables synchronized, but also
+leverages device memory by migrating the part of the data set that is actively being
 used by the device.
 
 
@@ -151,21 +151,28 @@ registration of an hmm_mirror struct::
 
  int hmm_mirror_register(struct hmm_mirror *mirror,
                          struct mm_struct *mm);
- int hmm_mirror_register_locked(struct hmm_mirror *mirror,
-                                struct mm_struct *mm);
 
-
-The locked variant is to be used when the driver is already holding mmap_sem
-of the mm in write mode. The mirror struct has a set of callbacks that are used
+The mirror struct has a set of callbacks that are used
 to propagate CPU page tables::
 
  struct hmm_mirror_ops {
+     /* release() - release hmm_mirror
+      *
+      * @mirror: pointer to struct hmm_mirror
+      *
+      * This is called when the mm_struct is being released.  The callback
+      * must ensure that all access to any pages obtained from this mirror
+      * is halted before the callback returns. All future access should
+      * fault.
+      */
+     void (*release)(struct hmm_mirror *mirror);
+
      /* sync_cpu_device_pagetables() - synchronize page tables
       *
       * @mirror: pointer to struct hmm_mirror
-      * @update_type: type of update that occurred to the CPU page table
-      * @start: virtual start address of the range to update
-      * @end: virtual end address of the range to update
+      * @update: update information (see struct mmu_notifier_range)
+      * Return: -EAGAIN if update.blockable false and callback need to
+      *         block, 0 otherwise.
       *
       * This callback ultimately originates from mmu_notifiers when the CPU
       * page table is updated. The device driver must update its page table
@@ -176,14 +183,12 @@ to propagate CPU page tables::
       * page tables are completely updated (TLBs flushed, etc); this is a
       * synchronous call.
       */
-      void (*update)(struct hmm_mirror *mirror,
-                     enum hmm_update action,
-                     unsigned long start,
-                     unsigned long end);
+     int (*sync_cpu_device_pagetables)(struct hmm_mirror *mirror,
+                                       const struct hmm_update *update);
  };
 
 The device driver must perform the update action to the range (mark range
-read only, or fully unmap, ...). The device must be done with the update before
+read only, or fully unmap, etc.). The device must complete the update before
 the driver callback returns.
 
 When the device driver wants to populate a range of virtual addresses, it can
@@ -194,17 +199,18 @@ use either::
 
 The first one (hmm_range_snapshot()) will only fetch present CPU page table
 entries and will not trigger a page fault on missing or non-present entries.
-The second one does trigger a page fault on missing or read-only entry if the
-write parameter is true. Page faults use the generic mm page fault code path
-just like a CPU page fault.
+The second one does trigger a page fault on missing or read-only entries if
+write access is requested (see below). Page faults use the generic mm page
+fault code path just like a CPU page fault.
 
 Both functions copy CPU page table entries into their pfns array argument. Each
 entry in that array corresponds to an address in the virtual range. HMM
 provides a set of flags to help the driver identify special CPU page table
 entries.
 
-Locking with the update() callback is the most important aspect the driver must
-respect in order to keep things properly synchronized. The usage pattern is::
+Locking within the sync_cpu_device_pagetables() callback is the most important
+aspect the driver must respect in order to keep things properly synchronized.
+The usage pattern is::
 
  int driver_populate_range(...)
  {
@@ -239,11 +245,11 @@ respect in order to keep things properly synchronized. The usage pattern is::
             hmm_range_wait_until_valid(&range, TIMEOUT_IN_MSEC);
             goto again;
           }
-          hmm_mirror_unregister(&range);
+          hmm_range_unregister(&range);
           return ret;
       }
       take_lock(driver->update);
-      if (!range.valid) {
+      if (!hmm_range_valid(&range)) {
           release_lock(driver->update);
           up_read(&mm->mmap_sem);
           goto again;
@@ -251,15 +257,15 @@ respect in order to keep things properly synchronized. The usage pattern is::
 
       // Use pfns array content to update device page table
 
-      hmm_mirror_unregister(&range);
+      hmm_range_unregister(&range);
       release_lock(driver->update);
       up_read(&mm->mmap_sem);
       return 0;
  }
 
 The driver->update lock is the same lock that the driver takes inside its
-update() callback. That lock must be held before checking the range.valid
-field to avoid any race with a concurrent CPU page table update.
+sync_cpu_device_pagetables() callback. That lock must be held before calling
+hmm_range_valid() to avoid any race with a concurrent CPU page table update.
 
 HMM implements all this on top of the mmu_notifier API because we wanted a
 simpler API and also to be able to perform optimizations latter on like doing
@@ -279,46 +285,47 @@ concurrently).
 Leverage default_flags and pfn_flags_mask
 =========================================
 
-The hmm_range struct has 2 fields default_flags and pfn_flags_mask that allows
-to set fault or snapshot policy for a whole range instead of having to set them
-for each entries in the range.
+The hmm_range struct has 2 fields, default_flags and pfn_flags_mask, that specify
+fault or snapshot policy for the whole range instead of having to set them
+for each entry in the pfns array.
+
+For instance, if the device flags for range.flags are::
 
-For instance if the device flags for device entries are:
-    VALID (1 << 63)
-    WRITE (1 << 62)
+    range.flags[HMM_PFN_VALID] = (1 << 63);
+    range.flags[HMM_PFN_WRITE] = (1 << 62);
 
-Now let say that device driver wants to fault with at least read a range then
-it does set::
+and the device driver wants pages for a range with at least read permission,
+it sets::
 
     range->default_flags = (1 << 63);
     range->pfn_flags_mask = 0;
 
-and calls hmm_range_fault() as described above. This will fill fault all page
+and calls hmm_range_fault() as described above. This will fill fault all pages
 in the range with at least read permission.
 
-Now let say driver wants to do the same except for one page in the range for
-which its want to have write. Now driver set::
+Now let's say the driver wants to do the same except for one page in the range for
+which it wants to have write permission. Now driver set::
 
     range->default_flags = (1 << 63);
     range->pfn_flags_mask = (1 << 62);
     range->pfns[index_of_write] = (1 << 62);
 
-With this HMM will fault in all page with at least read (ie valid) and for the
+With this, HMM will fault in all pages with at least read (i.e., valid) and for the
 address == range->start + (index_of_write << PAGE_SHIFT) it will fault with
-write permission ie if the CPU pte does not have write permission set then HMM
+write permission i.e., if the CPU pte does not have write permission set then HMM
 will call handle_mm_fault().
 
-Note that HMM will populate the pfns array with write permission for any entry
-that have write permission within the CPU pte no matter what are the values set
+Note that HMM will populate the pfns array with write permission for any page
+that is mapped with CPU write permission no matter what values are set
 in default_flags or pfn_flags_mask.
 
 
 Represent and manage device memory from core kernel point of view
 =================================================================
 
-Several different designs were tried to support device memory. First one used
-a device specific data structure to keep information about migrated memory and
-HMM hooked itself in various places of mm code to handle any access to
+Several different designs were tried to support device memory. The first one
+used a device specific data structure to keep information about migrated memory
+and HMM hooked itself in various places of mm code to handle any access to
 addresses that were backed by device memory. It turns out that this ended up
 replicating most of the fields of struct page and also needed many kernel code
 paths to be updated to understand this new kind of memory.
@@ -341,7 +348,7 @@ The hmm_devmem_ops is where most of the important things are::
 
  struct hmm_devmem_ops {
      void (*free)(struct hmm_devmem *devmem, struct page *page);
-     int (*fault)(struct hmm_devmem *devmem,
+     vm_fault_t (*fault)(struct hmm_devmem *devmem,
                   struct vm_area_struct *vma,
                   unsigned long addr,
                   struct page *page,
@@ -417,9 +424,9 @@ willing to pay to keep all the code simpler.
 Memory cgroup (memcg) and rss accounting
 ========================================
 
-For now device memory is accounted as any regular page in rss counters (either
+For now, device memory is accounted as any regular page in rss counters (either
 anonymous if device page is used for anonymous, file if device page is used for
-file backed page or shmem if device page is used for shared memory). This is a
+file backed page, or shmem if device page is used for shared memory). This is a
 deliberate choice to keep existing applications, that might start using device
 memory without knowing about it, running unimpacted.
 
@@ -439,6 +446,6 @@ get more experience in how device memory is used and its impact on memory
 resource control.
 
 
-Note that device memory can never be pinned by device driver nor through GUP
+Note that device memory can never be pinned by a device driver nor through GUP
 and thus such memory is always free upon process exit. Or when last reference
 is dropped in case of shared memory or file backed memory.
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 044a36d7c3f8..740bb00853f5 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -418,9 +418,10 @@ struct hmm_mirror_ops {
 	 *
 	 * @mirror: pointer to struct hmm_mirror
 	 *
-	 * This is called when the mm_struct is being released.
-	 * The callback should make sure no references to the mirror occur
-	 * after the callback returns.
+	 * This is called when the mm_struct is being released.  The callback
+	 * must ensure that all access to any pages obtained from this mirror
+	 * is halted before the callback returns. All future access should
+	 * fault.
 	 */
 	void (*release)(struct hmm_mirror *mirror);
 
-- 
2.20.1

