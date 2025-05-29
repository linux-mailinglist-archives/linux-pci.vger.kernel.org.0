Return-Path: <linux-pci+bounces-28581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D8AC7BE1
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EA51BC67CB
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132528DB7E;
	Thu, 29 May 2025 10:40:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BA288C8D;
	Thu, 29 May 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515229; cv=none; b=PJIbWaYU73X6NjNegnAWxkMFG36TmLOm8EFsbHbO8SJ1Og8S9arQTtmuADTKiJRAnZuGhnvEZ5ztJHvAG567qYo9rVJT+IqTd74Iwj+V2dMnYCyCA7slYh4SHiPjYzcGnzjXpGyiKY4Jq4eDKbDZdwqmcyyiZP117JXm1HGaRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515229; c=relaxed/simple;
	bh=UxGVSqNYEg/j9JIZ9TzAPE7mlxnvxUd7kLNBw4/t2sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkGtd8iFVZ6RxkL1frM2XUJyOUvsGpvwjDZn0AqnLVdKpfMGUUWI7wDwP1eh9xTz8aBfvM9eMqqHl/YQOGYO38S+9tQGySe7oZHP2xePOJcpq6CMye+SWlHWCCS4SsGU+ug0ObtSIen2AuPVINVOQ+6rJFLccixkZzyaCslAtrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C93712C06670;
	Thu, 29 May 2025 12:34:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ABF3F25C488; Thu, 29 May 2025 12:34:36 +0200 (CEST)
Date: Thu, 29 May 2025 12:34:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: grwhyte@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Reduce delay after FLR of Microsoft MANA devices
Message-ID: <aDg4PE4Zbzwps71E@wunner.de>
References: <20250528181047.1748794-1-grwhyte@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528181047.1748794-1-grwhyte@linux.microsoft.com>

On Wed, May 28, 2025 at 06:10:47PM +0000, grwhyte@linux.microsoft.com wrote:
> Add a device-specific reset for Microsoft MANA devices with the FLR
> delay reduced from 100ms to 10ms. While this is not compliant with the pci
> spec, these devices safely complete the FLR much quicker than 100ms and
> this can be reduced to optimize certain scenarios

How often do you reset these devices that 90 msec makes a difference?
What are these "certain scenarios"?

There are already "d3hot_delay" and "d3cold_delay" members in
struct pci_dev.  I'm wondering if it would make sense to add
another one, say, "flr_delay".  That would allow other devices
to reduce or lengthen the delay without each of them having to
duplicate pcie_flr().  The code duplication makes this difficult
to maintain long-term.

Thanks,

Lukas

