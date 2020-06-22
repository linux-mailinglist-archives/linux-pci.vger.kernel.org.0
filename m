Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7753204466
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 01:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgFVX0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 19:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgFVX0U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 19:26:20 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288302076E;
        Mon, 22 Jun 2020 23:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592868379;
        bh=z9oW+bNQE9z595itlOYPtEpmIp2zhxHxzEarExwecsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jgdOF9rdaptKSp4ZjAAW+sCHGvJspXu72WwobdfTUVR9mD4TkB24XpQlBAMxhmkvb
         C4A8j/HcMU0PGiIKsftuym+FEsEXem6IamFKuw2uEy1xwA2fDQE/ofRCOI50ynvi/n
         wDWlAJ/ynmbQU+CfRRj14FVn5TaT/P5W2N9pI17o=
Date:   Mon, 22 Jun 2020 18:26:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     mj@ucw.cz, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pciutils: Add decode support for RCECs
Message-ID: <20200622232617.GA2334699@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622230330.799259-1-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 04:03:30PM -0700, Sean V Kelley wrote:
> Root Complex Event Collectors provide support for terminating error
> and PME messages from RCiEPs.  This patch provides basic decoding for
> lspci RCEC Endpoint Association Extended Capability. See PCie 5.0-1,
> sec 7.9.10 for further details.

s/lspci/the/
s/PCie/PCIe/

> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
> ---
>  lib/header.h   |   8 +-
>  ls-ecaps.c     |  30 ++++-
>  setpci.c       |   2 +-
>  tests/cap-rcec | 299 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 335 insertions(+), 4 deletions(-)
>  create mode 100644 tests/cap-rcec
> 
> diff --git a/lib/header.h b/lib/header.h
> index 472816e..deb5150 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -219,7 +219,7 @@
>  #define PCI_EXT_CAP_ID_PB	0x04	/* Power Budgeting */
>  #define PCI_EXT_CAP_ID_RCLINK	0x05	/* Root Complex Link Declaration */
>  #define PCI_EXT_CAP_ID_RCILINK	0x06	/* Root Complex Internal Link Declaration */
> -#define PCI_EXT_CAP_ID_RCECOLL	0x07	/* Root Complex Event Collector */
> +#define PCI_EXT_CAP_ID_RCEC	0x07	/* Root Complex Event Collector */

OK, not super descriptive, but it does match the kernel's definition
in pci_regs.h.

>  #define PCI_EXT_CAP_ID_MFVC	0x08	/* Multi-Function Virtual Channel */
>  #define PCI_EXT_CAP_ID_VC2	0x09	/* Virtual Channel (2nd ID) */
>  #define PCI_EXT_CAP_ID_RCRB	0x0a	/* Root Complex Register Block */
> @@ -1048,6 +1048,12 @@
>  #define  PCI_RCLINK_LINK_ADDR	8	/* Link Entry: Address (64-bit) */
>  #define  PCI_RCLINK_LINK_SIZE	16	/* Link Entry: sizeof */
>  
> +/* Root Complex Event Collector */

This comment could mention "Endpoint Association", though.

> +#define  PCI_RCEC_EP_CAP_VER(reg)	(((reg) >> 16) & 0xf)
> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* as per PCIe sec 7.9.10.1 */
> +#define  PCI_RCEC_RCIEP_BMAP	0x0004	/* as per PCIe sec 7.9.10.2 */
> +#define  PCI_RCEC_BUSN_REG	0x0008	/* as per PCIe sec 7.9.10.3 */
> +
>  /* PCIe Vendor-Specific Capability */
>  #define PCI_EVNDR_HEADER	4	/* Vendor-Specific Header */
>  #define PCI_EVNDR_REGISTERS	8	/* Vendor-Specific Registers */
> diff --git a/ls-ecaps.c b/ls-ecaps.c
> index e71209e..589332d 100644
> --- a/ls-ecaps.c
> +++ b/ls-ecaps.c
> @@ -634,6 +634,32 @@ cap_rclink(struct device *d, int where)
>      }
>  }
>  
> +static void
> +cap_rcec(struct device *d, int where)
> +{
> +  printf("Root Complex Event Collector\n");

This could mention "Endpoint Association", too.

> +  if (verbose < 2)
> +    return;
> +
> +  if (!config_fetch(d, where, 12))
> +    return;
> +
> +  u32 hdr = get_conf_long(d, where);
> +  byte cap_ver = PCI_RCEC_EP_CAP_VER(hdr);
> +  u32 bmap = get_conf_long(d, where + PCI_RCEC_RCIEP_BMAP);
> +  printf("\t\tDesc:\tCapabilityVersion=%02x RCiEPBitmap=%08x\n",
> +    cap_ver,
> +    bmap);

I don't think "Desc:" is necessary.

Isn't "cap_ver" already printed as part of the header?

   Capabilities: [160 v2] Root Complex Event Collector
                      ^^

The "bmap" is a bitmap of device numbers of RCiEPs on the same bus as
the RCEC that are associated with this RCEC.  Could be decoded as a
list, e.g., "0, 1, 2, 8" or "0-3, 8".  Or maybe the hex bitmap is
enough.  Not sure how much trouble this would be worth or if there are
other examples in lspci to copy.

> +  if (cap_ver < PCI_RCEC_BUSN_REG_VER)
> +    return;
> +
> +  u32 busn = get_conf_long(d, where + PCI_RCEC_BUSN_REG);
> +  printf("\t\t\tRCECLastBus=%02x RCECFirstBus=%02x\n",
> +    BITS(busn, 16, 8),
> +    BITS(busn, 8, 8));
> +}
