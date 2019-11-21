Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5110568D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUQIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 11:08:46 -0500
Received: from foss.arm.com ([217.140.110.172]:58734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfKUQIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 11:08:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5679328;
        Thu, 21 Nov 2019 08:08:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DCA13F52E;
        Thu, 21 Nov 2019 08:08:45 -0800 (PST)
Date:   Thu, 21 Nov 2019 16:08:43 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Anvesh Salveru <anvesh.s@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v4 1/2] phy: core: add phy_property_present method
Message-ID: <20191121160842.GC43905@e119886-lin.cambridge.arm.com>
References: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
 <CGME20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21@epcas5p1.samsung.com>
 <1574306408-4360-2-git-send-email-anvesh.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574306408-4360-2-git-send-email-anvesh.s@samsung.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 08:50:07AM +0530, Anvesh Salveru wrote:
> In some platforms, we need information of phy properties in
> the controller drivers. This patch adds a new phy_property_present()
> method which can be used to check if some property exists in PHY
> or not.
> 
> In case of DesignWare PCIe controller, we need to write into controller
> register to specify about ZRX-DC compliance property of the PHY, which
> reduces the power consumption during lower power states.
> 
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  drivers/phy/phy-core.c  | 26 ++++++++++++++++++++++++++
>  include/linux/phy/phy.h |  8 ++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index b04f4fe..0a62eca 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -420,6 +420,32 @@ int phy_calibrate(struct phy *phy)
>  EXPORT_SYMBOL_GPL(phy_calibrate);
>  
>  /**
> + * phy_property_present() - checks if the property is present in PHY
> + * @phy: the phy returned by phy_get()
> + * @property: name of the property to check
> + *
> + * Used to check if the given property is present in PHY. PHY drivers
> + * can implement this callback function to expose PHY properties to
> + * controller drivers.
> + *
> + * Returns: true if property exists, false otherwise
> + */
> +bool phy_property_present(struct phy *phy, const char *property)
> +{
> +	bool ret;
> +
> +	if (!phy || !phy->ops->property_present)
> +		return false;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->property_present(phy, property);

I don't understand why it is necessary to require every phy driver to
implement this. Why can't the phy-core driver look up the device node
of the given phy?

Thanks,

Andrew Murray

> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_property_present);
> +
> +/**
>   * phy_configure() - Changes the phy parameters
>   * @phy: the phy returned by phy_get()
>   * @opts: New configuration to apply
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 15032f14..3dd8f3c 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -61,6 +61,7 @@ union phy_configure_opts {
>   * @reset: resetting the phy
>   * @calibrate: calibrate the phy
>   * @release: ops to be performed while the consumer relinquishes the PHY
> + * @property_present: check if some property is present in PHY
>   * @owner: the module owner containing the ops
>   */
>  struct phy_ops {
> @@ -103,6 +104,7 @@ struct phy_ops {
>  	int	(*reset)(struct phy *phy);
>  	int	(*calibrate)(struct phy *phy);
>  	void	(*release)(struct phy *phy);
> +	bool	(*property_present)(struct phy *phy, const char *property);
>  	struct module *owner;
>  };
>  
> @@ -217,6 +219,7 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
>  }
>  int phy_reset(struct phy *phy);
>  int phy_calibrate(struct phy *phy);
> +bool phy_property_present(struct phy *phy, const char *property);
>  static inline int phy_get_bus_width(struct phy *phy)
>  {
>  	return phy->attrs.bus_width;
> @@ -354,6 +357,11 @@ static inline int phy_calibrate(struct phy *phy)
>  	return -ENOSYS;
>  }
>  
> +static inline bool phy_property_present(struct phy *phy, const char *property)
> +{
> +	return false;
> +}
> +
>  static inline int phy_configure(struct phy *phy,
>  				union phy_configure_opts *opts)
>  {
> -- 
> 2.7.4
> 
