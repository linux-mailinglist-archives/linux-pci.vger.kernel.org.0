Return-Path: <linux-pci+bounces-34072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F92B27063
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D401176C94
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6A3272E5E;
	Thu, 14 Aug 2025 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt4Ss8Pk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8F271454;
	Thu, 14 Aug 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204678; cv=none; b=B2XEQTZG03roc9Dq7CtJ2B5Rcz7Q/D808E2XL8ssDYzgH4Wspz+Tux+oJSb5N+siDExGk3TF12HWP1YC6Tdf+Vit8wB6lfDt/3rS44Ybm2stVUaJIHtAhA1V056PI2enOlFhZ2SYXXj/KCDwCLno1xv9jzOO4OIoRZS6cZEUnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204678; c=relaxed/simple;
	bh=qR//FA/qgXQxDQXge8w8k+boWxyVk6PurKPWw9UbewI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eDt6XE6YOVWlhOZbpZ1J6I5WML2Bka5ePnp7A/S2eSzACOLUOWwYmN9Nru8ppoJAGjnj1ajng7ECumieXr/pcVMrT8zQOT8tC+1EOLcMA8iJL14sSXZkzvXnK80E7lIBCj1SBwCZwWpOAoXwjbecyqNATkuM+WzZEwMaPxhynQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt4Ss8Pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F8C4CEED;
	Thu, 14 Aug 2025 20:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755204677;
	bh=qR//FA/qgXQxDQXge8w8k+boWxyVk6PurKPWw9UbewI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Lt4Ss8Pk7hMdHg5ykTpqojt6yYdtj2ionpcUQ+7zbjBZCO+c8yTmW2ats7nwjrO+R
	 /oW+Hkiqr/rvaAXjLzoYL3T1GlnOrH3g7upbVXchlrkf8RQGMcPJeNvX3znh1vlI3r
	 7KgAKuFTD1LcqH1XYrowPiQfiuwSXSWj+310tP8RleLuG18s4vdRYpLpj6KsNzia3P
	 r9V5yuvLh2WtSnE83ZZTAEV37PBOUfWeIl8el50kD73EwWf7wfr5Aewq5EOJvXbyHY
	 nv0H5LxN6OYw2DZ4T1fZXtudjVJvM/58JS9ZdAOV6s5ODSuyMlWtF/ZnkKdcO+TMyv
	 mN7roCS9JqfJg==
Date: Thu, 14 Aug 2025 15:51:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	mani@kernel.org, robh@kernel.org, ilpo.jarvinen@linux.intel.com,
	gbayer@linux.ibm.com, lukas@wunner.de, arnd@kernel.org,
	geert@linux-m68k.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/6] Refactor capability search into common macros
Message-ID: <20250814205116.GA346877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc95b8020a152d487ada00e9751c2b3f602c11d.camel@linux.ibm.com>

On Thu, Aug 14, 2025 at 10:37:03PM +0200, Niklas Schnelle wrote:
> On Thu, 2025-08-14 at 15:25 -0500, Bjorn Helgaas wrote:
> ...

> > I applied this on pci/capability-search for v6.18, thanks!
> > 
> > Niklas, I added your Tested-by, omitting the dwc and cadence patches
> > because I think you tested s390 and probably didn't exercise dwc or
> > cadence.  Thanks very much to you and Gerd for finding the issue and
> > testing the resolution!
> 
> Thanks, yes leaving out dwc and cadence makes sense. Though I do often
> also test on my private x86 systems this one was s390 only. Since I
> have you here and as you applied this one now and Lukas PCI/ERR stuff
> yesterday, is it possible that my series titled "PCI/ERR: s390/pci: Use
> pci_uevent_ers() in PCI recovery" somehow fell through your mail
> filters maybe due to not having any "PCI:" in a subject?

Nope, I saw it and am actually looking at it right now :)

I see there's some conversation about Lukas's series, so I expect some
minor rebasing, if only to add Reviewed-by and such.  Nothing unusual;
I treat these branches as drafts until the merge window.

Bjorn

