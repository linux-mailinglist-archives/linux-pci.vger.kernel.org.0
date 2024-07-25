Return-Path: <linux-pci+bounces-10782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAB93BE56
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F61E28203B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC57E196D9E;
	Thu, 25 Jul 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6tTcWq6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555617557C;
	Thu, 25 Jul 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898306; cv=none; b=ZUaomTeBrw70Zq1F4KCNTjH6bUDxOVg2UkqeU/ffCPaNyCPGi3m6sEs6a46OINzcsFRqMxxSTUnKvrmDVNwaaB1iB9O7GUDoVNSBcjenVz6RZJDtU+usbdx2gqtjGX02LhFZ+xGwVtG3dSYK2TModKDsdaG8sm0nhXAiIGbsRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898306; c=relaxed/simple;
	bh=cQaxoH7sCpjY/+aRe/0buZnD8GJyvEDG+9PJ+3j6TCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHBX++0ajOzZ5R7hZhk/7IAQIrhmJ4lSkv3F7erGEoSyUNxkORWpIlYPsczvLvDUMgaqCPXzRpZev8a0d/G03SZdSh3yTNVsq+qLHCw5AFjdHkDprusIPI5NcRcn4epzWgYN2/bGP4RpPH2aNltU/OlcrcJowSY7ZYXsCXvExJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6tTcWq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8B2C116B1;
	Thu, 25 Jul 2024 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721898306;
	bh=cQaxoH7sCpjY/+aRe/0buZnD8GJyvEDG+9PJ+3j6TCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6tTcWq6kMciOcuhC3Vtu2WMy22VGBaCW6+by1GF9ZX3NubedOHeQtVYZvJMPLD0U
	 6Rr3GdoSEC1watzUwzRuOnAQyYvpMOq7xqJuTu4JS8rhWb8r9FuiBpOouqblGhYcVn
	 F+55LBv2UYuQUskAqhi1OxMs7Mlif0w/vWH1VvjVllTbx+JmaGlRTC3Cn29cNYoetQ
	 n0ZgoNXiBAOXntwPlhiEHt23ed0Z0tvn6qq76LDOdfJauFi+l1XLcjQUJjYTOjeAVZ
	 ZSZcKFQeoyzp+xugNJBbcg3YjTLV0A1XrAiOfpVdt80QMrR5NAQrP2rqltv65J2j4U
	 bW0aLpiZLrbTw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sWuPL-000000006Xd-3Nyx;
	Thu, 25 Jul 2024 11:05:07 +0200
Date: Thu, 25 Jul 2024 11:05:07 +0200
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
Message-ID: <ZqIVQzQA5kHpwFgN@hovoldconsulting.com>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
 <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
 <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>
 <ZqIJE5MSFFQ4iv-R@hovoldconsulting.com>
 <y6ctin3zp55gzbvzamj2dxm4rdk2h5odmyprlnt4m4j44pnkvu@bfhmhu6djvz2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y6ctin3zp55gzbvzamj2dxm4rdk2h5odmyprlnt4m4j44pnkvu@bfhmhu6djvz2>

On Thu, Jul 25, 2024 at 11:57:39AM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 25, 2024 at 10:13:07AM GMT, Johan Hovold wrote:

> > It is already part of the bindings for all platforms.
> 
> It is not, it is enabled only for sc7280 and sc8280xp. 

No, that's both incorrect and irrelevant. It is used by msm8996 and
older platforms by in-kernel DTs as well. But the point is that is has
been part of the bindings an cannot simply be removed as there can be
out-of-tree DTs that are correctly using this property for any of these
platforms.

Johan

