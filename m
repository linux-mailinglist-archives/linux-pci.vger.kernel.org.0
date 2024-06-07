Return-Path: <linux-pci+bounces-8440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02798FFFDF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E605E1C2241F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76F73468;
	Fri,  7 Jun 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJz999IF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22773200A0;
	Fri,  7 Jun 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753805; cv=none; b=t0MagDAm8hp+Vl4HiJTktdvI8CAy+mGyaq0IFBAhCOG0f9bJrYjlkmBz+GfsrlRgb6xf9I9m1/2SJ5TkrtXsPzN96c3e3HJnYO//fzNswLd+953O2d7l6gkDLHQe3O8CcQAzQpA3RvnBWOoaVIL1VDVERsq+a0IAWfyZNrOIxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753805; c=relaxed/simple;
	bh=akjruwrkh3WPGkPm5XOY0XEKEarFR0VOfCvlpit9/ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrGcHlgx3t8oi25RmD6wdV2kdQJ3YLqHLC8I2E/nRGbCSKsR3B8PDhiRlsDL6XSX0wooesHfBLgGqTGo96mEJsbjBwLtGTJw2o9tGBldY8X0GVh3/NfZbv2IuWPsVLzcAePBCxSYK15Pfhl5VpKAJczxVLiGgAG3/yzr+Tj9jhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJz999IF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E0CC2BBFC;
	Fri,  7 Jun 2024 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717753804;
	bh=akjruwrkh3WPGkPm5XOY0XEKEarFR0VOfCvlpit9/ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJz999IFl1R2Wv1WpGcamcd26uiBC8bgKjv2D0/k3c/2dxRb6z9gvkUv9sZ427y15
	 hM4bpYCEJOAeaY8H15myrOiJ72h2GW9lgce1l9cvek3Ax5TubupbgSCfTS0oHPXKkb
	 DtYCP+8q+sXRCl/SsUbj5bpvzVfOMUrCzHRPuME9D+nClgE7XQ5oqQYBx2502mexB4
	 jQ+GsienBD+TirjkdCuz+oC3CxeksciiMp5qYcyaBntQ8iFhCKaym8zjzWvWpVuryU
	 CiQsjtNzICfCKWNcOnelZDglN3I9A2fh9C/3Zy9eK/+YY9B5vQeB5XHajdhSQDeHzO
	 doy3fofa+ItFQ==
Date: Fri, 7 Jun 2024 11:49:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 03/13] dt-bindings: PCI: snps,dw-pcie-ep: Add
 tx_int{a,b,c,d} legacy irqs
Message-ID: <ZmLXxUa_6WTde7OC@ryzen.lan>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-3-3dc00fe21a78@kernel.org>
 <20240605073402.GE5085@thinkpad>
 <ZmCQak-m7RWRxiix@ryzen.lan>
 <20240606062538.GA4441@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606062538.GA4441@thinkpad>

On Thu, Jun 06, 2024 at 11:55:38AM +0530, Manivannan Sadhasivam wrote:
> 
> I think you misunderstood what I was asking. I was just asking if we still want
> to keep the term 'legacy' for INTx IRQs in DT binding or not, since we recently
> got rid of that terminology in PCI drivers.

I still don't think that I understand :)

In snps,dw-pcie.yaml we currently (6.10-rc2) have:

const: legacy
(for the combined IRQ)

pattern: "^int(a|b|c|d)$"
(for the individual IRQs)

So we will need to support these indefinitely.

What is it that you would want to rename?

the combined irq?

Doesn't sound like a good idea to me, as we would need to support two
(perhaps that is what you meant).

But even if you wanted to rename it, it would be hard to come up with
a name. Perhaps intx, but that would be super confusing since we already
have inta, intb, intc, intd.

I think it is best just to not touch the binding.

In kernel macros could (that have already been renamed from legacy to intx)
doesn't really have anything to do with the DT binding IMO.


Kind regards,
Niklas

