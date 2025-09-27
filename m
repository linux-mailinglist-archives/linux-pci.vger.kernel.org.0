Return-Path: <linux-pci+bounces-37161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32447BA61F3
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B0F189D8B0
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7921B22A4EE;
	Sat, 27 Sep 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB6P1/gb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADC28682;
	Sat, 27 Sep 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758993238; cv=none; b=jvXsPiCSRaSV9OjKmP3E8UHUbMP8OqQYRbjp20WnDtoj7e/o5p1yBBgqkLQvqbmU2ev9AbFdOyzXwN0y8ji8jXFXah6PSffB0VvEsOhhHMcupWK0+I+bRbBIcZWjdivMhp2r3Cq3zfCaQLBBo2AsmKPpuzUD66YhTKoG7YCm810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758993238; c=relaxed/simple;
	bh=UPwJmk4ldg8KBXu6w6vaTC7zYnb1eFmsN5xVC6npkvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sb2mD6wHUUlw2eWxCEBsEFIrYYLFjjdcn+Uc0clCI8W2UxOnmB7pWuf49g3CaYR6/MVvLUe/i8EyKFCH7V7WN1VkeF6h6UJRrrKd55bLDCFa6NlLy8HApFQAaqABc5FkRKe6MbCQSgpb08Q/axzHfvsDLxa4zKBaLaVI7VLRynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB6P1/gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFB0C4CEE7;
	Sat, 27 Sep 2025 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758993237;
	bh=UPwJmk4ldg8KBXu6w6vaTC7zYnb1eFmsN5xVC6npkvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WB6P1/gb1VjELK/N9F9nzYxpowbgL3InMM3qENEUZzu1RavzxqLhA/+3cqZTa+kCW
	 vSbSU/YMfxkmwopvcsM15Yl2KKTZSd4VlFpQ7D8LE722TgdJ3mdUdFpVemF8g98kTt
	 IylsGAtJ9cmu481EF0VHNCaykJ+XxC6MbnOyQ5y1VxoM0snULU9QguN1So/x97NTzs
	 11VWZC5JBaO9Mhw0+xaXvsl2qd4Fb/+f1s3kekxidTpK3CkLB9k8P4QAXr0oi54OVe
	 AKbgjgNIXRBK3PnGJ+dRIJ0wSMFUzHNdHz+C2yPGUBrZfdiXnry/nWz3pxMJnGd4Oo
	 7jwLsgmW2X+Kw==
Date: Sat, 27 Sep 2025 12:13:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
Message-ID: <20250927171356.GA20865@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:08AM -0700, Chris Li wrote:
> This is phase I of the LUO PCI series. It does the minimal set of PCI
> device liveupdate which is preserving a bus master bit in the PCI command
> register.
> 
> The LUO PCI subsystem is based on the LUO V2 series.
> https://lore.kernel.org/lkml/20250515182322.117840-1-pasha.tatashin@soleen.com/

Pasha's email points to
https://github.com/googleprodkernel/linux-liveupdate/tree/luo/rfc-v2,
so I cloned https://github.com/googleprodkernel/linux-liveupdate.git
and tried to apply this series on top of the luo/rfc-v2 branch (head
5c8d261fdc15 ("MAINTAINERS: add liveupdate entry")), but it doesn't
apply cleanly.

Also tried the luo/v2 branch (head 75716df00a94 ("libluo: add
tests")), but it doesn't apply there either.

Am I looking the wrong place?  Do you have a public repo with this
series in it?

Bjorn

