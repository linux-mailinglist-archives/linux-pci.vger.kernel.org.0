Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2095434BD8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTNPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 09:15:22 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44572 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJTNPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 09:15:22 -0400
Received: by mail-oi1-f171.google.com with SMTP id y207so9540201oia.11;
        Wed, 20 Oct 2021 06:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2r3mbgEOKCAphWOTFN2e6UULnD2H9GQNAPamdyEgIXU=;
        b=vyq964GmUK0EE+Mo4BBu5QcF5gxc+dFOTUkVcNM4wCnPiTDy4u/JHdjTHHY0FcVoAV
         fS1cYytFQ1THR7l/OXCi6ib9Ilp3hVJfqR4r7PEoAWGa83zJiZInAzo7eN3OvvVS4G/s
         Ui44YZ1wWgDTlBEAvKMY5kUGVPPIHHTxX4mN/DJQofpmWmCypb0IBTNWSdXJn9Zrb/Ap
         y+4nYcwXlkSD1Tep2nIkaV6LCRRLNxF6gI9Yry56UfLTkv9cfEDtXe4zFyjYWTcA/U6C
         MsGUIQWQmMCmMT1HFGTnGVufU8wZ3Pw1Qg2xB9al9TZ+G3VIrwbfMGU4pGmntupsXslQ
         KjQg==
X-Gm-Message-State: AOAM533QNlM3/R0gaid0xJAvUbBW1l++w+T7IC1k5IGEhQVKswYWnGpr
        TzEnv6zFFqzjIXKullz3lg==
X-Google-Smtp-Source: ABdhPJxjCjd44cknqX1CrRz3ImU1u4LvNQz115jwwKQoOTlss5OHW3iJ68+/FeioWfmP9Kusyp4lLA==
X-Received: by 2002:aca:31c7:: with SMTP id x190mr9703609oix.143.1634735587326;
        Wed, 20 Oct 2021 06:13:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p14sm400670oov.0.2021.10.20.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:13:06 -0700 (PDT)
Received: (nullmailer pid 2208400 invoked by uid 1000);
        Wed, 20 Oct 2021 13:13:05 -0000
Date:   Wed, 20 Oct 2021 08:13:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/24] PCI: Unify PCI error response checking
Message-ID: <YXAV4bGehjAKK8XO@robh.at.kernel.org>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <da939a6cdb2dea96d16392ae152e1232212877d1.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da939a6cdb2dea96d16392ae152e1232212877d1.1634306198.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 08:08:44PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use SET_PCI_ERROR_RESPONSE() to set the error response and
> RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> read.
> 
> These definitions make error checks consistent and easier to find.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/access.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b3b2006ed1d2..03712866c818 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -417,10 +417,10 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>  		/*
>  		 * Reset *val to 0 if pci_read_config_word() fails, it may
> -		 * have been written as 0xFFFF if hardware error happens
> -		 * during pci_read_config_word().
> +		 * have been written as 0xFFFF (PCI_ERROR_RESPONSE) if hardware error
> +		 * happens during pci_read_config_word().
>  		 */
> -		if (ret)
> +		if (RESPONSE_IS_PCI_ERROR(val))

What if there is no error (in ret) and the register value was actually 
~0? We'd be corrupting the value.

In general, I think we should rely more on the error codes and less on 
the ~0 value.

>  			*val = 0;
>  		return ret;
>  	}
> @@ -452,10 +452,10 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
>  		/*
>  		 * Reset *val to 0 if pci_read_config_dword() fails, it may
> -		 * have been written as 0xFFFFFFFF if hardware error happens
> -		 * during pci_read_config_dword().
> +		 * have been written as 0xFFFFFFFF (PCI_ERROR_RESPONSE) if hardware
> +		 * error happens during pci_read_config_dword().
>  		 */
> -		if (ret)
> +		if (RESPONSE_IS_PCI_ERROR(val))
>  			*val = 0;
>  		return ret;
>  	}
> @@ -529,7 +529,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> -		*val = ~0;
> +		SET_PCI_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
> @@ -539,7 +539,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
>  int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> -		*val = ~0;
> +		SET_PCI_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
> @@ -550,7 +550,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
>  					u32 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> -		*val = ~0;
> +		SET_PCI_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
> -- 
> 2.25.1
> 
> 
