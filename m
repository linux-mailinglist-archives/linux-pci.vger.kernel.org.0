Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1554A136
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbiFMVS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351969AbiFMVSG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:18:06 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFA1E3EE;
        Mon, 13 Jun 2022 14:00:48 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id n11so7420426iod.4;
        Mon, 13 Jun 2022 14:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Odp6/obgJVsxv8Vv9ZmijjVf80Ud9qsxzsERwV2qZs=;
        b=UyneMvTW4UDRiTfhmgQ6UnwiycnSwRvM0CX1L+7z2VedG4xl12N9FY6bLYh9JAZpNw
         mLf3oWKgOIN0wwqq29/EVD6CnBcxwKGDVqROMklB5ljlagP2M3ZXrYY+Sb0E5MAxSArh
         WmYsDiJMj1P+kqkhJZ95HEq9eLXDXEY9e9KeNtOiQIaKefujlO7ZyyzqXfh67EWd328H
         ShNEr58Ulv4SOOey/+gKJ3MjZ9roCYwtbySdMh5A1ia9fVYPXSGbic55GKQ2z3R7fEJd
         UVfn+SPgbibsZFT11PilBFQHohCNyphi8eQl0MD4HWgDcSUXwbZ3grvHsz/fHF5cBWOw
         3RQA==
X-Gm-Message-State: AOAM533xqCsaW3yMII0qYiHTzQux/EhBac/dJ4QB5oCO7r3M8t9VqJbE
        w6m76NFd0E1HbbS1p5HOTw==
X-Google-Smtp-Source: ABdhPJw8eVfbIVjd2ydKXeVxyTaUwE+vffIj9bUthH3jOQqUqijyC5JzV9l4ObDcrSNOg7gmIgIrXg==
X-Received: by 2002:a05:6638:14cd:b0:331:d9b3:fa47 with SMTP id l13-20020a05663814cd00b00331d9b3fa47mr947723jak.303.1655154047769;
        Mon, 13 Jun 2022 14:00:47 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id k5-20020a023505000000b003315fa78c0bsm3976001jaa.146.2022.06.13.14.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:00:47 -0700 (PDT)
Received: (nullmailer pid 75907 invoked by uid 1000);
        Mon, 13 Jun 2022 21:00:46 -0000
Date:   Mon, 13 Jun 2022 15:00:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/3] PCI: qcom: Add IPQ60xx support
Message-ID: <20220613210046.GB62642-robh@kernel.org>
References: <cover.1655028401.git.baruch@tkos.co.il>
 <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
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

On Sun, Jun 12, 2022 at 01:18:35PM +0300, Baruch Siach wrote:
> From: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
> 
> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> platform.
> 
> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
> win.linuxopenwrt.2.0).
> 
> Split out the DBI registers access part from .init into .post_init. DBI
> registers are only accessible after phy_power_on().
> 
> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/
> 
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> ---
> v7:
> 
>   * Rebase on v5.19-rc1 (Bjorn Helgaas)
> 
> v6:
> 
> Address Bjorn Helgaas comments:
> 
>   * Rename PCIE_CAP_LINK1_VAL to PCIE_CAP_SLOT_VAL
> 
>   * Drop a vague comment about ASPM configuration
> 
>   * Add a comment about the source of delay periods
> 
> v5:
> 
>   * Remove comments from qcom_pcie_init_2_9_0() (Bjorn Andersson)
> 
> v4:
> 
>   * Rebase on v5.16-rc1
> 
> v3:
>   * Drop speed setup; rely on generic code (Rob Herring)
> 
>   * Drop unused CLK_RATE macros (Bjorn Helgaas)
> 
>   * Minor formatting fixes (Bjorn Helgaas)
> 
>   * Add reference to downstream Codeaurora kernel tree (Bjorn Helgaas)
> 
> v2:
>   * Drop ATU configuration; rely on common code instead
> 
>   * Use more common register macros
> 
>   * Use bulk clk and reset APIs
> ---
>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 140 +++++++++++++++++++
>  2 files changed, 141 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
