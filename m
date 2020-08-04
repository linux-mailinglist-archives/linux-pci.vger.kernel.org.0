Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073AD23C168
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgHDV0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHDV0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2020 17:26:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63DC06174A;
        Tue,  4 Aug 2020 14:26:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so13514964pfl.11;
        Tue, 04 Aug 2020 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H53lbBysrvDenqcyvIC5UIxfvFKGaXbtjEmFJwaxIpE=;
        b=T7fS5brMmb4wsPGHicKEipC/YARUq/fZUJQbVJ+Xk4BTkzZ9GzfejLGEQPEBcZ7tAq
         f4tgYSeSMSqesC9fJTzH37W+mPN5bA15tpvb7fttWSh/rIQXEdSWbSK0ZHQ39DFHtaEO
         IdAvLeQZu3/LLvABjTqO53RvtXGps7eAuOMvzLaA9lEMfUqme0I6MfqEBbDREDWHRcYT
         G5if5wjnu51vBKn+XfiPXaNCo0J6Wx1Kzh63dCvaf6CThNqef/BCWLpH5UTNMPP3d2rY
         nmqofLZ7F4cty7/B8i/xsWuZrAUts3iHqTtgQqwkPM0E3hh0ZbWL+4COSDa6WsibYTmj
         lIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H53lbBysrvDenqcyvIC5UIxfvFKGaXbtjEmFJwaxIpE=;
        b=aT/mdz97hKM5MLgRybq3GxtXrzr8DpPfYkbxoRen8+qPf6E+3N+PFR7saJS48Ck8ru
         mWgflwT/LWUA9w0S+rjLc5ODyBtlzNBe94YiayJXGOje5pVeoPNYXny/8N/1k6RZSxmB
         JAJkTHXNeKgcblsBtIWoHUbPRSf/EvybTj3TLAblS/jfC+Mpr9DD+VgV5jSv8jxPJjLj
         g9gaATsXuWrEQuqeIn1AAK8cgM1snRiVabMfOfukdCmpHAap41TjYxISLRHTj7hpfgM2
         a7cLPIIy05Mz/SSRRJcrZNrS7DGHB3A23wu1KhPChMNMHrtQAzoFwktFd2nYVEjYlOMq
         RDqw==
X-Gm-Message-State: AOAM533p4KpAOGxLj+Thjx+ucfx8P9z3Z89wqFltzRVFR8p5dtE7I8+C
        1vaZcgINkUL/gwZz52al+Us=
X-Google-Smtp-Source: ABdhPJxillOY5cbn2FINKGZ40mF2Q8aHqizsQ7EqXczJv8PwJnzXaEl1BvDabEeUkMzRY7cIaHCkGA==
X-Received: by 2002:a63:1a04:: with SMTP id a4mr297213pga.95.1596576367419;
        Tue, 04 Aug 2020 14:26:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 63sm8759439pfu.196.2020.08.04.14.26.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 14:26:06 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:26:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, Jean Delvare <jdelvare@suse.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 10/17] hwmon: Drop uses of pci_read_config_*() return
 value
Message-ID: <20200804212605.GA218592@roeck-us.net>
References: <20200801112446.149549-1-refactormyself@gmail.com>
 <20200801112446.149549-11-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801112446.149549-11-refactormyself@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 01, 2020 at 01:24:39PM +0200, Saheed O. Bolarinwa wrote:
> The return value of pci_read_config_*() may not indicate a device error.
> However, the value read by these functions is more likely to indicate
> this kind of error. This presents two overlapping ways of reporting
> errors and complicates error checking.
> 
> It is possible to move to one single way of checking for error if the
> dependency on the return value of these functions is removed, then it
> can later be made to return void.
> 
> Remove all uses of the return value of pci_read_config_*().
> Check the actual value read for ~0. In this case, ~0 is an invalid
> value thus it indicates some kind of error.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/i5k_amb.c | 12 ++++++++----
>  drivers/hwmon/vt8231.c  |  8 ++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index eeac4b04df27..b7497510323c 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -427,11 +427,13 @@ static int i5k_find_amb_registers(struct i5k_amb_data *data,
>  	if (!pcidev)
>  		return -ENODEV;
>  
> -	if (pci_read_config_dword(pcidev, I5K_REG_AMB_BASE_ADDR, &val32))
> +	pci_read_config_dword(pcidev, I5K_REG_AMB_BASE_ADDR, &val32);
> +	if (val32 == (u32)~0)
>  		goto out;
>  	data->amb_base = val32;
>  
> -	if (pci_read_config_dword(pcidev, I5K_REG_AMB_LEN_ADDR, &val32))
> +	pci_read_config_dword(pcidev, I5K_REG_AMB_LEN_ADDR, &val32);
> +	if (val32 == (u32)~0)
>  		goto out;
>  	data->amb_len = val32;
>  
> @@ -458,11 +460,13 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
>  	if (!pcidev)
>  		return -ENODEV;
>  
> -	if (pci_read_config_word(pcidev, I5K_REG_CHAN0_PRESENCE_ADDR, &val16))
> +	pci_read_config_word(pcidev, I5K_REG_CHAN0_PRESENCE_ADDR, &val16);
> +	if (val16 == (u16)~0)
>  		goto out;
>  	amb_present[0] = val16;
>  
> -	if (pci_read_config_word(pcidev, I5K_REG_CHAN1_PRESENCE_ADDR, &val16))
> +	pci_read_config_word(pcidev, I5K_REG_CHAN1_PRESENCE_ADDR, &val16);
> +	if (val16 == (u16)~0)
>  		goto out;
>  	amb_present[1] = val16;
>  
> diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
> index 2335d440f72d..6603727e15a0 100644
> --- a/drivers/hwmon/vt8231.c
> +++ b/drivers/hwmon/vt8231.c
> @@ -992,8 +992,8 @@ static int vt8231_pci_probe(struct pci_dev *dev,
>  			return -ENODEV;
>  	}
>  
> -	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_BASE_REG,
> -							&val))
> +	pci_read_config_word(dev, VT8231_BASE_REG, &val);
> +	if (val == (u16)~0)
>  		return -ENODEV;
>  
>  	address = val & ~(VT8231_EXTENT - 1);
> @@ -1002,8 +1002,8 @@ static int vt8231_pci_probe(struct pci_dev *dev,
>  		return -ENODEV;
>  	}
>  
> -	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_ENABLE_REG,
> -							&val))
> +	pci_read_config_word(dev, VT8231_ENABLE_REG, &val);
> +	if (val == (u16)~0)
>  		return -ENODEV;
>  
>  	if (!(val & 0x0001)) {
