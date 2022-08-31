Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8D5A8818
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiHaV2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHaV2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 17:28:13 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951CFF5CD9;
        Wed, 31 Aug 2022 14:28:12 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11ee4649dfcso20806117fac.1;
        Wed, 31 Aug 2022 14:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BoUUi7kWOmFUAVbHliHcyPkiOOsEv0Tfz2biE6Fi4Zg=;
        b=at9Il2zMlbvubGxbjmP/SaPE5TfcI14/aFBEyGunhL3zhIdIgbz9Cbtm6sgiECWP4q
         vIkzafrMSp+3faRyIx2mD3nKb37bF//uJA0r6CahxToyU6oGKBc3gKcEa5a6ezfHQUgQ
         695Sc8Evysk55rUvqOHV8SK4SgVbtoecW+04pU8qYU9X4pUkEqG9YEkGQiwNzXWO229E
         Yzs2aCdTJmUdf6xdC9YR67C63p1IBf15kMTjoDYiYzYlduppoRdf9DYWqiXI3cImzXVs
         8rsGwtk/TbhZxLDyr6nYjD5Dc/0Ld9zhCqvIfo3SR2a11pT3vZf6oS9kqVk/h9xhP3+K
         Bx9A==
X-Gm-Message-State: ACgBeo36FdRL8dI/pPZKnKpUK5ZBsI8bYVTFA/mVUYvEHOKN9GK+abtc
        WqV/8Opdbpps/7AbwuzTqg==
X-Google-Smtp-Source: AA6agR5sp6p3AvzhZHhB9FeGpft2IMHe5ZJ8L92p23FHf81Lu9EK5XaNvhZVgX0cC/OE9O9JFzRN3w==
X-Received: by 2002:a05:6871:10d:b0:11e:d761:2781 with SMTP id y13-20020a056871010d00b0011ed7612781mr2398877oab.263.1661981291916;
        Wed, 31 Aug 2022 14:28:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u34-20020a056870d5a200b00122520b2176sm507366oao.31.2022.08.31.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:28:11 -0700 (PDT)
Received: (nullmailer pid 281996 invoked by uid 1000);
        Wed, 31 Aug 2022 21:28:10 -0000
Date:   Wed, 31 Aug 2022 16:28:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 14/20] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <20220831212810.GA281963-robh@kernel.org>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-15-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Aug 2022 21:46:55 +0300, Serge Semin wrote:
> Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> controller is supposed to be fed up with four clock sources: DBI
> peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> reference clock generating the 100MHz signal. In addition to that the
> platform provide a way to reset each part of the controller:
> sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> Hot/Power reset signal. The Root Port controller is equipped with multiple
> IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> equalization request and eDMA ones. The registers space is accessed over
> the DBI interface. There can be no more than four inbound or outbound iATU
> windows configured.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> - Fix the 'compatible' property definition to being more specific about
>   what strings are supposed to be used. Due to that we had to add the
>   select property to evaluate the schema against the Baikal-T1 PCIe DT
>   nodes only.
> 
> Changelog v5:
> - Drop generic fallback names from the compatible property constraints.
>   (@Rob)
> - Define ordered {reg,interrupt,clock,reset}-names properties. (@Rob)
> - Drop minItems from the clocks and reset properties, since it equals
>   to the maxItems for them.
> - Drop num-ob-windows and num-ib-windows properties constraint. (@Rob)
> ---
>  .../bindings/pci/baikal,bt1-pcie.yaml         | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
