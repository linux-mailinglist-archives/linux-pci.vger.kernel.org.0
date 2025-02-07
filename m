Return-Path: <linux-pci+bounces-20893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BDA2C3DF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5873F3ACBB2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A92010E6;
	Fri,  7 Feb 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="DsxxJJur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771181F63F5
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935441; cv=none; b=kIeNs7s5YR9PDUMX3vE9WThJAOqa224LWM0CzsNGLucfw9/nsMRdbOvRkkbFzuPJJomzLgXgamfEi5vIkdh3HpI737IZkGkIKgxq4tmYCdotiUVzQdsW1MAP4LIaiX25IEIKc0YpMcjeaIZXMEDxhTsX1KV06HeO8chB+KJFIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935441; c=relaxed/simple;
	bh=IdbOi6N0+bHgyQ08uTaIC9JomsdE+10WelxdSZmGp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMIwnTwgDfbZXkEFzxdK60HNquetIEF6LmrWbG43bDu3G1bWe3K4FqKvDF+dBOlyXFy8aplKQUzWM72W8nTAKfq2mtxXwp85UX1O9JWvmR2v0ZSJNcvgFD7cd67AoiKI1STFmqz8KDLQktHf75p7dPtzKqca84lE9s8xL1LIi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=DsxxJJur; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0DF70240101
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 14:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1738935432; bh=IdbOi6N0+bHgyQ08uTaIC9JomsdE+10WelxdSZmGp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=DsxxJJuriK7OP/3VAdpJyhOhoqIowUPkuVAs6bIe7RSHnrSQTmrd8/a1Pz3A6wfGk
	 wWBvQqRkfXbmrjUzJDJ7qee4Nx96J2fYuvMUgNF9+MRVjdPg0ygKTXHWT9QUgmaEiU
	 f2ZMTrVA6WyCwliBTXfACOYXbu5IpQAOLzMHbdyDQsMGMte9ag2XeoYgPJ11DGHzzZ
	 YI9B9h8pkDWmEnNuaW1rDdp+sLu0MCREo5AVPVKurrL3bOGq3FkN5/yoTx5fVxFB1W
	 AmgPoDINAPQX7MwC4V3xUd+MxEDsh65nfvE2xVC5HDdaKnXih39UhBaEcb6MnJcx47
	 qZeYjzYclbBpg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YqFPs4w9Pz9rxF;
	Fri,  7 Feb 2025 14:37:05 +0100 (CET)
Date: Fri,  7 Feb 2025 13:37:04 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Frank Li <Frank.li@nxp.com>, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Message-ID: <Z6YMgETdCZGMJI4i@probook>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
 <Z5qx3jAFE81Ni2cJ@lizhi-Precision-Tower-5810>
 <Z6KkBEaGTkSyWiE_@probook>
 <689302c6-8fba-4fd1-a4b7-557cb2f8fa4d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <689302c6-8fba-4fd1-a4b7-557cb2f8fa4d@quicinc.com>

On Thu, Feb 06, 2025 at 06:12:47PM +0530, Mukesh Kumar Savaliya wrote:
> neat: subject: since binding is already mentioned in the prefix of the
> subject, no need to add bindings word again.

Sounds reasonable, thanks
J. Neuschäfer

