Return-Path: <linux-pci+bounces-41989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1420C828AF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90A884E0EC6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B722DBF40;
	Mon, 24 Nov 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoikFaol"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3791C84BC;
	Mon, 24 Nov 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019963; cv=none; b=o+UFLN3dGRH+z25s/owsszXMkV12BPMprB4m/Js7UUfn0AMo04e9EPlGE7gD3he52f92RR+BcmnwnhRWXzvzke3FPnKAwaXfIphxEEk5IbXN9bSR54h6wnXRcG3uayseqlAczEqNq9lE+69Mxc3+bUTS1zCipk6+UcvPETGU1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019963; c=relaxed/simple;
	bh=N/JgUuEqHbMVDwvonva1mhxZkydQiFcEqKnKir1ma6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PU4NhwAuxLot0uY1EM5qcDWBHgNLWGxm+8bUuV/XlK6zqVZqSLGQDvp4/nIRYmEjAbasLKkE5CbeN+jFwfESsM9G7E9M2Ze0sivaP1cBMKwLOrB4xZtc7nmJENSabl0ICXyBNR3AWjXyVTrjFOyn4AfKBIlPSyqMkCvJvD/bYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoikFaol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DA4C4CEF1;
	Mon, 24 Nov 2025 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019962;
	bh=N/JgUuEqHbMVDwvonva1mhxZkydQiFcEqKnKir1ma6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KoikFaolpEGoLd3a/d/OrXm45UtteFI6cLqGu8VEyanf5G6PyvclXIHCCg/DOyWi+
	 6Lb1KTD3MRzWDFIErlgTNB5RWqc30tIj1qyNoDYNALcTyfxPe7/b9glhRjV2N9J3IH
	 1voVlPWJ5GWQNiyxQShU/kgl9/GHVY+tlZ+sPX/qcqu2XUz0+4oTbytEyyfmAjPy9L
	 xEogljS6dgDV0oJMJHE6RznePi+T1HS7q6UgWTIcq5QrOexF+ZIyxt5Ri3uk4WaUzv
	 drEAFA//o2pKCA5iDO0Z+lnA0CtpFK0fEVFZ2OyPsmMyqkfmSH6fJ998ipTVVq7VE/
	 X7dM1JCsMJnSw==
Date: Mon, 24 Nov 2025 15:32:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, krishna.chundru@oss.qualcomm.com,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 0/2] PCI/pwrctrl: tc9563: A couple of fixes
Message-ID: <20251124213241.GA2715978@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120065116.13647-1-mani@kernel.org>

On Thu, Nov 20, 2025 at 12:21:14PM +0530, Manivannan Sadhasivam wrote:
> Hi Bjorn,
> 
> Please squash these fixes with the offending commit.
> 
> - Mani
> 
> Manivannan Sadhasivam (2):
>   PCI/pwrctrl: tc9563: Enforce I2C dependency
>   PCI/pwrctrl: tc9563: Remove unnecessary semicolons
> 
>  drivers/pci/pwrctrl/Kconfig              | 1 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

Squashed into pci/pwrctrl-tc9563, thanks!

