Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2798352064B
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiEIVEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiEIVEB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 17:04:01 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D462B8D27;
        Mon,  9 May 2022 14:00:06 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id j12so11605202oie.1;
        Mon, 09 May 2022 14:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A4ob0eSSbmcm/QW2p/EojIBNFD858jnW+91YcPxJNWg=;
        b=4tPZrGD/otv7B/T8daf0PTEEJxZgekmO8/HJKzdyneEQ3Uf2wtKx3DHJVfjBAhJ4W7
         5/vKNCpkmD3oPFadAS56PNXQiR7OXTFycZxr9bRrlzFYacUdJW8qQq5k68tw622OzoDD
         GOvwu7k1YNyrw4hKwZcNE1fTrNcjmsv286doLuDWQJtYrLPGFNEpSOULjbeKcm/Cgd4J
         qpgBw4i3JHpn+CzuCFP45RNrP75XcIBUmWMFeaiPg9xbgBlldPS4AU6CMnLvDtt0g1kv
         2gVmGsoEaFQzh5RRZGcr10iJ4NaPFgDxd+gQgQpf0QpV9S8S9pspzhBtQULXP7orniVN
         StEg==
X-Gm-Message-State: AOAM531acyT/rr21qsR6Lo5wBW5mKc/qkXE+WMNh4IcP79t/AN70M2VO
        qfbwVF4dOwu+mij9WLPlZI7c1bVq/g==
X-Google-Smtp-Source: ABdhPJxJjaYbkkOernUyIgfWhKeVU+9U1aYjG8s4i3k9rJRhT3J1gKrWtUXYs97LodSSfta7apCDYw==
X-Received: by 2002:a05:6808:1451:b0:326:9747:c70 with SMTP id x17-20020a056808145100b0032697470c70mr7576025oiv.106.1652130005303;
        Mon, 09 May 2022 14:00:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a15-20020a056870b14f00b000e9b8376a7bsm4501892oal.23.2022.05.09.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 14:00:04 -0700 (PDT)
Received: (nullmailer pid 168072 invoked by uid 1000);
        Mon, 09 May 2022 21:00:03 -0000
Date:   Mon, 9 May 2022 16:00:03 -0500
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
Message-ID: <YnmA02t7BBIPSgnY@robh.at.kernel.org>
References: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
 <20220505135407.1352382-6-dmitry.baryshkov@linaro.org>
 <YnRA//LbCW+IVi3o@robh.at.kernel.org>
 <b334a2e6-69ae-690d-8560-25f8a1319e5c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b334a2e6-69ae-690d-8560-25f8a1319e5c@linaro.org>
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

On Fri, May 06, 2022 at 10:40:56AM +0300, Dmitry Baryshkov wrote:
> On 06/05/2022 00:26, Rob Herring wrote:
> > On Thu, May 05, 2022 at 04:54:05PM +0300, Dmitry Baryshkov wrote:
> > > On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> > > separate GIC interrupt. Thus to receive higher MSI vectors properly,
> > > add separate msi_host_init()/msi_host_deinit() handling additional host
> > > IRQs.
> > 
> > msi_host_init() has 1 user (keystone) as it doesn't use the DWC MSI
> > controller. But QCom does given the access to PCIE_MSI_INTR0_STATUS,
> > so mutiple MSI IRQ outputs must have been added in newer versions of the
> > DWC IP. If so, it's only a matter of time for another platform to
> > do the same thing. Maybe someone from Synopsys could confirm?
> 
> This is a valid question, and if you check, first iterations of this
> patchset had this in the dwc core ([1], [2]). Exactly for the reason this
> might be usable for other platforms.
> 
> Then I did some research for other platforms using DWC PCIe IP core. For
> example, both Tegra Xavier and iMX6 support up to 256 MSI vectors, they use
> DWC MSI IRQ controller. The iMX6 TRM explicitly describes using different
> MSI groups for different endpoints. The diagram shows 8 MSI IRQ signal
> lines. However in the end the signals from all groups are OR'ed to form a
> single host msi_ctrl_int. Thus currently I suppose that using multiple MSI
> IRQs is a peculiarity of Qualcomm platform.

Chip integration very often will just OR together interrupts or not. 
It's completely at the whim of the SoC design, so I'd say both cases are 
very likely. Seems to be a feature in newer versions of the IP. Probably 
requested by some misguided h/w person thinking split interrupts would 
be 'faster'. (Sorry, too many past discussions with h/w designers on 
this topic.)

> > Therefore this should all be handled in the DWC core. In general, I
> > don't want to see more users nor more ops if we don't have to. Let's not
> > create ops for what can be handled as data. AFAICT, this is just number
> > of MSIs and # of MSIs per IRQ. It seems plausible another platform could
> > do something similar and supporting it in the core code wouldn't
> > negatively impact other platforms.
> 
> I wanted to balance adding additional ops vs complicating the core for other
> platforms. And I still suppose that platform specifics should go to the
> platform driver. However if you prefer [1] and [2], we can go back to that
> implementation.

Yes, I prefer that implementation.

Rob
