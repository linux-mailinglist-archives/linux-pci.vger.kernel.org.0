Return-Path: <linux-pci+bounces-7271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694998C071A
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E7E2844FD
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5513281F;
	Wed,  8 May 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgDkL1UL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48637D530;
	Wed,  8 May 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205879; cv=none; b=E/CT7VndAwXPHpkVRIUZzOFpAEdNVfw8voI/FMl6jnoKmYvjr+rYEWdjNo9b1rEF99LUJO/EbIx+sAKabscGsFMtQOG4LkpKT3+lWLhgBNYu3Syr3U/5u/0+p5zqsl0UCRQl5V1uU7+3iWZSsG9+Hh3YCfjHQozGL8nY3PRv1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205879; c=relaxed/simple;
	bh=ZN+vFBI35D1ri+L+O7niU/x4x2qvaqXNVEPvYjNr4B0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ah4GAdah73BtpPukTF7EZkg9BdE4zzvYoLh0jSCX/YrbZGA7k88G/V7z626UkHCkd8dNtXcaeN4+Y40NetPDUqXNTqgfEPOFvhRJQCZRd9YpTbA4tiNuM/FURTyQKBYHLjip0IzS1crokGEbLfdw+nVNDyeNHtaKlnchCPfTv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgDkL1UL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8630BC113CC;
	Wed,  8 May 2024 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715205878;
	bh=ZN+vFBI35D1ri+L+O7niU/x4x2qvaqXNVEPvYjNr4B0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bgDkL1UL4cUDw/bK4TvVB6BnhfDeQox+XBPdaNKVEM1LYL8gZOLSsn5Gh1ch9Lr/o
	 ohlulgg51oRnHEmgSrqvubg2oZJBV0fv/NP0K6oHA2oceBzfZ+BtlQgP+LNgBJfzSu
	 dDkEosJ1IH1OSmv+iGO8wTqniE0C8IdDMiykTG8P1VFm9XuE7CwN40JSG/l60gEcre
	 sqh1DRhzCf73jGvgfUWfRVQn3Z4Invy59zKEey6PnezZ35cwLZvMX/MydyZWa0RLMk
	 zvf6tqrAuFXJSuI6nAOzLxAWdV0X3iRsrDT8cqgOZgUxHI3LEgf3tXFHwkOxsyvjTs
	 jMw0tS4koxC3A==
Date: Wed, 8 May 2024 17:04:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH v2 0/3] Parse the HEST PCIe AER and set to relevant
 registers
Message-ID: <20240508220436.GA1789788@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218030430.783495-1-LeoLiu-oc@zhaoxin.com>

On Mon, Dec 18, 2023 at 11:04:27AM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
> r6.5, the register value form HEST PCI Express AER Structure should be
> written to relevant PCIe Device's AER Capabilities.So the purpose of the
> patch set is to extract register value from HEST PCI Express AER
> structures and program them into PCIe Device's AER registers. Refer to the
> ACPI SPEC r6.5 for the more detailed description. This patch is an
> effective supplement to _HPP/_HPX method when the Firmware does not
> support the _HPP/_HPX method and can be specially configured for the AER
> register of the specific device.
> 
> ---
> 
> v1->v2:
> - Move the definition of structure "hest_parse_aer_info" to file apei.h.

Just noticed that this removes the ACPICA header dependency problem
that Rafael pointed out.  This also applies (with minor offsets) to
v6.9-rc1, so it's not very stale.  We're almost to the v6.9 final
release, so when v6.10-rc1 is tagged, can you rebase to that and
repost this?

I assume you have a platform that uses this.  It would be good to
mention that in the commit log of patches 1 and 3 so we have some idea
of where it's useful and where changes need to be tested.

> LeoLiuoc (3):
>   ACPI/APEI: Add hest_parse_pcie_aer()
>   PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
>   PCI/ACPI: Add pci_acpi_program_hest_aer_params()
> 
>  drivers/acpi/apei/hest.c      | 69 +++++++++++++++++++++++-
>  drivers/pci/pci-acpi.c        | 98 +++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |  9 ++++
>  drivers/pci/probe.c           |  1 +
>  include/acpi/apei.h           | 17 ++++++
>  include/uapi/linux/pci_regs.h |  3 ++
>  6 files changed, 195 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

