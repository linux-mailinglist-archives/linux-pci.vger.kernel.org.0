Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B3777DF7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjHJQRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 12:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjHJQRO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 12:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C6CA8;
        Thu, 10 Aug 2023 09:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7A3F662E9;
        Thu, 10 Aug 2023 16:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD6EC433C9;
        Thu, 10 Aug 2023 16:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684233;
        bh=V/BG7ZXR+7VaA8Qltt4DBHJ7oWs032Dxd6TtWPfC5hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bhGpmQVB+wFkWR49wAIEYUUHWW/irFrO6sGtoASP7Uki3V5tQ1sCXj7fVfiCxvufo
         24Pw8r7G51R++tVPyqeUq8dBN4zAGyZLCiOFKQy3mqWbIimCZ6YC6kmB8oJQOItS6q
         97W68FOG5Umb/o9XmMVpWhXQH/31MGxj771bq+i93hlyjK7i5ShG2ivp7JLCNRSWxg
         ZY6z2cRuAAbotAlNvEOEHQUAveONn6bi39IAEuDoIpDvGF9CZ6mrQFjMIUxxCJ0GiP
         44ywM36q60zowexlsJgG16aFOuR2uwCbFLeNmLV2eI/t7kByBdiTx2/snNJRzX2SPk
         Ji2L5PBCLl9hQ==
Date:   Thu, 10 Aug 2023 11:17:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Jonas =?iso-8859-1?Q?Dre=DFler?= <verdre@v0yd.nl>
Subject: Re: [PATCH v5 00/11] PCI: Improve PCIe Capability RMW concurrency
 control
Message-ID: <20230810161711.GA33938@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717120503.15276-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 03:04:52PM +0300, Ilpo Järvinen wrote:
> PCI Express Capability RMW accessors don't properly protect against
> concurrent access. Link Control Register is written by a number of
> things in the kernel in a RMW fashion without any concurrency control.
> This could in the unlucky case lead to losing one of the updates. One
> of the most obvious path which can race with most of the other LNKCTL
> RMW operations seems to be ASPM policy sysfs write which triggers
> LNKCTL update. Similarly, Root Control Register can be concurrently
> accessed by AER and PME.
> 
> Make pcie_capability_clear_and_set_word() (and other RMW accessors that
> call it) to use a per device spinlock to protect the RMW operations to
> the Capability Registers that require locking. Convert open-coded
> LNKCTL RMW operations to use pcie_capability_clear_and_set_word() to
> benefit from the locking.
> 
> There's also a related series which improves ASPM service driver and
> device driver coordination by removing out-of-band ASPM state
> management from device drivers (which will remove some of the code
> fragments changed by this series but it has higher regression
> potential which is why it seems prudent to do these changes in two
> steps):
>   https://lore.kernel.org/linux-pci/20230602114751.19671-1-ilpo.jarvinen@linux.intel.com/T/#t
> 
> v5:
> - Remove reversed logic from a conditional
> - Use a variable for CCC setup
> 
> v4:
> - Rebased on top of pci/main
> - Added patch to update documentation
> 
> v3:
> - Split link retraining change off from ASPM patch & reorder it earlier
> - Adjust changelog to take into account the move of link retraining
>   code into PCI core and no longer refer to ASPM (currently in
>   pci/enumeration branch)
> - based on top of pci/main
> 
> v2:
> - Keep the RMW ops caller API the same
> - Make pcie_capability_clear_and_set_word() a wrapper that uses
>   locked/unlocked variant based on the capability reg
> - Extracted LNKCTL2 changes out from this series to keep this purely
>   a series which fixes something (LNKCTL2 RMW lock is necessary only
>   when PCIe BW control is introduced).
> - Added Fixes tags (it's a bit rathole but yeah, they're there now).
> - Renamed cap_lock to pcie_cap_lock
> - Changed ath1* to clear the ASPMC field before setting it
> 
> Ilpo Järvinen (11):
>   PCI: Add locking to RMW PCI Express Capability Register accessors
>   PCI: Make link retraining use RMW accessors for changing LNKCTL
>   PCI: pciehp: Use RMW accessors for changing LNKCTL
>   PCI/ASPM: Use RMW accessors for changing LNKCTL
>   drm/amdgpu: Use RMW accessors for changing LNKCTL
>   drm/radeon: Use RMW accessors for changing LNKCTL
>   net/mlx5: Use RMW accessors for changing LNKCTL
>   wifi: ath11k: Use RMW accessors for changing LNKCTL
>   wifi: ath12k: Use RMW accessors for changing LNKCTL
>   wifi: ath10k: Use RMW accessors for changing LNKCTL
>   PCI: Document the Capability accessor RMW improvements
> 
>  Documentation/PCI/pciebus-howto.rst           | 14 ++++---
>  drivers/gpu/drm/amd/amdgpu/cik.c              | 36 +++++-------------
>  drivers/gpu/drm/amd/amdgpu/si.c               | 36 +++++-------------
>  drivers/gpu/drm/radeon/cik.c                  | 36 +++++-------------
>  drivers/gpu/drm/radeon/si.c                   | 37 +++++--------------
>  .../ethernet/mellanox/mlx5/core/fw_reset.c    |  9 +----
>  drivers/net/wireless/ath/ath10k/pci.c         |  9 +++--
>  drivers/net/wireless/ath/ath11k/pci.c         | 10 +++--
>  drivers/net/wireless/ath/ath12k/pci.c         | 10 +++--
>  drivers/pci/access.c                          | 20 ++++++++--
>  drivers/pci/hotplug/pciehp_hpc.c              | 12 ++----
>  drivers/pci/pci.c                             |  8 +---
>  drivers/pci/pcie/aspm.c                       | 30 +++++++--------
>  drivers/pci/probe.c                           |  1 +
>  include/linux/pci.h                           | 34 ++++++++++++++++-
>  15 files changed, 136 insertions(+), 166 deletions(-)

Applied to pci/pcie-rmw for v6.6, thanks!

I removed the stable tags because we don't know of any actual problems
these fix.

Bjorn
