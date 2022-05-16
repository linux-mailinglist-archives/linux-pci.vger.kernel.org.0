Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77052903D
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiEPUkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 16:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349511AbiEPUij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 16:38:39 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B8A50468;
        Mon, 16 May 2022 13:18:50 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id l16so20025809oil.6;
        Mon, 16 May 2022 13:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQwPmeMbnyVUc/1zZOzdiaGv8oZUwRX2AH24X74Xh80=;
        b=A2x3lV8LGGh+z8ow3JABCYcrBFA6nrOPr8VI6T4UWrYBLobYhEsBxKh5lZlIWTlnBO
         stvTidEPCOg7tDZcKLuL4WY60/lbMdMddj0NHAedYVngwspZwecYtUjj3hrKZzFI2bU1
         E6CAxHo5d+X9CdwF20uK1z7co4klBOF88wEWwTsuUnZyzq3WCcIvzwOMpaZEMxRvj64X
         QtXHO7z7s1CY0lggw40nO6F3RAR2e9USWFPNwuHtglC7XppufjI2ozZe0Rnvv0xiG6gC
         qAv33VEROw0yjO9SsJ9mmwTmh0uEGFp5Dzkr/pHAq7UnN3Tutritnm9HYDS4e/dh89qd
         JXxw==
X-Gm-Message-State: AOAM531AlB5V7KcIl0r3qWxjK8Z5WIpSJu8JoUNPiv/mz7cjY2fH7NJL
        JI4E3yLOpdKhfjyY1am43w==
X-Google-Smtp-Source: ABdhPJxGMHHQtH6AccwOnAsP6opHqwuWr/lJDRPnbbFvlzXjbgT84u7Y4pK+INnmxljHHJb3NaIqug==
X-Received: by 2002:a05:6808:130b:b0:326:d1ff:b56f with SMTP id y11-20020a056808130b00b00326d1ffb56fmr13702343oiv.222.1652732329632;
        Mon, 16 May 2022 13:18:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6212000000b0060603221260sm4331069otj.48.2022.05.16.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:18:49 -0700 (PDT)
Received: (nullmailer pid 3205772 invoked by uid 1000);
        Mon, 16 May 2022 20:18:47 -0000
Date:   Mon, 16 May 2022 15:18:47 -0500
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
Subject: Re: [PATCH v2 03/17] PCI: dwc: Add more verbose link-up message
Message-ID: <20220516201847.GB3073005-robh@kernel.org>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503214638.1895-4-Sergey.Semin@baikalelectronics.ru>
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

On Wed, May 04, 2022 at 12:46:24AM +0300, Serge Semin wrote:
> Printing just "link up" isn't that much informative especially when it
> comes to working with the PCI Express bus. Even if the link is up, due to
> multiple reasons the bus performance can degrade to slower speeds or to
> narrower width than both Root Port and its partner is capable of. In that
> case it would be handy to know the link specifications as early as
> possible. So let's add a more verbose message to the busy-wait link-state
> method, which will contain the link speed generation and the PCIe bus
> width in case if the link up state is discovered. Otherwise an error will
> be printed to the system log.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Test the error condition first and return straight away if it comes true.
>   The typical return is better to be unindented (@Joe).
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 22 ++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
