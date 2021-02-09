Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9423158FB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 22:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhBIVvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 16:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233530AbhBIVKH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 16:10:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE1664E7A;
        Tue,  9 Feb 2021 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612904956;
        bh=zPshNYYFXKSJS1wslEtEfsCT/O2+xCNYoNiqqWCdjSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Zn5gTsXlvY3ytFe55Gfc5Gy5WlWm8USvW8m8E+qMDs11tp/aed3zUQpJSOV/by5d9
         S3zNFpMkFiw4U9ILxWLAiNOr0fCpunyvp44zSdIWxJ3G/V0ynIkb2S9ZIHMOguLs+/
         Hv39MLW2gAcEoNqTvjaHvz/ohh/MIWJhDMKsa2g9wxViLdXzR80A2+tIixuWGCsy0w
         ZprtZZNyRWEayPZjPos4SiPD8aVE6qPrEbVyIYvCXLHpbTA28kxfEmAc/0r+ctCWxl
         RlPB4aVxrWMHnNn+unF3b6cQkeCDj0Z2Abk02VYlgL6tFjjivRkWiZoH2tAMN9nSOZ
         eDPt992E6ZVew==
Date:   Tue, 9 Feb 2021 15:09:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PCI: Add Silicom Denmark vendor ID
Message-ID: <20210209210915.GA512168@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208150158.2877414-1-mhu@silicom.dk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 08, 2021 at 04:01:57PM +0100, Martin Hundebøll wrote:
> Update pci_ids.h with the vendor ID for Silicom Denmark. The define is
> going to be referenced in driver(s) for FPGA accelerated smart NICs.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>

Applied to pci/misc for v5.12 with reviewed-by from Krzysztof and Tom,
thanks!

> ---
> 
> Changes since v1:
>  * Align commit message/shortlog with similar changes to pci_ids.h
> 
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index f968fcda338e..c119f0eb41b6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2589,6 +2589,8 @@
>  
>  #define PCI_VENDOR_ID_REDHAT		0x1b36
>  
> +#define PCI_VENDOR_ID_SILICOM_DENMARK	0x1c2c
> +
>  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
>  
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
> -- 
> 2.29.2
> 
