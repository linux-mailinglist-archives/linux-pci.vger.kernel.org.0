Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7A2635FF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIS2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 14:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIS2t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 14:28:49 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19180206E6;
        Wed,  9 Sep 2020 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599676128;
        bh=VvJVb58cdrWVCnAyXeO0QvKAjyVmhEtfZzRcvtr5zKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n1cRMBaMkJtOVd3FpgUXQiz5XgMoBplsgN9dIIQtULKhVEtSTyyyaFbheufQa7RxQ
         4ek2qCV3lqIE8T4H1Ukx2MvoGfZPbf8z+ICk77ivLR7h2QIHOBUKt6G9NQiMfuvBZu
         8sD3CVB+gPeuP/Giac3hyzLTovwVVnTvTfmDHK2U=
Date:   Wed, 9 Sep 2020 13:28:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Reject sysfs attempts to enable states that
 are not covered by policy
Message-ID: <20200909182846.GA719960@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51768aa-8e8d-65e0-497c-eda1741e8a0a@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 20, 2020 at 08:08:59AM +0200, Heiner Kallweit wrote:
> When trying to enable a state that is not covered by the policy,
> then the change request will be silently ignored. That's not too
> nice to the user, therefore reject such attempts explicitly.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd3..cd0f30ca9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1224,11 +1224,16 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> +	u32 policy_state = policy_to_aspm_state(link);
>  	bool state_enable;
>  
>  	if (strtobool(buf, &state_enable) < 0)
>  		return -EINVAL;
>  
> +	/* reject attempts to enable states not covered by policy */
> +	if (state_enable && state & ~policy_state)
> +		return -EPERM;

I really like the sentiment of this patch, but I don't like the fact
that this test for states being covered by the policy is here by
itself.

There must be some place in the pcie_config_aspm_link() path that does
a similar test and silently ignores things not covered by the policy?
If we could take advantage of *that* test, we won't have to worry
about things getting out of sync if we change that test in the future.

Maybe pcie_config_aspm_link() could return -EPERM if the policy
doesn't allow the requested state, and we could just notice that here?

>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  
> @@ -1241,7 +1246,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  		link->aspm_disable |= state;
>  	}
>  
> -	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +	pcie_config_aspm_link(link, policy_state);
>  
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
> -- 
> 2.27.0
> 
