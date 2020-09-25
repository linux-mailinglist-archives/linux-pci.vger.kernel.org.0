Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5E2793C1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgIYVta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgIYVta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 17:49:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D2AC0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 14:49:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jw11so186301pjb.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=fnjUF/voPvuzv/dLnDwKTFVpoCBAlVLzlUtOZ7ywSnE=;
        b=C3vpLmGCW68ANbhnOaz2h6lzbnyxJxhTilf7RmDW7o5+xYdQShz3cfUnUmaMf36WUB
         Goh+j3wX4IomhnOFgSk9Qqzndy26jMQUtVDDVNUETPGOuJILmetyLO214ZUbsg2OfRp4
         mF4Enl6IpFLmTjP/8gf9gDfbhaq91+N4R6gOa2uRvERoXHaCach8ohD9rzyfEtQyd6Ot
         /gs1NS1whrz3/PzrAmIoXYWJLPq1E83qJnhtADt6ZM0HlEXIuYhZgsHhTT5h+YslGvQP
         +OtHTZaA5tuv4Mn0jTiu379rlMSeT6Wd2AM56p5cKudwH/XJVKHe0s4KDTFlL1h2zB8j
         d69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=fnjUF/voPvuzv/dLnDwKTFVpoCBAlVLzlUtOZ7ywSnE=;
        b=gr+LeqbD2xhGqprIHF4bBwH8aotJSnfX1aBldZEW7b37vHh99GsBRszPtXCG8FgiHi
         xXstlETpPfuviS4DLYKvoMuz6MWHpRDz4rl4xvwfrMUvOH0x/cAA8Fx13sqshlBPTK4m
         uZAlcdwaCZReMccbPNHJ8L5cOy/DxtfGhp33I0kjTKyin6sYQyIBJ2jOgvedcP4rhFpt
         78qyQ5onk7MD0l7oP2SalQJ5y5T+TPs9v9Rcm9uFafcQob8iuXDZzbtdpuWB3EltoNGQ
         BHv4fBqfESb90wYOVEicgkax2rOcVGPXl5mJeoMVGwCzUB1hGuBzzjGcJeVYIyK9tGc3
         74lg==
X-Gm-Message-State: AOAM533gaBlcwurbHsEs3e3h1ok3jlvCIDmlViudYB7voHQeX7mANAju
        d8xbXdHcXccgPs4uBaAZDomuWA==
X-Google-Smtp-Source: ABdhPJyaYrhQywp2qaaPfy4YgApx9UaJR3jSScPYQ8aimLoSCq4iazoA7b1KyyBsEEuWJ+ZQf75HQg==
X-Received: by 2002:a17:90b:1b50:: with SMTP id nv16mr491097pjb.153.1601070569873;
        Fri, 25 Sep 2020 14:49:29 -0700 (PDT)
Received: from [10.212.51.97] ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id o11sm3341494pgq.36.2020.09.25.14.49.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 14:49:29 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] PCI/RCEC: Cache RCEC capabilities in
 pci_init_capabilities()
Date:   Fri, 25 Sep 2020 14:49:27 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <02EA37E5-87CB-401E-B5CA-BDE3A0D92517@intel.com>
In-Reply-To: <20200925201312.GA2455652@bjorn-Precision-5520>
References: <20200925201312.GA2455652@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25 Sep 2020, at 13:13, Bjorn Helgaas wrote:

> On Tue, Sep 22, 2020 at 02:38:52PM -0700, Sean V Kelley wrote:
>> From: Sean V Kelley <sean.v.kelley@intel.com>
>>
>> Extend support for Root Complex Event Collectors by decoding and
>> caching the RCEC Endpoint Association Extended Capabilities when
>> enumerating. Use that cached information for later error source
>> reporting. See PCI Express Base Specification, version 5.0-1,
>> section 7.9.10.
>>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> ---
>>  drivers/pci/pci.h         | 18 ++++++++++++++
>>  drivers/pci/pcie/Makefile |  2 +-
>>  drivers/pci/pcie/rcec.c   | 52 
>> +++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/probe.c       |  3 ++-
>>  include/linux/pci.h       |  4 +++
>>  5 files changed, 77 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/pci/pcie/rcec.c
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index fa12f7cbc1a0..83670a6425d8 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -449,6 +449,16 @@ int aer_get_device_error_info(struct pci_dev 
>> *dev, struct aer_err_info *info);
>>  void aer_print_error(struct pci_dev *dev, struct aer_err_info 
>> *info);
>>  #endif	/* CONFIG_PCIEAER */
>>
>> +#ifdef CONFIG_PCIEPORTBUS
>> +/* Cached RCEC Associated Endpoint Extended Capabilities */
>> +struct rcec_ext {
>> +	u8		ver;
>> +	u8		nextbusn;
>> +	u8		lastbusn;
>> +	u32		bitmap;
>> +};
>> +#endif
>> +
>>  #ifdef CONFIG_PCIE_DPC
>>  void pci_save_dpc_state(struct pci_dev *dev);
>>  void pci_restore_dpc_state(struct pci_dev *dev);
>> @@ -461,6 +471,14 @@ static inline void pci_restore_dpc_state(struct 
>> pci_dev *dev) {}
>>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
>>  #endif
>>
>> +#ifdef CONFIG_PCIEPORTBUS
>> +void pci_rcec_init(struct pci_dev *dev);
>> +void pci_rcec_exit(struct pci_dev *dev);
>> +#else
>> +static inline void pci_rcec_init(struct pci_dev *dev) {}
>> +static inline void pci_rcec_exit(struct pci_dev *dev) {}
>> +#endif
>> +
>>  #ifdef CONFIG_PCI_ATS
>>  /* Address Translation Service */
>>  void pci_ats_init(struct pci_dev *dev);
>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>> index 68da9280ff11..d9697892fa3e 100644
>> --- a/drivers/pci/pcie/Makefile
>> +++ b/drivers/pci/pcie/Makefile
>> @@ -2,7 +2,7 @@
>>  #
>>  # Makefile for PCI Express features and port driver
>>
>> -pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
>> +pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o rcec.o
>>
>>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>>
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> new file mode 100644
>> index 000000000000..519ae086ff41
>> --- /dev/null
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -0,0 +1,52 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Root Complex Event Collector Support
>> + *
>> + * Authors:
>> + *  Sean V Kelley <sean.v.kelley@intel.com>
>> + *  Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> + *
>> + * Copyright (C) 2020 Intel Corp.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/errno.h>
>> +#include <linux/bitops.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci_regs.h>
>
> Do we really need all the above?  I don't see any errno or bitops
> here.

