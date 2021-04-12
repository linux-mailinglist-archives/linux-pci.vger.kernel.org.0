Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECE735D10C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhDLT2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 15:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237344AbhDLT2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 15:28:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A05B61352;
        Mon, 12 Apr 2021 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618255661;
        bh=qFlhkydUiC7xE0GIqveTRveWKRXRQiwAwp5r0CTOpV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vf9UPCGaC8CYxq5bwchEoV22B6m1ie7pVAU8QHWOXXPQqWUojh97f3MnXmRReWBTG
         12+tYHHDqjUcIdPW3ZVd1zIUKepFs0AoeusNC27g82bEPb6MP41tcHMXZM+WKEw3bH
         klCDFaX82SVslNJxgpIVURtHWfnNR2lpWUWDBaNGW95mzY615bCqticf+f8MGt0cmb
         Obj0Jv9dr1fxYFwcH8Xg+Xc44YFdfZp19icMr8HCDY4W9/K3Cna92CNe6RjxpV/B9Z
         /4sYfQM895ZHEWhGjz1ejqyhxbwKhYY6eid4btshRQ30QkWHtGoWJbsCNy2MwbGudg
         lykzNw4FBYNKA==
Date:   Mon, 12 Apr 2021 14:27:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20210412192740.GA2151026@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412124602.25762-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 02:46:02PM +0200, Pali Rohár wrote:
> Define new PCI_EXP_DEVCTL_PAYLOAD_* macros in linux/pci_regs.h header file
> for Max Payload Size. Macros are defined in the same style as existing
> macros PCI_EXP_DEVCTL_READRQ_* macros.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..8f1b15eea53e 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -504,6 +504,12 @@
>  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
>  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
>  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00A0 /* 4096 Bytes */

This is fine if we're going to use them, but we generally don't add
definitions purely for documentation.

5929b8a38ce0 ("PCI: Add defines for PCIe Max_Read_Request_Size") added
the PCI_EXP_DEVCTL_READRQ_* definitions and we do have a few (very
few) uses in drivers.

If we do need to add these, please follow the local use of lower-case
in the hex bitmasks.  The file is a mixture, but the closest examples
are lower-case.

>  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
>  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
>  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> -- 
> 2.20.1
> 
