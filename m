Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CBD77FCE6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 19:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353798AbjHQRUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 13:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbjHQRUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 13:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50131BF;
        Thu, 17 Aug 2023 10:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D219666B1E;
        Thu, 17 Aug 2023 17:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD8EC433C9;
        Thu, 17 Aug 2023 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292834;
        bh=Q0i/OGnnC5qzI/zu5hKUHPWm4HJuIBakje62Vw6t7tQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gAVPj1QNcjaAYrk8JtXjNEy1ferCbuGcIgW/6EdRA3PvgIkL9UyZHDigCwYVooYPw
         uaq2kV9b90/XE28ydMVg7nzdAmYYePYTQclebga5Lrq8fj2HEBKOzNh/qz9DVVc8em
         l+TvVpEdFhkztSfTLM/4itCGHSX90oIWJvdh0Ewm2NtduGpGK45hPNROT6ct1IKf0q
         FJhnjrJ+zXUmlMRKGMK8wrGBHUGQUHgE8yj7o+22Zb4clo8OWiA8yt9DUkQgAti/oE
         kMUvKzF/RgKFUHmupB/l1Z4UiRjECYB4VLfFQs1kkr66wgacKuou4K1mWR0CHngkqt
         /TkGvotXoIRdw==
Date:   Thu, 17 Aug 2023 12:20:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: qcom: Add sysfs entry to change link speed
 dynamically
Message-ID: <20230817172032.GA321136@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692239684-12697-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 08:04:43AM +0530, Krishna chaitanya chundru wrote:
> PCIe can operate on lower GEN speed if client decided based upon
> the bandwidth & latency requirements. To support dynamic GEN speed
> switch adding this sysfs support.

Who does "client" refer to?  I assume it's the system administrator,
but of course the endpoint is involved in the hardware speed
negotiation, so one could think of the endpoint as a "client" with its
own speed capabilities and requirements.

> To change the GEN speed the link should be in L0, so first disable
> L0s & L1.
> 
> L0s needs to be disabled at both RC & EP because L0s entry is
> independent. For enabling L0s both ends of the link needs to support
> it, so first check if L0s is supported on both ends and then enable
> L0s.

Is there a place to document this sysfs knob?  Why should it be
qcom-specific?  This sounds like generic PCIe functionality.

The ASPM stuff looks like it should be done by aspm.c, not done behind
its back.

Everything here looks generic (not qcom-specific) except the
qcom_pcie_icc_update() and qcom_pcie_opp_update().  Maybe we need some
core infrastructure around this.

> This patch is dependent on "PCI: qcom: Add support for OPP"
> https://lore.kernel.org/linux-arm-msm/1692192264-18515-1-git-send-email-quic_krichai@quicinc.com/T/#t
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 141 +++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 831d158..ad67d17 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -241,10 +241,150 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> +	bool l0s_supported;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static void qcom_pcie_icc_update(struct qcom_pcie *pcie);
> +static void qcom_pcie_opp_update(struct qcom_pcie *pcie);
> +
> +static int qcom_pcie_disable_l0s(struct pci_dev *pdev, void *userdata)
> +{
> +	int lnkctl;
> +
> +	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, &lnkctl);
> +	lnkctl &= ~(PCI_EXP_LNKCTL_ASPM_L0S);
> +	pci_write_config_word(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, lnkctl);
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_check_l0s_support(struct pci_dev *pdev, void *userdata)
> +{
> +	struct pci_dev *parent = pdev->bus->self;
> +	struct qcom_pcie *pcie = userdata;
> +	struct dw_pcie *pci = pcie->pci;
> +	int lnkcap;
> +
> +	 /* check parent supports L0s */
> +	if (parent) {
> +		dev_err(pci->dev, "parent\n");
> +		pci_read_config_dword(parent, pci_pcie_cap(parent) + PCI_EXP_LNKCAP,
> +				  &lnkcap);
> +		if (!(lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)) {
> +			dev_info(pci->dev, "Parent does not support L0s\n");
> +			pcie->l0s_supported = false;
> +			return 0;
> +		}
> +	}
> +
> +	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +			  &lnkcap);
> +	dev_err(pci->dev, "child %x\n", lnkcap);
> +	if (!(lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)) {
> +		dev_info(pci->dev, "Device does not support L0s\n");
> +		pcie->l0s_supported = false;
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_enable_l0s(struct pci_dev *pdev, void *userdata)
> +{
> +	int lnkctl;
> +
> +	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, &lnkctl);
> +	lnkctl |= (PCI_EXP_LNKCTL_ASPM_L0S);
> +	pci_write_config_word(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, lnkctl);
> +
> +	return 0;
> +}
> +
> +static ssize_t qcom_pcie_speed_change_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf,
> +			       size_t count)
> +{
> +	unsigned int current_speed, target_speed, max_speed;
> +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> +	struct pci_bus *child, *root_bus = NULL;
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +	struct dw_pcie *pci = pcie->pci;
> +	struct pci_dev *pdev;
> +	u16 offset;
> +	u32 val;
> +	int ret;
> +
> +	list_for_each_entry(child, &pp->bridge->bus->children, node) {
> +		if (child->parent == pp->bridge->bus) {
> +			root_bus = child;
> +			break;
> +		}
> +	}
> +
> +	pdev = root_bus->self;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +	max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +
> +	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +	current_speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> +
> +	ret = kstrtouint(buf, 10, &target_speed);
> +	if (ret)
> +		return ret;
> +
> +	if (target_speed > max_speed)
> +		return -EINVAL;
> +
> +	if (current_speed == target_speed)
> +		return count;
> +
> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_disable_l0s, pcie);
> +
> +	/* Disable L1 */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
> +	val &= ~(PCI_EXP_LNKCTL_ASPM_L1);
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
> +
> +	/* Set target GEN speed */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
> +	val &= ~PCI_EXP_LNKCTL2_TLS;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, val | target_speed);
> +
> +	ret = pcie_retrain_link(pdev, true);
> +	if (ret)
> +		dev_err(dev, "Link retrain failed %d\n", ret);
> +
> +	/* Enable L1 */
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
> +	val |= (PCI_EXP_LNKCTL_ASPM_L1);
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
> +
> +	pcie->l0s_supported = true;
> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_check_l0s_support, pcie);
> +
> +	if (pcie->l0s_supported)
> +		pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_l0s, pcie);
> +
> +	qcom_pcie_icc_update(pcie);
> +
> +	qcom_pcie_opp_update(pcie);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(qcom_pcie_speed_change);
> +
> +static struct attribute *qcom_pcie_attrs[] = {
> +	&dev_attr_qcom_pcie_speed_change.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(qcom_pcie);
> +
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value_cansleep(pcie->reset, 1);
> @@ -1716,6 +1856,7 @@ static struct platform_driver qcom_pcie_driver = {
>  		.of_match_table = qcom_pcie_match,
>  		.pm = &qcom_pcie_pm_ops,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.dev_groups = qcom_pcie_groups,
>  	},
>  };
>  builtin_platform_driver(qcom_pcie_driver);
> -- 
> 2.7.4
> 
