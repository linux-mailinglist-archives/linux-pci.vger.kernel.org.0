Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0B73CAF12
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhGOWV7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGOWV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 18:21:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75FC06175F
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 15:19:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f9so9681428wrq.11
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVKgG8J4DPCY0Ga9SbblFwsWSZOuE8eRYNH9mA5VPnQ=;
        b=Li61acL21JAKNwBctCKKQuPikwJJgu0Ni3OSaFV9IfH2v32RyqldOh26iucrpe7tAD
         cuvPQwnCKe72rcnQCaS+zyENOMKrVzLbJw6Q/30TuuF/74iHV7KrK66gaJRN/wVTnhxA
         ow+TAakGoBQKUhvn8RU+jhtwPIArOkWstUZjW0edb8BfX7XDTzVaf6Zrw34Wh5TvhtJw
         pjhF3hGmYsuC+0S2KIy25mpkdyBDNA0WzLO1bJY8ufwvAECP6LzCGNNa9HPY9DvBJBDg
         Kie6AWUhVghQkelNtcPrHx7ohsLmYhPNTROkVAaGV4MehMAl6HmfBHehO5MUqRrQZ35m
         aGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVKgG8J4DPCY0Ga9SbblFwsWSZOuE8eRYNH9mA5VPnQ=;
        b=cTi81lyo1FlGWuptz6ivHSlXuigRjZMyLX4960Im7Cg3oawxYIIbeKgPEN79CFgOur
         MKGv29i8coPTMoqg0k6OH1HKbiof1IC6BCYnO0drXy8kiWCUe6g8ceu/GfjHCfBhuiYu
         mgtxhHiT2jnXCh0tGhZJZmGLnT8jl0JX1kGWleKINLJ+j5b6/+Gpv2UZjY+UnAb1QQMN
         eu8NdvEQlf7n0ILlAOGEu1BX2X9ZeWAzS4ldRZXfNPySnIat1RPGIXkgbRUHtxnhVttn
         xRbfwCFFG2OHPS1TWgzNkNrjwa0x+JDZHZ+D4qWfnyAGPfyYPbtvYDNYgahXreIZeRIk
         n1Zg==
X-Gm-Message-State: AOAM530D/iTDLt378xa0R/Vdc3XLXoWhOUa0tZUuLtf+pn/sUMhQvQda
        aSm0BROaaqmvNpyG2TrDhxo=
X-Google-Smtp-Source: ABdhPJx8o4hw3XlZjHTMt4vtu0no8tdZwhkANAHk42E3kLD+EwZR3pTGFaeqoKX5ONjVoL0pomBS8g==
X-Received: by 2002:a5d:6d89:: with SMTP id l9mr8074484wrs.371.1626387544138;
        Thu, 15 Jul 2021 15:19:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3f:3d00:7ded:9144:bc60:9e25? (p200300ea8f3f3d007ded9144bc609e25.dip0.t-ipconnect.de. [2003:ea:8f3f:3d00:7ded:9144:bc60:9e25])
        by smtp.googlemail.com with ESMTPSA id z25sm6320919wmf.9.2021.07.15.15.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 15:19:03 -0700 (PDT)
Subject: Re: [PATCH 3/5] PCI/VPD: Consolidate missing EEPROM checks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-4-helgaas@kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <77979cb8-776b-3bd3-3552-593ea6ebad92@gmail.com>
Date:   Fri, 16 Jul 2021 00:16:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-4-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15.07.2021 23:59, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> A missing VPD EEPROM typically reads as either all 0xff or all zeroes.
> Both cases lead to invalid VPD resource items.  A 0xff tag would be a Large
> Resource with length 0xffff (65535).  That's invalid because VPD can only
> be 32768 bytes, limited by the size of the address register in the VPD
> Capability.
> 
> A VPD that reads as all zeroes is also invalid because a 0x00 tag is a
> Small Resource with length 0, which would result in an item of length 1.
> This isn't explicitly illegal in PCIe r5.0, sec 6.28, but the format is
> derived from PNP ISA, which *does* say "a small resource data type may be
> 2-8 bytes in size" (Plug and Play ISA v1.0a, sec 6.2.2.
> 
> Check for these invalid tags and return VPD size of zero if we find them.
> If they occur at the beginning of VPD, assume it's the result of a missing
> EEPROM.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/vpd.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 9b54dd95e42c..9c2744d79b53 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -77,11 +77,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  
>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
>  		unsigned char tag;
> -
> -		if (!header[0] && !off) {
> -			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
> -			return 0;
> -		}
> +		size_t size;
>  
>  		if (header[0] & PCI_VPD_LRDT) {
>  			/* Large Resource Data Type Tag */
> @@ -96,8 +92,16 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  						 off + 1);
>  					return 0;
>  				}
> -				off += PCI_VPD_LRDT_TAG_SIZE +
> -					pci_vpd_lrdt_size(header);
> +				size = pci_vpd_lrdt_size(header);
> +
> +				/*
> +				 * Missing EEPROM may read as 0xff.
> +				 * Length of 0xffff (65535) cannot be valid
> +				 * because VPD can't be that large.
> +				 */

I'm not fully convinced. Instead of checking for a "no VPD EPROM" read (00/ff)
directly, we now do it indirectly based on the internal tag structure.
We have pci_vpd_lrdt_size() et al to encapsulate the internal structure.
IMO the code is harder to understand now.

> +				if (size > PCI_VPD_MAX_SIZE)
> +					goto error;
> +				off += PCI_VPD_LRDT_TAG_SIZE + size;
>  			} else {
>  				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
>  					 tag, off);
> @@ -105,14 +109,28 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  			}
>  		} else {
>  			/* Short Resource Data Type Tag */
> -			off += PCI_VPD_SRDT_TAG_SIZE +
> -				pci_vpd_srdt_size(header);
>  			tag = pci_vpd_srdt_tag(header);
> +			size = pci_vpd_srdt_size(header);
> +
> +			/*
> +			 * Missing EEPROM may read as 0x00.  A small item
> +			 * must be at least 2 bytes.
> +			 */
> +			if (size == 0)
> +				goto error;
> +
> +			off += PCI_VPD_SRDT_TAG_SIZE + size;
>  			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>  				return off;
>  		}
>  	}
>  	return 0;
> +
> +error:
> +	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
> +		 header[0], off, off == 0 ?
> +		 "; assume missing optional EEPROM" : "");
> +	return 0;
>  }
>  
>  /*
> 

