Return-Path: <linux-pci+bounces-14404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF599B54F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 16:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5FD1C21429
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E34186E43;
	Sat, 12 Oct 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQjLMPc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C8178395;
	Sat, 12 Oct 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742136; cv=none; b=USpQpn4/esa4Q2AO10rQvBGW79+JCKgptP59ouFZLhDsFwFBExx9Cjs0ZI/M1YzhQouj2J9BNibRlGD7R78ah4usgF5EA+T0qtTesQ1G+vtQybI3MJzfPf1XBwvfQkOOgIFZFu2CDd0tgPWyDKuJEVMSA4Ji10W/NkIX+babYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742136; c=relaxed/simple;
	bh=NEnfYZi9+H7rxaWUXDBIp1Q4trpVdsL34YQitu2ViY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LFWyyX/BsOif5vJSCUlaixzjHgdoi19gwyBYUOnCU9+yIacKFtXUI7D7iAM/f7k4SbCdmJSbbZ2gKLkW1WoJ03TtzADZwzDL5Egr/aIwz1zdCNaHIslyn5B7Ixgh6UJVf5y5r/2JV7N+p3yMJyGc9XVjPhVC39nWlVLb+tYm+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQjLMPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5F8C4CEC6;
	Sat, 12 Oct 2024 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742136;
	bh=NEnfYZi9+H7rxaWUXDBIp1Q4trpVdsL34YQitu2ViY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WIQjLMPc8Ph4WuWJzS9gku1YXkkuL+lrhkEWeiVfpWzKdjB3fs0Ch6FzsU/nApk+o
	 Pwtzhuuipgh/uD7r6x+JJDzMS4BVUYc+SZTwDzms5Q48JCv+NJVlZUVdlYXD7IO0sS
	 wLt40NW3EZz5C6ovS/mTO6a1TufMch0Hk/Lj4/Zbx+hajgDsGmp0RMvV+xT5iYKBWR
	 6Ynr2swy7t0uR2IFxUS/hbaqIc/e2DrYfUAsMyelhlJZMcCGZ3v7cigdILqcRkd+5h
	 phpIWYNK1JUoVeCvzixHV99p0X3PT4MIzTAkPfCGXOjr7qRbQip0D5mfwR5C+bYDqL
	 Ywd26PvnAJjBA==
Date: Sat, 12 Oct 2024 09:08:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Mayank Rana <quic_mrana@quicinc.com>, kevin.xie@starfivetech.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PCI: starfive: Enable PCIe controller's PM runtime
 before probing host bridge
Message-ID: <20241012140852.GA603197@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2872d91-039b-399c-af88-c20bf605e172@quicinc.com>

On Fri, Oct 11, 2024 at 04:14:10PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/11/2024 2:22 AM, Bjorn Helgaas wrote:
> > On Thu, Oct 10, 2024 at 01:29:50PM -0700, Mayank Rana wrote:
> > > Commit 02787a3b4d10 ("PCI/PM: Enable runtime power management for host
> > > bridges") enables runtime PM for host bridge enforcing dependency chain
> > > between PCIe controller, host bridge and endpoint devices. With this,
> > > Starfive PCIe controller driver's probe enables host bridge (child device)
> > > PM runtime before parent's PM runtime (Starfive PCIe controller device)
> > > causing below warning and callstack:
> > 
> > I don't want the bisection hole that would result if we kept
> > 02787a3b4d10 ("PCI/PM: Enable runtime power management for host
> > bridges") and applied this patch on top of it.
> > 
> > If this is the fix, we'll apply it *first*, followed by 02787a3b4d10
> > (which will obviously become a different commit), so the locking
> > problem below described below should never exist in -next or the
> > upstream tree.
> > 
> > So we need to audit other drivers to make sure they don't have theBjorn, I have checked all the drivers in the controller folder where
> they are using pm_runtime_enable(), this is the only driver which needs
> to be fixed. once this patched was taken can we take "PCI/PM: Enable
>  runtime power management for host bridges"

Since these need to be applied in order, the usual process is to post
them together in one series.  Please work with Mayank to revise the
commit log of the starfive patch so it explains why the change is
necessary *independent* of your patch, and then post it and your
"enable runtime PM for host bridges" together as v6 of your patch.

In the cover letter include a note about why no other drivers need a
change like starfive does and how we can verify that.

Bjorn

