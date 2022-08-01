Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7E586F93
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiHARaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiHARaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 13:30:21 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB626EE;
        Mon,  1 Aug 2022 10:30:20 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id s16so2207728ilp.3;
        Mon, 01 Aug 2022 10:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0LWhWxKEK9e9eqjUyOZZ8NVIggUUXhWj4ioBL7S50EQ=;
        b=1LNbUKMHFJQpuH+e5ETZkYzVYwK/0UuSZSwh+VuE6h0Ny9LUjkXENxy13MDAc8l2yi
         B8boc2H6cr7FyHdskxXRtTicgQon9to60vNxduMYly+0fCAjXWBK8gzx8LnTaBaB+FLf
         vJf3uXmHYHqUDX2p4tCvEYbedPM0SWH/ZkHCN/FBpoc6PXCLj6wiq0ijq1eWDAYdqMs6
         Jx0ZMcAG34Zvt0rrl6qryC3vjl6PTwkCkJppQu9LUFuCYccDoTJRTytsAEnIucB55qMk
         M0wu6cWYpF79FnMfloTqEyIzoI5vxeY5BAtNe/wZFl/E86R4DhhZg8sXn2nS2COe09+1
         gmqA==
X-Gm-Message-State: ACgBeo3woR/kxkjxbI/YFKU0jNwPIW1T81WSWU0odRLsRexA7aiX3byk
        FI+uSrsl9Ifv+Pz8SvbzvA==
X-Google-Smtp-Source: AA6agR5vgSzZo7CA10FZ++gLwwH0vmNXaPRlHfPRzbPu2sVj4x2fE8QJdkfxldaj9o0Ag5kQ0I97Eg==
X-Received: by 2002:a05:6e02:12c3:b0:2de:79d9:f408 with SMTP id i3-20020a056e0212c300b002de79d9f408mr3517874ilm.107.1659375019748;
        Mon, 01 Aug 2022 10:30:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x14-20020a92de0e000000b002dd0cf02f42sm4958665ilm.44.2022.08.01.10.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:30:18 -0700 (PDT)
Received: (nullmailer pid 1218214 invoked by uid 1000);
        Mon, 01 Aug 2022 17:30:16 -0000
Date:   Mon, 1 Aug 2022 11:30:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4 01/17] dt-bindings: PCI: dwc: Detach common RP/EP DT
 bindings
Message-ID: <20220801173016.GA1218163-robh@kernel.org>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728143427.13617-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Jul 2022 17:34:11 +0300, Serge Semin wrote:
> Currently both DW PCIe Root Port and End-point DT bindings are defined as
> separate schemas. Carefully looking at them, at the hardware reference
> manuals and seeing there is a generic part of the driver used by the both
> RP and EP drivers we can greatly simplify the DW PCIe controller bindings
> by moving some of the properties into the common DT schema. It concerns
> the PERST GPIO control, number of lanes, number of iATU windows and CDM
> check properties. They will be defined in the snps,dw-pcie-common.yaml
> schema which will be referenced in the DW PCIe Root Port and End-point DT
> bindings in order to evaluate the common for both of these controllers
> properties. The rest of properties like reg{,-names}, clock{s,-names},
> reset{s,-names}, etc will be consolidate there in one of the next commits.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> ---
>  .../bindings/pci/snps,dw-pcie-common.yaml     | 76 +++++++++++++++++++
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 31 +-------
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 33 +-------
>  3 files changed, 78 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
