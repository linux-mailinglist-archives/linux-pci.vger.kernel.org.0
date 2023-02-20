Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4E69D2D1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 19:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBTSjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 13:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTSjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 13:39:03 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B5193EA
        for <linux-pci@vger.kernel.org>; Mon, 20 Feb 2023 10:38:59 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1986B15ED;
        Mon, 20 Feb 2023 19:38:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1676918335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIishryXESm0oiy+X2Z8dWTb5c05YKmyoo9koQcl8wM=;
        b=du9LdEWzJ9DfbAYeHA/gWwUFFqC0VN91AnkxU6DA7PMwI/BHHFyC7rCUS3LyJjiqf3OX/f
        xPtf9hjbOXIJE7k143DTXjmtPpQ2hSrte7KV0Ui158VEYYbc9YnLB0lzdzX2MXnZw4xa9R
        GqeJ2lgMwZ910YlTHFHVR7eRZKJ1prhchRPXwHekK1OWcWPzrc7XLzFK5iU/UDF83J1pWA
        UYDwozEwF6R/mlCqsW8p9F2sGPkmls7iWiKJASXvt9ZW7wktidEvhUq7aG3Gu4lYJgRaMu
        SH8TzVn7cYEASZRqFUklT/NTVZP2ifLRrrdV1CpEWOE8qldt7hoNvlQXo3v3lA==
MIME-Version: 1.0
Date:   Mon, 20 Feb 2023 19:38:55 +0100
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on
 kontron-pitx-imx8m
In-Reply-To: <Y/O3mXPe5zAQvMOz@sirena.org.uk>
References: <63f141b2.170a0220.57e67.6c7c@mx.google.com>
 <Y/O3mXPe5zAQvMOz@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d2ded53ad0e26585b3d40b6adc90e0cd@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Heiko as the owner of this board]

