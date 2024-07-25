Return-Path: <linux-pci+bounces-10786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD293C0D3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 13:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D826F282D4A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB5198A3B;
	Thu, 25 Jul 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLRcDziV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489B197A77;
	Thu, 25 Jul 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906921; cv=none; b=PxGY1K9n5vU7AN3abEomYTr8UpdBJVmVLdT02VSY06Nr0ECqVN9v7AkOTeTPFJwDu8ZNUS7ejWdwuA5rHd83nCXPQ8Vz5W4BMnkLd4IZDmXZm6zKh/By3q8um3rBM2czx9lUtqHZ8L7s6+pQd3V32AIg7ObTIOObKL09y8Mbo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906921; c=relaxed/simple;
	bh=tqxpcbUfbmXq4gYPOLPFEL8D1WTclkWhQrqiFH5NKao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXYpyHy5ps0K+o9aGlWbDInOoTTnTC9Zu1SjUphTge1+Hfv4nWsnklrPNt5StCjyZgdvoJL5uZ4V2c2ZqYXi5J8RP2nwruS3Fg//BiQ4RJb1KAgQO/TAgbUUnd/hFqUaV0rN7aN/Tv1Tl3QwQ2CUnUZkddDdy3vKkvJvQ3AFbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLRcDziV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CB5C116B1;
	Thu, 25 Jul 2024 11:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721906921;
	bh=tqxpcbUfbmXq4gYPOLPFEL8D1WTclkWhQrqiFH5NKao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLRcDziVx8Skyei78ECJYsXdlBEmexjDpO0sziANWvbsRbLGYmkRaqzL2cNxWH2zk
	 d0Jt1RT3BSbMOuk2KD/Y1iKCbpelLxP+uVJ+WUv17zQiUalLM3bLRVKhAlbINfMvkB
	 ot1zwl8vHI1kq834F3+NVSTv9752DfX/uE49ojNQOhqyLCwlXo/Af2np5GytZ7zNwz
	 Jw5SbkZOddNs2rviEi9l8Bqe6apTsp5TKcx7wifpHfdW/2r/AqvC5TkyaaWyiGMJ8C
	 Y9vo4MGteIv98aiGWY1q5pd2xktQ8Lz+DmzKtXENI1IthCa0GxwEisSiE7hXtJdM9m
	 t0U1Y9d3B5StA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sWweI-00000000094-2Ffb;
	Thu, 25 Jul 2024 13:28:42 +0200
Date: Thu, 25 Jul 2024 13:28:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <ZqI26iACl_mQX-zG@hovoldconsulting.com>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
 <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
 <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>
 <ZqIJE5MSFFQ4iv-R@hovoldconsulting.com>
 <y6ctin3zp55gzbvzamj2dxm4rdk2h5odmyprlnt4m4j44pnkvu@bfhmhu6djvz2>
 <ZqIVQzQA5kHpwFgN@hovoldconsulting.com>
 <pbkzwy63j7dh365amgdze2ns4krykckqyx2ncqjw2u4dufuoky@fg6rdpnqh5vb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pbkzwy63j7dh365amgdze2ns4krykckqyx2ncqjw2u4dufuoky@fg6rdpnqh5vb>

On Thu, Jul 25, 2024 at 01:24:27PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 25, 2024 at 11:05:07AM GMT, Johan Hovold wrote:
> > On Thu, Jul 25, 2024 at 11:57:39AM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jul 25, 2024 at 10:13:07AM GMT, Johan Hovold wrote:
> > 
> > > > It is already part of the bindings for all platforms.
> > > 
> > > It is not, it is enabled only for sc7280 and sc8280xp. 
> > 
> > No, that's both incorrect and irrelevant. It is used by msm8996 and
> > older platforms by in-kernel DTs as well. But the point is that is has
> > been part of the bindings an cannot simply be removed as there can be
> > out-of-tree DTs that are correctly using this property for any of these
> > platforms.
> 
> It can not be removed from the driver, but it definitely can be remove
> from bindings.

You apparently ignored the word "simply" in "cannot simply be removed".

Johan

