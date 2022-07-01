Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0D56392D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiGAS35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGAS34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 14:29:56 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F014220F7;
        Fri,  1 Jul 2022 11:29:55 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id i17so1903740ils.12;
        Fri, 01 Jul 2022 11:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BfKQ/G9vpK8o5YTL2HP8aX5XHf4iZZVbeFdacSW26dw=;
        b=F3fH6wCX0QPYKO+MXVgsBJkE7hfRcflKpN7gcMbXKQ2PKUumHMBA6G8y8eoEVjevqj
         GaX5peWnQZWC38l+htKUUkikIfqQXMMwNzKmxOOLgr90pzUtmtwqlTEDndYfhEKfnbbK
         LttzBv7NFI/TPApHwKNLdANyaaPbzZ7M1oRTWsre1XCjFW+LYqX7S11NY40e2R6BJd7c
         K31b8oyncc2oV2RSmxH9l349aOlojYJmIeicLsYvwGRAtck6xidZ6av2C6GuUskDgTCS
         ywv1QqNNpd1rmakdbDd2DyGG28S4cOOvPEf1udV//6amoD0Ko2koTrkwGRKjxGj/Zqzx
         qVFg==
X-Gm-Message-State: AJIora/AJHV1roWRUT7jOYWAE4P98KSqqSvyug0P6ohbSaeLAkVQnYWL
        +TBja93kIfZcZXL8hLXEMw==
X-Google-Smtp-Source: AGRyM1tBKEgt1I1S8M/iPVEROlqIos3uYk9EAnVDY4/jM8aYz7DrKKhMtpqYzQsLktxj6j+5uHUlHA==
X-Received: by 2002:a05:6e02:144d:b0:2da:b8f7:402a with SMTP id p13-20020a056e02144d00b002dab8f7402amr8861719ilo.178.1656700194546;
        Fri, 01 Jul 2022 11:29:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o126-20020a022284000000b00339f193b8ddsm10184094jao.130.2022.07.01.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:29:54 -0700 (PDT)
Received: (nullmailer pid 1275524 invoked by uid 1000);
        Fri, 01 Jul 2022 18:29:52 -0000
Date:   Fri, 1 Jul 2022 12:29:52 -0600
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
Subject: Re: [PATCH 07/10] PCI: qcom: Add support for SA8540P
Message-ID: <20220701182952.GB1266081-robh@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
 <20220629141000.18111-8-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629141000.18111-8-johan+linaro@kernel.org>
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

On Wed, Jun 29, 2022 at 04:09:57PM +0200, Johan Hovold wrote:
> The SA8540P platform has five PCIe controllers: two 4-lane, two 2-lane
> and one 1-lane.
> 
> Add a new "qcom,pcie-sa8540p" compatible string and reuse the 1.9.0 ops.
> 
> Note that like for SC8280XP, the SA8540 controllers need two or three
> interconnect clocks to be enabled.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
