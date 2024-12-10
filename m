Return-Path: <linux-pci+bounces-17995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0419EAAD9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D617D188AE71
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BB42309A9;
	Tue, 10 Dec 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCrzhnw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FA1B6CE5;
	Tue, 10 Dec 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820155; cv=none; b=fHlat+8UgVsiNcyRDbqfWq7JmaJQyPP8TBcm/sd7SWia7bFYKt93kZiXWcd4KVAYP30TFJJAjO6I87kN387h7HoanvQDLgtCH2EoDylCTwtDV2viTy72ZtUbh0aIzeBdMImijfRjDNey8B/FRBBr0Lfltupr7Te7PPtAdnzBcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820155; c=relaxed/simple;
	bh=G8t0wrYfWDY2rAJLw2Cw7tM2KPGudkobjl+e7Exu9Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL00kocnfjqrdOskEIw6GItepei6aOExfIKg4pFy9UAum60j8HZX460KWWkjdwUYdDAvgQxcskJqUcoooyMioE99/Jv7lsFmiX35cIepbUOlEHTo30Z5m+dJrrD37PZlFCmtgcRFE3PJDCkpWhB5yMpWzh7Chd8IH1F2NMkM9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCrzhnw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405FDC4CED6;
	Tue, 10 Dec 2024 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733820155;
	bh=G8t0wrYfWDY2rAJLw2Cw7tM2KPGudkobjl+e7Exu9Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCrzhnw0IbM6b5fOAsdndYQ52jaYT9vuecQlSf73kTMiJ3NNovy/EJiF9Jc+Rjpn9
	 wq7ILDeODZqLOuWoP0wdnzWute9B5/wJOSiCJECCyX4gIzDum1CAkaj7XS0RXg6x3C
	 KwZyC+yPJ8ObjGrSM6a1x4j1Bn0yVL2FmRcN7aSj6voL9TMbA3t2s7oWVYe8RKjhkT
	 ulzHeEwccTbRe91/IuMioHjMahqUEgS9VodK8+1I707KLY6oWjXSh1rLnwrYLOZrPy
	 BUL8II2eIkLWsyQQW9LxXT0Y9DhE3Fj0pF34Gp2zdjyLKXJYwPx/K33lXcMcmdTqRI
	 xCI4lYyd/h1Jw==
Date: Tue, 10 Dec 2024 09:42:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Frank <Li@nxp.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <4v7ma5bkczhrc4syzahsr2kxg5ulxgmnsfktdrlztjobpdkcra@yppf5e4s5vay>
References: <20241206222529.3706373-1-Frank.Li@nxp.com>
 <20241209235121.GA3221844@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209235121.GA3221844@bhelgaas>

On Mon, Dec 09, 2024 at 05:51:21PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 06, 2024 at 05:25:27PM -0500, Frank Li wrote:
> > Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
> > layerscape-pcie-gen4.txt into this file.
> > 
> > Additional change:
> > - interrupt-names: "aer", "pme", "intr", which align order in examples.
> > - reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.
> 
> Is there any way to split this into two patches:
> 
>   - Convert to yaml and update MAINTAINERS
>   - Update interrupt-names, reg-names
> 
> It's hard to review the interrupt-names, reg-names when they're mixed
> in with the yaml conversion.

The conversion should result in a correct binding, so if original
binding had some issues (and TXT bindings often have: missing or
stale/not-udpated properties), then we expect any fixes in the same
commit.  New things, not supported by existing in-kernel upstream users
or bindings, should be of course in separate patch.

Best regards,
Krzysztof


