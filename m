Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1033766342D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 23:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjAIWnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 17:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjAIWnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 17:43:02 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E834763
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 14:42:01 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id a9so5001813ilp.6
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 14:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TErLXK6Xw8NHk2rMZzxz1f1Mf6NRGAvKbG0LeKvkd80=;
        b=HBfGUR2BKxXIVeDbpudbJRq9L23fs0sHUreqrbBXmmUUZbfH6VqskmyOg1iWjFi/rW
         S9b+M0aSingPAzsb+yhQFYUUaRtGiL+OWRSYNpv/R+1hTEWJT5RJ8/+sRh9OgS3o6eCO
         r/jHmUeGmniwWQx8K/O0M/odoYUr+ZbHaEC6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TErLXK6Xw8NHk2rMZzxz1f1Mf6NRGAvKbG0LeKvkd80=;
        b=k7YSpu4eTJF3lba4Sikh5XzKyAHct/son9QFxTrEN3SILU+iuKzkDibAJewrfTecPz
         rqUoCEVI+iCXB2QPdWsdYT4GyJJt7hUWdj8e0wdy+b3j1dcesj5O8/5UwabyctLkAu+O
         0MNu9FlCRgOynuErHl5e2JUgZypW/QARd8VuUYKSzKQn1HnNlbYGvukK0O6QSso6XmRC
         26l1oWX2KCyBV0t6NRvoVe0Q7bO8X1bWhj/Irt3takHfst6qTosjwhtCm1u/LjSxGgYI
         YrejmIooy+7xuA1VNPRLkCoMxjPoAtygSFgumngbX4/xJgI2aChBl2eRfjDw5XQQkspE
         fz/g==
X-Gm-Message-State: AFqh2kr4yDD8z3SwWbiorMcrtuA9UVimClpTdvl77Bp9bI+FPdOINOBA
        VCC+464IrB0oToGLcvrzDC/Dc/IYGD3Ne+Bk
X-Google-Smtp-Source: AMrXdXv53lQkwFkvTB+kkYDEjigCbYWERvXtgFXrS1GfLpNNaWI/Xjg7caGqk3Fha0dxNWaxxuzkIg==
X-Received: by 2002:a92:c744:0:b0:30c:41cc:6978 with SMTP id y4-20020a92c744000000b0030c41cc6978mr22570638ilp.1.1673304120899;
        Mon, 09 Jan 2023 14:42:00 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id 191-20020a021dc8000000b0039e07ca9ae5sm3109938jaj.113.2023.01.09.14.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 14:42:00 -0800 (PST)
Date:   Mon, 9 Jan 2023 22:41:59 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Dhruva Gole <d-gole@ti.com>, lpieralisi@kernel.org,
        robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org
Subject: Re: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Message-ID: <Y7yYN1yGxqquR1FI@google.com>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
 <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
 <dad3aba3-a40b-8b76-c689-3dc877800263@ti.com>
 <20230105133639.GC4463@thinkpad>
 <Y7hlr3x9IrT/Kg82@google.com>
 <20230106190252.GA485076@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230106190252.GA485076@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 07, 2023 at 12:32:52AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jan 06, 2023 at 06:17:19PM +0000, Matthias Kaehlcke wrote:
