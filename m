Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5A3F4FCC
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhHWRsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 13:48:40 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37546 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhHWRsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Aug 2021 13:48:39 -0400
Received: by mail-ot1-f52.google.com with SMTP id i3-20020a056830210300b0051af5666070so28738812otc.4;
        Mon, 23 Aug 2021 10:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBsfD0XrGcdFhXjeONts6LY5Wea2lqmheLyik8cfuXQ=;
        b=uKIz973Y4m9+0aEcruG0QnuYZO5YLmyPU/dAdhhOOqWG4H2YLF7bQ5V5G0MyLJ1CnK
         +FWJLsnl9Y5yGijK/PZFXn9v4oWjprZmqNdS1w3rfG3we7SINHmzB6AerfhHT5BzHSlx
         yjtvUM6txsUVy2h2OMk+6eeHvD551S2qxMMPJrk49RKVaTwBiEFn5TxzMI9L0eQhy75p
         lsvjbB+tD+Nda9Izn+aRRkoAjrWmGI30bjJOOJbowutb8eKTIj71pSFa+TP5lsjF1zVK
         4sbFYCNYcJwjOTwk3FwOariMjS7cby0xBFxD2GzBbtMsf996QTILujNO8s7iLxHQ4sMJ
         TREg==
X-Gm-Message-State: AOAM531oxzXcR2JvPTkmj8dikenUHU1cX/IrapnsPMtw+A6Lqx2Hb0Wo
        6Zw2UStGx19KKFTTAGz/pQ==
X-Google-Smtp-Source: ABdhPJwGDkbzbNcCB1dG5DmxwUDmGZu4own478jDQXW6uwQ2OjjNi4xHQr8IN90RkXhHrcqB4zPQZw==
X-Received: by 2002:aca:5342:: with SMTP id h63mr11864556oib.171.1629740876700;
        Mon, 23 Aug 2021 10:47:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q7sm719391otl.68.2021.08.23.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:47:56 -0700 (PDT)
Received: (nullmailer pid 2411499 invoked by uid 1000);
        Mon, 23 Aug 2021 17:47:55 -0000
Date:   Mon, 23 Aug 2021 12:47:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add sc8180x compatible
Message-ID: <YSPfSxwMpmGkTxEf@robh.at.kernel.org>
References: <20210823154958.305677-1-bjorn.andersson@linaro.org>
 <20210823154958.305677-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823154958.305677-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 23 Aug 2021 08:49:58 -0700, Bjorn Andersson wrote:
> The SC8180x platform comes with 4 PCIe controllers, typically used for
> things such as NVME storage or connecting a SDX55 5G modem. Add a
> compatible for this, that just reuses the 1.9.0 ops.
> 
> Link: https://lore.kernel.org/linux-arm-msm/20210725040038.3966348-4-bjorn.andersson@linaro.org/
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - None
> 
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++--
>  drivers/pci/controller/dwc/pcie-qcom.c              | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
