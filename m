Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195259FDA8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiHXO6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiHXO6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 10:58:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AD8E4EC
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:57:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p18so15883248plr.8
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=41sAcz9c3vs/nXk4pYq7pvmGQL8rf/lJNZMSCRKunZY=;
        b=BplH8rV9dJab5d0+huQtWC9Ga3VR4bg3HipSXAjQvMaPC6oYxdJTJiXgqlWuH1DceA
         uOZSt/F5WeWN5n+FyPXGEyDsyw/W/ZAA0Wgd+ntyacyrJKzcCOi+niQEJRx2Mh4/CAQM
         +ED8IqxRJHLZEIL6WZ/NHxeOBtogGNnCzyJ463hxwPDI2lFaEkyiZYbdXm/oFarHxA4o
         vzlHoWqqPtXcKldCP1U6FEOaDrqbDNgahQyWW0c3wHYzub3jLQ706KKpG3G71SOVat4V
         aI1KDvuSAwE+TcQaCZrWgTrNBsvR/gezSSHBieWOeAqaJgAD3Lt0egbewPt0HKhG6mlN
         knBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=41sAcz9c3vs/nXk4pYq7pvmGQL8rf/lJNZMSCRKunZY=;
        b=U98LnQSHZH2V4ROg1bfaMhplOujUTALssr4xhbUOov8cuBq9jKauVelxuXEYGhqNGw
         DAzmN+JWzemqhwQYmyxWy57PksaixtxJBDiClYR0VnJvhm0o14UVtw+HqKQlUcuLhUBa
         lZ5CVlHgpTOBuF+jc1slPf9wp/VAkZAQYWxhkKHfo5qPn8RzfOY1/Fe1+UcZz35A1pws
         AHAMrpACd97sGZ6b8+d0XfYVF30qM7uqYkKrWSqyuyB21jjhPAPDvG58L7Xr8udIYCIL
         8Zl82F52zNccPw+RoJSbySEKv/0Bn2dahvPUgen8peGMU+fI7G9yKE1/vHAWlzwQmUNv
         VtYQ==
X-Gm-Message-State: ACgBeo1Pab/xIqMrgZm6JoMUOJ2ZMV/xBsPwBmFpXqe+AmmGBC4q78B0
        o5KzKLfOKvF7wJl1GFnbwGUt
X-Google-Smtp-Source: AA6agR77UPEmdtKtAgeec0tOsknV1XD+1Mb+D7hmZ1LJDqjwAh3z8uumtlhAObxtWctNxqbgo6L6sw==
X-Received: by 2002:a17:90a:cb13:b0:1fb:1aab:4f72 with SMTP id z19-20020a17090acb1300b001fb1aab4f72mr8526798pjt.58.1661353078135;
        Wed, 24 Aug 2022 07:57:58 -0700 (PDT)
Received: from thinkpad ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b00172fad607b3sm4842211plf.207.2022.08.24.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:57:57 -0700 (PDT)
Date:   Wed, 24 Aug 2022 20:27:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 3/4] PCI: qcom: Setup PHY to work in RC mode
Message-ID: <20220824145748.GF4767@thinkpad>
References: <20220726203401.595934-1-dmitry.baryshkov@linaro.org>
 <20220726203401.595934-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726203401.595934-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 26, 2022 at 11:34:00PM +0300, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the RC mode.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 93d75cda4b04..f85f2579c087 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1485,6 +1485,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, 0);
> +	if (ret)
> +		return err_deinit;
> +
>  	ret = phy_power_on(pcie->phy);
>  	if (ret)
>  		goto err_deinit;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
