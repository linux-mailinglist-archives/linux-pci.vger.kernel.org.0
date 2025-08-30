Return-Path: <linux-pci+bounces-35175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945BB3CA41
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03625E0662
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28214277C8F;
	Sat, 30 Aug 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJrcSsuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFB1DB34C;
	Sat, 30 Aug 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756550214; cv=none; b=ohwmXA0YkwNdov/C7jMrd02k8k5OcuyAnAfsghxtU7ISqiSSBzh02m0PE4aCV2UkdrsIhjMbb4a5Y48YyconIwcsfhwmSJ7A6YBa7cINiXcyuz45ShaHS9WX6wIfluy1FhfNJRkCLLe1cq0BBBw+Oa032V2vvzDPYGYaxxrUGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756550214; c=relaxed/simple;
	bh=wktQoMJ6heZ6PIZpSgy+ATEdVrh1/OExIzwglLTyTlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUwH/HlLin9y18nKGEBJ/6EJoNE8zBpzNjYQZk7enjMzSgVSGxWJf5qzi/r6h8KN1ylTa2w/BJQcwVWcVL24gY+Uo07qQ4BVT0YELGqsd2XDolnKBn3oCiT0ZjcLaFqT26N3+/ouiBKkyw15HXIg/TENz3wIP9r2LowtcTBnx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJrcSsuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238F6C4CEEB;
	Sat, 30 Aug 2025 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756550213;
	bh=wktQoMJ6heZ6PIZpSgy+ATEdVrh1/OExIzwglLTyTlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJrcSsuVVWWqHmwSatnrNsD5N2gOhXorzth/fvjy9EwHg/aVUDFfiiJLep28pkR58
	 ZCiawjK8Kvl58qMQSE89pUFYYok9QiEzg8CU4ilt9NwimafxfQiK7QSyBEZmrVz+qj
	 Ojk9BrCaQpYY4RcGJTigvt7WhK+uMbyafg51kAmT/cO8lf2g8VVdXowrrPkONroMog
	 QFfSUuyodnLd5dflcUduXX2Q57kPgejwxwOtnz+Md8nb5NBHoHsYFj7h63xUOn075r
	 bAmftLyD4Ds0VIK8dhkf6BpUd5l16qG9OQ+fNuK96YgiZaK8NpwgUSxV8bBRzpExsq
	 1KP8HdhAi+M3w==
Date: Sat, 30 Aug 2025 16:06:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/15] PCI: cadence: Move PCIe RP common functions to
 a separate file
Message-ID: <phxvk3wsr75btvhljdgakkoqz7lyza7x7sjut3kswwhutyhb7n@pihtlzszfb46>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-7-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-7-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:30PM GMT, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Move the Cadence PCIe controller RP common functions into a separate
> file. The common library functions are split from legacy PCIe RP controller
> functions to a separate file.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  drivers/pci/controller/cadence/Makefile       |   2 +-
>  .../cadence/pcie-cadence-host-common.c        | 179 ++++++++++++++++++
>  .../cadence/pcie-cadence-host-common.h        |  24 +++
>  .../controller/cadence/pcie-cadence-host.c    | 156 +--------------
>  4 files changed, 205 insertions(+), 156 deletions(-)
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
> 
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 80c1c4be7e80..e45f72388bbb 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> -obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> +obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> new file mode 100644
> index 000000000000..d34f8c7c49f0
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe host controller driver.

This should be changed to 'Cadence PCIe host controller library'. For
completeness, you should add the 'Author' tag also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

