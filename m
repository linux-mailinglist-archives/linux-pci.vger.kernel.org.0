Return-Path: <linux-pci+bounces-42968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A30FACB6783
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 612FF3001614
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2128688D;
	Thu, 11 Dec 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoDFl+qQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411152836A0
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765470599; cv=none; b=Dp5/NwFb+sK5bqqd5s1iyZcFCKeFkML7MBM4JxkQb+r4Tz680GbvWqtj3cJi/CYeG1rrYVEkoOFw16UJ5qUfuUr88HneUMBSktNcniYj8nBsWLTIogtVUg4i4p1UYZJBX+I+ChNtzgROijwttVfIFxMhQmYkTtutiwr8vZDnRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765470599; c=relaxed/simple;
	bh=P6KIEwi85VmWfN2nW2wZR6OCmL+ECYNt7WGle1jHtTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tCicrydOxq+U1bKf/3LWVFKuycLwRQq85BzKP633rGqvGmk2neyzzTbYEFc53nnL3nvXVw6l2TILA0yV6Gew9OJWqT3be1UHp07ml8ZZscfkqDLJQ8OiiHwYtjdX7gd9mnnxrKybmKgDVLp2DkNquX3w+JmWS1Z1K42BYnCAUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoDFl+qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F9CC4CEF7;
	Thu, 11 Dec 2025 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765470598;
	bh=P6KIEwi85VmWfN2nW2wZR6OCmL+ECYNt7WGle1jHtTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eoDFl+qQ+iFhvl1GJNL2NC78r2wdhwIYDa8w9Qbsnp7Jq3xUouJsyBW3Ph6L+lpf1
	 kJMWjT+gAesEQh+vpw1bHbeKAWxHkX+Ndu8WsudHTqOb73kCNfDBAqVX4rJkgiGsHg
	 bVUEfgmFwyQlpaZS2MDXgCYsOypk9tbBX/F5980OO5k9o/k1BzuFD9zDAhjkOer8vE
	 IsDdSbKPZOY/ydCqh0Y7Al6UcHj9FNfRGjnBlDR0sK2XMC1jBN3Gij1wd5IYJzkmqU
	 16aKQSVGskyJvfNlN2jnvt9WGInJs9oxyXsdUiNLsSS6Bpz/5nUb6qyX+XWvI8Hy61
	 x188uFsYgrxJQ==
Date: Thu, 11 Dec 2025 10:29:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: Change get_lttssm() to provide
 L1ss info
Message-ID: <20251211162957.GA3595695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764035632-180821-2-git-send-email-shawn.lin@rock-chips.com>

On Tue, Nov 25, 2025 at 09:53:52AM +0800, Shawn Lin wrote:
> This patch renames rockchip_pcie_get_ltssm() to rockchip_pcie_get_ltssm_reg()
> and adds rockchip_pcie_get_ltssm() to get_lttssm() callback to in order to
> show the proper L1 substates. The PCIE_CLIENT_LTSSM_STATUS[5:0] register returns
> the same ltssm layout as enum dw_pcie_ltssm. So we only need to tell L1ss apart
> and return the proper value defined in pcie-designware.h.
> 
> cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> L1_2 (0x142)

s/get_lttssm/get_ltssm/ (subject and commit log)
s/This patch renames/Rename/ (imperative mood)
s/and adds/and add/ (imperative mood)
s/ltssm/LTSSM/
s/L1ss/L1 PM Substates/

Wrap the commit log to fit in 75 columns to allow for "git log"
indenting everything.

Indent the "cat /sys/..." example two spaces.

> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN);
> +

Wrap to fit in 80 columns like the rest of the file.  Or possibly
reduce the length of "PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN", which
might be excessively descriptive.

> +	if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_1)
> +		return DW_PCIE_LTSSM_L1_1;
> +	else if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_2)
> +		return DW_PCIE_LTSSM_L1_2;
> +	else
> +		return rockchip_pcie_get_ltssm_reg(rockchip) &
> +			PCIE_LTSSM_STATUS_MASK;

None of these "else" uses are needed:

  if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_1)
    return DW_PCIE_LTSSM_L1_1;

  if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_2)
    return DW_PCIE_LTSSM_L1_2;

  return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;

