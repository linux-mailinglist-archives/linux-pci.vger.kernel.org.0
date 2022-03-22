Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1D4E3F48
	for <lists+linux-pci@lfdr.de>; Tue, 22 Mar 2022 14:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiCVNSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Mar 2022 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiCVNSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2022 09:18:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC0F1606F0;
        Tue, 22 Mar 2022 06:16:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66E9152B;
        Tue, 22 Mar 2022 06:16:42 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3173F73B;
        Tue, 22 Mar 2022 06:16:40 -0700 (PDT)
Message-ID: <61809b8f-acaa-bae2-ac5e-aa47c55eea23@arm.com>
Date:   Tue, 22 Mar 2022 13:16:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        dann frazier <dann.frazier@canonical.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Android Kernel Team <kernel-team@android.com>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <87h77rxnyl.wl-maz@kernel.org>
 <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
 <87fsnbxgau.wl-maz@kernel.org> <e52c8cbd-031b-848f-3d78-dff8b93bd416@arm.com>
In-Reply-To: <e52c8cbd-031b-848f-3d78-dff8b93bd416@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-03-21 20:06, Robin Murphy wrote:
> On 2022-03-21 19:21, Marc Zyngier wrote:
>> On Mon, 21 Mar 2022 18:03:27 +0000,
>> Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Mon, Mar 21, 2022 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
>>>>
>>>> On Mon, 21 Mar 2022 15:17:34 +0000,
>>>> Rob Herring <robh@kernel.org> wrote:
>>>>>
>>>>> On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
>>>>>>
>>>>> For XGene-1, I'd still like to understand what the issue is. Reverting
>>>>> the first fix and fixing 'dma-ranges' should have fixed it. I need a
>>>>> dump of how the IB registers are initialized in both cases. I'm not
>>>>> saying changing 'dma-ranges' in the firmware is going to be required
>>>>> here. There's a couple of other ways we could fix that without a
>>>>> firmware change, but first I need to understand why it broke.
>>>>
>>>> Reverting 6dce5aa59e0b was enough for me, without changing anything
>>>> else.
>>>
>>> Meaning c7a75d07827a didn't matter for you. I'm not sure that it would.
>>>
>>> Can you tell me what 'dma-ranges' contains on your system?
>>
>> Each pcie node (all 5 of them) has:
>>
>> dma-ranges = <0x42000000 0x80 0x00 0x80 0x00 0x00 0x80000000
>>                0x42000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> 
> Hmm, is there anyone other than iommu-dma who actually depends on the 
> resource list being sorted in ascending order of bus address? I recall 
> at the time I pushed for creating the list in sorted order as it was the 
> simplest and most efficient option, but there's no technical reason we 
> couldn't create it in as-found order and defer the sorting until 
> iova_reserve_pci_windows() (at worst that could even operate on a 
> temporary copy if need be). It's just more code, which didn't need to 
> exist without a good reason, but if this is one then exist it certainly 
> may.

Taking a closer look, the Cadence driver is already re-sorting the list
for its own setup, so iommu-dma can't assume the initial sort is
preserved and needs to do its own anyway. Does the (untested) diff below
end up helping X-Gene also?

Robin.

----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b22034975301..8ef603c9ca3e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,6 +20,7 @@
  #include <linux/iommu.h>
  #include <linux/iova.h>
  #include <linux/irq.h>
+#include <linux/list_sort.h>
  #include <linux/mm.h>
  #include <linux/mutex.h>
  #include <linux/pci.h>
@@ -414,6 +415,14 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
  	return 0;
  }
  
+static int iommu_dma_ranges_sort(void *priv, const struct list_head *a, const struct list_head *b)
+{
+	struct resource_entry *res_a = list_entry(a, typeof(*res_a), node);
+	struct resource_entry *res_b = list_entry(b, typeof(*res_b), node);
+
+	return res_a->res->start > res_b->res->start;
+}
+
  static int iova_reserve_pci_windows(struct pci_dev *dev,
  		struct iova_domain *iovad)
  {
@@ -432,6 +441,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
  	}
  
  	/* Get reserved DMA windows from host bridge */
+	list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
  	resource_list_for_each_entry(window, &bridge->dma_ranges) {
  		end = window->res->start - window->offset;
  resv_iova:
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index cb2e8351c2cc..d176b4bc6193 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -393,12 +393,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
  			goto failed;
  		}
  
-		/* Keep the resource list sorted */
-		resource_list_for_each_entry(entry, ib_resources)
-			if (entry->res->start > res->start)
-				break;
-
-		pci_add_resource_offset(&entry->node, res,
+		pci_add_resource_offset(ib_resources, res,
  					res->start - range.pci_addr);
  	}
  
