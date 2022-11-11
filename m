Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AE662590C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiKKLE4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 06:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiKKLEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 06:04:54 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2C5B585;
        Fri, 11 Nov 2022 03:04:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so7832774lfv.2;
        Fri, 11 Nov 2022 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Od3UfcxF+ZlfXUq7jjNyBB+yQGOCv7zBBlbMwLtdKYc=;
        b=jhd9smis2M3IZo23nle2YDPArf49P1H5YrCs1sOs84gjAm567Cidw1mbDVvi9+eKrf
         Ey15I+AtsSqccvFe0BzzN+VmjjWUi43/nZjTVZ4gc2ySza/fNwQSDwy9AL+craDnuAyq
         1pvV+x7mObRwZ8R/JO1pa7NqbJWivfETT+VsfAhDw2UGnHE7B5B0R1FNX0KDZ1zN962f
         KXLTQNis/ikVFwxbGXS9wibE9LTQp62xNpRjKuWLoLYu0PRAvCq71kj31d1AN7wVQ6Zt
         qmoObX0eJ65uLpFwflQFBvkAFk5ca5TYF+mNGm3f4NruwcjjIKbu1sv/oBNGPswKice7
         p6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od3UfcxF+ZlfXUq7jjNyBB+yQGOCv7zBBlbMwLtdKYc=;
        b=dIKXtrQlV2TX3hs9whr2XwmA4pwJpijOwi5d6jbkTmgIHiUUNU+xIgc9F4kKyYOcrj
         CEcez0LyMlxHZQtFT7G8koRRDJFpBndccEZfjoLSRBth45j7rXePdV+CUybKHRMBghOI
         b5v0DEqk2Hotn1ovN/R2MhpBqDN0AJRd0vkYmnFwdKalZtd9Etzszbgz5+OKqKbX4TIm
         zPXOFbk7qbLOJLtfU2VAJPVbrC4ziSTMSrJ0l/AGXuT1fmR666VOZ7vowy2LQjoirVZp
         E1YVEOAjciQ1VvFj8+knYUQw9OqCUq+IX8Z983uxGuoSy4pPyQdYSfuLi6LWHNBsBA1T
         iWFA==
X-Gm-Message-State: ANoB5pn73LweeL1w/1Qkz7i6byrcZfELh/LVSLTuyHQ4XTyACeJOncnl
        +KWffpSbGoGANRW/VeZdslY=
X-Google-Smtp-Source: AA0mqf6jouf+KgJGa/dHztcF3ByX4zhLiwA6QV1oVepCq86SFD9tdHuC93GSpciMjrxiMkd3O6xwOw==
X-Received: by 2002:a05:6512:2202:b0:4a2:34d5:9929 with SMTP id h2-20020a056512220200b004a234d59929mr660434lfu.31.1668164691423;
        Fri, 11 Nov 2022 03:04:51 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a3-20020a2e8303000000b002770e531535sm347193ljh.55.2022.11.11.03.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:04:50 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:04:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        caihuoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH v6 11/20] dt-bindings: PCI: dwc: Add clocks/resets common
 properties
Message-ID: <20221111110448.oiekd5rzewhvhogv@mobilestation>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
 <20221107204934.32655-12-Sergey.Semin@baikalelectronics.ru>
 <166811541565.1069420.11032822569415159193.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166811541565.1069420.11032822569415159193.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 03:23:37PM -0600, Rob Herring wrote:
> 
> On Mon, 07 Nov 2022 23:49:25 +0300, Serge Semin wrote:
> > DW PCIe RP/EP reference manuals explicit define all the clocks and reset
> > requirements in [1] and [2]. Seeing the DW PCIe vendor-specific
> > DT-bindings have already started assigning random names to the same set of
> > the clocks and resets lines, let's define a generic names sets and add
> > them to the DW PCIe common DT-schema.
> > 
> > Note since there are DW PCI-based vendor-specific DT-bindings with the
> > custom names assigned to the same clocks and resets resources we have no
> > much choice but to add them to the generic DT-schemas in order to have the
> > schemas being applicable for such devices. These names are marked as
> > vendor-specific and should be avoided being used in new bindings in favor
> > of the generic names.
> > 
> > [1] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
> > Root Port, Version 5.40a, March 2019, p.55 - 78.
> > [2] Synopsys DesignWare Cores PCI Express Controller Databook - DWC PCIe
> > Endpoint, Version 5.40a, March 2019, p.58 - 81.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch unpinned from the next one:
> >   https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
> >   by the Rob' request. (@Rob)
> > - Drop synonymous from the names list since the device schemas create
> >   their own enumerations anyway.
> > 
> > Changelog v5:
> > - Add platform-specific clock/reset names, but mark them as deprecated.
> > 
> > Changelog v6:
> > - Move the common *-names definitions to the RP/EP schemas. Thus drop
> >   the 'definitions' property. (@Rob)
> > - Drop the 'deprecated' keywords from the vendor-specific names. (@Rob)
> > ---
> >  .../bindings/pci/snps,dw-pcie-common.yaml     | 120 ++++++++++++++++++
> >  .../bindings/pci/snps,dw-pcie-ep.yaml         |   6 +
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 -
> >  3 files changed, 126 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Yahoo! We've finally done this) Thanks.

-Sergey
