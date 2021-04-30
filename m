Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BEA36FD46
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhD3PFU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:05:20 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45785 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhD3PFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:05:13 -0400
Received: by mail-oi1-f173.google.com with SMTP id n184so44253249oia.12;
        Fri, 30 Apr 2021 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/INWjCRM1B9+70V8iiUyLDnZTxKydu+XSX6q0Y8SkH8=;
        b=R5IaEhJOSypG1je14d3ATyjNI9+l1tXlXmIpilwxCBZgJiOBneFDY4GvGq9Bj6rkrb
         w8sGqKhFa3lkacUcvwF3pgJxdH9IHCPunTTnBvRtsrelbqWM+KtKySLV2pDJ2b378dHw
         Nyhas7sGf8rIcQt5VQFp8B/74k/EorHBDv6iW3CRHw1Kz9ZYsJFWsbCtFQG4iXiUR1S7
         c6dqFNf85MVMSm6G6XdvHOkekbd0DVg+yKtHf6Z5BOxQtA1bGH7e7FajXj5zbIUhuFAV
         DVGbgdE1iYR+xgJWGS72MtLYtG5qnDacw1mw38aDbPoQwhFjz4/YXp+1TITogJDr+IN2
         35IQ==
X-Gm-Message-State: AOAM531d1HI7PK1Ahy21OICfL8GizPab6Qrnba+Jis39xsNG7Uw37XF7
        ZUFJqsMXUjtCSOVxmyxyvQ==
X-Google-Smtp-Source: ABdhPJz6HzVAj0or5d1D7Hnc0EjbBhimRieQL/4bKusYwgFYusuFeT5uNTTaBlN49s62e34R6js8GQ==
X-Received: by 2002:aca:dd86:: with SMTP id u128mr4230463oig.155.1619795065227;
        Fri, 30 Apr 2021 08:04:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 68sm740146otc.54.2021.04.30.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:04:23 -0700 (PDT)
Received: (nullmailer pid 3321318 invoked by uid 1000);
        Fri, 30 Apr 2021 15:04:22 -0000
Date:   Fri, 30 Apr 2021 10:04:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 4/5] dt-bindings: phy: qcom, qmp: Add IPQ60xx PCIe PHY
 bindings
Message-ID: <20210430150422.GA3321286@robh.at.kernel.org>
References: <cover.1618916235.git.baruch@tkos.co.il>
 <f787ca496eae2a0d5ff4f17655eaff9f39a14321.1618916235.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f787ca496eae2a0d5ff4f17655eaff9f39a14321.1618916235.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Apr 2021 14:21:39 +0300, Baruch Siach wrote:
> Add ipq6018 qmp phy device for the single PCIe serdes lane on IPQ60xx
> SoCs.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
