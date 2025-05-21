Return-Path: <linux-pci+bounces-28212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E12ABF62F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE82C3AE670
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938B27F194;
	Wed, 21 May 2025 13:33:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555F27C16A;
	Wed, 21 May 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834397; cv=none; b=KwqmB/Z8+AWPvlt6uUqBy1UdvIJRjZSxiRgdRS2hcU8f8MVpjZ1p1WNJIenKAvpmccbW4iD2DjIwyyqZYQwC7Tn5KgfVJSS9bQol6vswAAMdbbHzXGI0ie6+x5J4Cd2LI3dUP8B9UwCB1qIiv0FaOqBM9hNOv4r9L5rEhJtI/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834397; c=relaxed/simple;
	bh=/kpC3OxvJHN8RxMVYVHLBRDyK+ravG6fOx3B63Lkpfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzGVzPzVe43CuH3fKU37/T2BSbm6MmP6QfAMpBDgjYctAR7hpgEQkVZlUlNpxy7G44vPpVOUsLo9SyXbzuQZ5nzSdzNhxY1ViDScgkjbEO/lEyE1nsAqf5YyIhcEOrJRj68jW5JiUDiBlT0AcD5dubTYJkUEf0Mv5O4yRRkekPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A52FB2C06E70;
	Wed, 21 May 2025 15:33:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7641E1B823E; Wed, 21 May 2025 15:33:05 +0200 (CEST)
Date: Wed, 21 May 2025 15:33:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <superm1@kernel.org>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aC3WESz-Jeox5_TA@wunner.de>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
 <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
 <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>
 <aCXW4c-Ocly4t6yF@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCXW4c-Ocly4t6yF@black.fi.intel.com>

On Thu, May 15, 2025 at 02:58:25PM +0300, Raag Jadav wrote:
> On Wed, May 14, 2025 at 11:25:36PM +0200, Denis Benato wrote:
> > >> You can see the dmesg here: https://pastebin.com/Um7bmdWi
> 
> Thanks for the report. From logs it looks like a hotplug event is triggered
> for presence detect which is disabling the slot and in turn loosing the
> device on resume. The cause of it is unclear though (assuming it is not
> a manual intervention).

Below the Root Port 0000:00:1a.0, there is a discrete Intel Thunderbolt
controller.  Attached to it is an ASMedia Thunderbolt controller.

The Presence Detect Changed event occurs at the Intel Thunderbolt
controller's Downstream Port.  Because PCIe is tunneled over Thunderbolt,
this means that the tunnel to the ASMedia controller could not be
re-established on resume, hence the Presence Detect Changed event.
Could be the result of the device being unplugged or some Thunderbolt
issue.

For the same reason, anything below the Intel Thunderbolt controller
is inaccessible on resume, hence the "Unable to change power state"
messages for the HDA controller on the AMD GPU.

Thanks,

Lukas

