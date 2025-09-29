Return-Path: <linux-pci+bounces-37207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0DBA9935
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD803C3957
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00430BB9D;
	Mon, 29 Sep 2025 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNfA+TYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0A30BB98;
	Mon, 29 Sep 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155967; cv=none; b=e3JD1am/vLtf0HFn2njlx7bDX7yVZqka+oDoo5VdTSugBiGOmzzpLtPEsX1+Fajp93Qq5LF3pumWmtGVp35Kiz9u99/ibMlGhZqnMcX50bPtqisK3t9EkSZUSJjXk3Vws6Nw2OsS6BGhnoZL2tQSqFNFxREn+LXpusTCfUWVJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155967; c=relaxed/simple;
	bh=hTD3Nt4DpaJRy7P/xGnOsnI2J/j1t6BOJMHTcrErYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0Y16zbp7IwbhzOH/co5+ONkeS1OkSVv7lev1OTTsSS3CDhrF/HGnGc+yTiSgFvDj0fjtQzd3GHZbuTjIpL/D6I7ALE2rJMclI5tV0PRJvDiWyLnyNgyXTvCDMTS1+KDSCouj+SaIAUymMpwfyuJ1zXZV4gwP1xRf5uHiU9qcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNfA+TYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B7CC4CEF4;
	Mon, 29 Sep 2025 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759155966;
	bh=hTD3Nt4DpaJRy7P/xGnOsnI2J/j1t6BOJMHTcrErYBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNfA+TYysm0r/r7mJIUX1cdDvGFGBTYzwOKXfuZgsoVZioa6sP+OU8gDYuRo+zqpu
	 Rx2oqwpImf+kGSC0dtL0SGLVSUn+VAayC8BnlCCLcD6MybTCv/DakzG8I8UcBDFc/1
	 d9cIWsyVYAT2IiatXZ/oNPEf0jt7+4+oMT/u7y37tGTWIj7jOm5hWxyudkcSil0ONf
	 JBlkyG29FZqqyaYUt1SuDxXmD/oYcLtTCpm9Vub3AQAwtV/al/GcCpEXU11zDmtD2l
	 bHeSrIl1E3dFC6gsYuLc0wd4CS1PNoV8/TZO/F40ekErsZSM7nbJrJk7UgBj6cRZ6v
	 jFhxV5Lirvcgg==
Date: Mon, 29 Sep 2025 19:55:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Randolph Lin <randolph@andestech.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr, 
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	ben717@andestech.com, inochiama@gmail.com, thippeswamy.havalige@amd.com, 
	namcao@linutronix.de, shradha.t@samsung.com, randolph.sklin@gmail.com, 
	tim609@andestech.com
Subject: Re: [PATCH v3 1/5] PCI: dwc: Skip failed outbound iATU and continue
Message-ID: <ihappv6m5k7hvbfn7h65j7e52jqben7mgrvg7sem3hskfzgxyn@meq5xq33hgpc>
References: <aNPq42O1Ml3ppF2M@swlinux02>
 <20250926211023.GA2128495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926211023.GA2128495@bhelgaas>

On Fri, Sep 26, 2025 at 04:10:23PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2025 at 08:58:11PM +0800, Randolph Lin wrote:
> > On Tue, Sep 23, 2025 at 09:42:23AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 23, 2025 at 07:36:43PM +0800, Randolph Lin wrote:
> > > > Previously, outbound iATU programming included range checks
> > > > based on hardware limitations. If a configuration did not meet
> > > > these constraints, the loop would stop immediately.
> > > >
> > > > This patch updates the behavior to enhance flexibility. Instead
> > > > of stopping at the first issue, it now logs a warning with
> > > > details of the affected window and proceeds to program the
> > > > remaining iATU entries.
> > > >
> > > > This enables partial configuration to complete in cases where
> > > > some iATU windows may not meet requirements, improving overall
> > > > compatibility.
> > > 
> > > It's not really clear why this is needed.  I assume it's related
> > > to dropping qilai_pcie_outbound_atu_addr_valid().
> > 
> > Yes, I want to drop the previous atu_addr_valid function.
> > 
> > > I guess dw_pcie_prog_outbound_atu() must return an error for one
> > > of the QiLai ranges?  Which one, and what exactly is the problem?
> > > I still suspect something wrong in the devicetree description.
> > 
> > The main issue is not the returned error; just need to avoid
> > terminating the process when the configuration exceeds the
> > hardware’s expected limits.
> > 
> > There are two methods to fix the issue on the Qilai SoC:
> > 
> > 1. Simply skip the entries that do not match the designware hardware
> > iATU limitations.  An error will be returned, but it can be ignored.
> > On the Qilai SoC, the iATU limitation is the 4GB boundary. Qilai SoC
> > only need to configure iATU support to translate addresses below the
> > "32-bits" address range. Although 64-bits addresses do not match the
> > designware hardware iATU limitations, there is no need to configure
> > 64-bits addresses, since the connection is hard-wired.
> > 

Why does the DT supplies broken 'ranges' in the first place? DT describes the
hardware and if the hardware only supports 32bit OB window, then DT has to
supply the range accordingly. It is not currently clear on what issue you are
trying to solve by skipping the range check for broken resources.

> > 2. Set the devicetree only 2 viewport for iATU and force using
> > devicetree value.  This is a workaround in the devicetree, but the
> > fix logic is not easy to document.  Instead, we should enforce the
> > use of the viewport defined in the devicetree and modify the
> > designware generic code accordingly — using the viewport values from
> > the devicetree instead of reading them from the designware
> > registers.  Since only two viewports are available for iATU, we
> > should reserve one for the configuration registers and the other for
> > 32-bit address access.  Therefore, reverse logic still needs to be
> > added to the designware generic code.
> > 

'num-viewport' property is deprecated. So should not be used in new DTs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

