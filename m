Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938DAD8209
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 23:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfJOVVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 17:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfJOVVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 17:21:17 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6F4120663;
        Tue, 15 Oct 2019 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571174477;
        bh=3K/dBRiHOBO6Jzlz9q0mgrO/uoZRy00qv6QIhRJ29pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dJXu+BWJY3D486J01ucuMDxmvZVRnL3ZsGHLNIg8sSUZSTlWSJzfmngiTUiSEvd1V
         icYPjjWiWse2ks45qjEPxDYQiRVpZCWzsUsGTDgkFr1c4dms7MuXuhWLEfjQza58WK
         7FqHwbGZG2JLR9OXUxEI28paPAKTPYsgsLV52efQ=
Date:   Tue, 15 Oct 2019 16:21:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: sysfs: remove pci_bridge_groups and pcie_dev_groups
Message-ID: <20191015212115.GA135279@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015140059.18660-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 03:00:59PM +0100, Ben Dooks wrote:
> The pci_bridge_groups and pcie_dev_groups objects are
> not exported and not used at-all, so remove them to
> fix the following warnings from sparse:
> 
> drivers/pci/pci-sysfs.c:1546:30: warning: symbol 'pci_bridge_groups' was not declared. Should it be static?
> drivers/pci/pci-sysfs.c:1555:30: warning: symbol 'pcie_dev_groups' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/pci-sysfs.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 793412954529..f7028cf3649a 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1543,20 +1543,10 @@ static const struct attribute_group pci_bridge_group = {
>  	.attrs = pci_bridge_attrs,
>  };
>  
> -const struct attribute_group *pci_bridge_groups[] = {
> -	&pci_bridge_group,
> -	NULL,
> -};
> -
>  static const struct attribute_group pcie_dev_group = {
>  	.attrs = pcie_dev_attrs,
>  };
>  
> -const struct attribute_group *pcie_dev_groups[] = {
> -	&pcie_dev_group,
> -	NULL,
> -};
> -
>  static const struct attribute_group pci_dev_hp_attr_group = {
>  	.attrs = pci_dev_hp_attrs,
>  	.is_visible = pci_dev_hp_attrs_are_visible,

I find the sysfs attribute/group/groups stuff quite confusing, but
aren't these now unused also?

  pci_bridge_group
  pcie_dev_group
