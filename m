Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97DC7D778F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjJYWFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjJYWFX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 18:05:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF18184;
        Wed, 25 Oct 2023 15:05:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1AEC433C8;
        Wed, 25 Oct 2023 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698271521;
        bh=K37AazOyFgGLh7Rwz9bbbBRRa9M4I7JnYV82L3ucPGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hmqwH2VPlpn+EsaFTF7qlt93Mww7TUJXDiF7WPLfP03DQqPcRLeu3QzI7D+rzU7CY
         Zs6YeyrHGnRMhOJ2GboEBbJE6sFOuBAi5dfJnb61nN04TnGAfUISyiGU4nOapPA4GH
         4AkC+ZpO3C1+oMegqEJEGWmlfTaPjLk+nEy5GEfyKhaADHrWBaCQWINN7O+GGOzbJU
         xkYlUjuJ4CQU2u5YJbwH/5FUvYcY/uBzLB8mznSKJbi0N0VA0uOMlS2QmZefPVdxwv
         mviyhqM+ZG6OEGI8z+pGeUiEqoQeTjxCBNj0zbLmmvDhDsBGS9IWV1KOLYiiBWZzWN
         0wtxAnl7hYdkg==
Date:   Wed, 25 Oct 2023 17:05:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sharath.kumar.d.m@intel.com
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>
Subject: Re: [PATCH v4 2/2] PCI: altera: add support for agilex family fpga
Message-ID: <20231025220518.GA1768317@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917170546.2097352-3-sharath.kumar.d.m@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Joyce]

On Sun, Sep 17, 2023 at 10:35:46PM +0530, sharath.kumar.d.m@intel.com wrote:
> From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
> 
> create new instance of struct altera_pcie_data for
> "altr,pcie-root-port-3.0"
> provide corresponding callback
> "port_conf_off" points to avmm port config register base

Please mention the hardware platform that this corresponds to.

> +	/* interrupt pin not programmed in hardware, set to INTA*/

Add space before closing "*/".

> +	if (status & AGLX_CFG_AER) {
> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
> +		if (ret)
> +			dev_err_ratelimited(dev, "unexpected IRQ\n");

Maybe include a hint about what the unexpected IRQ was?  An IRQ number
or "status" value?

> +static const struct altera_pcie_ops altera_pcie_ops_3_0 = {
> +	.alt_read_own_cfg = aglx_read_own_cfg,
> +	.alt_write_own_cfg = aglx_write_own_cfg,
> +	.get_link_status = aglx_altera_pcie_link_up,
> +	.alt_read_other_cfg = aglx_read_other_cfg,
> +	.alt_write_other_cfg = aglx_write_other_cfg,
> +	.rp_isr = aglx_isr,

Use the same order of function pointers in all of these structs and
make it match the struct altera_pcie_ops definition.  (Don't put
.get_link_status in the middle of the config accessors.)

>  static const struct of_device_id altera_pcie_of_match[] = {
>  	{.compatible = "altr,pcie-root-port-1.0",
>  	 .data = &altera_pcie_1_0_data },
>  	{.compatible = "altr,pcie-root-port-2.0",
>  	 .data = &altera_pcie_2_0_data },
> +	{.compatible = "altr,pcie-root-port-3.0",
> +	.data = &altera_pcie_3_0_data },

Make the .data indentation match the rest.