Will remove unused.

>
>> +#include "../pci.h"
>> +
>> +void pci_rcec_init(struct pci_dev *dev)
>> +{
>> +	u32 rcec, hdr, busn;
>> +
>> +	/* Only for Root Complex Event Collectors */
>> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)
>> +		return;
>> +
>> +	dev->rcec_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC);
>> +	if (!dev->rcec_cap)
>> +		return;
>> +
>> +	dev->rcec_ext = kzalloc(sizeof(*dev->rcec_ext), GFP_KERNEL);
>> +
>> +	rcec = dev->rcec_cap;
>> +	pci_read_config_dword(dev, rcec + PCI_RCEC_RCIEP_BITMAP, 
>> &dev->rcec_ext->bitmap);
>> +
>> +	/* Check whether RCEC BUSN register is present */
>> +	pci_read_config_dword(dev, rcec, &hdr);
>> +	dev->rcec_ext->ver = PCI_EXT_CAP_VER(hdr);
>> +	if (dev->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
>> +		return;
>> +
>> +	pci_read_config_dword(dev, rcec + PCI_RCEC_BUSN, &busn);
>> +	dev->rcec_ext->nextbusn = PCI_RCEC_BUSN_NEXT(busn);
>> +	dev->rcec_ext->lastbusn = PCI_RCEC_BUSN_LAST(busn);
>> +}
>> +
>> +void pci_rcec_exit(struct pci_dev *dev)
>> +{
>> +	kfree(dev->rcec_ext);
>> +	dev->rcec_ext = NULL;
>> +}
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 03d37128a24f..16bc651fecb7 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2201,6 +2201,7 @@ static void pci_configure_device(struct pci_dev 
>> *dev)
>>  static void pci_release_capabilities(struct pci_dev *dev)
>>  {
>>  	pci_aer_exit(dev);
>> +	pci_rcec_exit(dev);
>>  	pci_vpd_release(dev);
>>  	pci_iov_release(dev);
>>  	pci_free_cap_save_buffers(dev);
>> @@ -2400,7 +2401,7 @@ static void pci_init_capabilities(struct 
>> pci_dev *dev)
>>  	pci_ptm_init(dev);		/* Precision Time Measurement */
>>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>>  	pci_dpc_init(dev);		/* Downstream Port Containment */
>> -
>> +	pci_rcec_init(dev);		/* Root Complex Event Collector */
>>  	pcie_report_downtraining(dev);
>>
>>  	if (pci_probe_reset_function(dev) == 0)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 835530605c0d..5c5c4eb642b6 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -326,6 +326,10 @@ struct pci_dev {
>>  #ifdef CONFIG_PCIEAER
>>  	u16		aer_cap;	/* AER capability offset */
>>  	struct aer_stats *aer_stats;	/* AER stats for this device */
>> +#endif
>> +#ifdef CONFIG_PCIEPORTBUS
>> +	u16		rcec_cap;	/* RCEC capability offset */
>
> Looking through the whole series, I think rcec_cap is used (a) in
> pci_rcec_init(), where we actually read the RCEC EA capability, and
> (b) in walk_rcec() and pcie_link_rcec(), where we only use it to test
> whether the device has an RCEC EA capability.
>
> Couldn't we accomplish (b) just by testing "dev->rcec_ext"?  Then we
> wouldn't need to save rcec_cap at all.

Yes, rcec_ext really implies that the cap is there so the explicit cap 
would not be necessary.  Will remove and make use of the renamed rcec_ea 
(per below).

>
>> +	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended 
>> capabilities */
>
> Maybe "rcec_ea"?  The important part is that this is the Endpoint
> Association information.  The fact that it happens to be an "extended"
> capability isn't very interesting.

Right, better to be more specific here.  Will change.

Thanks,

Sean

>
>>  #endif
>>  	u8		pcie_cap;	/* PCIe capability offset */
>>  	u8		msi_cap;	/* MSI capability offset */
>> -- 
>> 2.28.0
>>
