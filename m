Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A334B7C5246
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjJKLkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjJKLkI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:40:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC87C93;
        Wed, 11 Oct 2023 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697024406; x=1728560406;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LRMI9HqFBKquKFWFkeENUvqUvLxgC+ygNTlsAn9NeAE=;
  b=lufjFv2efTAPhjXdkE9rTAN/xrmaCdlNSYkwgTIMK9Eig+pfP49tQR2B
   TNk1/XFaLrBnT99PwTbYVCBA8YqfOcoBHkYKb10hbnJCwv+4Fpf77q3WE
   38rP5yhJgTEa8TVIrTBw5WOdG0Iv9OYgpWNnucguriva1A0CFl2ClCSe7
   k/drx7WrvIfMQ0fLaZic+aFUMeyZoeMBeJXlckfEyRctnY2wqdOyG+Mhn
   UHlpNkLMh1kD9sr5chS2pfDnu8loQQEamSXU5a/tVEgZ0GiYXE/IXV35W
   ukpczqIiRPBLqMMio1Q3wwEBicbKGpvev1emsnK9Oyyb7kCf1pNWtpZlU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364922330"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364922330"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927536417"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="927536417"
Received: from opipikin-mobl2.ger.corp.intel.com ([10.252.57.154])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:40:02 -0700
Date:   Wed, 11 Oct 2023 14:39:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 09/10] PCI/VC: Use FIELD_GET()
In-Reply-To: <20231010204436.1000644-10-helgaas@kernel.org>
Message-ID: <5bf5368a-97cb-eac7-2880-4fc654f36f3@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-10-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-918573796-1697024404=:1977"
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

--8323329-918573796-1697024404=:1977
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
>  drivers/pci/vc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index 5fc59ac31145..a4ff7f5f66dd 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -6,6 +6,7 @@
>   *     Author: Alex Williamson <alex.williamson@redhat.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -201,9 +202,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
>  	/* Extended VC Count (not counting VC0) */
>  	evcc = cap1 & PCI_VC_CAP1_EVCC;
>  	/* Low Priority Extended VC Count (not counting VC0) */
> -	lpevcc = (cap1 & PCI_VC_CAP1_LPEVCC) >> 4;
> +	lpevcc = FIELD_GET(PCI_VC_CAP1_LPEVCC, cap1);
>  	/* Port Arbitration Table Entry Size (bits) */
> -	parb_size = 1 << ((cap1 & PCI_VC_CAP1_ARB_SIZE) >> 10);
> +	parb_size = 1 << FIELD_GET(PCI_VC_CAP1_ARB_SIZE, cap1);
>  
>  	/*
>  	 * Port VC Control Register contains VC Arbitration Select, which
> @@ -231,7 +232,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
>  		int vcarb_offset;
>  
>  		pci_read_config_dword(dev, pos + PCI_VC_PORT_CAP2, &cap2);
> -		vcarb_offset = ((cap2 & PCI_VC_CAP2_ARB_OFF) >> 24) * 16;
> +		vcarb_offset = FIELD_GET(PCI_VC_CAP2_ARB_OFF, cap2) * 16;
>  
>  		if (vcarb_offset) {
>  			int size, vcarb_phases = 0;
> @@ -277,7 +278,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
>  
>  		pci_read_config_dword(dev, pos + PCI_VC_RES_CAP +
>  				      (i * PCI_CAP_VC_PER_VC_SIZEOF), &cap);
> -		parb_offset = ((cap & PCI_VC_RES_CAP_ARB_OFF) >> 24) * 16;
> +		parb_offset = FIELD_GET(PCI_VC_RES_CAP_ARB_OFF, cap) * 16;
>  		if (parb_offset) {
>  			int size, parb_phases = 0;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-918573796-1697024404=:1977--
