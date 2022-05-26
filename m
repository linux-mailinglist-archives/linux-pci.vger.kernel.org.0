Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB310535322
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 20:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiEZSKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiEZSKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 14:10:00 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0ADAF1C2;
        Thu, 26 May 2022 11:09:58 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-f2cbceefb8so3077595fac.11;
        Thu, 26 May 2022 11:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4YB+kQiJXBKUP7agdWevfRvbh3ysPyiKc3h+uOJrr30=;
        b=m6FlulSVMbJIokdyY7BkIjIWSjoulzLMI12fL+s87otTdtbVXgo6ZG7Fa9bst8pkxU
         3ugXVwh9J9PwxXRWVlJiHoZImHCjcrqYfxsOn6BK1SKDaz82VGruZrnqPdofGafRo6G4
         R/311Vdf/W5s/Y/jKERV7Tlxsy5ZBff0FEjpJjgfEu3gv8UERkY7zR/rLBAqRZCMl7ti
         PQLmfIC8DkuYyNOQBa7faB59ieFK0utkpJL5DwJKWCp5VnslV/vScWJquDkROAANDW6P
         tiqYfNx0/SPwZ3Bp7R4QsRhrXmzMVV5+Lcac+OSinyhaL1VzEQswXZK0AEzS/I2pFi1Q
         0iag==
X-Gm-Message-State: AOAM531tcuFg97vAAqbsvF3yEjERArUJ1iDHjsSSJspz/6LXmFLJrZpm
        8ZfXi6rEj5Y8Akexde0E3A==
X-Google-Smtp-Source: ABdhPJy+aqv9dLlqDpwsWWTrsp3aQXkLGZiF+XvO7PDRnouiQjrgiJu9nn4EHNdgdKR5BzDL81LOwQ==
X-Received: by 2002:a05:6870:c5aa:b0:e5:8e03:d40f with SMTP id ba42-20020a056870c5aa00b000e58e03d40fmr2013869oab.264.1653588597896;
        Thu, 26 May 2022 11:09:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a5-20020a9d5c85000000b0060603221274sm846684oti.68.2022.05.26.11.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:09:57 -0700 (PDT)
Received: (nullmailer pid 78956 invoked by uid 1000);
        Thu, 26 May 2022 18:09:55 -0000
Date:   Thu, 26 May 2022 13:09:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 4/8] PCI: dwc: split MSI IRQ parsing/allocation to a
 separate function
Message-ID: <20220526180955.GC54904-robh@kernel.org>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-5-dmitry.baryshkov@linaro.org>
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

On Mon, May 23, 2022 at 09:18:32PM +0300, Dmitry Baryshkov wrote:
> Split handling of MSI host IRQs to a separate dw_pcie_msi_host_init()
> function. The code is complex enough to warrant a separate function.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 98 +++++++++++--------
>  1 file changed, 56 insertions(+), 42 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Note that we should probably apply this[1] or whatever fix we end up 
with first.

Rob

[1] https://lore.kernel.org/all/20220525223316.388490-1-willmcvicker@google.com/
