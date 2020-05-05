Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C961C5DAB
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 18:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgEEQeW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 12:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgEEQeW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 12:34:22 -0400
Received: from localhost (mobile-166-175-56-67.mycingular.net [166.175.56.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D29206FA;
        Tue,  5 May 2020 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588696461;
        bh=BqeRErPLvrkInDRUEC8fNeToroaXgVoXwdAnzn6jhV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ClXe+DR40QL3TVBIydWa9ZpfBw9VdX7i2AtxLrzIhy3x5pcQ+Psqh8ikvxF0hH4cM
         yQ+R/tjMh4VW1C0qRfRzjjIVyOvCTTiHbCZ9A9y9PX8V4FexoiB7IDPp2UzRM/rqQF
         m7SNiYRDP7FXIjH0bfP+QnvB5NB5feokFsUGM6LE=
Date:   Tue, 5 May 2020 11:34:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     bhelgaas@google.com, andy@infradead.org,
        alexander.h.duyck@intel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] pci: Add Designated Vendor Specific Capability
Message-ID: <20200505163420.GA363203@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505013206.11223-2-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  $ git log --oneline include/uapi/linux/pci_regs.h
  202853595e53 PCI: pciehp: Disable in-band presence detect when possible
  ed22aaaede44 PCI: dwc: intel: PCIe RC controller driver
  bbdb2f5ecdf1 PCI: Add #defines for Enter Compliance, Transmit Margin
  c9c13ba428ef PCI: Add PCI_STD_NUM_BARS for the number of standard BARs
  106feb2fdced PCI: pciehp: Remove pciehp_set_attention_status()
  448d5a55759a PCI: Add #defines for some of PCIe spec r4.0 features
  de76cda215d5 PCI: Decode PCIe 32 GT/s link speed

Yours could be:

  PCI: Add #defines for Designated Vendor-Specific Capability

On Mon, May 04, 2020 at 06:32:04PM -0700, David E. Box wrote:
> Add pcie dvsec extended capability id along with helper macros to
> retrieve information from the headers.

s/pcie/PCIe/
s/dvsec/DVSEC/
s/id/ID/

I don't see any helper macros in the patch.  Well, OK, I guess the
header offsets could be considered macros.

> https://members.pcisig.com/wg/PCI-SIG/document/12335

This URL is for an ECN.  DVSEC is included in PCIe r5.0, sec 7.9.6, so
please cite that instead so the citation remains useful after the URL
becomes stale and for people who have the spec but not access to the
PCI-SIG website.

> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..c96f08d1e711 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -720,6 +720,7 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> +#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Desinated Vendor-Specific */

s/Desinated/Designated/

>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> @@ -1062,6 +1063,10 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
>  
> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> +#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific Header1 */
> +#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific Header2 */
> +
>  /* Data Link Feature */
>  #define PCI_DLF_CAP		0x04	/* Capabilities Register */
>  #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
> -- 
> 2.20.1
> 
