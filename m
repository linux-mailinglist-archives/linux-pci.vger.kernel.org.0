Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E63DF405
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJURSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 13:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJURSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 13:18:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA5DD2086D;
        Mon, 21 Oct 2019 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571678314;
        bh=raWePBp3jLVfFdHI3MbBqyLEtynL7RmrxY4VOVMhTJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HhSMD9jbCOt6G5i7uUOPM/sG0LJgLVkAnrnB5MKZPfzF9r1Au3DrRUn+15HJWWG/t
         1E3lSiH9wuNt373E/FB5ayv5ROT9X/kiGd+OO7n36OElWSaNPvh7I+ZnqqQ6QwEH/G
         55spOPP6fLU8L+ozw1evM6QJBOy2fSI3TEIHc+W0=
Date:   Mon, 21 Oct 2019 12:18:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191021171832.GA232571@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021133849.GQ47056@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > PCIe RC driver on Intel Gateway SoCs have a requirement
> > of changing link width and speed on the fly.

Please add more details about why this is needed.  Since you're adding
sysfs files, it sounds like it's not actually the *driver* that needs
this; it's something in userspace?

The normal scenario is that the hardware negotiates link widths and
speeds without any software involvement (PCIe r5.0, sec 1.2).

If this is to work around hardware defects, we should try to do that
inside the kernel because we can't expect userspace to do it reliably.

As Andrew points out below, this all sounds like it should be generic
rather than Intel-specific.

> > So add the sysfs attributes to show and store the link
> > properties.
> > Add the respective link resize function in pcie DesignWare
> > framework so that Intel PCIe driver can use during link
> > width configuration on the fly.
> > ...

> > +static ssize_t pcie_link_status_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> > +	u32 reg, width, gen;
> > +
> > +	reg = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, reg >> 16);
> > +	gen = FIELD_GET(PCI_EXP_LNKSTA_CLS, reg >> 16);
> > +
> > +	if (gen > lpp->max_speed)
> > +		return -EINVAL;
> > +
> > +	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
> > +		       width, pcie_link_gen_to_str(gen));
> > +}
> > +static DEVICE_ATTR_RO(pcie_link_status);

We already have generic current_link_speed and current_link_width
files.

> > +static ssize_t pcie_speed_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t len)
> > +{
> > +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	ret = kstrtoul(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val > lpp->max_speed)
> > +		return -EINVAL;
> > +
> > +	lpp->link_gen = val;
> > +	intel_pcie_max_speed_setup(lpp);
> > +	dw_pcie_link_speed_change(&lpp->pci, false);
> > +	dw_pcie_link_speed_change(&lpp->pci, true);
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(pcie_speed);
> > +
> > +/*
> > + * Link width change on the fly is not always successful.
> > + * It also depends on the partner.
> > + */
> > +static ssize_t pcie_width_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t len)
> > +{
> > +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
> > +	unsigned long val;
> > +	int ret;
> > +
> > +	lpp = dev_get_drvdata(dev);
> > +
> > +	ret = kstrtoul(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val > lpp->max_width)
> > +		return -EINVAL;
> > +
> > +	/* HW auto bandwidth negotiation must be enabled */
> > +	pcie_rc_cfg_wr_mask(lpp, PCI_EXP_LNKCTL_HAWD, 0,
> > +			    PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> > +	dw_pcie_link_width_resize(&lpp->pci, val);
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(pcie_width);
> > +
> > +static struct attribute *pcie_cfg_attrs[] = {
> > +	&dev_attr_pcie_link_status.attr,
> > +	&dev_attr_pcie_speed.attr,
> > +	&dev_attr_pcie_width.attr,
> > +	NULL,
> > +};
> 
> Is there a reason that these are limited only to the Intel driver and
> not the wider set of DWC drivers?
> 
> Is there anything specific here about the Intel GW driver?
