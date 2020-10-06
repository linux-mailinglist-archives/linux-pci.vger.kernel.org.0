Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE4285410
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgJFVut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 17:50:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43128 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFVut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 17:50:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id l85so189200oih.10;
        Tue, 06 Oct 2020 14:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWes/yu+mBIEDEh+K26AzOE76qunRcdgTJyHBYmLCK4=;
        b=ufaV2+zM5TJqHv20VJd/Zi4kpLcqwOXh5vRtFgYniE/N+Omr29BA10zRp/B8PtIuZq
         yHPlZweWa0YsdS4nWarvfp8nDHb3+wbpjqFOeaA50STMXNtRbbT5SB7XblNoJ/KrEytr
         P+KKjiUxMXjfBv/hDqCuagARuPtawLFmH7pBuozVtI3kvW4/4VN07y6D9fZs6jX4KB7d
         lUD/g5mkRJ/iC9mTs2xiZmhbeCw3uPHSAD+GIfiu5NdjT2Z9TTevRM08Qw/j4qEep+Hy
         bgHSsZruqrS0i4ZEr9DZ3kcxgBVWaF4QOfaoE2LG9RnJnQIT5exSF1etstjkhmHT09zx
         G3Mg==
X-Gm-Message-State: AOAM532gyukHcBgR6ZbNed79jBnhV3VLsPOZw7k+2RQZjqBQfDawIaqe
        LrXVtviApl2AYXiNdqcvNg==
X-Google-Smtp-Source: ABdhPJwdzPoK6D3j4YnvHhkFnmCr6wu/OqyYvYCdlHDIMJy2I58fyvPNewiHilM7JDJ+hTZCjj2iOQ==
X-Received: by 2002:aca:1006:: with SMTP id 6mr214231oiq.2.1602021048280;
        Tue, 06 Oct 2020 14:50:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v21sm9000oto.65.2020.10.06.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:50:47 -0700 (PDT)
Received: (nullmailer pid 2911306 invoked by uid 1000);
        Tue, 06 Oct 2020 21:50:46 -0000
Date:   Tue, 6 Oct 2020 16:50:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] PCI: qcom: Add SM8250 SoC support
Message-ID: <20201006215046.GB2893458@bogus>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
 <20201005093152.13489-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005093152.13489-5-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 05, 2020 at 03:01:51PM +0530, Manivannan Sadhasivam wrote:
> The PCIe IP (rev 1.9.0) on SM8250 SoC is similar to the one used on
> SDM845. Hence the support is added reusing the members of ops_2_7_0.
> The key difference between ops_2_7_0 and ops_1_9_0 is the config_sid
> callback, which will be added in successive commit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
