Return-Path: <linux-pci+bounces-34206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED76B2AD4B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F9018A632D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6B30F524;
	Mon, 18 Aug 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIyUtouv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EC319844;
	Mon, 18 Aug 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532115; cv=none; b=eLTobjut0ogU7hTjGvK58ydLKUOVl6fCNidqoEj+jcvkM7BF+5TcVdA0Bv09wC/Nw4KkTNjKcXfVRrF9+0qXZXn2rNrBpSmcNoXseZfyTfFOBFIYoQp/xxM4TKzcnuaK/08SifqvCRTJ7oHilHN5Fz+4RLWaf974287qXeFY7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532115; c=relaxed/simple;
	bh=SD+YffITOfZAo6Ivx+38x0kP3WuI7A8ZqDwATXhXXAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kNlO9/q3N2dCoqFdfARb8esUXn9mZvd59Enk3LoCDz71qtQN1Bj681K3AI9O38N3kx+UekcB6ne905V+c+qLVtD3ZYkRecgouY3qb4eqlW9z3YQAxxtRen3u+eo5EkxJ3iaZqsXTOBO15qG/ZH4K5d5ldP+g0juvvI2BNguuDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIyUtouv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA63DC4CEEB;
	Mon, 18 Aug 2025 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532115;
	bh=SD+YffITOfZAo6Ivx+38x0kP3WuI7A8ZqDwATXhXXAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rIyUtouvTqSQc8bVuEm61JYDwdCLFA+/97Yamt591o3sfsa8/GSMX85ag89CZO1FZ
	 v1D4Ow4jXJvA7pihd+zjhI07g2ZLM2FQPzV731bIuYu+9IN4WnYcKZAgb6ftVnoSkL
	 N9fiyUUXq32WzdvUDkgZ/NEZtlJGux/7XbfS11rWvZTna6AtjN9gYDmZpsKv51MOod
	 Z2YODUPQQ6yqbesk5Pnpi/mLaMI8IZvsSV8qOLXleFdbWlZgCtoMMDvag0sF3b1xot
	 gbiXzPWL93C5e+vRzRCRRD+1JV/a+47ZeCmhit58trvxI4B2Bn8Ek6TgR4INmDDDGU
	 snoJGHTF31DYg==
Date: Mon, 18 Aug 2025 10:48:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Message-ID: <20250818154833.GA528281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818073205.1412507-2-hongxing.zhu@nxp.com>

On Mon, Aug 18, 2025 at 03:32:01PM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> 
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
> 
> The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
> PME_Turn_Off is sent out.
> 
> To support this case, don't poll L2 state and apply a simple delay of
> PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
> in suspend.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 31 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b5012..20a7f827babbf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1007,7 +1007,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> -	int ret;
> +	int ret = 0;
>  
>       /*
>        * If L1SS is supported, then do not put the link into L2 as some
         * devices such as NVMe expect low resume latency.
         */
         if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
                return 0;

You didn't change it in this patch (the L1SS test was added by
4774faf854f5 ("PCI: dwc: Implement generic suspend/resume
functionality")), but this L1SS check is an encapsulation problem.
The ASPM configuration shouldn't leak out here in such an ad hoc way.

*All* drivers, not just NVMe, would prefer low resume latency.

How do we deal with this in other host controller drivers?  If any
other driver puts links in L2, I suppose they would have the same
issue?  Maybe DWC is the only one that puts the link in L2?

What happens when we add a new driver that puts links in L2?  I guess
we'll be debugging some NVMe issue again?

Bjorn

