Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478054A0DD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiFMVJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351828AbiFMVHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:07:15 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD96101F3;
        Mon, 13 Jun 2022 13:45:17 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id n11so7378142iod.4;
        Mon, 13 Jun 2022 13:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s24PQDzjRFCCWmnRmYW7secnNUQR1a1bKNZuPeWWIn0=;
        b=uBmlzIWrAFPQZ9BcWWo5u2Cu5OElVnpj5zTodYoRNjmr3XRRCbSedYEqvnuSd8/Ih5
         IcGRPa8QsV0OGKgdJ5hqoEHPkQw8jeckpNs4fiCU8gJLpplvsQ+sflZZnq+8I+RQPex8
         MfOZC0PsGPSkWPC6JLrMu+kHJhOtKSHBny1ZQ3+io62UzgBpP2KkvbejTk1W0/Ffu+mf
         5nlUYVWSzVYpHDTF1j9OYbR64+dDVPixccTJzjkaGFS1r+KPdOu5Hk4KhM65qDT8lhPc
         8wR2K0k8CqdqkfzXmEh03+xK/wI2mALJ952WdbOqDPtLbJU0EvxLi4/hon6Eg+/zWcvi
         V8zA==
X-Gm-Message-State: AOAM531ocZjbPOQKf+yHe4Pc+zaRL6vYK4WYe0Uk/YZhmglUSmUrTVxV
        YgTxScdcDbYNBHKAL9hPBg==
X-Google-Smtp-Source: ABdhPJx0U+5+Ad/jwJCrXkr303VHbawoRyO2dk6Q9O4Y26ZGoCeSZifjQRwIUxh6X9gwmG+0Kedy/Q==
X-Received: by 2002:a05:6602:2d81:b0:669:d880:1581 with SMTP id k1-20020a0566022d8100b00669d8801581mr747239iow.133.1655153116912;
        Mon, 13 Jun 2022 13:45:16 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id l12-20020a92280c000000b002d19bb6082fsm4405943ilf.43.2022.06.13.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:45:16 -0700 (PDT)
Received: (nullmailer pid 51674 invoked by uid 1000);
        Mon, 13 Jun 2022 20:45:15 -0000
Date:   Mon, 13 Jun 2022 14:45:15 -0600
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
Subject: Re: [PATCH v4 17/18] PCI: dwc-plat: Discard unused regmap pointer
Message-ID: <20220613204515.GE28636-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-18-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:33AM +0300, Serge Semin wrote:
> The regmap pointer was added into the dw_plat_pcie structure in
> commit 1d906b22076e ("PCI: dwc: Add support for EP mode"), but it hasn't
> been utilized neither in the code submitted in the denoted so far nor in
> the platform driver evolving afterwards. Drop it then for good.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
