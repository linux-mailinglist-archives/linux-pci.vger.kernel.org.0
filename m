Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3357CE63
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiGUO7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiGUO7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:59:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71905F7A;
        Thu, 21 Jul 2022 07:59:12 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LpbJd6zy9z67dbJ;
        Thu, 21 Jul 2022 22:57:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 16:59:10 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Jul
 2022 15:59:09 +0100
Date:   Thu, 21 Jul 2022 15:59:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/28] CXL PMEM Region Provisioning
Message-ID: <20220721155907.0000708c@huawei.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 17:00:41 -0700
Dan Williams <dan.j.williams@intel.com> wrote:


Hi Dan,

I'm low on time unfortunately and will be OoO for next week,
But whilst fixing a bug in QEMU, I set up a test to exercise
the high port target register on the hb with

CFMWS interleave ways = 1
hb with 8 rp with a type3 device connected to each.

The resulting interleave granularity isn't what I'd expect to see.
Setting region interleave to 1k (which happens to match the CFMWS)
I'm getting 1k for the CFMWS, 2k for the hb and 256 bytes for the type3
devices.  Which is crazy...  Now there may be another bug lurking
in QEMU so this might not be a kernel issue at all.

For this special case we should be ignoring the CFMWS IG
as it's irrelevant if we aren't interleaving at that level.
We also know we don't have any address bits used for interleave
decoding until the HB.

Thanks,

Jonathan


