Return-Path: <linux-pci+bounces-33884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97CB2392D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDCC1886866
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8942F8BE2;
	Tue, 12 Aug 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMqXijtb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC92475F7;
	Tue, 12 Aug 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027673; cv=none; b=ErMJ89Q7UyTK/yguRuTOCdJmcY0+Ue7LsnnIjISUBuzDOmARe4cVyvn/+GPEnba1KFznmc6Z2WgnEQRaqdIeKm3J2Bhs+L9JG3P/WyZiMf5TLnC6KrKAMRXGHknwdwsJt+SCIGoIXiLge+157UMdGaPzuzJ2Hjcq/k1a0LxetEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027673; c=relaxed/simple;
	bh=3JQQE3TOuT+5vKeGPOdkiGX1nGFlQoXrddrR5M7DJw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAr9rUjUEc/mVwuM+I2wkspaicPRJ4qXiHVIt2ucDAWipTlE2dR7X9LtVFbhq3yyg+MHn2PCFT/oSrsDlYcnh7sfmz85CuQ9w9I9Nst25XAdJnSrufvVaIHcXONRcOGBvWhv0DPldsIvnjfvvhVx+Z8+SO3MCsRKwL5v3mUinJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMqXijtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B2FC4CEF0;
	Tue, 12 Aug 2025 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755027673;
	bh=3JQQE3TOuT+5vKeGPOdkiGX1nGFlQoXrddrR5M7DJw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMqXijtb7JJYnTEjmN3IIpih63tjB9dD85A/vDTN81dcBpEjPdNyquqrMb6eEf0AU
	 BguP8K3NW4Lm42PhGQfxpuNI1EDKk9E08A9dLwb1EIR7phkVbHiD91EdSkPI8C3+C9
	 eWRplH86MNnuNr1wvrt0u1HAyGxw8t52q0WoFubEY/WJ/0pfKKhLpui0KF4FI8Jqii
	 EaBvcqPnQQ6W738L97DXVCiWpXNcJLJ+fJBmDajLBriBng+SywcNCJS7PioRs2VnDX
	 opE1hOAjgr/fuXhxFxw/UCOrc/gcC7aeOYDPxWEHNHAPmpDo0uZ2b/B7KV6CnTibKK
	 fTRSHIxcj81KA==
Date: Tue, 12 Aug 2025 13:41:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <aJuY1o4JAftObQhv@kbusch-mbp>
References: <20250812182209.c31roKpC@linutronix.de>
 <20250812190036.GA199875@bhelgaas>
 <20250812193219.9E_pRwle@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812193219.9E_pRwle@linutronix.de>

On Tue, Aug 12, 2025 at 09:32:19PM +0200, Nam Cao wrote:
> On Tue, Aug 12, 2025 at 02:00:36PM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 12, 2025 at 08:22:09PM +0200, Nam Cao wrote:
> > > Minor correction, it is not just an unnecessary WARN_ON, but child devices'
> > > drivers couldn't enable MSI at all.
> > > 
> > > So perhaps something like "Remove the sanity check to allow child devices
> > > which only support MSI".
> > 
> > Thanks, updated.
> 
> Sorry for the extra work I have been putting on you this cycle. I trust you
> understand it is for good reason.
> 
> It is unfortunate that I do not have hardware for most patches I sent. The
> best I could do was staring at the patches until I think "yeah, that
> probably isn't broken". That obviously isn't good enough to remove all
> bugs. I wish that I could do better, but oh well...
> 
> Thanks Ammar as well, for helping me tracking down this bug.
> 
> I hope this one is the last regression report that we will see.

I'm sure intel can get you a proper hardware spec. Referencing marketing
white paper material to guide software changes is not a good idea. :)

