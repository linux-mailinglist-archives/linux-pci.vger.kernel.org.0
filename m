Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3987415A1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjF1PtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 11:49:22 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:55392 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjF1PtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 11:49:18 -0400
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7835e5fa459so1629239f.2;
        Wed, 28 Jun 2023 08:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967357; x=1690559357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yTuLJEjegEnc+ckJ/STK+G1bTc1nViuTPAG6DOencA=;
        b=BZ0Ip2CP1dBVIJ1RsN9+fgK5GQIRiGHv30AHsWxiMxS0voDItkDBLA6ldaqEqj34Gz
         Pe2RIfvcc4HrQyvOSREdwMvllUcmkL7ZOMx6TA2JT4B2Ztaf5Oy/DwxArAX9GIgAK0zb
         895LCdz5ZxmJbIs3tO6VzaXyf2GpZvlgzbyXx6+1/b0B0IohK2QvhVS2sLNIdXg3sbQT
         CBOEwsFSJAyZlxXwgM7r7tnXtuiAX58eNUiJbERww24Zs2gTfq4VKR4f1P+/rgjbfyZI
         dcVvdWKpWibPgz68svsMySBLrAPgQ/kgNvD6H1wVUMhh2vra/BTvnfMZ8hplDqMeoC9I
         Ph7g==
X-Gm-Message-State: AC+VfDxvVKW6MfMF20RyUxMFcpV+HQV8CDae2aOT7E7c0A36OlT1aXSi
        DDp8evgYyJjdnxQL0Hm0lQ==
X-Google-Smtp-Source: ACHHUZ5JQFD1swjEc+5KIr79xJ+lX9X7/7F/be7HrRES7/memPLKsVxZkqlae2+9Rc1k71hUJkzTTA==
X-Received: by 2002:a5d:9452:0:b0:783:7275:9c47 with SMTP id x18-20020a5d9452000000b0078372759c47mr5690077ior.7.1687967357467;
        Wed, 28 Jun 2023 08:49:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k5-20020a02cb45000000b0040bbcee6b57sm1044231jap.133.2023.06.28.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:49:16 -0700 (PDT)
Received: (nullmailer pid 535502 invoked by uid 1000);
        Wed, 28 Jun 2023 15:49:15 -0000
Date:   Wed, 28 Jun 2023 09:49:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-pci@vger.kernel.org, bharat.kumar.gogada@amd.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, michals@amd.com,
        lorenzo.pieralisi@arm.com, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Message-ID: <168796735468.535447.828928601501423401.robh@kernel.org>
References: <20230628092812.1592644-1-thippeswamy.havalige@amd.com>
 <20230628092812.1592644-3-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092812.1592644-3-thippeswamy.havalige@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 28 Jun 2023 14:58:11 +0530, Thippeswamy Havalige wrote:
> Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> change in v5:
> Modified uppercase case hex value to lower case.
> change in v4:
> - Removed unnecessary space.
> changes in v3:
> - Fixed compatible string issue.
> - Modified ranges property description to maxItems.
> - Modified address-cell property of interrupt-controller child node.
> changes in v2:
> - None
>  .../bindings/pci/xlnx,xdma-host.yaml          | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>

