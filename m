Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5335D4503E2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 12:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhKOMA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:00:29 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38891 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKOMAY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 07:00:24 -0500
Received: by mail-ed1-f42.google.com with SMTP id m20so24857336edc.5;
        Mon, 15 Nov 2021 03:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iZwd8zOKfHOZHtZg1NiyaugaGLTtwcsli/vHUABjgyw=;
        b=dl20a6pf9ubQUeyNWfyNb6BQCZdr75fb2PvgJJ9jg2yGvZauub9Zi9hkjA42w5YBqB
         ukMhJ0tIRNIFyMpr2j+qGEE+qxufKdCsctb+tCGB7IPNUa1WYOkFU9OcU7Yt9gd4jklt
         1stS8BcCeaKjky4Vz/1DAT03T60/MOAJWBk64S9Wtb8bmsxghm+/AG8Jw6g6y6P4sN0O
         X6UU2aFHiq3mBB8sSeJIVb94Fv5xOkZvFhBID19tlFJw9nXAvao5Kk5JowAIIy2enmpy
         bhLAc/V1tIvCx1VSlvfn9phhcG/N//AI2tL+xtvPV2flEOLXCrOWxeuAxqnzRzDkxGNJ
         GN7A==
X-Gm-Message-State: AOAM531S+TJCPWs6VxSnk/wdaLmAUdwoarqPAjLZncgi5YN5jOIbZKev
        k9fzejdpaCkuKLeVonrewm8=
X-Google-Smtp-Source: ABdhPJwW6w4WpnROjobFjseOxEMIFpGxpb+OUZBqnh8kfqVJtqdI09J1Lvv5euWDTqz0D+G9VGmPuQ==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr47736793ejb.292.1636977448502;
        Mon, 15 Nov 2021 03:57:28 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id ne33sm6491674ejc.6.2021.11.15.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 03:57:27 -0800 (PST)
Date:   Mon, 15 Nov 2021 12:57:26 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
Message-ID: <YZJLJgYsKQY+5TyI@rocinante>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

> Use BIT() as __GENMASK() is for internal use only. The rationale
> of switching to BIT() is to provide better generated code. The
> GENMASK() against non-constant numbers may produce an ugly assembler
> code. On contrary the BIT() is simply converted to corresponding shift
> operation.
> 
> Note, it's the only user of __GENMASK() in the kernel outside of its own realm.
> 
> Fixes: 3baec684a531 ("PCI: brcmstb: Accommodate MSI for older chips")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: switched to BIT() and elaborated why, hence not included tag
>  drivers/pci/controller/pcie-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..0c49fc65792c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -619,7 +619,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
>  
>  static void brcm_msi_set_regs(struct brcm_msi *msi)
>  {
> -	u32 val = __GENMASK(31, msi->legacy_shift);
> +	u32 val = ~(BIT(msi->legacy_shift) - 1);

Thank you!  I also personally prefer using BIT() macro here.

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
