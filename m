Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8285E65ED28
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjAENhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 08:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjAENgt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 08:36:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D722D5
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 05:36:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cl14so3406689pjb.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Jan 2023 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AUq/fH3433jj5mBTye1N9Y+4Kwha1VQSzZyDmC40ABs=;
        b=qqi1KR0CwVwPialeP/vVz4H2BrZcPEUSCREGYjXQQShJCMoNB0+HQeVXeRubvB1e2e
         x2RAYpDlaRt3BOKkEyV14HcAeIaAWx9pcf1LhlN2nESIhE581wZYE/TT2RnLx9nQJEj9
         1DWbG/O/NH/gLFa1WyB2drG7aqQBPh2NE0AaVKlgVviZmocgRrXY/Wx1SO2+kfvmDVf8
         4pquiqpJtZbvh93ky60+1qo/px80CmlvMKaIR14dSQ8HzpjufuHuwpZBJEsxQ865rzGB
         Tcbkn3pkreOCnOvb/5lpwisXCQvI3NXI1JRIMU45tfX6TjlER6Sbl0OSTg1ytho4tyRC
         u5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUq/fH3433jj5mBTye1N9Y+4Kwha1VQSzZyDmC40ABs=;
        b=YRyqjzWOsNpmbfIldO1A2WhHv1+O0De13IEUzSKuZc2RDB+w6/AZHbQaDv32IL0GlQ
         EEVuvJQgo75ie2LWXidGPhGV1/CfUWpFloEIBvlh1Po5YsKXlDuMDrVx+n0xcZmwVw9M
         JnSVskXIebzFoNiGB+P1MhDpxX34UjVmb3euwX2Htibsh5YcbKi6iOOa32BPhTk6blkf
         RoLRRetqO8qQkFMaNh/KznGcifUO/Ioa1kRTOyuhmQ99gPuNfGeiEoInnZvWe1+iW+2z
         61pNSbFJWa54m+TirxNUUZb/I6zhe4vLuCUVymCwAiNAn35gqS66lHqMgg4IpE10aoup
         ewfw==
X-Gm-Message-State: AFqh2kqL0PZT+jmnCi71sWXVuwN9mgVrDkuUdVKpVLACaLQaaImECfT3
        Tfo52m1csMm9rP2jk9B6iO2m+QRWiC4R+bg=
X-Google-Smtp-Source: AMrXdXveHUkpZc56ezsxEQLj/WhfUvK+o1mZVoRR76QAthztmcXb8pZvYykCG5PNid64jKKC8USPgA==
X-Received: by 2002:a17:903:110d:b0:189:89e2:5406 with SMTP id n13-20020a170903110d00b0018989e25406mr92514518plh.24.1672925807368;
        Thu, 05 Jan 2023 05:36:47 -0800 (PST)
Received: from thinkpad ([27.111.75.153])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189651e5c26sm26132627pla.236.2023.01.05.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:36:46 -0800 (PST)
Date:   Thu, 5 Jan 2023 19:06:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Message-ID: <20230105133639.GC4463@thinkpad>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
 <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
 <dad3aba3-a40b-8b76-c689-3dc877800263@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dad3aba3-a40b-8b76-c689-3dc877800263@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 03, 2023 at 04:46:11PM +0530, Dhruva Gole wrote:
> 
> 
> On 03/01/23 13:19, Manivannan Sadhasivam wrote:
> > During the system suspend, vote for minimal interconnect bandwidth and
> > also turn OFF the resources like clock and PHY if there are no active
> > devices connected to the controller. For the controllers with active
> > devices, the resources are kept ON as removing the resources will
> > trigger access violation during the late end of suspend cycle as kernel
> > tries to access the config space of PCIe devices to mask the MSIs.
> > 
> > Also, it is not desirable to put the link into L2/L3 state as that
> > implies VDD supply will be removed and the devices may go into powerdown
> > state. This will affect the lifetime of storage devices like NVMe.
> > 
> > And finally, during resume, turn ON the resources if the controller was
> > truly suspended (resources OFF) and update the interconnect bandwidth
> > based on PCIe Gen speed.
> > 
> > Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Nice to have another driver added to the list of system suspend
> support!
> 
> Acked-by: Dhruva Gole <d-gole@ti.com>
> 
> >   drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 5696e327795b..48810f1f2dba 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -227,6 +227,7 @@ struct qcom_pcie {
> >   	struct gpio_desc *reset;
> >   	struct icc_path *icc_mem;
> >   	const struct qcom_pcie_cfg *cfg;qcom_pcie_icc_update
> > +	bool suspended;
> >   };
> >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > @@ -1835,6 +1836,52 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> >   	return 0;
> >   }
> > +static int qcom_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = icc_set_bw(pcie->icc_mem, 0, 0);
> > +	if (ret) {
> > +		dev_err(pcie->pci->dev, "Failed to set interconnect bandwidth: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Turn OFF the resources only for controllers without active PCIe devices. For controllers
> > +	 * with active devices, the resources are kept ON and the link is expected to be in L0/L1
> > +	 * (sub)states.
> > +	 *
> > +	 * Turning OFF the resources for controllers with active PCIe devices will trigger access
> > +	 * violation during the end of the suspend cycle, as kernel tries to access the PCIe devices
> > +	 * config space for masking MSIs.
> > +	 *
> > +	 * Also, it is not desirable to put the link into L2/L3 state as that implies VDD supply
> > +	 * will be removed and the devices may go into powerdown state. This will affect the
> > +	 * lifetime of the storage devices like NVMe.
> > +	 */
> > +	if (!dw_pcie_link_up(pcie->pci)) {
> > +		qcom_pcie_host_deinit(&pcie->pci->pp);
> > +		pcie->suspended = true;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int qcom_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +	if (pcie->suspended) {
> > +		qcom_pcie_host_init(&pcie->pci->pp);
> > +		pcie->suspended = false;
> > +	}
> > +
> > +	qcom_pcie_icc_update(pcie);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct of_device_id qcom_pcie_match[] = {
> >   	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> >   	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > @@ -1870,12 +1917,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
> >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
> >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> > +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
> > +};
> > +
> >   static struct platform_driver qcom_pcie_driver = {
> >   	.probe = qcom_pcie_probe,
> >   	.remove = qcom_pcie_remove,
> >   	.driver = {
> >   		.name = "qcom-pcie",
> >   		.of_match_table = qcom_pcie_match,
> > +		.pm = &qcom_pcie_pm_ops,
> >   	},
> >   };
> >   module_platform_driver(qcom_pcie_driver);
> 
> Out of curiosity, were you able to measure how much power you were able
> to save after adding suspend support for PCIe? I don't know if clock
> gating really saves much amount of power, but yeah its true that we
> can't really cut off the power domain entirely in this case.
> 

I did not measure the power consumption and I agree that we won't save much
power with setting icc bandwidth to 0. But it is better to have something
than nothing. And in the coming days, I have plans to look into other power
saving measures also.

Thanks,
Mani

> -- 
> Thanks and Regards,
> Dhruva Gole

-- 
மணிவண்ணன் சதாசிவம்
