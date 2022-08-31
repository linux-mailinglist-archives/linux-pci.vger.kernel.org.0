Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B495A8800
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiHaVSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHaVSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 17:18:42 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F6EE48A;
        Wed, 31 Aug 2022 14:18:39 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1225219ee46so2499978fac.2;
        Wed, 31 Aug 2022 14:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9m98NxU5A86KuWXY2vovcqY79lYhHDupa0B+1XAZNXI=;
        b=J5itwN7e9LGnhrm23Fwvv/OcJpHHDiOEza+6QLGn8Y7B2air9FdCxPKYfZj9Xzg2qo
         S5PdhgNsf760yQcnRXWf0cH3/xjExzQy6goOqrADeHUfPA8YtLDnzJYN2QlGN6LwaWrZ
         Fw5kHEgwA7uODQ0qPp5BOqksgLmyb+ImJHkw4NnzwCywNl6KrIYQVjlhREG7Emr+FIgt
         0ikjwoT2NkNhl+qEO9oZBQap5sKEl9QHuny1ZNSiAeikS1dJuZJ18JXt1Ws7I7B8yNlJ
         Vt9+65zEEM1al1O5Mv6cvp0XuIeIUQ48f2d22W3LAjyqNHDELu75IPmHoRyGr7r1PZon
         1gEw==
X-Gm-Message-State: ACgBeo0vJQgKwKA6YvJWYvyOwfc7rPTpW3xqqcUZ5HepEFGDoiL9Tj6B
        7ydlUoa6GhnTQMU8PDKKNSNyzHS8/A==
X-Google-Smtp-Source: AA6agR5mjzuCT804Od3ar0hVSJxntEJNibVpbFZ3mWYBSrWp0nknR6FsyV22UkQZ3NpMXCOUl9XgoQ==
X-Received: by 2002:aca:5bc3:0:b0:345:30a2:89da with SMTP id p186-20020aca5bc3000000b0034530a289damr1973244oib.3.1661980719096;
        Wed, 31 Aug 2022 14:18:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g10-20020acab60a000000b0034516ca90dcsm7962802oif.23.2022.08.31.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:18:38 -0700 (PDT)
Received: (nullmailer pid 267582 invoked by uid 1000);
        Wed, 31 Aug 2022 21:18:37 -0000
Date:   Wed, 31 Aug 2022 16:18:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH v5 07/20] dt-bindings: PCI: dwc: Apply generic schema for
 generic device only
Message-ID: <20220831211837.GA267498-robh@kernel.org>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822184701.25246-8-Sergey.Semin@baikalelectronics.ru>
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

On Mon, 22 Aug 2022 21:46:48 +0300, Serge Semin wrote:
> Having the generic compatible strings constraints with the 'any'+'generic
> string' semantic implicitly encourages either to add new DW PCIe-based
> DT-bindings with the generic compatible string attached or just forget
> about adding new DT-bindings since the corresponding DT-node will be
> evaluated anyway. Moreover having that semantic implemented in the
> generic DT-schema causes the DT-validation tool to apply the schema twice:
> first by implicit compatible-string-based selection and second by means of
> the 'allOf: [ $ref ]' statement. Let's fix all of that by dropping the
> compatible property constraints and selecting the generic DT-schema only
> for the purely generic DW PCIe DT-nodes. The later is required since there
> is a driver for such devices. (Though there are no such DT-nodes currently
> defined in the kernel DT sources.)
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch unpinned from the next one:
>   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
>   by the Rob' request. (@Rob)
> - Fix compatible property schema so one would work as expected: string
>   must contain either generic DW PCIe IP-core name or both generic and
>   equipped with IP-core version names.
> 
> Changelog v5:
> - Switch the patch from not-selecting the generic schemas to applying
>   them to the generic DW PCIe device nodes only.
> - Drop the generic compatible string used as fallback. (@Rob)
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 16 ++++++++++------
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml    | 16 ++++++++++------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
