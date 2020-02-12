Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF7C15B363
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLWIA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 17:08:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:64968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgBLWIA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 17:08:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 14:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281352672"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Feb 2020 14:07:57 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j20Am-0001IO-Jc; Thu, 13 Feb 2020 06:07:56 +0800
Date:   Thu, 13 Feb 2020 06:07:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: [pci:pci/review/cpumask] BUILD REGRESSION
 50fcb29e443db489b159054e9d5f4d8663812da2
Message-ID: <5e44771d.omXSZehDBRQLl+f/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git  pci/review/cpumask
branch HEAD: 50fcb29e443db489b159054e9d5f4d8663812da2  Unify ia64

Regressions in current branch:

arch/ia64/include/asm/topology.h:29:24: warning: pointer type mismatch in conditional expression
arch/ia64/include/asm/topology.h:52:6: note: in expansion of macro 'cpumask_of_node'
arch/ia64/kernel/acpi.c:862:20: note: in expansion of macro 'cpumask_of_node'
arch/ia64/kernel/iosapic.c:658:14: note: in expansion of macro 'cpumask_of_node'
arch/ia64/kernel/numa.c:27:28: error: passing argument 2 of 'cpumask_test_cpu' from incompatible pointer type [-Werror=incompatible-pointer-types]
arch/ia64/kernel/numa.c:35:23: error: passing argument 2 of 'cpumask_set_cpu' from incompatible pointer type [-Werror=incompatible-pointer-types]
arch/ia64/kernel/numa.c:44:25: error: passing argument 2 of 'cpumask_clear_cpu' from incompatible pointer type [-Werror=incompatible-pointer-types]
arch/ia64/kernel/numa.c:59:17: error: passing argument 1 of 'cpumask_clear' from incompatible pointer type [-Werror=incompatible-pointer-types]
arch/s390/include/asm/topology.h:81:9: error: return from incompatible pointer type [-Werror=incompatible-pointer-types]
arch/sparc/include/asm/topology_64.h:15:24: warning: pointer type mismatch in conditional expression
arch/sparc/include/asm/topology_64.h:31:3: note: in expansion of macro 'cpumask_of_node'
arch/sparc/kernel/of_device_64.c:629:28: note: in expansion of macro 'cpumask_of_node'
arch/sparc/kernel/pci_msi.c:290:28: note: in expansion of macro 'cpumask_of_node'
arch/sparc/mm/init_64.c:1126:17: error: passing argument 1 of 'cpumask_setall' from incompatible pointer type [-Werror=incompatible-pointer-types]
arch/sparc/mm/init_64.c:1464:15: error: passing argument 1 of 'cpumask_copy' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/base/node.c:42:20: note: in expansion of macro 'cpumask_of_node'
drivers/base/node.c:43:20: note: in expansion of macro 'cpumask_of_node'
drivers/block/mtip32xx/mtip32xx.c:3896:14: note: in expansion of macro 'cpumask_of_node'
drivers/block/mtip32xx/mtip32xx.c:4078:3: note: in expansion of macro 'dev_info'
drivers/dma/dmaengine.c:228:25: note: in expansion of macro 'cpumask_of_node'
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:1421:21: note: in expansion of macro 'cpumask_of_node'
drivers/pci/pci-driver.c:356:25: note: in expansion of macro 'cpumask_of_node'
drivers/pci/pci-driver.c:356:9: note: in expansion of macro 'cpumask_any_and'
drivers/pci/pci-sysfs.c:112:34: note: in expansion of macro 'cpumask_of_pcibus'
drivers/pci/pci-sysfs.c:85:8: note: in expansion of macro 'cpumask_of_node'
drivers/scsi/megaraid/megaraid_sas_base.c:5789:5: note: in expansion of macro 'cpumask_of_node'
drivers/scsi/mpt3sas/mpt3sas_base.c:3017:17: note: in expansion of macro 'cpumask_of_node'
include/linux/dev_printk.h:110:33: note: in expansion of macro 'nr_cpus_node'
include/linux/topology.h:227:9: note: in expansion of macro 'cpumask_of_node'
include/linux/topology.h:44:7: note: in expansion of macro 'nr_cpus_node'
kernel/irq/manage.c:468:36: note: in expansion of macro 'cpumask_of_node'
kernel/sched/core.c:2037:14: note: in expansion of macro 'cpumask_of_node'
kernel/sched/core.c:2039:14: note: in expansion of macro 'cpumask_of_node'
kernel/sched/core.c:2048:14: note: in expansion of macro 'cpumask_of_node'
kernel/sched/core.c:2050:14: note: in expansion of macro 'cpumask_of_node'
kernel/sched/topology.c:1644:28: note: in expansion of macro 'cpumask_of_node'
kernel/sched/topology.c:1653:28: note: in expansion of macro 'cpumask_of_node'
kernel/smp.c:382:13: note: in expansion of macro 'cpumask_of_node'
kernel/workqueue.c:1549:24: note: in expansion of macro 'cpumask_of_node'
kernel/workqueue.c:1549:8: note: in expansion of macro 'cpumask_any_and'
lib/cpu_rmap.c:183:7: note: in expansion of macro 'cpumask_of_node'
lib/cpumask.c:219:25: note: in expansion of macro 'cpumask_of_node'
mm/compaction.c:2633:34: note: in expansion of macro 'cpumask_of_node'
mm/compaction.c:2635:34: note: in expansion of macro 'cpumask_of_node'
mm/page_alloc.c:1775:34: note: in expansion of macro 'cpumask_of_node'
mm/page_alloc.c:5524:30: note: in expansion of macro 'cpumask_of_node'
mm/slab.c:819:24: note: in expansion of macro 'nr_cpus_node'
mm/slab.c:945:31: note: in expansion of macro 'cpumask_of_node'
mm/vmscan.c:3873:34: note: in expansion of macro 'cpumask_of_node'
mm/vmscan.c:3898:34: note: in expansion of macro 'cpumask_of_node'
mm/vmscan.c:3968:34: note: in expansion of macro 'cpumask_of_node'
mm/vmstat.c:1918:22: note: in expansion of macro 'cpumask_of_node'
mm/vmstat.c:1920:22: note: in expansion of macro 'cpumask_of_node'
mm/vmstat.c:1968:22: note: in expansion of macro 'cpumask_of_node'
net/sunrpc/svc.c:124:6: note: in expansion of macro 'nr_cpus_node'
net/sunrpc/svc.c:205:2: note: in expansion of macro 'for_each_node_with_cpus'
net/sunrpc/svc.c:324:30: note: in expansion of macro 'cpumask_of_node'

