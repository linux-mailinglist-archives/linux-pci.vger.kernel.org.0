Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767766606E0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjAFTDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 14:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjAFTDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 14:03:06 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C57A2DE5
        for <linux-pci@vger.kernel.org>; Fri,  6 Jan 2023 11:03:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso2664558pjf.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2023 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cN1Hjv1ZjF1Fra4t2Mn0qNOiNK4+jB93cBxr0YMCnwU=;
        b=Ey7z3A66Pzb0lcqqMt7lzKApR06KzbwNc88raWNB+go5VTfVweyGY/80D8spdoOnkY
         sAHBjRedssOlc0LeTldAEMDilblEKDERD+bPNfwq5CuK6q/1NVnbXPy9rLc8/9NALSqZ
         jC626zoqPMyvdQk3G5maM8JFqH34WkrYpKV515OhQMMNn7xw/LTJORjKMFiKuAnZeCBj
         pvoydOVH/Huo5U07uDzgqc3r77FMDpKpWfIzqJPQpAFPccJez3uyL8hbBMGSmneUYRSV
         P+1ufg+TuJzu/ynM6oa5FnmlPY3hSU9Gdli4T0jEaTSsUzk3TayX8rKPzt54Wc8TnIu3
         fcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cN1Hjv1ZjF1Fra4t2Mn0qNOiNK4+jB93cBxr0YMCnwU=;
        b=hdPt5BDsHsw0024GhD4TGns/+XmYEvNMVkcpRFeKOIro+hVJmtPNm0eC4WluQxBBF9
         ytXb3ctzM9vFdnvV6Bf+xFjh8pwz2GrXB/JFCH/wkUfKEnFWnmEIUjjPF5QL+JryXYz0
         chHtTOGus8l5Ki4HUSEWXnDA6QyTxihKHSQC+00IwSD9HbU6NtzgXKxpeFNldnolYfmw
         jIb47xnaNAVbh07SkiLDdyXINKmxzQm6m7AKYIkmOr+CeUcnox6PePuecLGsJK31lZUm
         86yCMb9yvzYpxC6FDTQ3qVUFWGC7HNSDIsxdq7zvkDJJOpH8DFEq2cjulT3na8+MbGwU
         wnkQ==
X-Gm-Message-State: AFqh2kqKATfTM0fpxQUhSnIAODgClvdIv4LEJ2nhilXeXBNRMlmSzvvl
        h5QK7NXIOhYemuceCZZ3fD0C
X-Google-Smtp-Source: AMrXdXtfMOGCp05TM2sHR7cXAOWHvJIBVZnzSN59IpmKgh+9sUVPEuNQKKQMNialZrVSnsAUd6Yl3g==
X-Received: by 2002:a17:90b:23c7:b0:225:f8e9:a0b5 with SMTP id md7-20020a17090b23c700b00225f8e9a0b5mr45042090pjb.45.1673031783709;
        Fri, 06 Jan 2023 11:03:03 -0800 (PST)
Received: from thinkpad ([117.217.183.19])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090a061700b002262fcd92desm3217844pjj.7.2023.01.06.11.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:03:02 -0800 (PST)
Date:   Sat, 7 Jan 2023 00:32:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Dhruva Gole <d-gole@ti.com>, lpieralisi@kernel.org,
        robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Message-ID: <20230106190252.GA485076@thinkpad>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
 <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
 <dad3aba3-a40b-8b76-c689-3dc877800263@ti.com>
 <20230105133639.GC4463@thinkpad>
 <Y7hlr3x9IrT/Kg82@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7hlr3x9IrT/Kg82@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 06, 2023 at 06:17:19PM +0000, Matthias Kaehlcke wrote:
