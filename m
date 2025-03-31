Return-Path: <linux-pci+bounces-25015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF7A76D04
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC93E7A433F
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4441DE4E3;
	Mon, 31 Mar 2025 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6JhxUyO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605D86347
	for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743446922; cv=none; b=EelSgBFKhCqStvh/G5UThi044PjcvTJ5rsKu+uBL9jDjkn4S3G28D98VxWTlByFQveiMSZYv1/ItcQzdEck9MHoX3SWQBYJfFC8SJxb/LfsciZJSJ1aStM2pwCYoMZXBceqm8SmjEVSeD9TrOHsOacm36oQB5PKFTC5Cx9rRnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743446922; c=relaxed/simple;
	bh=SsGxhJgxTJ467GVRi5Ioi/i+BQfvyi/JyXDynpvc2W8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DKdO8fHnsTcMU2Vu4p4ylZKn9HCzxEeXRoY90iPUSp+CwwJgmqMbkovMZALkAB7zPsvzqoFlaqdLRFYCrEIKN5uI1GQpVt2ZHyUi6q0/lQQ2/r2KHofZgcDAdhfNs41X0iWWuQR5bb3YsfXn50Ao1Ump/NefI+Hu02U9HlgROhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6JhxUyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C276AC4CEE3;
	Mon, 31 Mar 2025 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743446922;
	bh=SsGxhJgxTJ467GVRi5Ioi/i+BQfvyi/JyXDynpvc2W8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J6JhxUyOTHQMaitzQLr8FVObg+tsEv+n3Y3uU6JTkpZNtU1lMl2MqpmFI9+LcbxND
	 YqbibGbnSIRUeTBOgoQYlviURFubBhDcfwzncdwU5TM30icZJvfu4RoYgUbH+yY8/x
	 Xnvyxz++31Gv/cCGDpcwWwc8OeaWXOBulN71LOremhRxZkzStmuqIqtUIxELTCXMYc
	 G6g2ixSp2gj4alVP7WrsGFx7T3QGQnI+SimVeN7Xw4EvfYIKeC5NpHvNJi5M06pT7g
	 LHcViNUZY31dFR4q35S7xiwxq0oY5uO3xm4+kFclxZdAy1wEcDXexfY23vTEch+Gch
	 lBdm8Ssp3trzw==
Date: Mon, 31 Mar 2025 13:48:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250331184840.GA1170881@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321015806.954866-7-pandoh@google.com>

On Thu, Mar 20, 2025 at 06:58:04PM -0700, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).

> +static bool aer_ratelimited(struct pci_dev *dev, unsigned int severity)
> +{
> +	struct ratelimit_state *ratelimit;
> +
> +	if (severity == AER_CORRECTABLE)
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
> +	else
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
> +
> +	return !__ratelimit(ratelimit);
> +}

I found the __ratelimit() return values a little confusing (1 == print
the message, 0 == don't print), so this is appealing because it's less
confusing by itself.

But I think we should name this "aer_ratelimit()" and return the
result of __ratelimit() without inverting it so it works the same way
as __ratelimit() and similar wrappers like ata_ratelimit(),
net_ratelimit(), drbd_ratelimit().

