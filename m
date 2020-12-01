Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D32C93C3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 01:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgLAASM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 19:18:12 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:35433 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLAASM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 19:18:12 -0500
Received: by mail-io1-f45.google.com with SMTP id i9so13803368ioo.2;
        Mon, 30 Nov 2020 16:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3y5lHxw9L2sp4pKlDXYUK3THtSMZV6/5JS02mefxQ1I=;
        b=tQkx+fi15+txXgY+eRgoJ3vniRgv33VLiU0HIFo1l161uURkTY9oidPrHUGMxCYa6F
         NMjCAmbowEIAwxE5gL3Kfft9eNqWpS8sSG050wgWW4qSqkRYMfsKCLJxkfLQbmuDuttI
         Wj7UjIgvocBaKfLXwWN6BlFC6STDGTa7GZENWwuyEbe/zGcegcxbOwIs9ieA5pTsp1zo
         dezrSWoPZ/N4N4hbdfJq3VehFISMRx7RokNFc+VANi/8KWcozrKZ9dD8g3JydnL5yPQ9
         vHlYGpq24zjkSd+yhJD4VSZVrJQwngPg9V2Qs9gnpzdfLgfl1WrV++BfdrfMhzetb7cS
         TCpQ==
X-Gm-Message-State: AOAM532EFHcBF4TuiiCjSLs3Kr6wmIxxb8iHoHU4wHhV94W31Evfb56I
        AWc0bk7Y7cf0KgjcwOh48g==
X-Google-Smtp-Source: ABdhPJzKuOpKkwZB80o5iMvuqLTVkadj8zW3lC1ulA9iHs8BZ0C9xSZEJ5zuRHbphCw/whh4wyplBw==
X-Received: by 2002:a02:90c6:: with SMTP id c6mr321139jag.3.1606781851455;
        Mon, 30 Nov 2020 16:17:31 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f29sm116491ilg.3.2020.11.30.16.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:17:30 -0800 (PST)
Received: (nullmailer pid 3321016 invoked by uid 1000);
        Tue, 01 Dec 2020 00:17:26 -0000
Date:   Mon, 30 Nov 2020 17:17:26 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     linux-pci@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, sin_jieyang@mediatek.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        qizhong.cheng@mediatek.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        chuanjia.liu@mediatek.com, Philipp Zabel <p.zabel@pengutronix.de>,
        davem@davemloft.net, devicetree@vger.kernel.org,
        youlin.pei@mediatek.com
Subject: Re: [v4,1/3] dt-bindings: PCI: mediatek: Add YAML schema
Message-ID: <20201201001726.GA3320955@robh.at.kernel.org>
References: <20201118082935.26828-1-jianjun.wang@mediatek.com>
 <20201118082935.26828-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118082935.26828-2-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Nov 2020 16:29:33 +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
