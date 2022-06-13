Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162754A0E0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351850AbiFMVJb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352239AbiFMVI4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:08:56 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F95C10A1;
        Mon, 13 Jun 2022 13:45:59 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id p128so7409776iof.1;
        Mon, 13 Jun 2022 13:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJmWCNP0ladMRpePzPpUxguk9fysv2R62U4XUuwjs68=;
        b=AJvErssO79/l+RjyDwZGtqwUh5ETjJkWDCMnPel97S3gL7lUfKp9Gob1S7MhpbDeXW
         1pYKc/1oL3JbvxMAwLk8KOwBu42rpOiHoZJd1wf9XmLLDG4EpQV0sQfyJDgDvQIn3fq6
         o83CBmoJanlAN2rxbQacQAldDB3Ow1DFw3aRj8RrV5dwxqU3CgMYfx6K6hrOG+niFeFq
         nmZcsRaD3HsORAkAi5/HUnTBnv7ktgVlNQGjop4JUwHuxKFGGj8v9ItaLWVN1GVSZ3EJ
         zcMq7Vqx3DQum3JY/npPwT7aBeZlMAVjJwjI5WVBIxOYtfH8lH4zIGT3S+xZWu1mnhuE
         0pOw==
X-Gm-Message-State: AOAM530EArbH9K7lHlIiSAufPrqkW4vz2fbXFwhMfgFcp144X0n1k6Qo
        q4Ny94mM+co9nulltlh9Hg==
X-Google-Smtp-Source: ABdhPJzN2cviFaeRfw2llYui3KQhoD+yFBrfaCJJggQU3sz4qrPqnXYwf9eL+x6lGkOPg0gTb/O17A==
X-Received: by 2002:a05:6638:22c7:b0:333:f684:ccc4 with SMTP id j7-20020a05663822c700b00333f684ccc4mr901380jat.57.1655153158823;
        Mon, 13 Jun 2022 13:45:58 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id u12-20020a6be30c000000b006694bc50b82sm4524719ioc.35.2022.06.13.13.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:45:58 -0700 (PDT)
Received: (nullmailer pid 52799 invoked by uid 1000);
        Mon, 13 Jun 2022 20:45:57 -0000
Date:   Mon, 13 Jun 2022 14:45:57 -0600
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
Subject: Re: [PATCH v4 18/18] PCI: dwc-plat: Drop dw_plat_pcie_of_match
 forward declaration
Message-ID: <20220613204557.GA52313-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-19-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-19-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:34AM +0300, Serge Semin wrote:
> The denoted forward declaration used to be required to get the OF-device
> ID structure by calling the of_match_device() method. The later method
> invocation has been replaced with the of_device_get_match_data() call in
> the commit 5c204204cf24 ("PCI: designware-plat: Prefer
> of_device_get_match_data()"). Thus the forward declaration of the
> OF-compatible device strings no longer needed. Drop it for good.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
