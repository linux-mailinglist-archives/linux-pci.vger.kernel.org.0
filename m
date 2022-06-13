Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B363A54A04E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351051AbiFMUyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352330AbiFMUyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:54:25 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E412AE2E;
        Mon, 13 Jun 2022 13:23:03 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id h187so9102394oif.4;
        Mon, 13 Jun 2022 13:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWsit0XtntT6J2RTRZ0ujYWmdRDTbMZCbVmpGrfCYhA=;
        b=DrGzYq5D9Y2CcEeM9Bd5UjW9DU11eGCY1W7+VI4JU2LyajBxb/5/JtUN1lT8z+QMUg
         FveTy5nLgT5QNfemLV9Bx5PqsLqKesflDx7D1yzMw+P9W31CZxt6TH7qcdpqunEquvbM
         192aDNy1EW1FWJmtsoHit0rRI+UnXHcJHH37mG4Mb9Yqc54ZBbYWMd1b9ot1HpMZU++X
         rQfGH0YSdwX/qKzVIARuruKvVwZUn1hTCIQ4zlIiRzIkmqo5io+WOV51VLhoj2XIqlaK
         qiHhcUiwzTdnsM56n097+hnSTcKkElH1oBuXUvbYQHhdOT4PF11nbNr1dGtXeAVGHlEL
         HoDQ==
X-Gm-Message-State: AOAM532kgN9CnIiKntm9V3/eEYkfvwrIyTbpk5Em4gvP4fmy3h3ACHPy
        uCsw0Wjh3JcgyccOrbzu/g==
X-Google-Smtp-Source: ABdhPJzo2BcmC/VIfVQzsrFJ8doyeGKwKmqH/pmvy+HKvx0w6Zh7cJYQumivPmCaX4tpdaBO6WF6gQ==
X-Received: by 2002:a05:6808:11c7:b0:2f9:f96c:d0ee with SMTP id p7-20020a05680811c700b002f9f96cd0eemr266770oiv.134.1655151782945;
        Mon, 13 Jun 2022 13:23:02 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:20d2:bb97:4381:7341:60ed:a4a1])
        by smtp.gmail.com with ESMTPSA id go13-20020a056870da0d00b000f324b1e645sm4504754oab.22.2022.06.13.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:23:02 -0700 (PDT)
Received: (nullmailer pid 453 invoked by uid 1000);
        Mon, 13 Jun 2022 20:10:43 -0000
Date:   Mon, 13 Jun 2022 14:10:43 -0600
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
Subject: Re: [PATCH v4 07/18] PCI: dwc: Add braces to the multi-line if-else
 statements
Message-ID: <20220613201043.GC4188875-robh@kernel.org>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
 <20220610082535.12802-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610082535.12802-8-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:25:23AM +0300, Serge Semin wrote:
> In accordance with [1] if there is at least one multi-line if-else
> clause in the statement, then each clause will need to be surrounded by
> the braces. The driver code violates that coding style rule in a few
> places. Let's fix it.
> 
> [1] Documentation/process/coding-style.rst
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c    | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
