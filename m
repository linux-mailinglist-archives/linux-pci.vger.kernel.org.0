Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F667E4A3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 23:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfHAVMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 17:12:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:45634 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbfHAVMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 17:12:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 14:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="348219613"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2019 14:12:08 -0700
Date:   Thu, 1 Aug 2019 15:09:29 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        keith.busch@intel.com
Subject: Re: [PATCH v4 2/7] PCI/ATS: Initialize PRI in pci_ats_init()
Message-ID: <20190801210929.GE15795@localhost.localdomain>
References: <cover.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <744998862eebecfae79afd23c42d518264231a22.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <744998862eebecfae79afd23c42d518264231a22.1562172836.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 01:46:19PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> +#ifdef CONFIG_PCI_PRI
> +static void pci_pri_init(struct pci_dev *pdev)
> +{
> +	u32 max_requests;
> +	int pos;
> +
> +	/*
> +	 * As per PCIe r4.0, sec 9.3.7.11, only PF is permitted to
> +	 * implement PRI and all associated VFs can only use it.
> +	 * Since PF already initialized the PRI parameters there is
> +	 * no need to proceed further.
> +	 */
> +	if (pdev->is_virtfn)
> +		return;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_dword(pdev, pos + PCI_PRI_MAX_REQ, &max_requests);
> +
> +	/*
> +	 * Since PRI is a shared resource between PF and VF, we must not
> +	 * configure Outstanding Page Allocation Quota as a per device
> +	 * resource in pci_enable_pri(). So use maximum value possible
> +	 * as default value.
> +	 */
> +	pci_write_config_dword(pdev, pos + PCI_PRI_ALLOC_REQ, max_requests);
> +
> +	pdev->pri_reqs_alloc = max_requests;
> +	pdev->pri_cap = pos;
> +}
> +#endif
> +
>  void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
> @@ -28,6 +62,10 @@ void pci_ats_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->ats_cap = pos;
> +
> +#ifdef CONFIG_PCI_PRI
> +	pci_pri_init(dev);
> +#endif
>  }

Rather than surround the call to pci_pri_init() with the #ifdef, you
should provide an empty function implementation when CONFIG_PCI_PRI is
not defined. Same thing for the next patch adding PASID.
