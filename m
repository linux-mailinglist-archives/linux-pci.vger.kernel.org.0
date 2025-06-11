Return-Path: <linux-pci+bounces-29485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CBAD5D60
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C15E3A7F90
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D41B21AD;
	Wed, 11 Jun 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4FPfz0a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93E2F41
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663791; cv=none; b=SIf9eYoO4wpTFS+4k5vscfYRkYW5oTTnfsjb7Lx6fItj/8BdMOsKR+tZ4p2aBli2lOVcCSby0u+3Et+62VLkav0L9f1Y7rCPLmRRezHCYjPY4/ZUluLNv9SSIDzmD2+Ka6HNiegmYb9kSAZCX5GAdgpTwBZd/BgYYae86NxcoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663791; c=relaxed/simple;
	bh=v2PtpQkliuh4rOAtp1Bp9/gC7C3c53XQKvEH6vU71a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDE/wmr5VmTDV1nWRnazH0g5VVD9frjR2EDpcRxVVPOuLltDkryeAnJfHedfkbmzBxNhdHK1e4koII5/DdENk14RG7g6F42QkgAtUqRRVO56ZpRMEOymDMkR9SnmPWLdbkLDacVloKFK4fKGWv3JTwbmfHH6//f+405QHz3nES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4FPfz0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF93C4CEE3;
	Wed, 11 Jun 2025 17:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749663789;
	bh=v2PtpQkliuh4rOAtp1Bp9/gC7C3c53XQKvEH6vU71a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4FPfz0ayYi2zHXN+L8lYmg2BF02i/aKDXBOdKDeERH/7N3jqIPEiXbOc0B4PEYT9
	 hgNUGKF5iX6O/xHXj0uMDcmdV0oABlYYaomt1SI/g3DA7GJkJz7jbPhbD9Npct5OKq
	 dcfTk1J+X6fbXzya1EBoACYSO89VMeNR5RiS4otPVfGGpcQ41iQfeT/NVYszvlMIvl
	 XLwJEnOb0k7zHrmWPudYqAEfVlLCdqUzxLSETn/NQ7mtvn0sbVwk6Q7nuzswcHgPO7
	 KeJzbhKqbrG6QGk+t/EF3DIg7OzkzxmxkNc730UQ6pPxVZ3ifG+mOaAU8aUfNOF3qz
	 /cQ2+txwYUk4A==
Date: Wed, 11 Jun 2025 23:13:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable windows.
Message-ID: <obwqe4etp2cccwsnwiucgqptgcxkufjg3ryy5pdpgqrtzpets4@4nrtnghxgubf>
References: <PA4PR07MB8838163AF4B32E0BF74BDFD3FDD62@PA4PR07MB8838.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR07MB8838163AF4B32E0BF74BDFD3FDD62@PA4PR07MB8838.eurprd07.prod.outlook.com>

On Mon, Mar 10, 2025 at 09:51:03AM +0000, Wannes Bouwen (Nokia) wrote:
> Subject: [v2 PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable windows.
> 

There should be no 'Subject' prefix.

Also, the subject is not accurate. This patch fixes the check that is supposed
to check the PCI address range of the non-prefetchable region to be within 32bit
boundary, but it was checking the size.

> According to the PCIe spec (PCIe r6.3, sec 7.5.1.3.8), non-prefetchable memory
> supports only 32-bit host bridge windows (both base address as limit address).
> 
> In the kernel there is a check that prints a warning if a
> non-prefetchable resource's size exceeds the 32-bit limit.
> 
> The check currently checks the size of the resource, while actually the
> check should be done on the PCIe end address of the non-prefetchable
> window.
> 
> Move the check to devm_of_pci_get_host_bridge_resources() where the PCIe
> addresses are available and use the end address instead of the size of
> the window to avoid warnings for 4 GiB windows.
> 

'to avoid warnings for 4 GiB windows' doesn't really matter here, though that
was your intention of patch v1.

I think a fixes tag pointing to commit, fede8526cc48 is also needed.

> Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> ---

You should include the changelog for v2->v1 here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

