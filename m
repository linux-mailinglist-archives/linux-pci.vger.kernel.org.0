Return-Path: <linux-pci+bounces-27356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FBAAAD863
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924C23B0B28
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF926220F24;
	Wed,  7 May 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyVJurje"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570A20FA86;
	Wed,  7 May 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603489; cv=none; b=DzTaXfrygeujofGGsNPg9PecPlXlpKTk5R3fFUn6UoqiCb3dGxdbD95LnvZP5G5PEU+vv77fEn5Ji+qgvGYoany3T+MeV84OkMFXPaLKhZGV2QokD0lhCx0+Pq5t6Cj6eZyxvFowquxiKem7g7EfRNQSAy8MDmc8Ryts0u9zUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603489; c=relaxed/simple;
	bh=u+94YTkIK1yodzp++T2HMB+oePCPOpIrqtliTXH6QBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGvrDKoKw/f8ODjkTituDrbsaD5qw3sbllJEv3U79mBXiHLiIJBZp+ec+pLTg2W5nZlP8U+uA5Jw6YLRYDf2gMBG7nUxMILrpIisj1rG6yq86/o/5uExq67t703KfXdtQG6cUjNo0OoKNTW9TE4krBa2hoyu6sZyUrweOpGc5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyVJurje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7A2C4CEE7;
	Wed,  7 May 2025 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746603489;
	bh=u+94YTkIK1yodzp++T2HMB+oePCPOpIrqtliTXH6QBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyVJurjeBVyWd0G4t6kNsd8et1PSYUrBGqs3MV3TTtICVDqAPr1gZrx094VjLWDPk
	 S1RHk810ExOMe3Plnpi/9lAoeGTwFcSOqjzcfHXAJmJ7VvllQ4kRLt6V5lDIhirnCG
	 ayPbPG5iFPwEFPD/0sbOGcniB0tkc3uJURu1rXFsnN0jYdEooMQHvgIdL/BPdNCJzS
	 zUCCV72YUsIzuaSVGk1+1RGJ2M85dEfzB/HVz72Hm0RC4pYgQtYszjDkqRI9TL5usf
	 qYo0Gdh/ulmD9cwhOOIvH1+8pwt6FhazSFU6pwVosm3T1ltDep5tY6IRvhxDDiaP1I
	 W5upt/sdhcU9g==
Date: Wed, 7 May 2025 09:38:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org,
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org,
	robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/3] PCI: Configure root port MPS during host probing
Message-ID: <aBsN2_YG0RsH4RPA@ryzen>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506173439.292460-2-18255117159@163.com>

On Wed, May 07, 2025 at 01:34:37AM +0800, Hans Zhang wrote:

(snip)

>  static void pci_configure_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge = pci_upstream_bridge(dev);
> @@ -2178,6 +2209,10 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
>  	}

We should probably add a comment explaining why we are doing this here.

Perhaps something like:

/*
 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
 * start off by setting root ports' MPS to MPSS. Depending on the MPS
 * strategy, and the MPSS of the devices below the root port, the MPS
 * of the root port might get overriden later.
 */


> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +		pcie_write_mps(dev, 128 << dev->pcie_mpss);
> +
>  	if (!bridge || !pci_is_pcie(bridge))
>  		return;
>  


Kind regards,
Niklas

