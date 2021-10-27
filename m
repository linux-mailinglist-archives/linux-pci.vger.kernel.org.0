Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488F343CDD7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 17:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbhJ0Pnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 11:43:50 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:35430 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbhJ0Pnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 11:43:49 -0400
Received: by mail-ot1-f49.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so4200641ott.2;
        Wed, 27 Oct 2021 08:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opFLfarytUi1LIEZfIIbq2GqDGG5zGCf1kpvMwl8K2o=;
        b=N0h1AAN122TZyeed0uDv8w+Si5JvFRNGZmbQQjBkPGaaTZNhDrdoVIvQRrhzw3qZo1
         z4gxPxIs/lj+F9OK+ONnHM+T/ICPQawnDsJ8rHjcSq8R7+NQZaMWgBhHDKAL8pbLCSMM
         9DvxW+KqtXkPhYYM6G7O/tRbIOx/pt1xf4pwbb97rtybJBamb2VNFEEwipA7OQm06dUM
         YdLq0HhYuWmiPKQA/KySTwM0mqnNgeUu/ViSvsPnuPoqy0o367cd1Bxc5hyIvHH9ahcN
         uNY4xJsGUxYxzvdxbVNZfcXDtZvwV2u1o8e8sJiCacuFZGQmek/NJSEd+KTiktVST0+8
         bPMg==
X-Gm-Message-State: AOAM533kIi22bz6dygTjlRCMeDSWpPvcCR8qyjnvmbVFb8f0Ozfi7CG/
        z9CVMfnJ5tGZ+8y6+oAwgCgd6P+y0Q==
X-Google-Smtp-Source: ABdhPJyE5f+gyHfDgDNIlsabVc/02zgDD1060UqyWHOJKpNCFIfxwQCMvMH/b9IbViiwtU6ZowWDDA==
X-Received: by 2002:a9d:86e:: with SMTP id 101mr25374838oty.177.1635349283615;
        Wed, 27 Oct 2021 08:41:23 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm73561oic.48.2021.10.27.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 08:41:22 -0700 (PDT)
Received: (nullmailer pid 1007478 invoked by uid 1000);
        Wed, 27 Oct 2021 15:41:22 -0000
Date:   Wed, 27 Oct 2021 10:41:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <YXlzIsTk2lKVpZtv@robh.at.kernel.org>
References: <20210506023448.169146-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506023448.169146-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 10:34:48AM +0800, Simon Xue wrote:
> Document DT bindings for PCIe controller found on Rockchip SoC.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

I don't know why this didn't get sent with subsequent versions, but it 
should have. I've applied it now.

Rob

