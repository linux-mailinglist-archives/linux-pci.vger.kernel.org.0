Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806DB1B61EC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgDWR1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 13:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbgDWR1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 13:27:16 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120FF20728;
        Thu, 23 Apr 2020 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587662835;
        bh=Zr4Xg0JSL8LYcT3TgDBD7nueXSkitr9yJVip2R/DjXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SuIMUfM3ZWtpPzBqDa4p6mJrPH0ogxVSDVTXxFPL36bL0hGWkhrmN1JIdtt8LuVnp
         cnzVPWpAi/FPdmFErJpvCOaYMP65fY8U3qmRicT+z1BhKyOK9mwJP/KDjixaUXK8mX
         BDn4b4skolFLJ6pOy/g3yueSxRkHKCxFS8xFfqd0=
Date:   Thu, 23 Apr 2020 12:27:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/9] PCI: aardvark: don't write to read-only register
Message-ID: <20200423172713.GA191930@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-3-marek.behun@nic.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

In the next round, please capitalize the first word of the subjects of
the whole series to match:

  $ git log --oneline drivers/pci/controller/pci-aardvark.c
  4e5be6f81be7 ("PCI: aardvark: Use pci_parse_request_of_pci_ranges()")
  e078723f9ccc ("PCI: aardvark: Fix big endian support")
  7fbcb5da811b ("PCI: aardvark: Don't rely on jiffies while holding spinlock")
  c0f05a6ab525 ("PCI: aardvark: Fix PCI_EXP_RTCTL register configuration")
  f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready before training link")
  364b3f1ff8f0 ("PCI: aardvark: Use LTSSM state to build link training flag")

The important thing for the subject of this patch is not the "don't
write to read-only register" part; it's true that there's no point in
writing to read-only registers, but removing that write would not fix
any bugs.

The important thing is that we shouldn't blindly enable ASPM L0s, so
that's what the subject should mention.

On Tue, Apr 21, 2020 at 01:16:54PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Trying to change Link Status register does not have any effect as this
> is a read-only register. Trying to overwrite bits for Negotiated Link
> Width does not make sense.
> 
> In future proper change of link width can be done via Lane Count Select
> bits in PCIe Control 0 register.
> 
> Trying to unconditionally enable ASPM L0s via ASPM Control bits in Link
> Control register is wrong. There should be at least some detection if
> endpoint supports L0s as isn't mandatory.
> 
> Moreover ASPM Control bits in Link Control register are controlled by
> pcie/aspm.c code which sets it according to system ASPM settings,
> immediately after aardvark driver probes. So setting these bits by
> aardvark driver has no long running effect.
> 
> Remove code which touches ASPM L0s bits from this driver and let
> kernel's ASPM implementation to set ASPM state properly.
> 
> Some users are reporting issues that this code is problematic for some
> Intel wifi cards and removing it fixes them, see e.g.:
> https://bugzilla.kernel.org/show_bug.cgi?id=196339
> 
> If problems with Intel wifi cards occur even after this commit, then
> pcie/aspm.c code could be modified / hooked to not enable ASPM L0s state
> for affected problematic cards.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index b59198a102d0..551d98174613 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -356,10 +356,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  
>  	advk_pcie_wait_for_link(pcie);
>  
> -	reg = PCIE_CORE_LINK_L0S_ENTRY |
> -		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
> -	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> -
>  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>  	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
>  		PCIE_CORE_CMD_IO_ACCESS_EN |
> -- 
> 2.24.1
> 
