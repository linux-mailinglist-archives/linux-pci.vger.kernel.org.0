Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46677267624
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKWrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 18:47:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34131 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKWrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 18:47:23 -0400
Received: by mail-il1-f195.google.com with SMTP id a8so10474161ilk.1;
        Fri, 11 Sep 2020 15:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=toRK8zGv7TSJRoFMqCRYc0FnDU6AsE8wqo5QvqdD9Y0=;
        b=LeojaZItGchL2ujLSZcc+61NVkNH46GKfKmMaSSWoJ874Hrjt8ao9RXai9Cg70W3Sc
         nA3ISgbhuvJlQ3vcSkcOwVWxGwdU4hcxOSvi6L7EDLVzLLTM1FOBhVWvXVRD14uOHTTb
         FyrEtrNVqfog9A/L4JZlGs20/c6athi74dltG276oulz+l8WlZXmTQhtTKfsUqRb13Tu
         hATtRle/tOUOqPDaJY30R7+DGEvQDkkG9hEPgEMzQPecjq44eEst8Hkfuf0XXSaltmVs
         tdveqoiC3vc9pCYHmZfDfrd3AVEJ5+H4/9N8ID+T0k2q9py0P1pNJKxuR1WCKQBxrcJ1
         faAg==
X-Gm-Message-State: AOAM533YqwyUSuHpKaKIWkX/O6jCuyzQwe2daluxUUKdqR/P0bu/Jixj
        v7zpWRgvIJgHx5mYGM2Lcg==
X-Google-Smtp-Source: ABdhPJz2tzFgwdaI7kMcby20MLuKDjuwoCwCUru/3NSCPPsR6LUbfstzJwDVYDEEYeQEjRY4jj0a+A==
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr416324ilj.291.1599864442418;
        Fri, 11 Sep 2020 15:47:22 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i1sm1880771ilk.39.2020.09.11.15.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:47:21 -0700 (PDT)
Received: (nullmailer pid 2961743 invoked by uid 1000);
        Fri, 11 Sep 2020 22:47:09 -0000
Date:   Fri, 11 Sep 2020 16:47:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>, yong.wu@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
Message-ID: <20200911224709.GA2960430@bogus>
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
 <20200910061115.909-2-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910061115.909-2-chuanjia.liu@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Sep 2020 14:11:12 +0800, Chuanjia Liu wrote:
> Split the PCIe node and add pciecfg node to fix MSI issue.
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  38 +++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 144 +++++++++++-------
>  2 files changed, 129 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.example.dt.yaml: example-0: pciecfg@1a140000:reg:0: [0, 437518336, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1361249

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

