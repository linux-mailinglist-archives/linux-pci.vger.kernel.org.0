Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D066722D9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfGWXK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 19:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfGWXK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 19:10:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488B5216F4;
        Tue, 23 Jul 2019 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563923427;
        bh=j8bLuldBBqMhCMCDVzy6BAXt6Ga9tRbQC3m8P6hPc1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AP0zSSo2VmV3eHyP04t0twnDt3kxR+lAykX9TsL3++GI4Dm+wUVunwKCRkOlRfzfw
         PXzBYbuRz48swE2BbLvNmn4nAfR2dwsjH6/ndpZksMwaIGEKjnT90qEwjLOYq16V1T
         K02oooz+AOPrdwndVwuGPFI/l167ThiU8whSmK+M=
Date:   Tue, 23 Jul 2019 18:10:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vicki Pfau <vi@endrift.com>
Cc:     linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Woods <brian.woods@amd.com>
Subject: Re: [PATCH 1/2] x86/amd_nb: Add PCI device IDs for family 17h, model
 70h
Message-ID: <20190723231025.GB47047@google.com>
References: <20190714183209.29916-1-vi@endrift.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714183209.29916-1-vi@endrift.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 14, 2019 at 11:32:08AM -0700, Vicki Pfau wrote:
> Add the PCI device IDs for the newly released AMD Ryzen 3xxx desktop
> (Matisse) CPU line northbridge link and misc devices.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

It's still a shame to have to modify the kernel to add new device IDs
even though there's no new functionality here.  But ISTR there was a
hornet's nest there ;)

> ---
>  arch/x86/kernel/amd_nb.c | 3 +++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index d63e63b7d1d9..0a8b816857c1 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -21,6 +21,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -49,6 +50,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{}
>  };
> @@ -63,6 +65,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{}
>  };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..862556761bbf 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -548,6 +548,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.22.0
> 
