Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECE6FA6FC
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjEHK0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjEHKZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 06:25:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86125240
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 03:25:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so28992515ad.3
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683541520; x=1686133520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nISMZiLCgK5YExKIQaILcEjGV16PHjAVE+2qzwjdP9U=;
        b=FbheN73E2lrXhsYBVfExIkulRcJsveu8T76D/gxtNyfkFnhnqnm9e16eyEyHZxJjRG
         4llS324c4dTAgVhKktSs6Ap+deaORCAgB4X9GM4zusQ4IL0+SBWarlIeGL+nW999K/qk
         kSHNmj/R4zrZzZUfUw5PqJvRfvzBdp++3JrGEOKdSFhpC529Y2wdFrg0t0Qv+vVysam2
         Lu4Gao+GJh8agNCwStXEIHpZtCjPyqzX59fHPV3rAqB///I9mN5EQvg7IDP4nIrcAn+w
         KiUevOCg+oEtOn0Jx8/lAEx9Ys8pye7+CzafnnzHuraWWHlSOQjRdY2b2IOOJizaOFUj
         fb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541520; x=1686133520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nISMZiLCgK5YExKIQaILcEjGV16PHjAVE+2qzwjdP9U=;
        b=Yft1pAV0GRla+fZnoiYC6gzaVq0UUveZNATDfcgpxOEwK5ZLCZos14SLQCf/kNoslK
         eKYfKbXUxXjZBBaRXBAqNreAVGygOKAdglMBZrc7qumcJRK+euXCeNHCXqruQbTH7z+5
         w+jSJ0V7aJhnp2VhM0Db3jZvNssEuPODkqKawSLCBwLqfbFRna6VtOBUtC+6jqgs2F3+
         NDwHlycZqkRaiA6xZ/p4B0HcMUq7KKRzdTiKdjvue7T9gfZBI6H8F4G6cYdzoGoQ5m6n
         ZeAvDcXBTE1mI9SV6B8GKHXcUIyHBLwP6Rhhl8Q1PDAwtKuiCYKG9hAcZ4Yk9/R7h+YX
         tpmA==
X-Gm-Message-State: AC+VfDyW/uMJApPGyme8nZpw1shlWVbbz9WHpRq+iO1ZA5t0pedVY8fH
        qhKpmbWqi+deqItRbUW9EeON
X-Google-Smtp-Source: ACHHUZ6FNAT5+l7kub+yrj1pmu7hxSfwhD4xjzHQKhOQXYMSJu1KJnmXI8Q3p67Vujx1Ksa3TqLa8A==
X-Received: by 2002:a17:902:c1cd:b0:1a9:40d5:b0ae with SMTP id c13-20020a170902c1cd00b001a940d5b0aemr10165029plc.12.1683541519738;
        Mon, 08 May 2023 03:25:19 -0700 (PDT)
Received: from thinkpad ([59.92.97.45])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001a1ccb37847sm6847233plz.146.2023.05.08.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 03:25:19 -0700 (PDT)
Date:   Mon, 8 May 2023 15:55:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH 5/8] PCI: qcom: Do not advertise hotplug capability for
 IP v2.3.2
Message-ID: <20230508102505.GA4190@thinkpad>
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-6-manivannan.sadhasivam@linaro.org>
 <bc3ce44f-745a-bbad-32ac-67f8baa49483@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc3ce44f-745a-bbad-32ac-67f8baa49483@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 06, 2023 at 03:04:42PM +0300, Dmitry Baryshkov wrote:
> On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> > SoCs making use of Qcom PCIe controller IP v2.3.2 do not support hotplug
> > functionality. But the hotplug capability bit is set by default in the
> > hardware. This causes the kernel PCI core to register hotplug service for
> > the controller and send hotplug commands to it. But those commands will
> > timeout generating messages as below during boot and suspend/resume.
> > 
> > [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> > [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> > [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> > [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> > 
> > This not only spams the console output but also induces a delay of a
> > couple of seconds. To fix this issue, let's clear the HPC bit in
> > PCI_EXP_SLTCAP register as a part of the post init sequence to not
> > advertise the hotplug capability for the controller.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 3d5b3ce9e2da..33353be396ec 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -579,6 +579,8 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
> >   static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> >   {
> > +	struct dw_pcie *pci = pcie->pci;
> > +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >   	u32 val;
> >   	/* enable PCIe clocks and resets */
> > @@ -602,6 +604,14 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
> >   	val |= EN;
> >   	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
> > +	val &= ~PCI_EXP_SLTCAP_HPC;
> > +	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> > +
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +
> 
> Seeing this code again and again makes me wonder if we should have a
> separate function for this.
> 

Makes sense!

- Mani

> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
