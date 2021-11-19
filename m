Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5945695B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 05:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhKSE7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 23:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSE7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 23:59:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408BC061574;
        Thu, 18 Nov 2021 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=lRXCjMK29T4/gyG/Olue4fZUtwEPwf37PoJ0RXT5pcw=; b=YE4Z1fWRmbHFZRmHKFnSFoCrjc
        wPOlPiSvjjjo2t1RVo5E/dGZr180IL9bJAbKWhjW6G2Xm+6Uxuo+oyiCEp/RVDm3JvkR7oySDCXy6
        CUFFEwrGsz0m5JKrjBw7FvD6i4qsF8AMB7SEtNafbY0nBrX4V0GK7W2oIXwQ376kzG0Zsq/Le0mK1
        EvefdA0qfRPBoCIRhW2uV1BjoVH0C3jBh0RfvUIOQUlxHcdFh+GmpaiTGDzxwcedvsVDSIP+8lpB0
        gYUl9VkvT/3eGgn0NwK/GJ1sY6/UMq0GUmlPi+liamF73zmuNZPefIYgHpLMcyXybtW8ktuJxfSbD
        1c33pqzg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnvx1-009Trx-Vj; Fri, 19 Nov 2021 04:56:40 +0000
Subject: Re: ERROR: modpost: "mips_cm_unlock_other"
 [drivers/pci/controller/pcie-mt7621.ko] undefined!
To:     kernel test robot <lkp@intel.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
References: <202111180317.mNAFaXap-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae386c44-c358-e8c8-ab86-2e27ce72df33@infradead.org>
Date:   Thu, 18 Nov 2021 20:56:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202111180317.mNAFaXap-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/17/21 11:09 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ee1703cda8dc777e937dec172da55beaf1a74919
> commit: 2bdd5238e756aac3ecbffc7c22b884485e84062e PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver
> date:   4 weeks ago
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bdd5238e756aac3ecbffc7c22b884485e84062e
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 2bdd5238e756aac3ecbffc7c22b884485e84062e
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>>> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!


This is one way to fix these build errors. Is that what the MIPS people
want to do or should their be APIs to access these base addresses and
mips_cm_is64 data?

---
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mips: kernel: export mips-cm and mips-cpc data & functions for pcie-mt7621

Fixes these build errors:

ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
  arch/mips/kernel/mips-cm.c  |    6 ++++++
  arch/mips/kernel/mips-cpc.c |    2 ++
  2 files changed, 8 insertions(+)

--- linux-next-20211118.orig/arch/mips/kernel/mips-cm.c
+++ linux-next-20211118/arch/mips/kernel/mips-cm.c
@@ -5,6 +5,7 @@
   */
  
  #include <linux/errno.h>
+#include <linux/export.h>
  #include <linux/percpu.h>
  #include <linux/spinlock.h>
  
@@ -12,8 +13,11 @@
  #include <asm/mipsregs.h>
  
  void __iomem *mips_gcr_base;
+EXPORT_SYMBOL(mips_gcr_base);
+
  void __iomem *mips_cm_l2sync_base;
  int mips_cm_is64;
+EXPORT_SYMBOL(mips_cm_is64);
  
  static char *cm2_tr[8] = {
  	"mem",	"gcr",	"gic",	"mmio",
@@ -352,6 +356,7 @@ void mips_cm_lock_other(unsigned int clu
  	 */
  	mb();
  }
+EXPORT_SYMBOL(mips_cm_lock_other);
  
  void mips_cm_unlock_other(void)
  {
@@ -368,6 +373,7 @@ void mips_cm_unlock_other(void)
  
  	preempt_enable();
  }
+EXPORT_SYMBOL(mips_cm_unlock_other);
  
  void mips_cm_error_report(void)
  {
--- linux-next-20211118.orig/arch/mips/kernel/mips-cpc.c
+++ linux-next-20211118/arch/mips/kernel/mips-cpc.c
@@ -5,6 +5,7 @@
   */
  
  #include <linux/errno.h>
+#include <linux/export.h>
  #include <linux/percpu.h>
  #include <linux/of.h>
  #include <linux/of_address.h>
@@ -13,6 +14,7 @@
  #include <asm/mips-cps.h>
  
  void __iomem *mips_cpc_base;
+EXPORT_SYMBOL(mips_cpc_base);
  
  static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
  

