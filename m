Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06134B007
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 21:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCZURg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 16:17:36 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:47089 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhCZUR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 16:17:28 -0400
Received: by mail-io1-f48.google.com with SMTP id j26so6629118iog.13;
        Fri, 26 Mar 2021 13:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/waVsYbxc/CEMfLtl1ZIVb7VmU/61u6EDNxRL9TvBpc=;
        b=CIec+Hma59Sz9bX5HjyIV51Wj8nXE7CvncbbTPbnnGo/rnfSdPAOQhRjiRYsd/iR0l
         sy/MVaosXCk8aRRPe2j34VIEEPvDynisdsZYsVxwb3VSmUxAyJoCImiJokAhuP/eTfOF
         RIqCz2VGn78T7lkzUUAYVmjr/sCXWwa5OKHFkyBLSBwEZnSORMDZO+W1RbRmdoYAX+YZ
         Tky9QCsEynez7m5ddlmEaAnjBU03wGM2+wHG9jSK9A+KWfCyN1rqblNnGGlLAyYXP2j5
         9C30nXb7RgOOIbJdzqvApZ9nZRLffZPFkP84xwzNsKqIPbG4LNp+NTjY3Q2VHeHVYtev
         1z7Q==
X-Gm-Message-State: AOAM530ute+F5D/1zm3l5PPI5HeSUQdLltBb+1Bv7LUxa3OB2bafI0rS
        fuIKuPPK4k+b/IeE86GApg==
X-Google-Smtp-Source: ABdhPJxZzBaleRES7A/UrIChjERT4dMfo0japjM1iovfhStVjE/NXeNNsTYKiCfKKZqaLcowlCpFyw==
X-Received: by 2002:a5e:c809:: with SMTP id y9mr11900357iol.192.1616789847392;
        Fri, 26 Mar 2021 13:17:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 74sm4761952iob.43.2021.03.26.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:17:26 -0700 (PDT)
Received: (nullmailer pid 3797288 invoked by uid 1000);
        Fri, 26 Mar 2021 20:17:24 -0000
Date:   Fri, 26 Mar 2021 14:17:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        yong.wu@mediatek.com, bhelgaas@google.com, frank-w@public-files.de,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/4] dt-bindings: PCI: mediatek: Update the Device
 tree bindings
Message-ID: <20210326201724.GA3797259@robh.at.kernel.org>
References: <20210323033833.14954-1-chuanjia.liu@mediatek.com>
 <20210323033833.14954-2-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323033833.14954-2-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Mar 2021 11:38:30 +0800, Chuanjia Liu wrote:
> There are two independent PCIe controllers in MT2712 and MT7622
> platform. Each of them should contain an independent MSI domain.
> 
> In old dts architecture, MSI domain will be inherited from the root
> bridge, and all of the devices will share the same MSI domain.
> Hence that, the PCIe devices will not work properly if the irq number
> which required is more than 32.
> 
> Split the PCIe node for MT2712 and MT7622 platform to comply with
> the hardware design and fix MSI issue.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 201 ++++++++++--------
>  2 files changed, 146 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
