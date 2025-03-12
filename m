Return-Path: <linux-pci+bounces-23507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E8A5E035
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C97A2D6F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CCA24E00E;
	Wed, 12 Mar 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xgUseHpf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB2F24C668;
	Wed, 12 Mar 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792882; cv=none; b=eqpEN5IBWDjV4i46We8mT9cyb9M46IBph+acnt0/R2AZf46LN3IxA6rCDvDQ2dhllWLIJWXHvkTU2FZ36kc9SC8iKA2PbcQFAoqJXjB8GnQf4DqFNq6KpItP2wJGSLe+9ZZnJYrN+Jz8rjqXicUJNfKRfgrGnfomU46ZTwAKmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792882; c=relaxed/simple;
	bh=4sQmwkxed47J1yAVFY1M8IrVAON5A+0JqlWOAYiAt0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuhWWdqZgeDhxFlKVXs/fj44LA8EdOSpz3C4jEID2cUxUP5jSZELwdCzD09CzIBOTLHn7a5aOziOLQnkv4dEW4oIeydBZj1RyzTkfo+gVBhYhflfCPlBRQLi/SIagODU4gdZGn1kQHml/bSUWoTc6kPIq4rpf7zdU02+zwSwREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xgUseHpf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 39B93457EA;
	Wed, 12 Mar 2025 16:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741792879;
	bh=4sQmwkxed47J1yAVFY1M8IrVAON5A+0JqlWOAYiAt0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xgUseHpfm/duHTEwQRTgX7/pauJE0Oh8fZ2kNPDxNy4/6mY9AGXU20bYatRDGiRFC
	 2XLH9+jFCs8YySrzCSPu9SQgWGSribYev3e1rQ+pwqqyN1mqPJVu/ga9Vn74BA+J3H
	 UiyzKeGKERMvEZHmat4/khRc4SaEi1wdKZDg2XifJe4ljlAwPT69QcrPko87TXxxkQ
	 IHWTxAmwmKNFxYLYPVgWu/YHImYGBRl75RPl+uE9B9qlgJ1rBoX1F46qGH1sRbTTFZ
	 YBvFflm9hrsYcn3+iyZG/zm5sNDFxrm3QO+dMzCUZ9rBy0T7d0kQHMtsNOzdZtNKZk
	 E8iOdVUM4QuoQ==
Date: Wed, 12 Mar 2025 16:21:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <Z9GmbgYKr0VepQZZ@8bytes.org>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <Z9CEIlXoQJ-A0t-d@8bytes.org>
 <d55240a4-fe4a-48ea-b3a8-9a997bb7267c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55240a4-fe4a-48ea-b3a8-9a997bb7267c@arm.com>

Hi Robin,

On Wed, Mar 12, 2025 at 10:10:04AM +0000, Robin Murphy wrote:
> Argh! When I moved the dma_configure call into iommu_init_device() for
> v2 I moved the warning with it, but of course that needs to stay where
> it was, *after* the point that ops->probe_device has had a chance to
> filter out irrelevant devices. Does this make it behave?

Okay, thanks for the patch. I am currently building a kernel to test it
and will report back.

Regards,

	Joerg

