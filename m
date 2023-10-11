Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899177C520D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbjJKL2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbjJKL2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:28:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17807198E;
        Wed, 11 Oct 2023 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697023218; x=1728559218;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wQggwqpGoqsQbtZ47vm6zVFK/IO32aEH3Qz/VufZSs8=;
  b=YghAG74hvV6PVe6+FqFoxWGW08KczzP0Yj/PhHri0eCN3ZGxSyxSs7oc
   6WS0zwNIdoiOIb2DCsKtMV2vNSe1RViBaLNaTly55SxtQPenYI5H1kz7q
   wmoOkrpaSAjcG6bzZTQ0qJxqr1mIgBJdrEfdMJkO9B0+vrKIjsV/Ipsvd
   HRA662Qmap/DVmD/4BgTMQVMdqKlRAqmJeORB7MlkTJtyl/fOvUxkYoLf
   YTVxWcfGn3xaFhpzXvD1ILMFevs8mXxHl+VpK5LlTKfquKTNRZO5TnYBG
   rs+Z+lvBjjdI77nyeqB0kolxmQkrvn5woV9VqPMgmL6iQENjRB7ZDBD27
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448835573"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="448835573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730462088"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730462088"
Received: from opipikin-mobl2.ger.corp.intel.com ([10.252.57.154])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:20:14 -0700
Date:   Wed, 11 Oct 2023 14:20:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 05/10] PCI/ATS: Use FIELD_GET()
In-Reply-To: <20231010204436.1000644-6-helgaas@kernel.org>
Message-ID: <85b2c818-1c43-e633-8179-ec694214ce77@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-6-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-951230455-1697023216=:1977"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-951230455-1697023216=:1977
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 10 Oct 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c             | 7 ++-----
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..c570892b2090 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -9,6 +9,7 @@
>   * Copyright (C) 2011 Advanced Micro Devices,
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/export.h>
>  #include <linux/pci-ats.h>
>  #include <linux/pci.h>
> @@ -480,8 +481,6 @@ int pci_pasid_features(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
> -#define PASID_NUMBER_SHIFT	8
> -#define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>  /**
>   * pci_max_pasids - Get maximum number of PASIDs supported by device
>   * @pdev: PCI device structure
> @@ -503,9 +502,7 @@ int pci_max_pasids(struct pci_dev *pdev)
>  
>  	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
>  
> -	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
> -
> -	return (1 << supported);
> +	return (1 << FIELD_GET(PCI_PASID_CAP_WIDTH, supported));
>  }
>  EXPORT_SYMBOL_GPL(pci_max_pasids);
>  #endif /* CONFIG_PCI_PASID */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 6af1f8d53e97..833e5fb40ea5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -932,6 +932,7 @@
>  #define PCI_PASID_CAP		0x04    /* PASID feature register */
>  #define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
>  #define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
> +#define  PCI_PASID_CAP_WIDTH	0x1f00
>  #define PCI_PASID_CTRL		0x06    /* PASID control register */
>  #define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
>  #define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-951230455-1697023216=:1977--
