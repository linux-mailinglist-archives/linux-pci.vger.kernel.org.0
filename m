Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7B705E2B
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 05:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjEQDiC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 23:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjEQDiA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 23:38:00 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523F134;
        Tue, 16 May 2023 20:37:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vir4JUF_1684294672;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vir4JUF_1684294672)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 11:37:54 +0800
Message-ID: <10fa299e-f742-4c5c-e252-6bb7db772850@linux.alibaba.com>
Date:   Wed, 17 May 2023 11:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <20230516130110.59632-4-xueshuai@linux.alibaba.com>
 <202305170639.XU3djFZX-lkp@intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <202305170639.XU3djFZX-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/17 07:21, kernel test robot wrote:
> Hi Shuai,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus soc/for-next linus/master v6.4-rc2 next-20230516]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-move-Alibaba-Vendor-ID-linux-pci_ids-h/20230517-013326
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20230516130110.59632-4-xueshuai%40linux.alibaba.com
> patch subject: [PATCH v4 3/4] drivers/perf: add DesignWare PCIe PMU driver
> config: sh-allmodconfig
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/f576345a26fff4584ed49f0f42e03c65d8a7f2bf
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Shuai-Xue/PCI-move-Alibaba-Vendor-ID-linux-pci_ids-h/20230517-013326
>         git checkout f576345a26fff4584ed49f0f42e03c65d8a7f2bf
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/perf/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305170639.XU3djFZX-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/perf/dwc_pcie_pmu.c: In function '__dwc_pcie_pmu_probe':
>>> drivers/perf/dwc_pcie_pmu.c:507:24: error: implicit declaration of function 'pci_find_vsec_capability'; did you mean 'pci_find_ext_capability'? [-Werror=implicit-function-declaration]
>      507 |                 vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>          |                        pci_find_ext_capability
>    cc1: some warnings being treated as errors

This will be fixed by:

- remove COMPILE_TEST and add depend on PCI in kconfig

Thank you.
Shuai

> 
> vim +507 drivers/perf/dwc_pcie_pmu.c
> 
>    487	
>    488	static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv)
>    489	{
>    490		struct pci_dev *pdev = NULL;
>    491		struct dwc_pcie_pmu *pcie_pmu;
>    492		char *name;
>    493		u32 bdf;
>    494		int ret;
>    495	
>    496		INIT_LIST_HEAD(&priv->pmu_nodes);
>    497	
>    498		/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
>    499		for_each_pci_dev(pdev) {
>    500			u16 vsec;
>    501			u32 val;
>    502	
>    503			if (!(pci_is_pcie(pdev) &&
>    504			      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>    505				continue;
>    506	
>  > 507			vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>    508							DWC_PCIE_VSEC_RAS_DES_ID);
>    509			if (!vsec)
>    510				continue;
>    511	
>    512			pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
>    513			if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
>    514			    PCI_VNDR_HEADER_LEN(val) != 0x100)
>    515				continue;
>    516			pci_dbg(pdev,
>    517				"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
>    518	
>    519			bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
>    520			name = devm_kasprintf(priv->dev, GFP_KERNEL, "dwc_rootport_%x",
>    521					      bdf);
>    522			if (!name)
>    523				return -ENOMEM;
>    524	
>    525			/* All checks passed, go go go */
>    526			pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
>    527			if (!pcie_pmu) {
>    528				pci_dev_put(pdev);
>    529				return -ENOMEM;
>    530			}
>    531	
>    532			pcie_pmu->pdev = pdev;
>    533			pcie_pmu->ras_des = vsec;
>    534			pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
>    535			pcie_pmu->pmu = (struct pmu){
>    536				.module		= THIS_MODULE,
>    537				.attr_groups	= dwc_pcie_attr_groups,
>    538				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>    539				.task_ctx_nr	= perf_invalid_context,
>    540				.event_init	= dwc_pcie_pmu_event_init,
>    541				.add		= dwc_pcie_pmu_event_add,
>    542				.del		= dwc_pcie_pmu_event_del,
>    543				.start		= dwc_pcie_pmu_event_start,
>    544				.stop		= dwc_pcie_pmu_event_stop,
>    545				.read		= dwc_pcie_pmu_event_update,
>    546			};
>    547	
>    548			/* Add this instance to the list used by the offline callback */
>    549			ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
>    550						       &pcie_pmu->cpuhp_node);
>    551			if (ret) {
>    552				pci_err(pcie_pmu->pdev,
>    553					"Error %d registering hotplug @%x\n", ret, bdf);
>    554				return ret;
>    555			}
>    556			ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
>    557			if (ret) {
>    558				pci_err(pcie_pmu->pdev,
>    559					"Error %d registering PMU @%x\n", ret, bdf);
>    560				cpuhp_state_remove_instance_nocalls(
>    561					dwc_pcie_pmu_hp_state, &pcie_pmu->cpuhp_node);
>    562				return ret;
>    563			}
>    564	
>    565			/* Add registered PMUs and unregister them when this driver remove */
>    566			list_add(&pcie_pmu->pmu_node, &priv->pmu_nodes);
>    567		}
>    568	
>    569		return 0;
>    570	}
>    571	
> 
