Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0B4EA3A8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 01:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiC1Xdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 19:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiC1Xdq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 19:33:46 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796E84BFFC
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 16:32:04 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 3A451120857;
        Mon, 28 Mar 2022 23:32:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 03F042E;
        Mon, 28 Mar 2022 23:31:53 +0000 (UTC)
Message-ID: <8569d431ce4e1d64ae271f0498c7a0395d2c5c7e.camel@perches.com>
Subject: Re: [PATCH 03/16] PCI: dwc: Add more verbose link-up message
From:   Joe Perches <joe@perches.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Mar 2022 16:31:53 -0700
In-Reply-To: <20220324013734.18234-4-Sergey.Semin@baikalelectronics.ru>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
         <20220324013734.18234-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 03F042E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: meuo49tiime8xmtnwejfrcwtzrcjaoci
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX181O1cQlVu9KyimR2kDvRtMJRaMI+j7axg=
X-HE-Tag: 1648510313-438953
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-03-24 at 04:37 +0300, Serge Semin wrote:
> Printing just "link up" isn't that much informative especially when it
> comes to working with the PCI Express bus. Even if the link is up, due to
> multiple reasons the bus performance can degrade to slower speeds or to
> narrower width than both Root Port and its partner is capable of. In that
> case it would be handy to know the link specifications as early as
> possible. So let's add a more verbose message to the busy-wait link-state
> method, which will contain the link speed generation and the PCIe bus
> width in case if the link up state is discovered. Otherwise an error will
> be printed to the system log.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 22 +++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
[]
> @@ -528,14 +528,26 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  
>  	/* Check if the link is up or not */
>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (dw_pcie_link_up(pci)) {
> -			dev_info(pci->dev, "Link up\n");
> -			return 0;
> -		}
> +		if (dw_pcie_link_up(pci))
> +			break;
> +
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}
>  
> -	dev_info(pci->dev, "Phy link never came up\n");
> +	if (retries < LINK_WAIT_MAX_RETRIES) {
> +		u32 offset, val;
> +
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +		dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +			 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +			 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +
> +		return 0;
> +	}
> +
> +	dev_err(pci->dev, "Phy link never came up\n");
>  
>  	return -ETIMEDOUT;
>  }

IMO: it's generally bette to test the error condition and unindent
the typical return.

	if (retries >= LINK_WAIT_MAX_RETRIES) {
		dev_err(pci->dev, "Phy link never came up\n");
		return -ETIMEDOUT;
	}

	offset = ...
	val = ...
	dev_info(...)

	return 0;
}

