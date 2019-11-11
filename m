Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B207BF8134
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfKKU2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 15:28:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36890 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKKU17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 15:27:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so5731801ljl.4
        for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2019 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Cok4vuNrWMa9ObCC+g9TLuz/pn7nRlm4dRmGnb/5UnA=;
        b=KB9G51SeKxW4lLuyyEP3NEhJgN6dsnOoWByBVy+iOzw6oAKSFoLwRAtMuDDd13pPTQ
         wjZEbyAdyDH31O7U7+iwNlfwTP0GmWu59d4zqZQkGlMH3goNc5s5pQXB+QFYNr+Pmv1a
         +XrTz4/O0Vuoa5KuhLvCJZW/CySl+Cl7j8lKyb07PYXm0MrdBbVXtiPrQHDSPTpoIjJN
         /lfDcZ0Td5DJg7c/Jl378DB6F6EN2JKdf1T/SSq2ROfBu3bjzfIJd+c9f4ONKXZ4yhAZ
         GjIfjfu1A6ciGb1mKmMJM5JqNTvUMt+OrbOI7WOtfHSKFE+7JE87W+22lry+wGR5nX+e
         im3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Cok4vuNrWMa9ObCC+g9TLuz/pn7nRlm4dRmGnb/5UnA=;
        b=WRBDaY5WcJDXRaGK+f1KcHRFRklcdzbubO9jB0/l3VGmiBz+vw7uckvzV3UTePYA+7
         U649Scy/17/9IpJW+z6rWJnoz++Vy75ux3sUa0VAwZbmpIdnl0FUKEcfmvleN4lUrlat
         +upOfxdIk+MEl15A62FHcoqYSgPqlWtZkZlPJjmw0xsAXj5FaK9jLSCppLPwtW1hiSQq
         EZhGdQw48ynhm0pYsojdXihAtz5OUjDaPszxtj6PsQkYoMMoz/+16qtm6wyGAx0oTlid
         f3LAEal1JaxAZiNnRNEs5K8+GEMChQ5EHLSh+rKvHuU9LgWZMct55ourREH1syhdBdZP
         4UxQ==
X-Gm-Message-State: APjAAAV1nHg9uONeQkMpD5aS5NufqixHovgff1eF+053nYVV119kOKRP
        gu9iM6apYQnghc+G8Rp0+F5kCaniNPwY/0ky//d4rQ==
X-Google-Smtp-Source: APXvYqxD4n8vStPPmwNYgpU3TJsuvVE+pZhZ+FOxAdmCNWMCvJy6EVgzQcsjCK5Z3EoigFVFCJgcl5pVXSiMjGnllPs=
X-Received: by 2002:a2e:9449:: with SMTP id o9mr5930678ljh.75.1573504069780;
 Mon, 11 Nov 2019 12:27:49 -0800 (PST)
