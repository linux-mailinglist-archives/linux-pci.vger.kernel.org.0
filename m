Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EB34E6A15
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353862AbiCXVFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 17:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353882AbiCXVFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 17:05:48 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957E99D4DB;
        Thu, 24 Mar 2022 14:04:16 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id e189so6175333oia.8;
        Thu, 24 Mar 2022 14:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QwE0l0Di9czJLn9RSeTlxzvPzQRFACDPyPmoojChbjk=;
        b=apIHNrGqydmF6YBS01DsU7XhWNQLOvUCgfO6dPE9gak4iPUJaf676pUJE4Qrr40XI1
         kODALnZM7SAAAs9LAP/54OEhig7bQ0Yu/M1jywDxrjsBXpgYcediP683TeOVXlmO9KSZ
         TFQw9k+9wQv0RWTPj1o7ViZrqClS8XAjdtnHUYXdLHYlA/WK+cHSmq5oKAlCT6foFw4I
         shMYddqL5zAW8Tw3swXjMjIK/I3EreiuUJgrw5urjaOid02taL03AiMdZg0zbauJtqSe
         yhbadDFDPN02A1XSrStd+xVgGXkYW1hn7TPyPdYp+mtAapAhDZjWMas9R9Q6O2wMDtw1
         KRgQ==
X-Gm-Message-State: AOAM5307vTl9TJfQtOgAY97jJV/QQPONFriTQV5lAHdY4o6RTZDe4kz1
        +alEzNLO4uQMHaQMAdMsxmhpQzoi0w==
X-Google-Smtp-Source: ABdhPJwp4zD+dsz4UF3dn8rC+v4s5pkDAlQb2fjRaMWWt6T+3Zn13ChMVMoVsUKgdDOuoEOtU5BH2g==
X-Received: by 2002:a05:6808:11cd:b0:2d5:3f90:b9e with SMTP id p13-20020a05680811cd00b002d53f900b9emr3462595oiv.113.1648155855909;
        Thu, 24 Mar 2022 14:04:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p8-20020a0568301cc800b005b2259500e2sm1830857otg.25.2022.03.24.14.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:04:15 -0700 (PDT)
Received: (nullmailer pid 2570475 invoked by uid 1000);
        Thu, 24 Mar 2022 21:04:14 -0000
Date:   Thu, 24 Mar 2022 16:04:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiantao Zhang <water.zhangjiantao@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangjianrong (E)" <zhangjianrong5@huawei.com>,
        caiyadong <caiyadong@huawei.com>,
        "xuetao (kirin)" <xuetao09@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>, songxiaowei@hisilicon.com,
        guhengsheng@hisilicon.com
Subject: Re: [PATCH v2] PCI: dwc: Fix setting error return on MSI DMA mapping
 failure
Message-ID: <Yjzczp4SX3CPdKM8@robh.at.kernel.org>
References: <CAL_JsqJNMGobo1iaBjqSQJXNy9arXGU+et20dMueCK44seGnQw@mail.gmail.com>
 <30170911-0e2f-98ce-9266-70465b9073e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30170911-0e2f-98ce-9266-70465b9073e5@huawei.com>
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

On Wed, Mar 09, 2022 at 08:01:04PM +0800, Jiantao Zhang wrote:
> When dma_mapping_error() returns error because of no enough memory,
> but dw_pcie_host_init() returns success, which will mislead the callers.
> 
> Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
> Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
