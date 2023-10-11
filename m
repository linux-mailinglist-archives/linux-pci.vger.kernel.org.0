Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847847C524B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjJKLlC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJKLlB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:41:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B118F;
        Wed, 11 Oct 2023 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697024459; x=1728560459;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xolNbnSR41bT5Gxm2xO/m9osxdxJ0UMd2pRcScUs0VU=;
  b=GlKDfUVXL9c0ENzeDHwrd2e4M/43uzmZGXa60BXYZCM3sApO6vNGMrRJ
   Kw6VzUnTI0buVhQmjb4Z5Vwee8EWELFWVdZEz0n9tG6l1RqFsDMmOG3L4
   EbLA4S7mPJtKGiV7NWAoou5/Nu+rdh3gtiGFx2TA5BcAkwB/QUb35Mc4J
   Cqh3Ek2lx6AqbGSbRB7gb6oM+7ZeR1oTs0jwm+hCsnK2uzeWlZor/OmBt
   UCJazW9TQAaks/WmbB5Bvtr9eXEA8Il+IhRFQYVqcDjPCSv6yBdHPpBad
   x/W6pHyerf+GtiPWy9m08p8gP0WvcTBIp1L+xzGv0/MpN9yM195n5Eqoj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448838245"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="448838245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730467408"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730467408"
Received: from opipikin-mobl2.ger.corp.intel.com (HELO sdodaev-mobl.ger.corp.intel.com) ([10.252.57.154])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:40:50 -0700
Date:   Wed, 11 Oct 2023 14:40:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 10/10] PCI/portdrv: Use FIELD_GET()
In-Reply-To: <20231010204436.1000644-11-helgaas@kernel.org>
Message-ID: <e4c240f1-2f8f-6617-ea5b-4d74f2185eb9@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-11-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-616638726-1697024453=:1977"
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

--8323329-616638726-1697024453=:1977
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
>  drivers/pci/pcie/portdrv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 46fad0d813b2..14a4b89a3b83 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/dmi.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -69,7 +70,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>  	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
>  		    PCIE_PORT_SERVICE_BWNOTIF)) {
>  		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
> -		*pme = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> +		*pme = FIELD_GET(PCI_EXP_FLAGS_IRQ, reg16);
>  		nvec = *pme + 1;
>  	}
>  
> @@ -81,7 +82,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>  		if (pos) {
>  			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
>  					      &reg32);
> -			*aer = (reg32 & PCI_ERR_ROOT_AER_IRQ) >> 27;
> +			*aer = FIELD_GET(PCI_ERR_ROOT_AER_IRQ, reg32);
>  			nvec = max(nvec, *aer + 1);
>  		}
>  	}
> @@ -92,7 +93,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>  		if (pos) {
>  			pci_read_config_word(dev, pos + PCI_EXP_DPC_CAP,
>  					     &reg16);
> -			*dpc = reg16 & PCI_EXP_DPC_IRQ;
> +			*dpc = FIELD_GET(PCI_EXP_DPC_IRQ, reg16);
>  			nvec = max(nvec, *dpc + 1);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-616638726-1697024453=:1977--
