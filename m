Return-Path: <linux-pci+bounces-30551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE93AE711D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC121794EC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21A2E3B14;
	Tue, 24 Jun 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAU5j4Tp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942DD3595C;
	Tue, 24 Jun 2025 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798483; cv=none; b=ME6HVRQ/lZaY8/zFrHUSDqgToQTdgVUadMv619SdeYF5PYU2+h7gcHV+v1Eo1UHlgB2gouoPmhvxolXmydgVV20KXOFQjezPASsX03egiGASaHmNJYJf0kV+xssJCGGytX6kAwOHA3DtgyDY5YflBavFbSlqFWyt57AVBBklzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798483; c=relaxed/simple;
	bh=HagKa+zInK0BmkImfeWWekMyfV3wf6Bb1IstPRmg81k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E/EFtTghrwEsmP6bHA30ZMDH6b3Mj5VjSwhidKeBNmKe6eFZQGKMTzU7IqIA6BhrPR/1WAWNUKqf4xr9I3M+/C9/qYJit/uNPpVxqMOy89pKpGBmKYHH6GKBDKfGkbly76z0txLcjle2PoEn/f7kfSbkkFP+Z61RqCOu3IrZ878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAU5j4Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDD7C4CEE3;
	Tue, 24 Jun 2025 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750798483;
	bh=HagKa+zInK0BmkImfeWWekMyfV3wf6Bb1IstPRmg81k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZAU5j4TpYOBUpealazdefpiefsh0gw8AqvGbJWfEtN2LrF6qUFOAbptb73ghMt8Ha
	 q6GuDiZ7C0JsXwKtdTIzp/pvN+R3dFkzqaYHB0/OWJx4T44vnUih3MvZxL77InzDNk
	 dU4ZEvtfNuY145wn/8gbXyCUn39Lwk82+3wQfWHDK2nYgnELFytYw52CrvBaNy1rJC
	 3lc7SqAvcygN0ml/mhYCYsDk64PLZWTkhE2OhnrdJryvhO4XjX8BepqZHP6GyVfmUY
	 2rI5kpHYvHWoBcS0+1cRJ4iuzxU4OcFxeC/P/SsU04KDCLkigSH18QvFYy1Ot233mI
	 cA03uGw6QGg+g==
Date: Tue, 24 Jun 2025 15:54:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwei Sun <sjiwei@163.com>
Cc: macro@orcam.me.uk, ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, ahuang12@lenovo.com, sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com, sunjw10@outlook.com,
	Andrew <andreasx0@protonmail.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 0/2] PCI: Fix the issue of failed speed limit lifting
Message-ID: <20250624205441.GA1528511@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123055155.22648-1-sjiwei@163.com>

[+cc Andrew, Matthew, Sathy]

On Thu, Jan 23, 2025 at 01:51:53PM +0800, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
> PCIe Link Speed"), there are two potential issues in the function
> pcie_failed_link_retrain().
> 
> (1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
> use the link speed field of the registers. However, there are many other
> different function fields in the Link Control 2 Register or the Link
> Capabilities Register. If the register value is directly used by the two
> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).
> 
> (2) In the pcie_failed_link_retrain(), the local variable lnkctl2 is not
> changed after reading from PCI_EXP_LNKCTL2. It might cause that the
> removing 2.5GT/s downstream link speed restriction codes are not executed.
> 
> In order to avoid the above-mentioned potential issues, only keep link
> speed field of the two registers before using and reread the Link Control 2
> Register before using.
> 
> This series focuses on the first patch of the original series [1]. The
> second one of the original series will submitted via the other single
> patch.
> 
> [1] https://lore.kernel.org/linux-pci/tencent_DD9CBE5B44210B43A04EF8DAF52506A08509@qq.com/
> ---
> v4 changes:
>  - rename the variable name in the macro
> 
> v3 changes:
>  - add fix tag in the commit messages of first patch
>  - add an empty line after the local variable definition in the macro
>  - adjust the position of reading the Link Control 2 register in the code
> 
> v2 changes:
>  - divide the two issues into different patches
>  - get fixed inside the macros
> 
> Jiwei Sun (2):
>   PCI: Fix the wrong reading of register fields
>   PCI: Adjust the position of reading the Link Control 2 register
> 
>  drivers/pci/pci.h    | 32 +++++++++++++++++++-------------
>  drivers/pci/quirks.c |  6 ++++--
>  2 files changed, 23 insertions(+), 15 deletions(-)

Sorry, this totally slipped through the cracks.  I applied both of
these to pci/enumeration for v6.17.

Andrew reported tripping over this issue fixed by the first patch, and
Lukas also posted a similar patch [1] to fix it, so I updated the
commit log as below to include details of Andrew's report.

As Lukas did, I added a stable tag but made it for v6.13+ (not v6.12+)
because I think the actual problem showed up with de9a6c8d5dbf
("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed"),
not with f68dea13405c ("PCI: Revert to the original speed after PCIe
failed link retraining").

[1] https://lore.kernel.org/r/1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de


    PCI: Fix link speed calculation on retrain failure

    When pcie_failed_link_retrain() fails to retrain, it tries to revert to the
    previous link speed.  However it calculates that speed from the Link
    Control 2 register without masking out non-speed bits first.

    PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
    PCI_SPEED_UNKNOWN (0xff), which in turn causes a WARN splat in
    pcie_set_target_speed():

      pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
      pci 0000:00:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
      pci 0000:00:01.1: retraining failed
      WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target_speed
      RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
      pcie_failed_link_retrain
      pci_device_add
      pci_scan_single_device

    Mask out the non-speed bits in PCIE_LNKCTL2_TLS2SPEED() and
    PCIE_LNKCAP_SLS2SPEED() so they don't incorrectly return PCI_SPEED_UNKNOWN.


