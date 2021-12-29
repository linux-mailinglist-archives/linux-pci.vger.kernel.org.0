Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861C8481681
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 21:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhL2UAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 15:00:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52092 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhL2UAQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 15:00:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CB31B81A02;
        Wed, 29 Dec 2021 20:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF052C36AEA;
        Wed, 29 Dec 2021 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640808014;
        bh=wqhMfCvA9zj0zXkZZQhJ9lSi8r+UeURgf/ajHSematg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OeanErZL1YBoL2iej/Q6v/kFInv0fHpYLmYObk2wxWdBt2h+8GWvSP+rl1859P83K
         wg8idnGLOOKehP0qVfyIuQrYZ4e0xpOXgjdVC29cC7NeSExLhqUdkgGACryaQpS9RR
         qs1b9cOYEF6kxgPW7IbRDo02BPEV+aQDMknx1fMdvDc0Aqjc1kiGPhfF3laP1Tmrpt
         4i2hkZ8qbfhmhfhFg2dYtD0zlagIzF3NURvCUPM3ogKoktKR8DcOryJYVE0+NAMurD
         IkEd5jhKOsI0a9P0qo0LeMgzLqFML2VVI9IM6HidIsRnT8+S/79s453MxRdWLdbhxj
         ZipaUu/2rHZeQ==
Date:   Wed, 29 Dec 2021 14:00:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Add device code for AMD FCH SATA Controller
 in AHCI mode
Message-ID: <20211229200012.GA1698594@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227162658.11314-1-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 27, 2021 at 05:26:56PM +0100, Paul Menzel wrote:
> The ASUS F2A85-M PRO with the fusion controller hub (FCH) AMD A85
> (Hudson D4) has the SATA controller below.
> 
>     $ lspci -s 00:11.0
>     00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7801] (rev 40)
> 
> Add the ID for it, when in AHCI mode.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..fe944b44858a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -602,6 +602,7 @@
>  #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
>  #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
> +#define PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI	0x7801
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
> -- 
> 2.30.2
> 
