Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74954A048
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbiFMUyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352279AbiFMUyU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:20 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371D2872B;
        Mon, 13 Jun 2022 13:22:46 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id e67-20020a9d01c9000000b0060c221b1420so5170439ote.0;
        Mon, 13 Jun 2022 13:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kRE4DxNwjv4AxQ1uZcDHj0eGTvbkuAx+bI1tJP4tNF8=;
        b=rcLxtbJrvJMZkY9P+bsX20fp0p9WZQpoDe3FLc6Yue6smpNla3i+T22rL6FPzNhBJj
         +t4OM3C4i/JAU6kB2nDnPOcLJxbMnftpDQwoF4lTinJJ37AMpp6+PfcWT232DUbT/9C4
         cOzLMZdf23oJdrBs7Z1PFdqhNLBTKz1ZL5aA7Z82lEkPMoAN3nqg6t75t68hyK+C+TVa
         IXRXCP2JzvEA9dCdkaQEcaKysHF9kH40Z3zxMY3Xumda01CLItbiMoei9i9Ztv7hNf7k
         a182M3jomipMY0bom/DduEOhesNhnQ5T/UU1gZFGAJ3sy5C5eErk8F6t4KxR3UaLnqYL
         HlgQ==
X-Gm-Message-State: AOAM532WDyvAexcgBzQ3huvwh1pWsdbu7NzJtVl24d8FVjSKprBREVcF
        9FDFm7euAaVBR0zymF4LPw==
X-Google-Smtp-Source: ABdhPJwFCeHBhkZZ3wgWk/c0LFQGgWIk9LDpt9EhgErOdrn2Gq3/2kfSJ/kP1kY3/1Bhzk0Ie/1qmw==
X-Received: by 2002:a05:6830:3101:b0:60c:472b:7d44 with SMTP id b1-20020a056830310100b0060c472b7d44mr696526ots.139.1655151766157;
        Mon, 13 Jun 2022 13:22:46 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id d67-20020aca3646000000b0032f0fd7e1f8sm3647731oia.39.2022.06.13.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:45 -0700 (PDT)
Received: (nullmailer pid 4193325 invoked by uid 1000);
        Mon, 13 Jun 2022 20:09:58 -0000
Date:   Mon, 13 Jun 2022 14:09:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/18] PCI: dwc: Deallocate EPC memory on EP init error
Message-ID: <20220613200958.GB4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-6-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:21AM +0300, Serge Semin wrote:
> If the dw_pcie_ep_init() method fails to perform any action after the EPC
> memory is initialized and the MSI memory region is allocated, the later
> parts won't be undone thus causing the memory leak.  Let's fix that by
> introducing the cleanup-on-error path in the dw_pcie_ep_init() method,
> which will be taken should any consequent erroneous situation happens.
> 
> Fixes: 2fd0c9d966cc ("PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> ---
> 
> Changelog v2:
> - This is a new patch create as a result of the discussion in:
>   Link: https://lore.kernel.org/linux-pci/20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

