Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB83418A27A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 19:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCRSgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 14:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCRSgJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 14:36:09 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47D020780;
        Wed, 18 Mar 2020 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584556569;
        bh=CZ3vU96wdH3fiBOrH3e81maNz/01u/l6RR1bNf1AwHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vv41YUmsvsqbsVWt+ZlKXuMSQdIFe3V2lqbd32gGrs+rgPHII0pB5zWTktovqOeYS
         QbehFAswPQdPw1OEX0h+Tg9+6MniZ9q+7wNn8AH5lMHXIzTCuvRJb5Liofsd8EpPPM
         D0Fbn3zIg28YC8wygqWkyDujQ/3nL0FcQz/PVLU4=
Date:   Wed, 18 Mar 2020 13:36:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, will@kernel.org, joro@8bytes.org,
        robin.murphy@arm.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org, robh@kernel.org
Subject: Re: [PATCH v2 1/6] PCI/ATS: Export symbols of PASID functions
Message-ID: <20200318183606.GA207832@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224165846.345993-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 05:58:41PM +0100, Jean-Philippe Brucker wrote:
> The Arm SMMUv3 driver uses pci_{enable,disable}_pasid() and related
> functions.  Export them to allow the driver to be built as a module.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/ats.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 3ef0bb281e7c..390e92f2d8d1 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -366,6 +366,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_enable_pasid);
>  
>  /**
>   * pci_disable_pasid - Disable the PASID capability
> @@ -390,6 +391,7 @@ void pci_disable_pasid(struct pci_dev *pdev)
>  
>  	pdev->pasid_enabled = 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_disable_pasid);
>  
>  /**
>   * pci_restore_pasid_state - Restore PASID capabilities
> @@ -441,6 +443,7 @@ int pci_pasid_features(struct pci_dev *pdev)
>  
>  	return supported;
>  }
> +EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
>  #define PASID_NUMBER_SHIFT	8
>  #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
> @@ -469,4 +472,5 @@ int pci_max_pasids(struct pci_dev *pdev)
>  
>  	return (1 << supported);
>  }
> +EXPORT_SYMBOL_GPL(pci_max_pasids);
>  #endif /* CONFIG_PCI_PASID */
> -- 
> 2.25.0
> 
