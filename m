Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6360B54A086
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349913AbiFMU4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349028AbiFMUzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:55:48 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85892BA;
        Mon, 13 Jun 2022 13:28:37 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-fe51318ccfso10002325fac.0;
        Mon, 13 Jun 2022 13:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+MycQEHVLS0G3Jp47J4dPsMXopl+aBAELiT0jx3BxM=;
        b=y4wc3MZS3lXg4/ZTsle84DEZOq5pRu+BI/FI7ahMbz6Sg3g7HYzL++6qGONkPSMSCh
         owhNYRs0vyTy5k/a9+ZR9+cOc6ECZ/kAaIF6j38VcpKED+Tc3cvqZJhjiM+OxcrFuALQ
         XA1NQgPvW32RsbN1vqFdOJdTSvL7cEhRB3tADgGFtJQ9XQJatrNj3burFJkAakg1+myt
         tBFJHVnEHBA8+n/SOPI8Ypy6i+WKavlAK9+OSiKZiaeHQWLEoa6IKLVhNWlww+jHzVLG
         0ne+K01JWAfn50NQInye8pk5/x/J2CrW+nkuLTMKQx2wvTOzQ11r+jrY/dM4uc56yT3o
         fOIg==
X-Gm-Message-State: AJIora/19chDhdinKyTNz8ble6vE1FaAWx8DSivdMb27dgzkvzWNFxQt
        IjMkvf7FrGQ4B1jamUmdvg==
X-Google-Smtp-Source: AGRyM1tvwC9bduY8bxzqWREuAHNwiFAwzpSzRs1ILRb1JzaAGZb+YH0O1A7QOk6i0DmNy9eU8s/frA==
X-Received: by 2002:a05:6870:46a6:b0:f5:ecd6:befb with SMTP id a38-20020a05687046a600b000f5ecd6befbmr331021oap.57.1655152116990;
        Mon, 13 Jun 2022 13:28:36 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ada48000000b0035eb4e5a6d6sm4057166oou.44.2022.06.13.13.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:28:36 -0700 (PDT)
Received: (nullmailer pid 30275 invoked by uid 1000);
        Mon, 13 Jun 2022 20:28:32 -0000
Date:   Mon, 13 Jun 2022 14:28:32 -0600
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
Subject: Re: [PATCH v4 12/18] PCI: dwc: Re-use local pointer to the resource
 data
Message-ID: <20220613202832.GA28636-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-13-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:28AM +0300, Serge Semin wrote:
> The dw_pcie_host_init() method has two instances of the resource structure
> pointers used in non-related places of the method. It's pointless to have
> two different local storages for them since the corresponding code is
> small and having resource specific names doesn't make it more readable.
> Let's convert these parts of the function to using just a common pointer
> to the resource structure instance. That shall make the code a bit nicer
> looking.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
