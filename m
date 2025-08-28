Return-Path: <linux-pci+bounces-35043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE8B3A823
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD823AABAC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B83375BA;
	Thu, 28 Aug 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm8QlKSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A423ABBD;
	Thu, 28 Aug 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402313; cv=none; b=BiIA1QV5TjQ85v/+eQrbCHJQpLLZgD74nGK15mzaWJldCMYA0iTrPxi0hPKoIi4/NCrdZqyDvQsHB0i3HUpG22bt0a29cNTWoRmxZdUmd17gb8YG/Ploe8N4/ysSHhYwycMFDbkTMv2LHnloR26O4ZO1OZbExLp/Q2/8tc3mWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402313; c=relaxed/simple;
	bh=vl9K/umacKTfK8n27M0KwHBfAPbKCprrGgu7yc+VISM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gB/uz38hofrgGWY9zM2+iTrdF290/tAwP/LUe3jZi4i2UszBTlx4vmAqHNys15L994D2rFUmzWXDpHAQOxaWEtGkzQ9DPAB0PV2szEXBzE1BRKgL2VzKvSj0Q2I3rZ9EqNTLW6KRb3vwBGZmTNuvy9Nx1/5Xx4dLEjqiLdEPVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm8QlKSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAD3C4CEEB;
	Thu, 28 Aug 2025 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402312;
	bh=vl9K/umacKTfK8n27M0KwHBfAPbKCprrGgu7yc+VISM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Nm8QlKSUyPe3Gf+UCV04JeGw8KneAP2RaHR1A4YbseNmdkgRMIY3thPtQ/OAYQiqm
	 rp3ocwBxMk/z+rHqd3B3InJvp1jblMILJ8F44Ut8sekeJqhuMCpm+VVbun3jgnT//q
	 q0lW/PAxNv/v+VJ6n0eT+l5UxBBHcIAWlsXm/8Q5IroJBUY9QpO12Xnvn9FXHPslGE
	 sHC5eDUO0UKs2FOZh0vS5hlguumDWK8S8lyFXrZ9svJWpBcdmUBMxo7iH7EljoSAk4
	 QTHLNxoCXsQjUo/wNZpIa9zzlYtq6gjBnxsDClXPPdwPYrbU2icH59w927cENgcDjw
	 K4izz/zKsSrjw==
Date: Thu, 28 Aug 2025 12:31:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	LKML <linux-kernel@vger.kernel.org>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/24] PCI: Bridge window selection improvements
Message-ID: <20250828173151.GA950809@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d209c08a-56df-5aac-869d-7c6c548c0614@linux.intel.com>

On Thu, Aug 28, 2025 at 07:47:06PM +0300, Ilpo Järvinen wrote:
> On Wed, 27 Aug 2025, Bjorn Helgaas wrote:
> > On Fri, Aug 22, 2025 at 05:55:41PM +0300, Ilpo Järvinen wrote:
> > > This series is based on top of the three resource fitting and
> > > assignment algorithm fixes (v3).
> > > 
> > > PCI resource fitting and assignment code needs to find the bridge
> > > window a resource belongs to in multiple places, yet, no common
> > > function for that exists. Thus, each site has its own version of
> > > the decision, each with their own corner cases, misbehaviors, and
> > > some resulting in complex interfaces between internal functions.
> > > ...

> I'll need to do minor corrections into a few intermediate patches though 
> to ensure bisectability, we really want to make this as bisectable as 
> possible. In other words, I've found 2 relatively small issues in them 
> which won't change the end result when the whole series is complete and 
> fixed some small grammar errors in the changelogs.
> 
> I see you made some corrections so I'm not sure what's the best course of 
> action here to update them. Should I just send v2 normally and you deal 
> with your changes while replacing v1 with v2?

That would work for me.  Or if you picked the patches from
pci/resource and posted a v2 based on them, that would be even easier
for me.

