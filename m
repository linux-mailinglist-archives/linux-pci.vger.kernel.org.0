Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8632B7941D6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbjIFRIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 13:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjIFRIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 13:08:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024C1998;
        Wed,  6 Sep 2023 10:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB3AC433C8;
        Wed,  6 Sep 2023 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694020095;
        bh=Ig/k1GbgPg6OmKwwM82+oz8Y85Fx+ZiNym6sZhl4jLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E8Y+9zu0D6epCNqmp77C8CQepON8oe2SdWDbDV4CDY6YbQch+jYsszjI6/F3L2CAq
         DXctAQ/Vze85y3ou3VMErzA7Z5NBCDlOVI+c34arIGqASvoiLPM+Ih+PwtgZly6fVc
         KiWHgaOd2NIQnn1MoUWbwE5uCyYYk0blVifHCgfTHh05anZoT0t7Kgse647s0xR69Y
         9A00kxSKk2uspn1BE1gNZ6QpCUazgDg+527Sa3tJHJRjbEndxm5MW7QtSILHAKemj2
         B1q3K6Ja6DCAwETARlWeh9lzxN7X8y8U1rdQNh9xe6DW68v6j+w7Uyj3sbKqLvsuyM
         OYerQsLMwKZEw==
Date:   Wed, 6 Sep 2023 12:08:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sharath.kumar.d.m@intel.com
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Message-ID: <20230906170812.GA230066@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906110918.1501376-2-sharath.kumar.d.m@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize subject line to match history:

  PCI: altera: Refactor driver for supporting new platform

On Wed, Sep 06, 2023 at 04:39:17PM +0530, sharath.kumar.d.m@intel.com wrote:
> From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

Needs a commit log.  It's OK to repeat the subject line.  Also helpful
if you can hint about why it needs to be refactored.  In this case, it
looks like you'll need to have a different ISR for Agilex, and also
something different about root bus vs downstream config accesses.

> @@ -100,10 +101,15 @@ struct altera_pcie_ops {
>  	void (*tlp_write_pkt)(struct altera_pcie *pcie, u32 *headers,
>  			      u32 data, bool align);
>  	bool (*get_link_status)(struct altera_pcie *pcie);
> -	int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> -			   int size, u32 *value);
> +	int (*rp_read_cfg)(struct altera_pcie *pcie, u8 busno,
> +			unsigned int devfn, int where, int size, u32 *value);
>  	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
> -			    int where, int size, u32 value);
> +			unsigned int devfn, int where, int size, u32 value);
> +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> +			unsigned int devfn, int where, int size, u32 *value);
> +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> +			unsigned int devfn, int where, int size, u32 value);

"ep_read_cfg" isn't the ideal name because it suggests "endpoint", but
it may be either an endpoint or a switch upstream port.  The rockchip
driver uses "other", which isn't super descriptive either but might be
better.

> +	void (*rp_isr)(struct irq_desc *desc);
>  };

> +static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
> +				 unsigned int devfn, int where, int size,
> +				 u32 *value)
> +{
> +	if (busno == pcie->root_bus_nr && pcie->pcie_data->ops->rp_read_cfg)
> +		return pcie->pcie_data->ops->rp_read_cfg(pcie, busno, devfn,
> +							where, size, value);

Several other drivers use pci_is_root_bus() instead of keeping track
of root_bus_nr and watching for changes to it.  Maybe simpler and more
reliable?  That would be best as a separate patch all by itself if you
go that direction.

> +
> +	if (pcie->pcie_data->ops->ep_read_cfg)
> +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno, devfn,
> +							where, size, value);
> +	return PCIBIOS_FUNC_NOT_SUPPORTED;
> +}
