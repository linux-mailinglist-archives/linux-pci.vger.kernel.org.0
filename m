Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01C43C748
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 12:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhJ0KFM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 06:05:12 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34734 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbhJ0KCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 06:02:44 -0400
Received: by mail-ed1-f54.google.com with SMTP id g10so8421755edj.1;
        Wed, 27 Oct 2021 03:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EsemFH0tETj3VZTrSmHxIMsN9NPXwXnYtpYm6mXI1Tk=;
        b=OVrPHfz2U5JUp+QiwRAYIE7397KhB7YycXt+DXvYe4JcjhzXsFHE5CrXDeDHIuuD1M
         dEIkXjamD6BAgkr9Greu77ateYlJXmZPLyGqYey4pUhZ6oxyqZS455lzsSgVPDu+r9Lt
         EEDKloMTpBgKGUhCEcuOgsByPOODZ9V4RYYGrgIcHKb/SljzqPRmtEtLQ1Xyg7wX1dBW
         /mKgxkASIqjR8tzD30QERKId11vrnyQz6OhtJnjQT4JOnrWEEf2ctuGUfP+vzi/akV1H
         lNMHLkoGh9IgVbL7vKBmFCikA106YeF/RhCfVd7jrU3RxIHxybBFjq/af9RtMzOfRr4A
         O+bg==
X-Gm-Message-State: AOAM532uomeSp4FOEndF14s9/JG028M4bvTGvS6Jp6x/idPuBAUxwnzv
        s/ssHihUzfaa4uIF6CCknnUmM6zLjdiJgw==
X-Google-Smtp-Source: ABdhPJwWFV7VmfT7RFLcWceqEPwWUqlkhVXAffxqOWvA+FVbvR+fUfPgg8451eo1WEr35K0YegqIOw==
X-Received: by 2002:a17:906:4f8c:: with SMTP id o12mr37456066eju.115.1635328817804;
        Wed, 27 Oct 2021 03:00:17 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r5sm8427743edy.86.2021.10.27.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:00:17 -0700 (PDT)
Date:   Wed, 27 Oct 2021 12:00:16 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: brcmstb: Use GENMASK() as __GENMASK() is for
 internal use only
Message-ID: <YXkjMO0ULRGqZPbr@rocinante>
References: <20211027093433.4832-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027093433.4832-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

> Use GENMASK() as __GENMASK() is for internal use only.

To add, for posterity, that using __GENMASK() bypasses the 
GENMASK_INPUT_CHECK() macro that adds extra validation.

> Fixes: 3baec684a531 ("PCI: brcmstb: Accommodate MSI for older chips")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..51522510c08c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -619,7 +619,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
>  
>  static void brcm_msi_set_regs(struct brcm_msi *msi)
>  {
> -	u32 val = __GENMASK(31, msi->legacy_shift);
> +	u32 val = GENMASK(31, msi->legacy_shift);

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
