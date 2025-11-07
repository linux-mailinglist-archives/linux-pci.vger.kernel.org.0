Return-Path: <linux-pci+bounces-40560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66022C3E946
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 07:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC5188B8BD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3042D0601;
	Fri,  7 Nov 2025 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPV+Cg2w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002C280A20;
	Fri,  7 Nov 2025 06:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495399; cv=none; b=fbG1yYL4Z14pOqoa7UScQ8DTW/JuQR4FNvon0+r/iQb+rWVvsNSsrPwLfJ34yOn8Cn/vm2FSm9qOOwaMGNbcY2cMLCocxOENcxAhy4ylFIBaPhlzQxuPje3/b89Ess5pCF3XiAs9VeGMQJP98oNXGozsIrLcJSistR0WXUjeHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495399; c=relaxed/simple;
	bh=TlVvyjy8Qz5ChlDvWPbBxE+vA1IB1QZdK1yG9sKb7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHU21cHd4+Ldo9xtFs9KBGZaQqP+WPkl6AOPs/FP3oddOnvzGF5wQZ2Ev2N8c2elUZhdn5c10sMjEOHNzWbwyhYsjbiTOimkAYCesPWJcqVacQUnP9M2CL3/1tYV0O9+F94fvDEQm9CghXY0eFvpMuBSJvxkehJWlzJHq1tpE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPV+Cg2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D186FC4CEF5;
	Fri,  7 Nov 2025 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762495398;
	bh=TlVvyjy8Qz5ChlDvWPbBxE+vA1IB1QZdK1yG9sKb7DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPV+Cg2wMPbNl1q2cCNQmh8ekcy8rJwpZ2QzvQr3CkIRAs6QlBnp5w6K4bnjX3O7e
	 mZ7z7nM9j1sVHLYXXpeSFgtswQjKBsjoc5cYhXX1NG0/mom6XoCGKVaCGP8YB29LJ6
	 AXqZgFQSBMTQpJemxdrpoMEzOp05DEB3yocDtCdzkv0j4EtaxbZ06gHugQwxPq0qaL
	 nzLKSNxtaylvIc3zfm8mbqndZDqhpYstZs39ys3kMmPlsAl/39qPIGtE4MOtZXeT6d
	 3K9c5ozOP6/ZoQP7AD8NDIdO/6hacVbF52jW752Le2R+WlgjJwi1PI5anY1W8uQFXY
	 Tz2SFKS7br/tg==
Date: Fri, 7 Nov 2025 11:33:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Christian Zigotzky <chzigotzky@xenosoft.de>, mad skateman <madskateman@gmail.com>, 
	"R . T . Dickinson" <rtd2@xtra.co.nz>, Darren Stevens <darren@stevens-zone.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Lukas Wunner <lukas@wunner.de>, 
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>, Roland <rol7and@gmx.com>, 
	Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org, 
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Cache Link Capabilities so quirks can
 override them
Message-ID: <6fni6w6aolqgxazmepiw2clwjq54yt76pjswx7zmdgebj4svqz@mggk4qyhdrrt>
References: <20251106183643.1963801-1-helgaas@kernel.org>
 <20251106183643.1963801-2-helgaas@kernel.org>
 <944388a9-1f5d-41e4-8270-ac1fb6cf73e1@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <944388a9-1f5d-41e4-8270-ac1fb6cf73e1@rock-chips.com>

On Fri, Nov 07, 2025 at 09:17:09AM +0800, Shawn Lin wrote:
> 在 2025/11/07 星期五 2:36, Bjorn Helgaas 写道:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Cache the PCIe Link Capabilities register in struct pci_dev so quirks can
> > remove features to avoid hardware defects.  The idea is:
> > 
> >    - set_pcie_port_type() reads PCIe Link Capabilities and caches it in
> >      dev->lnkcap
> > 
> >    - HEADER quirks can update the cached dev->lnkcap to remove advertised
> >      features that don't work correctly
> > 
> >    - pcie_aspm_cap_init() relies on dev->lnkcap and ignores any features not
> >      advertised there
> > 
> 
> Quick test with a NVMe shows it works.
> 
> Before this patch,  lspci -vvv dumps:
> 
>  LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>  LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
> 
> 
> Capabilities: [21c v1] L1 PM Substates
>          L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                    PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>          L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                     T_CommonMode=0us LTR1.2_Threshold=26016ns
> 
> After this patch + a local quirk patch like your patch 2, it shows:
> 
>  LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>  LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
> 
> Capabilities: [21c v1] L1 PM Substates
>           L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                     PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>           L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                      T_CommonMode=0us LTR1.2_Threshold=0ns
> 
> 
> 
> One things I noticed is CommClk in LnkCtl is changed.

That's not because of this series, but because of your quirk that disables L0s
and L1. Common Clock Configuration happens only when ASPM is enabled, if it is
disabled, PCI core will not configure it (the value remains untouched). That's
why it was enabled before your quirk and disabled afterwards.

This bit is also only used to report the L0s and L1 Exit latencies by the
devices.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

