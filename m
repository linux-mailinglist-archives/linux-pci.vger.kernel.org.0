Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD44319C1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJRMsd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 08:48:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:64461 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231724AbhJRMsd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 08:48:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="209031935"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="gz'50?scan'50,208,50";a="209031935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 05:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="gz'50?scan'50,208,50";a="443395692"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2021 05:46:18 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mcS1x-000BLX-Ib; Mon, 18 Oct 2021 12:46:17 +0000
Date:   Mon, 18 Oct 2021 20:45:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove the unused pci wrappers pci_pool_xxx()
Message-ID: <202110182052.wFGUaZ1G-lkp@intel.com>
References: <20211018081629.151-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20211018081629.151-1-caihuoqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on v5.15-rc6 next-20211018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cai-Huoqing/PCI-Remove-the-unused-pci-wrappers-pci_pool_xxx/20211018-161828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-randconfig-a015-20211018 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d245f2e8597bfb52c34810a328d42b990e4af1a4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/35cdbe7c76652cc75a170ef91c4dafac9773e8c0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cai-Huoqing/PCI-Remove-the-unused-pci-wrappers-pci_pool_xxx/20211018-161828
        git checkout 35cdbe7c76652cc75a170ef91c4dafac9773e8c0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/scsi/lpfc/lpfc_mem.c:92:25: error: implicit declaration of function 'dma_pool_create' [-Werror,-Wimplicit-function-declaration]
           phba->lpfc_mbuf_pool = dma_pool_create("lpfc_mbuf_pool", &phba->pcidev->dev,
                                  ^
   drivers/scsi/lpfc/lpfc_mem.c:92:25: note: did you mean 'mempool_create'?
   include/linux/mempool.h:40:19: note: 'mempool_create' declared here
   extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
                     ^
>> drivers/scsi/lpfc/lpfc_mem.c:92:23: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           phba->lpfc_mbuf_pool = dma_pool_create("lpfc_mbuf_pool", &phba->pcidev->dev,
                                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/lpfc/lpfc_mem.c:107:28: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
                   pool->elements[i].virt = dma_pool_alloc(phba->lpfc_mbuf_pool,
                                            ^
   drivers/scsi/lpfc/lpfc_mem.c:107:28: note: did you mean 'mempool_alloc'?
   include/linux/mempool.h:48:14: note: 'mempool_alloc' declared here
   extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
                ^
>> drivers/scsi/lpfc/lpfc_mem.c:107:26: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
                   pool->elements[i].virt = dma_pool_alloc(phba->lpfc_mbuf_pool,
                                          ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:131:23: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
                   phba->lpfc_hrb_pool = dma_pool_create("lpfc_hrb_pool",
                                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:137:23: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
                   phba->lpfc_drb_pool = dma_pool_create("lpfc_drb_pool",
                                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:144:23: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
                   phba->lpfc_hbq_pool = dma_pool_create("lpfc_hbq_pool",
                                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/lpfc/lpfc_mem.c:164:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(phba->lpfc_drb_pool);
           ^
   drivers/scsi/lpfc/lpfc_mem.c:164:2: note: did you mean 'mempool_destroy'?
   include/linux/mempool.h:47:13: note: 'mempool_destroy' declared here
   extern void mempool_destroy(mempool_t *pool);
               ^
>> drivers/scsi/lpfc/lpfc_mem.c:180:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_mbuf_pool, pool->elements[i].virt,
                   ^
   drivers/scsi/lpfc/lpfc_mem.c:194:3: error: implicit declaration of function 'dma_pool_create' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_create("lpfc_nvmet_drb_pool",
                   ^
   drivers/scsi/lpfc/lpfc_mem.c:193:28: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           phba->lpfc_nvmet_drb_pool =
                                     ^
   drivers/scsi/lpfc/lpfc_mem.c:223:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(phba->lpfc_nvmet_drb_pool);
           ^
   drivers/scsi/lpfc/lpfc_mem.c:252:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_mbuf_pool, pool->elements[i].virt,
                   ^
   drivers/scsi/lpfc/lpfc_mem.c:332:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
           ^
   drivers/scsi/lpfc/lpfc_mem.c:383:8: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
           ret = dma_pool_alloc(phba->lpfc_mbuf_pool, GFP_KERNEL, handle);
                 ^
   drivers/scsi/lpfc/lpfc_mem.c:383:6: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           ret = dma_pool_alloc(phba->lpfc_mbuf_pool, GFP_KERNEL, handle);
               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:419:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_mbuf_pool, virt, dma);
                   ^
   drivers/scsi/lpfc/lpfc_mem.c:467:8: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
           ret = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool, GFP_KERNEL, handle);
                 ^
   drivers/scsi/lpfc/lpfc_mem.c:467:6: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           ret = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool, GFP_KERNEL, handle);
               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:483:2: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
           dma_pool_free(phba->lpfc_sg_dma_buf_pool, virt, dma);
           ^
   drivers/scsi/lpfc/lpfc_mem.c:508:21: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
           hbqbp->dbuf.virt = dma_pool_alloc(phba->lpfc_hbq_pool, GFP_KERNEL,
                              ^
   drivers/scsi/lpfc/lpfc_mem.c:508:19: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           hbqbp->dbuf.virt = dma_pool_alloc(phba->lpfc_hbq_pool, GFP_KERNEL,
                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:533:2: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
           dma_pool_free(phba->lpfc_hbq_pool, hbqbp->dbuf.virt, hbqbp->dbuf.phys);
           ^
   drivers/scsi/lpfc/lpfc_mem.c:560:23: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
           dma_buf->hbuf.virt = dma_pool_alloc(phba->lpfc_hrb_pool, GFP_KERNEL,
                                ^
   drivers/scsi/lpfc/lpfc_mem.c:560:21: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           dma_buf->hbuf.virt = dma_pool_alloc(phba->lpfc_hrb_pool, GFP_KERNEL,
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:566:21: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           dma_buf->dbuf.virt = dma_pool_alloc(phba->lpfc_drb_pool, GFP_KERNEL,
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:569:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_hrb_pool, dma_buf->hbuf.virt,
                   ^
   drivers/scsi/lpfc/lpfc_mem.c:593:2: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
           dma_pool_free(phba->lpfc_hrb_pool, dmab->hbuf.virt, dmab->hbuf.phys);
           ^
   drivers/scsi/lpfc/lpfc_mem.c:618:23: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
           dma_buf->hbuf.virt = dma_pool_alloc(phba->lpfc_hrb_pool, GFP_KERNEL,
                                ^
   drivers/scsi/lpfc/lpfc_mem.c:618:21: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           dma_buf->hbuf.virt = dma_pool_alloc(phba->lpfc_hrb_pool, GFP_KERNEL,
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:624:21: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
           dma_buf->dbuf.virt = dma_pool_alloc(phba->lpfc_nvmet_drb_pool,
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_mem.c:627:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_hrb_pool, dma_buf->hbuf.virt,
                   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   13 warnings and 20 errors generated.
--
   drivers/scsi/lpfc/lpfc_sli.c:15629:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
           int i = 0;
               ^
>> drivers/scsi/lpfc/lpfc_sli.c:19245:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_drb_pool, pcmd->virt, pcmd->phys);
                   ^
   drivers/scsi/lpfc/lpfc_sli.c:19245:3: note: did you mean 'mempool_free'?
   include/linux/mempool.h:49:13: note: 'mempool_free' declared here
   extern void mempool_free(void *element, mempool_t *pool);
               ^
>> drivers/scsi/lpfc/lpfc_sli.c:19283:16: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
                   pcmd->virt = dma_pool_alloc(phba->lpfc_drb_pool, GFP_KERNEL,
                                ^
   drivers/scsi/lpfc/lpfc_sli.c:19283:16: note: did you mean 'mempool_alloc'?
   include/linux/mempool.h:48:14: note: 'mempool_alloc' declared here
   extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
                ^
>> drivers/scsi/lpfc/lpfc_sli.c:19283:14: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
                   pcmd->virt = dma_pool_alloc(phba->lpfc_drb_pool, GFP_KERNEL,
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_sli.c:19332:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_drb_pool, pcmd->virt, pcmd->phys);
                   ^
   drivers/scsi/lpfc/lpfc_sli.c:22226:18: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
                   tmp->dma_sgl = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool,
                                  ^
>> drivers/scsi/lpfc/lpfc_sli.c:22226:16: warning: incompatible integer to pointer conversion assigning to 'struct sli4_sge *' from 'int' [-Wint-conversion]
                   tmp->dma_sgl = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool,
                                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_sli.c:22312:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                   ^
   drivers/scsi/lpfc/lpfc_sli.c:22369:19: error: implicit declaration of function 'dma_pool_alloc' [-Werror,-Wimplicit-function-declaration]
                   tmp->fcp_cmnd = dma_pool_alloc(phba->lpfc_cmd_rsp_buf_pool,
                                   ^
>> drivers/scsi/lpfc/lpfc_sli.c:22369:17: warning: incompatible integer to pointer conversion assigning to 'struct fcp_cmnd *' from 'int' [-Wint-conversion]
                   tmp->fcp_cmnd = dma_pool_alloc(phba->lpfc_cmd_rsp_buf_pool,
                                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_sli.c:22462:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_cmd_rsp_buf_pool,
                   ^
   4 warnings and 7 errors generated.
--
>> drivers/scsi/lpfc/lpfc_init.c:3804:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_sg_dma_buf_pool, sb->data,
                   ^
   drivers/scsi/lpfc/lpfc_init.c:3804:3: note: did you mean 'mempool_free'?
   include/linux/mempool.h:49:13: note: 'mempool_free' declared here
   extern void mempool_free(void *element, mempool_t *pool);
               ^
   drivers/scsi/lpfc/lpfc_init.c:3815:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(phba->lpfc_sg_dma_buf_pool, sb->data,
                   ^
   drivers/scsi/lpfc/lpfc_init.c:3848:4: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                           dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                           ^
   drivers/scsi/lpfc/lpfc_init.c:3864:4: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                           dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                           ^
   drivers/scsi/lpfc/lpfc_init.c:4260:5: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                                   dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                                   ^
>> drivers/scsi/lpfc/lpfc_init.c:4330:21: error: implicit declaration of function 'dma_pool_zalloc' [-Werror,-Wimplicit-function-declaration]
                   lpfc_ncmd->data = dma_pool_zalloc(phba->lpfc_sg_dma_buf_pool,
                                     ^
   drivers/scsi/lpfc/lpfc_init.c:4330:21: note: did you mean 'mempool_alloc'?
   include/linux/mempool.h:48:14: note: 'mempool_alloc' declared here
   extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
                ^
>> drivers/scsi/lpfc/lpfc_init.c:4330:19: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
                   lpfc_ncmd->data = dma_pool_zalloc(phba->lpfc_sg_dma_buf_pool,
                                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/lpfc/lpfc_init.c:4353:5: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                                   dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                                   ^
   drivers/scsi/lpfc/lpfc_init.c:4365:4: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                           dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                           ^
   drivers/scsi/lpfc/lpfc_init.c:4375:4: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                           dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                           ^
>> drivers/scsi/lpfc/lpfc_init.c:7686:3: error: implicit declaration of function 'dma_pool_create' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_create("lpfc_sg_dma_buf_pool",
                   ^
   drivers/scsi/lpfc/lpfc_init.c:7686:3: note: did you mean 'mempool_create'?
   include/linux/mempool.h:40:19: note: 'mempool_create' declared here
   extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
                     ^
>> drivers/scsi/lpfc/lpfc_init.c:7685:29: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           phba->lpfc_sg_dma_buf_pool =
                                      ^
   drivers/scsi/lpfc/lpfc_init.c:7693:30: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           phba->lpfc_cmd_rsp_buf_pool =
                                       ^
>> drivers/scsi/lpfc/lpfc_init.c:7723:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
           ^
   drivers/scsi/lpfc/lpfc_init.c:7723:2: note: did you mean 'mempool_destroy'?
   include/linux/mempool.h:47:13: note: 'mempool_destroy' declared here
   extern void mempool_destroy(mempool_t *pool);
               ^
   drivers/scsi/lpfc/lpfc_init.c:8139:4: error: implicit declaration of function 'dma_pool_create' [-Werror,-Wimplicit-function-declaration]
                           dma_pool_create("lpfc_sg_dma_buf_pool",
                           ^
   drivers/scsi/lpfc/lpfc_init.c:8138:29: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           phba->lpfc_sg_dma_buf_pool =
                                      ^
   drivers/scsi/lpfc/lpfc_init.c:8146:30: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           phba->lpfc_cmd_rsp_buf_pool =
                                       ^
   drivers/scsi/lpfc/lpfc_init.c:8300:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(phba->lpfc_cmd_rsp_buf_pool);
           ^
   5 warnings and 13 errors generated.
--
>> drivers/scsi/lpfc/lpfc_scsi.c:349:15: error: implicit declaration of function 'dma_pool_zalloc' [-Werror,-Wimplicit-function-declaration]
                   psb->data = dma_pool_zalloc(phba->lpfc_sg_dma_buf_pool,
                               ^
   drivers/scsi/lpfc/lpfc_scsi.c:349:15: note: did you mean 'mempool_alloc'?
   include/linux/mempool.h:48:14: note: 'mempool_alloc' declared here
   extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
                ^
>> drivers/scsi/lpfc/lpfc_scsi.c:349:13: warning: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
                   psb->data = dma_pool_zalloc(phba->lpfc_sg_dma_buf_pool,
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/lpfc/lpfc_scsi.c:360:4: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                           dma_pool_free(phba->lpfc_sg_dma_buf_pool,
                           ^
   drivers/scsi/lpfc/lpfc_scsi.c:360:4: note: did you mean 'mempool_free'?
   include/linux/mempool.h:49:13: note: 'mempool_free' declared here
   extern void mempool_free(void *element, mempool_t *pool);
               ^
   1 warning and 2 errors generated.
--
>> drivers/net/ethernet/alacritech/slicoss.c:852:18: error: implicit declaration of function 'dma_pool_create' [-Werror,-Wimplicit-function-declaration]
           txq->dma_pool = dma_pool_create("slic_pool", &sdev->pdev->dev,
                           ^
   drivers/net/ethernet/alacritech/slicoss.c:852:18: note: did you mean 'page_pool_create'?
   include/net/page_pool.h:169:19: note: 'page_pool_create' declared here
   struct page_pool *page_pool_create(const struct page_pool_params *params);
                     ^
>> drivers/net/ethernet/alacritech/slicoss.c:852:16: warning: incompatible integer to pointer conversion assigning to 'struct dma_pool *' from 'int' [-Wint-conversion]
           txq->dma_pool = dma_pool_create("slic_pool", &sdev->pdev->dev,
                         ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/alacritech/slicoss.c:863:10: error: implicit declaration of function 'dma_pool_zalloc' [-Werror,-Wimplicit-function-declaration]
                   desc = dma_pool_zalloc(txq->dma_pool, GFP_KERNEL,
                          ^
>> drivers/net/ethernet/alacritech/slicoss.c:863:8: warning: incompatible integer to pointer conversion assigning to 'struct slic_tx_desc *' from 'int' [-Wint-conversion]
                   desc = dma_pool_zalloc(txq->dma_pool, GFP_KERNEL,
                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/alacritech/slicoss.c:884:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(txq->dma_pool, buff->desc, buff->desc_paddr);
                   ^
   drivers/net/ethernet/alacritech/slicoss.c:884:3: note: did you mean 'dma_pool_create'?
   drivers/net/ethernet/alacritech/slicoss.c:852:18: note: 'dma_pool_create' declared here
           txq->dma_pool = dma_pool_create("slic_pool", &sdev->pdev->dev,
                           ^
>> drivers/net/ethernet/alacritech/slicoss.c:886:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(txq->dma_pool);
           ^
   drivers/net/ethernet/alacritech/slicoss.c:886:2: note: did you mean 'page_pool_destroy'?
   include/net/page_pool.h:172:6: note: 'page_pool_destroy' declared here
   void page_pool_destroy(struct page_pool *pool);
        ^
   drivers/net/ethernet/alacritech/slicoss.c:902:3: error: implicit declaration of function 'dma_pool_free' [-Werror,-Wimplicit-function-declaration]
                   dma_pool_free(txq->dma_pool, buff->desc, buff->desc_paddr);
                   ^
   drivers/net/ethernet/alacritech/slicoss.c:911:2: error: implicit declaration of function 'dma_pool_destroy' [-Werror,-Wimplicit-function-declaration]
           dma_pool_destroy(txq->dma_pool);
           ^
   2 warnings and 6 errors generated.


vim +/dma_pool_create +92 drivers/scsi/lpfc/lpfc_mem.c

2e0fef85e098f6 James Smart       2007-06-17   68  
e59058c44025d7 James Smart       2008-08-24   69  /**
3621a710a7dbb2 James Smart       2009-04-06   70   * lpfc_mem_alloc - create and allocate all PCI and memory pools
e59058c44025d7 James Smart       2008-08-24   71   * @phba: HBA to allocate pools for
c734de98a7bc3d Lee Jones         2020-07-21   72   * @align: alignment requirement for blocks; must be a power of two
e59058c44025d7 James Smart       2008-08-24   73   *
d79c9e9d4b3d93 James Smart       2019-08-14   74   * Description: Creates and allocates PCI pools lpfc_mbuf_pool,
d79c9e9d4b3d93 James Smart       2019-08-14   75   * lpfc_hrb_pool.  Creates and allocates kmalloc-backed mempools
e59058c44025d7 James Smart       2008-08-24   76   * for LPFC_MBOXQ_t and lpfc_nodelist.  Also allocates the VPI bitmask.
e59058c44025d7 James Smart       2008-08-24   77   *
e59058c44025d7 James Smart       2008-08-24   78   * Notes: Not interrupt-safe.  Must be called with no locks held.  If any
e59058c44025d7 James Smart       2008-08-24   79   * allocation fails, frees all successfully allocated memory before returning.
e59058c44025d7 James Smart       2008-08-24   80   *
e59058c44025d7 James Smart       2008-08-24   81   * Returns:
e59058c44025d7 James Smart       2008-08-24   82   *   0 on success
e59058c44025d7 James Smart       2008-08-24   83   *   -ENOMEM on failure (if any memory allocations fail)
e59058c44025d7 James Smart       2008-08-24   84   **/
dea3101e0a5c89 James Bottomley   2005-04-17   85  int
da0436e915a5c1 James Smart       2009-05-22   86  lpfc_mem_alloc(struct lpfc_hba *phba, int align)
dea3101e0a5c89 James Bottomley   2005-04-17   87  {
dea3101e0a5c89 James Bottomley   2005-04-17   88  	struct lpfc_dma_pool *pool = &phba->lpfc_mbuf_safety_pool;
dea3101e0a5c89 James Bottomley   2005-04-17   89  	int i;
dea3101e0a5c89 James Bottomley   2005-04-17   90  
dea3101e0a5c89 James Bottomley   2005-04-17   91  
771db5c0e3f5da Romain Perier     2017-07-06  @92  	phba->lpfc_mbuf_pool = dma_pool_create("lpfc_mbuf_pool", &phba->pcidev->dev,
da0436e915a5c1 James Smart       2009-05-22   93  							LPFC_BPL_SIZE,
da0436e915a5c1 James Smart       2009-05-22   94  							align, 0);
dea3101e0a5c89 James Bottomley   2005-04-17   95  	if (!phba->lpfc_mbuf_pool)
d79c9e9d4b3d93 James Smart       2019-08-14   96  		goto fail;
dea3101e0a5c89 James Bottomley   2005-04-17   97  
6da2ec56059c3c Kees Cook         2018-06-12   98  	pool->elements = kmalloc_array(LPFC_MBUF_POOL_SIZE,
6da2ec56059c3c Kees Cook         2018-06-12   99  				       sizeof(struct lpfc_dmabuf),
6da2ec56059c3c Kees Cook         2018-06-12  100  				       GFP_KERNEL);
a96e0c7798057d Mariusz Kozlowski 2007-01-02  101  	if (!pool->elements)
a96e0c7798057d Mariusz Kozlowski 2007-01-02  102  		goto fail_free_lpfc_mbuf_pool;
a96e0c7798057d Mariusz Kozlowski 2007-01-02  103  
dea3101e0a5c89 James Bottomley   2005-04-17  104  	pool->max_count = 0;
dea3101e0a5c89 James Bottomley   2005-04-17  105  	pool->current_count = 0;
dea3101e0a5c89 James Bottomley   2005-04-17  106  	for ( i = 0; i < LPFC_MBUF_POOL_SIZE; i++) {
771db5c0e3f5da Romain Perier     2017-07-06 @107  		pool->elements[i].virt = dma_pool_alloc(phba->lpfc_mbuf_pool,
dea3101e0a5c89 James Bottomley   2005-04-17  108  				       GFP_KERNEL, &pool->elements[i].phys);
dea3101e0a5c89 James Bottomley   2005-04-17  109  		if (!pool->elements[i].virt)
dea3101e0a5c89 James Bottomley   2005-04-17  110  			goto fail_free_mbuf_pool;
dea3101e0a5c89 James Bottomley   2005-04-17  111  		pool->max_count++;
dea3101e0a5c89 James Bottomley   2005-04-17  112  		pool->current_count++;
dea3101e0a5c89 James Bottomley   2005-04-17  113  	}
dea3101e0a5c89 James Bottomley   2005-04-17  114  
e7dab164a9aa45 James Smart       2020-10-20  115  	phba->mbox_mem_pool = mempool_create_kmalloc_pool(LPFC_MBX_POOL_SIZE,
0eaae62abaa1ad Matthew Dobson    2006-03-26  116  							  sizeof(LPFC_MBOXQ_t));
dea3101e0a5c89 James Bottomley   2005-04-17  117  	if (!phba->mbox_mem_pool)
dea3101e0a5c89 James Bottomley   2005-04-17  118  		goto fail_free_mbuf_pool;
dea3101e0a5c89 James Bottomley   2005-04-17  119  
0eaae62abaa1ad Matthew Dobson    2006-03-26  120  	phba->nlp_mem_pool = mempool_create_kmalloc_pool(LPFC_MEM_POOL_SIZE,
0eaae62abaa1ad Matthew Dobson    2006-03-26  121  						sizeof(struct lpfc_nodelist));
dea3101e0a5c89 James Bottomley   2005-04-17  122  	if (!phba->nlp_mem_pool)
dea3101e0a5c89 James Bottomley   2005-04-17  123  		goto fail_free_mbox_pool;
8568a4d2495ebc James Smart       2009-07-19  124  
8568a4d2495ebc James Smart       2009-07-19  125  	if (phba->sli_rev == LPFC_SLI_REV4) {
19ca760979e4be James Smart       2010-11-20  126  		phba->rrq_pool =
9dace1fa91ca41 Dick Kennedy      2020-06-30  127  			mempool_create_kmalloc_pool(LPFC_RRQ_POOL_SIZE,
19ca760979e4be James Smart       2010-11-20  128  						sizeof(struct lpfc_node_rrq));
19ca760979e4be James Smart       2010-11-20  129  		if (!phba->rrq_pool)
19ca760979e4be James Smart       2010-11-20  130  			goto fail_free_nlp_mem_pool;
771db5c0e3f5da Romain Perier     2017-07-06  131  		phba->lpfc_hrb_pool = dma_pool_create("lpfc_hrb_pool",
771db5c0e3f5da Romain Perier     2017-07-06  132  					      &phba->pcidev->dev,
da0436e915a5c1 James Smart       2009-05-22  133  					      LPFC_HDR_BUF_SIZE, align, 0);
da0436e915a5c1 James Smart       2009-05-22  134  		if (!phba->lpfc_hrb_pool)
19ca760979e4be James Smart       2010-11-20  135  			goto fail_free_rrq_mem_pool;
8568a4d2495ebc James Smart       2009-07-19  136  
771db5c0e3f5da Romain Perier     2017-07-06  137  		phba->lpfc_drb_pool = dma_pool_create("lpfc_drb_pool",
771db5c0e3f5da Romain Perier     2017-07-06  138  					      &phba->pcidev->dev,
da0436e915a5c1 James Smart       2009-05-22  139  					      LPFC_DATA_BUF_SIZE, align, 0);
da0436e915a5c1 James Smart       2009-05-22  140  		if (!phba->lpfc_drb_pool)
8568a4d2495ebc James Smart       2009-07-19  141  			goto fail_free_hrb_pool;
8568a4d2495ebc James Smart       2009-07-19  142  		phba->lpfc_hbq_pool = NULL;
8568a4d2495ebc James Smart       2009-07-19  143  	} else {
771db5c0e3f5da Romain Perier     2017-07-06  144  		phba->lpfc_hbq_pool = dma_pool_create("lpfc_hbq_pool",
771db5c0e3f5da Romain Perier     2017-07-06  145  			&phba->pcidev->dev, LPFC_BPL_SIZE, align, 0);
8568a4d2495ebc James Smart       2009-07-19  146  		if (!phba->lpfc_hbq_pool)
8568a4d2495ebc James Smart       2009-07-19  147  			goto fail_free_nlp_mem_pool;
8568a4d2495ebc James Smart       2009-07-19  148  		phba->lpfc_hrb_pool = NULL;
8568a4d2495ebc James Smart       2009-07-19  149  		phba->lpfc_drb_pool = NULL;
8568a4d2495ebc James Smart       2009-07-19  150  	}
92d7f7b0cde3ad James Smart       2007-06-17  151  
1ba981fd3ad1f9 James Smart       2014-02-20  152  	if (phba->cfg_EnableXLane) {
1ba981fd3ad1f9 James Smart       2014-02-20  153  		phba->device_data_mem_pool = mempool_create_kmalloc_pool(
1ba981fd3ad1f9 James Smart       2014-02-20  154  					LPFC_DEVICE_DATA_POOL_SIZE,
1ba981fd3ad1f9 James Smart       2014-02-20  155  					sizeof(struct lpfc_device_data));
1ba981fd3ad1f9 James Smart       2014-02-20  156  		if (!phba->device_data_mem_pool)
895427bd012ce5 James Smart       2017-02-12  157  			goto fail_free_drb_pool;
1ba981fd3ad1f9 James Smart       2014-02-20  158  	} else {
1ba981fd3ad1f9 James Smart       2014-02-20  159  		phba->device_data_mem_pool = NULL;
1ba981fd3ad1f9 James Smart       2014-02-20  160  	}
1ba981fd3ad1f9 James Smart       2014-02-20  161  
dea3101e0a5c89 James Bottomley   2005-04-17  162  	return 0;
895427bd012ce5 James Smart       2017-02-12  163  fail_free_drb_pool:
771db5c0e3f5da Romain Perier     2017-07-06 @164  	dma_pool_destroy(phba->lpfc_drb_pool);
895427bd012ce5 James Smart       2017-02-12  165  	phba->lpfc_drb_pool = NULL;
8568a4d2495ebc James Smart       2009-07-19  166   fail_free_hrb_pool:
771db5c0e3f5da Romain Perier     2017-07-06  167  	dma_pool_destroy(phba->lpfc_hrb_pool);
da0436e915a5c1 James Smart       2009-05-22  168  	phba->lpfc_hrb_pool = NULL;
19ca760979e4be James Smart       2010-11-20  169   fail_free_rrq_mem_pool:
19ca760979e4be James Smart       2010-11-20  170  	mempool_destroy(phba->rrq_pool);
19ca760979e4be James Smart       2010-11-20  171  	phba->rrq_pool = NULL;
ed957684294618 James Smart       2007-06-17  172   fail_free_nlp_mem_pool:
ed957684294618 James Smart       2007-06-17  173  	mempool_destroy(phba->nlp_mem_pool);
ed957684294618 James Smart       2007-06-17  174  	phba->nlp_mem_pool = NULL;
dea3101e0a5c89 James Bottomley   2005-04-17  175   fail_free_mbox_pool:
dea3101e0a5c89 James Bottomley   2005-04-17  176  	mempool_destroy(phba->mbox_mem_pool);
2e0fef85e098f6 James Smart       2007-06-17  177  	phba->mbox_mem_pool = NULL;
dea3101e0a5c89 James Bottomley   2005-04-17  178   fail_free_mbuf_pool:
a96e0c7798057d Mariusz Kozlowski 2007-01-02  179  	while (i--)
771db5c0e3f5da Romain Perier     2017-07-06 @180  		dma_pool_free(phba->lpfc_mbuf_pool, pool->elements[i].virt,
dea3101e0a5c89 James Bottomley   2005-04-17  181  						 pool->elements[i].phys);
dea3101e0a5c89 James Bottomley   2005-04-17  182  	kfree(pool->elements);
a96e0c7798057d Mariusz Kozlowski 2007-01-02  183   fail_free_lpfc_mbuf_pool:
771db5c0e3f5da Romain Perier     2017-07-06  184  	dma_pool_destroy(phba->lpfc_mbuf_pool);
2e0fef85e098f6 James Smart       2007-06-17  185  	phba->lpfc_mbuf_pool = NULL;
dea3101e0a5c89 James Bottomley   2005-04-17  186   fail:
dea3101e0a5c89 James Bottomley   2005-04-17  187  	return -ENOMEM;
dea3101e0a5c89 James Bottomley   2005-04-17  188  }
dea3101e0a5c89 James Bottomley   2005-04-17  189  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--sm4nu43k4a2Rpi4c--
