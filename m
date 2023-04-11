Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF536DD8D3
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjDKLFn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDKLFm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 07:05:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332303588
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:05:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id px4so5429023pjb.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=io8UpU5dAmYXG11sIwaNdSii471vCcYFpdDyFDwKPgY=;
        b=BAvnR27qwms7MKR6LP3NoeyT/Ghkxw6tRsZ6utkXZICaajKUMt75IRXj8JmnJl9Oya
         sdNJmthl4XSlSOfr+xLK69CfbgVbIJGqYhIcbRfp6KRY3u9WKrcl0Nwmc0X5SomTa41P
         Gnboi5DFZTigHhJn4VAbWqtUBO6shp+/stsftRZDkwQ0hQJJeX7jNEzBjmtUkVRfslmz
         8+DRMHnqN/854QjVjqLe17bARvpT/Jf2ddjNz6gDzbihfavgMu0Pltiao0dMW+7bEjbK
         FUiSeZTJU0XyttdNcMuR20Nvdn7CDXDkwZyiJ5j5HTItFhvtBQ4Lw/cCWYM63Szpc2Ml
         S0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=io8UpU5dAmYXG11sIwaNdSii471vCcYFpdDyFDwKPgY=;
        b=tEAeYkYyhcNr/zGQtfV9GB4cjM6fArIU1eJPRcFy/znzdamIjk6nJcJN7ExD/6HEyk
         Ta+I9DkSVJcyWq2JhEHZcRUE2VnKSkOcac3L4f8zdbrptEABNjkmKQ57Z3Zd8OpbD1Wh
         kvxp4TusK18j/I1lQTkG9PXNs6W01OcICSb/HlGdBanM2UQCUVSncIjJ1Ur5rMweLOcZ
         QeswtbD2YJI3oYHoWBGEpSmzbL4r0lHJXiHVXAEbLOYvWPcyEXvw0710QFpgXkmM/yo/
         nHanQn+1tP4aGxQTSv4anJm3YGOdFwblL5Vx1+yHyrvRW4U0NM0/C41KbtL04SEohbLZ
         B1pQ==
X-Gm-Message-State: AAQBX9fvnq1i0FOw5XLwkOlDEpv+w923V0At6zEi7wjIpE/mxwzvXSzO
        Mul581lwTX5mztdyqIDdbZ0X
X-Google-Smtp-Source: AKy350auwVp798Y4nCCGwszWeeAy8RYT89ODx6HrKEQrzx+s92jgK5a09SHdRU0RH5JS692sJIV6fg==
X-Received: by 2002:a05:6a20:77af:b0:de:af2f:fdeb with SMTP id c47-20020a056a2077af00b000deaf2ffdebmr9218828pzg.3.1681211115858;
        Tue, 11 Apr 2023 04:05:15 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id j10-20020a62e90a000000b005a7f8a326a3sm9535165pfh.50.2023.04.11.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:05:15 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:35:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 02/10] PCI: dwc: Fix inbound iATU entries
 out-of-bounds warning message
Message-ID: <20230411110507.GD5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-3-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:20AM +0300, Serge Semin wrote:
> The message is printed if the number of requested inbound iATU windows
> exceed the device capability. In that case the message should either refer
> to the "dma-ranges" DT property or to the DMA-ranges mapping. We suggest
> to use the later version as a counterpart to the just CPU-ranges mapping.
> In any case the current "Dma-ranges" phrase seems incorrect.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..5718b4bb67f0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -723,7 +723,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	}
>  
>  	if (pci->num_ib_windows <= i)
> -		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> +		dev_warn(pci->dev, "DMA-ranges exceed inbound iATU size (%u)\n",
>  			 pci->num_ib_windows);
>  
>  	return 0;
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
