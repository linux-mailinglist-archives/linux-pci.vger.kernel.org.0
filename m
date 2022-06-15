Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3F54CEAC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346821AbiFOQbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiFOQbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:31:50 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092403EAA5;
        Wed, 15 Jun 2022 09:31:50 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id h18so9144596ilj.7;
        Wed, 15 Jun 2022 09:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wAnv749H8T5jbgH7qOtJ76bsDPHMzd3UB3aMwPjk12I=;
        b=q8wrLHhwN5wy9cGGq/sT7DUMJd3ZZgImJ2mAZ/DAKce5IxSeM5SplnespFqTQaBn8K
         UZryVJa/iJQdtoKJRU3gDHsbSAdquwIgz3bCFqjHigILqxG67y93waz7JenIIxeMJKS+
         RJ4O5rdWpEp02cqr+X90qvJ2ixzmqb9aLh5wH5qFJcL6Gw4WA4F0koePWHNQZx6vRyaZ
         vlpaVntku9lqP2/o5wludVGX8JkFV6QcJvMvQ0nBH0mKJY9HR4y/bc+aQJHKKOmcJT6S
         wtBPu6xa8DFwOGNr4Z5xzLdUHvvsOKlu1/B9czEMhRZy1mwI8hoSl1AWKyTGoVD1Mtyh
         MwxA==
X-Gm-Message-State: AJIora/y0b/yQAKqbwzyzJbVXBvGzeqqQ6xRJB17pIbE6GZqnI65Xbxi
        b5Zudx0QAodD8650spDDXw==
X-Google-Smtp-Source: AGRyM1vzB7iayUo66rT+mIDKxHVKw6WWE4SKTSL/ca1B+1u0IkIJbRPbu2EvntupG1m67X40ESjgtA==
X-Received: by 2002:a05:6e02:b41:b0:2d1:c5a7:19ed with SMTP id f1-20020a056e020b4100b002d1c5a719edmr364805ilu.281.1655310709315;
        Wed, 15 Jun 2022 09:31:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a10-20020a92d10a000000b002d6d8398e88sm6990521ilb.70.2022.06.15.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:31:49 -0700 (PDT)
Received: (nullmailer pid 1397129 invoked by uid 1000);
        Wed, 15 Jun 2022 16:31:46 -0000
Date:   Wed, 15 Jun 2022 10:31:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     devicetree@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 06/17] dt-bindings: PCI: dwc: Add max-functions EP
 property
Message-ID: <20220615163146.GA1397011-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 10 Jun 2022 11:56:54 +0300, Serge Semin wrote:
> In accordance with [1] the CX_NFUNC IP-core synthesize parameter is
> responsible for the number of physical functions to support in the EP
> mode. Its upper limit is 32. Let's use it to constrain the number of
> PCIe functions the DW PCIe EP DT-nodes can advertise.
> 
> [1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
> Endpoint, Version 5.40a, March 2019, p. 887.
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
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
