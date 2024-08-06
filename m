Return-Path: <linux-pci+bounces-11356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9E948FEB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7719C1C210B0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351B1C57A9;
	Tue,  6 Aug 2024 13:02:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AED1C3F08;
	Tue,  6 Aug 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949367; cv=none; b=ChC+w5jvrG0J9AVVOXsijyAOfKpjQ0+Y+iCkZd5gAdvW170NUfDkQqgesNy32YM8QB4h6NlnZc7YMXl8/2G7uduWM/95CyXnqEjBKOAlUR3RU7DK1kZt1iEIv+IjRgJ+hLtTt6vZe70qU6HivhBM4ZlZNNR77bDtqf+vt4C1ESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949367; c=relaxed/simple;
	bh=QLbBnypIbU8z3vkmhXYCvE9K8LwGn4OIeMj+ESkXssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilOl1Z2uCt9eSGep+wBjT0dwT/E/BFmLTdrcqeVHMR/o9N2p8tPtVA2XGTKK3xWY8pLWSjaUseuqzdf9E+RnUeW6dUonLmQTBVZt16y3uqWa4GkO0RT8d89RNjfA8aC5iTX2vCD1zPNx8XkQ+qdnZiibtIVEm2fz2jzqS2KR+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id EE1382800B1BA;
	Tue,  6 Aug 2024 15:02:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DCB654AE4B; Tue,  6 Aug 2024 15:02:39 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:02:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <ZrIe70Z7uFven8HH@wunner.de>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad>
 <ZrHITXLkKrDbQKQp@wunner.de>
 <20240806124107.GB2968@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806124107.GB2968@thinkpad>

On Tue, Aug 06, 2024 at 06:11:07PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Aug 06, 2024 at 08:53:01AM +0200, Lukas Wunner wrote:
> > AFAICS we always program the device to go to D3hot and the platform
> > then cuts power, thereby putting it into D3cold.  So D3hot is never
> > skipped.  See __pci_set_power_state():
> > 
> > 	if (state == PCI_D3cold) {
> > 		/*
> > 		 * To put the device in D3cold, put it into D3hot in the native
> > 		 * way, then put it into D3cold using platform ops.
> > 		 */
> > 		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
> > 
> > 		if (pci_platform_power_transition(dev, PCI_D3cold))
> > 			return error;
> > 
> 
> This is applicable only to pci_set_power_state(), but AFAIK PCIe spec
> doesn't mandate switching to D3Hot for entering D3Cold.

Per PCI Bus Power Management Interface Specification r1.2 sec 5.5 fig 5-1,
the only supported state transition to D3cold is from D3hot.

Per PCIe r6.2 sec 5.2, "PM is compatible with the PCI Bus Power Management
Interface Specification".

Granted, PCI-PM is an ancient spec, so I think anyone can be forgiven
for not knowing its intricacies off-the-cuff. :)


> So the PCIe host controller drivers (especically non-ACPI platforms)
> may just send PME_Turn_Off followed by removing the slot power
> (which again is not controlled by pci_set_power_state())
> as there are no non-ACPI related hooks as of now.

Ideally, devicetree-based platforms should be brought into the
platform_pci_*() fold to align them with ACPI and get common
behavior across all platforms.

Thanks,

Lukas

