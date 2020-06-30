Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3273B20FFCE
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgF3WBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 18:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgF3WBK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 18:01:10 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B30206B6;
        Tue, 30 Jun 2020 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593554469;
        bh=gVkLD6MF+LTfC2BUBwZ7K7ZonyRQ7eFt5NUbE8XpAaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U6Jo9NP2zkP3pskixOJ5KwW4ymdxBm4ffU7E0Nnv4vZoUlUw6XtR+xR121DD6Avja
         Wo64W98uIcU152IAyHyZ5uH1Y+5KXqSb+Hqkw+RN9wZQHVXbPuCbOhvoAxESDjEoYx
         AP3fuzdY6qMGOEWiOPQifB5ryvoDUQGQRLu/8ZmI=
Date:   Tue, 30 Jun 2020 17:01:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Make pcie_find_root_port() work for PCIe root ports
 as well
Message-ID: <20200630220107.GA3489322@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622161248.51099-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 07:12:48PM +0300, Mika Westerberg wrote:
> Commit 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
> pci_find_pcie_root_port()") unified the root port finding functionality
> into a single function but missed the fact that the passed in device may
> already be a root port. This causes the kernel to block power management
> of PCIe hierarchies in recent systems because ->bridge_d3 started to
> return false for such ports after the commit in question.
> 
> Fixes: 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/pci.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c79d83304e52..c17c24f5eeed 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2169,8 +2169,13 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
>   */
>  static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>  {
> -	struct pci_dev *bridge = pci_upstream_bridge(dev);
> +	struct pci_dev *bridge;
>  
> +	/* If dev is already root port */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		return dev;
> +
> +	bridge = pci_upstream_bridge(dev);
>  	while (bridge) {
>  		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
>  			return bridge;

I applied the patch below, which is slightly simplified but I think
still equivalent, to for-linus for v5.8.  Let me know if it's not.

I dropped the stable tag because 6ae72bfa656e was merged for v5.8-rc1,
and I assume v5.7 works correctly so it doesn't need any change.


commit 5396956cc7c6 ("PCI: Make pcie_find_root_port() work for Root Ports")
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Mon Jun 22 19:12:48 2020 +0300

    PCI: Make pcie_find_root_port() work for Root Ports
    
    Commit 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
    pci_find_pcie_root_port()") broke acpi_pci_bridge_d3() because calling
    pcie_find_root_port() on a Root Port returned NULL when it should return
    the Root Port, which in turn broke power management of PCIe hierarchies.
    
    Rework pcie_find_root_port() so it returns its argument when it is already
    a Root Port.
    
    [bhelgaas: test device only once, test for PCIe]
    Fixes: 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and pci_find_pcie_root_port()")
    Link: https://lore.kernel.org/r/20200622161248.51099-1-mika.westerberg@linux.intel.com
    Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c79d83304e52..34c1c4f45288 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2169,12 +2169,11 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
  */
 static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 {
-	struct pci_dev *bridge = pci_upstream_bridge(dev);
-
-	while (bridge) {
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
-			return bridge;
-		bridge = pci_upstream_bridge(bridge);
+	while (dev) {
+		if (pci_is_pcie(dev) &&
+		    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+			return dev;
+		dev = pci_upstream_bridge(dev);
 	}
 
 	return NULL;
