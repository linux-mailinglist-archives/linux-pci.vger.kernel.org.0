Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B94396471
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfHTPbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 11:31:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38423 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTPbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 11:31:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so3452546pga.5
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2019 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GNTaQEUKw3DkFYPRjOd2+jlWbivaUPKZR0GlTO1D9vQ=;
        b=cKOrZzGL6sT+oH42dorpn9LVy2TIxYp2XRnPXpZ1nq6yQgQ/eECm6ylClzkzFh+dko
         Oi07UPSUyeCL54DZMr3FwWFk1it6Rix2zVZRzkf9R1lmVQdhE2LhX4W3U4YXG+k8ges7
         9RxcIrFYyvLaBGCOr7raJi/3CQ7ljkA5gzzls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GNTaQEUKw3DkFYPRjOd2+jlWbivaUPKZR0GlTO1D9vQ=;
        b=l2OWPJXJJVvSClrI45U64WdJCTEynDavgZSjx9oWHaq4tiZNELVt6unipx0/kYYOD4
         9eYwV/tsOfr/BJmmzHDidic/SngquevtiMNeiqMGA3uCPLUv7atGu7KZlGGlCszUT+sS
         EJvBYzO2scmloRFKJoBLAWA0NKZnicb9dc10/xPLwpdY7ksloVqJAhz7tv1Dy5CVxel0
         MuwdNq906IR9yFM7F5i80Tp8YYQ7uXyG4aXKmGizwt36YWjVqRgn3LBWGwO+0Tf8lZVG
         0Vg4FR+m3sr16vi5NsobDx6AJbY1CwQCeEzL51TtjlK7jHrevPzwcrfSg/+OFdq5cE6y
         RVPg==
X-Gm-Message-State: APjAAAVEqLRqE6fMov/1MbkHfU84sowQ479HfI8CzgE3dIsvKndHPo6u
        9Jr5xyzFlPiud8gpDx9Alk2nZQ==
X-Google-Smtp-Source: APXvYqwElzu1rPBlzknftcusYxSBT5g1kl1HIbsRc6PJpu2oNRxWkKsSgsPuuWbHWUx1qqGettKcLQ==
X-Received: by 2002:a17:90a:d3cf:: with SMTP id d15mr611463pjw.34.1566315111331;
        Tue, 20 Aug 2019 08:31:51 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z14sm249632pjr.23.2019.08.20.08.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:31:50 -0700 (PDT)
Subject: Re: [PATCH] PCI: Add PCIE ACS quirk for IPROC PAXB
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abhinav Ratna <abhinav.ratna@broadcom.com>
References: <1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d39bbda2-49ee-a6eb-38f8-347106bbf3ed@broadcom.com>
Date:   Tue, 20 Aug 2019 08:31:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566275985-25670-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good.

On 2019-08-19 9:39 p.m., Srinath Mannam wrote:
> From: Abhinav Ratna <abhinav.ratna@broadcom.com>
>
> IPROC PAXB RC doesn't support ACS capabilities and control registers.
> Add quirk to have separate IOMMU groups for all EPs and functions connected
> to root port, by masking RR/CR/SV/UF bits.
>
> Signed-off-by: Abhinav Ratna <abhinav.ratna@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pci/quirks.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc..f9584c0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4466,6 +4466,21 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>   	return acs_flags ? 0 : 1;
>   }
>   
> +static int pcie_quirk_brcm_bridge_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * IPROC PAXB RC doesn't support ACS capabilities and control registers.
> +	 * Add quirk to to have separate IOMMU groups for all EPs and functions
> +	 * connected to root port, by masking RR/CR/SV/UF bits.
> +	 */
> +
> +	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
> +	int ret = acs_flags & ~flags ? 0 : 1;
> +
> +	return ret;
> +}
> +
> +
>   static const struct pci_dev_acs_enabled {
>   	u16 vendor;
>   	u16 device;
> @@ -4559,6 +4574,7 @@ static const struct pci_dev_acs_enabled {
>   	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
>   	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
>   	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
> +	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pcie_quirk_brcm_bridge_acs },
>   	{ 0 }
>   };
>   
