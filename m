Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF157C8B4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiGUKPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiGUKPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 06:15:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A21F2A40A
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 03:15:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w7so1349399ply.12
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oR90Wy+BbIseki+Ksn9Fge8gQuYW/CcYg/B9Ro/uOaM=;
        b=vGuW2fZsTVl5M8xmJhehdo8lqxDuQ5yr9DArKQICoR6CN3HWeO4poEc+qPqUKeEsGf
         HPh/8TZ13ybohlbRVEfNOmAMoQfJbbi7qg+vjoNvGDqE0y26DENnspAqIW4pNTZy+Xxv
         WkXxXl1l4DOXhOMD6IH3OU6BO/nRbZChQO5cyPecoJ0amY1cgCbVE0Ya0N6NK4i2uQvW
         vuNZL0ri3CZGKckLiq+MgCKbUGisIN39BjUOPpAMx2JypRl8keehy/xbbUZQfmo9zEEL
         6ksnDfg/by2TAHkfs1sTBL+aP041FbQmonoeRNVDdnKEjilVINjPwt87mO/qSxMJN2ij
         olVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oR90Wy+BbIseki+Ksn9Fge8gQuYW/CcYg/B9Ro/uOaM=;
        b=yk5fmJaSpwJaK+rGyQgxGuiuD5x8Nz10NPjjGGCkWhHnrVKM7w5JWUN7rDvyMX1f+5
         K2IsWRGoxYLUwNzHhgOYyeA/Muv+e8DcIpeTzHU29wNiOUHK+syFWALEQYki6Ew5h2pT
         Bf73k36RqteqZJtfTFlvQc3cvdoSY+on7/JgeaaMjqVqzfr6WObeCCOrR5ozRcj47Cfz
         JXraF02dAZ1ndDUfyd+jrYCPsMsx7JhaqH9QhQVOWW0AEnhDJ2Dd+xq0ShTtpzP5T15P
         +rWba2hiBCCjq7B2b8cVFPnB1x6tnA0wweUjoBaP03UjygBkV+R7dqdcPIJJk8vwF9BR
         LqCw==
X-Gm-Message-State: AJIora8fQFcwJnwStEcRSMolFGGpJ4zNq2SMgH6a9fLWddcPbQ9p0kdm
        R790dHlIB5ETOcbbhdTJcZzrhHf7gWNd
X-Google-Smtp-Source: AGRyM1ueo2HzVXQZMwOgDCxW+IQN5HQEHOxiTty+UmlVUWeUsZ8VqZ1t97OKyHfMBZShN/keuCkvTQ==
X-Received: by 2002:a17:90b:4b4d:b0:1ef:a2c2:6bcc with SMTP id mi13-20020a17090b4b4d00b001efa2c26bccmr10619762pjb.186.1658398539759;
        Thu, 21 Jul 2022 03:15:39 -0700 (PDT)
Received: from thinkpad ([117.217.186.184])
        by smtp.gmail.com with ESMTPSA id 36-20020a630e64000000b0040df0c9a1aasm1116409pgo.14.2022.07.21.03.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:15:39 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:45:30 +0530
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
Subject: Re: [RFC PATCH 0/4] PCI: qcom: support using the same PHY for both
 RC and EP
Message-ID: <20220721101530.GE39125@thinkpad>
References: <20220719200626.976084-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719200626.976084-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 11:06:22PM +0300, Dmitry Baryshkov wrote:
> Programming of QMP PCIe PHYs slightly differs between RC and EP modes.
> 
> Currently both qcom and qcom-ep PCIe controllers setup the PHY in the
> default mode, making it impossible to select at runtime whether the PHY
> should be running in RC or in EP modes. Usually this is not an issue,
> since for most devices only the RC mode is used, while for some (SDX55)
> the EP mode is used without support for working as the RC.
> 

SDX55 could work in RC mode also. Support is on the way.

> Some of the Qualcomm platforms would still benefit from being able to
> switch between RC and EP depending on the driver being used. While it is
> possible to use different compat strings for the PHY depending on the
> mode, it seems like an incorrect approach, since the PHY doesn't differ
> between usecases. It's the PCIe controller, who should decide how to
> configure the PHY.
> 
> This patch series implements the ability to select between RC and EP
> modes, by allowing the PCIe QMP PHY driver to switch between
> programming tables.
> 

This is really nice! On the case of SDX55, there is a single PHY and PCIe
controller that is being used as both RC and EP depending on the usecase. While
it makes sense to use a different PCIe node based on usecase, it does not for
the PHY. So the runtime switch is a neat way of handling the differences.

I've provided my review for the patches. But for the next iteration, you could
remove the RFC tag.

Also, please mention the dependency of the series in the cover letter if any.
Like this one depends on your previous PHY cleanup series. It will help
maintainers while picking the patches.

Thanks a lot for the series!

Regards,
Mani

> Dmitry Baryshkov (4):
>   phy: qcom-qmp-pcie: split register tables into primary and secondary
>     part
>   phy: qcom-qmp-pcie: suppor separate tables for EP mode
>   PCI: qcom: call phy_set_mode_ext()
>   PCI: qcom-ep: call phy_set_mode_ext()
> 
>  drivers/pci/controller/dwc/pcie-qcom-ep.c |   4 +
>  drivers/pci/controller/dwc/pcie-qcom.c    |   4 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 155 ++++++++++++----------
>  3 files changed, 96 insertions(+), 67 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
