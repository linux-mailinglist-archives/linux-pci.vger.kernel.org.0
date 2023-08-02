Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A6276C8D6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHBI5q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjHBI5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 04:57:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFDF10B
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 01:57:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe10f0f4d1so10941327e87.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Aug 2023 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690966662; x=1691571462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1RkudbqyyEMRrk7wA9tad+48CQViRMxgAPmmiACPPc=;
        b=oCl8tlmOoX2MXxYDDRSSbSDcZoKPGTf9C70uA5WymwxdJzIAbskGVOwqguMPwDoJua
         Q1DtOX6gueAd5IT/yxcuI/t+q+hle6EPKNu5FE5jt+slIE8BFcw7/fNX0IGY1mFSaiTY
         dno6powcd1pY0Ri4sxBtPzj5u6RMGPDaFhs7xm51rv04mHb9Uqx00MMbjWjwoyLn43RU
         hGLmPkTcS3Kka5chKeUhr7h+ULA1rc+MKEcMnnLz/2UlRCdjmAlkI7R/uccYrMsqC67x
         6nn5pf8rj8EAz5JdulJl6rVpBvNkEUU818mid9S4WK5roqydarFKmABxdkpSMecJMTTg
         6tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690966662; x=1691571462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1RkudbqyyEMRrk7wA9tad+48CQViRMxgAPmmiACPPc=;
        b=MxwE/ZwJCwCqYxyuO8sXnIn+t60I0bJig8n5ICGSQ2Uqx/JIIwuDGJVSvMbWwvMWcK
         bsKFxLZU65EbcASLobJVQkPCjZPmo2wY8G26Jb89yNKODwigqjsLOMchevIOb3/OfuVB
         E7WqwKMkQIzS3TKXynzg4SbmIxwhRB00WARZVvkaNZmWU6kjWLTYDSfBQUphBhumAssi
         dNI9ytCl6/xq2UOw9Vkc2TCFUEhqI+fsPNNLyazP8ZHsbb19J0s41KzOqYoyTKhumV2R
         4NI/va8nejWw9fjg8Rj0HvFYr8SDvVoNCCVPHGMHT9lGlWeexAc9M6+KPZrCj4sufg4l
         i/6w==
X-Gm-Message-State: ABy/qLbtHkKsLbc4i6XqtLRLvs8FoBzdIobsKmQLCZkpzE4U1CRd4Bqy
        NKIo2SYNsmbjWe+1V5cVkY8=
X-Google-Smtp-Source: APBJJlG6OLLIWvVuSGDk/uzMy8GXc3MMK61Nj8OEiC05o6sCR/G/BojXqQaISgZWT3WxbqBN2Cu4kw==
X-Received: by 2002:a05:6512:3baa:b0:4f8:5e65:b61b with SMTP id g42-20020a0565123baa00b004f85e65b61bmr4956225lfv.65.1690966662031;
        Wed, 02 Aug 2023 01:57:42 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004fb57f28773sm879231lfe.285.2023.08.02.01.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 01:57:41 -0700 (PDT)
Date:   Wed, 2 Aug 2023 11:57:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v2 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Message-ID: <fsfsdc2m6vf4tukmlzgedygowaji2nuntsy2ahnw3sghokydhu@hr3b2s6fnxtm>
References: <20230802075944.937619-1-dlemoal@kernel.org>
 <20230802075944.937619-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802075944.937619-2-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 04:59:43PM +0900, Damien Le Moal wrote:
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
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  include/linux/pci.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ff7500772e6..7692d73719e0 100644
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

> +#define PCI_IRQ_LEGACY		PCI_IRQ_INTX	/* prefer PCI_IRQ_INTX */
> +

I would have been more strict about using this macro and explicitly
stated that the macro is deprecated:

+#define PCI_IRQ_LEGACY		PCI_IRQ_INTX /* Deprecated! Use PCI_IRQ_INTX */
+

In anyway:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
>  
> -- 
> 2.41.0
> 
