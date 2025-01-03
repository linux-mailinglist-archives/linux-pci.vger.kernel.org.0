Return-Path: <linux-pci+bounces-19206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A30A004F0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 08:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C031883F58
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97ED1C760A;
	Fri,  3 Jan 2025 07:28:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC11C5F33;
	Fri,  3 Jan 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889292; cv=none; b=ZA56UzDL8pIWYthd2Co1Wku2jqzIZjmUyQziF68dVkMoZTYX9jfwQVNgSRgWH34P3+lmpDuDjLcHYhvrDcgLeZ85QiZOiHO+p41A8tQifcE/Hyxfps8i2aJ8K2BXIr44K+lGmtbNLMi4ucQksS6OGB2vgiimc0yRB6slMwVkGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889292; c=relaxed/simple;
	bh=hDWEfUzTIhiBFhANnJ+9N4J+UrEmd6wQ5HUaT9fsztk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQVHVmv/gfULn3Ayn89FRPgFncd3wrNe389jJX0bGgp34GtGOvbKKoEhunf/sSjPkGiH2wZDbuXXOgT5h/Hvnt60g+FIPomkxzE8Ib5rI4ZY3hYWiEPx+QXbDoQrTeQfwRAKXWHuIwTiMH6ME/0mg8slvb43Zc3d3WE3U4KIF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 981C868BEB; Fri,  3 Jan 2025 08:28:05 +0100 (CET)
Date: Fri, 3 Jan 2025 08:28:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20250103072805.GB28920@lst.de>
References: <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com> <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de> <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com> <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
> The Qualcomm platform (or class of platforms) we're looking at with this
> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
> 
> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
> state by Linux as of today, and I'm trying really hard to convince some
> folks to let me describe it correctly, with little success so far..

Well, not advertizing the right mechanism isn't going to cause havoc
to any scheme.

> That is the real underlying issue and once/if it's solved, this patch
> will not be necessary.

Well, maybe this thread gave good enough fodder to finally fix it?

> 
> > In theory, ACPI S3 or hibernation may request that, but I've never
> > seen it happen in practice.
> > 
> > Suspend-to-idle on x86 may want devices to end up in specific power
> > states in order to be able to switch the entire platform into a deep
> > energy-saving mode, but that's never been D3cold so far.
> 
> In our case the plug is only pulled in S2RAM, otherwise the best we can
> do is just turn off the devices individually to decrease the overall
> power draw

FYI, going to D3 for S2RAM seems perfectly reasonable from the NVMe POV.


