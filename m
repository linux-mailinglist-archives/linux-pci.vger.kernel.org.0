Return-Path: <linux-pci+bounces-4266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC62186CF0A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 17:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC8DB2BD52
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C57580C;
	Thu, 29 Feb 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="v87BRxfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E637827D;
	Thu, 29 Feb 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223624; cv=none; b=FHDcEWgx2P2NsxNsECV/1PjKxveumD7RS4zACVO/QahsnEZeUrLE3ItJ3N1B2ifYDfz7yWS0FcIkend5YIDp2gSZ4ChvRaMDp+RuNDlFUirM6oE1A31+X9MtXBNlrOzZxF6yZxZSld9f0BkPFkNwsdQt6/1b86RXyi5mh6FbwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223624; c=relaxed/simple;
	bh=EG0AQMhvajtRtj7h37GNmIv5kRJfqZmGy40sXuFridE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzQWw2rpED7wokga3mr5Eg5vVR93okFYsH44/wNltaVDd3hhvxTbD0xl6QGCwA+Y6tpOAD6KjNYkWOniJh6Sma8oOaLSs5ruIeq9H0423FIZZxneiLrFRTXHH8A0vJ9ueJ5FdQfIhPF/BWCcuw+bEXQkmDjr4SJQZA10m8XtTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=v87BRxfS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709223618;
	bh=EG0AQMhvajtRtj7h37GNmIv5kRJfqZmGy40sXuFridE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v87BRxfSazLj7SyYlAEei17Nshjcn1N/7j/le0FQKvKyn9t1w2mlSvIJyECKconh2
	 RjSMpnq374Gzpm1BbKC5mPYhUibBC5OlBVlKG61EMd9gx+u2koByF3KXndn6DJKiFe
	 p4rrd6vMfCPyd0zQHf7DItjKcA74Frp1INQEkAyQe+wnB/gdQ3fTel4zHvpDDHzLG2
	 tH1uHCZvZEO5+gJftGYLxRSYWlgJWmm1EvWF/1UYJ3I/yS0jA8UEiML7QyNm6K6+Bf
	 n19mw1ODQiItTyfDgpJUfsS1JagKYT/E+qDprAGxuyAHFnrarbAXXkeY14zyaPwSso
	 +MIfSuYq3vpdQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 643CC3782066;
	Thu, 29 Feb 2024 16:20:15 +0000 (UTC)
Date: Thu, 29 Feb 2024 11:20:13 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Assert MAC reset only if PHY
 reset also present
Message-ID: <27b54e13-35da-44cd-9f02-a48a84c63e79@notapiano>
References: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229092449.580971-1-angelogioacchino.delregno@collabora.com>

On Thu, Feb 29, 2024 at 10:24:49AM +0100, AngeloGioacchino Del Regno wrote:
> Some SoCs have two PCI-Express controllers: in the case of MT8195,
> one of them is using a dedicated PHY, but the other uses a combo PHY
> that is shared with USB and in that case the PHY cannot be reset
> from the PCIe driver, or USB functionality will be unable to resume.
> 
> Resetting the PCIe MAC without also resetting the PHY will result in
> a full system lockup at PCIe resume time and the only option to
> resume operation is to hard reboot the system (with a PMIC cut-off).
> 
> To resolve this issue, check if we've got both a PHY and a MAC reset
> and, if not, never assert resets at PM suspend time: in that case,
> the link is still getting powered down as both the clocks and the
> power domains will go down anyway.
> 
> Fixes: d537dc125f07 ("PCI: mediatek-gen3: Add system PM support")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

With this applied resume finally works on MT8195-Tomato! And I no longer see the
errors I mentioned in [1]. So,

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

[1] https://lore.kernel.org/all/d8cfb804-e47a-471c-8bc0-e974ee045655@notapiano/

