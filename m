Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2E454A0C9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348593AbiFMVFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352630AbiFMVEb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:04:31 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A33981A;
        Mon, 13 Jun 2022 13:39:51 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id y79so7375187iof.2;
        Mon, 13 Jun 2022 13:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jfed8WHo8TWNvxCiSvI5rcyrYQLVvZOkDmByiHpwcb4=;
        b=R/y71E7QOY6woE382+bK9glJduIZ41l7A6wrwXeq6fpfqICgtjIWPLB48KyjA2UGxO
         RWzVXV4soUsBDINcnPrt2lIVmYmAfbsu54YrLvL5cWvMlHLICdkJIN2QiL11CWxe+zfk
         fUMcuhBE/JkMYVF2HGpEoWu2SpWND/ZRT9tvrEIobltZMO+1uDdEUsiRw9tAeLnMtT7j
         OeMllGfoapaK0ro129uzfm04dzJZXxGBKcW0C/cxi/9kpu7odVPrmxE13yQhHwm0FKJu
         1bGpMEtcT97KrZuI7gxsowfPCzFi+1fI8FI4hyJXe4uc7zCKBY9HhTdqQC69SY94bJe0
         OkWA==
X-Gm-Message-State: AOAM5302xIxFIF0mB4V4JSr+FOtdpHM1aVvKf/yXY+A5wQy4KvboWV3o
        LJ8DS2a/quoPQIHgoo7NPw==
X-Google-Smtp-Source: ABdhPJx7nR5T7M0L4hzZ6y5vQUaF5sNik9SF5ruUtWjDfNKqK4EuWnDm5nKY2r7qbgu01ui2ucAQoQ==
X-Received: by 2002:a6b:6003:0:b0:668:160b:db94 with SMTP id r3-20020a6b6003000000b00668160bdb94mr769352iog.204.1655152790868;
        Mon, 13 Jun 2022 13:39:50 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id c9-20020a023f49000000b0033156d6016asm3939471jaf.91.2022.06.13.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:39:50 -0700 (PDT)
Received: (nullmailer pid 42858 invoked by uid 1000);
        Mon, 13 Jun 2022 20:39:49 -0000
Date:   Mon, 13 Jun 2022 14:39:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 13/18] PCI: dwc: Add start_link/stop_link inliners
Message-ID: <20220613203949.GB28636-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-14-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:29AM +0300, Serge Semin wrote:
> There are several places in the generic DW PCIe code where the
> platform-specific PCIe link start/stop methods are called after making
> sure the ops handler and the callbacks are specified. Instead of repeating
> the same pattern over and over let's define the static-inline methods in
> the DW PCIe header file and use them in the relevant parts of the driver.
> 
> Note returning a negative error from the EP link start procedure if the
> start_link pointer isn't specified doesn't really make much sense since it
> perfectly normal to have such platform. Moreover even pci_epc_start()
> doesn't fail if no epc->ops->start callback is spotted. As a side-effect
> of this modification we can set the generic DW PCIe and Layerscape EP
> platform drivers free from the empty start_link callbacks and as such
> entirely dummy dw_pcie_ops instances.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v4:
> - This is a new patch created on the v4 lap of the series.
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 12 ------------
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 ++------
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++------
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 10 ----------
>  drivers/pci/controller/dwc/pcie-designware.h      | 14 ++++++++++++++
>  5 files changed, 20 insertions(+), 34 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
