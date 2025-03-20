Return-Path: <linux-pci+bounces-24262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE5A6AFD2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A9D1896625
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D4221732;
	Thu, 20 Mar 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyTC2YHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9920C477;
	Thu, 20 Mar 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506135; cv=none; b=uFBRHNetN1+GCaaB2TIf6t0iljGGnlRktmvPTPgnaD9l6N8GKXofHZ2lKz7iPH1AinWmh3dncYfV5R1vArix/oKHzvjQ1gEac3/4B4l0rTBuVG0jdEhUFZHh0ZhIHG0Wy5tgW7eRGDSKBq3uyv0fBgPEVcGJ8e0vH+0278ATX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506135; c=relaxed/simple;
	bh=Wpi5Eh5Rd2QQclpqKHlSBxuKzqBweDOG2Az8IE451I0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tfFqn2KS1BJNlDZemKG3s30u4LJS7ZlZj1cQsJ7+J9uHc5E2au8kjoNaro7ZXQwpb8aCI5x5PVf8h9ySUCwUs+buf+dUoRb2jSIylzEisiu5g2v6LGlCw1opKTvZ6jb5okiAJT6Js8NGqtQC69OQFvRcoJEpgxtPzfyI8dZnhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyTC2YHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F218C4CEE3;
	Thu, 20 Mar 2025 21:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506135;
	bh=Wpi5Eh5Rd2QQclpqKHlSBxuKzqBweDOG2Az8IE451I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WyTC2YHI73vIBKSb4XVSC3LdKsU4C4oeR5eBEdoWpSLEnxKkBdl3Z/ZLHSbJW//y3
	 g9Y5V8+MywaI9Y1xHPJom46oMSZarLCAn9efVZ4oa/9Nm0L5VJ5xY5pFK0F9vdlK8q
	 ATJB8MhDUsOYYDG8+bIucRE5VZULWstJOEQQmlGnmpedExuqfYlaVyUmMe7c17MS1n
	 xWeFpKCb1HpfA3hVKDhiqs7Mga0BvZvF5+VoROFdtdGl/NTFclGvcCIYJGH1mWESLy
	 HgHUSThFgIUQhuDJqWEMuogA2JC7VD/2HIQmK+MXClobLbJ9zWhen5OfhOShu6na7R
	 jr5T8Ywu5sSXw==
Date: Thu, 20 Mar 2025 16:28:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	bwawrzyn@cisco.com, thomas.richard@bootlin.com,
	wojciech.jasko-EXT@continental-corporation.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
Message-ID: <20250320212853.GA1100504@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a44822-9b1a-4d59-a4ce-926d12f73147@163.com>

On Sat, Mar 15, 2025 at 08:06:52AM +0800, Hans Zhang wrote:
> On 2025/3/15 04:31, Bjorn Helgaas wrote:
> > On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
> > > ...
> > 
> > > Even though this patch is mostly for an out of tree controller
> > > driver which is not going to be upstreamed, the patch itself is
> > > serving some purpose. I really like to avoid the hardcoded offsets
> > > wherever possible. So I'm in favor of this patch.
> > > 
> > > However, these newly introduced functions are a duplicated version
> > > of DWC functions. So we will end up with duplicated functions in
> > > multiple places. I'd like them to be moved (both this and DWC) to
> > > drivers/pci/pci.c if possible. The generic function
> > > *_find_capability() can accept the controller specific readl/ readw
> > > APIs and the controller specific private data.
> > 
> > I agree, it would be really nice to share this code.
> > 
> > It looks a little messy to deal with passing around pointers to
> > controller read ops, and we'll still end up with a lot of duplicated
> > code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
> > etc.
> > 
> > Maybe someday we'll make a generic way to access non-PCI "config"
> > space like this host controller space and PCIe RCRBs.
> > 
> > Or if you add interfaces that accept read/write ops, maybe the
> > existing pci_find_capability() etc could be refactored on top of them
> > by passing in pci_bus_read_config_word() as the accessor.
> 
> I have already replied to an email, please help review whether it is
> appropriate.

URL to the email on lore.kernel.org?

If you mean this:
https://lore.kernel.org/r/3cadf8d5-c4d8-4941-ae2e-8b00ceb83a8f@163.com,
just post it as a v3 patch with the usual commit log and motivation
for the change, and it will automatically get picked up in patchwork
so it doesn't get forgotten.

Right now the urgency seems fairly low since (IIUC) it doesn't fix an
existing bug in the upstream code.

Bjorn

