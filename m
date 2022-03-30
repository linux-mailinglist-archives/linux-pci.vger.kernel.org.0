Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B44ECB68
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbiC3SKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349711AbiC3SKM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 14:10:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E63B37AB8
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648663704; x=1680199704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+3WC9EUA7CEvdiGyVZoXD/HxckRZWuNW9EXqNNdtl0=;
  b=GXgRvCMa7AK9dV+uOhwICG3jCjhSr97N7K4S7WeY7BQuQ0XHYwvVz3jJ
   u7UsKrniDFtGZmebZNZfzgyBt4Wzw70MBHYj45TK9ZOPpEe8sqrJpTbHf
   uQfsI4J/MVlJ2VpnZYXmyj1QtdO7+xryMyiowgJzfv+PM3mypcQHwYpnJ
   aRlbHfx9+XPp9oIHYFZulFvePiBTGNjgSYB5gC3rk+iOS1z20m3jWucTX
   maegtAPtvsNslOwQsVw1wVsoXV0fBCBZxjhbc0QgJYbfVpEDiF1ki6AEH
   oW/KEXC0adW2ZzFennwaXnRoxL30W5F7WvTeE9JxqY82fY6B3xL54eOCJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258440910"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="258440910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:07:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="546960892"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.117.191]) ([10.212.117.191])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:07:20 -0700
Message-ID: <161140d7-e400-f1ee-5613-9d35bd454ffe@linux.intel.com>
Date:   Wed, 30 Mar 2022 11:07:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] Allow VMD to disable MSIX remapping with interrupt
 remapping enabled.
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@intel.com>
References: <20220330174900.GA1694073@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220330174900.GA1694073@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/30/2022 10:49 AM, Bjorn Helgaas wrote:
> On Tue, Mar 29, 2022 at 03:48:21PM -0700, Patel, Nirmal wrote:
>> On 3/16/2022 8:51 AM, Nirmal Patel wrote:
>>> This patch removes a placeholder patch 2565e5b69c44 ("PCI: vmd: Do
>>> not disable MSI-X remapping if interrupt remapping is enabled by IOMMU.")
>>> This patch was added as a workaround to disable MSI remapping if iommu
>>> enables interrupt remapping. VMD does not assign proper IRQ domain to
>>> child devices when MSIX is disabled. There is no dependency between MSI
>>> remapping by VMD and interrupt remapping by iommu. MSI remapping can be
>>> enabled or disabled with and without interrupt remap.
>>>
>>> Signed-off-by: Nirmal Patel <nirmal.patel@intel.com>
>>> ---
>>>  drivers/pci/controller/vmd.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index 3a6570e5b765..91bc1b40d40c 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -6,7 +6,6 @@
>>>  
>>>  #include <linux/device.h>
>>>  #include <linux/interrupt.h>
>>> -#include <linux/iommu.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/module.h>
>>> @@ -813,8 +812,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>  	 * acceptable because the guest is usually CPU-limited and MSI
>>>  	 * remapping doesn't become a performance bottleneck.
>>>  	 */
>>> -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>>> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>>  	    offset[0] || offset[1]) {
>>>  		ret = vmd_alloc_irqs(vmd);
>>>  		if (ret)
> If/when you repost this, please update the subject and commit log to
> use "MSI-X" consistently instead of the current mix of "MSI-X" and
> "MSIX".
>
> Also s/iommu/IOMMU/.
>
> In subject line, add "PCI: vmd: " prefix and drop trailing period.
>
> Also rewrite commit log in imperative mood, e.g., "Revert 2565e5b69c44
> ..." instead of "This patch removes ..."  It's 100% clear that the
> commit log refers to *this* patch, so it's pointless to include that.
>
> It's further confusing that "This patch was added ..." refers to
> *2565e5b69c44*, not this revert.
>
> This reverts 2565e5b69c44 (but doesn't remove the #include
> <linux/iommu.h>" added by 2565e5b69c44).
>
> 2565e5b69c44 fixed a problem.  If that fix is no longer necessary
> because of some other change, the commit log should mention that
> change.  Otherwise somebody will backport this fix too far and
> reintroduce the problem solved by 2565e5b69c44.
>
> Bjorn

I will apply these changes.

Thank you
Nirmal

