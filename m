Return-Path: <linux-pci+bounces-30185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF12AE06BD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9901BC5545
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB1236A73;
	Thu, 19 Jun 2025 13:15:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4F2472B1;
	Thu, 19 Jun 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338920; cv=none; b=g0dTccTlk7qsvGSXsm/Bte9ENGilaSQcUQi2YtIMAj6Wzl2CUfKuEzjXZ0AQIbziW2MZkXgkef97l7WFMYHlK7j5dozuw2CfqwCFSH+HGZ1pwIS9Q2+dxBrFj9d8xYBOhntiRrR/NIlikf4l66/SsVV8R/n9HQB4HoJggkvZeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338920; c=relaxed/simple;
	bh=AeSgFFFQI7owhohnK+ar5oPVTwBeVMCIKMJlUx7kFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYt8bNX5xiOG0165q3L1+4hfxEbcPdLBqy3lWCFh8TYQK0ouEkL6YRl9FOCo5C8VWhp7dQ0pOOLmIpla3NlfJT7AAWj+u/dYZjO96rC5iIR2mXIJgoq6HGnw/PluiEDo96TPzfChYPoGZ+eexbF94O3y85hXlMCpezEWN03l5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 921EF2009D10;
	Thu, 19 Jun 2025 15:15:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7C5323A085D; Thu, 19 Jun 2025 15:15:15 +0200 (CEST)
Date: Thu, 19 Jun 2025 15:15:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Krzysztof Wilczy??ski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Fix secondary bus wait return value when D3cold
 delay = 0
Message-ID: <aFQNYwAuEG1t2iB4@wunner.de>
References: <20250610115532.7591-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610115532.7591-1-ilpo.jarvinen@linux.intel.com>

On Tue, Jun 10, 2025 at 02:55:31PM +0300, Ilpo Järvinen wrote:
> If D3cold delay is zero, pci_bridge_wait_for_secondary_bus()
> immediately returns 0 which is inconsistent with the rest of the
> function.
> 
> When D3cold delay is 0, infer the return value like in the other cases.
> With link_active_reporting, use Data Link Layer Link Active (PCIe spec
> r6.2 sec. 7.5.3.8) and otherwise call pci_dev_wait() with zero delay.

I guess Mika implemented it this way on purpose:

If d3cold_delay is zero, the devices on the secondary bus are
immediately available and there's no need to wait.  Note that
pci_bus_max_d3cold_delay() goes below the default min_delay of 100
only if pdev->d3cold_delay is lower.

And pci_pm_init() initializes d3cold_delay to PCI_PM_D3COLD_WAIT
(which is also 100).  So d3cold_delay has a different value only
if it's changed in a quirk or similar.

pci_acpi_optimize_delay() actually sets d3cold_delay to zero under
certain conditions, so your patch *will* cause a change of behavior.

Bottom line is, I think there's nothing to fix here.

Thanks,

Lukas

