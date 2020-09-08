Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9498261E60
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgIHTvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 15:51:14 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33514 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgIHTuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 15:50:55 -0400
Received: by mail-il1-f196.google.com with SMTP id x2so118163ilm.0;
        Tue, 08 Sep 2020 12:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wYZEjLQwTXY96HNLGsdoKgvmcXxudxUg3/wdAMNlCKY=;
        b=WQ5z5eajOMRavRHOCddVz/byDz6J7OM3LKhbYG4HZNroRTD5aM36XwohMi46Ch3ghY
         QqITxXDjPv90A3EqewXT3QPSQYo9s8Nw/ddfk2H5QF3ZZeyaIvoIpMNscz8MWYJl8a74
         qPdLk2VxzdsDW8wJNv5UwIJohqtxEI5fmkM+UTdtmUTZy8NWzT5CPlpwYux7TDF7JcQJ
         wvTqUHeB6avZiRA4FWebVTIciSNU0HhoWlQlDs40bE4SltAOcV0aQfgellEkDI92/3qO
         FM1TJnLs6hw0++12887WNjOfPjtBkI22AzpQII7EkC2LJ2K7leLHTFCAoG4VwIx5ipmU
         q+2g==
X-Gm-Message-State: AOAM5321g1qnd9Q7cfe1LmumPP3LOUmSHv5Lrjm30sMokjufNlHn5qE9
        MA9ao7Zj5eFHqbw3H2WfaA==
X-Google-Smtp-Source: ABdhPJyOWElQls0b423Yc43EIQ2uJbnV85nXzCnrhQNpnp/WEIa0eqADRr+RFWsXeGWmMLnRWyzVbA==
X-Received: by 2002:a92:189:: with SMTP id 131mr425929ilb.40.1599594654188;
        Tue, 08 Sep 2020 12:50:54 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q23sm156327iob.19.2020.09.08.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:50:53 -0700 (PDT)
Received: (nullmailer pid 795761 invoked by uid 1000);
        Tue, 08 Sep 2020 19:50:50 -0000
Date:   Tue, 8 Sep 2020 13:50:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     davem@davemloft.net, Philipp Zabel <p.zabel@pengutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pci@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sj Huang <sj.huang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [v1,1/3] dt-bindings: Add YAML schemas for Gen3 PCIe controller
Message-ID: <20200908195050.GA795070@bogus>
References: <20200907120852.12090-1-jianjun.wang@mediatek.com>
 <20200907120852.12090-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907120852.12090-2-jianjun.wang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 07 Sep 2020 20:08:50 +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dts:55.56-59.19: Warning (pci_device_reg): /example-0/bus/pcie@11230000/legacy-interrupt-controller: missing PCI reg property


See https://patchwork.ozlabs.org/patch/1359119

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

