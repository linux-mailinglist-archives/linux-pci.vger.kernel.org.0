Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490C65AFBAF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 07:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIGFZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 01:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGFZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 01:25:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1E52DDC;
        Tue,  6 Sep 2022 22:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662528321; x=1694064321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3fwuebPci+layBCJrWgeXhUy9wzDEyG0L73TDATLe+k=;
  b=eMVUfS57hlc7rstnmlny67094iAjM9OfUgwXyxCIzUCsb25tUYTr5ZTv
   Cats8VQQFldPc8/FKLHMBzV99KUzyBIJiULMC6IvUsyULBtQNQKbm5Ghh
   vuXzmZl2Pc6c3epQAwOTiH/Phz+NU/irEiZJvE0pbT4FU5c4hjwsK6yMO
   t2dVHuKCxiY/3u/3rHvv/q2FiFUVdvKeQXvO9tagOsIPlBoA2k/6Z0iSC
   If44RtneCHjqIdtWBUc83SFtQopS61F+GQzY0XrtcmxICSXDzdoEYT6HW
   MaOJNAda3Ff7bks41JWao6aFm9hnl2hYnDJOJOAuUkdqq1HPkvSODUkt9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358499552"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="358499552"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="859514583"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2022 22:25:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7F294F7; Wed,  7 Sep 2022 08:25:30 +0300 (EEST)
Date:   Wed, 7 Sep 2022 08:25:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 04/10] PCI/PTM: Separate configuration and enable
Message-ID: <YxgrSltxhdEZt4WL@black.fi.intel.com>
References: <20220906222351.64760-1-helgaas@kernel.org>
 <20220906222351.64760-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906222351.64760-5-helgaas@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 05:23:45PM -0500, Bjorn Helgaas wrote:
> +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +

Unnecessary empty line.

> +		/*
> +		 * Per sec 7.9.15.3, this should be the Local Clock
> +		 * Granularity of the associated Time Source.  But it
> +		 * doesn't say how to find that Time Source.
> +		 */
> +		dev->ptm_granularity = 0;
