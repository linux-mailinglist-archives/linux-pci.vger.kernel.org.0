Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060162F4AF9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAMMGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 07:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbhAMMGj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 07:06:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD38C061795
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 04:05:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x126so1087887pfc.7
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 04:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rgkuTBsatwNJSFukk7YicMTbt2SY0ukVzdRGr/VFZys=;
        b=cOl6Zhu2dw/c+w51im0JfCjpG4zEg1ObDsz9irQYpzF7Hwyiq0EwAR0u9cWEn2j/Ic
         j2Yxgd2Je0BYzG9kqyToJLcYgI9M1UG3+H4R4HVjRmN3D71I7UYRxqmNYiRSwBqUbbgG
         VFpZ6xP6GFO0KWEm6EQe/zgLczvO6HlHDXsoxwYk+37SvMofk0JGzljpabRtOpM8gI2q
         o3XQK05ukfBLV3VpxJ8psg4JNhZmnnqIS1A9X4kQurhgglyakOoWgQ5KHsU+Hy780Yyx
         hjTZHwsNXJGCsg01J4xaHHlCRdvqVnvU3/8C6MIW6vHR70INpLIuHNKB0hnGHPOWYzlm
         WvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rgkuTBsatwNJSFukk7YicMTbt2SY0ukVzdRGr/VFZys=;
        b=KUrGhVY/UpkNVxYOPiS04KBO9kyJBILOHaVaf9d33ykNkJ5F2sxNq/w775VSAUZ3FM
         TTE5dHkQEB3osb5jAx9JAFBQCIwFCrwONaZRdNRA2tKeVl9P5UcMf3YH5jqbrgLIuP0U
         I63tgevkYZBpKZJEl+4Ujh4Vb+6onm/Kv8gFnQ96wpveOTf1Cno1NX6XJJNuhQuRXCPb
         T9nX97UgWTXiQDnQFiXTwSWrhV8vLuh6OccqOnozo6BxW8zxHY47wS8FBMV49cQEEWrs
         P2AOv8JQ1HPdl9kc3S6A0vDrn/m0EC9+fsWI2qDjMVZlR5sSwgSSWLsWPDrMht64oXtS
         AEOA==
X-Gm-Message-State: AOAM532bk7YJGqpKAYh3BUU5jUe8S8fwc38ShoHLeuXWpC1GkhSPRLye
        yxsEd/gQia8/Zsc43QQTSaxu/Q==
X-Google-Smtp-Source: ABdhPJxnF/0Q5Vw3ffGbiKIGpIFa1PEf6zSvspzFG3LaIOefe/P+oTi+74uT8h+tnwQkVG9sV997Dg==
X-Received: by 2002:a63:dd53:: with SMTP id g19mr1766273pgj.291.1610539559087;
        Wed, 13 Jan 2021 04:05:59 -0800 (PST)
Received: from ?IPv6:240e:45b:406:3726:19ba:7333:19c1:ecbe? ([240e:45b:406:3726:19ba:7333:19c1:ecbe])
        by smtp.gmail.com with ESMTPSA id g16sm2288805pfh.187.2021.01.13.04.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 04:05:58 -0800 (PST)
Subject: Re: [PATCH] PCI: Add a quirk to enable SVA for HiSilicon chip
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20210112170230.GA1838341@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <b9fd8097-85f9-408d-f58c-b26dd21f3aa0@linaro.org>
Date:   Wed, 13 Jan 2021 20:05:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112170230.GA1838341@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

Thanks for the suggestion.