MIME-Version: 1.0
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 11 Nov 2019 12:27:38 -0800
Message-ID: <CABEDWGyow+OeNgXXUtVekr6hrXAVuH45GXCQGxNGv3q5nGs3qA@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-nvme@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 9:38 AM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> From: Alan Mikhak <alan.mikhak@sifive.com>
>
> Add a Linux PCI Endpoint Framework function driver to bring-up a
> NVMe endpoint device over the PCIe bus. NVMe endpoint function
> driver runs on a PCIe endpoint device and connects to an x86_64
> or other root-complex host across the PCIe bus. On the endpoint
> device side, the NVMe endpoint function driver connects to the
> unmodified Linux NVMe target driver running on the embedded CPU.
> The Linux NVMe target operates a NVMe namespace suitable for
> the application. For example, Linux NVMe target code can be
> configured to operate a file-based namespace which is backed
> by the loop device. The application may be expanded in the
> future to operate on non-volatile storage such as flash or
> battery-backed RAM.
>
> With its current implementation, I am able to mount such a NVMe
> namespace from a x86_64 Debian Linux host across PCIe using the
> Disks App and perform Partition Benchmarking. I am also able to
> save and load files on NVMe namespace partition nvme0n1p1 using
> the Debian Files app. One such possible example usage is to store
> and load trace files for debugging NVMe endpoint devices from
> the host side with KernelShark.
>
> This RFC patch presents an implementation that is still work in
> progress. It is not stable yet for reliable use or upstream
> submission. It is stable enough for me to see it work from a
> Debian host desktop to capture screenshots of NVMe partition
> benchmarking, formatting, mounting, file storage and retrieval
> activity such as I mentioned.
>
> A design goal is to not modify the Linux NVMe target driver
> at all. The NVMe endpoint function driver should implement the
> functionality that is required for the scope of its application
> in order to interface with Linux NVMe target driver. It maps
> NVMe Physical Region Pages (PRP) and PRP Lists from the host,
> formats a scatterlist that NVMe target driver can consume, and
> executes the NVMe command with the scatterlist on the NVMe target
> controller on behalf of the host. The NVMe target controller can
> therefore read and write directly to host buffers using the
> scatterlist as it does if the scatterlist had arrived over an
> NVMe fabric.
>
> NVMe endpoint function driver currently creates the admin ACQ and
> ASQ on startup. When the NVMe host connects over PCIe, NVMe
> endpoint function driver handles the Create/Delete SQ/CQ commands
> and any other commands that cannot go to the NVMe target on behalf
> of the host. For example, it creates a pair of I/O CQ and SQ as
> requested by the Linux host kernel nvme.ko driver. The NVMe endpoint
> function driver supports Controller Memory Buffer (CMB). The I/O SQ
> is therefore located in CMB as requested by host nvme.ko.
>
> An n:1 relationship between SQs and CQs has not been implemented
> yet since no such request was made so far from the Linux host
> nvme.ko. It needs to be implemented at some point. Feedback
> received elsewhere indicates this is desirable.
>
> NVMe endpoint function driver needs to map PRP that sit across
> the PCIe bus anywhere in host memory. PRPs are typically 4KB pages
> which may be scattered throughout host memory. The PCIe address
> space of NVMe endpoint is larger than its local physical memory
> space or that of the host system. PCIe address space of an NVMe
> endpoint needs to address much larger regions than physical memory
> populated on either side of the PCIe bus. The NVMe endpoint device
> must be prepared to be plugged into other hosts with differing
> memory arrangements over its lifetime.
>
> NVMe endpoint function driver access to host PRPs is not BAR-based.
> NVMe endpoint accesses host memory as PCIe bus master. PCIe hosts,
> on the other hand, typically access endpoint memory using BARs.
>
> Finding an economical solution for page struct backing for a large
> PCIe address space, which is not itself backed by physical memory,
> is desirable. Page structs are a requirement for using scatterlists.
> Since scatterlists are the mechanism that Linux NVMe target driver
> uses, the NVMe endpoint function driver needs to convert PRPs to
> scatterlist using mappings that have proper page struct backing.
> As suggested by Christoph Hellwig elsewhere, devm_memremap_pages()
> may be a solution if the kernel supports ZONE_DEVICE.
>
> I submit this RFC patch to request early review comments and
> feedback. This implementation is not in a polished state yet.
> I hope to receive early feedback to improve it. I look forward
> to and appreciate your responses.
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/Kconfig         |   10 +
>  drivers/pci/endpoint/functions/Makefile        |    1 +
>  drivers/pci/endpoint/functions/pci-epf-debug.h |   59 +
>  drivers/pci/endpoint/functions/pci-epf-map.h   |  151 ++
>  drivers/pci/endpoint/functions/pci-epf-nvme.c  | 1880 ++++++++++++++++++++++++
>  5 files changed, 2101 insertions(+)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-debug.h
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-map.h
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
>
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 8820d0f7ec77..35c2570f97ac 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -12,3 +12,13 @@ config PCI_EPF_TEST
>            for PCI Endpoint.
>
>            If in doubt, say "N" to disable Endpoint test driver.
> +
> +config PCI_EPF_NVME
> +       tristate "PCI Endpoint NVMe function driver"
> +       depends on PCI_ENDPOINT
> +       select CRC32
> +       help
> +          Enable this configuration option to enable the NVMe function
> +          driver for PCI Endpoint.
> +
> +          If in doubt, say "N" to disable Endpoint NVMe function driver.
> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
> index d6fafff080e2..e8a60f0fcfa1 100644
> --- a/drivers/pci/endpoint/functions/Makefile
> +++ b/drivers/pci/endpoint/functions/Makefile
> @@ -4,3 +4,4 @@
>  #
>
>  obj-$(CONFIG_PCI_EPF_TEST)             += pci-epf-test.o
> +obj-$(CONFIG_PCI_EPF_NVME)             += pci-epf-nvme.o
> diff --git a/drivers/pci/endpoint/functions/pci-epf-debug.h b/drivers/pci/endpoint/functions/pci-epf-debug.h
> new file mode 100644
> index 000000000000..8fbd31b017fc
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-debug.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * Debug functions header file for
> + * PCI Endpoint Function (EPF) drivers.
> + *
> + * Copyright (C) 2019 SiFive
> + */
> +
> +#ifndef _PCI_EPF_DEBUG_H
> +#define _PCI_EPF_DEBUG_H
> +
> +static bool pci_epf_debug;
> +
> +static __always_inline bool pci_epf_debug_is_enabled(void)
> +{
> +       return pci_epf_debug;
> +}
> +
> +static __always_inline bool pci_epf_debug_enable(void)
> +{
> +       if (pci_epf_debug)
> +               return true;
> +
> +       pci_epf_debug = true;
> +       return false;
> +}
> +
> +static __always_inline bool pci_epf_debug_disable(void)
> +{
> +       if (!pci_epf_debug)
> +               return false;
> +
> +       pci_epf_debug = false;
> +       return true;
> +}
> +
> +static __always_inline void pci_epf_debug_print(const char *text)
> +{
> +       if (pci_epf_debug && text)
> +               pr_info("%s\n", text);
> +}
> +
> +static void pci_epf_debug_dump(void *data, size_t size, const char *label)
> +{
> +       if (pci_epf_debug && data && size) {
> +               unsigned char *p = (unsigned char *)data;
> +
> +               if (label)
> +                       pr_info("%s:\n", label);
> +               while (size >= 8) {
> +                       pr_info("%02x %02x %02x %02x %02x %02x %02x %02x\n",
> +                               p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
> +                       p += 8;
> +                       size -= 8;
> +               }
> +       }
> +}
> +
> +#endif /* _PCI_EPF_DEBUG_H */
> diff --git a/drivers/pci/endpoint/functions/pci-epf-map.h b/drivers/pci/endpoint/functions/pci-epf-map.h
> new file mode 100644
> index 000000000000..09e54a45c69f
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-map.h
> @@ -0,0 +1,151 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * Map helper functions header file for
> + * PCI Endpoint Function (EPF) drivers.
> + *
> + * Copyright (C) 2019 SiFive
> + */
> +
> +#ifndef _PCI_EPF_MAP_H
> +#define _PCI_EPF_MAP_H
> +
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +
> +struct pci_epf_map {
> +       size_t size;
> +       size_t align;
> +       off_t offset;
> +       struct {
> +               u64 phys_addr;
> +               u64 phys_base;
> +               u64 phys_end;
> +       } host;
> +       struct {
> +               size_t size;
> +               void __iomem *virt_addr;
> +               void __iomem *virt_base;
> +               phys_addr_t phys_addr;
> +               phys_addr_t phys_base;
> +       } pci;
> +       struct pci_epf *epf;
> +};
> +
> +static int pci_epf_map_alloc_region(struct pci_epf_map *map,
> +                                   struct pci_epf *epf,
> +                                   const struct pci_epc_features *features)
> +{
> +       phys_addr_t phys_base;
> +       void __iomem *virt_base;
> +       size_t align, size;
> +
> +       if (map->pci.phys_base)
> +               return -EALREADY;
> +
> +       align = (features && features->align) ? features->align : PAGE_SIZE;
> +       size = (map->size < align) ? (align << 1) : map->size;
> +
> +       virt_base = pci_epc_mem_alloc_addr(epf->epc, &phys_base, size);
> +       if (!virt_base)
> +               return -ENOMEM;
> +
> +       map->epf = epf;
> +       map->align = align;
> +       map->pci.size = size;
> +       map->pci.virt_base = virt_base;
> +       map->pci.phys_base = phys_base;
> +       return 0;
> +}
> +
> +static __always_inline void pci_epf_map_free_region(struct pci_epf_map *map)
> +{
> +       if (map->pci.phys_base) {
> +               pci_epc_mem_free_addr(map->epf->epc,
> +                                     map->pci.phys_base,
> +                                     map->pci.virt_base,
> +                                     map->pci.size);
> +               map->pci.phys_base = 0;
> +       }
> +}
> +
> +static int pci_epf_map_enable(struct pci_epf_map *map)
> +{
> +       int ret;
> +
> +       if (!map->pci.phys_base)
> +               return -ENOMEM;
> +
> +       if (map->pci.phys_addr)
> +               return -EALREADY;
> +
> +       map->host.phys_base = map->host.phys_addr;
> +       if (map->align > PAGE_SIZE)
> +               map->host.phys_base &= ~(map->align-1);
> +
> +       map->host.phys_end = map->host.phys_base + map->pci.size - 1;
> +
> +       map->offset = map->host.phys_addr - map->host.phys_base;
> +       if (map->offset + map->size > map->pci.size)
> +               return -ERANGE;
> +
> +       ret = pci_epc_map_addr(map->epf->epc, map->epf->func_no,
> +                              map->pci.phys_base, map->host.phys_base,
> +                              map->pci.size);
> +       if (ret)
> +               return ret;
> +
> +       map->pci.virt_addr = map->pci.virt_base + map->offset;
> +       map->pci.phys_addr = map->pci.phys_base + map->offset;
> +       return 0;
> +}
> +
> +static __always_inline void pci_epf_map_disable(struct pci_epf_map *map)
> +{
> +       if (map->pci.phys_addr) {
> +               pci_epc_unmap_addr(map->epf->epc,
> +                                  map->epf->func_no,
> +                                  map->pci.phys_base);
> +               map->pci.phys_addr = 0;
> +       }
> +}
> +
> +static void pci_epf_unmap(struct pci_epf_map *map)
> +{
> +       pci_epf_map_disable(map);
> +       pci_epf_map_free_region(map);
> +       memset(map, 0, sizeof(*map));
> +}
> +
> +static int pci_epf_map(struct pci_epf_map *map,
> +                      struct pci_epf *epf,
> +                      const struct pci_epc_features *features)
> +{
> +       int ret;
> +
> +       ret = pci_epf_map_alloc_region(map, epf, features);
> +       if (ret) {
> +               dev_err(&epf->dev, "Failed to allocate address map\n");
> +               return ret;
> +       }
> +
> +       ret = pci_epf_map_enable(map);
> +       if (ret) {
> +               dev_err(&epf->dev, "Failed to enable address map\n");
> +               pci_epf_map_free_region(map);
> +       }
> +       return ret;
> +}
> +
> +static __always_inline int
> +pci_epf_map_check_fit(struct pci_epf_map *map, u64 addr, u64 end)
> +{
> +       return addr >= map->host.phys_base && end <= map->host.phys_end;
> +}
> +
> +static __always_inline void __iomem *
> +pci_epf_map_get(struct pci_epf_map *map, u64 addr)
> +{
> +       return addr - map->host.phys_base + map->pci.virt_base;
> +}
> +
> +#endif /* _PCI_EPF_MAP_H */
> diff --git a/drivers/pci/endpoint/functions/pci-epf-nvme.c b/drivers/pci/endpoint/functions/pci-epf-nvme.c
> new file mode 100644
> index 000000000000..5dd9d6796fce
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
> @@ -0,0 +1,1880 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * NVMe function driver for PCI Endpoint Framework
> + *
> + * Copyright (C) 2019 SiFive
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/pci_ids.h>
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +#include <linux/pci_regs.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/nvme.h>
> +#include "../../../nvme/host/nvme.h"
> +#include "../../../nvme/target/nvmet.h"
> +#include "pci-epf-map.h"
> +#include "pci-epf-debug.h"
> +
> +#define TIMER_RESOLUTION               1
> +
> +/* maximum page size (MPSMAX): 4K */
> +#define PCI_EPF_NVME_MPSMAX            0ULL
> +/* minimum page size (MPSMIN): 4K is current upper limit from Linux kernel */
> +#define PCI_EPF_NVME_MPSMIN            0ULL
> +/* command sets supported (CSS): NVMe command set */
> +#define PCI_EPF_NVME_CSS               1ULL
> +/* CC.EN timeout in 500msec units (TO) */
> +#define PCI_EPF_NVME_TO                        15ULL
> +/* zero-based maximum queue entries (MQES) */
> +#define PCI_EPF_NVME_MQES              (NVME_AQ_DEPTH - 1)
> +/* maximum queue id */
> +#define PCI_EPF_NVME_QIDMAX            4
> +/* keepalive ticks */
> +#define PCI_EPF_NVME_KA_TICKS          1000
> +
> +/* # of address maps */
> +#define PRP_MAPS                       12
> +/* size of address map: 1G = 2^30 */
> +#define PRP_MAP_SIZE                   0x0000000040000000ULL
> +/* flag bit to indicate when a prp is mapped */
> +#define PRP_MAP_FLAG                   (1 << 0)
> +
> +/* no prp marker */
> +#define PRP_NONE                       0xffffffffffffffffULL
> +/* size of prp */
> +#define PRP_SIZE                       sizeof(__le64)
> +/* maximum # of prps in a page per nvme */
> +#define PRP_PER_PAGE                   (PAGE_SIZE / PRP_SIZE)
> +
> +/* # of prp lists supported */
> +#define PRP_LISTS                      1
> +/* # of prp list entries supported */
> +#define PRP_LIST_ENTRIES               (PRP_LISTS * PRP_PER_PAGE)
> +
> +static struct workqueue_struct *epf_nvme_workqueue;
> +
> +enum pci_epf_nvme_status {
> +       PCI_EPF_NVME_SYNC = -1,
> +       PCI_EPF_NVME_ASYNC = -2
> +};
> +
> +struct pci_epf_nvme_queue {
> +       u16 qid;
> +       u16 size;
> +       u16 depth;
> +       u16 flags;
> +       u16 vector;
> +       u16 head;
> +       u16 tail;
> +       u16 phase;
> +       u32 db;
> +       struct pci_epf_map map;
> +};
> +
> +struct pci_epf_nvme_cmb {
> +       size_t size;
> +       enum pci_barno bar;
> +       void *virt_dma_addr;
> +       u64 phys_dma_addr;
> +};
> +
> +struct pci_epf_nvme_features {
> +       u32 aec;
> +};
> +
> +struct pci_epf_nvme_prplist {
> +       unsigned int count;
> +       unsigned int index;
> +       size_t align;
> +       u64 min;
> +       u64 max;
> +       u64 prp[PRP_LIST_ENTRIES];
> +};
> +
> +struct pci_epf_nvme_host {
> +       void __iomem *reg;
> +       int msi;
> +       u64 cap;
> +       u32 vs;
> +       u32 intms;
> +       u32 intmc;
> +       u32 cc;
> +       u32 csts;
> +       u32 cmbsz;
> +       u32 cmbloc;
> +       u32 aqa;
> +       u64 asq;
> +       u64 acq;
> +       struct pci_epf_nvme_queue sq[PCI_EPF_NVME_QIDMAX + 1];
> +       struct pci_epf_nvme_queue cq[PCI_EPF_NVME_QIDMAX + 1];
> +       struct pci_epf_nvme_cmb cmb;
> +       struct pci_epf_nvme_features features;
> +};
> +
> +struct pci_epf_nvme_target {
> +       struct device *dev;
> +       struct nvmet_host host;
> +       struct nvmet_host_link host_link;
> +       struct nvmet_subsys subsys;
> +       struct nvmet_subsys_link subsys_link;
> +       struct nvmet_port port;
> +       enum nvme_ana_state port_ana_state[NVMET_MAX_ANAGRPS + 1];
> +       struct nvmet_ns ns;
> +       struct nvmet_ctrl *nvmet_ctrl;
> +       struct nvmet_sq sq[PCI_EPF_NVME_QIDMAX + 1];
> +       struct nvmet_cq cq[PCI_EPF_NVME_QIDMAX + 1];
> +       struct nvmet_req req;
> +       struct nvme_command cmd;
> +       struct nvme_completion rsp;
> +       struct completion done;
> +       struct sg_table sg_table;
> +       struct scatterlist sgl[PRP_LIST_ENTRIES + 2];
> +       struct pci_epf_map map[PRP_MAPS];
> +       struct pci_epf_nvme_prplist prplist;
> +       size_t buffer_size;
> +       u8 *buffer;
> +       int keepalive;
> +};
> +
> +struct pci_epf_nvme {
> +       void *reg[6];
> +       struct pci_epf *epf;
> +       enum pci_barno reg_bar;
> +       struct delayed_work poll;
> +       const struct pci_epc_features *epc_features;
> +       struct pci_epf_nvme_host host;
> +       struct pci_epf_nvme_target target;
> +       int tick;
> +};
> +
> +static void __iomem *
> +pci_epf_nvme_map_find(struct pci_epf_nvme *nvme, u64 addr, size_t size)
> +{
> +       int slot;
> +       struct pci_epf_map *map;
> +       u64 end = addr + size - 1;
> +
> +       for (slot = 0; slot < PRP_MAPS; slot++) {
> +               map = &nvme->target.map[slot];
> +               if (!map->pci.virt_addr)
> +                       break;
> +               else if (pci_epf_map_check_fit(map, addr, end))
> +                       return pci_epf_map_get(map, addr);
> +       }
> +
> +       return NULL;
> +}
> +
> +static int
> +pci_epf_nvme_map(struct pci_epf_nvme *nvme, int slot, u64 addr, size_t size)
> +{
> +       if (addr && size && slot < PRP_MAPS) {
> +               struct pci_epf_map *map = &nvme->target.map[slot];
> +
> +               map->size = size;
> +               map->host.phys_addr = addr;
> +               return pci_epf_map(map, nvme->epf, nvme->epc_features);
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static __always_inline int
> +pci_epf_nvme_map_sgl(struct pci_epf_nvme *nvme,
> +                    struct nvme_sgl_desc *sgl)
> +{
> +       return pci_epf_nvme_map(nvme, 0,
> +                               le64_to_cpu(sgl->addr),
> +                               le32_to_cpu(sgl->length)) == 0;
> +}
> +
> +static __always_inline int
> +pci_epf_nvme_map_ksgl(struct pci_epf_nvme *nvme,
> +                     struct nvme_keyed_sgl_desc *ksgl)
> +{
> +       return pci_epf_nvme_map(nvme, 0,
> +                               le64_to_cpu(ksgl->addr),
> +                               PAGE_SIZE) == 0;
> +}
> +
> +static __always_inline int
> +pci_epf_nvme_map_prp(struct pci_epf_nvme *nvme, int slot, u64 prp)
> +{
> +       if (!prp)
> +               return 0;
> +
> +       return pci_epf_nvme_map(nvme, slot, prp, PAGE_SIZE) == 0;
> +}
> +
> +static __always_inline int
> +pci_epf_nvme_map_prp1(struct pci_epf_nvme *nvme, struct nvme_command *cmd)
> +{
> +       u64 prp = le64_to_cpu(cmd->common.dptr.prp1);
> +
> +       return pci_epf_nvme_map_prp(nvme, 0, prp);
> +}
> +
> +static __always_inline int
> +pci_epf_nvme_map_prp2(struct pci_epf_nvme *nvme, struct nvme_command *cmd)
> +{
> +       u64 prp = le64_to_cpu(cmd->common.dptr.prp2);
> +
> +       return pci_epf_nvme_map_prp(nvme, 1, prp);
> +}
> +
> +static int
> +pci_epf_nvme_map_dptr(struct pci_epf_nvme *nvme, struct nvme_command *cmd)
> +{
> +       u8 psdt = (cmd->common.flags & NVME_CMD_SGL_ALL);
> +
> +       if (psdt == 0) {
> +               int result = pci_epf_nvme_map_prp1(nvme, cmd);
> +
> +               if (result && cmd->common.dptr.prp2)
> +                       result = pci_epf_nvme_map_prp2(nvme, cmd);
> +               return result;
> +       } else if (psdt == NVME_CMD_SGL_METABUF) {
> +               return pci_epf_nvme_map_sgl(nvme, &cmd->common.dptr.sgl);
> +       } else if (psdt == NVME_CMD_SGL_METASEG) {
> +               return pci_epf_nvme_map_ksgl(nvme, &cmd->common.dptr.ksgl);
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +pci_epf_nvme_expand_prplist(struct pci_epf_nvme *nvme, unsigned int more)
> +{
> +       struct pci_epf_nvme_prplist *list = &nvme->target.prplist;
> +       u64 prp;
> +
> +       list->count += more;
> +
> +       while (more--) {
> +               prp = le64_to_cpu(list->prp[list->index]);
> +               if (!prp || (prp & (PAGE_SIZE - 1)))
> +                       return -EINVAL;
> +
> +               if (prp > list->max)
> +                       list->max = prp;
> +               if (prp < list->min)
> +                       list->min = prp;
> +
> +               list->prp[list->index++] = prp;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +pci_epf_nvme_transfer_prplist(struct pci_epf_nvme *nvme,
> +                             int slot, unsigned int count)
> +{
> +       struct pci_epf_nvme_prplist *list = &nvme->target.prplist;
> +       struct pci_epf_map *map = &nvme->target.map[slot];
> +       unsigned int more;
> +       size_t size;
> +       u64 nextlist;
> +
> +       list->align = map->align;
> +       list->min = PRP_NONE;
> +       list->max = 0;
> +       list->index = 0;
> +
> +       while (count) {
> +               if (count <= PRP_PER_PAGE) {
> +                       more = count;
> +                       size = more * PRP_SIZE;
> +               } else {
> +                       more = PRP_PER_PAGE - 1;
> +                       size = PAGE_SIZE;
> +               }
> +
> +               pci_epf_debug_dump(map->pci.virt_addr, size, "prplist");
> +               memcpy_fromio(&list->prp[list->index],
> +                             map->pci.virt_addr, size);
> +               pci_epf_unmap(map);
> +
> +               if (pci_epf_nvme_expand_prplist(nvme, more)) {
> +                       pr_info("pci epf nvme: prplist invalid prp\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (count <= PRP_PER_PAGE)
> +                       break;
> +
> +               count -= PRP_PER_PAGE - 1;
> +
> +               nextlist = le64_to_cpu(list->prp[list->index]);
> +               if (!nextlist || (nextlist & (PAGE_SIZE - 1))) {
> +                       pr_info("pci epf nvme: invalid next prplist\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (!pci_epf_nvme_map_prp(nvme, slot, nextlist)) {
> +                       pr_info("pci epf nvme: next prplist map error\n");
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void
> +pci_epf_nvme_review_prplist(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_prplist *list = &nvme->target.prplist;
> +       unsigned int index;
> +       u64 prp;
> +
> +       list->min = PRP_NONE;
> +       for (index = 0; index < list->count; index++) {
> +               prp = list->prp[index];
> +               if (prp & PRP_MAP_FLAG)
> +                       continue;
> +               else if (pci_epf_nvme_map_find(nvme, prp, PAGE_SIZE))
> +                       list->prp[index] |= PRP_MAP_FLAG;
> +               else if (prp < list->min)
> +                       list->min = prp;
> +       }
> +}
> +
> +static int
> +pci_epf_nvme_map_prplist(struct pci_epf_nvme *nvme, int slot)
> +{
> +       struct pci_epf_nvme_prplist *list = &nvme->target.prplist;
> +       size_t span;
> +       u64 base, mask;
> +
> +       if (list->min == PRP_NONE) {
> +               pr_info("pci epf nvme: unexpected empty prplist\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (pci_epf_nvme_map_find(nvme, list->min, PAGE_SIZE)) {
> +               pci_epf_nvme_review_prplist(nvme);
> +               if (list->min == PRP_NONE)
> +                       return 0;
> +       }
> +
> +       mask = ~(list->align - 1);
> +       base = list->min & mask;
> +       span = list->max + PAGE_SIZE - base;
> +
> +       while (span) {
> +               if (pci_epf_nvme_map(nvme, slot, base, PRP_MAP_SIZE)) {
> +                       pr_info("pci epf nvme: prplist map region error\n");
> +                       return -ENOMEM;
> +               }
> +
> +               if (span <= PRP_MAP_SIZE)
> +                       return 0;
> +
> +               span -= PRP_MAP_SIZE;
> +
> +               if (++slot == PRP_MAPS) {
> +                       pr_info("pci epf nvme: prplist map out of resources\n");
> +                       return -ENOMEM;
> +               }
> +
> +               pci_epf_nvme_review_prplist(nvme);
> +               if (list->min == PRP_NONE)
> +                       return 0;
> +
> +               base = list->min & mask;
> +               span = list->max + PAGE_SIZE - base;
> +       }
> +
> +       return 0;
> +}
> +
> +static void
> +pci_epf_nvme_unmap_dptr(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_map *map = nvme->target.map;
> +       int slot;
> +
> +       for (slot = 0; slot < PRP_MAPS; slot++) {
> +               if (map->pci.virt_addr)
> +                       pci_epf_unmap(map);
> +               map++;
> +       }
> +}
> +
> +static int
> +pci_epf_nvmet_write32(struct pci_epf_nvme_target *target, u32 off, u32 val)
> +{
> +       struct nvmet_ctrl *nvmet_ctrl = target->nvmet_ctrl;
> +
> +       if (!nvmet_ctrl)
> +               return -ENXIO;
> +
> +       switch (off) {
> +       case NVME_REG_CC:
> +               nvmet_update_cc(nvmet_ctrl, val);
> +               return 0;
> +       default:
> +               return -EIO;
> +       }
> +}
> +
> +static int
> +pci_epf_nvmet_read32(struct pci_epf_nvme_target *target, u32 off, u32 *val)
> +{
> +       struct nvmet_ctrl *nvmet_ctrl = target->nvmet_ctrl;
> +       u32 reg;
> +
> +       if (!nvmet_ctrl)
> +               return -ENXIO;
> +
> +       switch (off) {
> +       case NVME_REG_VS:
> +               reg = nvmet_ctrl->subsys->ver;
> +               break;
> +       case NVME_REG_CC:
> +               reg = nvmet_ctrl->cc;
> +               break;
> +       case NVME_REG_CSTS:
> +               reg = nvmet_ctrl->csts;
> +               break;
> +       default:
> +               return -EIO;
> +       }
> +
> +       if (val)
> +               *val = reg;
> +       return 0;
> +}
> +
> +static int
> +pci_epf_nvmet_read64(struct pci_epf_nvme_target *target, u32 off, u64 *val)
> +{
> +       struct nvmet_ctrl *nvmet_ctrl = target->nvmet_ctrl;
> +       u64 reg;
> +
> +       if (!nvmet_ctrl)
> +               return -ENXIO;
> +
> +       switch (off) {
> +       case NVME_REG_CAP:
> +               reg = nvmet_ctrl->cap;
> +               break;
> +       default:
> +               return -EIO;
> +       }
> +
> +       if (val)
> +               *val = reg;
> +       return 0;
> +}
> +
> +static int pci_epf_nvmet_add_port(struct nvmet_port *nvmet_port)
> +{
> +       pr_err("pci epf nvme: unexpected call to add port\n");
> +       return 0;
> +}
> +
> +static void pci_epf_nvmet_remove_port(struct nvmet_port *nvmet_port)
> +{
> +       pr_err("pci epf nvme: unexpected call to remove port\n");
> +}
> +
> +static void pci_epf_nvmet_queue_response(struct nvmet_req *req)
> +{
> +       struct pci_epf_nvme_target *target;
> +
> +       if (req->cqe->status)
> +               pr_err("pci epf nvme: queue_response status 0x%x\n",
> +                       le16_to_cpu(req->cqe->status));
> +
> +       target = container_of(req, struct pci_epf_nvme_target, req);
> +       complete(&target->done);
> +       target->keepalive = 0;
> +}
> +
> +static void pci_epf_nvmet_delete_ctrl(struct nvmet_ctrl *nvmet_ctrl)
> +{
> +       pr_err("pci epf nvme: unexpected call to delete controller\n");
> +}
> +
> +static struct nvmet_fabrics_ops pci_epf_nvmet_fabrics_ops = {
> +       .owner          = THIS_MODULE,
> +       .type           = NVMF_TRTYPE_LOOP,
> +       .add_port       = pci_epf_nvmet_add_port,
> +       .remove_port    = pci_epf_nvmet_remove_port,
> +       .queue_response = pci_epf_nvmet_queue_response,
> +       .delete_ctrl    = pci_epf_nvmet_delete_ctrl,
> +};
> +
> +static void *
> +pci_epf_nvmet_buffer(struct pci_epf_nvme_target *target, size_t size)
> +{
> +       if (target->buffer) {
> +               if (size <= target->buffer_size)
> +                       return target->buffer;
> +
> +               devm_kfree(target->dev, target->buffer);
> +       }
> +
> +       target->buffer = devm_kzalloc(target->dev, size, GFP_KERNEL);
> +       target->buffer_size = target->buffer ? size : 0;
> +       return target->buffer;
> +}
> +
> +static int
> +pci_epf_nvmet_execute(struct pci_epf_nvme_target *target)
> +{
> +       struct nvmet_req *req = &target->req;
> +
> +       req->execute(req);
> +
> +       if (req->cmd->common.opcode != nvme_admin_async_event)
> +               wait_for_completion(&target->done);
> +
> +       return req->cqe->status ? -EIO : NVME_SC_SUCCESS;
> +}
> +
> +static int
> +pci_epf_nvmet_execute_sg_table(struct pci_epf_nvme_target *target,
> +                              struct scatterlist *sg)
> +{
> +       struct nvmet_req *req = &target->req;
> +
> +       req->sg = target->sgl;
> +       req->sg_cnt = sg - target->sgl;
> +       sg_init_marker(req->sg, req->sg_cnt);
> +
> +       target->sg_table.sgl = req->sg;
> +       target->sg_table.nents = req->sg_cnt;
> +       target->sg_table.orig_nents = req->sg_cnt;
> +       return pci_epf_nvmet_execute(target);
> +}
> +
> +static size_t
> +pci_epf_nvmet_set_sg(struct scatterlist *sg, const void *buffer, size_t size)
> +{
> +       sg_set_page(sg, virt_to_page(buffer), size, offset_in_page(buffer));
> +       return size;
> +}
> +
> +static size_t
> +pci_epf_nvmet_set_sg_page(struct scatterlist *sg, const void *page)
> +{
> +       return pci_epf_nvmet_set_sg(sg, page, PAGE_SIZE);
> +}
> +
> +static size_t
> +pci_epf_nvmet_set_sg_map(struct scatterlist *sg, const struct pci_epf_map *map)
> +{
> +       return pci_epf_nvmet_set_sg(sg, map->pci.virt_addr, map->size);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_buffer(struct pci_epf_nvme_target *target)
> +{
> +       struct nvmet_req *req = &target->req;
> +       struct scatterlist *sg = target->sgl;
> +       void *buffer;
> +
> +       buffer = pci_epf_nvmet_buffer(target, req->data_len);
> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       req->transfer_len = pci_epf_nvmet_set_sg(sg++, buffer, req->data_len);
> +       return pci_epf_nvmet_execute_sg_table(target, sg);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_sgl_ksgl(struct pci_epf_nvme_target *target)
> +{
> +       struct nvmet_req *req = &target->req;
> +       struct scatterlist *sg = target->sgl;
> +       struct pci_epf_map *map = target->map;
> +
> +       pci_epf_debug_dump(map->pci.virt_addr, 64, "sgl");
> +       req->transfer_len = pci_epf_nvmet_set_sg_map(sg++, map);
> +       return pci_epf_nvmet_execute_sg_table(target, sg);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_prp1_prp2(struct pci_epf_nvme_target *target)
> +{
> +       struct nvmet_req *req = &target->req;
> +       struct scatterlist *sg = target->sgl;
> +       struct pci_epf_map *map = target->map;
> +
> +       req->transfer_len  = pci_epf_nvmet_set_sg_map(sg++, map++);
> +       req->transfer_len += pci_epf_nvmet_set_sg_map(sg++, map);
> +       return pci_epf_nvmet_execute_sg_table(target, sg);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_prp1(struct pci_epf_nvme_target *target)
> +{
> +       struct nvmet_req *req = &target->req;
> +       struct scatterlist *sg = target->sgl;
> +       struct pci_epf_map *map = target->map;
> +
> +       req->transfer_len = pci_epf_nvmet_set_sg_map(sg++, map);
> +       return pci_epf_nvmet_execute_sg_table(target, sg);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_prplist(struct pci_epf_nvme_target *target,
> +                             int slot, size_t list_data_len)
> +{
> +       struct pci_epf_nvme_prplist *list = &target->prplist;
> +       struct pci_epf_nvme *nvme;
> +       struct scatterlist *sg;
> +       struct nvmet_req *req;
> +       void __iomem *virt_addr;
> +       unsigned int index, count;
> +       int status;
> +       u64 prp;
> +
> +       memset(list, 0, sizeof(*list));
> +
> +       if (slot < 0 || slot > 1)
> +               return -EINVAL;
> +
> +       count = list_data_len >> PAGE_SHIFT;
> +
> +       if (count == 0 || count > PRP_LIST_ENTRIES) {
> +               pr_info("pci epf nvme: prplist invalid length 0x%x\n", count);
> +               return -EINVAL;
> +       }
> +
> +       nvme = container_of(target, struct pci_epf_nvme, target);
> +
> +       status = pci_epf_nvme_transfer_prplist(nvme, slot, count);
> +       if (status)
> +               return status;
> +
> +       status = pci_epf_nvme_map_prplist(nvme, slot);
> +       if (status)
> +               return status;
> +
> +       sg = &target->sgl[slot];
> +       req = &target->req;
> +
> +       for (index = 0; index < list->count; index++) {
> +               prp = list->prp[index] & ~(PRP_MAP_FLAG);
> +               virt_addr = pci_epf_nvme_map_find(nvme, prp, PAGE_SIZE);
> +               if (unlikely(!virt_addr)) {
> +                       pr_info("pci epf nvme: prplist map find error\n");
> +                       return -ENOMEM;
> +               }
> +
> +               req->transfer_len += pci_epf_nvmet_set_sg_page(sg++, virt_addr);
> +       }
> +
> +       if (req->transfer_len != req->data_len) {
> +               pr_info("pci epf nvme: prplist map length error\n");
> +               return -ENOMEM;
> +       }
> +
> +       return pci_epf_nvmet_execute_sg_table(target, sg);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_prp1_prp2list(struct pci_epf_nvme_target *target)
> +{
> +       struct nvmet_req *req = &target->req;
> +       size_t list_data_len = req->data_len - target->map[0].size;
> +
> +       req->transfer_len = pci_epf_nvmet_set_sg_map(target->sgl, target->map);
> +       return pci_epf_nvmet_execute_prplist(target, 1, list_data_len);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_prp1list(struct pci_epf_nvme_target *target)
> +{
> +       return pci_epf_nvmet_execute_prplist(target, 0, target->req.data_len);
> +}
> +
> +static int
> +pci_epf_nvmet_execute_request(struct pci_epf_nvme_target *target, int qid)
> +{
> +       struct pci_epf_map *map = target->map;
> +       struct nvmet_req *req = &target->req;
> +       struct nvme_command *cmd = req->cmd;
> +       u8 psdt = (cmd->common.flags & NVME_CMD_SGL_ALL);
> +       int status;
> +
> +       cmd->common.flags &= ~(NVME_CMD_SGL_ALL);
> +       cmd->common.flags |= NVME_CMD_SGL_METABUF;
> +
> +       if (!nvmet_req_init(req, &target->cq[qid], &target->sq[qid],
> +                           &pci_epf_nvmet_fabrics_ops))
> +               return -EIO;
> +
> +       memset(target->sgl, 0, sizeof(target->sgl));
> +
> +       if (req->data_len == 0)
> +               status = pci_epf_nvmet_execute(target);
> +       else if (req->cmd->common.opcode == nvme_fabrics_command)
> +               status = pci_epf_nvmet_execute_buffer(target);
> +       else if (!map[0].pci.virt_addr || !map[0].size)
> +               status = -ENOMEM;
> +       else if (psdt)
> +               status = pci_epf_nvmet_execute_sgl_ksgl(target);
> +       else if (req->data_len <= PAGE_SIZE)
> +               status = pci_epf_nvmet_execute_prp1(target);
> +       else if (!map[1].pci.virt_addr || !map[1].size)
> +               status = pci_epf_nvmet_execute_prp1list(target);
> +       else if (req->data_len <= (2 * PAGE_SIZE))
> +               status = pci_epf_nvmet_execute_prp1_prp2(target);
> +       else
> +               status = pci_epf_nvmet_execute_prp1_prp2list(target);
> +
> +       if (status == NVME_SC_SUCCESS)
> +               return NVME_SC_SUCCESS;
> +       else if (status == -EIO)
> +               return -EIO;
> +
> +       status = NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +       req->cqe->status = cpu_to_le16(status << 1);
> +       return -EIO;
> +}
> +
> +static struct nvme_command *
> +pci_epf_nvmet_init_request(struct pci_epf_nvme_target *target)
> +{
> +       memset(&target->cmd, 0, sizeof(target->cmd));
> +       memset(&target->rsp, 0, sizeof(target->rsp));
> +       memset(&target->req, 0, sizeof(target->req));
> +
> +       target->req.cmd = &target->cmd;
> +       target->req.cqe = &target->rsp;
> +       target->req.port = &target->port;
> +
> +       return target->req.cmd;
> +}
> +
> +static int pci_epf_nvmet_connect(struct pci_epf_nvme_target *target,
> +                                u16 qid, u16 qsize, u16 command_id)
> +{
> +       struct nvmf_connect_data *data;
> +       struct nvme_command *cmd;
> +       char *subsysnqn;
> +       char *hostnqn;
> +       void *buffer;
> +       u16 cntlid;
> +       u32 kato;
> +
> +       buffer = pci_epf_nvmet_buffer(target, sizeof(*data));
> +       if (!buffer)
> +               return -ENOMEM;
> +
> +       subsysnqn = target->subsys.subsysnqn;
> +       hostnqn = nvmet_host_name(target->host_link.host);
> +       cntlid = qid ? target->nvmet_ctrl->cntlid : 0xffff;
> +       kato = (NVME_DEFAULT_KATO + NVME_KATO_GRACE) * 1000;
> +
> +       data = (struct nvmf_connect_data *)buffer;
> +       strncpy(data->hostnqn, hostnqn, NVMF_NQN_SIZE);
> +       strncpy(data->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
> +       uuid_gen(&data->hostid);
> +       data->cntlid = cpu_to_le16(cntlid);
> +
> +       cmd = pci_epf_nvmet_init_request(target);
> +       cmd->connect.command_id = command_id;
> +       cmd->connect.opcode = nvme_fabrics_command;
> +       cmd->connect.fctype = nvme_fabrics_type_connect;
> +       cmd->connect.qid = cpu_to_le16(qid);
> +       cmd->connect.sqsize = cpu_to_le16(qsize);
> +       cmd->connect.kato = cpu_to_le32(kato);
> +
> +       target->req.port = &target->port;
> +
> +       if (pci_epf_nvmet_execute_request(target, qid))
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int
> +pci_epf_nvmet_connect_admin_queue(struct pci_epf_nvme_target *target)
> +{
> +       if (pci_epf_nvmet_connect(target, 0, (NVME_AQ_DEPTH - 1), 0))
> +               return -EIO;
> +
> +       target->nvmet_ctrl = target->sq[0].ctrl;
> +       if (target->nvmet_ctrl)
> +               pr_info("connected to target controller %p id %d\n",
> +                       target->nvmet_ctrl, target->nvmet_ctrl->cntlid);
> +
> +       return 0;
> +}
> +
> +static void pci_epf_nvme_target_keep_alive(struct pci_epf_nvme *nvme)
> +{
> +       struct nvme_command *cmd;
> +
> +       if (++nvme->target.keepalive < PCI_EPF_NVME_KA_TICKS)
> +               return;
> +
> +       cmd = pci_epf_nvmet_init_request(&nvme->target);
> +       cmd->common.opcode = nvme_admin_keep_alive;
> +       pci_epf_nvmet_execute_request(&nvme->target, 0);
> +}
> +
> +static void pci_epf_nvme_target_stop(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct nvmet_sq *sq = target->sq;
> +       int qid;
> +
> +       nvmet_ns_disable(&target->ns);
> +
> +       for (qid = 0; qid <= PCI_EPF_NVME_QIDMAX; qid++)
> +               nvmet_sq_destroy(sq++);
> +
> +       target->nvmet_ctrl = NULL;
> +}
> +
> +static void pci_epf_nvme_target_start(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct nvmet_sq *sq = target->sq;
> +       int qid;
> +
> +       for (qid = 0; qid <= PCI_EPF_NVME_QIDMAX; qid++)
> +               nvmet_sq_init(sq++);
> +
> +       if (pci_epf_nvmet_connect_admin_queue(target))
> +               dev_err(&nvme->epf->dev, "Failed to connect target ASQ\n");
> +
> +       else if (pci_epf_nvmet_write32(target, NVME_REG_CC, host->cc))
> +               dev_err(&nvme->epf->dev, "Failed to write target CC\n");
> +}
> +
> +static void pci_epf_nvme_target_init(struct pci_epf_nvme *nvme)
> +{
> +       static u8 nguid[16] = {
> +               0xef, 0x90, 0x68, 0x9c, 0x6c, 0x46, 0xd4, 0x4c,
> +               0x89, 0xc1, 0x40, 0x67, 0x80, 0x13, 0x09, 0xa8
> +       };
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct nvmet_host *host = &target->host;
> +       struct nvmet_host_link *host_link = &target->host_link;
> +       struct nvmet_subsys *subsys = &target->subsys;
> +       struct nvmet_subsys_link *subsys_link = &target->subsys_link;
> +       struct nvmet_port *port = &target->port;
> +       struct nvmet_ns *ns = &target->ns;
> +       struct nvmet_cq *cq = target->cq;
> +       struct nvmet_sq *sq = target->sq;
> +       int qid, gid;
> +
> +       target->dev = &nvme->epf->dev;
> +       target->keepalive = PCI_EPF_NVME_KA_TICKS - 1;
> +       init_completion(&target->done);
> +
> +       host->group.cg_item.ci_name = "hostnqn";
> +
> +       subsys->subsysnqn = "testnqn";
> +       subsys->type = NVME_NQN_NVME;
> +       subsys->max_qid = PCI_EPF_NVME_QIDMAX;
> +       kref_init(&subsys->ref);
> +       mutex_init(&subsys->lock);
> +       INIT_LIST_HEAD(&subsys->namespaces);
> +       INIT_LIST_HEAD(&subsys->ctrls);
> +       INIT_LIST_HEAD(&subsys->hosts);
> +
> +       port->ana_state = target->port_ana_state;
> +       for (gid = 0; gid <= NVMET_MAX_ANAGRPS; gid++)
> +               port->ana_state[gid] = NVME_ANA_INACCESSIBLE;
> +       port->ana_state[NVMET_DEFAULT_ANA_GRPID] = NVME_ANA_OPTIMIZED;
> +       port->ana_default_group.port = port;
> +       port->ana_default_group.grpid = NVMET_DEFAULT_ANA_GRPID;
> +       nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
> +
> +       port->disc_addr.trtype = NVMF_TRTYPE_LOOP;
> +       port->disc_addr.treq = NVMF_TREQ_DISABLE_SQFLOW;
> +       memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
> +       INIT_LIST_HEAD(&port->global_entry);
> +       INIT_LIST_HEAD(&port->entry);
> +       INIT_LIST_HEAD(&port->referrals);
> +       INIT_LIST_HEAD(&port->subsystems);
> +       port->inline_data_size = 0;
> +
> +       INIT_LIST_HEAD(&host_link->entry);
> +       host_link->host = host;
> +       list_add_tail(&host_link->entry, &subsys->hosts);
> +
> +       INIT_LIST_HEAD(&subsys_link->entry);
> +       subsys_link->subsys = subsys;
> +       list_add_tail(&subsys_link->entry, &port->subsystems);
> +
> +       INIT_LIST_HEAD(&ns->dev_link);
> +       init_completion(&ns->disable_done);
> +       ns->nsid = 1;
> +       ns->subsys = subsys;
> +       ns->device_path = "/dev/loop0";
> +       ns->anagrpid = NVMET_DEFAULT_ANA_GRPID;
> +       ns->buffered_io = false;
> +       memcpy(&ns->nguid, nguid, sizeof(ns->nguid));
> +       uuid_gen(&ns->uuid);
> +
> +       for (qid = 0; qid <= PCI_EPF_NVME_QIDMAX; qid++) {
> +               cq->qid = 0;
> +               cq->size = 0;
> +               cq++;
> +
> +               sq->sqhd = 0;
> +               sq->qid = 0;
> +               sq->size = 0;
> +               sq->ctrl = NULL;
> +               sq++;
> +       }
> +}
> +
> +static u64 pci_epf_nvme_cap(struct pci_epf_nvme *nvme)
> +{
> +       u64 cap;
> +
> +       if (pci_epf_nvmet_read64(&nvme->target, NVME_REG_CAP, &cap)) {
> +               /* maximum queue entries supported (MQES) */
> +               cap = PCI_EPF_NVME_MQES;
> +               /* CC.EN timeout in 500msec units (TO) */
> +               cap |= (PCI_EPF_NVME_TO << 24);
> +               /* command sets supported (CSS) */
> +               cap |= (PCI_EPF_NVME_CSS << 37);
> +       }
> +
> +       if (NVME_CAP_MPSMIN(cap) != PCI_EPF_NVME_MPSMIN) {
> +               /* minimum page size (MPSMIN) */
> +               cap &= ~(0x0fULL << 48);
> +               cap |= (PCI_EPF_NVME_MPSMIN << 48);
> +       }
> +
> +       if (NVME_CAP_MPSMAX(cap) != PCI_EPF_NVME_MPSMAX) {
> +               /* maximum page size (MPSMAX) */
> +               cap &= ~(0x0fULL << 52);
> +               cap |= (PCI_EPF_NVME_MPSMAX << 52);
> +       }
> +
> +       return cap;
> +}
> +
> +static u32 pci_epf_nvme_vs(struct pci_epf_nvme *nvme)
> +{
> +       u32 vs;
> +
> +       if (pci_epf_nvmet_read32(&nvme->target, NVME_REG_VS, &vs))
> +               vs = NVME_VS(1, 3, 0);
> +
> +       /* CMB supported on NVMe versions 1.2+ */
> +       else if (vs < NVME_VS(1, 2, 0))
> +               vs = NVME_VS(1, 2, 0);
> +
> +       return vs;
> +}
> +
> +static u32 pci_epf_nvme_csts(struct pci_epf_nvme *nvme)
> +{
> +       u32 csts;
> +
> +       if (pci_epf_nvmet_read32(&nvme->target, NVME_REG_CSTS, &csts))
> +               csts = 0;
> +
> +       return csts;
> +}
> +
> +static u32 pci_epf_nvme_cmbloc(struct pci_epf_nvme *nvme)
> +{
> +       u32 cmbloc = 0;
> +
> +       if (nvme->host.cmb.size)
> +               cmbloc = nvme->host.cmb.bar;
> +
> +       return cmbloc;
> +}
> +
> +static u32 pci_epf_nvme_cmbsz(struct pci_epf_nvme *nvme)
> +{
> +       u32 cmbsz = 0;
> +
> +       if (nvme->host.cmb.size) {
> +               cmbsz = NVME_CMBSZ_SQS |   /* Submission Queue Support (SQS) */
> +                       NVME_CMBSZ_CQS;    /* Completion Queue Support (CQS) */
> +
> +               /* Size (SZ) in Size Units (SZU) of 4KiB */
> +               cmbsz |= (nvme->host.cmb.size << NVME_CMBSZ_SZ_SHIFT);
> +       }
> +
> +       return cmbsz;
> +}
> +
> +static size_t bar_size[] = { SZ_4K, SZ_4K, SZ_4K, SZ_4K, SZ_4K, SZ_4K };
> +
> +static u32 pci_epf_nvme_host_read32(struct pci_epf_nvme_host *host, u32 reg)
> +{
> +       return readl(host->reg + reg);
> +}
> +
> +static void pci_epf_nvme_host_write32(struct pci_epf_nvme_host *host,
> +                                     u32 reg, u32 val)
> +{
> +       writel(val, host->reg + reg);
> +}
> +
> +static u64 pci_epf_nvme_host_read64(struct pci_epf_nvme_host *host, u32 reg)
> +{
> +       return lo_hi_readq(host->reg + reg);
> +}
> +
> +static void pci_epf_nvme_host_write64(struct pci_epf_nvme_host *host,
> +                                     u32 reg, u64 val)
> +{
> +       lo_hi_writeq(val, host->reg + reg);
> +}
> +
> +static void pci_epf_nvme_host_emit(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +
> +       host->cap = pci_epf_nvme_cap(nvme);
> +       host->vs = pci_epf_nvme_vs(nvme);
> +       host->cmbloc = pci_epf_nvme_cmbloc(nvme);
> +       host->cmbsz = pci_epf_nvme_cmbsz(nvme);
> +       host->csts = pci_epf_nvme_csts(nvme);
> +
> +       pci_epf_nvme_host_write64(host, NVME_REG_CAP, host->cap);
> +       pci_epf_nvme_host_write32(host, NVME_REG_VS, host->vs);
> +       pci_epf_nvme_host_write32(host, NVME_REG_CMBLOC, host->cmbloc);
> +       pci_epf_nvme_host_write32(host, NVME_REG_CMBSZ, host->cmbsz);
> +       pci_epf_nvme_host_write32(host, NVME_REG_CSTS, host->csts);
> +}
> +
> +static void pci_epf_nvme_host_queue_reset(struct pci_epf_nvme_queue *queue)
> +{
> +       memset(queue, 0, sizeof(*queue));
> +}
> +
> +static void pci_epf_nvme_host_queue_unmap(struct pci_epf_nvme_queue *queue)
> +{
> +       pci_epf_unmap(&queue->map);
> +       pci_epf_nvme_host_queue_reset(queue);
> +}
> +
> +static int pci_epf_nvme_host_queue_map(struct pci_epf_nvme_queue *queue,
> +                                      struct pci_epf_nvme *nvme)
> +{
> +       return pci_epf_map(&queue->map, nvme->epf, nvme->epc_features);
> +}
> +
> +static int pci_epf_nvme_host_queue_pair(struct pci_epf_nvme *nvme,
> +                                       u16 sqid, u16 cqid)
> +{
> +       struct pci_epf_nvme_queue *sq = &nvme->host.sq[sqid];
> +       struct pci_epf_nvme_queue *cq = &nvme->host.cq[cqid];
> +       struct pci_epf *epf = nvme->epf;
> +       int ret;
> +
> +       sq->qid = sqid;
> +       sq->depth = sq->size + 1;
> +       sq->vector = 0;
> +       sq->map.size = sq->depth * sizeof(struct nvme_command);
> +       sq->db = NVME_REG_DBS + (sqid * 2 * sizeof(u32));
> +
> +       cq->qid = cqid;
> +       cq->depth = cq->size + 1;
> +       cq->vector = 0;
> +       cq->map.size = cq->depth * sizeof(struct nvme_completion);
> +       cq->db = NVME_REG_DBS + (((cqid * 2) + 1) * sizeof(u32));
> +       cq->phase = 1;
> +
> +       if (!sq->map.pci.virt_addr) {
> +               ret = pci_epf_nvme_host_queue_map(sq, nvme);
> +               if (ret) {
> +                       dev_err(&epf->dev, "Failed to map host SQ%d\n", sqid);
> +                       return ret;
> +               }
> +       }
> +
> +       if (!cq->map.pci.virt_addr) {
> +               ret = pci_epf_nvme_host_queue_map(cq, nvme);
> +               if (ret) {
> +                       dev_err(&epf->dev, "Failed to map host CQ%d\n", cqid);
> +                       pci_epf_nvme_host_queue_unmap(sq);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void pci_epf_nvme_host_complete(struct pci_epf_nvme *nvme, int qid)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf_nvme_queue *cq = &host->cq[qid];
> +       struct pci_epf *epf = nvme->epf;
> +       struct pci_epc *epc = epf->epc;
> +       struct nvme_completion *entry;
> +       struct nvme_completion *rsp;
> +       int tail;
> +
> +       pci_epf_nvme_unmap_dptr(nvme);
> +
> +       rsp = nvme->target.req.cqe;
> +       rsp->sq_id = qid;
> +       rsp->status |= cpu_to_le16(cq->phase);
> +
> +       tail = cq->tail++;
> +       if (cq->tail == cq->depth) {
> +               cq->tail = 0;
> +               cq->phase = !cq->phase;
> +       }
> +
> +       entry = (struct nvme_completion *)cq->map.pci.virt_addr + tail;
> +       memcpy_toio(entry, rsp, sizeof(*rsp));
> +       pci_epf_debug_dump(entry, sizeof(*entry), "rsp");
> +
> +       if (!(cq->flags & NVME_CQ_IRQ_ENABLED))
> +               return;
> +
> +       if (host->msi)
> +               pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_MSI, 1);
> +       else
> +               pci_epc_raise_irq(epc, epf->func_no, PCI_EPC_IRQ_LEGACY, 0);
> +}
> +
> +static int pci_epf_nvme_host_fetch(struct pci_epf_nvme *nvme, int qid)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf_nvme_queue *sq = &host->sq[qid];
> +       struct nvme_command *entry;
> +       struct nvme_command *cmd;
> +       int head, db;
> +
> +       if (!sq->size)
> +               return -ENXIO;
> +
> +       db = pci_epf_nvme_host_read32(host, sq->db);
> +       if (db == sq->head)
> +               return -EAGAIN;
> +
> +       if (pci_epf_debug_is_enabled())
> +               pr_info("sq[%d]: head 0x%x dbs 0x%x\n",
> +                       qid, (int)sq->head, db);
> +
> +       head = sq->head++;
> +       if (sq->head == sq->depth)
> +               sq->head = 0;
> +
> +       entry = (struct nvme_command *)sq->map.pci.virt_addr + head;
> +
> +       cmd = pci_epf_nvmet_init_request(&nvme->target);
> +       memcpy_fromio(cmd, entry, sizeof(*cmd));
> +       pci_epf_debug_dump(entry, sizeof(*entry), "cmd");
> +
> +       return head;
> +}
> +
> +static void pci_epf_nvme_host_stop(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf_nvme_queue *sq = host->sq;
> +       struct pci_epf_nvme_queue *cq = host->cq;
> +       int qid;
> +
> +       for (qid = 0; qid <= PCI_EPF_NVME_QIDMAX; qid++) {
> +               pci_epf_nvme_host_queue_unmap(sq++);
> +               pci_epf_nvme_host_queue_unmap(cq++);
> +       }
> +
> +       host->msi = 0;
> +
> +       host->csts &= ~NVME_CSTS_RDY;
> +       pci_epf_nvme_host_write32(host, NVME_REG_CSTS, host->csts);
> +}
> +
> +static int pci_epf_nvme_host_start(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf *epf = nvme->epf;
> +       struct pci_epc *epc = epf->epc;
> +       int ret;
> +
> +       host->aqa = pci_epf_nvme_host_read32(host, NVME_REG_AQA);
> +       host->asq = pci_epf_nvme_host_read64(host, NVME_REG_ASQ);
> +       host->acq = pci_epf_nvme_host_read64(host, NVME_REG_ACQ);
> +
> +       host->sq[0].size = (host->aqa & 0x0fff);
> +       host->sq[0].flags = NVME_QUEUE_PHYS_CONTIG;
> +       host->sq[0].map.host.phys_addr = host->asq;
> +
> +       host->cq[0].size = ((host->aqa & 0x0fff0000) >> 16);
> +       host->cq[0].flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
> +       host->cq[0].map.host.phys_addr = host->acq;
> +
> +       ret = pci_epf_nvme_host_queue_pair(nvme, 0, 0);
> +       if (ret)
> +               return ret;
> +
> +       host->msi = pci_epc_get_msi(epc, epf->func_no);
> +
> +       pci_epf_nvme_host_emit(nvme);
> +       return 0;
> +}
> +
> +static int pci_epf_nvme_host_cmb_init(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_cmb *cmb = &nvme->host.cmb;
> +       struct pci_epf *epf = nvme->epf;
> +       enum pci_barno bar = BAR_2;
> +
> +       if (!nvme->reg[bar]) {
> +               dev_err(&epf->dev, "Failed to initialize CMB\n");
> +               return -ENOMEM;
> +       }
> +
> +       cmb->bar = bar;
> +       cmb->size = epf->bar[bar].size;
> +       cmb->virt_dma_addr = nvme->reg[bar];
> +       cmb->phys_dma_addr = epf->bar[bar].phys_addr;
> +       return 0;
> +}
> +
> +static void pci_epf_nvme_host_init(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf_nvme_queue *sq = host->sq;
> +       struct pci_epf_nvme_queue *cq = host->cq;
> +       int qid;
> +
> +       for (qid = 0; qid <= PCI_EPF_NVME_QIDMAX; qid++) {
> +               pci_epf_nvme_host_queue_reset(sq++);
> +               pci_epf_nvme_host_queue_reset(cq++);
> +       }
> +
> +       host->reg = nvme->reg[nvme->reg_bar];
> +
> +       host->msi = 0;
> +       host->intms = 0;
> +       host->intmc = 0;
> +       host->cc = 0;
> +       host->aqa = 0;
> +
> +       pci_epf_nvme_host_cmb_init(nvme);
> +       pci_epf_nvme_host_emit(nvme);
> +}
> +
> +static int pci_epf_nvme_admin_identify(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct pci_epf_map *map = target->map;
> +       struct nvmet_req *req = &target->req;
> +       struct nvme_command *cmd = req->cmd;
> +
> +       switch (cmd->identify.cns) {
> +       case NVME_ID_CNS_NS_PRESENT_LIST:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd)) {
> +                       __le32 *list = (__le32 *)map[0].pci.virt_addr;
> +
> +                       list[0] = cpu_to_le32(target->ns.nsid);
> +                       list[1] = 0;
> +                       return NVME_SC_SUCCESS;
> +               }
> +               break;
> +       case NVME_ID_CNS_CTRL_LIST:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd)) {
> +                       __le16 *list = (__le16 *)map[0].pci.virt_addr;
> +
> +                       list[0] = cpu_to_le16(1);
> +                       list[1] = cpu_to_le16(target->nvmet_ctrl->cntlid);
> +                       return NVME_SC_SUCCESS;
> +               }
> +               break;
> +       case NVME_ID_CNS_CTRL:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd)) {
> +                       struct nvme_id_ctrl *id;
> +                       int status;
> +
> +                       status = pci_epf_nvmet_execute_request(target, 0);
> +                       if (req->cqe->status)
> +                               return le16_to_cpu(req->cqe->status);
> +                       else if (status)
> +                               break;
> +
> +                       /* indicate no support for SGLs */
> +                       id = (struct nvme_id_ctrl *)map[0].pci.virt_addr;
> +                       id->sgls = 0;
> +                       return NVME_SC_SUCCESS;
> +               }
> +               break;
> +       case NVME_ID_CNS_NS:
> +       case NVME_ID_CNS_NS_ACTIVE_LIST:
> +       case NVME_ID_CNS_NS_DESC_LIST:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd))
> +                       return PCI_EPF_NVME_SYNC;
> +               break;
> +       default:
> +               return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +       }
> +
> +       return NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +}
> +
> +static int pci_epf_nvme_admin_set_features(struct pci_epf_nvme *nvme)
> +{
> +       struct nvme_command *cmd = nvme->target.req.cmd;
> +       u32 fid = le32_to_cpu(cmd->common.cdw10) & 0xff;
> +
> +       switch (fid) {
> +       case NVME_FEAT_ASYNC_EVENT:
> +               nvme->host.features.aec = le32_to_cpu(cmd->common.cdw11);
> +               return NVME_SC_SUCCESS;
> +       case NVME_FEAT_NUM_QUEUES:
> +       case NVME_FEAT_KATO:
> +       case NVME_FEAT_HOST_ID:
> +       case NVME_FEAT_WRITE_PROTECT:
> +               return PCI_EPF_NVME_SYNC;
> +       default:
> +               return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +       }
> +
> +       return NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +}
> +
> +static int pci_epf_nvme_admin_get_log_page(struct pci_epf_nvme *nvme)
> +{
> +       struct nvme_command *cmd = nvme->target.req.cmd;
> +       struct pci_epf_map *map = nvme->target.map;
> +
> +       switch (cmd->get_log_page.lid) {
> +       case NVME_LOG_CHANGED_NS:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd)) {
> +                       __le32 *list = (__le32 *)map[0].pci.virt_addr;
> +
> +                       list[0] = 0;
> +                       return NVME_SC_SUCCESS;
> +               }
> +               break;
> +       case NVME_LOG_ERROR:
> +       case NVME_LOG_SMART:
> +       case NVME_LOG_FW_SLOT:
> +       case NVME_LOG_CMD_EFFECTS:
> +       case NVME_LOG_ANA:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd))
> +                       return PCI_EPF_NVME_SYNC;
> +               break;
> +       default:
> +               return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +       }
> +
> +       return NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +}
> +
> +static int pci_epf_nvme_admin_create_cq(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct nvme_create_cq *cmd = (struct nvme_create_cq *)target->req.cmd;
> +       struct pci_epf_nvme_queue *cq;
> +       u16 cqid, cq_flags, qsize;
> +
> +       if (!cmd->cqid)
> +               return NVME_SC_SUCCESS;
> +
> +       cqid = le16_to_cpu(cmd->cqid);
> +       if (cqid > PCI_EPF_NVME_QIDMAX)
> +               return NVME_SC_QID_INVALID | NVME_SC_DNR;
> +
> +       cq_flags = le16_to_cpu(cmd->cq_flags);
> +       if (!(cq_flags & NVME_QUEUE_PHYS_CONTIG))
> +               return NVME_SC_INVALID_QUEUE | NVME_SC_DNR;
> +
> +       qsize = le16_to_cpu(cmd->qsize);
> +       if (!qsize)
> +               return NVME_SC_QUEUE_SIZE | NVME_SC_DNR;
> +
> +       if (cmd->irq_vector)
> +               return NVME_SC_INVALID_VECTOR | NVME_SC_DNR;
> +
> +       cq = &nvme->host.cq[cqid];
> +       cq->size = qsize;
> +       cq->flags = cq_flags;
> +       cq->map.host.phys_addr = cmd->prp1;
> +
> +       return NVME_SC_SUCCESS;
> +}
> +
> +static int pci_epf_nvme_admin_create_sq(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct nvme_create_sq *cmd = (struct nvme_create_sq *)target->req.cmd;
> +       struct pci_epf_nvme_queue *sq;
> +       u16 sqid, cqid, sq_flags, qsize;
> +
> +       if (!cmd->sqid)
> +               return NVME_SC_SUCCESS;
> +
> +       sqid = le16_to_cpu(cmd->sqid);
> +       if (sqid > PCI_EPF_NVME_QIDMAX)
> +               return NVME_SC_QID_INVALID | NVME_SC_DNR;
> +
> +       cqid = le16_to_cpu(cmd->cqid);
> +       if (sqid != cqid)
> +               return NVME_SC_CQ_INVALID | NVME_SC_DNR;
> +
> +       sq_flags = le16_to_cpu(cmd->sq_flags);
> +       if (sq_flags != NVME_QUEUE_PHYS_CONTIG)
> +               return NVME_SC_INVALID_QUEUE | NVME_SC_DNR;
> +
> +       qsize = le16_to_cpu(cmd->qsize);
> +       if (!qsize)
> +               return NVME_SC_QUEUE_SIZE | NVME_SC_DNR;
> +
> +       sq = &host->sq[sqid];
> +       sq->size = qsize;
> +       sq->flags = sq_flags;
> +       sq->map.host.phys_addr = cmd->prp1;
> +
> +       if (host->cmb.size)
> +               sq->map.pci.virt_addr = host->cmb.virt_dma_addr;
> +
> +       if (pci_epf_nvmet_connect(target, sqid, qsize, cmd->command_id))
> +               return NVME_SC_INTERNAL | NVME_SC_DNR;
> +
> +       if (pci_epf_nvme_host_queue_pair(nvme, sqid, cqid))
> +               return NVME_SC_INTERNAL | NVME_SC_DNR;
> +
> +       return NVME_SC_SUCCESS;
> +}
> +
> +static int pci_epf_nvme_admin_command(struct pci_epf_nvme *nvme)
> +{
> +       struct nvme_command *cmd = nvme->target.req.cmd;
> +
> +       if (cmd->common.flags & NVME_CMD_SGL_ALL)
> +               return NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +
> +       switch (cmd->common.opcode) {
> +       case nvme_admin_identify:
> +               return pci_epf_nvme_admin_identify(nvme);
> +       case nvme_admin_set_features:
> +               return pci_epf_nvme_admin_set_features(nvme);
> +       case nvme_admin_get_log_page:
> +               return pci_epf_nvme_admin_get_log_page(nvme);
> +       case nvme_admin_create_cq:
> +               return pci_epf_nvme_admin_create_cq(nvme);
> +       case nvme_admin_create_sq:
> +               return pci_epf_nvme_admin_create_sq(nvme);
> +       case nvme_admin_async_event:
> +               return PCI_EPF_NVME_ASYNC;
> +       case nvme_admin_get_features:
> +       case nvme_admin_keep_alive:
> +       case nvme_admin_abort_cmd:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd))
> +                       return PCI_EPF_NVME_SYNC;
> +               break;
> +       case nvme_admin_delete_sq:
> +       case nvme_admin_delete_cq:
> +       case nvme_admin_ns_attach:
> +               return NVME_SC_SUCCESS;
> +       default:
> +               return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +       }
> +
> +       return NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +}
> +
> +static int pci_epf_nvme_io_command(struct pci_epf_nvme *nvme)
> +{
> +       struct nvme_command *cmd = nvme->target.req.cmd;
> +
> +       switch (cmd->common.opcode) {
> +       case nvme_cmd_write:
> +       case nvme_cmd_read:
> +               if (pci_epf_nvme_map_dptr(nvme, cmd))
> +                       return PCI_EPF_NVME_SYNC;
> +               break;
> +       case nvme_cmd_dsm:
> +               if (pci_epf_nvme_map_prp1(nvme, cmd))
> +                       return PCI_EPF_NVME_SYNC;
> +               break;
> +       case nvme_cmd_flush:
> +       case nvme_cmd_write_zeroes:
> +               return PCI_EPF_NVME_SYNC;
> +       default:
> +               return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +       }
> +
> +       return NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +}
> +
> +static void pci_epf_nvme_admin_poll(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct nvmet_req *req = &target->req;
> +       struct nvme_command *cmd = req->cmd;
> +       struct nvme_completion *rsp = req->cqe;
> +       int qid = 0;
> +       int status;
> +       int head;
> +
> +       head = pci_epf_nvme_host_fetch(nvme, qid);
> +       if (head < 0)
> +               return;
> +
> +       status = pci_epf_nvme_admin_command(nvme);
> +       if (status >= NVME_SC_SUCCESS)
> +               rsp->status = cpu_to_le16(status << 1);
> +       else if (pci_epf_nvmet_execute_request(target, qid))
> +               dev_err(&nvme->epf->dev, "Failed to execute admin command\n");
> +
> +       if (status == PCI_EPF_NVME_ASYNC) {
> +               struct nvmet_ns *ns = &target->ns;
> +
> +               if (ns->enabled || nvmet_ns_enable(ns))
> +                       return;
> +
> +               wait_for_completion(&target->done);
> +       }
> +
> +       rsp->sq_head = cpu_to_le16(head);
> +       rsp->command_id = cmd->common.command_id;
> +       pci_epf_nvme_host_complete(nvme, qid);
> +}
> +
> +static void pci_epf_nvme_io_poll(struct pci_epf_nvme *nvme)
> +{
> +       struct pci_epf_nvme_target *target = &nvme->target;
> +       struct nvmet_req *req = &target->req;
> +       struct nvme_command *cmd = req->cmd;
> +       struct nvme_completion *rsp = req->cqe;
> +       int qid = 1;
> +       int status;
> +       int head;
> +
> +       head = pci_epf_nvme_host_fetch(nvme, qid);
> +       if (head < 0)
> +               return;
> +
> +       status = pci_epf_nvme_io_command(nvme);
> +       if (status >= NVME_SC_SUCCESS)
> +               rsp->status = cpu_to_le16(status << 1);
> +       else if (pci_epf_nvmet_execute_request(target, qid))
> +               dev_err(&nvme->epf->dev, "Failed to execute I/O command\n");
> +
> +       rsp->sq_head = cpu_to_le16(head);
> +       rsp->command_id = cmd->common.command_id;
> +       pci_epf_nvme_host_complete(nvme, qid);
> +}
> +
> +static void pci_epf_nvme_poll(struct work_struct *work)
> +{
> +       struct pci_epf_nvme *nvme = container_of(work, struct pci_epf_nvme,
> +                                                poll.work);
> +       struct pci_epf_nvme_host *host = &nvme->host;
> +       struct pci_epf *epf = nvme->epf;
> +       struct device *dev = &epf->dev;
> +
> +       nvme->tick++;
> +       host->cc = pci_epf_nvme_host_read32(host, NVME_REG_CC);
> +       if (host->cc & NVME_CC_ENABLE) {
> +               if ((host->csts & NVME_CSTS_RDY) == 0) {
> +                       dev_info(dev, "CC 0x%x NVME_CC_ENABLE set tick %d\n",
> +                                host->cc, nvme->tick);
> +                       pci_epf_nvme_target_start(nvme);
> +                       pci_epf_nvme_host_start(nvme);
> +               }
> +               pci_epf_nvme_admin_poll(nvme);
> +               pci_epf_nvme_io_poll(nvme);
> +               pci_epf_nvme_target_keep_alive(nvme);
> +       } else if (host->csts & NVME_CSTS_RDY) {
> +               dev_info(dev, "CC 0x%x NVME_CC_ENABLE clear tick %d\n",
> +                        host->cc, nvme->tick);
> +               pci_epf_nvme_host_stop(nvme);
> +               pci_epf_nvme_target_stop(nvme);
> +       }
> +
> +       queue_delayed_work(epf_nvme_workqueue, &nvme->poll,
> +                          msecs_to_jiffies(1));
> +}
> +
> +static void pci_epf_nvme_linkup(struct pci_epf *epf)
> +{
> +       struct pci_epf_nvme *nvme = epf_get_drvdata(epf);
> +
> +       queue_delayed_work(epf_nvme_workqueue, &nvme->poll,
> +                          msecs_to_jiffies(1));
> +}
> +
> +static void pci_epf_nvme_unbind(struct pci_epf *epf)
> +{
> +       struct pci_epf_nvme *nvme = epf_get_drvdata(epf);
> +       struct pci_epc *epc = epf->epc;
> +       struct pci_epf_bar *epf_bar;
> +       int bar;
> +
> +       cancel_delayed_work(&nvme->poll);
> +       pci_epc_stop(epc);
> +       for (bar = BAR_0; bar <= BAR_5; bar++) {
> +               epf_bar = &epf->bar[bar];
> +
> +               if (nvme->reg[bar]) {
> +                       pci_epc_clear_bar(epc, epf->func_no, epf_bar);
> +                       pci_epf_free_space(epf, nvme->reg[bar], bar);
> +               }
> +       }
> +
> +#ifdef CONFIG_PCI_ENDPOINT_DMAENGINE
> +       pci_epc_epf_exit(epc, epf);
> +#endif
> +}
> +
> +static int pci_epf_nvme_set_bar(struct pci_epf *epf)
> +{
> +       struct pci_epc *epc = epf->epc;
> +       struct pci_epf_nvme *nvme = epf_get_drvdata(epf);
> +       const struct pci_epc_features *features = nvme->epc_features;
> +       u8 reserved_bar = features ? features->reserved_bar : 0;
> +       enum pci_barno reg_bar = nvme->reg_bar;
> +       struct pci_epf_bar *epf_bar;
> +       int bar, add;
> +       int ret;
> +
> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
> +               epf_bar = &epf->bar[bar];
> +               /*
> +                * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> +                * if the specific implementation required a 64-bit BAR,
> +                * even if we only requested a 32-bit BAR.
> +                */
> +               add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +
> +               if (!!(reserved_bar & (1 << bar)))
> +                       continue;
> +
> +               ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
> +               if (ret) {
> +                       pci_epf_free_space(epf, nvme->reg[bar], bar);
> +                       dev_err(&epf->dev, "Failed to set BAR%d\n", bar);
> +                       if (bar == reg_bar)
> +                               return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int pci_epf_nvme_alloc_space(struct pci_epf *epf)
> +{
> +       struct pci_epf_nvme *nvme = epf_get_drvdata(epf);
> +       const struct pci_epc_features *features = nvme->epc_features;
> +       enum pci_barno reg_bar = nvme->reg_bar;
> +       struct device *dev = &epf->dev;
> +       struct pci_epf_bar *epf_bar;
> +       size_t align = PAGE_SIZE;
> +       u8 reserved_bar = 0;
> +       int bar, add;
> +       void *base;
> +
> +       if (features) {
> +               reserved_bar = features->reserved_bar;
> +               if (features->align)
> +                       align = features->align;
> +       }
> +
> +       base = pci_epf_alloc_space(epf, bar_size[reg_bar], reg_bar, align);
> +       if (!base) {
> +               dev_err(dev, "Failed to allocated register space\n");
> +               return -ENOMEM;
> +       }
> +       nvme->reg[reg_bar] = base;
> +
> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
> +               epf_bar = &epf->bar[bar];
> +               add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +
> +               if (bar == reg_bar)
> +                       continue;
> +
> +               if (!!(reserved_bar & (1 << bar)))
> +                       continue;
> +
> +               base = pci_epf_alloc_space(epf, bar_size[bar], bar, align);
> +               if (!base)
> +                       dev_err(dev, "Failed to allocate BAR%d space\n", bar);
> +               nvme->reg[bar] = base;
> +       }
> +
> +       return 0;
> +}
> +
> +static void pci_epf_configure_bar(struct pci_epf *epf,
> +                                 const struct pci_epc_features *features)
> +{
> +       u8 bar_fixed_64bit = features ? features->bar_fixed_64bit : 0;
> +       struct pci_epf_bar *epf_bar;
> +       int i;
> +
> +       for (i = BAR_0; i <= BAR_5; i++) {
> +               epf_bar = &epf->bar[i];
> +               if (!!(bar_fixed_64bit & (1 << i)))
> +                       epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +               if (features && features->bar_fixed_size[i])
> +                       bar_size[i] = features->bar_fixed_size[i];
> +       }
> +}
> +
> +static int pci_epf_nvme_bind(struct pci_epf *epf)
> +{
> +       int ret;
> +       struct pci_epf_nvme *nvme = epf_get_drvdata(epf);
> +       struct pci_epf_header *header = epf->header;
> +       const struct pci_epc_features *features;
> +       enum pci_barno reg_bar = BAR_0;
> +       struct pci_epc *epc = epf->epc;
> +       bool linkup_notifier = false;
> +       bool msix_capable = false;
> +       bool msi_capable = true;
> +
> +       if (WARN_ON_ONCE(!epc))
> +               return -EINVAL;
> +
> +       features = pci_epc_get_features(epc, epf->func_no);
> +       if (features) {
> +               linkup_notifier = features->linkup_notifier;
> +               msix_capable = features->msix_capable;
> +               msi_capable = features->msi_capable;
> +               reg_bar = pci_epc_get_first_free_bar(features);
> +               pci_epf_configure_bar(epf, features);
> +       }
> +
> +       nvme->epc_features = features;
> +       nvme->reg_bar = reg_bar;
> +
> +#ifdef CONFIG_PCI_ENDPOINT_DMAENGINE
> +       ret = pci_epc_epf_init(epc, epf);
> +       if (ret) {
> +               dev_err(&epf->dev, "Failed to initialize EPF\n");
> +               return ret;
> +       }
> +#endif
> +
> +       ret = pci_epc_write_header(epc, epf->func_no, header);
> +       if (ret) {
> +               dev_err(&epf->dev, "Configuration header write failed\n");
> +               return ret;
> +       }
> +
> +       ret = pci_epf_nvme_alloc_space(epf);
> +       if (ret)
> +               return ret;
> +
> +       ret = pci_epf_nvme_set_bar(epf);
> +       if (ret)
> +               return ret;
> +
> +       if (msi_capable) {
> +               ret = pci_epc_set_msi(epc, epf->func_no, epf->msi_interrupts);
> +               if (ret) {
> +                       dev_err(&epf->dev, "MSI configuration failed\n");
> +                       return ret;
> +               }
> +       }
> +
> +       if (msix_capable) {
> +               ret = pci_epc_set_msix(epc, epf->func_no, epf->msix_interrupts);
> +               if (ret) {
> +                       dev_err(&epf->dev, "MSI-X configuration failed\n");
> +                       return ret;
> +               }
> +       }
> +
> +       pci_epf_nvme_target_init(nvme);
> +       pci_epf_nvme_target_start(nvme);
> +       pci_epf_nvme_host_init(nvme);
> +       pci_epf_nvme_target_stop(nvme);
> +
> +       if (!linkup_notifier)
> +               queue_work(epf_nvme_workqueue, &nvme->poll.work);
> +
> +       return 0;
> +}
> +
> +static struct pci_epf_header epf_nvme_pci_header = {
> +       .vendorid       = PCI_ANY_ID,
> +       .deviceid       = PCI_ANY_ID,
> +       .progif_code    = 2, /* NVM Express */
> +       .subclass_code  = 8, /* Non-Volatile Memory controller */
> +       .baseclass_code = PCI_BASE_CLASS_STORAGE,
> +       .interrupt_pin  = PCI_INTERRUPT_INTA,
> +};
> +
> +static int pci_epf_nvme_probe(struct pci_epf *epf)
> +{
> +       struct pci_epf_nvme *nvme;
> +
> +       nvme = devm_kzalloc(&epf->dev, sizeof(*nvme), GFP_KERNEL);
> +       if (!nvme)
> +               return -ENOMEM;
> +
> +       epf->header = &epf_nvme_pci_header;
> +       nvme->epf = epf;
> +
> +       INIT_DELAYED_WORK(&nvme->poll, pci_epf_nvme_poll);
> +
> +       epf_set_drvdata(epf, nvme);
> +       return 0;
> +}
> +
> +static const struct pci_epf_device_id pci_epf_nvme_ids[] = {
> +       { .name = "pci_epf_nvme" },
> +       {},
> +};
> +
> +static struct pci_epf_ops pci_epf_nvme_ops = {
> +       .unbind = pci_epf_nvme_unbind,
> +       .bind   = pci_epf_nvme_bind,
> +       .linkup = pci_epf_nvme_linkup
> +};
> +
> +static struct pci_epf_driver epf_nvme_driver = {
> +       .driver.name    = "pci_epf_nvme",
> +       .probe          = pci_epf_nvme_probe,
> +       .id_table       = pci_epf_nvme_ids,
> +       .ops            = &pci_epf_nvme_ops,
> +       .owner          = THIS_MODULE
> +};
> +
> +static int __init pci_epf_nvme_init(void)
> +{
> +       int ret;
> +
> +       epf_nvme_workqueue = alloc_workqueue("kepfnvme",
> +                                            WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
> +       if (!epf_nvme_workqueue) {
> +               pr_err("Failed to allocate the ksvnvme work queue\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = pci_epf_register_driver(&epf_nvme_driver);
> +       if (ret) {
> +               pr_err("Failed to register pci epf nvme driver --> %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +module_init(pci_epf_nvme_init);
> +
> +static void __exit pci_epf_nvme_exit(void)
> +{
> +       pci_epf_unregister_driver(&epf_nvme_driver);
> +}
> +module_exit(pci_epf_nvme_exit);
> +
> +MODULE_DESCRIPTION("PCI EPF NVME FUNCTION DRIVER");
> +MODULE_AUTHOR("SiFive");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
+linux-pci@vger.kernel.org
