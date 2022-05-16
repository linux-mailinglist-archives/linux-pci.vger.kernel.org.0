Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BC529272
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbiEPVIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349309AbiEPVHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:07:40 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54849914;
        Mon, 16 May 2022 13:48:30 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id m25so20114851oih.2;
        Mon, 16 May 2022 13:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4B+S5pFtmWEETp4JA5C+fFz+X0jWyKLR/MvdqaxOlMc=;
        b=cXLD9PR7RxFoh8mhEwM3+808s0+dbWe0m1Y49b/ExAB3FOzCXeQkgKSXExC/a9IfgZ
         tNDrWRG6XECoh234dmRRxiVJ4y8QFXqqpsy2FdnS1PUSekBaqppdlYs4y6nqLOP1BdTY
         +n5Y6SOmOxxNJslVMGFgywF9a9DzlAMEtR6eUp0aNkBSmSvK8FCKjeNWXN6JMpFmuToW
         nzBW2OJ4bn3yimPbzrsFWxyBxocSDFfKwVN6+5NxZRtWX8JHE0Xw7Inua5mXaOV1Qwr4
         LIWO5BTGh0EbWfksvsfyE7D2vzOMUemNUK3pgf0anqq6kC+u0BY+gzujLMwosNdahgXe
         le5g==
X-Gm-Message-State: AOAM5332NWAbT5ph97ARRFukFL8Um8ODuL12+DLrKXKQ0sw3aVuDiIXs
        h9Hfue3qT9tzUDwcbSqHVw==
X-Google-Smtp-Source: ABdhPJzajriBb9btty50/SrjCPFYwS4f/6a4+aD5RsLOF7cPJAs2ZVSIcj2DhBYq0d5v/zMdK/NRLw==
X-Received: by 2002:a05:6808:2004:b0:326:7f22:624e with SMTP id q4-20020a056808200400b003267f22624emr13755044oiw.180.1652734109872;
        Mon, 16 May 2022 13:48:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s186-20020aca45c3000000b00325cda1ff8asm4201224oia.9.2022.05.16.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:48:29 -0700 (PDT)
Received: (nullmailer pid 3257344 invoked by uid 1000);
        Mon, 16 May 2022 20:48:28 -0000
Date:   Mon, 16 May 2022 15:48:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/17] PCI: dwc: Add host de-initialization callback
Message-ID: <20220516204828.GF3209795-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-9-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:29AM +0300, Serge Semin wrote:
> Seeing the platform-specific DW PCIe host-initialization is performed from
> within the generic dw_pcie_host_init() method by means of the dedicated
> dw_pcie_ops.host_init() callback, there must be declared an antagonist
> which would perform the corresponding cleanups. Let's add such callback
> then. It will be called in the dw_pcie_host_deinit() method and in the
> cleanup-on-error path in the dw_pcie_host_init() function.

I'm not really a fan of .host_init() to begin with as it isn't really 
clear by the name when it is supposed to be called and what init to do. 
The drv probe -> dw_pcie_host_init -> drv .host_init() -> return to drv 
sequence isn't great either. I'd rather see more fine grained and well 
defined hooks. So I'm hesitant to add a host_deinit()...

Rob