Error ids grouped by kconfigs:

recent_errors
|-- ia64-alldefconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   `-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|-- ia64-allmodconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-dev_info
|   |-- drivers-dma-dmaengine.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-net-ethernet-hisilicon-hns3-hns3pf-hclge_main.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- drivers-scsi-megaraid-megaraid_sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-scsi-mpt3sas-mpt3sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-dev_printk.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- ia64-allnoconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   `-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|-- ia64-allyesconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-dev_info
|   |-- drivers-dma-dmaengine.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-net-ethernet-hisilicon-hns3-hns3pf-hclge_main.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- drivers-scsi-megaraid-megaraid_sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-scsi-mpt3sas-mpt3sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-dev_printk.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- ia64-bigsur_defconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- ia64-defconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- ia64-generic_defconfig
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- ia64-randconfig-a001-20200212
|   |-- arch-ia64-include-asm-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-include-asm-topology.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-ia64-kernel-acpi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-iosapic.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_clear_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_set_cpu-from-incompatible-pointer-type
|   |-- arch-ia64-kernel-numa.c:error:passing-argument-of-cpumask_test_cpu-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-dma-dmaengine.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- s390-allmodconfig
|   `-- arch-s390-include-asm-topology.h:error:return-from-incompatible-pointer-type
|-- s390-allyesconfig
|   `-- arch-s390-include-asm-topology.h:error:return-from-incompatible-pointer-type
|-- s390-debug_defconfig
|   `-- arch-s390-include-asm-topology.h:error:return-from-incompatible-pointer-type
|-- s390-defconfig
|   `-- arch-s390-include-asm-topology.h:error:return-from-incompatible-pointer-type
|-- s390-randconfig-a001-20200212
|   `-- arch-s390-include-asm-topology.h:error:return-from-incompatible-pointer-type
|-- sparc-allmodconfig
|   |-- arch-sparc-include-asm-topology_64.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_copy-from-incompatible-pointer-type
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_setall-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-dev_info
|   |-- include-linux-dev_printk.h:note:in-expansion-of-macro-nr_cpus_node
|   `-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|-- sparc-allyesconfig
|   |-- arch-sparc-include-asm-topology_64.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-include-asm-topology_64.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-sparc-kernel-of_device_64.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-kernel-pci_msi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_copy-from-incompatible-pointer-type
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_setall-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-dev_info
|   |-- drivers-dma-dmaengine.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-net-ethernet-hisilicon-hns3-hns3pf-hclge_main.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- drivers-scsi-megaraid-megaraid_sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-scsi-mpt3sas-mpt3sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-dev_printk.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- sparc64-allmodconfig
|   |-- arch-sparc-include-asm-topology_64.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-include-asm-topology_64.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-sparc-kernel-of_device_64.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-kernel-pci_msi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_copy-from-incompatible-pointer-type
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_setall-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-dev_info
|   |-- drivers-dma-dmaengine.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-net-ethernet-hisilicon-hns3-hns3pf-hclge_main.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- drivers-scsi-megaraid-megaraid_sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-scsi-mpt3sas-mpt3sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-dev_printk.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- sparc64-allyesconfig
|   |-- arch-sparc-include-asm-topology_64.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-include-asm-topology_64.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-sparc-kernel-of_device_64.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-kernel-pci_msi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_copy-from-incompatible-pointer-type
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_setall-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-block-mtip32xx-mtip32xx.c:note:in-expansion-of-macro-dev_info
|   |-- drivers-dma-dmaengine.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-net-ethernet-hisilicon-hns3-hns3pf-hclge_main.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- drivers-scsi-megaraid-megaraid_sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-scsi-mpt3sas-mpt3sas_base.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-dev_printk.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
|   `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node
|-- sparc64-defconfig
|   |-- arch-sparc-include-asm-topology_64.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-include-asm-topology_64.h:warning:pointer-type-mismatch-in-conditional-expression
|   |-- arch-sparc-kernel-of_device_64.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-kernel-pci_msi.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_copy-from-incompatible-pointer-type
|   |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_setall-from-incompatible-pointer-type
|   |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
|   |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
|   |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-slab.c:note:in-expansion-of-macro-cpumask_of_node
|   |-- mm-slab.c:note:in-expansion-of-macro-nr_cpus_node
|   |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
|   `-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
`-- sparc64-randconfig-a001-20200212
    |-- arch-sparc-include-asm-topology_64.h:note:in-expansion-of-macro-cpumask_of_node
    |-- arch-sparc-include-asm-topology_64.h:warning:pointer-type-mismatch-in-conditional-expression
    |-- arch-sparc-kernel-of_device_64.c:note:in-expansion-of-macro-cpumask_of_node
    |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_copy-from-incompatible-pointer-type
    |-- arch-sparc-mm-init_64.c:error:passing-argument-of-cpumask_setall-from-incompatible-pointer-type
    |-- drivers-base-node.c:note:in-expansion-of-macro-cpumask_of_node
    |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_any_and
    |-- drivers-pci-pci-driver.c:note:in-expansion-of-macro-cpumask_of_node
    |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_node
    |-- drivers-pci-pci-sysfs.c:note:in-expansion-of-macro-cpumask_of_pcibus
    |-- include-linux-topology.h:note:in-expansion-of-macro-cpumask_of_node
    |-- include-linux-topology.h:note:in-expansion-of-macro-nr_cpus_node
    |-- kernel-irq-manage.c:note:in-expansion-of-macro-cpumask_of_node
    |-- kernel-sched-core.c:note:in-expansion-of-macro-cpumask_of_node
    |-- kernel-sched-topology.c:note:in-expansion-of-macro-cpumask_of_node
    |-- kernel-smp.c:note:in-expansion-of-macro-cpumask_of_node
    |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_any_and
    |-- kernel-workqueue.c:note:in-expansion-of-macro-cpumask_of_node
    |-- lib-cpu_rmap.c:note:in-expansion-of-macro-cpumask_of_node
    |-- lib-cpumask.c:note:in-expansion-of-macro-cpumask_of_node
    |-- mm-compaction.c:note:in-expansion-of-macro-cpumask_of_node
    |-- mm-page_alloc.c:note:in-expansion-of-macro-cpumask_of_node
    |-- mm-slab.c:note:in-expansion-of-macro-cpumask_of_node
    |-- mm-slab.c:note:in-expansion-of-macro-nr_cpus_node
    |-- mm-vmscan.c:note:in-expansion-of-macro-cpumask_of_node
    |-- mm-vmstat.c:note:in-expansion-of-macro-cpumask_of_node
    |-- net-sunrpc-svc.c:note:in-expansion-of-macro-cpumask_of_node
    |-- net-sunrpc-svc.c:note:in-expansion-of-macro-for_each_node_with_cpus
    `-- net-sunrpc-svc.c:note:in-expansion-of-macro-nr_cpus_node

