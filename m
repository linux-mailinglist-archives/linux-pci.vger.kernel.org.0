Return-Path: <linux-pci+bounces-16909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2379CF323
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D816CB2B296
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B141D5CFD;
	Fri, 15 Nov 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYa1aWWC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FE84D02;
	Fri, 15 Nov 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691715; cv=none; b=pHBMphV7i+oMe379lq7SknmqdUS7rfWcTkhHoETdyD2Z/1tY3GlyiPV66zKFDNRKRF2+rPpr9tWH6otd7TfWIGIy3gb/MNezNLRFkRR0oWERd9Gmbod85LvElA9CjqqqaPovw9XIOVLfWPhwvxpdQEqsXZSrkQgshL/0ZJYX158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691715; c=relaxed/simple;
	bh=KyYJ/FcwK4MFIP4OtoiBgZVuLgsPGiS1DsVgNoTACfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FHeX0B3J+EZhrnn8+BIii47wlihKJMEs5LTZbMpFpeyatgiXTXDb9kmSBQglvpu2RMEPvJOpsVPjaaMuklLz8hepGxSSfeS45MKEA31oIESdyLwDI1a4p9+edxYqGiHfcsjaYipoahsmtGENfWNhKc90OphZWI7QXAm59fEB6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYa1aWWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83753C4CECF;
	Fri, 15 Nov 2024 17:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731691714;
	bh=KyYJ/FcwK4MFIP4OtoiBgZVuLgsPGiS1DsVgNoTACfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NYa1aWWCYVM2EsvgIx8yuxDRJQJ9z3zIGsINPCDgJuV0a9gaJ7SP3az/6EgsDoc1Z
	 C0OPffYgopFoAdsHSzNH4z2sT6dzvqzLawbUykuWSNpSgzh96Vvz1UzdHoLm3ns6Rh
	 CFmkG/X297Kd4jYQXewx7eeqE/47n39CySs9d2vETfFtrDyxsA22vevdRUsPAbkb3t
	 s+Ml4jPlw/KMPmecVQiBAr4CYGRYbrWHYWBPsS5eAKkZMaAq0r1IxqI5I8eM6nzw8p
	 USm90huFNDI0pKDyok2Z67iXvUXm+mybskj98B9PtdGqhyMHw0L0tEtU/+51Fogev6
	 v4tLZ1UYgiukg==
Date: Fri, 15 Nov 2024 11:28:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 8/9] thermal: Add PCIe cooling driver
Message-ID: <20241115172832.GA2044695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzRm1SJTwEMRsAr8@wunner.de>

On Wed, Nov 13, 2024 at 09:44:05AM +0100, Lukas Wunner wrote:
> On Fri, Oct 18, 2024 at 05:47:54PM +0300, Ilpo Järvinen wrote:
> >  static void pcie_bwnotif_remove(struct pcie_device *srv)
> >  {
> > +	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
> > +
> > +	if (data->cdev)
> > +		pcie_cooling_device_unregister(data->cdev);
> > +
> 
> Just noting a minor nit here in what is now commit 7206400cda87
> on pci/bwctrl:  The NULL pointer check for data->cdev seems
> redundant as pcie_cooling_device_unregister() just calls
> thermal_cooling_device_unregister(), which in turn contains
> this at the top:
> 
> 	if (!cdev)
> 		return;

Thanks, I dropped this NULL pointer check locally.

