Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595EF45668B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 00:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhKRXxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 18:53:38 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37862 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKRXxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 18:53:38 -0500
Received: by mail-oi1-f175.google.com with SMTP id bj13so18033164oib.4;
        Thu, 18 Nov 2021 15:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdQqzU43HKUpnZBB2kJWVnYdHuE9gpSLPuv7kOuXwcA=;
        b=KjfnnAH75pyLPum/ptw2LwV5Axx/8ignO4jLhb+fMFqxeZamyT1Yx34qsnf2TvzfIb
         pWjEyDAxAIrFCtnRnJNJBbEDzbi8lictB384zwtUZJlDrunI4zrbj6rb545c8HBmuaDW
         H3rNnGH4ImXJu6AJIFRUcl15/wKgqCEFVEE7zuqEyezqoO/SQNDBzqtxjLDtHof3/2ZN
         FR6y+G0oCUynrXVa3bY9vnHdHee5WSUlCmsEFex1BEsziHYX81JyEahiz73LmEwWV6AZ
         utFsxJqGIrzJXRSB6uwTowJm1jyvj5w8ENEPdxAkJFG7bRaA7gDhJ9DCptGruxCdYwHY
         uGoQ==
X-Gm-Message-State: AOAM533B4DszPzKDkgjBe8Y1gCnO73mqMzE1kmALpmh+PZhn7m3x1bFR
        FQIIUYBP9o6xzZ2VVAONYQ==
X-Google-Smtp-Source: ABdhPJyn/bL+xzaQX+komWYvUKUMTSemYbuVI5QujiRyRaelGy2An5fwI0mbB8m9xg9IN1RZ6tTDig==
X-Received: by 2002:a05:6808:2016:: with SMTP id q22mr876614oiw.81.1637279437332;
        Thu, 18 Nov 2021 15:50:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g5sm253638ooe.15.2021.11.18.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:50:36 -0800 (PST)
Received: (nullmailer pid 2015609 invoked by uid 1000);
        Thu, 18 Nov 2021 23:50:35 -0000
Date:   Thu, 18 Nov 2021 17:50:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     bhelgaas@google.com, shawnguo@kernel.org,
        marcel.ziswiler@toradex.com, l.stach@pengutronix.de,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        vkoul@kernel.org, linux-pci@vger.kernel.org,
        galak@kernel.crashing.org, tharvey@gateworks.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
Message-ID: <YZbmy8asguINPF4O@robh.at.kernel.org>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
 <1637200489-11855-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637200489-11855-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 Nov 2021 09:54:43 +0800, Richard Zhu wrote:
> Add dt-binding for the standalone i.MX8 PCIe PHY driver.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
