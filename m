Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA72257C890
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiGUKGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiGUKGr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 06:06:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F24691D2
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 03:06:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p8so1329337plq.13
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AVi71jTg2zZgRyksu4oDVpC11c/ibz9Ad2vYrARJAuk=;
        b=lQKSIpdxBQBj3NDqMVti15bQQcyYgi67J2ZbvxOu7JNF+q+9bQAhQT+n9g1YoKpGib
         S17SYds6jd5cUMwpU/CCqWpVuW5d2sEIJ7XB/8q3jFFaYdgZq092jL4tpU2p1FPsX06e
         y8hhaIiw69hak/ANQIC2WgSk3ieHk4HeznjI+2y8fupLspLVg4Q6s8KktxbaUK0KGNm6
         CtwseyraVhrzYqdjHdy5NjvseggKXiufAOFrbVNGp5rBex3y7I5FueymzMIdMN+JGXT1
         KtvgBdE7V6XCzEu1NgZev2GOfBo60m8mB9dhauG1QT6LCBtfmqPbVBDGQKwFVeaSCeMK
         oH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AVi71jTg2zZgRyksu4oDVpC11c/ibz9Ad2vYrARJAuk=;
        b=Xn+ny7gSAqtDRcPYVn40/ef0It3ELkJI0hkVVz4GKZLjUiJa1ivTnMzgTGA/bk8onB
         djU3Ui88rlr3TiKzYzgczHnDydA9HW8b7kX44Vtn/Z4OujHgHkLbmvFiNu0AsRQP2cEm
         IBpWLa2Ovg8o7ubX6ndUif3vPFcsVckSxk3o7g/mm0mi44lv99tMH9d6KXzWCRja0xBG
         CWl7gWQPgIfYPaigOySWoH63YNAi/ULK0TJ1Zf+a+0TmVztWZoIO6jWrraaFuM1AIB3Y
         syWZHNT3IHwgFyDz3vucE6elVALW+FsbBO79y7bxzcZew9eDqrk8oTSr6INrl1zfJ5MU
         TLmA==
X-Gm-Message-State: AJIora+Jfru9wZfsdLwZ84z7YWKYlSUj6YrPMJ6Kho6SAW0yfrDmFfjD
        l2Z8E6hmLvuuriLSzoM81RVH
X-Google-Smtp-Source: AGRyM1t+5pkhTckRd47fBjJIXpNSlttS3jlHQMWA2BnyvciXg8rGjrhzqIi7eRvnwPNUzZan3B/yRg==
X-Received: by 2002:a17:902:d48a:b0:16b:f0be:4e15 with SMTP id c10-20020a170902d48a00b0016bf0be4e15mr43685877plg.155.1658398006077;
        Thu, 21 Jul 2022 03:06:46 -0700 (PDT)
Received: from thinkpad ([117.217.186.184])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm1316888pfy.55.2022.07.21.03.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:06:45 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:36:38 +0530
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
Subject: Re: [RFC PATCH 3/4] PCI: qcom: call phy_set_mode_ext()
Message-ID: <20220721100638.GC39125@thinkpad>
References: <20220719200626.976084-1-dmitry.baryshkov@linaro.org>
 <20220719200626.976084-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719200626.976084-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Subject could be,

"PCI: qcom: Set PHY in RC mode"

On Tue, Jul 19, 2022 at 11:06:25PM +0300, Dmitry Baryshkov wrote:
> Call phy_set_mode_ext() to notify the PHY driver that the PHY is being
> used in the RC mode.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5ed164c2afa3..50bf3fefef7a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1486,6 +1486,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, 0);
> +	if (ret)
> +		return ret;

err_deinit?

Thanks,
Mani

> +
>  	ret = phy_power_on(pcie->phy);
>  	if (ret)
>  		goto err_deinit;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
