Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669BF57A8BE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiGSVEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 17:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGSVEe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 17:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AC50721;
        Tue, 19 Jul 2022 14:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23AD5B81D4E;
        Tue, 19 Jul 2022 21:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6D4C341C6;
        Tue, 19 Jul 2022 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658264669;
        bh=HKPdeEQ/6HnoatBYVcVwPMjZ1CI7YyWcl3Vrd+PB5bU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dd2VIYA8HRRe7dXnZGqbiV0DLc7+CPVQEJ8hr8C5TR5JIJVCyojrIWfXH2n/NboNq
         Hk+GikxAl3EaaMeWRA6TR/e1FQzV3ktMcNfR8OY2CxYo41JR3So2gzOifdarYIg3ms
         Ntgum6IXlkcQKlWAeOvMGWfdizXm1y6Yy7X7/H4wRZ+RgXHenfV5CI3plC1RYFIZ8k
         3TQVQUNAqvPHFt5TxAMDsd4NtLby2lnMnTipU0P7Mv8rXIPtHTaIdmSdl7fpVls5U6
         ZWH07cLrb+jLjDuxmOyWhrhm5ffBeMYC0sZkxMtaD7vidSJqbczKgC+krAd2bsfO1X
         vcmDPa9pu0uWg==
Date:   Tue, 19 Jul 2022 16:04:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Krzysztof@debian,
        =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: build failure of next-20220718 due to 'imx6_pcie_host_exit'
 defined but not used
Message-ID: <20220719210427.GA1568454@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVKzW4vh1nRSqbx@debian>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 12:58:05PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> Not sure if it has been reported, builds of alpha, csky, xtensa, riscv, s390 allmodsconfig
> have failed to build next-20220718 with the error:
> 
> 
> drivers/pci/controller/dwc/pci-imx6.c:973:13: error: 'imx6_pcie_host_exit' defined but not used [-Werror=unused-function]
>   973 | static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>       |             ^~~~~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pci-imx6.c:904:13: error: 'imx6_pcie_stop_link' defined but not used [-Werror=unused-function]
>   904 | static void imx6_pcie_stop_link(struct dw_pcie *pci)
>       |             ^~~~~~~~~~~~~~~~~~~

Thanks for the report!  I propose the following patch, which I have
tentatively applied to my pci/ctrl/imx6 branch:


commit 0e4daeaa52ca ("PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Jul 19 15:50:18 2022 -0500

    PCI: imx6: Convert to NOIRQ_SYSTEM_SLEEP_PM_OPS()
    
    Replace SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() with NOIRQ_SYSTEM_SLEEP_PM_OPS(),
    which has the advantage that the compiler always sees the PM callbacks as
    referenced, so they don't need to be wrapped with "#ifdef CONFIG_PM_SLEEP"
    or tagged with "__maybe_unused" to avoid "defined but not used" warnings.
    
    See 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5ea01ed4674d..6f1dfbfc4304 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -884,7 +884,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx6_pcie_start_link,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
@@ -1008,11 +1007,10 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops imx6_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
-				      imx6_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
+				  imx6_pcie_resume_noirq)
 };
 
 static int imx6_pcie_probe(struct platform_device *pdev)
