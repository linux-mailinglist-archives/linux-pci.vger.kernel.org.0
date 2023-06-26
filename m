Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6073E453
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjFZQLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjFZQLa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 12:11:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED671984
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 09:11:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e3b15370so2022701b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Jun 2023 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687795884; x=1690387884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ha/GDAq9CWNgtfrd2MFxFNzbDb2wvJAzh/x5CTnutr4=;
        b=jwJ/gtH2M03dWK+/ERwwihg75IqSdf/oOi6W1lM7wjCV2r2U+l3mnQDZdPo0QZk5le
         uY1afJshsNrxW6fGdxOKt/VKMkbIABm7RhmqcXAsD2YjVU4kr6dnT9BSHz+YKbZz6Ow/
         zYA2DiNyxausKh9M4GlGVZkEqIlh8kPl26vxJoLpKjLBNw7fKprZfxs12qdOZbMBbSv5
         VWoVl5WACJMCwmGgmlQ98qQ400b+R/6pvWaZPw9/3/KDVCfnZjZw8z+3VSzk3mzvXdSc
         VlY2Mvx30np9ePt9GsDXf4JgeD5sZPmt2Y4FfAgvlJTOBhqPNHE5ODhnBfEQlVvy5ZEE
         uYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795884; x=1690387884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha/GDAq9CWNgtfrd2MFxFNzbDb2wvJAzh/x5CTnutr4=;
        b=apbKUaIaW2dulXp8wid061ChCjcN7IzWbnz3cRX4SUhpWVmduyn3tL4ZawhYB6m1F8
         ZP1yAinoAPid/FpcQtoKgXqeQ0VPLfjd9jVoP+z3z6qsAy85AJeCXmFp56g3g9dnvui0
         mzUhmiXI/Ev4AgZ4Og1J9eY+moNPRMnauJ2baUvA/ZhkcqD0EJUZ7/BBxEZZ63VrrO76
         yFeBSBm/rujoQcYMNU9X7s/UZ9S1UiQKXuOID1/oymbB32TEk0DQ0NtNujtUXJXdb3cl
         cp4cua59hGGn33LaCP9b7xFC3HBofjYzWdrMGCpt0gzlX5xg+icKVtKzsKvBQreLEgZ0
         J2jQ==
X-Gm-Message-State: AC+VfDyzUjqQOJpcVZOlMCzNnvNPkDs+vnUbETyMchKgxhNRt+tmlzm6
        N8CaW8/aPj3LAXSiX7O+8CDe
X-Google-Smtp-Source: ACHHUZ7FeXzw2OpalhN3a3km3eAd2AM5tP72OVInMEuvTRdpkRMWZ/QPc8iHmqQRUjwWAqpo3srByQ==
X-Received: by 2002:a05:6a20:8428:b0:11f:6dc:4f38 with SMTP id c40-20020a056a20842800b0011f06dc4f38mr27417575pzd.55.1687795884392;
        Mon, 26 Jun 2023 09:11:24 -0700 (PDT)
Received: from thinkpad ([117.217.176.238])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78c04000000b006765cb32558sm2260133pfd.139.2023.06.26.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:11:23 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:41:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as DesignWare
 PCIe driver maintainer
Message-ID: <20230626161118.GB18472@thinkpad>
References: <20230626151907.495702-1-kwilczynski@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626151907.495702-1-kwilczynski@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 26, 2023 at 03:19:07PM +0000, Krzysztof Wilczyński wrote:
> Manivannan has been actively reviewing patches and testing changes
> related to the DesignWare core driver and other DWC-based PCIe drivers
> for a while now.
> 
> Thus, let's add Manivannan as a maintainer for the Synopsys DesignWare
> driver to make his role and contributions official.
> 
> Thank you Manivannan! For all the help with DWC!
> 
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..61a64744e31b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16167,6 +16167,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்
