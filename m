Return-Path: <linux-pci+bounces-14232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C51999374
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CEC1C229E4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C41E0495;
	Thu, 10 Oct 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="pMF193xb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277C1CF2B3;
	Thu, 10 Oct 2024 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591100; cv=none; b=h2nPAvVK/LxZzv86QcmJv74HaoS7jlEQSbdcVhZtR/NTsYJ5jFnzdOHImeQ2sG5VuXxNaPj8JnG8097zBh/rOrTnwX+krK76DXQZ3lR5fyigRoPmosOGBwkBjlgvn2nsDfju+e8Dr0kAO7oQ2i8bZudZUFEx3ZZ0K+Xw1EwbPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591100; c=relaxed/simple;
	bh=YUURegqHlzdMc+l9OPp0EJKPdH70Hf31zc5tVc3O95A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmzFISW/WMK3N/8vDA/CN+YR4JPrJeS8815lB6fSXNYIdYYUuW7iMpR1NbnZwEj6BpQ2WfvI0t5a82eV4ISDXjVxKSAlIMeIzYh5iYXfPjcccgDynU6a4JeobD1YWg0QJf9gEvfWFfTtWNW+ZLwzHUIacH8/Jui2FkE+dmENJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=pMF193xb; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E31AD1F969;
	Thu, 10 Oct 2024 22:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728591086;
	bh=/I/lOPCvj/ZjeWChjY+DvX2ksqrYKCeJpqQ5rwBLawg=; h=From:To:Subject;
	b=pMF193xbTFIzRJTY6djU4mXUsm9R6/HW+dM2v2iOS9lqEfsk32VpZ1E+pXfqj1ZCx
	 1iPu8rpsjf/LD2jXnV7Qpun5CQDjei5WZC0/I8J7v/9OfxbirdO2ZA16oZzQ3qvEyL
	 M9869aCZ+4aUDBQ0dcZDu9qR72BPi8TOd8FGDfgD8tm2mM6sl5OipwVagnB8xIn7CW
	 UgwZiMmbL+u1yMEi3VfclrXSkFe3PQmQkDQCioAVXdt1IocqHiZsE+gsoVZHcrP3Fc
	 pu/9bUqsvXMpwD6T6I2b71P/zRbSSvrzg0Q0J+BERe6M+88IgeIVMLM/lx1WzGL+tx
	 48dIdF46pK8/g==
Date: Thu, 10 Oct 2024 22:11:21 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Stefan Eichenberger <eichest@gmail.com>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241010201121.GA88411@francesco-nb>
References: <20241009131659.29616-1-eichest@gmail.com>
 <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>

Hello Frank,

On Thu, Oct 10, 2024 at 04:01:21PM -0400, Frank Li wrote:
> On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > The suspend/resume support is broken on the i.MX6QDL platform. This
> > patch resets the link upon resuming to recover functionality. It shares
> > most of the sequences with other i.MX devices but does not touch the
> > critical registers, which might break PCIe. This patch addresses the
> > same issue as the following downstream commit:
> > https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> > In comparison this patch will also reset the device if possible. Without
> > this patch suspend/resume will not work if a PCIe device is connected.
> > The kernel will hang on resume and print an error:
> > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > 8<--- cut here ---
> > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> >
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> 
> Thank you for your patch.
> 
> But it may conflict with another suspend/resume patch
> https://lore.kernel.org/imx/1727245477-15961-8-git-send-email-hongxing.zhu@nxp.com/

Thanks for the head-up.

Do you see any issue with this patch apart that? Because this patch is
fixing a crash, so I would expect this to be merged, once ready, and
such a series rebased afterward.

I am writing this explicitly since you wrote a similar comment on the
v1 (https://lore.kernel.org/all/ZsNXDq%2FkidZdyhvD@lizhi-Precision-Tower-5810/)
and I would like to prevent to have this fix starving for long just because
multiple people is working on the same driver.

Francesco


