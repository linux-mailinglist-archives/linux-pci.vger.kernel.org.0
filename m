Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF3420787
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhJDIpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 04:45:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhJDIpm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 04:45:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD2C8101E;
        Mon,  4 Oct 2021 01:43:53 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A2A33F66F;
        Mon,  4 Oct 2021 01:43:52 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:43:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 01/13] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20211004084350.GB22336@lpieralisi>
References: <20211001195856.10081-1-kabel@kernel.org>
 <20211001195856.10081-2-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001195856.10081-2-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 09:58:44PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
> Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)

This requires Bjorn's ACK.

Thanks,
Lorenzo

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..ff6ccbc6efe9 100644
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
> +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
>  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
>  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
>  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> -- 
> 2.32.0
> 
