Return-Path: <linux-pci+bounces-11350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6029489A0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 08:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BDF285E35
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D11BC9F7;
	Tue,  6 Aug 2024 06:53:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1D15B147;
	Tue,  6 Aug 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927187; cv=none; b=JZk5P2vk6o+ilSvBLCw0BCCFPBnkFoqQtgZM6o2kwgrrrIOCiugt1fQ/prMzX5UaQHshWUAOK3nHbL4loyxT3lmck+wh3SaacmV9ysC1aKXI3Qhrf6v2kDMcsuGVMLEglSuv4I2wBuJb88gx0T2vvM4mEGzgJzBEJ9tNgQFcCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927187; c=relaxed/simple;
	bh=XqxcGCRMECyTsBkrwwKzGy9qu0WpXUhddQXpzpKFkPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaxOc7aMJ+y0S9hGNglJ14XWreWmH0EOLWdg/sW30ZmUegmt12m/ojJncSeAXZKdVQx36PKkUfI5TPyDUycNJsL6mvRL09RfO4ZOq/xH9IUXxIrIHnubUflKmhlam+I7qMSlcVqFe2+MCqTlkauJfff1arePqyOh7/7F3brCm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id BCBC8300002A5;
	Tue,  6 Aug 2024 08:53:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A884E323E0; Tue,  6 Aug 2024 08:53:01 +0200 (CEST)
Date: Tue, 6 Aug 2024 08:53:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <ZrHITXLkKrDbQKQp@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805133555.GC7274@thinkpad>

On Mon, Aug 05, 2024 at 07:05:55PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 02, 2024 at 12:13:31PM +0200, Lukas Wunner wrote:
> > The PCI core cannot put devices into D3cold without help from the
> > platform.  Checking whether D3cold is possible (or allowed or
> > whatever) thus requires asking platform support code via
> > platform_pci_power_manageable(), platform_pci_choose_state() etc.
> > 
> > I think patch [3/4] is a little confusing because it creates
> > infrastructure to decide whether D3cold is supported (allowed?)
> > but we already have that in the platform_pci_*() functions.
> > So I'm not sure if patch [3/4] adds value.  I think generally
> > speaking if D3hot isn't possible (allowed?), D3cold is assumed
> > to not be possible either.
> 
> Why? D3Hot is useful for runtime PM and if the platform doesn't want to do
> runtime PM, it can always skip D3Hot (not ideal though).

AFAICS we always program the device to go to D3hot and the platform
then cuts power, thereby putting it into D3cold.  So D3hot is never
skipped.  See __pci_set_power_state():

	if (state == PCI_D3cold) {
		/*
		 * To put the device in D3cold, put it into D3hot in the native
		 * way, then put it into D3cold using platform ops.
		 */
		error = pci_set_low_power_state(dev, PCI_D3hot, locked);

		if (pci_platform_power_transition(dev, PCI_D3cold))
			return error;

Thanks,

Lukas

