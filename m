Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2763974F24B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGKOdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGKOdo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 10:33:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D88EBC;
        Tue, 11 Jul 2023 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689086023; x=1720622023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XYaVMQ3P2Xw+yr548W+rzf2xAqljuiRQQedbp9M8+Ao=;
  b=KXwDwHKLP27yuoPmvmVV12rMD9w+8KTh+CVducRjShtdIin4KQDM7L0p
   KxhOeKdVvEaUC2qxXauFPsitb9IZ6p0CfOKBlIRlvV76CNALnv6KN2OrV
   JA6lCNx0+1JnsXHWPYmP6oSKNlQg+voKJIDUkjYE05wV2Nds0ZUI4kson
   nVpIq61nNE4LZl3rcZrLuRf8jgmWckZfgrqbHEaHKGZS5xuPMyPh/+Trc
   URGfn1uHdGRuNyxPYENnkOyZ9caokReaEPDwMjHj8VizQeM8srIaHjvTi
   tBL9XI2FIx2tBl7MqXv2LwrtmWBiHBHlnZ8XlhRsRKRvpC2Dmdk3RgDDt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="368135306"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368135306"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="721103911"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="721103911"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2023 07:33:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qJEQT-001sG8-2y;
        Tue, 11 Jul 2023 17:33:13 +0300
Date:   Tue, 11 Jul 2023 17:33:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 13/13] ASoC: Intel: sst: Convert to PCI device IDs defines
Message-ID: <ZK1oKYW0rro4FnNO@smile.fi.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
 <20230711125726.3509391-14-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711125726.3509391-14-amadeuszx.slawinski@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 02:57:26PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header.

...

>  	switch (sst->dev_id) {
> -	case SST_MRFLD_PCI_ID:
> +	case PCI_DEVICE_ID_INTEL_ADSP_TNG:
>  	case SST_BYT_ACPI_ID:
>  	case SST_CHV_ACPI_ID:

I think this needs a bit more, i.e. replacing the rest with respective PCI IDs.

All three will be defined with SST prefix, which makes sense to me.

ACPI here is a bit misleading, but correct. The ACPI specification assumes that
respective part of the ID space covers 100% of PCI ID space.

I have briefly checked the code and it seems that ID is used externally only
for PCI case, so we may simply use the lower 16 bits of the ACPI _HID for the
context.

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a0d29510d2bc..b1f59604d825 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -222,7 +222,7 @@ static void sst_init_locks(struct intel_sst_drv *ctx)
 }
 
 int sst_alloc_drv_context(struct intel_sst_drv **ctx,
-		struct device *dev, unsigned int dev_id)
+		struct device *dev, unsigned short dev_id)
 {
 	*ctx = devm_kzalloc(dev, sizeof(struct intel_sst_drv), GFP_KERNEL);
 	if (!(*ctx))
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 4d37d39fd8f4..c04f033e1d5f 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -358,7 +358,7 @@ struct sst_fw_save {
 struct intel_sst_drv {
 	int			sst_state;
 	int			irq_num;
-	unsigned int		dev_id;
+	unsigned short		dev_id;
 	void __iomem		*ddr;
 	void __iomem		*shim;
 	void __iomem		*mailbox;
@@ -523,7 +523,7 @@ int sst_register(struct device *);
 int sst_unregister(struct device *);
 
 int sst_alloc_drv_context(struct intel_sst_drv **ctx,
-		struct device *dev, unsigned int dev_id);
+		struct device *dev, unsigned short dev_id);
 int sst_context_init(struct intel_sst_drv *ctx);
 void sst_context_cleanup(struct intel_sst_drv *ctx);
 void sst_configure_runtime_pm(struct intel_sst_drv *ctx);

...

>  /* driver names */
>  #define SST_DRV_NAME "intel_sst_driver"

> -#define SST_MRFLD_PCI_ID 0x119A
>  #define SST_BYT_ACPI_ID	0x80860F28
>  #define SST_CHV_ACPI_ID	0x808622A8

And kill all three!

-- 
With Best Regards,
Andy Shevchenko


