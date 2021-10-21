Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3B436522
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUPLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUPLi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 11:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E43F60F9F;
        Thu, 21 Oct 2021 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634828962;
        bh=lqxEVvdfZbCu44YT4ZbFv244WhBD1fJuFoS+40FRFXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qY0tp96LWzxuDoAYTegy1GQG30HadTMVTNqeu9+iw+52nJvw/C9O+Mfj/iTQG2QQm
         kT0VSJLUqB88O932PFo+1FOvEuwiY+E8vT40FKCPEKtLdxkJmvLfDnxxcUsbjvxGVf
         S4n4YKztAWhU5WM0S6xeVBmhYJKfjbIcQcQ6w9SAXnmEUAFZO0j8PqnO809d6Evdr1
         QeeoWe8vhxGt5ItL5hNRdPfKcvDtXU11RWjLwyFWufB7amQkT/ZQNUseWISB/XsBZj
         KsPW6UFfZiQuvRPNqqlE3kdvaoRrUomm5kmMO/+/JLue8aqku+GggZaNBXFVbSP8EN
         I8E+tsqYlMjMg==
Date:   Thu, 21 Oct 2021 10:09:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, hkallweit1@gmail.com,
        anthony.wong@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
Message-ID: <20211021150920.GA2680911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021035159.1117456-4-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 11:51:59AM +0800, Kai-Heng Feng wrote:
> Sometimes BIOS may not be able to program ASPM and LTR settings, for
> instance, the NVMe devices behind Intel VMD bridges. For this case, both
> ASPM and LTR have to be enabled to have significant power saving.
> 
> Since we still want POLICY_DEFAULT honor the default BIOS ASPM settings,
> introduce LTR sysfs knobs so users can set max snoop and max nosnoop
> latency manually or via udev rules.

How is the user supposed to figure out what "max snoop" and "max
nosnoop" values to program?

If we add this, I'm afraid we'll have people programming random things
that seem to work but are not actually reliable.

> [1] https://github.com/systemd/systemd/pull/17899/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209789
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - New patch.
> 
>  drivers/pci/pcie/aspm.c | 59 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 1560859ab056..f7dc62936445 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1299,6 +1299,59 @@ static ssize_t clkpm_store(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t ltr_attr_show_common(struct device *dev,
> +			  struct device_attribute *attr, char *buf, u8 state)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ltr;
> +	u16 val;
> +
> +	ltr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return -EINVAL;
> +
> +	pci_read_config_word(pdev, ltr + state, &val);
> +
> +	return sysfs_emit(buf, "0x%0x\n", val);
> +}
> +
> +static ssize_t ltr_attr_store_common(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len, u8 state)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int ltr;
> +	u16 val;
> +
> +	ltr = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return -EINVAL;
> +
> +	if (kstrtou16(buf, 16, &val) < 0)
> +		return -EINVAL;
> +
> +	/* LatencyScale is not permitted to be 110 or 111 */
> +	if ((val >> 10) > 5)
> +		return -EINVAL;
> +
> +	pci_write_config_word(pdev, ltr + state, val);
> +
> +	return len;
> +}
> +
> +#define LTR_ATTR(_f, _s)						\
> +static ssize_t _f##_show(struct device *dev,				\
> +			 struct device_attribute *attr, char *buf)	\
> +{ return ltr_attr_show_common(dev, attr, buf, PCI_LTR_##_s); }		\
> +									\
> +static ssize_t _f##_store(struct device *dev,				\
> +			  struct device_attribute *attr,		\
> +			  const char *buf, size_t len)			\
> +{ return ltr_attr_store_common(dev, attr, buf, len, PCI_LTR_##_s); }
> +
> +LTR_ATTR(ltr_max_snoop_lat, MAX_SNOOP_LAT);
> +LTR_ATTR(ltr_max_nosnoop_lat, MAX_NOSNOOP_LAT);
> +
>  static DEVICE_ATTR_RW(clkpm);
>  static DEVICE_ATTR_RW(l0s_aspm);
>  static DEVICE_ATTR_RW(l1_aspm);
> @@ -1306,6 +1359,8 @@ static DEVICE_ATTR_RW(l1_1_aspm);
>  static DEVICE_ATTR_RW(l1_2_aspm);
>  static DEVICE_ATTR_RW(l1_1_pcipm);
>  static DEVICE_ATTR_RW(l1_2_pcipm);
> +static DEVICE_ATTR_RW(ltr_max_snoop_lat);
> +static DEVICE_ATTR_RW(ltr_max_nosnoop_lat);
>  
>  static struct attribute *aspm_ctrl_attrs[] = {
>  	&dev_attr_clkpm.attr,
> @@ -1315,6 +1370,8 @@ static struct attribute *aspm_ctrl_attrs[] = {
>  	&dev_attr_l1_2_aspm.attr,
>  	&dev_attr_l1_1_pcipm.attr,
>  	&dev_attr_l1_2_pcipm.attr,
> +	&dev_attr_ltr_max_snoop_lat.attr,
> +	&dev_attr_ltr_max_nosnoop_lat.attr,
>  	NULL
>  };
>  
> @@ -1338,6 +1395,8 @@ static umode_t aspm_ctrl_attrs_are_visible(struct kobject *kobj,
>  
>  	if (n == 0)
>  		return link->clkpm_capable ? a->mode : 0;
> +	else if (n == 7 || n == 8)
> +		return pdev->ltr_path ? a->mode : 0;
>  
>  	return link->aspm_capable & aspm_state_map[n - 1] ? a->mode : 0;
>  }
> -- 
> 2.32.0
> 
