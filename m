Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FD7C5223
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjJKLcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKLcE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:32:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC58C9;
        Wed, 11 Oct 2023 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697023921; x=1728559921;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hbERW9TCUzG04DSURrSyqLQenuj4yH5qm9T4ka2HjGY=;
  b=WJsqcOozISNVWwXIyWPFOth7ytIjbbh3NgJc1fXY4PpND1q0R6XM+Y8/
   EG5ssT63sM9iCS+thSQOSy8U5MSQpHA8pGrluzq7qOGhElkGvNXreCZu3
   8HvJgbRh3IlXoOVB7veo91TsMMVrjw8irUYQn6A8VfGkCCVDvMGCtIOEK
   MdqyhfQOuKCDkoxj2DLzSrB94ULMmqHHoV23tDZtga6AEM4+F3sitN2BG
   6uGI+4WsjROCnzNPi+Fwz6WzIYE0ToF5AgDKSZgCq7SiXPdJkpo3inM8p
   HENxDf1NGZjJzcjr9pn6jvpfw5hmUzLY5mXHMxv6dX6rMjjQK7TYqlP6A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369702099"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369702099"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="844523907"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="844523907"
Received: from opipikin-mobl2.ger.corp.intel.com (HELO sdodaev-mobl.ger.corp.intel.com) ([10.252.57.154])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:31:58 -0700
Date:   Wed, 11 Oct 2023 14:31:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 04/10] PCI/ATS: Show PASID Capability register width in
 bitmasks
In-Reply-To: <20231010204436.1000644-5-helgaas@kernel.org>
Message-ID: <46318dc8-3658-403e-1ca2-cb8ed138bbd@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1123553150-1697023920=:1977"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1123553150-1697023920=:1977
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 10 Oct 2023, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PASID Capability and Control registers are both 16 bits wide.  Use
> 16-bit wide constants in field names to match the register width.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/uapi/linux/pci_regs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 34bf037993f3..6af1f8d53e97 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -930,12 +930,12 @@
>  
>  /* Process Address Space ID */
>  #define PCI_PASID_CAP		0x04    /* PASID feature register */
> -#define  PCI_PASID_CAP_EXEC	0x02	/* Exec permissions Supported */
> -#define  PCI_PASID_CAP_PRIV	0x04	/* Privilege Mode Supported */
> +#define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
> +#define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
>  #define PCI_PASID_CTRL		0x06    /* PASID control register */
> -#define  PCI_PASID_CTRL_ENABLE	0x01	/* Enable bit */
> -#define  PCI_PASID_CTRL_EXEC	0x02	/* Exec permissions Enable */
> -#define  PCI_PASID_CTRL_PRIV	0x04	/* Privilege Mode Enable */
> +#define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
> +#define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */
> +#define  PCI_PASID_CTRL_PRIV	0x0004	/* Privilege Mode Enable */
>  #define PCI_EXT_CAP_PASID_SIZEOF	8

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1123553150-1697023920=:1977--
