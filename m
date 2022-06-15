Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052054CF02
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiFOQrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbiFOQru (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:47:50 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0BE18B3E;
        Wed, 15 Jun 2022 09:47:48 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id c189so1986345iof.3;
        Wed, 15 Jun 2022 09:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xyk/QyCaSSsOxFO6IW3EiZcp9+p5SxGXZQgbLaM6mqk=;
        b=V7iNUVWioUTh9LDa+udTreq+vATunIRC8nFKFr0rfT22ayoB6n9dS253bNZGEIj3pI
         SiGbjYKVYqjAN+DkZ32d1NgIIIBLMyLHQ+imOt2sDJgr3J6bnQIE7OJFNvWqMWuahBpt
         k6mez+AL6qqe+qLWZGPiSzFQRRKqd09eNlRNiuW0TXT77Wd3Cz3ujhMe8T30ecyijmUq
         A5mfEQo17ePLMdrrllip62GTPUaG1GYD/Wkfm3yVED7sYl6tFWuNJa3fLEH4YQqwtTro
         yNOdt4Tyz6qrgqubZKdYfE9gyL/SXLwc23FICzNWxxZKafxENZe7IJV9FWaYrwopwdCC
         AkqA==
X-Gm-Message-State: AJIora9QJaei0j1DOiGjuSGTgxw9yMylyLQk1tEuGVsUX71sRJZgg2ZA
        LROecWnVOoVBRmdu2qb0/Q==
X-Google-Smtp-Source: AGRyM1sCW44BCXNC9lQ6s0yr95rAyq8XGTYhY8nUvUJi+xOc9mFNPgf/1W2PQXiv5ZV/4hco+kqgHw==
X-Received: by 2002:a5d:850f:0:b0:660:92e:5edc with SMTP id q15-20020a5d850f000000b00660092e5edcmr305463ion.187.1655311668154;
        Wed, 15 Jun 2022 09:47:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l12-20020a056e0205cc00b002d1ed1f6082sm7030081ils.44.2022.06.15.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:47:47 -0700 (PDT)
Received: (nullmailer pid 1424079 invoked by uid 1000);
        Wed, 15 Jun 2022 16:47:45 -0000
Date:   Wed, 15 Jun 2022 10:47:45 -0600
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/17] PCI: dwc: Combine iATU detection procedures
Message-ID: <20220615164745.GC1413880-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-16-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:57:03AM +0300, Serge Semin wrote:
> Since the iATU CSR region is now retrieved in the DW PCIe resources getter
> there is no much benefits in the iATU detection procedures splitting up.
> Therefore let's join the iATU unroll/viewport detection procedure with the
> rest of the iATU parameters detection code. The resultant method will be
> as coherent as before, while the redundant functions will be eliminated
> thus producing more readable code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v3:
> - This is a new patch created on v3 lap of the series.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 39 +++++---------------
>  1 file changed, 10 insertions(+), 29 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
