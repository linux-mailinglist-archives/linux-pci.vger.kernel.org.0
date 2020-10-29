Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31AA29F01E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgJ2PfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 11:35:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43484 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgJ2PeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 11:34:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id x203so3567895oia.10;
        Thu, 29 Oct 2020 08:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aK/szC9cuz0dkwowt7HBz66qxgW7H05J1XCoOJdmtI=;
        b=RTRDv3osDih5WS33gx4crX+GwILnZA98bJXE1n+fblBAOYInIB/G7K1X1b93OEBGmA
         oNr1VvztFjLupxCAZ1H38SKl7+H947lDpjIwst0NIM7EspqWwYic7sH1gE5ReacXUfFg
         9i8T6p5l3/Mtlu2H9cuuEFbJDFxYii2nq1g+gJuhnuqkhURIfR2cey4ep/Qfc+11iTnz
         R5lnJZhNEBJscXnLRGQzRs3vkMKVhThUwNMrxmolliz/I79jG3g9RCUsIB3hP3l/JhqJ
         +7wgs0uS0WzdWHSOUBU1tAl7kmT42pU9UNxo5G49nXTGfYXob4YEUjWClJxH/KsfwJ8U
         81Pg==
X-Gm-Message-State: AOAM532idpb9Z1TfoQ6oLXDsVt7WnAvWF7xOcakm92NgdBCTS+stb+Z1
        IFKWZpfETu5ydupRCU86gA==
X-Google-Smtp-Source: ABdhPJxG7ICq8C1FIbSZZtWag6ID+Jd5bh+2TxqPf8GogPBGE65XxoIbK5S1tuOukAIbQd3RCoMMEw==
X-Received: by 2002:aca:670b:: with SMTP id z11mr78596oix.116.1603985645332;
        Thu, 29 Oct 2020 08:34:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i18sm733762oik.7.2020.10.29.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:34:04 -0700 (PDT)
Received: (nullmailer pid 1912238 invoked by uid 1000);
        Thu, 29 Oct 2020 15:34:04 -0000
Date:   Thu, 29 Oct 2020 10:34:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, yong.wu@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
Message-ID: <20201029153404.GB1911637@bogus>
References: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
 <20201029081513.10562-2-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029081513.10562-2-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 29 Oct 2020 16:15:10 +0800, Chuanjia Liu wrote:
> Split the PCIe node and add pciecfg node to fix MSI issue.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 129 +++++++++++-------
>  2 files changed, 118 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml:19:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1389940

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