> On Thu, Jan 05, 2023 at 07:06:39PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 03, 2023 at 04:46:11PM +0530, Dhruva Gole wrote:
> > > 
> > > 
> > > On 03/01/23 13:19, Manivannan Sadhasivam wrote:
> > > > During the system suspend, vote for minimal interconnect bandwidth and
> > > > also turn OFF the resources like clock and PHY if there are no active
> > > > devices connected to the controller. For the controllers with active
> > > > devices, the resources are kept ON as removing the resources will
> > > > trigger access violation during the late end of suspend cycle as kernel
> > > > tries to access the config space of PCIe devices to mask the MSIs.
> > > > 
> > > > Also, it is not desirable to put the link into L2/L3 state as that
> > > > implies VDD supply will be removed and the devices may go into powerdown
> > > > state. This will affect the lifetime of storage devices like NVMe.
> > > > 
> > > > And finally, during resume, turn ON the resources if the controller was
> > > > truly suspended (resources OFF) and update the interconnect bandwidth
> > > > based on PCIe Gen speed.
> > > > 
> > > > Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > 
> > > Nice to have another driver added to the list of system suspend
> > > support!
> > > 
> > > Acked-by: Dhruva Gole <d-gole@ti.com>
> > > 
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
> > > >   1 file changed, 52 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 5696e327795b..48810f1f2dba 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -227,6 +227,7 @@ struct qcom_pcie {
> > > >   	struct gpio_desc *reset;
> > > >   	struct icc_path *icc_mem;
> > > >   	const struct qcom_pcie_cfg *cfg;qcom_pcie_icc_update
> > > > +	bool suspended;
> > > >   };
> > > >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > > @@ -1835,6 +1836,52 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> > > >   	return 0;
> > > >   }
> > > > +static int qcom_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = icc_set_bw(pcie->icc_mem, 0, 0);
> > > > +	if (ret) {
> > > > +		dev_err(pcie->pci->dev, "Failed to set interconnect bandwidth: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Turn OFF the resources only for controllers without active PCIe devices. For controllers
> > > > +	 * with active devices, the resources are kept ON and the link is expected to be in L0/L1
> > > > +	 * (sub)states.
> > > > +	 *
> > > > +	 * Turning OFF the resources for controllers with active PCIe devices will trigger access
> > > > +	 * violation during the end of the suspend cycle, as kernel tries to access the PCIe devices
> > > > +	 * config space for masking MSIs.
> > > > +	 *
> > > > +	 * Also, it is not desirable to put the link into L2/L3 state as that implies VDD supply
> > > > +	 * will be removed and the devices may go into powerdown state. This will affect the
> > > > +	 * lifetime of the storage devices like NVMe.
> > > > +	 */
> > > > +	if (!dw_pcie_link_up(pcie->pci)) {
> > > > +		qcom_pcie_host_deinit(&pcie->pci->pp);
> > > > +		pcie->suspended = true;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int qcom_pcie_resume_noirq(struct device *dev)
> > > > +{
> > > > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > > > +
> > > > +	if (pcie->suspended) {
> > > > +		qcom_pcie_host_init(&pcie->pci->pp);
> > > > +		pcie->suspended = false;
> > > > +	}
> > > > +
> > > > +	qcom_pcie_icc_update(pcie);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >   static const struct of_device_id qcom_pcie_match[] = {
> > > >   	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > >   	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > > @@ -1870,12 +1917,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
> > > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
> > > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> > > > +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> > > > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
> > > > +};
> > > > +
> > > >   static struct platform_driver qcom_pcie_driver = {
> > > >   	.probe = qcom_pcie_probe,
> > > >   	.remove = qcom_pcie_remove,
> > > >   	.driver = {
> > > >   		.name = "qcom-pcie",
> > > >   		.of_match_table = qcom_pcie_match,
> > > > +		.pm = &qcom_pcie_pm_ops,
> > > >   	},
> > > >   };
> > > >   module_platform_driver(qcom_pcie_driver);
> > > 
> > > Out of curiosity, were you able to measure how much power you were able
> > > to save after adding suspend support for PCIe? I don't know if clock
> > > gating really saves much amount of power, but yeah its true that we
> > > can't really cut off the power domain entirely in this case.
> > > 
> > 
> > I did not measure the power consumption and I agree that we won't save much
> > power with setting icc bandwidth to 0. But it is better to have something
> > than nothing. And in the coming days, I have plans to look into other power
> > saving measures also.
> 
> On a sc7280 system I see a reduction of ~30mW with this patch when no PCI
> card is plugged in. The reduction seems to come from powering the PHY down.
> 

Thanks a lot for testing!

> Interestingly on that system power consumption during suspend (without this
> patch) is ~30mW higher *without* a PCI card vs. with a card. Maybe the PHY
> doesn't enter a low power mode when no card is plugged in?

Yeah, both PHY and controllers are never put into low power mode even if there
are no devices connected. I don't know if the low power mode is possible at
all with PHY.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
