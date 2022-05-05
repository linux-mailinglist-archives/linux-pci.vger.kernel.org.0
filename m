Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E4451CAFD
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 23:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385843AbiEEVaH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 17:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385814AbiEEVaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 17:30:05 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E6A5130E;
        Thu,  5 May 2022 14:26:25 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id y63so5664650oia.7;
        Thu, 05 May 2022 14:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xb0OXOg0t3N9GD/mSfY2n7fjYxRyr0+XtQQ9Bzntzbk=;
        b=NHbcgylLmq2g0OC2OqHmNClW5bPQjn2pyLRIVujxPjXRoLjWy8+ifLdQT7G+jLSeLX
         ujuGg1iGZaj62Td/mKSZhyohrxG9n+aAwnMySPQTXaGZrWhE1J3mNOFLZ5u3qCa9p83g
         goSBfg9FIbstEogiF6TxC88LDD4wek4Ps3I+yOPkbOH39bdlI0Rc5aZ44Iaz75Zd/2Zi
         8etic4vJA13NwczvdKauLXnF+gjg6KmoQ+g83Q50+q+NBlueYauslySRjhTro7lLJs+U
         cfTc6GKIi0Qgk+vpxdmq3wVfuuwbKZCxoWovD+dwpcbFIKfHpMXa1JpbuaFAQUEMi+rk
         otlg==
X-Gm-Message-State: AOAM532qhxmJfeM9N8qlEJzikOwJHO6UmOZ2ay+UUBqGuPeWpkRJro/K
        F7MTgFvebwrNC2v5v8t0WBmr+BgTWA==
X-Google-Smtp-Source: ABdhPJyATktKFDoFdZkIrhRXSEOmMNynq/iVqAxBxgVsMosqzSPT8kE9g1Bm61KZN+lhyx19jTkYXA==
X-Received: by 2002:a05:6808:150c:b0:322:88d3:74aa with SMTP id u12-20020a056808150c00b0032288d374aamr98156oiw.245.1651785984414;
        Thu, 05 May 2022 14:26:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a4ab649000000b0033a3450cc20sm1194434ooo.0.2022.05.05.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 14:26:23 -0700 (PDT)
Received: (nullmailer pid 219646 invoked by uid 1000);
        Thu, 05 May 2022 21:26:23 -0000
Date:   Thu, 5 May 2022 16:26:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/7] PCI: qcom: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <YnRA//LbCW+IVi3o@robh.at.kernel.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505135407.1352382-6-dmitry.baryshkov@linaro.org>
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

On Thu, May 05, 2022 at 04:54:05PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Thus to receive higher MSI vectors properly,
> add separate msi_host_init()/msi_host_deinit() handling additional host
> IRQs.

msi_host_init() has 1 user (keystone) as it doesn't use the DWC MSI 
controller. But QCom does given the access to PCIE_MSI_INTR0_STATUS, 
so mutiple MSI IRQ outputs must have been added in newer versions of the 
DWC IP. If so, it's only a matter of time for another platform to 
do the same thing. Maybe someone from Synopsys could confirm?

Therefore this should all be handled in the DWC core. In general, I 
don't want to see more users nor more ops if we don't have to. Let's not 
create ops for what can be handled as data. AFAICT, this is just number 
of MSIs and # of MSIs per IRQ. It seems plausible another platform could 
do something similar and supporting it in the core code wouldn't 
negatively impact other platforms.

Rob
