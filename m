Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678067C5244
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjJKLjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbjJKLi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:38:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1178F;
        Wed, 11 Oct 2023 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697024336; x=1728560336;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GPkCjm3yLjG3e96xldCF3K9/fcJKD337qFs8kK1u8Kg=;
  b=fj+dVAk5hrIYuH4ffWHlOr70CJl7qEhtSSWrjU2xvKMlN6950fyMQFhR
   e6MXGfw73YcxGn+e0zDCdqnXj18InFFUxkQca9jwSKwwaF4d7Bs65N3bM
   b9guoAyIh2bjhwc7KHReY6mMzrPM/tg/nj7OJU01pJwrFaGo8qkjIeOaV
   dqrOm822dmJ22lOLqeJUH7ksPDaKHVERIFf1SXvOvAwnYBvEyzLy4EBUe
   3K8yO0GVUbzf8OU9YwE4rO5FKP6aH+f/GjBu/MjYcFHIHvFEabQgM1fxW
   Hrh7NOgSDF39UA9uYy4y7ORJOdDbxau9rI/BjMRbzVVoYBtZud5LmVPdo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3228527"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3228527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788968127"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788968127"
Received: from opipikin-mobl2.ger.corp.intel.com ([10.252.57.154])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:38:53 -0700
Date:   Wed, 11 Oct 2023 14:38:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 07/10] PCI/PME: Use FIELD_GET()
In-Reply-To: <20231010204436.1000644-8-helgaas@kernel.org>
Message-ID: <602f5d96-889d-d4a4-409f-334db2beb4f@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-8-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-593103629-1697024335=:1977"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-593103629-1697024335=:1977
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
>  drivers/pci/pcie/pme.c        | 4 +++-
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index ef8ce436ead9..a2daebd9806c 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -9,6 +9,7 @@
>  
>  #define dev_fmt(fmt) "PME: " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -235,7 +236,8 @@ static void pcie_pme_work_fn(struct work_struct *work)
>  			pcie_clear_root_pme_status(port);
>  
>  			spin_unlock_irq(&data->lock);
> -			pcie_pme_handle_request(port, rtsta & 0xffff);
> +			pcie_pme_handle_request(port,
> +				    FIELD_GET(PCI_EXP_RTSTA_PME_RQ_ID, rtsta));
>  			spin_lock_irq(&data->lock);
>  
>  			continue;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e97a06b50f95..9fb8a69241f4 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -637,6 +637,7 @@
>  #define PCI_EXP_RTCAP		0x1e	/* Root Capabilities */
>  #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
>  #define PCI_EXP_RTSTA		0x20	/* Root Status */
> +#define  PCI_EXP_RTSTA_PME_RQ_ID 0x0000ffff /* PME Requester ID */
>  #define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
>  #define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

(I'd have used REQ myself but it seems both forms are commonly used by 
the existing defines.)

-- 
 i.

--8323329-593103629-1697024335=:1977--
