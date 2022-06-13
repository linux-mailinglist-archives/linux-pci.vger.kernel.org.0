Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7C54A06D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348080AbiFMUzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352277AbiFMUyU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:20 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B672A96C;
        Mon, 13 Jun 2022 13:22:42 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f2a4c51c45so9889752fac.9;
        Mon, 13 Jun 2022 13:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KWClgfWpgHG+VAivQTnsEGKmEl3BheN2a8JGL0usIbE=;
        b=x71qOj9Dke4QPwcNw8orbLy973iV1rsHM5hgNxApmrJE/i4zqPSuovyQfgGwXrez92
         vIUuhdtmJsTzg+E62m0ne8gaqzztvV/873LFliGnFSl3v/BXA7tqHPcu2d51XXgJsrSq
         QBvnQhFv3QcMm4p+yiqDwJCsCFohVaKnjTsh5zlDIuGuA2XkbL7rkzjscxxVVRUO4Qxo
         bUhNkh5bKU67BOBBgMYct6gzloSoISHCs8jw2PPJ4OzR5l6Fr2Or8ArdXyRMKEWwlGz1
         N4ammCOa0+VtSIcwdO5AwXR8s/MxwOzIZR8neJc7imCfynbEzanwWr8vhhBKqnJ0JhRh
         YN6A==
X-Gm-Message-State: AJIora8+ESIvvZBDexq29bmap3YIBSWFU5WfDkk92iYnmaPq7BnT/+sJ
        u848ni8oHHlBPSTDA4c6WuN1kQRUPQ==
X-Google-Smtp-Source: AGRyM1uYY8kwAc52zC+3YVt186Rqlx1c75177h/UvxedvgIBWt2vywhFxGucs6f9z45JMqELRcEFAQ==
X-Received: by 2002:a05:6870:c88a:b0:f2:8d92:318a with SMTP id er10-20020a056870c88a00b000f28d92318amr302337oab.281.1655151761607;
        Mon, 13 Jun 2022 13:22:41 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id a21-20020a4ad1d5000000b0035eb4e5a6b2sm4211689oos.8.2022.06.13.13.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:22:41 -0700 (PDT)
Received: (nullmailer pid 7891 invoked by uid 1000);
        Mon, 13 Jun 2022 20:15:01 -0000
Date:   Mon, 13 Jun 2022 14:15:01 -0600
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
Subject: Re: [PATCH v4 08/18] PCI: dwc: Add trailing new-line literals to the
 log messages
Message-ID: <20220613201501.GD4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-9-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:24AM +0300, Serge Semin wrote:
> There are two places in the DW PCIe controller driver, which omit the
> trailing newlines in the log info and warn messages. Not having them there
> will cause leaving the messages in the printk ring buffer until a next
> '\n'-terminated message is printed (it will consequently cause the buffer
> flush). As it isn't what the corresponding code implies let's add the
> new-line characters in the messages.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
