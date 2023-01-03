Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73465BEC7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjACLQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 06:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjACLQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 06:16:27 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A997110B;
        Tue,  3 Jan 2023 03:16:26 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 303BGGCi094124;
        Tue, 3 Jan 2023 05:16:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672744576;
        bh=RMcrotq/Tz8HcR5hKM3/+kFg3e7/OG5DejTKOeZFUIY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UCHdUPYII7rIGRosvNkBCmaLPJ9xEA6N3CJW01tt+FD6RjE4Ln/cDhk1nDAw4nNna
         pIsxprzch6QkKVg/igc833PduYVoqfJkWpgCzRhdt4P7TUGtdegA3gmlWgaCIO/F4p
         M40e8aWr000SyP5G/X+4a9x8RWMRCRQDoANCjy1E=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 303BGG5Y029962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 05:16:16 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 3
 Jan 2023 05:16:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 3 Jan 2023 05:16:15 -0600
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 303BGBr3048662;
        Tue, 3 Jan 2023 05:16:12 -0600
Message-ID: <dad3aba3-a40b-8b76-c689-3dc877800263@ti.com>
Date:   Tue, 3 Jan 2023 16:46:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] PCI: qcom: Add support for system suspend and resume
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <robh@kernel.org>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>, <johan+linaro@kernel.org>,
        <steev@kali.org>
References: <20230103074907.12784-1-manivannan.sadhasivam@linaro.org>
 <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230103074907.12784-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 03/01/23 13:19, Manivannan Sadhasivam wrote:
> During the system suspend, vote for minimal interconnect bandwidth and
> also turn OFF the resources like clock and PHY if there are no active
> devices connected to the controller. For the controllers with active
> devices, the resources are kept ON as removing the resources will
> trigger access violation during the late end of suspend cycle as kernel
> tries to access the config space of PCIe devices to mask the MSIs.
> 
> Also, it is not desirable to put the link into L2/L3 state as that
> implies VDD supply will be removed and the devices may go into powerdown
> state. This will affect the lifetime of storage devices like NVMe.
> 
> And finally, during resume, turn ON the resources if the controller was
> truly suspended (resources OFF) and update the interconnect bandwidth
> based on PCIe Gen speed.
> 
> Suggested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Nice to have another driver added to the list of system suspend
support!

Acked-by: Dhruva Gole <d-gole@ti.com>

>   drivers/pci/controller/dwc/pcie-qcom.c | 52 ++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5696e327795b..48810f1f2dba 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -227,6 +227,7 @@ struct qcom_pcie {
>   	struct gpio_desc *reset;
>   	struct icc_path *icc_mem;
>   	const struct qcom_pcie_cfg *cfg;qcom_pcie_icc_update
> +	bool suspended;
>   };
>   
>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1835,6 +1836,52 @@ static int qcom_pcie_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int qcom_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = icc_set_bw(pcie->icc_mem, 0, 0);
> +	if (ret) {
> +		dev_err(pcie->pci->dev, "Failed to set interconnect bandwidth: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Turn OFF the resources only for controllers without active PCIe devices. For controllers
> +	 * with active devices, the resources are kept ON and the link is expected to be in L0/L1
> +	 * (sub)states.
> +	 *
> +	 * Turning OFF the resources for controllers with active PCIe devices will trigger access
> +	 * violation during the end of the suspend cycle, as kernel tries to access the PCIe devices
> +	 * config space for masking MSIs.
> +	 *
> +	 * Also, it is not desirable to put the link into L2/L3 state as that implies VDD supply
> +	 * will be removed and the devices may go into powerdown state. This will affect the
> +	 * lifetime of the storage devices like NVMe.
> +	 */
> +	if (!dw_pcie_link_up(pcie->pci)) {
> +		qcom_pcie_host_deinit(&pcie->pci->pp);
> +		pcie->suspended = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_resume_noirq(struct device *dev)
> +{
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +
> +	if (pcie->suspended) {
> +		qcom_pcie_host_init(&pcie->pci->pp);
> +		pcie->suspended = false;
> +	}
> +
> +	qcom_pcie_icc_update(pcie);
> +
> +	return 0;
> +}
> +
>   static const struct of_device_id qcom_pcie_match[] = {
>   	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>   	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> @@ -1870,12 +1917,17 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
>   
> +static const struct dev_pm_ops qcom_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
> +};
> +
>   static struct platform_driver qcom_pcie_driver = {
>   	.probe = qcom_pcie_probe,
>   	.remove = qcom_pcie_remove,
>   	.driver = {
>   		.name = "qcom-pcie",
>   		.of_match_table = qcom_pcie_match,
> +		.pm = &qcom_pcie_pm_ops,
>   	},
>   };
>   module_platform_driver(qcom_pcie_driver);

Out of curiosity, were you able to measure how much power you were able
to save after adding suspend support for PCIe? I don't know if clock
gating really saves much amount of power, but yeah its true that we
can't really cut off the power domain entirely in this case.

-- 
Thanks and Regards,
Dhruva Gole
