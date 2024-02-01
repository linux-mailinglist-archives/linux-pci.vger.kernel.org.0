Return-Path: <linux-pci+bounces-2948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CEC845EEA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2A01F2E5F7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E595E7C6EC;
	Thu,  1 Feb 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExsA38x9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F527C6E5;
	Thu,  1 Feb 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809904; cv=none; b=ULaR7dZC6932DFghQV9hBWcD5IoJC2onAvd1EDFph4PtpeVmiOHxmNqyZXPsy+LObmkTjvEmVChB0PdChpPQ2Qwclty31yHMvwLfM1XNOkfjcgLOlEEJrlpGk2FUhqV8BOapFv6f5tRZ7r31C/OvyXCKOFPdt/jkWNvwm6pk40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809904; c=relaxed/simple;
	bh=NBAq41sZrAhFrxvxlRsGWF+jxtCI89vEGX4NEy3bXfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EJYea1q2u5CHhvor9CgznrdHyWoNUaYFROwLOYrbNr+hacY+ub5pBQG4fFMiSzkMVVdSckNvMYLMwpjs7q0Zi4WJe9RaGx3blsySBcEdYMH6tskfnjqrpMh171jioWSn4xdDGasDvvGnlsotxRuf1UzjDBVGm1/dQCahP2WSJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExsA38x9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2013C433F1;
	Thu,  1 Feb 2024 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706809904;
	bh=NBAq41sZrAhFrxvxlRsGWF+jxtCI89vEGX4NEy3bXfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ExsA38x98f6hOZjGbIhdvMv1awDlLZZlwBAUZSdOnQViU+wBbfPEeccnwrqTGXQGA
	 ZR7Uza+yZDSdy4fVi0MtEa0obgFSBH2lN0I98Soca7bZ/zJS4AQMVVc9gucfOdGSKl
	 oBjGlQCrt4/Q9zrsloIJsPjOfHdLiW+euHBxuWeYEazbuwrQB9ti1SetEMHWGtKgt8
	 3ayRrK/BooXovf843Bw0Q5YFVxq5Jmf4+WeU/eM9WHm2LfWPbDkqUWdCDPDWgPpZ0P
	 VI0wl2uikH0ufgLE8r+l/ObB6zYx++PXBK2xcLCT0QPsVYApsgDMdP/mtFXBs6kZAu
	 McT/zuIRxraKg==
Date: Thu, 1 Feb 2024 11:51:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: PCI: dwc: Add 'msg" register region
Message-ID: <20240201175142.GA640715@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-pme_msg-v2-5-6767052fe6a4@nxp.com>

Still has mismatched quotes in subject.

