Return-Path: <linux-pci+bounces-37764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F6BC9A46
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1404E0F66
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B62E8B71;
	Thu,  9 Oct 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4tFvlZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51101991CA;
	Thu,  9 Oct 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021655; cv=none; b=J3VWHpbBadUKUXa92U4Y8V3tr/n5FcxRAku3bGupFsK8RlTXu/5t1AbsUTQNxno0THCqV74fAA4GwA56cttKZnrUSAudwPDvg84E6DM9oPfHeYvuv2+5XkAkh71KwFIzm9c4ojQS2fezjwz867xL6HXK8u/oB1r98iDejILPX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021655; c=relaxed/simple;
	bh=u7qQWcO8WuaNEapEtwOxfNG9MDLshhzuiyQfAaxCNq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvGYgy0SnRPuUC7eTUtqoC3IYrPReYE2+kJE2hyXybfxvhEHnxr//KE8SKWC/PMhA+hyOWnYNdpihYFqsCK9ZXfKIioCTHYRZ2EmFe5LUIn9jYTO6DNPdFGeVmR0+lRldVDbD3h3R/sJ+jnSm29l0zLrVRX9G01D+0ZrA/TzQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4tFvlZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FFC4CEE7;
	Thu,  9 Oct 2025 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760021653;
	bh=u7qQWcO8WuaNEapEtwOxfNG9MDLshhzuiyQfAaxCNq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4tFvlZHi1CmZ/v1/t8WhmzVGJ/ahXbYNipr380L74A5fmGsamnPFhqDz7Ec0b34X
	 Ir062HEqkFxgsQwy8klCqWLKs+JKkMDZL6dV8VsqYQto3yLuOWDcg3sMdRFL0RE7CS
	 I89mYxbAMuwp/ItW1nY2F8gsEsQ79KgzEfpWfE2BeBevFG0Mpy5A3VJigBdTHxExR3
	 nDGKO3G63wR+RwEF86pdkByEZtiPoQvxNPfY+HWWGFa3UYPuTUU9mVuXcs7PgWgIXt
	 nHqJ3zikw+kx2/u3ZarPv78R/CvwWmyocmBrjEiVzRB0DaSzZgejBbvuCkTzHR7v7v
	 efAtpQQzBRriA==
Date: Thu, 9 Oct 2025 10:54:11 -0400
From: Sasha Levin <sashal@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	helgaas@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	robh@kernel.org, ilpo.jarvinen@linux.intel.com,
	schnelle@linux.ibm.com, gbayer@linux.ibm.com, lukas@wunner.de,
	arnd@kernel.org, geert@linux-m68k.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 6/6] PCI: cadence: Use cdns_pcie_find_*capability()
 to avoid hardcoding offsets
Message-ID: <aOfMk9BW8BH2P30V@laps>
References: <20250813144529.303548-1-18255117159@163.com>
 <20250813144529.303548-7-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250813144529.303548-7-18255117159@163.com>

On Wed, Aug 13, 2025 at 10:45:29PM +0800, Hans Zhang wrote:
>@@ -249,9 +252,10 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
> {
> 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> 	struct cdns_pcie *pcie = &ep->pcie;
>-	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> 	u16 flags, mme;
>+	u8 cap;
>
>+	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_MSIX);

We should be passing PCI_CAP_ID_MSI, not PCI_CAP_ID_MSIX here, right?

-- 
Thanks,
Sasha

