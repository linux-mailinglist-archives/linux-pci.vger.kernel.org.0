Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6174554FD07
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFQSoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFQSon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 14:44:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE112DD51;
        Fri, 17 Jun 2022 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655491482; x=1687027482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1Gf9lLU9+H7jAY/ufwZLymJnmKu8v6RftFaAoJNXbsM=;
  b=dNY3VZgCdbIiy6QbW6FyLAYMT9skBJIcEYZy2aIpFw+dTi1Lvh//HYJ9
   NY4RRQIMxqmj33z46MmLbxNR66uspr+MzSW12xGGW8e7XbT3Rm+jyo9qu
   /pEda3mmEVWwHXgrzFEzK8lq9DAKU9sY3eLtAf2zfyCzumkz5HF5V4lJi
   OokLfrmdy7j/1SwvwGz5zzNzEmV9yjNUW29CAS/J8GN2LjTA+eTbCRnGg
   Zs9fr1I76wDFAhRHtzuBc1cED4Z40W9LwQmYwPzkESdiCvjyRrQsOMjdw
   tOsr9qLtCZLqXKP3sU5ZlKcFxLRcfzTYP+oaMYOIG58Ru+aNbVRxnXRxZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262604622"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262604622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 11:44:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536919700"
Received: from ecastill-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.204.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 11:44:41 -0700
Date:   Fri, 17 Jun 2022 11:44:41 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     priyanka.dandamudi@intel.com, matthew.auld@intel.com,
        intel-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Add support for LMEM PCIe
 resizable bar
Message-ID: <20220617184441.7kbs4al7gmpxjuuy@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220616151247.1192063-1-priyanka.dandamudi@intel.com>
 <20220616151247.1192063-2-priyanka.dandamudi@intel.com>
 <87fsk3vgey.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsk3vgey.fsf@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc'ing intel-pci, lkml, Bjorn

On Fri, Jun 17, 2022 at 11:32:37AM +0300, Jani Nikula wrote:
>On Thu, 16 Jun 2022, priyanka.dandamudi@intel.com wrote:
>> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>>
>> Add support for the local memory PICe resizable bar, so that
>> local memory can be resized to the maximum size supported by the device,
>> and mapped correctly to the PCIe memory bar. It is usual that GPU
>> devices expose only 256MB BARs primarily to be compatible with 32-bit
>> systems. So, those devices cannot claim larger memory BAR windows size due
>> to the system BIOS limitation. With this change, it would be possible to
>> reprogram the windows of the bridge directly above the requesting device
>> on the same BAR type.

There is a big caveat here that this may be too late as other drivers
may have already mapped their BARs - so probably too late in the pci scan
for it to be effective. In fact, after using this for a while, it seems
to fail too often, particularly on CFL systems.

Do we have any alternative to be done in the PCI subsystem during the
scan?  There is other work in progress to allow i915 to use the rest of
the device memory even with a smaller BAR, but it would be better if we
can improve our chances of succeeding the resize.

thanks
Lucas De Marchi


>>
>> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
>> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
>> Cc: Stuart Summers <stuart.summers@intel.com>
>> Cc: Michael J Ruhl <michael.j.ruhl@intel.com>
>> Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
>> Signed-off-by: Priyanka Dandamudi <priyanka.dandamudi@intel.com>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
>Please see https://lore.kernel.org/r/87pmj8vesm.fsf@intel.com
>
>> ---
>>  drivers/gpu/drm/i915/i915_driver.c | 92 ++++++++++++++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
>> index d26dcca7e654..4bdb471cb2e2 100644
>> --- a/drivers/gpu/drm/i915/i915_driver.c
>> +++ b/drivers/gpu/drm/i915/i915_driver.c
>> @@ -303,6 +303,95 @@ static void sanitize_gpu(struct drm_i915_private *i915)
>>  		__intel_gt_reset(to_gt(i915), ALL_ENGINES);
>>  }
>>
>> +static void __release_bars(struct pci_dev *pdev)
>> +{
>> +	int resno;
>> +
>> +	for (resno = PCI_STD_RESOURCES; resno < PCI_STD_RESOURCE_END; resno++) {
>> +		if (pci_resource_len(pdev, resno))
>> +			pci_release_resource(pdev, resno);
>> +	}
>> +}
>> +
>> +static void
>> +__resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>> +	int bar_size = pci_rebar_bytes_to_size(size);
>> +	int ret;
>> +
>> +	__release_bars(pdev);
>> +
>> +	ret = pci_resize_resource(pdev, resno, bar_size);
>> +	if (ret) {
>> +		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
>> +			 resno, 1 << bar_size, ERR_PTR(ret));
>> +		return;
>> +	}
>> +
>> +	drm_info(&i915->drm, "BAR%d resized to %dM\n", resno, 1 << bar_size);
>> +}
>> +
>> +/* BAR size starts from 1MB - 2^20 */
>> +#define BAR_SIZE_SHIFT 20
>> +static resource_size_t
>> +__lmem_rebar_size(struct drm_i915_private *i915, int resno)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>> +	u32 rebar = pci_rebar_get_possible_sizes(pdev, resno);
>> +	resource_size_t size;
>> +
>> +	if (!rebar)
>> +		return 0;
>> +
>> +	size = 1ULL << (__fls(rebar) + BAR_SIZE_SHIFT);
>> +
>> +	if (size <= pci_resource_len(pdev, resno))
>> +		return 0;
>> +
>> +	return size;
>> +}
>> +
>> +#define LMEM_BAR_NUM 2
>> +static void i915_resize_lmem_bar(struct drm_i915_private *i915)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>> +	struct pci_bus *root = pdev->bus;
>> +	struct resource *root_res;
>> +	resource_size_t rebar_size = __lmem_rebar_size(i915, LMEM_BAR_NUM);
>> +	u32 pci_cmd;
>> +	int i;
>> +
>> +	if (!rebar_size)
>> +		return;
>> +
>> +	/* Find out if root bus contains 64bit memory addressing */
>> +	while (root->parent)
>> +		root = root->parent;
>> +
>> +	pci_bus_for_each_resource(root, root_res, i) {
>> +		if (root_res && root_res->flags & (IORESOURCE_MEM |
>> +					IORESOURCE_MEM_64) && root_res->start > 0x100000000ull)
>> +			break;
>> +	}
>> +
>> +	/* pci_resize_resource will fail anyways */
>> +	if (!root_res) {
>> +		drm_info(&i915->drm, "Can't resize LMEM BAR - platform support is missing\n");
>> +		return;
>> +	}
>> +
>> +	/* First disable PCI memory decoding references */
>> +	pci_read_config_dword(pdev, PCI_COMMAND, &pci_cmd);
>> +	pci_write_config_dword(pdev, PCI_COMMAND,
>> +			       pci_cmd & ~PCI_COMMAND_MEMORY);
>> +
>> +	__resize_bar(i915, LMEM_BAR_NUM, rebar_size);
>> +
>> +	pci_assign_unassigned_bus_resources(pdev->bus);
>> +	pci_write_config_dword(pdev, PCI_COMMAND, pci_cmd);
>> +}
>> +
>>  /**
>>   * i915_driver_early_probe - setup state not requiring device access
>>   * @dev_priv: device private
>> @@ -852,6 +941,9 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>
>>  	disable_rpm_wakeref_asserts(&i915->runtime_pm);
>>
>> +	if (HAS_LMEM(i915))
>> +		i915_resize_lmem_bar(i915);
>> +
>>  	intel_vgpu_detect(i915);
>>
>>  	ret = intel_gt_probe_all(i915);
>
>-- 
>Jani Nikula, Intel Open Source Graphics Center
