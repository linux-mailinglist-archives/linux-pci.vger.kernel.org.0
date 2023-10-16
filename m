Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513747CB59C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 23:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjJPVsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjJPVsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 17:48:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4DEEB;
        Mon, 16 Oct 2023 14:48:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4BCC433CA;
        Mon, 16 Oct 2023 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697492908;
        bh=xmUchrdBa511fTg4ejYwrhmgta3bscCkkCA28jOMO24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b+ric6N2xWGyn2oE1pzkDnM6Olyd8pkRLzilhqgqOGJ+pMCuBul4DZyF9Qt0crYHA
         OVG0jepWdGVMNwwQSXsOrgnBMzFBQAta7dLTHKpKRrMclcdpC8pXLtQGWHlpsKL08z
         bQVgOiudY5oukcP34Eegb2i1nol/OlUWhW40erTabV0gyi2uYTSjCN5XMyK2XGoJEi
         H9LrACaA/R1aWC3g7amFAz6SIdynX38NicjmJc78d5r5pNOFM7L6a3zEeQ26umSn7t
         PYa/Rs6JYFWW/wKp0d9qzUKGLArEheyZVgNcuR+ov91o7vbULlyQCFqpxM+faLrvI8
         RX6NlR1AxOXGQ==
Date:   Mon, 16 Oct 2023 16:48:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Sriramakrishnan <srk@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid
 unnecessary memory assignment
Message-ID: <20231016214826.GA1226689@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Siddharth, Ravi, Sriramakrishnan]

On Wed, Oct 11, 2023 at 04:14:15PM +0900, Yoshihiro Shimoda wrote:
> According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> assignment during device enumeration. Otherwise, Renesas R-Car Gen4
> PCIe controllers cannot work correctly in host mode.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a7170fd0e847..56cc7ff6d508 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -737,6 +737,14 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  	u32 val, ctrl, num_ctrls;
>  	int ret;
>  
> +	/*
> +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> +	 * assignment during device enumeration.
> +	 */
> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);

I cc'd Siddharth and others because they are working on a Keystone
issue with MSI-X that requires BAR0; see
https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com 

I assume any DWC controller that uses MSI-X would require BAR0 or BAR1
for the MSI-X Table.

I don't have any of the DWC specs and don't know whether any
controllers use MSI-X, so just heads up in case they do.  This patch
was recently merged and will appear in v6.7.

Bjorn
