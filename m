Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6B563932
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGASeG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGASeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 14:34:05 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87833347;
        Fri,  1 Jul 2022 11:34:04 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id i17so1910323ils.12;
        Fri, 01 Jul 2022 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZoP9Y6JMHxvXYoZccJ+pHAP7qwF5tFNnm8l0CLPIew=;
        b=W83ZRbu2fWQsLn5adtgyDpURXbAP3Ahb0KUdqz6HhQYftHcMIC5YcC56YC1O6LDT7b
         cswm+YQws9l7JvoqqIa6edCf5W48HEDPaiy7PWPKyzoseTTHv5fO4fFClvJKVoHTQnWB
         XjMPHdU3B2i4UkSSWykREdbDnhDnHqRthufLCldk+WsaBt9jna++9cgDheXVyNwSjQPY
         bedyOXZr60C2mLaLKubBXNtoDQ+vjWO1F7g0j6bmpYA6QgPsAWZSQdyiiEBGYOAfEfdw
         axtFNB2mcQeJkpSlTSZ1qXZscvjmpOh560eBkvGciuNib77nLBajtpzHQ+KnVyr5zb23
         r7Xg==
X-Gm-Message-State: AJIora/0ZUAdCaVLsaFaJDIxMHJRxnSU6hIsQOycX1ydzlcDuuEGiKaK
        VQk25JDrMHT2WofBZHqABSXbqLjFFQ==
X-Google-Smtp-Source: AGRyM1sIS4TSzEqyC9Ii3ta/AcAtHTHn4ER0oLjaYP586lvtQw1IuKquT/6LguAEkW2phF1CD8DkmQ==
X-Received: by 2002:a05:6e02:b29:b0:2da:bd29:6ee5 with SMTP id e9-20020a056e020b2900b002dabd296ee5mr9306235ilu.291.1656700443466;
        Fri, 01 Jul 2022 11:34:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d9242000000b006758cc4aa76sm3200776iol.29.2022.07.01.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:34:02 -0700 (PDT)
Received: (nullmailer pid 1282243 invoked by uid 1000);
        Fri, 01 Jul 2022 18:34:01 -0000
Date:   Fri, 1 Jul 2022 12:34:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] PCI: qcom: Make all optional clocks optional
Message-ID: <20220701183401.GC1266081-robh@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-9-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629141000.18111-9-johan+linaro@kernel.org>
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

On Wed, Jun 29, 2022 at 04:09:58PM +0200, Johan Hovold wrote:
> The kernel is not a devicetree validator and does not need to re-encode
> information which is already available in the devicetree.
> 
> This is specifically true for the optional PCIe clocks, some of which
> are really interconnect clocks.
> 
> Treat also the 2.7.0 optional clocks as truly optional instead of
> maintaining a list of clocks per compatible (including two compatible
> strings for the two identical controllers on sm8450) just to validate
> the devicetree.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 28 ++++----------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)

I guess this depends on patch 6, but looks like a good cleanup.

Reviewed-by: Rob Herring <robh@kernel.org>
