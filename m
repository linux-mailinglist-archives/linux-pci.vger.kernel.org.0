Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F870C114
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjEVO3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjEVO3G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 10:29:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038799;
        Mon, 22 May 2023 07:29:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ0Ch0Z4Nz686w8;
        Mon, 22 May 2023 22:27:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 15:29:00 +0100
Date:   Mon, 22 May 2023 15:28:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <helgaas@kernel.org>, <yangyicong@huawei.com>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v5 0/4] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Message-ID: <20230522152859.0000429e@Huawei.com>
In-Reply-To: <20230522035428.69441-1-xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
        <20230522035428.69441-1-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 May 2023 11:54:24 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

Hi,

Very rarely a good idea to send a new patch set version in reply to an old
one. Tends to just resort in it being way off the top of people's most recent
email (depending on client of course!)

Jonathan

> changes since v4:
> 
> 1. addressing commens from Bjorn Helgaas:
> - reorder the includes by alpha
> - change all macros with upper-case hex
> - change ras_des type into u16
> - remove unnecessary outer "()"
> - minor format changes
> 
> 2. Address commensts from Jonathan Cameron:
> - rewrite doc and add a example to show how to use lane event
> 
> 3. fix compile error reported by: kernel test robot
> - remove COMPILE_TEST and add depend on PCI in kconfig
> - add Reported-by: kernel test robot <lkp@intel.com>
> 
> Changes since v3:
> 
> 1. addressing comments from Robin Murphy:
> - add a prepare patch to define pci id in linux/pci_ids.h
> - remove unnecessary 64BIT dependency
> - fix DWC_PCIE_PER_EVENT_OFF/ON macro
> - remove dwc_pcie_pmu struct and move all its fileds into dwc_pcie_rp_info
> - remove unnecessary format field show
> - use sysfs_emit() instead of all the assorted sprintf() and snprintf() calls.
> - remove unnecessary spaces and remove unnecessary cast to follow event show convention
> - remove pcie_pmu_event_attr_is_visible
> - fix a refcout leak on error branch when walk pci device in for_each_pci_dev
> - remove bdf field from dwc_pcie_rp_info and calculate it at runtime
> - finish all the checks before allocating rp_info to avoid hanging wasted memory
> - remove some unused fields
> - warp out control register configuration from sub function to .add()
> - make function return type with a proper signature
> - fix lane event count enable by clear DWC_PCIE_CNT_ENABLE field first
> - pass rp_info directly to the read_*_counter helpers and in start, stop and add callbacks
> - move event type validtion into .event_init()
> - use is_sampling_event() to be consistent with everything else of pmu drivers
> - remove unnecessary dev_err message in .event_init()
> - return EINVAL instead EOPNOTSUPP for not a valid event 
> - finish all the checks before start modifying the event
> - fix sibling event check by comparing event->pmu with sibling->pmu
> - probe PMU for each rootport independently
> - use .update() as .read() directly
> - remove dynamically generating symbolic name of lane event
> - redefine static symbolic name of lane event and leave lane filed to user
> - add CPU hotplug support
> 
> 2. addressing comments from Baolin:
> - add a mask to avoid possible overflow
> 
> Changes since v2 addressing comments from Baolin:
> - remove redundant macro definitions
> - use dev_err to print error message
> - change pmu_is_register to boolean
> - use PLATFORM_DEVID_NONE macro
> - fix module author format
> 
> Changes since v1:
> 
> 1. address comments from Jonathan:
> - drop marco for PMU name and VSEC version
> - simplify code with PCI standard marco
> - simplify code with FIELD_PREP()/FIELD_GET() to replace shift marco
> - name register filed with single _ instead double
> - wrap dwc_pcie_pmu_{write}_dword out and drop meaningless snaity check 
> - check vendor id while matching vesc with pci_find_vsec_capability()
> - remove RP_NUM_MAX and use a list to organize PMU devices for rootports
> - replace DWC_PCIE_CREATE_BDF with standard PCI_DEVID
> - comments on riping register together
> 
> 2. address comments from Bjorn:
> - rename DWC_PCIE_VSEC_ID to DWC_PCIE_VSEC_RAS_DES_ID
> - rename cap_pos to ras_des
> - simplify declare of device_attribute with DEVICE_ATTR_RO
> - simplify code with PCI standard macro and API like pcie_get_width_cap()
> - fix some code style problem and typo
> - drop meaningless snaity check of container_of
> 
> 3. address comments from Yicong:
> - use sysfs_emit() to replace sprintf()
> - simplify iteration of pci device with for_each_pci_dev
> - pick preferred CPUs on a near die and add comments
> - unregister PMU drivers only for failed ones
> - log on behalf PMU device and give more hint
> - fix some code style problem
> 
> (Thanks for all comments and they are very valuable to me)
> 
> This patchset adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian 710 SoC chip. Yitian 710 is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature.
> 
> Shuai Xue (4):
>   docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>   PCI: move Alibaba Vendor ID linux/pci_ids.h
>   drivers/perf: add DesignWare PCIe PMU driver
>   MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
> 
>  .../admin-guide/perf/dwc_pcie_pmu.rst         |  97 +++
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  MAINTAINERS                                   |   6 +
>  drivers/infiniband/hw/erdma/erdma_hw.h        |   2 -
>  drivers/perf/Kconfig                          |   7 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/dwc_pcie_pmu.c                   | 701 ++++++++++++++++++
>  include/linux/pci_ids.h                       |   2 +
>  8 files changed, 815 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>  create mode 100644 drivers/perf/dwc_pcie_pmu.c
> 

