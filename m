Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F15A7AA1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiHaJwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiHaJwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 05:52:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F3D0211;
        Wed, 31 Aug 2022 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661939573; x=1693475573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liz9QKD66fjJkJlD6S49BKSU5AKN4A+IAiqQaU4RCD8=;
  b=j6g7rO1LTYomwUIhdyo3zeYN7NjVAKDXh6BB+kiscEWUSupWvUfvSlTi
   sw6dvMi7fhCVbFhisFz/2gCdBXKJDN7+gCnwJO20iH3kIS3BFVeMIoH2z
   EmfWsryMx/z4Mv+AE23OzCjcjppFJbpPg9X5yWYN5tMS+utjQPkt8EDmj
   cbDDuffaOlMSA/8Jt/VEM1FhAkuGmAxGABbQCTaXoUa/Kl6QoktPRG+C7
   NCFxiyvsWc2eRZPOkGrxWHWMln9rMEBmbiM2bvb+OKOsu0XbH/5UzhmZa
   LrT9kZrUZsYzHeq0/kMzfav3Jsy6ORnfkvecfPEJxeVM6h9HQkxjeivyg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282386818"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="282386818"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="608138049"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2022 02:52:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8D8C2174; Wed, 31 Aug 2022 12:53:05 +0300 (EEST)
Date:   Wed, 31 Aug 2022 12:53:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Disable PTM on Upstream Ports during suspend
Message-ID: <Yw8vgYeqY6a79HDR@black.fi.intel.com>
References: <20220830155224.103907-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830155224.103907-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Aug 30, 2022 at 10:52:24AM -0500, Bjorn Helgaas wrote:
> +	type = pci_pcie_type(dev);
> +	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
> +	      type == PCI_EXP_TYPE_UPSTREAM ||
> +	      type == PCI_EXP_TYPE_ENDPOINT))
> +		return;

Perhaps switch () instead?

switch (pci_pcie_type(dev)) {
case PCI_EXP_TYPE_ROOT_PORT:
case PCI_EXP_TYPE_UPSTREAM:
case PCI_EXP_TYPE_ENDPOINT:
	break;
default:
	return;
}

Either way,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
