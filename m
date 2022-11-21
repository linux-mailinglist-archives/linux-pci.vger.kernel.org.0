Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDDE631904
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 04:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKUDrG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 22:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUDrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 22:47:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564151788C;
        Sun, 20 Nov 2022 19:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669002424; x=1700538424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R+pxjHRXikHGKHlpOCaKvahGOxHzcOR5T1v3IDt7RxE=;
  b=aePBd0VRWukdlpzrvtsrQ1h+7HUqHdXQtTrOcRdpYe34lnyKyAtIcYdf
   kAKC2IsBdgaT2C1scAMaETeZZLVtI7CaU0MKWXtnatay67mGNqYh/fRN+
   Ri9rD/wR/0PGm81Igce/S3lKCyQQ9uGhYK5dV0nZOQkFFIMoUaBO8sSRz
   YpBLhoNXp+gwV9oce3bn2+XVaRg2Pgk2qJNcwr/73+wfB01VVVSdyn4dR
   1tOocd6zY9G8moL5/DqgHlcwUWPbYEy5xL2rrOZGsO9wkIZ/Y7QjfG6Ws
   8d1MFgKl2UU3m4N+j2L9WegMYtLuK5CO9t0EOSGrfXswhVn95d/JXpyki
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315285434"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="315285434"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 19:47:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="643164700"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="643164700"
Received: from mjcardon-mobl.amr.corp.intel.com (HELO [10.209.57.10]) ([10.209.57.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 19:47:03 -0800
Message-ID: <a21d9795-6404-4fc2-3af1-5ddb35e58494@linux.intel.com>
Date:   Sun, 20 Nov 2022 19:47:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH V8 RESEND 4/4] PCI: vmd: Add quirk to configure PCIe ASPM
 and LTR
Content-Language: en-US
To:     david.e.box@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119021411.1383248-1-david.e.box@linux.intel.com>
 <20221119021411.1383248-5-david.e.box@linux.intel.com>
 <cddb4c3d-cbaa-06fb-0edc-e0a1d8bf9ff2@linux.intel.com>
 <d46a9aa805d740979b9ae0a89984d43231757bb5.camel@linux.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d46a9aa805d740979b9ae0a89984d43231757bb5.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/20/22 7:30 PM, David E. Box wrote:
>>> +
>>>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>  {
>>>         struct pci_sysdata *sd = &vmd->sysdata;
>>> @@ -867,6 +917,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
>>> unsigned long features)
>>>                 pci_reset_bus(child->self);
>>>         pci_assign_unassigned_bus_resources(vmd->bus);
>>>  
>>> +       pci_walk_bus(vmd->bus, vmd_pm_enable_quirk, &features);
>>> +
>>>         /*
>>>          * VMD root buses are virtual and don't return true on pci_is_pcie()
>>>          * and will fail pcie_bus_configure_settings() early. It can instead
>>> be
>>> @@ -1005,17 +1057,17 @@ static const struct pci_device_id vmd_ids[] = {
>>>                                 VMD_FEAT_HAS_BUS_RESTRICTIONS |
>>>                                 VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
>>>         {PCI_VDEVICE(INTEL, 0x467f),
>>> -               .driver_data = VMD_FEATS_CLIENT,},
>>> +               .driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
>>>         {PCI_VDEVICE(INTEL, 0x4c3d),
>>> -               .driver_data = VMD_FEATS_CLIENT,},
>>> +               .driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
>>>         {PCI_VDEVICE(INTEL, 0xa77f),
>>> -               .driver_data = VMD_FEATS_CLIENT,},
>>> +               .driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
>>>         {PCI_VDEVICE(INTEL, 0x7d0b),
>>> -               .driver_data = VMD_FEATS_CLIENT,},
>>> +               .driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
>>>         {PCI_VDEVICE(INTEL, 0xad0b),
>>> -               .driver_data = VMD_FEATS_CLIENT,},
>>> +               .driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
>>>         {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>>> -               .driver_data = VMD_FEATS_CLIENT,},
>>> +               .driver_data = VMD_FEATS_CLIENT | VMD_FEAT_BIOS_PM_QUIRK,},
>> Why not add VMD_FEAT_BIOS_PM_QUIRK part of VMD_FEATS_CLIENT?
> Because our VMD team is in the middle of removing the need for the current on
> next gen.

You mean you may not need this quirk support from next gen? 

It looks like you are adding this quirk to all occurances of
VMD_FEATS_CLIENT. So I am still not clear why we can't add it directly to that macro?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
