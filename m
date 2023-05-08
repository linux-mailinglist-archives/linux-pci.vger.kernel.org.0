Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCE6FA898
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjEHKnE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjEHKm2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 06:42:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553142C3EA
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 03:41:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf21bb427so30543595ad.1
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683542492; x=1686134492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LeRt9uIBhRc0IzYM4Je8YJbs6yEHyFSlqTzPoluTbQk=;
        b=zAllV7isaF8QsMiAdjnG+3bMSkb94Omp7PXqGc3tTrBnlYeAJ7TdRXD5DnSYDUYs96
         JSMIgLpqwdk8E8/sCvTsB7hq+AsYLpo7UlwH6TvKT58geYGh7r2D6RRyAF0vZTt4Rqm7
         SyojFnkQynQ4GmxY7VNbUaO/t7xFbHCWzxZifCi18ORHHoQF4vPmjbshVRjJIz91eEaK
         saqK2xFq8q8PrVNxULsBGmqcUg9hT95l6lGoy2Fa1fm9e727VKU7/mOTjTnP3VzmCql+
         cUkXwvkCShAnnGmiDkpu0YMYNMZiGoPZUAOVf0HIkqjTBVFB0gnu1QpJfr1nP33JDFAs
         GYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683542492; x=1686134492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeRt9uIBhRc0IzYM4Je8YJbs6yEHyFSlqTzPoluTbQk=;
        b=SGayaNzb2yMCg40q+Sl6PfJ3IJWrP6BqQ9wA9Ya/7c46FiDF3r8mVspeuc2FVS5Pv/
         ErwBUbfdtW32LTW2qSCqI5rmGaFfR9O01qCzFf5ily1kyr5bzfNNQRwt/GIP7U7Z6g0z
         FAyafLM5bPVE03f0lRQH8KxyydpVAkXVd2Aarkj6dZmqv7HYMSOIzsXTFJvCXwC7wIYb
         npVIp6avlGohL6+WSYMAVjxEpAe/d3eKX8lasIYg3rzxxyaGnWzH6ehbNZYKiZzd7Ge0
         xZVN9nrbjiKJtgIZkI3nlLVqpZlFIrBj8iPMX6B8/xDRVUbSFifP9i7SJwLkwUHG4E5u
         Lv1Q==
X-Gm-Message-State: AC+VfDxL4HXgub+WKdLq8eEKonkGbQCJ3TkgtFZpgp8aB28TWT0/z/FN
        2ZAvKpn1zilSaL5vzmaKzTdi
X-Google-Smtp-Source: ACHHUZ77wjgYAVc0g6+G0s0folTgzK1xWweysONOrE9DaFKntjxyue1aOAMnKmsnmhZ8kntbX9AkRQ==
X-Received: by 2002:a17:902:e80c:b0:1ab:1dff:9540 with SMTP id u12-20020a170902e80c00b001ab1dff9540mr12713851plg.14.1683542492544;
        Mon, 08 May 2023 03:41:32 -0700 (PDT)
Received: from thinkpad ([59.92.97.45])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902768100b001aaf2e7b06csm6863394pll.132.2023.05.08.03.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:41:32 -0700 (PDT)
Date:   Mon, 8 May 2023 16:11:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, andersson@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 5/8] PCI: qcom: Do not advertise hotplug capability for
 IP v2.3.2
Message-ID: <20230508104127.GB4190@thinkpad>
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-6-manivannan.sadhasivam@linaro.org>
 <bc3ce44f-745a-bbad-32ac-67f8baa49483@linaro.org>
 <0e5f9f6b-eb67-38f8-2719-06aa8fe296bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e5f9f6b-eb67-38f8-2719-06aa8fe296bd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 06, 2023 at 04:01:43PM +0200, Konrad Dybcio wrote:
> 
> 
> On 6.05.2023 14:04, Dmitry Baryshkov wrote:
> > On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> >> SoCs making use of Qcom PCIe controller IP v2.3.2 do not support hotplug
> >> functionality. But the hotplug capability bit is set by default in the
> >> hardware. This causes the kernel PCI core to register hotplug service for
> >> the controller and send hotplug commands to it. But those commands will
> >> timeout generating messages as below during boot and suspend/resume.
> >>
> >> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> >> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> >> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> >> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> >>
> >> This not only spams the console output but also induces a delay of a
> >> couple of seconds. To fix this issue, let's clear the HPC bit in
> >> PCI_EXP_SLTCAP register as a part of the post init sequence to not
> >> advertise the hotplug capability for the controller.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 3d5b3ce9e2da..33353be396ec 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -579,6 +579,8 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> >>     static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> >>   {
> >> +    struct dw_pcie *pci = pcie->pci;
> >> +    u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >>       u32 val;
> >>         /* enable PCIe clocks and resets */
> >> @@ -602,6 +604,14 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> >>       val |= EN;
> >>       writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> >>   +    dw_pcie_dbi_ro_wr_en(pci);
> >> +
> >> +    val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >> +    val &= ~PCI_EXP_SLTCAP_HPC;
> >> +    writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >> +
> >> +    dw_pcie_dbi_ro_wr_dis(pci);
> >> +
> > 
> > Seeing this code again and again makes me wonder if we should have a separate function for this.
> Moreover, is there no generic rmw type function for readl+writel?
> 

No rmw as of now. But it could be added to reduce boilerplate code. But it
should be part of separate cleanup series though.

- Mani

> Konrad
> > 

-- 
மணிவண்ணன் சதாசிவம்
