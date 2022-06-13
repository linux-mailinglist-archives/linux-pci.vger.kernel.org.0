Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09A54A07B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiFMU4Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbiFMUzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:55:11 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93326D1;
        Mon, 13 Jun 2022 13:26:18 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so5145620otg.3;
        Mon, 13 Jun 2022 13:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xjJ+L/03WddGCEAsgz/Lrlk2Q+t7sJ2y1Km8PFwfoNk=;
        b=BPKAJiBhGJ9YDRskcrKFBXNeppoBCV2oo77qkgz/vMWN0LfhgskSOifBfQOgBkN2OF
         Xeq8lQjdqmCREqu/c/Kad+j+J3NC8H7OSOc+DUDYg+v/LJDUOXrQ4kngcsIl5NZvTmTn
         je5/vI+B5KSdzB+g2RSoAxFxmnsKG7uh0SjRsH96NhtZe54/22DbEMfTchfHFRANUyr9
         98r5QkUXFoJh+UL4szXa+iQGpAnlZxsy0LTcHQpopcpIq6wHojpdxSoUfQ51CJIorohv
         g6qbMjDI1Ca72cui6iSvkNSiiAP/Ml8q5n66mzL4hL0NqE/6zvguZec3ZC6liJFSsdu2
         0OFg==
X-Gm-Message-State: AOAM532zTWX7vJ5KiXeJaRzBp8t7/PkZijnvtANv2H7H9YTQ1DQYbRUf
        mEdcMJyARtSGlo9aRMH58A==
X-Google-Smtp-Source: ABdhPJyyNGQE5OWlwWOsRGyl+ERnbWUW9m7Hm8qg29Snv2swD4+4Noswgzb+z8m3p/9w1nAI1gVr1w==
X-Received: by 2002:a05:6830:1d57:b0:60c:1ebc:b4b1 with SMTP id p23-20020a0568301d5700b0060c1ebcb4b1mr663010oth.255.1655151977380;
        Mon, 13 Jun 2022 13:26:17 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id i9-20020a9d6249000000b0060c54271f68sm3130029otk.23.2022.06.13.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:26:17 -0700 (PDT)
Received: (nullmailer pid 26367 invoked by uid 1000);
        Mon, 13 Jun 2022 20:26:11 -0000
Date:   Mon, 13 Jun 2022 14:26:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/18] PCI: dwc: Organize local variables usage
Message-ID: <20220613202611.GG4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-12-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:27AM +0300, Serge Semin wrote:
> There are several places in the common DW PCIe code with incoherent local
> variables usage: a variable is defined and initialized with a structure
> field, but the structure pointer is de-referenced to access that field
> anyway; the local variable is defined and initialized but either used just
> once or not used afterwards in the main part of the subsequent method.
> It's mainly concerns the pcie_port.dev field. Let's fix that in the
> relevant places.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 +++++++-------
>  drivers/pci/controller/dwc/pcie-designware.c      |  8 +++-----
>  2 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
