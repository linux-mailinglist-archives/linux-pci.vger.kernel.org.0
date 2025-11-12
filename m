Return-Path: <linux-pci+bounces-40975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7FBC51881
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D1FB4FF086
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135602FE566;
	Wed, 12 Nov 2025 09:50:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD122FDC5B
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941014; cv=none; b=r5I49P4rEn3i88IFltqQod0bxl5msxP9H81jmXH3qBKAq8VjSA4jXbtNUX1SJ6lTDi6pXHk/R3jYM7eSq7BVdwLo/xyhOxFfCA9LMDY2GnKqPSMjI0Nm64E1TQdWblgidnRu+3ws5jY+ME2KcoUanfYaOgXw07+62PJFGy2IQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941014; c=relaxed/simple;
	bh=pWaoinVZH7rlrVoExU+UXZcijLxigr8ftAiDGCtifQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfE5cJg3WX/5aodezP57RWT0aTzENO1EG7dmLQME8ZLtHz7nQwA7qwGEOmT+w1Hm/cobIz7LLjcQuctlwwEt7iA9lr+RxYSl63ESU1CsENxSo5YT3JsE7zT8PYYhZlGcOAo3CKGUr6g3ohNzXz0L6NIxIzVxnPGE6fdIPMEwzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CA721200C2E1;
	Wed, 12 Nov 2025 10:50:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BD4D8137E4; Wed, 12 Nov 2025 10:50:01 +0100 (CET)
Date: Wed, 12 Nov 2025 10:50:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/PTM: Enable PTM only if it advertises a role
Message-ID: <aRRYSQO9DKo_7ipy@wunner.de>
References: <20251111061048.681752-1-mika.westerberg@linux.intel.com>
 <20251111153942.GA2174680@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111153942.GA2174680@bhelgaas>

On Tue, Nov 11, 2025 at 09:39:42AM -0600, Bjorn Helgaas wrote:
> I do wonder about the fact that previously we automatically enabled
> PTM only for Root Ports and Switch Upstream Ports, but we didn't
> enable it for Endpoints until a driver called pci_enable_ptm().
> 
> With this change, it looks like we automatically enable PTM for every
> device that supports it.  Worth a mention in the commit log, and we
> might also want to revisit the drivers (ice, idpf, igc, mlx5) that
> explicitly enable it to remove the enable and disable calls there.
> 
> PTM consumes some link bandwidth, so the idea was to avoid paying that
> cost unless a driver actually wanted to use PTM.

pci_pm_suspend() and pci_pm_runtime_suspend() call pci_suspend_ptm()
and there's a code comment preceding the call that it allows platforms
such as Intel Coffee Lake to go to a deeper power state.

So apparently PTM not only has a bandwidth cost but also a power cost.

Thanks,

Lukas

