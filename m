Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C551EFF21
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfD3RxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 13:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RxG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 13:53:06 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854F221670;
        Tue, 30 Apr 2019 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556646785;
        bh=uaA3gKddXQ40WR5eBSunCDRDXdKyXN0GHfcQ06mZD/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEE3R8ikYIUcyARGFIWIgKbrNhnMzSP7Xrdm2tMB/p1h8vv0cIgM/BPuNnGbWQp7A
         ohiiIvADfgK0qwahTqWOnxMpz9JdOKoDKeS/ucW2dee7DjNcFoiEf2Y/4dSHSbL2G7
         b5cst1evJIcFrL9qmRq0kf4l5pY0EqWEJ2amk+9Q=
Date:   Tue, 30 Apr 2019 12:53:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
Message-ID: <20190430175304.GC145057@google.com>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
 <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 13, 2019 at 11:12:41AM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per
> default. However especially on notebooks ASPM can provide significant
> power-saving, therefore we want to give users the option to enable
> ASPM. With the new sysfs attribute users can control which ASPM
> link-states are disabled.

> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> -#endif
> -
> -#ifdef CONFIG_PCIEASPM_DEBUG
> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> -#else

I like the idea of exposing these sysfs control files all the time,
instead of only when CONFIG_PCIEASPM_DEBUG=y, but I think when we do
that, we should put the files at the downstream end of the link (e.g.,
an endpoint) instead of at the upstream end (e.g., a root port or
switch downstream port).  We had some conversation about this here:

https://lore.kernel.org/lkml/20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com

Doing it at the downstream end would require more changes, of course,
and probably raises some locking issues, but I think we have a small
window of opportunity here where we can tweak the sysfs structure
before we're committed to supporting something forever.

Bjorn
