Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38825A42
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEUWXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 18:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEUWXE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 May 2019 18:23:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A01217D7;
        Tue, 21 May 2019 22:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558477383;
        bh=0BbaZAoRiNBkSCBgG5D5D9mPLpmU4+kTs7jtHZ1Eh+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDlRgWmMgA5Ms9sqPND1mhPez3t6HOhJaCVVygWmtiD7I0NIIr4pFUjbJDdEGjXgT
         e9kKeidECeMYpjNz67UFHXuqwu9O8a+DL+P9aVbJrVaoD+UC7EhPt1/gdv1H6K+Zko
         GA2SY7XRoz5Ktx7Z/z9d4AmiGmkZbS6CoiNU8WzY=
Date:   Tue, 21 May 2019 17:23:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190521222300.GG57618@google.com>
References: <20190521163104.15759-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521163104.15759-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mathias, linux-usb]

On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
> There's an xHC device that doesn't wake when a USB device gets plugged
> to its USB port. The driver's own runtime suspend callback was called,
> PME signaling was enabled, but it stays at PCI D0.

s/xHC/xHCI/ ?

This looks like it's fixing a bug?  If so, please include a link to
the bug report, and make sure the bug report has "lspci -vv" output
attached to it.

> A PCI device can be runtime suspended to D0 when it supports D0 PME and
> its _S0W reports D0. Theoratically this should work, but as [1]
> specifies, D0 doesn't have wakeup capability.

s/Theoratically/Theoretically/

What does "runtime suspended to D0" mean?  Is that different from the
regular "device is fully operational" sort of D0?  If so, what
distinguishes "runtime suspended D0" from "normal fully operational
D0"?

> To avoid this problematic situation, we should avoid runtime suspend if
> D0 is the only state that can wake up the device.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/device-working-state-d0
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  drivers/pci/pci.c        | 2 +-
>  include/linux/pci.h      | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index cae630fe6387..15a6310c5d7b 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1251,6 +1251,11 @@ static int pci_pm_runtime_suspend(struct device *dev)
>  		return 0;
>  	}
>  
> +	if (pci_target_state(pci_dev, device_can_wakeup(dev)) == PCI_D0) {
> +		dev_dbg(dev, "D0 doesn't have wakeup capability\n");
> +		return -EBUSY;
> +	}
> +
>  	pci_dev->state_saved = false;
>  	if (pm && pm->runtime_suspend) {
>  		error = pm->runtime_suspend(dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8abc843b1615..ceee6efbbcfe 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2294,7 +2294,7 @@ EXPORT_SYMBOL(pci_wake_from_d3);
>   * If the platform can't manage @dev, return the deepest state from which it
>   * can generate wake events, based on any available PME info.
>   */
> -static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  {
>  	pci_power_t target_state = PCI_D3hot;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4a5a84d7bdd4..91e8dc4d04aa 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1188,6 +1188,7 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
>  void pci_pme_active(struct pci_dev *dev, bool enable);
>  int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
>  int pci_wake_from_d3(struct pci_dev *dev, bool enable);
> +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup);
>  int pci_prepare_to_sleep(struct pci_dev *dev);
>  int pci_back_from_sleep(struct pci_dev *dev);
>  bool pci_dev_run_wake(struct pci_dev *dev);
> @@ -1672,6 +1673,8 @@ static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  { return 0; }
>  static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>  { return 0; }
> +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> +{ return PCI_D0; }
>  static inline pci_power_t pci_choose_state(struct pci_dev *dev,
>  					   pm_message_t state)
>  { return PCI_D0; }
> -- 
> 2.17.1
> 
