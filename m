Return-Path: <linux-pci+bounces-11147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C794550C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 01:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA981F22D33
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44AA14D702;
	Thu,  1 Aug 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taHRRej3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3D13E04C;
	Thu,  1 Aug 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556674; cv=none; b=jymn90CMJIxatP6/3g03ZkfZ/1ZodZ8i0ftjDmqST1MZXpzA1znk8pKi7FRRjJDL4XDVwc3FgFpk3DWiigevrLzBDS4bj0mRjHsagMovkHkCxMqEnmkAnTqzt8EgERi0u8LlPQRScDyel32ZMsJGvCq5GsH6YCaXy9oYWF1zj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556674; c=relaxed/simple;
	bh=NJ5xjYh4vu5N0CFN9vwh+aQ8qN3AxM5GyydRpZOCIvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N0Ss8/efvv+ISXJaWVLJtyx17SCHKabRj244EeN4K9oQwPUY611buMJbPFsxXV4ovCoH6rzk2cMlSNXutc4gfbVc/tQ7pqfZmAfElZP/B0t9wldKDFUq2mQeUk5WVWvbPL17yFVrd7UVjTNmQCw1T4TXRjrBovGr6Ie5PD8ov7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taHRRej3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD92C32786;
	Thu,  1 Aug 2024 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722556674;
	bh=NJ5xjYh4vu5N0CFN9vwh+aQ8qN3AxM5GyydRpZOCIvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=taHRRej3xlM327yIOchm3zAl+K/qSRW8YYeDoaMPLx6u9Ab3Kqq3ZZOsfGrbXqDQi
	 uKQLhjUmOSwBxriuhDCx0s5EtSDz/JgcMrOcDuWWkNRSbHt9zYFUebT8zc4TLSDgj5
	 vyv1ni0M16DEGA+pQ30hWDsiMLVm+tPlpx2tf56RahbUKYCEY0yOneDM3AmBpm/o76
	 Ztzy9hfxlbD2qK5xn+0/Wc9TUXzBRIRq3Ew8ZV5De+8ROOzgPoV+aH5rBR1zc0rGYq
	 oKL1oGhUlPVMHTsbbdM2W/matl6h0Y/yl4uRPtUEffS06ZLn/FN3OLTHoZvep7T8uN
	 fCxOkA1ZD5MQQ==
Date: Thu, 1 Aug 2024 18:57:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, yazen.ghannam@amd.com, avadhut.naik@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH v3 0/3] Parse the HEST PCIe AER and set to relevant
 registers
Message-ID: <20240801235752.GA129276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>

On Thu, Jul 18, 2024 at 02:24:02PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
> r6.5, the register value form HEST PCI Express AER Structure should be
> written to relevant PCIe Device's AER Capabilities. So the purpose of the
> patch set is to extract register value from HEST PCI Express AER
> structures and program them into PCIe Device's AER registers.
> Refer to the ACPI SPEC r6.5 for the more detailed description. This patch
> is an effective supplement to _HPP/_HPX method when the Firmware does not
> support the _HPP/_HPX method and can be specially configured for the AER
> register of the specific device.

Just to close the loop on this, I'm assuming you'll rebase to
v6.11-rc1, fix the warnings from the robot, address Yazen's comment
and post a v4.

> v1->v2:
> - Move the definition of structure "hest_parse_aer_info" to file apei.h.
> 
> v2->v3:
> - The applicable hardware for this patch is added to the commit
>   information.
> - Change the function name "program_hest_aer_endpoint" to
>   "program_hest_aer_common".
> - Add the comment to function "program_hest_aer_common".
> - Remove the "PCI_EXP_TYPE_PCIE_BRIDGE" branch handling in function
>   "program_hest_aer_params".
> 
> LeoLiuoc (3):
>   ACPI/APEI: Add hest_parse_pcie_aer()
>   PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
>   PCI/ACPI: Add pci_acpi_program_hest_aer_params()
> 
>  drivers/acpi/apei/hest.c      |  66 +++++++++++++++++++++-
>  drivers/pci/pci-acpi.c        | 101 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   9 +++
>  drivers/pci/probe.c           |   1 +
>  include/acpi/apei.h           |  17 ++++++
>  include/uapi/linux/pci_regs.h |   3 +
>  6 files changed, 195 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 

