Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57CA54672B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbiFJNMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiFJNMo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 09:12:44 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A15A0A0;
        Fri, 10 Jun 2022 06:12:42 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id p128so5781100iof.1;
        Fri, 10 Jun 2022 06:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=GUJQPqIBLKX/t4jWZnKHkjJZiTQ4T+t3dlD445+qEg8=;
        b=LlhnE92a043p3tJrMlkAtD2UCOHS8aCuiaITaFpjOCwfOJxA24CvrBstlu746Mac3j
         +BVMeyB8GCgWW8c31/6Ng6JW4RwHWMfB+pWSDoZmICNjwbbSMWkuwuHF1Z5nmSch8Tej
         xDaYkQdjADFSVLfN1gzDokCmy7H3hIJpcws3DpTdXYXBfwIqNs2UsgzN//Cm5sB2rqsj
         d+AdJ6PT+6wfMHcgviVx9yvL6+Wv13q8mGGAnQIa+IDULhmqfIt6aGTTtbPX0Q0I7uIT
         TUr8P42+11957ikGmbGtwzTWmMYotH4/zwpOXWw8j7ySdmezVb+lXTA1ccoLp5xdu0KD
         WTng==
X-Gm-Message-State: AOAM530/u80Zj2VvH0cr55npuY+yJOCiFMwdtMtMBl04oacG5lohO0xN
        DWLXrzbTL/rHr9U51A32oQ==
X-Google-Smtp-Source: ABdhPJzpXU+91NH1R+XxaxuT7R1s4GIE+oR2ZORwDbUcWvGs8HOPQcvwCCMc8f49vy0vBOWd3ZsDGw==
X-Received: by 2002:a05:6602:2b04:b0:669:5fa:12fa with SMTP id p4-20020a0566022b0400b0066905fa12famr21843526iov.178.1654866761402;
        Fri, 10 Jun 2022 06:12:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m8-20020a0566380dc800b00331e38ccc4asm4368616jaj.51.2022.06.10.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:12:40 -0700 (PDT)
Received: (nullmailer pid 1529405 invoked by uid 1000);
        Fri, 10 Jun 2022 13:12:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Simon Xue <xxm@rock-chips.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
In-Reply-To: <20220610085706.15741-12-Sergey.Semin@baikalelectronics.ru>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru> <20220610085706.15741-12-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 11/17] dt-bindings: PCI: dwc: Apply common schema to Rockchip DW PCIe nodes
Date:   Fri, 10 Jun 2022 07:12:35 -0600
Message-Id: <1654866755.753412.1529404.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 10 Jun 2022 11:56:59 +0300, Serge Semin wrote:
> As the DT-bindings description states the Rockchip PCIe controller is
> based on the DW PCIe RP IP-core thus its DT-nodes are supposed to be
> compatible with the common DW PCIe controller schema. Let's make sure they
> evaluated against it by referring to the snps,dw-pcie-common.yaml schema
> in the allOf sub-schemas composition.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/pci/snps,dw-pcie-common.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dtb: pcie@fe280000: False schema does not allow {'compatible': ['rockchip,rk3568-pcie'], 'reg': [[3, 3229614080, 0, 3735552], [0, 4264034304, 0, 65536], [3, 2147483648, 0, 1048576]], 'reg-names': ['dbi', 'apb', 'config'], 'bus-range': [[32, 47]], 'clocks': [[4294967295, 143], [4294967295, 144], [4294967295, 145], [4294967295, 146], [4294967295, 147]], 'clock-names': ['aclk_mst', 'aclk_slv', 'aclk_dbi', 'pclk', 'aux'], 'device_type': ['pci'], 'linux,pci-domain': [[2]], 'max-link-speed': [[2]], 'msi-map': [[8192, 4294967295, 8192, 4096]], 'num-lanes': [[2]], 'phys': [[4294967295]], 'phy-names': ['pcie-phy'], 'power-domains': [[4294967295, 15]], 'ranges': [[2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [2197815296, 0, 2156920832, 3, 2156920832, 0, 1064304640]], 'resets': [[4294967295, 193]], 'reset-names': ['pipe'], '#address-cells': [[3]], '#size-cells': [[2]], '$nodename': ['pcie
 @fe280000']}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

