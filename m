Return-Path: <linux-pci+bounces-28397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8FCAC3A3C
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 08:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BE33A7198
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723172625;
	Mon, 26 May 2025 06:54:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768B148832;
	Mon, 26 May 2025 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242490; cv=none; b=eOYIeBv4AQbAWsqsARR7/yTF9CA9ZXzDOOIUowX1SPUyOh40FthCLX6ypHRX2+87atr3ZOwENoI3AukZPL7hx3ExUPvGKbhPd8gs/JSfzUuOUbE7BNZ05M8XhQLi8Vgfonm1rLcI3oDIXieena8mE9EKEdgyisnGAMuPdrUHKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242490; c=relaxed/simple;
	bh=osuS7BKWqOzSF3PaONFsCZYNsU9T5QvIVA2MXQscbUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8ly8p96v3mQQcr5k0iMOEcT/rMIZYp4w1aZ0emWfeSIKfmsjDrvUHPeD/0nRwU+wknx9PhOFCiHQC8hI9chJkcBKbLyL5PNIA/gAeyu75U+SxZqoqt0MM54dtw0WxMwSjchNaXMZi4U9c50uUrHLBA0rhOfL2XS8Kh3YjTkz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E66FB2C01633;
	Mon, 26 May 2025 08:54:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9CA99250B2A; Mon, 26 May 2025 08:54:37 +0200 (CEST)
Date: Mon, 26 May 2025 08:54:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, cassel@kernel.org,
	wilfred.mallawa@wdc.com
Subject: Re: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Message-ID: <aDQQLU1wrgstypEi@wunner.de>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
 <aDLFG06J-kXnvckG@wunner.de>
 <qujhzxzysxm6keqcnjx5jvt5ggsoiiogy2kpv4cu5qo4dcfrvm@yonxobo7jrk7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qujhzxzysxm6keqcnjx5jvt5ggsoiiogy2kpv4cu5qo4dcfrvm@yonxobo7jrk7>

On Sun, May 25, 2025 at 01:28:18PM +0530, Manivannan Sadhasivam wrote:
> On Sun, May 25, 2025 at 09:22:03AM +0200, Lukas Wunner wrote:
> > "The device state" is ambiguous as the Root Port is a device itself
> > and even referred to by the "dev" variable.  I think what you mean
> > is "The Endpoint state".
> > 
> 
> Yes! Will fix them while applying, thanks!

ICYMI, current controller/dw-rockchip branch still uses
"The device state", not "The Endpoint state" in commit
56eecfc8f46f ("PCI/ERR: Add support for resetting the
Root Ports in a platform specific way").

Otherwise LGTM.

Thanks,

Lukas

