Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2162076E5F1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjHCK56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjHCK5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 06:57:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E230F3
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 03:57:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68706b39c4cso525523b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691060261; x=1691665061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yxi8OSUOsgSNqW0DID4+WdGXqClGX+/fDODchGAnwd4=;
        b=zTSrDZPhXxN+lm/Sh1hUVCzIbg1hHVcd+I/F39LmuyOqDplPv5dVkfMl7MeZxgwAt7
         gffDm582xHBD4JwPusXS2/VlI1Al7OM0rwm6U12KOY7rRUeNEZbnJ8yNSmIvCRcdW16N
         Kp8QY6aVqZvd5PK+MFCUcaFNvcgPkdtbwSyHFE6GuO2YbWTzDQCjhOORiP2njwBxLA7q
         mS1QaazQp2fZN3052w+Q1Wy/YVzqRBS2deh2XrxECloAR4UIZZLgL2xoU29wj/eE0opL
         sr3L9Cfb3ux9bITVnV2NZZ2NcHsd0ZrkkqmGVYl3o2NvmCuTsN0rF91NPqiNeTQi7A43
         n1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691060261; x=1691665061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxi8OSUOsgSNqW0DID4+WdGXqClGX+/fDODchGAnwd4=;
        b=YYgdh1edMU56NKTIE8Z1h+N2HXMsULAqB5XjLF5sI9RM7hea+JNNeI3NyQryvkEyA7
         wm0cqrQLB7idsSf+mCLthyodBL6iN6ixleI1d9Zbv8+68lcx22rGpTS2ImoximqryC09
         CfNiId/zEUvzrlGKADd8GpuPGxVLGBwVMML08JXlSyNIicgYs0a1/0kL4r57fVdn0EYL
         vr856t8UM59w2qbMwnMz5mdgW3D03TcnAz/8pSUTLy7FCDpJQ7p2N2oQDyW8zxzeSgzN
         XTamo7W0aPP/jsp1uV7pz+qVboPGx9sTJnmtWri37p/WYPALNne90pchRLJQ8tm4bxHU
         wzdw==
X-Gm-Message-State: ABy/qLaDNlX81/TOZ3G56WjAb4QTB3pFfHQQPWGYV27mXaXX0tIi60Sn
        2lxKEO+2w3Hl8kbije1XrFyR
X-Google-Smtp-Source: APBJJlGFYkAo1Xry9RNVbNHHTT0h0nSDmp1PI757Nj6byqcE6gAvoFhRTSycJUMKZDvW1JXPdzz4Ig==
X-Received: by 2002:a05:6a20:8f0b:b0:12e:cbce:444a with SMTP id b11-20020a056a208f0b00b0012ecbce444amr21705887pzk.37.1691060261273;
        Thu, 03 Aug 2023 03:57:41 -0700 (PDT)
Received: from thinkpad ([103.28.246.45])
        by smtp.gmail.com with ESMTPSA id e18-20020a62aa12000000b006875493da1fsm4524019pff.10.2023.08.03.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:57:40 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:27:36 +0530
From:   Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Message-ID: <20230803105736.GA7313@thinkpad>
References: <20230802094036.1052472-1-dlemoal@kernel.org>
 <20230802094036.1052472-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802094036.1052472-2-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 06:40:35PM +0900, Damien Le Moal wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
> of IRQ being referenced as well as to match the PCI specifications
> terms. Redefine PCI_IRQ_LEGACY as an alias to PCI_IRQ_INTX to avoid the
> need for doing the renaming tree-wide. New drivers and new code should
> now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  include/linux/pci.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ff7500772e6..9e97f0027227 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1048,11 +1048,13 @@ enum {
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
>  };
>  
> -#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
> +#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
>  #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
>  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
>  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
>  
> +#define PCI_IRQ_LEGACY		PCI_IRQ_INTX /* Deprecated! Use PCI_IRQ_INTX */
> +
>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
>  
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
