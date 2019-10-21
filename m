Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D981EDF3FF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfJURRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 13:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJURRj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 13:17:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D961B20882;
        Mon, 21 Oct 2019 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571678258;
        bh=8n+BilFqcAeLRiVDMfASlZVZ2WRjYrEYHbkF6OeRIoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CZz7qhtg0/UcMkgVdbX/vzQvisa+oRoS37bpEG/7ojCxGpfPK4TFDqy7r1DX/H/Bl
         nMzYYEP0psYBx/QMsNizDB9Pxy2WA7ltfA1HS+nLxHuOG3YQKeWg+SvzEOAGwsTwPf
         SdCoOtVxEq2v7HTaN03RUvMAL249fKmzp7mC31Lw=
Date:   Mon, 21 Oct 2019 12:17:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191021171736.GA233393@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare pci core.
> 
> Intel PCIe driver requires Upconfig support, fast training
> sequence configuration and link speed change. So adding the
> respective helper functions in the pcie DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.
> 

> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 val;
> +
> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
> +	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
> +
> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +
> +	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
> +	val |= (PCI_EXP_LNKSTA_SLC << 16) | PCI_EXP_LNKCTL_CCC |
> +	       PCI_EXP_LNKCTL_RCB;

Link Control is only 16 bits wide, so "PCI_EXP_LNKSTA_SLC << 16"
wouldn't make sense.  But I guess you're writing a device-specific
register that is not actually the Link Control as documented in PCIe
r5.0, sec 7.5.3.7, even though the bits are similar?

Likewise, PCI_EXP_LNKCTL_RCB is RO for Root Ports, but maybe you're
telling the device what it should advertise in its Link Control?

PCI_EXP_LNKCTL_CCC is RW.  But doesn't it depend on the components on
both ends of the link?  Do you know what device is at the other end?
I would have assumed that you'd have to start with CCC==0, which
should be most conservative, then set CCC=1 only if you know both ends
have a common clock.

> +	pcie_rc_cfg_wr(lpp, val, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +}
> +

> +static void intel_pcie_max_speed_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 reg, val;
> +
> +	reg = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
> +	switch (lpp->link_gen) {
> +	case PCIE_LINK_SPEED_GEN1:
> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
> +		reg |= PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_2_5GT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN2:
> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
> +		reg |= PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_5_0GT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN3:
> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
> +		reg |= PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_8_0GT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN4:
> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
> +		reg |= PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_16_0GT;
> +		break;
> +	default:
> +		/* Use hardware capability */
> +		val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
> +		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +		reg &= ~PCI_EXP_LNKCTL2_HASD;
> +		reg |= val;
> +		break;
> +	}
> +
> +	pcie_rc_cfg_wr(lpp, reg, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
> +	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);

There are other users of of_pci_get_max_link_speed() that look sort of
similar to this (dra7xx_pcie_establish_link(),
ks_pcie_set_link_speed(), tegra_pcie_prepare_host()).  Do these *need*
to be different, or is there something that could be factored out?

> +}
> +
> +
> +

Remove extra blank lines here.

> +static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
> ...

> +	/* Intel PCIe doesn't configure IO region, so configure
> +	 * viewport to not to access IO region during register
> +	 * read write operations.
> +	 */

This comment doesn't describe the code.  Is there supposed to be some
code here that configures the viewport?  Where do we tell the viewport
not to access IO?

I guess maybe this means something like "tell
dw_pcie_access_other_conf() not to program an outbound ATU for I/O"?
I don't know that structure well enough to write this in a way that
makes sense, but this code doesn't look like it's configuring any
viewports.

Please use usual multi-line comment style, i.e.,

  /*
   * Intel PCIe ...
   */

> +	pci->num_viewport = data->num_viewport;
> +	dev_info(dev, "Intel PCIe Root Complex Port %d init done\n", lpp->id);
> +
> +	return ret;
> +}
