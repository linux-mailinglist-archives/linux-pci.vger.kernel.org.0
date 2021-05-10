Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67987379301
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhEJPuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:50:03 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36863 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEJPuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 11:50:00 -0400
Received: by mail-ot1-f50.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso14825391otn.3;
        Mon, 10 May 2021 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0s9YigQUJ/LXiQfPGifCK11/lOC8QzwiEINdkGwd2X4=;
        b=oAdPb6Y/DzphItXce6znA5q3d3Lf63o3uLhEW9UMY4GSvPy1RWH/prb3c2lU5TLORO
         U44dNGka+xQQs/VrhRTBBF44jPMvorauUUd79pmC+1zhnpXOy52Juz7mbWZIfKleQiW0
         rZqa8FQBAuVLtZy3ALWS8CCPsyOKpnOzv3IvB4QmlikvU1xU4UCXz9DEY1SsUB3ith0c
         MlFbQ+b+QjhAm/+YUpwBMMCt4e2JfLEYOgc8Or80iJmqe/BcMaDoYiFCnjIvJq8pn5Rp
         ogRa0wxdUTRj1D7l4aqBXMmQMPGD9zDyqGGNWfkP+HwxV9hOC5frdMrbBQcZ05lJgzuS
         GUfA==
X-Gm-Message-State: AOAM533UAfCO0VmjvQbe3nFbgVOy1ANmzhsxmZ6ySfsUHZOy+M7w+OQB
        bQy6ZLidRAb4HqWzKCxUZQ==
X-Google-Smtp-Source: ABdhPJxnAsMxt2AYbuf0Wn5S6hv3hi6bMg9NcLNa7hEDJKYFK+24dzi7MZHl2PtrRRsPpVxcSqUKJw==
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr13021392otq.152.1620661735051;
        Mon, 10 May 2021 08:48:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y191sm1765230oia.50.2021.05.10.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:48:53 -0700 (PDT)
Received: (nullmailer pid 185091 invoked by uid 1000);
        Mon, 10 May 2021 15:48:52 -0000
Date:   Mon, 10 May 2021 10:48:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prasad Malisetty <pmaliset@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-pci@vger.kernel.org, mgautam@codeaurora.org,
        dianders@chromium.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: pci: qcom: Document PCIe bindings for
 SC720
Message-ID: <20210510154852.GA185045@robh.at.kernel.org>
References: <1620382648-17395-1-git-send-email-pmaliset@codeaurora.org>
 <1620382648-17395-2-git-send-email-pmaliset@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620382648-17395-2-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 07 May 2021 15:47:26 +0530, Prasad Malisetty wrote:
> Document the PCIe DT bindings for SC7280 SoC.The PCIe IP is similar
> to the one used on SM8250. Add the compatible for SC7280.
> 
> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
