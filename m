Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9DC68C9B9
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 23:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBFWnm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 17:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFWnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 17:43:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E0C1A0;
        Mon,  6 Feb 2023 14:43:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C38161052;
        Mon,  6 Feb 2023 22:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7066C433D2;
        Mon,  6 Feb 2023 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675723419;
        bh=LcWE6lqyUx1tYRkadazTCvdsU9i6nzatE7AvkG7OvbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mlpMXJm3wRMm5Koi6JzJMibFX3jucmzuN07kJ+G7q1mAb6gcv6rD+JVPGOeg5Mezs
         uQjLxyStL3ZnRI1FeOKqepOUN9S0X3Q+bTaGmbDUjzpPX7FGbae8o8DQqbVjf+oHP6
         26M1+esJr8/94E5oFmctoZoA1CxxxUn6mx5EUvtgZLmbU3+zUhGsqrfzStOu53zReb
         aldlSGuS7+CIcp1wmo17JqtVKnU4SRxWy7ED3a9MqzRMbr7xQN8eJMq6ZCld0JOBlZ
         VdR5rvQJ3GIqbSIE7Z2oF07T2sggATFvM/YJM2PofCRbHwYjt2FjuE2o6iQ7CoH9/s
         fSvESnAROVnRg==
Date:   Mon, 6 Feb 2023 16:43:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Subject: Re: [PATCH 11/18] PCI: Export pcie_get_width() using the code from
 sysfs PCI link width show function
Message-ID: <20230206224338.GA2256550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167571666013.587790.16270669112177554916.stgit@djiang5-mobl3.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 01:51:01PM -0700, Dave Jiang wrote:
> Move the logic in current_link_width_show() to a common function and export
> that functiuon as pcie_get_width() to allow other drivers to to retrieve
> the current negotiated link width.

s/a common function and export that functiuon and export that functiuon as//

I don't see the module caller of this, so not clear on why it needs to
be exported.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pci-sysfs.c |    9 +--------
>  drivers/pci/pci.c       |   20 ++++++++++++++++++++
>  include/linux/pci.h     |    1 +
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 0217bb5ca8fa..139096c39380 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -215,15 +215,8 @@ static ssize_t current_link_width_show(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> -	u16 linkstat;
> -	int err;
>  
> -	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> -	if (err)
> -		return -EINVAL;
> -
> -	return sysfs_emit(buf, "%u\n",
> -		(linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT);
> +	return sysfs_emit(buf, "%u\n", pcie_get_width(pci_dev));
>  }
>  static DEVICE_ATTR_RO(current_link_width);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d0131b5623b1..0858fa2f1c2d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6235,6 +6235,26 @@ enum pci_bus_speed pcie_get_speed(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pcie_get_speed);
>  
> +/**
> + * pcie_get_width - query for the PCI device's current link width
> + * @dev: PCI device to query
> + *
> + * Query the PCI device current negoiated width.
> + */
> +
> +enum pcie_link_width pcie_get_width(struct pci_dev *dev)
> +{
> +	u16 linkstat;
> +	int err;
> +
> +	err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> +	if (err)
> +		return PCIE_LNK_WIDTH_UNKNOWN;
> +
> +	return FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
> +}
> +EXPORT_SYMBOL(pcie_get_width);
> +
>  /**
>   * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
>   * @dev: PCI device
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6a065986ff8f..21eca09a98e2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -305,6 +305,7 @@ enum pci_bus_speed {
>  
>  enum pci_bus_speed pcie_get_speed(struct pci_dev *dev);
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
> +enum pcie_link_width pcie_get_width(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>  
>  struct pci_vpd {
> 
> 
