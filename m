Return-Path: <linux-pci+bounces-30157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE5ADFD84
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8987189CF08
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D324466E;
	Thu, 19 Jun 2025 06:14:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833120E711
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750313694; cv=none; b=ClNiMJtVEgyDGQZ6zQTyZOl4v+5le9SFNujJ/fqE0BpM7AbBiWwDNYFo4MgF/Xg2R3sArxCuSmYoPNQ+723tehQOndIYUI0Beh05JAEmFEO3imiz1vEakStZMup6SROhxedXCFZE1Jn+9I1X4IrGEvifO91v9iAYhMTTrcnHX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750313694; c=relaxed/simple;
	bh=BCHoKRddxM+ppI0/fvB91W8M/yRTlG2BPlaogSqCEW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqSFClfmNLs3CGWHQOEpE3/Sn6e61CMiNk3cNFtX5D51MLvMRNGB5CF0PI3xU5zrDvIH1/nVrZQMzRjeLRqa598ysEHBu2jyUgh0V8S67YDW70c+gEBBiCIEJVew6rWJuptGkkFgkgRegL87wWnsa6QVc4PcTfHSJknHdXlDevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7566720091AF;
	Thu, 19 Jun 2025 08:14:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 61AAE331C6F; Thu, 19 Jun 2025 08:14:50 +0200 (CEST)
Date: Thu, 19 Jun 2025 08:14:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Don't show errors on inaccessible PCI devices
Message-ID: <aFOq2ub8P47kvmpC@wunner.de>
References: <20250616192813.3829124-1-superm1@kernel.org>
 <20250616192813.3829124-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616192813.3829124-2-superm1@kernel.org>

On Mon, Jun 16, 2025 at 02:26:56PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> remove issue a "Link Down" and "Card not detected event". The PCI core
> will treat this as a surprise hotplug event and unconfigure all downstream
> devices. This involves setting the device error state to
> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.
> 
> As the device is already gone and the PCI core is cleaning up there isn't
> really any reason to show error messages to the user about failing to
> change power states. Detect the device is marked disconnected and skip the
> messaging.

Code change looks reasonable to me, but should be cc'ed to Rafael.

I find the commit message a bit confusing.  I guess your point is
that it doesn't make sense to runtime resume disconnected devices
to D0 and report the (expected) failure to do so.  That's one sentence.
And the subject could be something like:

    PCI/PM: Skip resuming to D0 if disconnected

Thanks,

Lukas

