Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D4221757
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 23:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGOVvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 17:51:01 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38658 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 17:51:01 -0400
Received: by mail-il1-f193.google.com with SMTP id s21so3336497ilk.5;
        Wed, 15 Jul 2020 14:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KBhS464+xTe8zxChlHKza9Sk8r7xT2QRaf6Ev4NHLb8=;
        b=O+NBb3qdDmUvsaW3D34W59A3Zq2Lx247Zn8SGtlOfpbql9MqM1HxXVC5wsf5iB0gX9
         OYMCZuF2mRo2xHGHl3+e7AtNvVpiP1KbyyIZds2GL4e6AV43zKgtSrnJNFcRBx88xGZE
         rSYafq6czDFkXUATAS6IYsS1ETwBwbdie5o3bGNlGUh67YlMs9+4BZxiLKso6yPYketu
         3qq6F4L3bAnYwcFcA2DqlU+Yd+OabHJCVVAfLpBY1BTXC+WuuDtokYE5UhTBZFpKXxxm
         0r68JzzILTi6et9lWDIdFB8Tij2A2R56nA5zaVYNrYMT00/vzNbUT+rVjFCOJ7GB/BaD
         cG0g==
X-Gm-Message-State: AOAM5304c/bTu/24vMH27UMG44X8YC4xS+zyW/YZxt5hNGKwsIF7BjhE
        8h9c/fgjLT/lyUwtWiE8sw==
X-Google-Smtp-Source: ABdhPJwBGi+uuOaHqFueng9LtD6gz4CIY5Va7eyOPqpgOg3ZpGgOwXsgclNDCXLpVMhYg6g8qG0cVg==
X-Received: by 2002:a92:5ecf:: with SMTP id f76mr1672287ilg.6.1594849860224;
        Wed, 15 Jul 2020 14:51:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w4sm1751016ioc.23.2020.07.15.14.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:50:59 -0700 (PDT)
Received: (nullmailer pid 879112 invoked by uid 1000);
        Wed, 15 Jul 2020 21:50:57 -0000
Date:   Wed, 15 Jul 2020 15:50:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     kishon@ti.com, linux-clk@vger.kernel.org, smuthayy@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        vkoul@kernel.org, varada@codeaurora.org, mturquette@baylibre.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        p.zabel@pengutronix.de, svarbanov@mm-sol.com, bhelgaas@google.com,
        agross@kernel.org, lorenzo.pieralisi@arm.com,
        bjorn.andersson@linaro.org, mgautam@codeaurora.org,
        sboyd@kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,qmp: Add dt-binding for
 ipq8074 gen3 pcie phy
Message-ID: <20200715215057.GA879061@bogus>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
 <1593940680-2363-3-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593940680-2363-3-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 05 Jul 2020 14:47:53 +0530, Sivaprakash Murugesan wrote:
> ipq8074 has two different phy blocks for two pcie ports, with pcie gen2
> compatible already available, specify the pcie phy compatible
> for gen3 pcie port.
> 
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