> On Sat, Feb 18, 2023 at 01:22:58PM -0800, KernelCI bot wrote:
> 
> The KernelCI bisection bot identified a failure to probe the Intel GBE
> driver on kontron-pitx-imx8m as coming from commit 75c2f26da03f ("PCI:
> imx6: Add i.MX PCIe EP mode support").  Looking at the commit it's
> changed PCI_IMX6 to be selected by two new options PCI_IMX6_HOST and
> PCI_IMX6_EP but there's been no corresponding update to defconfig so
> the arm64 defconfig, it just has CONFIG_PCI_IMX6=y which gets 
> deselected
> automatically.  This is going to affect all PCI on i.MX platforms.  
> I'll
> send a patch.
> 
> The issue can be seen on today's -next with a plain defconfig:
> 
>    https://linux.kernelci.org/test/plan/id/63f32296682b9971318c8653/
> 
> The defconfig we generate is at:
> 
> 
> https://storage.kernelci.org/next/master/next-20230220/arm64/defconfig/clang-17/config/kernel.config
> 
> Full details from the bot, including a tag for it and bisection log
> below:
> 
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> 
>> next/master bisection: baseline.bootrr.intel-igb-probed on 
>> kontron-pitx-imx8m
>> 
>> Summary:
>>   Start:      9d9019bcea1a Add linux-next specific files for 20230215
>>   Plain log:  
>> https://storage.kernelci.org/next/master/next-20230215/arm64/defconfig+videodec/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
>>   HTML log:   
>> https://storage.kernelci.org/next/master/next-20230215/arm64/defconfig+videodec/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
>>   Result:     75c2f26da03f PCI: imx6: Add i.MX PCIe EP mode support
>> 
>> Checks:
>>   revert:     PASS
>>   verify:     PASS
>> 
>> Parameters:
>>   Tree:       next
>>   URL:        
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>   Branch:     master
>>   Target:     kontron-pitx-imx8m
>>   CPU arch:   arm64
>>   Lab:        lab-kontron
>>   Compiler:   gcc-10
>>   Config:     defconfig+videodec
>>   Test case:  baseline.bootrr.intel-igb-probed
>> 
>> Breaking commit found:
>> 
>> -------------------------------------------------------------------------------
>> commit 75c2f26da03f93e988cd7678722ea893a8c63796
>> Author: Richard Zhu <hongxing.zhu@nxp.com>
>> Date:   Mon Jan 16 13:41:21 2023 +0800
>> 
>>     PCI: imx6: Add i.MX PCIe EP mode support
>> 
>>     i.MX PCIe is one dual mode PCIe controller.
>> 
>>     Add i.MX PCIe EP mode support here, and split the PCIe modes to 
>> the Root
>>     Complex mode and Endpoint mode.
>> 
>>     Link: 
>> https://lore.kernel.org/r/1673847684-31893-12-git-send-email-hongxing.zhu@nxp.com
>>     Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>     Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> 
>> diff --git a/drivers/pci/controller/dwc/Kconfig 
>> b/drivers/pci/controller/dwc/Kconfig
>> index a0d2713f0e88..dffd7fbdfb98 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -92,10 +92,31 @@ config PCI_EXYNOS
>>  	  functions to implement the driver.
>> 
>>  config PCI_IMX6
>> -	bool "Freescale i.MX6/7/8 PCIe controller"
>> +	bool
>> +
>> +config PCI_IMX6_HOST
>> +	bool "Freescale i.MX6/7/8 PCIe controller host mode"
>>  	depends on ARCH_MXC || COMPILE_TEST
>>  	depends on PCI_MSI
>>  	select PCIE_DW_HOST
>> +	select PCI_IMX6
>> +	help
>> +	  Enables support for the PCIe controller in the i.MX SoCs to
>> +	  work in Root Complex mode. The PCI controller on i.MX is based
>> +	  on DesignWare hardware and therefore the driver re-uses the
>> +	  DesignWare core functions to implement the driver.
>> +
>> +config PCI_IMX6_EP
>> +	bool "Freescale i.MX6/7/8 PCIe controller endpoint mode"
>> +	depends on ARCH_MXC || COMPILE_TEST
>> +	depends on PCI_ENDPOINT
>> +	select PCIE_DW_EP
>> +	select PCI_IMX6
>> +	help
>> +	  Enables support for the PCIe controller in the i.MX SoCs to
>> +	  work in endpoint mode. The PCI controller on i.MX is based
>> +	  on DesignWare hardware and therefore the driver re-uses the
>> +	  DesignWare core functions to implement the driver.
>> 
>>  config PCIE_SPEAR13XX
>>  	bool "STMicroelectronics SPEAr PCIe controller"
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c 
>> b/drivers/pci/controller/dwc/pci-imx6.c
>> index 1dde5c579edc..572faa91eea7 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -60,6 +60,7 @@ enum imx6_pcie_variants {
>> 
>>  struct imx6_pcie_drvdata {
>>  	enum imx6_pcie_variants variant;
>> +	enum dw_pcie_device_mode mode;
>>  	u32 flags;
>>  	int dbi_length;
>>  	const char *gpr;
>> @@ -159,17 +160,20 @@ static unsigned int imx6_pcie_grp_offset(const 
>> struct imx6_pcie *imx6_pcie)
>> 
>>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>>  {
>> -	unsigned int mask, val;
>> +	unsigned int mask, val, mode;
>> +
>> +	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
>> +		mode = PCI_EXP_TYPE_ENDPOINT;
>> +	else
>> +		mode = PCI_EXP_TYPE_ROOT_PORT;
>> 
>>  	if (imx6_pcie->drvdata->variant == IMX8MQ &&
>>  	    imx6_pcie->controller_id == 1) {
>>  		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
>> -		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>> -				  PCI_EXP_TYPE_ROOT_PORT);
>> +		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE, mode);
>>  	} else {
>>  		mask = IMX6Q_GPR12_DEVICE_TYPE;
>> -		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
>> -				  PCI_EXP_TYPE_ROOT_PORT);
>> +		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
>>  	}
>> 
>>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
>> @@ -1003,8 +1007,99 @@ static const struct dw_pcie_host_ops 
>> imx6_pcie_host_ops = {
>> 
>>  static const struct dw_pcie_ops dw_pcie_ops = {
>>  	.start_link = imx6_pcie_start_link,
>> +	.stop_link = imx6_pcie_stop_link,
>> +};
>> +
>> +static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> +	enum pci_barno bar;
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	for (bar = BAR_0; bar <= BAR_5; bar++)
>> +		dw_pcie_ep_reset_bar(pci, bar);
>> +}
>> +
>> +static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>> +				  enum pci_epc_irq_type type,
>> +				  u16 interrupt_num)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +
>> +	switch (type) {
>> +	case PCI_EPC_IRQ_LEGACY:
>> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
>> +	case PCI_EPC_IRQ_MSI:
>> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>> +	case PCI_EPC_IRQ_MSIX:
>> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
>> +	default:
>> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pci_epc_features imx8m_pcie_epc_features = {
>> +	.linkup_notifier = false,
>> +	.msi_capable = true,
>> +	.msix_capable = false,
>> +	.reserved_bar = 1 << BAR_1 | 1 << BAR_3,
>> +	.align = SZ_64K,
>> +};
>> +
>> +static const struct pci_epc_features*
>> +imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
>> +{
>> +	return &imx8m_pcie_epc_features;
>> +}
>> +
>> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
>> +	.ep_init = imx6_pcie_ep_init,
>> +	.raise_irq = imx6_pcie_ep_raise_irq,
>> +	.get_features = imx6_pcie_ep_get_features,
>>  };
>> 
>> +static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>> +			   struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	unsigned int pcie_dbi2_offset;
>> +	struct dw_pcie_ep *ep;
>> +	struct resource *res;
>> +	struct dw_pcie *pci = imx6_pcie->pci;
>> +	struct dw_pcie_rp *pp = &pci->pp;
>> +	struct device *dev = pci->dev;
>> +
>> +	imx6_pcie_host_init(pp);
>> +	ep = &pci->ep;
>> +	ep->ops = &pcie_ep_ops;
>> +
>> +	switch (imx6_pcie->drvdata->variant) {
>> +	default:
>> +		pcie_dbi2_offset = SZ_4K;
>> +		break;
>> +	}
>> +	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, 
>> "addr_space");
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	ep->phys_base = res->start;
>> +	ep->addr_size = resource_size(res);
>> +	ep->page_size = SZ_64K;
>> +
>> +	ret = dw_pcie_ep_init(ep);
>> +	if (ret) {
>> +		dev_err(dev, "failed to initialize endpoint\n");
>> +		return ret;
>> +	}
>> +	/* Start LTSSM. */
>> +	imx6_pcie_ltssm_enable(dev);
>> +
>> +	return 0;
>> +}
>> +
>>  static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>>  {
>>  	struct device *dev = imx6_pcie->pci->dev;
>> @@ -1279,15 +1374,22 @@ static int imx6_pcie_probe(struct 
>> platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>> 
>> -	ret = dw_pcie_host_init(&pci->pp);
>> -	if (ret < 0)
>> -		return ret;
>> +	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>> +		ret = imx6_add_pcie_ep(imx6_pcie, pdev);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else {
>> +		ret = dw_pcie_host_init(&pci->pp);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (pci_msi_enabled()) {
>> +			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
>> 
>> -	if (pci_msi_enabled()) {
>> -		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
>> -		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
>> -		val |= PCI_MSI_FLAGS_ENABLE;
>> -		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>> +			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
>> +			val |= PCI_MSI_FLAGS_ENABLE;
>> +			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>> +		}
>>  	}
>> 
>>  	return 0;
>> -------------------------------------------------------------------------------
>> 
>> 
>> Git bisection log:
>> 
>> -------------------------------------------------------------------------------
>> git bisect start
>> # good: [d5a1224aa68c8b124a4c5c390186e571815ed390] drm/i915/gen11: 
>> Wa_1408615072/Wa_1407596294 should be on GT list
>> git bisect good d5a1224aa68c8b124a4c5c390186e571815ed390
>> # bad: [9d9019bcea1aac7eed64a1a4966282b6b7b141c8] Add linux-next 
>> specific files for 20230215
>> git bisect bad 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
>> # bad: [e8b85852ecfd21f4aca6456423c7e7eebd4de095] Merge branch 
>> 'master' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
>> git bisect bad e8b85852ecfd21f4aca6456423c7e7eebd4de095
>> # good: [230c2111794b1c5547149a9378fede8407a5f585] Merge branch 
>> 'nfsd-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
>> git bisect good 230c2111794b1c5547149a9378fede8407a5f585
>> # good: [7cd8200555d4f01183f0b9071e0760c389a51816] wifi: rtw89: coex: 
>> Refine coexistence log
>> git bisect good 7cd8200555d4f01183f0b9071e0760c389a51816
>> # bad: [321bd02ae8d76684597db34f3a43bb39988f4e3e] Merge branch 
>> 'master' of git://linuxtv.org/mchehab/media-next.git
>> git bisect bad 321bd02ae8d76684597db34f3a43bb39988f4e3e
>> # bad: [80c52d59cb5d51a2a1e10b2c4f4ef6adb92049cd] Merge branch 
>> 'i3c/next' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
>> git bisect bad 80c52d59cb5d51a2a1e10b2c4f4ef6adb92049cd
>> # good: [32feb85935981e8cd3b44efa5d0e636f6000c29c] Merge branch 
>> 'for-next' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
>> git bisect good 32feb85935981e8cd3b44efa5d0e636f6000c29c
>> # good: [760f504ec490c502a27b477089baecc5f3dab4db] Merge branch 
>> 'for-6.3/logitech' into for-next
>> git bisect good 760f504ec490c502a27b477089baecc5f3dab4db
>> # bad: [c51b1767b4df2c81270ab6942ab84675341c21ed] Merge branch 
>> 'pci/controller/mvebu'
>> git bisect bad c51b1767b4df2c81270ab6942ab84675341c21ed
>> # good: [0e159888fa3b75c8d9bddb1186552c5bd1496816] Merge branch 
>> 'pci/endpoint'
>> git bisect good 0e159888fa3b75c8d9bddb1186552c5bd1496816
>> # good: [7119685cf49033b777c559ae4da093be2a9b225c] dmaengine: dw-edma: 
>> Drop DT-region allocation
>> git bisect good 7119685cf49033b777c559ae4da093be2a9b225c
>> # good: [87616c47e354eec4e64baffa1779ba2b30e51120] Merge branch 
>> 'pci/controller/dwc'
>> git bisect good 87616c47e354eec4e64baffa1779ba2b30e51120
>> # bad: [530ba41250b69db4b5beb9fc03bd7183881c5e7f] PCI: imx6: Add 
>> i.MX8MQ PCIe EP support
>> git bisect bad 530ba41250b69db4b5beb9fc03bd7183881c5e7f
>> # good: [2dd6dc57d2da459983ded133767d0389194f15b8] dt-bindings: 
>> imx6q-pcie: Add i.MX8MP PCIe EP mode compatible string
>> git bisect good 2dd6dc57d2da459983ded133767d0389194f15b8
>> # bad: [75c2f26da03f93e988cd7678722ea893a8c63796] PCI: imx6: Add i.MX 
>> PCIe EP mode support
>> git bisect bad 75c2f26da03f93e988cd7678722ea893a8c63796
>> # good: [01ea5ede419733fdc39e75875f0861d16a829fe6] misc: 
>> pci_endpoint_test: Add i.MX8 PCIe EP device support
>> git bisect good 01ea5ede419733fdc39e75875f0861d16a829fe6
>> # first bad commit: [75c2f26da03f93e988cd7678722ea893a8c63796] PCI: 
>> imx6: Add i.MX PCIe EP mode support
>> -------------------------------------------------------------------------------
>> 
>> 
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#38383): 
>> https://groups.io/g/kernelci-results/message/38383
>> Mute This Topic: https://groups.io/mt/97056400/1131744
>> Group Owner: kernelci-results+owner@groups.io
>> Unsubscribe: https://groups.io/g/kernelci-results/unsub 
>> [broonie@kernel.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
>> 
>> 
