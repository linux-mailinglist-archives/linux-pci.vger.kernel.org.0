Return-Path: <linux-pci+bounces-36066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53365B55908
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 00:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59B51C85C1B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 22:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C81262FD4;
	Fri, 12 Sep 2025 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuQxxHsa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2E24A046;
	Fri, 12 Sep 2025 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715499; cv=none; b=Wwe2/zis3hel5epzjk8gA7XknU2HDV79JTB8+ECpr/Q9wQd4trpvz0iqCmjYGwWp9lq1S3p5s19tJAaZPpCmC6DprjQGZgbu/iI6J2ppDEbpk0TPwfuyxAfGf8yquNKg0wJ7RCi8fEapAP8hMkpACqp5Mfv/ATzVuU4d+GbitX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715499; c=relaxed/simple;
	bh=kLu6RnGhve72kIxJfLVveDvpDowMd3hCTSYR8/4G3dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JHTsDROMioANrCazzU6+CIRV/wa8lcvsr/4giIzfGo6mZ0hTL+pxE4GfsIQX8DS6k4O9kjdtKST268PNpYavzEf0MY/RK3vjigrZJ62Rw4u6TV+JFNfZzynoLZSJt92PPmMUR1G50+4yKiuklLUratHR6KNclTZpyGIIEcw4pQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuQxxHsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E5DC4CEF1;
	Fri, 12 Sep 2025 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757715499;
	bh=kLu6RnGhve72kIxJfLVveDvpDowMd3hCTSYR8/4G3dg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AuQxxHsaN1kg9VH6QnR7m0bHMqX1VI0Glu3XqOApBqq24YlRu6VMwLm513iS6Fhn1
	 lxhcWVmv9PHgENVqU0HmZMFLJtkgMidzxYDXbgVabu7aPo3CZw4r/wbxIECkSyAzBl
	 XZp4PDIWdjUyP+jIt/3QdivzrYG73wk5QEEznTmkHoHjyj3Dy3EizZN3+tZO9r/6zi
	 mFWY8Wtmn8AqMlpItl8DlN7/T/9zExzCQKm5YSfTU6YHuC3GFdfQmUfHs534G6vdbx
	 f7Wy/4+I8Vk+UtBlmPVDhHoX/Jh65Bzk67eaUjojsNRMqJlvqHtR3w8JCZXhAp6OiP
	 W6LhlAFdU8B9w==
Date: Fri, 12 Sep 2025 17:18:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pcie: s32g: Add Phy clock definition
Message-ID: <20250912221817.GA1650405@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-3-vincent.guittot@linaro.org>

On Fri, Sep 12, 2025 at 04:14:34PM +0200, Vincent Guittot wrote:
> From: Ciprian Costea <ciprianmarian.costea@nxp.com>
> 
> Define the list of Clock mode supported by PCIe
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  include/linux/pcie/nxp-s32g-pcie-phy-submode.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> 
> diff --git a/include/linux/pcie/nxp-s32g-pcie-phy-submode.h b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> new file mode 100644
> index 000000000000..2b96b5fd68c0
> --- /dev/null
> +++ b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/**
> + * Copyright 2021, 2025 NXP
> + */
> +#ifndef NXP_S32G_PCIE_PHY_SUBMODE_H
> +#define NXP_S32G_PCIE_PHY_SUBMODE_H
> +
> +enum pcie_phy_mode {
> +	CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
> +	CRSS = 1, /* Common Reference Clock, Spread Spectrum */
> +	SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
> +	SRIS = 3  /* Separate Reference Clock, Independent Spread Spectrum */
> +};
> +
> +#endif

I doubt this belongs in include/linux/.  It looks like it should be in
pci-s32g.c since that's the only use.

