Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5F54A0D4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiFMVHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351805AbiFMVGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:06:55 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581D8B8D;
        Mon, 13 Jun 2022 13:44:37 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id r3so5149438ilt.8;
        Mon, 13 Jun 2022 13:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StAcLIjCh0njXEnXcEA4NWN6L/qr4LrDHVx4iVNASTs=;
        b=lDs3Xu84Y2SM+nF+XzRMGDfNQSKUzyArljlkoukU/9XLfc086Aq//XCe6HOzAf8vmI
         U13gSVOTaiPslfZ0VHpT4fwfOou8wCg6v2gmCc0u3Z2cim6RsRNBLup+pHS/QZyj8Qh8
         xDJFDxWDdf9S1U2EHp5chzqHXebs8f77Nd4KvLteCFm2M1uQCF/OZFA8g+QogLEXNs0+
         Zo2YUsBxThiGoxicN5Kll3KadIkAqA1WNvpOruiSkBl43IghFu5fovu82e4tvy761IF/
         cjVAKgm7C64g6C51EYEGWiS+Z0RQmcPgmzonLDnPjmRtNhcXwbc6c7JawbVxMtp+IF72
         1jGA==
X-Gm-Message-State: AJIora/RGr86h8v/CN/wWumKxz+4aQjl0nopqQWOmC638geJsoWG1bEQ
        8+ZsNMWRK5DdDr/z1RZTlg==
X-Google-Smtp-Source: AGRyM1sOzn9leFju6WEww6rLj1DsIiincCJ7IemtY1yaCr6G0UCu9/rn80VeLpthy4Ts8OlZCcC15Q==
X-Received: by 2002:a05:6e02:1bef:b0:2d3:c3d5:823d with SMTP id y15-20020a056e021bef00b002d3c3d5823dmr948272ilv.2.1655153076667;
        Mon, 13 Jun 2022 13:44:36 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id z3-20020a029383000000b0032ec5c47c17sm3891269jah.46.2022.06.13.13.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:44:36 -0700 (PDT)
Received: (nullmailer pid 50617 invoked by uid 1000);
        Mon, 13 Jun 2022 20:44:35 -0000
Date:   Mon, 13 Jun 2022 14:44:35 -0600
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
Subject: Re: [PATCH v4 16/18] PCI: dwc-plat: Simplify the probe method return
 value handling
Message-ID: <20220613204435.GD28636-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-17-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-17-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:32AM +0300, Serge Semin wrote:
> The whole switch-case-logic implemented in the DWC PCIe RC/EP probe
> procedure doesn't seem well thought through. First of all the ret variable
> is unused in the EP-case and is only partly involved in the RC-case of the
> switch-case statement, which unnecessary complicates the code. Secondly
> the probe method will return zero if an unknown mode is detected. That is
> improbable situation since the OF-device data is initialized only with
> valid modes, but such code is still wrong at least from maintainability
> point of view. So let's convert the switch-case part of the probe function
> to being more coherent. We suggest to use the local ret variable to
> preserve the status of the case-clauses and return its value from the
> probe procedure after the work is done.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
