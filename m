Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38D7D60FB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 07:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJYFDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 01:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYFDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 01:03:17 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A103E5;
        Tue, 24 Oct 2023 22:03:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39P52tl9125931;
        Wed, 25 Oct 2023 00:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698210175;
        bh=3zOX6TUjyNNgjljAkOrTg04EXn1HnypXqTsDWnDgMkM=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=KiuO+Qi8x7F7wJgye1QmAuld7eE4GbP5+7VouFlMMzrYe/1EsnKgi7xGS9EhHZwch
         7TcJL8kqBzGG8GKcPsetvmC8eGPDa29k5xKybyjnzP/PRR3j/jCehURfVV3hbitmU9
         UUliMs4da9kAehXo99waO0OMJj4VjlF9x1HvMJIQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39P52tet103204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Oct 2023 00:02:55 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Oct 2023 00:02:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Oct 2023 00:02:55 -0500
Received: from [172.24.227.9] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39P52o6I019290;
        Wed, 25 Oct 2023 00:02:51 -0500
Message-ID: <c7851172-f474-42f3-9730-1f323f9e6c73@ti.com>
Date:   Wed, 25 Oct 2023 10:32:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
References: <20231023212628.GA1627567@bhelgaas>
Content-Language: en-US
In-Reply-To: <20231023212628.GA1627567@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On 24/10/23 02:56, Bjorn Helgaas wrote:
> On Mon, Oct 23, 2023 at 05:05:30PM +0530, Siddharth Vadapalli wrote:
>> On 23/10/23 16:12, Serge Semin wrote:
>>
>> ...
>>
>>> Siddharth, if it won't be that much bother and you have an access to
>>> the v3.65-based Keystone PCIe device, could you please have a look
>>> whether it's possible to implement what Bjorn suggested?
>>
>> Unfortunately I don't have any SoC/Device with me that has the v3.65 PCIe
>> controller, so I will not be able to test Bjorn's suggestion.
> 
> Huh.  57e1d8206e48 ("MAINTAINERS: move Murali Karicheri to credits")
> removed the maintainer for pci-keystone.c, so the driver hasn't had a
> maintainer for over two years.
> 
> Given the fact that there's no maintainer, I'm more than happy to take
> a patch to move this code to somewhere in the host_init() callback,
> even if you don't have the hardware to test it.

Sure, I can work on a patch for it. The execution flow with the existing code is
as follows:

ks_pcie_probe()
    dw_pcie_host_init()
        pci_host_probe()
            ks_pcie_v3_65_add_bus()

So I assume that as long as ks_pcie_v3_65_add_bus() is invoked after
pci_host_probe(), it should be acceptable. With this understanding, I plan to
move it immediately after the invocation to dw_pcie_host_init() within
ks_pcie_probe() conditionally (based on the is_am6 flag). The new call trace
with this change will look like:

ks_pcie_probe()
    dw_pcie_host_init()
        pci_host_probe()
    ks_pcie_v3_65_add_bus()

Since the .add_bus() method will be removed following this change, I suppose
that the patch I post for it can be applied instead of this v3 patch which fixes
pci_ops.

The patch I plan to post as a replacement for the current patch which shall also
remove the ks_pcie_v3_65_add_bus() and the .add_bus() method is:

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 0def919f89fa..3933e857ecaa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -447,44 +447,10 @@ static struct pci_ops ks_child_pcie_ops = {
 	.write = pci_generic_config_write,
 };

-/**
- * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
- * @bus: A pointer to the PCI bus structure.
- *
- * This sets BAR0 to enable inbound access for MSI_IRQ register
- */
-static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
-{
-	struct dw_pcie_rp *pp = bus->sysdata;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	if (!pci_is_root_bus(bus))
-		return 0;
-
-	/* Configure and set up BAR0 */
-	ks_pcie_set_dbi_mode(ks_pcie);
-
-	/* Enable BAR0 */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
-
-	ks_pcie_clear_dbi_mode(ks_pcie);
-
-	 /*
-	  * For BAR0, just setting bus address for inbound writes (MSI) should
-	  * be sufficient.  Use physical address to avoid any conflicts.
-	  */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
-
-	return 0;
-}
-
 static struct pci_ops ks_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = ks_pcie_v3_65_add_bus,
 };

 /**
@@ -1270,6 +1236,29 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
 			goto err_get_sync;
+
+		if (!ks_pcie->is_am6) {
+			/*
+			 * For v3.65 DWC PCIe Controllers, setup BAR0 to enable
+			 * inbound access for MSI_IRQ register.
+			 */
+
+			/* Configure and set up BAR0 */
+			ks_pcie_set_dbi_mode(ks_pcie);
+
+			/* Enable BAR0 */
+			dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+			dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+
+			ks_pcie_clear_dbi_mode(ks_pcie);
+
+			 /*
+			  * For BAR0, just setting bus address for inbound writes (MSI) should
+			  * be sufficient.  Use physical address to avoid any conflicts.
+			  */
+			dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+		}
+
 		break;
 	case DW_PCIE_EP_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_EP)) {

Please review and let me know if this looks fine. If so, I will post the patch for it.

-- 
Regards,
Siddharth.
