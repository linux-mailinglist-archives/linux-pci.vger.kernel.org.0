Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903BE3CAEF0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhGOWKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhGOWKw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 18:10:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C72C06175F
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 15:07:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w13so4596675wmc.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9dH9z9dIdcIEWOK5jxQlH/yBDDcHCUCiAtHOEk9FwlA=;
        b=iKGu84V8bvN+Bj3Fr3iWh3rjagb16SLuMA6SB/1HOXR7+1Nf61d7mA5OzmiKdLe8nP
         85HYy+0aKoiO3NlXYHaxb05pJqSTmLDQvdIBD+UZjcE12AvQTFob/66j4mczHKQXlIIT
         SCAnY9LdSyeV6yvLlLBgBBs3lBF966H0n657oBLiKdLz21KKmTFsEyst+IpZ0tj6Ck8h
         nppOJJLcNyV4dd5nkxSb5QAVmKhUbdBWbmengU6xXea0nuuL+bo7VcTcnStpEzDx7sk3
         KzN6KaX4ijeioEEcXJUWB3ci0CJfWnkr9d/RgaNNBAkIxx3Gf2BaMWycs8SavMrY0RsA
         +5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9dH9z9dIdcIEWOK5jxQlH/yBDDcHCUCiAtHOEk9FwlA=;
        b=tUAf9V652CxPptsyW5d4oLbor14RwzAXYL06bzUALRR/SIZ5lwoQ5JjafIu4uU3850
         SKN3XI19tFy+7f6JfZQyjbOzEt7YQV6oogfsZg6+HmTqT/R139b43F/0L7rePHAr9vMy
         qztyYxRfFGvq9Fcdv54soMv41tXbvaZjhY5Y5aZjS5e8wT4RGhhSyO+wPyNdQwwkUErD
         s7LEMJDIxyG4UD7rMxo0b044ceew+fTwUhVQxtVTGWfUWzDsjH+u/yY5lyw/XuRwxa/5
         2LniPQhiVUlyrBiI9uq20435hnOEDijVG5tR8hEvIMJHpSQHESrZmLJj65LSxFkZDmGt
         No/A==
X-Gm-Message-State: AOAM530usrl0NtCjh3zfDs4oxGiYTrRsYI7KM9JQB8Sk/MEFuQpOpMPi
        F4KeeBOUGzLDrkcg1N7xF3s=
X-Google-Smtp-Source: ABdhPJzEEVBhmMToLpw0+cy21HKu4dCT1/4JCnZWLj6073TBDtOUbre5wSXf7qjzurJu8MMGi3RosQ==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr13187405wme.16.1626386876553;
        Thu, 15 Jul 2021 15:07:56 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3f:3d00:7ded:9144:bc60:9e25? (p200300ea8f3f3d007ded9144bc609e25.dip0.t-ipconnect.de. [2003:ea:8f3f:3d00:7ded:9144:bc60:9e25])
        by smtp.googlemail.com with ESMTPSA id n23sm6227923wmc.38.2021.07.15.15.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 15:07:55 -0700 (PDT)
Subject: Re: [PATCH 1/5] PCI/VPD: Correct diagnostic for VPD read failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
 <20210715215959.2014576-2-helgaas@kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7e171631-f1b4-8a25-bb12-6ed8bc8fc17c@gmail.com>
Date:   Fri, 16 Jul 2021 00:07:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715215959.2014576-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15.07.2021 23:59, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously, when a VPD read failed, we warned about an "invalid large
> VPD tag".  Warn about the VPD read failure instead.
> 
LGTM. Seems no VPD has been broken enough yet to trigger this warning
(at that place), so there's not much need to argue.

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/vpd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 26bf7c877de5..7bfb8fc4251b 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -92,8 +92,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>  			    (tag == PCI_VPD_LTIN_RW_DATA)) {
>  				if (pci_read_vpd(dev, off+1, 2,
>  						 &header[1]) != 2) {
> -					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
> -						 tag, off + 1);
> +					pci_warn(dev, "failed VPD read at offset %zu",
> +						 off + 1);
>  					return 0;
>  				}
>  				off += PCI_VPD_LRDT_TAG_SIZE +
> 

