Return-Path: <linux-pci+bounces-22653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C17A49EFB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 17:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A4E18981F8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214DE272904;
	Fri, 28 Feb 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHZSPwtb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7693271294;
	Fri, 28 Feb 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760644; cv=none; b=pvocbeRrMSC8kQ864yXkSnI5CzXOgfG2hcBwwnMiS4FBY6QcT9gkb3FuR8oi/pzjL6xrhy+3a210G9Nd+IG9Rf9rwN+SMapQtUAyr3gjo7KMpOX3BlJMamyJFIan3r3wakLIOkiOcpcPqiXSRHlaHyVLBM2Paca500jzagKvc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760644; c=relaxed/simple;
	bh=A69CLjlOQbAO3pZl4fF041K+6a5JT2FGix0HP+Td0wc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J6Yw9gcTGHYgC7OTnBxqImiQL6V8iTLjUTnMAD81vRvogsw9w9Azh+Vr7bmvtV10HnECiUcKuL6AkWm9IUwdUdbwo3wPdgYGDEUvzpqCErShKsFigM8A+M0ztbGU+tGg0KQiCQxPchK0UJ6nMB/akBXFmuEdogcldH8Tv4D1Bd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHZSPwtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229D0C4CED6;
	Fri, 28 Feb 2025 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760643;
	bh=A69CLjlOQbAO3pZl4fF041K+6a5JT2FGix0HP+Td0wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DHZSPwtb6DP3g/SDWt0N+aNOxTed6arPNw8IEvxLckTXrvGSzylNBPtv3VZu8I/pb
	 CQVcVLDQYAgZEMXCHFYFxQZeoWfwJ/busg2F87CpKQELQIL6IKvDmwuSMYLzBNaoqk
	 NHxPdteOmu86zIK8RtPolapyWcKWeBNw/Wr/l5I+XcGabfwhWoTvB0yEpIZqy5axRb
	 ByEWINBILtw17M8JttsdIx2IXTI3gkA5DZhvuNjoXphL8Bjy5IrRPt3fZ5uhG0JY5W
	 k2Ho98eF/PrTqkIUofPE9GcBKgpak60RfMi6oPOx60+7rgzufU7WUXxmk/j+99yoTW
	 63dCZs1go/I9A==
Date: Fri, 28 Feb 2025 10:37:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250228163721.GA56317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228093351.923615-4-thippeswamy.havalige@amd.com>

On Fri, Feb 28, 2025 at 03:03:51PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
> 
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-GT/s operation per lane.
> 
> Bridge supports error and INTx interrupts and are handled using platform
> specific interrupt line in Versal2.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202502191741.xrVmEAG4-lkp@intel.
> | com/

Drop these reported-by: and closes: tags.

Krzysztof K. already said this:
https://lore.kernel.org/r/144202cc-057c-4a7d-852a-27e979284dd2@kernel.org

Don't repost the series just for this.  If there are no other
comments, we can remove this when merging it.

Bjorn

