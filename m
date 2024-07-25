Return-Path: <linux-pci+bounces-10776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26593BDBC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC88B2166C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F454172BB2;
	Thu, 25 Jul 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRDyAk71"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0161CD11;
	Thu, 25 Jul 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721895187; cv=none; b=n7kKGhjFOqSGjh7yx0UpNKv6xqsx1F7K+Q0a+jOFOMXPcq7b2cSFVjOobHrSDjRako2YLNN+35fIw7oGoVU/wFErHzCJm+DQmflYBCNTjshc0YrKsB29YyA/hZTBtOSMGDpyHny1rJuNYthwl5cnvsdWy/baN4IkDditZGzySt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721895187; c=relaxed/simple;
	bh=o3sIUlPYn9OmBSqi6y1yA1ROss+FDuoSUDrVt7rAf8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5fVHgSPCZGmolSNd0dpaIB5pgr8YlAXUG0bibgJ5TXAyei5PoX5gzOtRddBm5VtvnE2rdywiIHJjweMPkSBEKsiOhor4EAEdJIz8nKaAfzglDinHFcJZxu+TDk6USlOgDiU/dEaJORtxYavp89bj7eXIX/RzRFXhOBlpd1qW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRDyAk71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52121C116B1;
	Thu, 25 Jul 2024 08:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721895187;
	bh=o3sIUlPYn9OmBSqi6y1yA1ROss+FDuoSUDrVt7rAf8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRDyAk71jqi+YJ/HRwWAhehXpNTou4Tm6dEfe6CzDbcSJLWd6EAT3n8pyerFsZalF
	 H9lzXL/bWTaJ9NHczvIA3iiFP/y9s4BOm0Rgj0MTabhyqsAbWbOCWwJNiDiOyuW8oq
	 cN7zRRyYN32yD5qb3qyOob4VQy1nL9AOfKy2hvoJgHHrCdaraVSREx988wFohTvIv6
	 nU/VHqRxYkK9PswVLok+pkG4n8clBol07VdhkOPouguyONXfYgYmxjxhm7bAFdMESQ
	 3oVL+HENvuSa2OTphfd67pjueDiiosSgbjsWD0Cbdb7eBRg1/SM4G8rPLRK6EFXTpN
	 q/mjjbYa/cOKQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sWtb1-000000004mR-3J0n;
	Thu, 25 Jul 2024 10:13:08 +0200
Date: Thu, 25 Jul 2024 10:13:07 +0200
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
Message-ID: <ZqIJE5MSFFQ4iv-R@hovoldconsulting.com>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
 <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
 <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>

On Thu, Jul 25, 2024 at 10:49:41AM +0300, Dmitry Baryshkov wrote:
> On Thu, 25 Jul 2024 at 09:17, Johan Hovold <johan@kernel.org> wrote:
> > On Wed, Jul 24, 2024 at 08:22:54PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, Jul 23, 2024 at 05:13:28PM GMT, Johan Hovold wrote:

> > > > Note that this property has been part of the Qualcomm PCIe bindings
> > > > since 2018 and would need to be deprecated rather than simply removed if
> > > > there is a desire to replace it with 'vpcie3v3' which is used for some
> > > > non-Qualcomm controllers.
> > >
> > > I think Rob Herring suggested [1] adding the property to the root port
> > > node rather than the host. If that suggestion still applies it might be
> > > better to enable the deprecated propertly only for the hosts, which
> > > already used it, and to define a new property at the root port.
> >
> > You seem to miss the point that this is just restoring status quo (and
> > that the property has not yet been deprecated).
> 
> You are restoring it for all platforms.

It is already part of the bindings for all platforms.

Johan