On 2021/1/13 上午1:02, Bjorn Helgaas wrote:
> On Tue, Jan 12, 2021 at 02:49:52PM +0800, Zhangfei Gao wrote:
>> HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
>> actually on the AMBA bus. These fake PCI devices can not support tlp
>> and have to enable SMMU stall mode to use the SVA feature.
>>
>> Add a quirk to set dma-can-stall property and enable tlp for these devices.
> s/tlp/TLP/
>
> I don't think "enable TLP" really captures what's going on here.  You
> must be referring to the fact that you set pdev->eetlp_prefix_path.
>
> That is normally set by pci_configure_eetlp_prefix() if the Device
> Capabilities 2 register has the End-End TLP Prefix Supported bit set
> *and* all devices in the upstream path also have it set.
>
> The only place we currently test eetlp_prefix_path is in
> pci_enable_pasid().  In PCIe, PASID is implemented using the PASID TLP
> prefix, so we only enable PASID if TLP prefixes are supported.
>
> If I understand correctly, a PASID-like feature is implemented on AMBA
> without using TLP prefixes, and setting eetlp_prefix_path makes that
> work.
Yes, that's the requirement.
>
> I don't think you should do this by setting eetlp_prefix_path because
> TLP prefixes are used for other features, e.g., TPH.  Setting
> eetlp_prefix_path implies these devices can also support things like
> TLP, and I don't think that's necessarily true.
Thanks for the remainder.
>
> Apparently these devices have a PASID capability.  I think you should
> add a new pci_dev bit that is specific to this idea of "PASID works
> without TLP prefixes" and then change pci_enable_pasid() to look at
> that bit as well as eetlp_prefix_path.
That's great, this solution is much simpler.
we can set the bit before pci_enable_pasid.
>
> It seems like dma-can-stall is a separate thing from PASID?  If so,
> this should be two separate patches.
>
> If they can be separated, I would probably make the PASID thing the
> first patch, and then the "dma-can-stall" can be on its own as a
> broken DT workaround (if that's what it is) and it's easier to remove
> that if it become obsolete.
>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>> Property dma-can-stall depends on patchset
>> https://lore.kernel.org/linux-iommu/20210108145217.2254447-1-jean-philippe@linaro.org/
>>
>> drivers/pci/quirks.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 653660e..a27f327 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1825,6 +1825,31 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quir
>>   
>>   DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
>>   
>> +static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
>> +{
>> +	struct property_entry properties[] = {
>> +		PROPERTY_ENTRY_BOOL("dma-can-stall"),
>> +		{},
>> +	};
>> +
>> +	if ((pdev->revision != 0x21) && (pdev->revision != 0x30))
>> +		return;
>> +
>> +	pdev->eetlp_prefix_path = 1;
>> +
>> +	/* Device-tree can set the stall property */
>> +	if (!pdev->dev.of_node &&
>> +	    device_add_properties(&pdev->dev, properties))
> Does this mean "dma-can-stall" *can* be set via DT, and if it is, this
> quirk is not needed?  So is this quirk basically a workaround for an
> old or broken DT?
The quirk is still needed for uefi case, since uefi can not describe the 
endpoints (peripheral devices).
>
>> +		pci_warn(pdev, "could not add stall property");
>> +}
>> +
> Remove this blank line to follow the style of the rest of the file.
>
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>> +
>>   /*
>>    * It's possible for the MSI to get corrupted if SHPC and ACPI are used
>>    * together on certain PXH-based systems.

How about changes like this

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 68f53f7..886ea26 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2466,6 +2466,9 @@ static int arm_smmu_enable_pasid(struct 
arm_smmu_master *master)
      if (num_pasids <= 0)
          return num_pasids;

+    if (master->stall_enabled)
+        pdev->pasid_no_tlp = 1;
+
      ret = pci_enable_pasid(pdev, features);
      if (ret) {
          dev_err(&pdev->dev, "Failed to enable PASID\n");
@@ -2860,6 +2863,11 @@ static struct iommu_device 
*arm_smmu_probe_device(struct device *dev)
      device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
      master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);

+    if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
+         device_property_read_bool(dev, "dma-can-stall")) ||
+        smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+        master->stall_enabled = true;
+
      /*
       * Note that PASID must be enabled before, and disabled after ATS:
       * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
@@ -2874,11 +2882,6 @@ static struct iommu_device 
*arm_smmu_probe_device(struct device *dev)
          master->ssid_bits = min_t(u8, master->ssid_bits,
                        CTXDESC_LINEAR_CDMAX);

-    if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
-         device_property_read_bool(dev, "dma-can-stall")) ||
-        smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
-        master->stall_enabled = true;
-
      arm_smmu_init_pri(master);

      return &smmu->iommu;
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e36d601..fe604b5 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -386,7 +386,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
      if (WARN_ON(pdev->pasid_enabled))
          return -EBUSY;

-    if (!pdev->eetlp_prefix_path)
+    if ((!pdev->eetlp_prefix_path) && (!pdev->pasid_no_tlp))
          return -EINVAL;

      if (!pasid)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index f1f26f8..fbee7fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,7 @@ struct pci_dev {
                         supported from root to here */
      u16        l1ss;        /* L1SS Capability pointer */
  #endif
+    unsigned int    pasid_no_tlp:1;        /* PASID can be supported 
without TLP Prefix */
      unsigned int    eetlp_prefix_path:1;    /* End-to-End TLP Prefix */

      pci_channel_state_t error_state;    /* Current connectivity state */

Thanks
