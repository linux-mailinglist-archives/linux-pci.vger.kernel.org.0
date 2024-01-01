Return-Path: <linux-pci+bounces-1589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052EF821581
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 23:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B0C1C20C2A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 22:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809EE542;
	Mon,  1 Jan 2024 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4KseXHX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB6FBE1;
	Mon,  1 Jan 2024 22:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F61C433C8;
	Mon,  1 Jan 2024 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704147359;
	bh=vaYP09n7NQRCkMOIIM0dBoEGJ1KUL9tEiUtSqhELX54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m4KseXHX5wx9q+NQWukSufL8Ons5NIm6HUAxspt2Me2WIKQipZ9Qowhs7quVQr10r
	 8jAFoZMMYgEEPZ82kdzVkgzCmYnJ5SHN04u8ud42C65GbLqbxjQDuJyiaiwLtt69cR
	 H/Nil9ta+37qrsLjFCq00dxafC7WQv5M4EppNgPJTe0fI7fcszB4zjTy64DeU3LUMz
	 qqAQ+mWPYEOqEn9SAiUL7V+P/bc4HRnul80OcdVxW+ljf7eJ1NuakXbr8F8AAwqSj2
	 wdi9gt/2ovYjHyUxbf7MCYxFHI2MPqlqDUJLOlAjbw9ZG43AGbDJh44jiE7/oP2bWX
	 gvZ5IKHMux54Q==
Date: Mon, 1 Jan 2024 16:15:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Schaller <michael@5challer.de>
Cc: bhelgaas@google.com, kai.heng.feng@canonical.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, macro@orcam.me.uk,
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	gregkh@linuxfoundation.org, hkallweit1@gmail.com,
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
Message-ID: <20240101221554.GA1693060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f121140-e5dc-4c1a-b510-a9d791004a27@5challer.de>

On Mon, Jan 01, 2024 at 07:57:40PM +0100, Michael Schaller wrote:
> On 01.01.24 19:13, Bjorn Helgaas wrote:
> > On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
> > ...

> > So unless somebody has a counter-argument, I plan to queue a revert of
> > 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
> > v6.7.
> 
> If it helps I could also try if a partial revert of 08d0cc5f3426 would be
> sufficient. This might also narrow down the issue and give more insight
> where the issue originates from.

We're so close to the v6.7 final release that I doubt we can figure
out the problem and test a fix before v6.7.  I'm sure Kai-Heng would
appreciate any additional data, but I don't think it's urgent at this
point.

Bjorn

