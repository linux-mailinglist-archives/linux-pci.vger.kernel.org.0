Return-Path: <linux-pci+bounces-16597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E69C6445
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40624B274D1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA6219E35;
	Tue, 12 Nov 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnm9qj4Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE81FA829;
	Tue, 12 Nov 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444199; cv=none; b=svVf0AUGwU72E2R3zVAFeUkMPP0cu3aE09Hx0SidUNzrXMtImjvDZnH0pac9YO8Rc63y+eTup2ZKDD9WI3b5lDXnc6qPkghHkV0e7srLnM9xoT5FOY9q7iHOVJyPaiZGjsI3y5MIcy4GMea8xlEgjHOVq4RzcZU5kOCn1gRVHYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444199; c=relaxed/simple;
	bh=uCIUvFOHKd4vWrNkE3Ky5+joDIchMtFW/pXudOijcjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U2n0G4G2dx/44rZEqwadQRcNDKmccSTdz1lJL+mTsMdXa0OZliZUd/CjduACHsnxvvaiNopgXnWj7ZoXp4+8OCX/OYqJdT7w0FBd6yraNr/Ap1knbsMPFzaXS+TCYgzfh2uiJbFrH2kS4B7DoHCZWX70uVKzh7y9hzNY7AEGi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnm9qj4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4147C4CED5;
	Tue, 12 Nov 2024 20:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731444199;
	bh=uCIUvFOHKd4vWrNkE3Ky5+joDIchMtFW/pXudOijcjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nnm9qj4YO7t7yRtay8zlvvq7BjmYiabXd9kX+zwB/11CmC6Z37UjzdCFiG41vjqEs
	 BtFolebgwazQ/41k0XWr01u6Vhtkx1JPhyK+rTHLAgotDA+UlkKKLhpWCUoN8c1w2W
	 eKjYRecKuHMTfWxKzrqU9bVDX9oOpt78IklIRaaPa2Ij+1hjj9qXd1xGL7uk7/wKGn
	 EtPRo8fuy0y4vwGyJCb44LhN63jug3g+bH+dx7Rf//il61BtCKNW6qIYiMQjY2Us1H
	 8YTJf5rv6ltdQVLuYbLtstfncNYtE4wSctg1/ih2LCIT1Izp3/n+oPuFkb7+823pkf
	 //8rkL7WKGbbA==
Date: Tue, 12 Nov 2024 14:43:17 -0600
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
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 7/9] PCI/bwctrl: Add API to set PCIe Link Speed
Message-ID: <20241112204317.GA1858532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzN4pO0lJDTSySaz@wunner.de>

On Tue, Nov 12, 2024 at 04:47:48PM +0100, Lukas Wunner wrote:
> On Fri, Oct 18, 2024 at 05:47:53PM +0300, Ilpo Järvinen wrote:
> > +EXPORT_SYMBOL_GPL(pcie_set_target_speed);
> 
> My apologies for another belated comment on this series.
> This patch is now a688ab21eb72 on pci/bwctrl:
> 
> I note that pcie_set_target_speed() is not called my a modular user
> (CONFIG_PCIE_THERMAL is bool, not tristate), so the above-quoted export
> isn't really necessary right now.  I don't know if it was added
> intentionally because some modular user is expected to show up
> in the near future.

Dropped the export for now, we can add it back if/when needed.

Bjorn

