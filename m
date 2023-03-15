Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656CE6BB64C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjCOOjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjCOOjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 10:39:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0441EF80;
        Wed, 15 Mar 2023 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678891149; x=1710427149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbEtsZqcCxnAkv7v46t+kyfgD1hi/rzwe9N8/sucaPk=;
  b=N4EwodQnOJ06yGSy9HYuPRSCGgRkxeH3eWr6vJ2EDdtgdddw1B4qFhp+
   JFfBkcSUt9Nng/b/IyX5B120FHzRhmPxD1vLFkh0SfI1OXibrbduXgUKA
   CFT6n2qIyVP+Z4dSbjot93coK6bnDHibRCvXZ7f+SvvTDlMYpKtyfZ98W
   q1Djdcpjt8UwrVhAJq/ObcRMcZ8CcziA6E/+ffyNTDMsUwlRbysFl5bfx
   ZmswvFkMyOKikeHaFeC8bzj1wgzUFSKF2XbJu0JmZFc6Bw0qvpRi+A9Kd
   /gpwArFFpJDbHmH3JxzxAp4+FeBDRnqn/O8CG5uvVj2fnlqVUiRBnLU/c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339257806"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="339257806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="711937077"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="711937077"
Received: from stevenpa-mobl2.amr.corp.intel.com (HELO [10.212.47.53]) ([10.212.47.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:39:08 -0700
Message-ID: <49907fd5-3069-dc19-1388-590e08600037@linux.intel.com>
Date:   Wed, 15 Mar 2023 07:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] PCI: vmd: guard device addition and removal
To:     "You-Sheng Yang (vicamo)" <vicamo.yang@canonical.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230313173733.1815277-1-vicamo.yang@canonical.com>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230313173733.1815277-1-vicamo.yang@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/13/2023 10:37 AM, You-Sheng Yang (vicamo) wrote:
> VMD may fail to create sysfs entries while `pci_rescan_bus()` called in
> some other drivers like t7xx wwan driver:
>
>   sysfs: cannot create duplicate filename '/devices/.../resource0'
>   Call Trace:
>    <TASK>
>    sysfs_warn_dup.cold+0x17/0x34
>    sysfs_add_bin_file_mode_ns+0xc0/0xf0
>    sysfs_create_bin_file+0x6d/0xb0
>    pci_create_attr+0x117/0x260
>    pci_create_resource_files+0x6b/0x150
>    pci_create_sysfs_dev_files+0x18/0x30
>    pci_bus_add_device+0x30/0x80
>    pci_bus_add_devices+0x31/0x80
>    pci_bus_add_devices+0x5b/0x80
>    vmd_enable_domain.constprop.0+0x6b7/0x880 [vmd]
>    vmd_probe+0x16d/0x193 [vmd]
>
> Fixes: 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management Device (VMD)")
> Signed-off-by: You-Sheng Yang (vicamo) <vicamo.yang@canonical.com>
> ---
>  drivers/pci/controller/vmd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..f050991bd1e9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -838,9 +838,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
>  
> +	pci_lock_rescan_remove();
> +
>  	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
>  				       &vmd_ops, sd, &resources);
>  	if (!vmd->bus) {
> +		pci_unlock_rescan_remove();
> +
>  		pci_free_resource_list(&resources);
>  		vmd_remove_irq_domain(vmd);
>  		return -ENODEV;
> @@ -893,6 +897,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	vmd_acpi_end();
>  
> +	pci_unlock_rescan_remove();
> +
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>  	return 0;

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Thanks

