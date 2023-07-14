Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2B7535D7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjGNI6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjGNI6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 04:58:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9322726;
        Fri, 14 Jul 2023 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689325093; x=1720861093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K6zEff/fKEc4WrQ3+9BLwJsZRcU7IRGpw6GoicdbMB0=;
  b=SrD5ag3WedpCUVYs2pHWDNQbmj6jn4retLvhSMu4/NbgTFvyZjba+wrL
   Kl2xm0Prs8XX3uoKxXH4DcLVnwV1SZkhVJFaajo0zBdWc6kXlM384Psub
   ix44hB3dxy2Yc75xFVaqP9qq+9IB5eQdVLDdJHQwSm38agzTEvovM20I8
   oCyLRiDx2iW5wpqaA7TroIvDCRNQmyAYYOfO3Vl0ITfEy0WOuiovsjezK
   Rnji3aJxI9UeNTOOeXOknfe71WPXVL5xn6GFuuU/H61v+YikDvzTF04V6
   GlmMd0nbzxGYuuZIgdXInDNzRu+IsMcYGJ/kHY1+386D3+2k+0xohC/dU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="350300060"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="350300060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725642319"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="725642319"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2023 01:58:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKEco-002bog-2k;
        Fri, 14 Jul 2023 11:58:06 +0300
Date:   Fri, 14 Jul 2023 11:58:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 03/11] PCI: pciehp: Use RMW accessors for changing
 LNKCTL
Message-ID: <ZLEOHly6+Y/MBzAF@smile.fi.intel.com>
References: <20230713124505.94866-1-ilpo.jarvinen@linux.intel.com>
 <20230713124505.94866-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713124505.94866-4-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 13, 2023 at 03:44:57PM +0300, Ilpo Järvinen wrote:
> As hotplug is not the only driver touching LNKCTL, use the RMW
> capability accessor which handles concurrent changes correctly.

...

> +	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_LD,
> +					   !enable ? PCI_EXP_LNKCTL_LD : 0);

					   enable ? 0 : PCI_EXP_LNKCTL_LD);

easier to read and get.

-- 
With Best Regards,
Andy Shevchenko


