Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AB2854B9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 00:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJFWp4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 18:45:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:41676 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgJFWp4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 18:45:56 -0400
IronPort-SDR: lG3QvKkW+57SpBwyTwYMNSCflG/0qZdLJ4b2HV4uKE+YXjzLeILbNg/PVTCKlDIC6/z8286+Ta
 kR/bcwPIgjpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="164797539"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="164797539"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 15:45:54 -0700
IronPort-SDR: W4s6uVAMv/wWjKImtrYsHBUxSulbo23oKS3gGpZqeT1emkKgexwZOlRQaUgNtmfkZ7C5HeSM2k
 ZGknGaqObfRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="461044940"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2020 15:45:54 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 2679C580782;
        Tue,  6 Oct 2020 15:45:54 -0700 (PDT)
Message-ID: <b75c3ff53dbe26ee0c6825e8d1f5f10489a5722c.camel@linux.intel.com>
Subject: Re: [PATCH V8 1/5] PCI: Add defines for Designated Vendor-Specific
 Extended Capability
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     lee.jones@linaro.org, dvhart@infradead.org, andy@infradead.org,
        bhelgaas@google.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Tue, 06 Oct 2020 15:45:54 -0700
In-Reply-To: <20201003013123.20269-2-david.e.box@linux.intel.com>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
         <20201003013123.20269-2-david.e.box@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This patch has been acked and unchanged for weeks. Is it possible to
get this pulled into next? We have SIOV and CXL related work that is
using these definitions. Thanks.

David

On Fri, 2020-10-02 at 18:31 -0700, David E. Box wrote:
> Add PCIe Designated Vendor-Specific Extended Capability (DVSEC) and
> defines
> for the header offsets. Defined in PCIe r5.0, sec 7.9.6.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h
> b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..beafeee39e44 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -720,6 +720,7 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port
> Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement
> */
> +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific 
> */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer
> 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> @@ -1062,6 +1063,10 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /*
> LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register
> */
>  
> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> +#define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-
> Specific Header1 */
> +#define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-
> Specific Header2 */
> +
>  /* Data Link Feature */
>  #define PCI_DLF_CAP		0x04	/* Capabilities Register */
>  #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link
> Feature Exchange Enable */