elapsed time: 2884m

configs tested: 275
configs skipped: 22

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
csky                                defconfig
s390                                defconfig
riscv                    nommu_virt_defconfig
sparc                               defconfig
nds32                             allnoconfig
mips                      fuloong2e_defconfig
s390                       zfcpdump_defconfig
i386                                defconfig
sh                                allnoconfig
riscv                          rv32_defconfig
s390                             allyesconfig
riscv                               defconfig
nds32                               defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
powerpc                             defconfig
s390                             allmodconfig
mips                             allyesconfig
sh                  sh7785lcr_32bit_defconfig
m68k                       m5475evb_defconfig
um                           x86_64_defconfig
h8300                       h8s-sim_defconfig
ia64                              allnoconfig
parisc                              defconfig
powerpc                           allnoconfig
ia64                             allyesconfig
h8300                     edosk2674_defconfig
s390                          debug_defconfig
i386                             alldefconfig
powerpc                       ppc64_defconfig
mips                              allnoconfig
alpha                               defconfig
ia64                             alldefconfig
i386                              allnoconfig
microblaze                    nommu_defconfig
mips                      malta_kvm_defconfig
m68k                           sun3_defconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
i386                 randconfig-a003-20200211
i386                 randconfig-a001-20200211
i386                 randconfig-a002-20200211
x86_64               randconfig-a002-20200211
x86_64               randconfig-a003-20200211
x86_64               randconfig-a001-20200211
x86_64               randconfig-a001-20200212
x86_64               randconfig-a002-20200212
x86_64               randconfig-a003-20200212
i386                 randconfig-a001-20200212
i386                 randconfig-a002-20200212
i386                 randconfig-a003-20200212
x86_64               randconfig-a001-20200213
x86_64               randconfig-a002-20200213
x86_64               randconfig-a003-20200213
i386                 randconfig-a001-20200213
i386                 randconfig-a002-20200213
i386                 randconfig-a003-20200213
parisc               randconfig-a001-20200211
riscv                randconfig-a001-20200211
mips                 randconfig-a001-20200211
m68k                 randconfig-a001-20200211
nds32                randconfig-a001-20200211
alpha                randconfig-a001-20200211
alpha                randconfig-a001-20200212
m68k                 randconfig-a001-20200212
nds32                randconfig-a001-20200212
parisc               randconfig-a001-20200212
riscv                randconfig-a001-20200212
c6x                  randconfig-a001-20200211
h8300                randconfig-a001-20200211
microblaze           randconfig-a001-20200211
nios2                randconfig-a001-20200211
sparc64              randconfig-a001-20200211
c6x                  randconfig-a001-20200212
h8300                randconfig-a001-20200212
microblaze           randconfig-a001-20200212
nios2                randconfig-a001-20200212
sparc64              randconfig-a001-20200212
csky                 randconfig-a001-20200212
openrisc             randconfig-a001-20200212
s390                 randconfig-a001-20200212
sh                   randconfig-a001-20200212
xtensa               randconfig-a001-20200212
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
sh                   randconfig-a001-20200211
s390                 randconfig-a001-20200211
xtensa               randconfig-a001-20200211
openrisc             randconfig-a001-20200211
csky                 randconfig-a001-20200211
x86_64               randconfig-b001-20200211
x86_64               randconfig-b002-20200211
x86_64               randconfig-b003-20200211
i386                 randconfig-b001-20200211
i386                 randconfig-b002-20200211
i386                 randconfig-b003-20200211
x86_64               randconfig-b001-20200212
x86_64               randconfig-b002-20200212
x86_64               randconfig-b003-20200212
i386                 randconfig-b001-20200212
i386                 randconfig-b002-20200212
i386                 randconfig-b003-20200212
x86_64               randconfig-b001-20200213
x86_64               randconfig-b002-20200213
x86_64               randconfig-b003-20200213
i386                 randconfig-b001-20200213
i386                 randconfig-b002-20200213
i386                 randconfig-b003-20200213
i386                 randconfig-c002-20200211
x86_64               randconfig-c003-20200211
i386                 randconfig-c001-20200211
x86_64               randconfig-c002-20200211
x86_64               randconfig-c001-20200211
i386                 randconfig-c003-20200211
x86_64               randconfig-c001-20200212
x86_64               randconfig-c002-20200212
x86_64               randconfig-c003-20200212
i386                 randconfig-c001-20200212
i386                 randconfig-c002-20200212
i386                 randconfig-c003-20200212
x86_64               randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
i386                 randconfig-c002-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-d001-20200212
x86_64               randconfig-d002-20200212
x86_64               randconfig-d003-20200212
i386                 randconfig-d001-20200212
i386                 randconfig-d002-20200212
i386                 randconfig-d003-20200212
x86_64               randconfig-d001-20200211
x86_64               randconfig-d002-20200211
x86_64               randconfig-d003-20200211
i386                 randconfig-d001-20200211
i386                 randconfig-d002-20200211
i386                 randconfig-d003-20200211
i386                 randconfig-e001-20200211
i386                 randconfig-e003-20200211
x86_64               randconfig-e001-20200211
x86_64               randconfig-e002-20200211
i386                 randconfig-e002-20200211
x86_64               randconfig-e003-20200211
x86_64               randconfig-e001-20200212
x86_64               randconfig-e002-20200212
x86_64               randconfig-e003-20200212
i386                 randconfig-e001-20200212
i386                 randconfig-e002-20200212
i386                 randconfig-e003-20200212
x86_64               randconfig-e001-20200213
x86_64               randconfig-e002-20200213
x86_64               randconfig-e003-20200213
i386                 randconfig-e001-20200213
i386                 randconfig-e002-20200213
i386                 randconfig-e003-20200213
x86_64               randconfig-f001-20200212
x86_64               randconfig-f002-20200212
x86_64               randconfig-f003-20200212
i386                 randconfig-f001-20200212
i386                 randconfig-f002-20200212
i386                 randconfig-f003-20200212
x86_64               randconfig-f001-20200211
x86_64               randconfig-f002-20200211
x86_64               randconfig-f003-20200211
i386                 randconfig-f001-20200211
i386                 randconfig-f002-20200211
i386                 randconfig-f003-20200211
x86_64               randconfig-g001-20200211
x86_64               randconfig-g002-20200211
x86_64               randconfig-g003-20200211
i386                 randconfig-g001-20200211
i386                 randconfig-g002-20200211
i386                 randconfig-g003-20200211
x86_64               randconfig-g001-20200212
x86_64               randconfig-g002-20200212
x86_64               randconfig-g003-20200212
i386                 randconfig-g001-20200212
i386                 randconfig-g002-20200212
i386                 randconfig-g003-20200212
x86_64               randconfig-g001-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-g003-20200213
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-h001-20200211
x86_64               randconfig-h002-20200211
x86_64               randconfig-h003-20200211
i386                 randconfig-h001-20200211
i386                 randconfig-h002-20200211
i386                 randconfig-h003-20200211
x86_64               randconfig-h001-20200212
x86_64               randconfig-h002-20200212
x86_64               randconfig-h003-20200212
i386                 randconfig-h001-20200212
i386                 randconfig-h002-20200212
i386                 randconfig-h003-20200212
x86_64               randconfig-h001-20200213
x86_64               randconfig-h002-20200213
x86_64               randconfig-h003-20200213
i386                 randconfig-h001-20200213
i386                 randconfig-h002-20200213
i386                 randconfig-h003-20200213
arc                  randconfig-a001-20200211
arm                  randconfig-a001-20200211
arm64                randconfig-a001-20200211
ia64                 randconfig-a001-20200211
powerpc              randconfig-a001-20200211
sparc                randconfig-a001-20200211
arc                  randconfig-a001-20200212
arm                  randconfig-a001-20200212
arm64                randconfig-a001-20200212
ia64                 randconfig-a001-20200212
powerpc              randconfig-a001-20200212
sparc                randconfig-a001-20200212
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
s390                             alldefconfig
s390                              allnoconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
