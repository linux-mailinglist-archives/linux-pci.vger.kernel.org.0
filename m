Return-Path: <linux-pci+bounces-27152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92494AA93FF
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5DA1887635
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37C2561A3;
	Mon,  5 May 2025 13:07:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3801F417E;
	Mon,  5 May 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450472; cv=none; b=qU8+pdPIsRfGtvSAerSajzZXZgvcR+DQVKH0t3nuig9jl6ml8tQ24tlyvC2658BW82oNZl24oe9TgWDsd+IyDu6VDCd85mBvXeA9PjQEcRRuRB+Gt6B0iS6XwBFgMgsKCKYr8empJVwqYvZWrjnVxqyocwRqYcGoPdOCz+BESCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450472; c=relaxed/simple;
	bh=0R116YkxYZ8fDGIY+zNpy7zIJt7PwPrBLh/F+DkYU4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+VUh4HyLeCSR69T/G4FfSQeoIQ0rOB2bbOIsxibRJaAM2paTVKPF5yUHcXQz1bb188BsBCCgmWqblXNZbyxOF7YGfXaIUNYWaO20m45q9B5NmNrnvmr1vzsRzGKy5qRhRSWZRfGyxjS46LScRTB33zTw8mgsFAoDL6yXBFNnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A3A472C051CF;
	Mon,  5 May 2025 14:57:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 08C5B149282; Mon,  5 May 2025 14:57:49 +0200 (CEST)
Date: Mon, 5 May 2025 14:57:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Moshe Shemesh <moshe@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: Fix lock symmetry in pci_slot_unlock()
Message-ID: <aBi1zYVNQ5qHbC4f@wunner.de>
References: <20250505115412.37628-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505115412.37628-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 05, 2025 at 02:54:12PM +0300, Ilpo Järvinen wrote:
> The commit a4e772898f8b ("PCI: Add missing bridge lock to
> pci_bus_lock()") made the lock function to call depend on
> dev->subordinate but left pci_slot_unlock() unmodified creating locking
> asymmetry compared with pci_slot_lock().
> 
> Because of the asymmetric lock handling, the same bridge device is
> unlocked twice. First pci_bus_unlock() unlocks bus->self and then
> pci_slot_unlock() will unconditionally unlock the same bridge device.
> 
> Move pci_dev_unlock() inside an else branch to match the logic in
> pci_slot_lock().
> 
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

