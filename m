Return-Path: <linux-pci+bounces-29955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11EBADD9DA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23872165BCF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D22DFF17;
	Tue, 17 Jun 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaFF0MHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC422FA65D;
	Tue, 17 Jun 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178974; cv=none; b=LqO+xcpOpw881jn40oM8PaZ5mn3D/02NY6PxJfssU/V0U5gRwbIVMShOGbPI5eaYCPdkq/8EeOY7FZICytgGKkl2ne6maDTa1BKapMSLOp31kS8H8IFb6AYOn1ZUsMK/2rAjWhVLDDZ2zJOwVEtb8XYS5BdRo3+26p1AdzsT/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178974; c=relaxed/simple;
	bh=jEpQjHvEgxjUr21tptc9aTVBtZFn15TNyZmIdalww0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB5yQMlWK9Qgl7mr+UyffdpYtI62/nrmmLqJPj485nj5V8ElFnUT3rikzcJ2XoQsBT0ZWlFyRvTFfy6r5ErPmTeJ7Qea+FaVoj97aItDWj1sWWo44aBnOVvyu+aUzUQ030j05EIMNy11P4UlTz9MFt0HqbCbtL2E/lUfZWprd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaFF0MHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC7C4CEE3;
	Tue, 17 Jun 2025 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750178973;
	bh=jEpQjHvEgxjUr21tptc9aTVBtZFn15TNyZmIdalww0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaFF0MHsIlQAMMGGdeGyfqazHmIaiExIxbYl9dG/yuKZuPzP4vz8JZTPn+P5UfyJE
	 gsaH1Icp7eGIGSOhrf5ez6dgr72NtugZZuVd73SXPuvGL7HUTucSraLfLKtjwmwFeo
	 QSrbtRCFp0J6uQE1RVRPRk/NjYSVaggophWc3NabXIztzOP5HDZqHDxaBOdLNNqA+R
	 jugmHjWGEVwisejQDpgyFQ2KJtdxVtbqL9pjCEUZbTqqjDST/wd/b67Ul7mfz+u1tM
	 z2QvFqgTegUfBx0VXEJwRfgAsT2JsEdzEMJxuW99urb12avw44vArKm8UWqm+DGJhq
	 btAkgz/2uSQYQ==
Date: Tue, 17 Jun 2025 22:19:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org, 
	robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Relax max-link-speed check to support PCIe
 Gen5/Gen6
Message-ID: <d26lnkthpe66s5jg5wufew3p4n6suoldijhcgnihiir5kkjtck@ik5io2tcmx2q>
References: <20250529021026.475861-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529021026.475861-1-18255117159@163.com>

On Thu, May 29, 2025 at 10:10:23AM +0800, Hans Zhang wrote:
> This patch series extends PCIe Gen5/Gen6 support for the max-link-speed
> property across device tree bindings and kernel validation logic.
> 
> With PCIe 6.0 now supported in the Linux kernel and industry IP providers
> like Synopsys/Cadence offering PCIe 6.0-compatible IPs, existing device
> tree bindings and checks for max-link-speed (limited to Gen1~Gen4) no
> longer align with hardware capabilities.
> 
> Documentation updates:
> 
> Patch 1/3 extends the PCI host controller binding (pci-bus-common.yaml) to
> explicitly include Gen5/Gen6.
> 
> Patch 2/3 updates the PCI endpoint binding (pci-ep.yaml) with the same
> extension.
> 
> Kernel validation fix:
> 
> Patch 3/3 relaxes the max-link-speed check in of_pci_get_max_link_speed()
> to accept values up to 6, ensuring compatibility with newer generations.
> 
> These changes ensure that device tree configurations for modern PCIe
> controllers (e.g., Synopsys/Cadence IP-based designs) can fully utilize
> Gen5/Gen6 speeds without DT validation errors.
> 
> ---
> In my impression, they have already obtained the relevant certifications.
> 
> e.g.:
> Synopsys:
> https://www.synopsys.com/dw/ipdir.php?ds=dwc_pcie6_controller
> 
> Cadence:
> https://www.cadence.com/en_US/home/tools/silicon-solutions/protocol-ip/pcie-and-compute-express-link/controller-for-pcie-and-cxl/controller-for-pcie.html
> ---
> 
> ---
> Changes for v2:
> - The following files have been deleted:
>   Documentation/devicetree/bindings/pci/pci.txt
> 
>   Update to this file again:
>   dtschema/schemas/pci/pci-bus-common.yaml
> ---
> 
> Hans Zhang (3):
>   dt-bindings: PCI: Extend max-link-speed to support PCIe Gen5/Gen6
>   dt-bindings: PCI: pci-ep: Extend max-link-speed to PCIe Gen5/Gen6

Applied patch 2 to pci/dt-bindings, thanks!

- Mani

>   PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6
> 
>  dtschema/schemas/pci/pci-bus-common.yaml          | 2 +-
>  Documentation/devicetree/bindings/pci/pci.txt     | 5 +++--
>  drivers/pci/of.c                                  | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> 
> base-commit: fee3e843b309444f48157e2188efa6818bae85cf
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

