Return-Path: <linux-pci+bounces-3721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA785A2BB
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5062285066
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420392D60A;
	Mon, 19 Feb 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgGZxJ2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4B2C842;
	Mon, 19 Feb 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344021; cv=none; b=PY1XPn0wR6WHA5NP0bcwHA5uXkiYAtqbD86/pWnvDj50jSDL0GBIbldzs5XbpGsj4GZ++R7p+vhoG5eTVhElLWo/osMUlcuP9aYunp1UN41XvNXMkHnfJ7xpZDSRuQRuE33tEAL788j24mtNwd8Zy2URCwB9N3ACh8FiVPwlZdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344021; c=relaxed/simple;
	bh=KPJGEyp+8mjgucHi5TVoshHn75rjK/8wWiERVy3coCI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owRRda4q+n8R86P+JKDrenU0Kz2WhDY+AvMbRVQp6o43ASoXiWctslArS/1Mle6K2mjzXHLeAOylRTLP6ydZaTmeB/jIZDdNQ4nX1XHUiwuFFTPq93Y4ISK1qMruivmuSI7RipU2n23otSnvAbrcno7AGSH9RLZ/YN97yNWfzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jgGZxJ2d; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41JC07U3118394;
	Mon, 19 Feb 2024 06:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708344007;
	bh=cU8f6d3RpKc/TTtGEPnr+Al9HkYAPF1QNsCxZf4C8gA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jgGZxJ2dvkrIPjoRF3Q46cnAErwClWjeY2my0tjcjVC/ZsRl+jI2rh5UG+biWmsz+
	 UNrDYzW/6HExJ1h3V3rmjI/kkkN6ux41SmEJ17wywxqk/VvJ+5RUSbIMDjcUKv3XQD
	 zPXpDdCTfFonqmyX6xOPRiqfzhgxPF8yBXpw64tQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41JC029x003366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 06:00:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 06:00:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 06:00:03 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41JC021g003913;
	Mon, 19 Feb 2024 06:00:03 -0600
Date: Mon, 19 Feb 2024 17:30:02 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Bean Huo <beanhuo@iokpp.de>
CC: <bhelgaas@google.com>, <helgaas@kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>, <stable@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: Increase maximum PCIe physical function number
 to 7 for non-ARI devices
Message-ID: <37d21806-d964-40e0-a5a5-3173996e601f@ti.com>
References: <20240219112422.54657-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219112422.54657-1-beanhuo@iokpp.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 24/02/19 12:24PM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> As per PCIe r6.2, sec 6.13 titled "Alternative Routing-ID Interpretation
> (ARI)", up to 8 [fn # 0..7] Physical Functions(PFs) are allowed in an
> non-ARI capable device. Previously, our implementation erroneously limited
> the maximum number of PFs to 7 for endpoints without ARI support.
> 
> This patch corrects the maximum PF count to adhere to the PCIe specification
> by allowing up to 8 PFs on non-ARI capable devices. This change ensures better
> compliance with the standard and improves compatibility with devices relying
> on this specification.

The function "next_fn()" seems to provide the next valid function.
Therefore, if the current function is 0 (fn = 0), then the next valid
function will be 1 which is returned by next_fn(). It extends similarly
until the case where current function is 6 (fn = 6) which shall return
the next valid function as 7. So all 8 PFs are still treated as valid
and there doesn't seem to be any limitation. Only in the case where the
EP doesn't support ARI (there is no function 8 (fn = 8)), the call to
next_fn() with the fn parameter set to 7, will return -ENODEV which
seems to be the expected behavior.

Regards,
Siddharth.

> 
> Fixes: c3df83e01a96 ("PCI: Clean up pci_scan_slot()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
> Changelog:
> 	v2--v3:
> 		1. Update commit messag 
> 	v1--v2:
> 		1. Add Fixes tag
> 		2. Modify commit message
> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ed6b7f48736a..8c3d0f63bc13 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2630,7 +2630,8 @@ static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>  	if (pci_ari_enabled(bus))
>  		return next_ari_fn(bus, dev, fn);
>  
> -	if (fn >= 7)
> +	/* If EP does not support ARI, the maximum number of functions should be 7 */
> +	if (fn > 7)
>  		return -ENODEV;
>  	/* only multifunction devices may have more functions */
>  	if (dev && !dev->multifunction)
> -- 
> 2.34.1
> 
> 

