Return-Path: <linux-pci+bounces-16474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C639C46D2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CF9283740
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34B16EC19;
	Mon, 11 Nov 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI8/4gq6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610691B95B;
	Mon, 11 Nov 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357025; cv=none; b=aK14I5FXthCIEGj5G1KP+hjeQRbHlg3ttr6y6YiPrmZ4rXj5YHW73KxJ8HKDP2N5pisxbMOEpIbQsPzEH+Zf8IKwwjSI/3VHSIEAQZufhpYJJIPrpiNDdDgejpmg5ETb4dH4DUuah3AXHoWEG8iZFgSEMT4eTICe7G9Kkk6vYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357025; c=relaxed/simple;
	bh=eFV6Mn9rlXPZKNihJg/acSCpZerYn1vyH7FUQTaubZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bkwVeRwR+RxAOIL/H48aiTpI9JqAuwxpZwhF1hFN1JFyG4GEwHjoYf+8+NLl8+VvG2jz+UM25VvwRqZzVaq2YfkFlJVIJFZlPY663KOYZkvisrp7ONF0dSawDXA5TPryPq2xX1iyJdMPFCxzYmbMhtgu9s9GgmWsdVCnkPlJgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI8/4gq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F6C4CECF;
	Mon, 11 Nov 2024 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357025;
	bh=eFV6Mn9rlXPZKNihJg/acSCpZerYn1vyH7FUQTaubZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gI8/4gq6Yr6ar+OCNS6VAjGcLnm81nZyKzFPy6mZJ3dUSsi0ZKKaf+3ZDY1W+AQjf
	 hbmpDvXRA0qa+AjNngfU01CZsUXiiS8blrpbqOW7Hksjgp1BQpdiP/EYkvT1TEQTcD
	 RLWPjpVMt5mlyBpxrg/r2Ii+vdPgkIrURTp0LasCIUteCWvEpHhn2zEzH1wIOzF5Wu
	 FW8TrRMeXVFPC/wPCMweLozeYcBbNhzV/2gr8viGSpFhuegah57nYZo1QJNpcDPp5D
	 wc7OM+pI2/hgbCZW7R+h4P+V3G/xGC+oCHMPcxB1dZrrG7h9O97SQm+0N0EmCh4Vkt
	 gzLxBTZt4F5QA==
Date: Mon, 11 Nov 2024 14:30:23 -0600
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
Subject: Re: [PATCH v9 3/9] PCI: Store all PCIe Supported Link Speeds
Message-ID: <20241111203023.GA1816689@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzIFV8UNYSvgZtQM@wunner.de>

On Mon, Nov 11, 2024 at 02:23:35PM +0100, Lukas Wunner wrote:
> On Fri, Oct 18, 2024 at 05:47:49PM +0300, Ilpo Järvinen wrote:
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index be5ed534c39c..a02b77fe7865 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -303,6 +303,7 @@ enum pci_bus_speed {
> >  	PCI_SPEED_UNKNOWN		= 0xff,
> >  };
> >  
> > +u8 pcie_get_supported_speeds(struct pci_dev *dev);
> >  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
> >  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> 
> I realize this is now already queued as commit 73ee11953294 on pci/bwctrl,
> nevertheless one belated comment:
> 
> Since there are no callers of pcie_get_supported_speeds() outside the
> PCI core, the above declaration should probably rather live in
> drivers/pci/pci.h.

I moved them, thanks!

I noticed duplicate declarations for pcie_get_speed_cap() and
pcie_get_width_cap(), so I'll add a patch to drop them from
drivers/pci/pci.h.

Bjorn