> > On Thu, Jan 05, 2023 at 07:06:39PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jan 03, 2023 at 04:46:11PM +0530, Dhruva Gole wrote:
> > > > 
> > > > 
> > > > On 03/01/23 13:19, Manivannan Sadhasivam wrote:
> > > > > During the system suspend, vote for minimal interconnect bandwidth and
> > > > > also turn OFF the resources like clock and PHY if there are no active
> > > > > devices connected to the controller. For the controllers with active
> > > > > devices, the resources are kept ON as removing the resources will
> > > > > trigger access violation during the late end of suspend cycle as kernel
> > > > > tries to access the config space of PCIe devices to mask the MSIs.
> > > > > 
> > > > > Also, it is not desirable to put the link into L2/L3 state as that
> > > > > implies VDD supply will be removed and the devices may go into powerdown
> > > > > state. This will affect the lifetime of storage devices like NVMe.
> > > > > 
> > > > > And finally, during resume, turn ON the resources if the controller was
> > > > > truly suspended (resources OFF) and update the interconnect bandwidth
> > > > > based on PCIe Gen speed.
> > > > > 
> > > > > Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > 
> > > > Nice to have another driver added to the list of system suspend
> > > > support!
> > > > 
> > > > Acked-by: Dhruva Gole <d-gole@ti.com>
> > > > 
> > > > >   drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
> > > > >   1 file changed, 52 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 5696e327795b..48810f1f2dba 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -227,6 +227,7 @@ struct qcom_pcie {
> > > > >   	struct gpio_desc *reset;
> > > > >   	struct icc_path *icc_mem;
> > > > >   	const struct qcom_pcie_cfg *cfg;qcom_pcie_icc_update
> > > > > +	bool suspended;
> > > > >   };
> > > > >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > > > @@ -1835,6 +1836,52 @@ static int qcom_pcie_remove(struct platform_device *pdev)
> > > > >   	return 0;
> > > > >   }
> > > > > +static int qcom_pcie_suspend_noirq(struct device *dev)
> > > > > +{
> > > > > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = icc_set_bw(pcie->icc_mem, 0, 0);
> > > > > +	if (ret) {
> > > > > +		dev_err(pcie->pci->dev, "Failed to set interconnect bandwidth: %d\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Turn OFF the resources only for controllers without active PCIe devices. For controllers
> > > > > +	 * with active devices, the resources are kept ON and the link is expected to be in L0/L1
> > > > > +	 * (sub)states.
> > > > > +	 *
> > > > > +	 * Turning OFF the resources for controllers with active PCIe devices will trigger access
> > > > > +	 * violation during the end of the suspend cycle, as kernel tries to access the PCIe devices
> > > > > +	 * config space for masking MSIs.
> > > > > +	 *
> > > > > +	 * Also, it is not desirable to put the link into L2/L3 state as that implies VDD supply
> > > > > +	 * will be removed and the devices may go into powerdown state. This will affect the
> > > > > +	 * lifetime of the storage devices like NVMe.
> > > > > +	 */
> > > > > +	if (!dw_pcie_link_up(pcie->pci)) {
> > > > > +		qcom_pcie_host_deinit(&pcie->pci->pp);
> > > > > +		pcie->suspended = true;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int qcom_pcie_resume_noirq(struct device *dev)
> > > > > +{
> > > > > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > > > > +
> > > > > +	if (pcie->suspended) {
> > > > > +		qcom_pcie_host_init(&pcie->pci->pp);
> > > > > +		pcie->suspended = false;
> > > > > +	}
> > > > > +
> > > > > +	qcom_pcie_icc_update(pcie);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >   static const struct of_device_id qcom_pcie_match[] = {
> > > > >   	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
> > > > >   	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> > > > > @@ -1870,12 +1917,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
> > > > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
> > > > >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
> > > > > +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> > > > > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
> > > > > +};
> > > > > +
> > > > >   static struct platform_driver qcom_pcie_driver = {
> > > > >   	.probe = qcom_pcie_probe,
> > > > >   	.remove = qcom_pcie_remove,
> > > > >   	.driver = {
> > > > >   		.name = "qcom-pcie",
> > > > >   		.of_match_table = qcom_pcie_match,
> > > > > +		.pm = &qcom_pcie_pm_ops,
> > > > >   	},
> > > > >   };
> > > > >   module_platform_driver(qcom_pcie_driver);
> > > > 
> > > > Out of curiosity, were you able to measure how much power you were able
> > > > to save after adding suspend support for PCIe? I don't know if clock
> > > > gating really saves much amount of power, but yeah its true that we
> > > > can't really cut off the power domain entirely in this case.
> > > > 
> > > 
> > > I did not measure the power consumption and I agree that we won't save much
> > > power with setting icc bandwidth to 0. But it is better to have something
> > > than nothing. And in the coming days, I have plans to look into other power
> > > saving measures also.
> > 
> > On a sc7280 system I see a reduction of ~30mW with this patch when no PCI
> > card is plugged in. The reduction seems to come from powering the PHY down.
> > 
> 
> Thanks a lot for testing!
> 
> > Interestingly on that system power consumption during suspend (without this
> > patch) is ~30mW higher *without* a PCI card vs. with a card. Maybe the PHY
> > doesn't enter a low power mode when no card is plugged in?
> 
> Yeah, both PHY and controllers are never put into low power mode even if there
> are no devices connected. I don't know if the low power mode is possible at
> all with PHY.

It's still interesting that the PHY apparently at least enters a *lower* power
mode when a card is plugged in, the extra 30mW are only seen without a card.
