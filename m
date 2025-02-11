Return-Path: <linux-pci+bounces-21174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C1EA3146A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94E5188B745
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A6262D16;
	Tue, 11 Feb 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrvOPc2G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138D25A34A;
	Tue, 11 Feb 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299876; cv=none; b=fxlRf4MZ5yqP7pPlayLKTKWmQa3ZNC5v3KcpxXjx3TQU9CaZ9fIHHuA805HGekt1frwx43vQjh+yaLgi+apUDtBe6Ros0PNb+zxTmMxltQt7/10nnMcCkHTv93s3BT5XvQpvtQcIPeEuSeb7vY/IFAp+IfrwlhIdl8QtuyHKLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299876; c=relaxed/simple;
	bh=Ohe9V0q672zCdoryIimZs3HHDJAtmxB5pXzVohyN7R8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cr4MoVTe+d6f7YHdBt53ZW0U01f5hHkOzQQcWpL4GHRfDB7jQ/s1nttYZEolICVGuoQxHVnSOXWlD6AGPuV4vhnGBy23T0DIq+UrOELU4Y0lbJSQdOR9s9YBQahO9lyYfFLlQ5aKjoH/HBBei2UsOs8ANvaWtprfBpIaMxxkDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrvOPc2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F36C4CEDD;
	Tue, 11 Feb 2025 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299876;
	bh=Ohe9V0q672zCdoryIimZs3HHDJAtmxB5pXzVohyN7R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RrvOPc2GRQp/LPOxVDx8qCjQ54V6om1qedpDU9/ZXP4AYThY3YoyxvK0d1wgFqINn
	 aghFyq5VATD5XzHqlJfC/j991uDsxsnBfOrtp5R1RoZPrKxm2elowhb0VsH50qBJwX
	 4B8DIYZMRSSTQHj25Ty1xRMs/jQrmXQOKPP8jfJ1m5U9jav988nKvXP24VcMS5d5fl
	 /IurUqwbLNs4yF2TR86WG2sV4acwW8AaGc5o17sP64jfM2lBsUouRgrWIQz1mOKgst
	 LIM77vQPstPfmAXqS9SdDiBC8K8HyxHj5uoVpnsLKSPcEa45ZFqMKTx+3QZJog9fXv
	 4NrAVxxd8s7HA==
Date: Tue, 11 Feb 2025 12:51:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Message-ID: <20250211185114.GA51552@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211081724.320279-3-thippeswamy.havalige@amd.com>

On Tue, Feb 11, 2025 at 01:47:24PM +0530, Thippeswamy Havalige wrote:
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the
> Next-Generation Compact Module (CPM5NC).
> 
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
> 
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. Legacy interrupt support is not available.

I guess this means INTx support is not available?

If so, I'd like to say "INTx" instead of "legacy" to be more specific.
Someday "MSI" may also be considered "legacy".

Bjorn