> Changes since v1 [1]:
> - Move 19 patches that have received a Reviewed-by to the 'pending'
>   branch in cxl.git (Thanks Alison, Adam, and Jonathan!)
> - Improve the changelog and add more Cc's to "cxl/acpi: Track CXL
>   resources in iomem_resource" and highlight the new export of
>   insert_resource_expand_to_fit()
> - Switch all occurrences of the pattern "rc = -ECODE; if (condition)
>   goto err;" to "if (condition) { rc = -ECODE; goto err; }" (Jonathan)
> - Re-organize all the cxl_{root,switch,endpoint}_decoder() patches to
>   move the decoder-type-specific setup into the decoder-type-specific
>   allocation routines (Jonathan)
> - Add kdoc to clarify the behavior of add_cxl_resources() (Jonathan)
> - Add IORES_DESC_CXL for kernel components like EDAC to determine when
>   they might be dealing with a CXL address range (Tony)
> - Drop usage of dev_set_drvdata() for passing @cxl_res (Jonathan)
> - Drop @remove_action argument to __cxl_dpa_release(), make it behave
>   like any other devm_<free> helper (Jonathan)
> - Clarify 'skip' vs 'skipped' in DPA handling helpers (Jonathan)
> - Clarify why port teardown no proceeds under the lock with the
>   conversion from list to xarray (Jonathan)
> - Revert rename of cxl_find_dport_by_dev() (Jonathan)
> - Fold down_read() / up_write() mismatch fix to the patch that
>   introduced the problem (Jonathan)
> - Fix description of interleave_ways and interleave_granularity in the
>   sysfs ABI document
> - Clarify tangential cleanups in "resource: Introduce
>   alloc_free_mem_region()" (Jonathan)
> - Clarify rationale for the region creation / naming ABI (Jonathan)
> - Add SET_CXL_REGION_ATTR() to supplement CXL_REGION_ATTR() the former
>   is used to optionally added region attributes to an attribute list
>   (position independent) and the latter is used to retrieve a pointer to
>   the attribute in code.  (Jonathan)
> - For writes to region attributes allow the same value to be written
>   multiple times without error (Jonathan)
> - Clarify the actions performed by cxl_port_attach_region() (Jonathan)
> - Commit message spelling fixes (Alison and Jonathan)
> - Rename cxl_dpa_resource() => cxl_dpa_resource_start() (Jonathan)
> - Reword error message in cxl_parse_cfmws() (Adam)
> - Keep @expected_len signed in cxl_acpi_cfmws_verify() (Jonathan)
> - Miscellaneous formatting and doc fixes (Jonathan)
> - Rename port->dpa_end port->hdm_end (Jonathan)
> - Rename unregister_region() => unregister_nvdimm_region() (Jonathan)
> 
> [1]: https://lore.kernel.org/linux-cxl/165603869943.551046.3498980330327696732.stgit@dwillia2-xfh
> 
> ---
> 
> Until the CXL 2.0 definition arrived there was little reason for OS
> drivers to care about CXL memory expanders. Similar to DDR they just
> implemented a physical address range that was described to the OS by
> platform firmware (EFI Memory Map + ACPI SRAT/SLIT/HMAT etc). The CXL
> 2.0 definition adds support for PMEM, hotplug, switch topologies, and
> device-interleaving which exceeds the limits of what can be reasonably
> abstracted by EFI + ACPI mechanisms. As a result, Linux needs a native
> capability to provision new CXL regions.
> 
> The term "region" is the same term that originated in the LIBNVDIMM
> implementation to describe a host physical / system physical address
> range. For PMEM a region is a persistent memory range that can be
> further sub-divided into namespaces. For CXL there are three
> classifications of regions:
> - PMEM: set up by CXL native tooling and persisted in CXL region labels
> 
> - RAM: set up dynamically by CXL native tooling after hotplug events, or
>   leftover capacity not mapped by platform firmware. Any persistent
>   configuration would come from set up scripts / configuration files in
>   userspace.
> 
> - System RAM: set up by platform firmware and described by EFI + ACPI
>   metadata, these regions are static.
> 
> For now, these patches implement just PMEM regions without region label
> support. Note though that the infrastructure routines like
> cxl_region_attach() and cxl_region_setup_targets() are building blocks
> for region-label support, provisioning RAM regions, and enumerating
> System RAM regions.
> 
> The general flow for provisioning a CXL region is to:
> - Find a device or set of devices with available device-physical-address
>   (DPA) capacity
> 
> - Find a platform CXL window that has free capacity to map a new region
>   and that is able to target the devices in the previous step.
> 
> - Allocate DPA according to the CXL specification rules of sequential
>   enabling of decoders by id and when a device hosts multiple decoders
>   make sure that lower-id decoders map lower HPA and higher-id decoders
>   map higher HPA.
> 
> - Assign endpoint decoders to a region and validate that the switching
>   topology supports the requested configuration. Recall that
>   interleaving is governed by modulo or xormap math that constrains which
>   device can support which positions in a given region interleave.
> 
> - Program all the decoders an all endpoints and participating switches
>   to bring the new address range online.
> 
> Once the range is online then existing drivers like LIBNVDIMM or
> device-dax can manage the memory range as if the ACPI BIOS had conveyed
> its parameters at boot.
> 
> This patch kit is the result of significant amounts of path finding work
> [2] and long discussions with Ben. Thank you Ben for all that work!
> Where the patches in this kit go in a different design direction than
> the RFC, the authorship is changed and a Co-developed-by is added mainly
> so I get blamed for the bad decisions and not Ben. The major updates
> from that last posting are:
> 
> - all CXL resources are reflected in full in iomem_resource
> 
> - host-physical-address (HPA) range allocation moves to a
>   devm_request_free_mem_region() derivative
> 
> - locking moves to two global rwsems, one for DPA / endpoint decoders
>   and one for HPA / regions.
> 
> - the existing port scanning path is augmented to cache more topology
>   information rather than recreate it at region creation time
> 
> [2]: https://lore.kernel.org/r/20220413183720.2444089-1-ben.widawsky@intel.com
> 
> ---
> 
> Ben Widawsky (4):
>       cxl/hdm: Add sysfs attributes for interleave ways + granularity
>       cxl/region: Add region creation support
>       cxl/region: Add a 'uuid' attribute
>       cxl/region: Add interleave geometry attributes
> 
> Dan Williams (24):
>       Documentation/cxl: Use a double line break between entries
>       cxl/core: Define a 'struct cxl_switch_decoder'
>       cxl/acpi: Track CXL resources in iomem_resource
>       cxl/core: Define a 'struct cxl_root_decoder'
>       cxl/core: Define a 'struct cxl_endpoint_decoder'
>       cxl/hdm: Enumerate allocated DPA
>       cxl/hdm: Add 'mode' attribute to decoder objects
>       cxl/hdm: Track next decoder to allocate
>       cxl/hdm: Add support for allocating DPA to an endpoint decoder
>       cxl/port: Record dport in endpoint references
>       cxl/port: Record parent dport when adding ports
>       cxl/port: Move 'cxl_ep' references to an xarray per port
>       cxl/port: Move dport tracking to an xarray
>       cxl/mem: Enumerate port targets before adding endpoints
>       resource: Introduce alloc_free_mem_region()
>       cxl/region: Allocate HPA capacity to regions
>       cxl/region: Enable the assignment of endpoint decoders to regions
>       cxl/acpi: Add a host-bridge index lookup mechanism
>       cxl/region: Attach endpoint decoders
>       cxl/region: Program target lists
>       cxl/hdm: Commit decoder state to hardware
>       cxl/region: Add region driver boiler plate
>       cxl/pmem: Fix offline_nvdimm_bus() to offline by bridge
>       cxl/region: Introduce cxl_pmem_region objects
> 
> 
>  Documentation/ABI/testing/sysfs-bus-cxl         |  213 +++
>  Documentation/driver-api/cxl/memory-devices.rst |   11 
>  drivers/cxl/Kconfig                             |    8 
>  drivers/cxl/acpi.c                              |  185 ++
>  drivers/cxl/core/Makefile                       |    1 
>  drivers/cxl/core/core.h                         |   49 +
>  drivers/cxl/core/hdm.c                          |  623 +++++++-
>  drivers/cxl/core/pmem.c                         |    4 
>  drivers/cxl/core/port.c                         |  669 ++++++--
>  drivers/cxl/core/region.c                       | 1830 +++++++++++++++++++++++
>  drivers/cxl/cxl.h                               |  263 +++
>  drivers/cxl/cxlmem.h                            |   18 
>  drivers/cxl/mem.c                               |   32 
>  drivers/cxl/pmem.c                              |  259 +++
>  drivers/nvdimm/region_devs.c                    |   28 
>  include/linux/ioport.h                          |    3 
>  include/linux/libnvdimm.h                       |    5 
>  kernel/resource.c                               |  185 ++
>  mm/Kconfig                                      |    5 
>  tools/testing/cxl/Kbuild                        |    1 
>  tools/testing/cxl/test/cxl.c                    |   75 +
>  21 files changed, 4156 insertions(+), 311 deletions(-)
>  create mode 100644 drivers/cxl/core/region.c
> 
> base-commit: b060edfd8cdd52bc8648392500bf152a8dd6d4c5

