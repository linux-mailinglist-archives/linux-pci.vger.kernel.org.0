Return-Path: <linux-pci+bounces-38516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2CBBEBDF7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 23:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F2A4215AF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 21:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E62D97B9;
	Fri, 17 Oct 2025 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyZBqmtF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F62D46C0;
	Fri, 17 Oct 2025 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738299; cv=none; b=YLjlZheJv4uiy2cYQ06y/I0RwmsNzdy8zYhbFEJTcAPxs9h/TDYDMvUbkB5j+ijZl9mtDIT+09kjGhhBJWOWuTXmbTU4djc4Ra1VYfRIthQ/SvWuX/KDPUpSmO7oTjlOHN/22qsFj+MCYBhcO0lECFR8/N+gg6n5gyQVjjLOQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738299; c=relaxed/simple;
	bh=vbyOPd6kY8TAyUO7T+YnYf/Nu9YmSqCoj4K2FY3LRxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qkw5PeiLC27wZwUfQ2ijV40wAVPlUOr4GgP6y5SHvsnxrCfcOgDja63Ddc2wKEb4C9An1yApstIumIKobLuhNTM3bSU7TVc6uVmdUfVh1rthmzFqo+qhqD5tvgY0afI+abH+jHnoIGdikC+pameltaCAdO7pFLVZVxXx8rluUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyZBqmtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1CDC4CEE7;
	Fri, 17 Oct 2025 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760738299;
	bh=vbyOPd6kY8TAyUO7T+YnYf/Nu9YmSqCoj4K2FY3LRxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pyZBqmtFa2HjyijG76eLA2Kb3jlwpa4P3fGkfpDuzKy/PzI3bSU0O+X1vs9vhX33c
	 eBam15qo59qG13fOK44aWvRUqqF6Kf8XNhyJfIjNsg7/6JekzlXw0lFhQNoRnIX0P5
	 wM23D8E+9JZZviYc5lPK3a2q+YzDUuckvXNLQ+BYNSwHEF824mpijOF1OKxtislGLb
	 JAkBcmHCjx0CRUWY8NNBSoMm8AEBDvnB1j+NBnQQCWzcSgGBsMHTlDKuA0NdQJPxzq
	 qd5uSAarsbdIQkDAvFnweMll6fsJRVxBxmfOD3Emzrw/ruTToNKESu1RneLyzIPunf
	 8Zy130Aj+kKdw==
Date: Fri, 17 Oct 2025 16:58:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 0/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Message-ID: <20251017215817.GA1047160@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com>

On Fri, Oct 17, 2025 at 05:10:52PM +0530, Krishna Chaitanya Chundru wrote:
> This series addresses issues with ECAM enablement in the DesignWare PCIe
> host controller when used with vendor drivers that rely on the DBI base
> for internal accesses.
> 
> The first patch fixes the ECAM logic by introducing a custom PCI ops
> implementation that avoids overwriting the DBI base, ensuring compatibility
> with vendor drivers that expect a stable DBI address.
> 
> The second patch reverts Qualcomm-specific ECAM preparation logic that
> is no longer needed due to the updated design.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Krishna Chaitanya Chundru (2):
>       PCI: dwc: Fix ECAM enablement when used with vendor drivers
>       PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the DWC ECAM enablement"
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++--
>  drivers/pci/controller/dwc/pcie-qcom.c            | 68 -----------------------
>  2 files changed, 24 insertions(+), 72 deletions(-)
> ---
> base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
> change-id: 20251015-ecam_fix-641d1d5ed71d

I hope we can remove the assumption that the root bus is bus 0, but in
the meantime I added these to pci/for-linus so we can build and test
them.

They're after the pci-v6.18-fixes-2 tag I just asked Linus to pull, so
they won't be in v6.18-rc2, but should make it for -rc3.

Bjorn

