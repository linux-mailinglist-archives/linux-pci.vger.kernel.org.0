Return-Path: <linux-pci+bounces-17278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864839D8639
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 14:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9728B100
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD771B1D65;
	Mon, 25 Nov 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkykpNRv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F651ABEA0;
	Mon, 25 Nov 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540868; cv=none; b=aUaY3xT/o0cJLzCbDeXglCemjmEMvicq+vBSzAzD/dtB2Wx+kW530fcPIgLxkROZwZ2BHjz17kufh3b4xi+tl1SbgmgpApAjs6qfuR8s0H024e8Upf9P1D9wqSlHGQwWFd2dNp4uIYTbo3jqtwFDOdInGroRJfZKTS1QYyjzPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540868; c=relaxed/simple;
	bh=3Z560kziSQXi2my1WMJNnxEGuywtw7Uta9RcrJwEvHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuooNe8ZwnTtoCOi9CmZaVxtI3RK4K5Q7VXDgNFl/4cisnYCLEltVo3upnd4MsGH9uqvaWCgZcUqIBBWREkcVxVBo2R+qRJY9YR5AL71vWj+oUW+hhKO9OvIiziennBN6Qy0GQ6zXn//BFbSF8CeBwA+qjP4FloJgegOLR388HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkykpNRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F7C4CED2;
	Mon, 25 Nov 2024 13:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732540866;
	bh=3Z560kziSQXi2my1WMJNnxEGuywtw7Uta9RcrJwEvHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkykpNRv7e4NVi4Q3z8ffrcHtigFITXEIxN/5bTSjYdSwaphoIBGxqmG+/Xb46TI7
	 lHS/FY0EsAUAz1aYRprNvi6QHcyObwv8xHeGqJ05oGkRLX0e0qKg8xflK6oz4lAXf7
	 YhDyUrt9P4stTb7wr4Cj6faNKuabUVK/uT5TkuTTJ9M8Dgc7pTuXnnsJprFpWQcWsr
	 oJtVByZrcaZVyAzTcmcBTi8a4HHu7UG0bHWY3Xph56B8h9135/UIM79mhNBzIGU96v
	 JXhwAWUIHHY0CyLinhprle6eH9ZMJ6gAhhpTH9YT2OXbHgesMLMXeqrXQl9GDr9GhR
	 cR4Addly+n0lQ==
Date: Mon, 25 Nov 2024 07:21:04 -0600
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@amd.com>, linux-gpio@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	Derek Kiernan <derek.kiernan@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH v4 04/10] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <20241125132104.GA1520508-robh@kernel.org>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com>
 <173250040873.6640.9720381303445148722.robh@kernel.org>
 <Z0RAGkBc-yz5lqN6@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0RAGkBc-yz5lqN6@apocalypse>

On Mon, Nov 25, 2024 at 10:15:06AM +0100, Andrea della Porta wrote:
> Hi Rob,
> 
> On 20:06 Sun 24 Nov     , Rob Herring (Arm) wrote:
> > 
> > On Sun, 24 Nov 2024 11:51:41 +0100, Andrea della Porta wrote:
> > > The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> > > schema is intended as minimal support for the clock generator and
> > > gpio controller peripherals which are accessible through BAR1.
> > > 
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > ---
> > >  .../devicetree/bindings/misc/pci1de4,1.yaml   | 74 +++++++++++++++++++
> > >  MAINTAINERS                                   |  1 +
> > >  2 files changed, 75 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/pci1de4,1.example.dtb: clocks@c040018000: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 	from schema $id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#

The error comes from this schema and...

> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> 
> Sorry about that, but even if I see that this should be the case (I've dropped
> the clock-name property from raspberrypi,rp1-clock.yaml), I can't reproduce it
> with:
> 
> # make W=1 dt_binding_check DT_SCHEMA_FILES=pci1de4,1.yaml

You've limited testing to schema files matching pci1de4,1.yaml.

> 
> and the output is:
> 
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/misc/pci1de4,1.example.dts
>   DTC [C] Documentation/devicetree/bindings/misc/pci1de4,1.example.dtb
> 
> dt-schema seems up to date. Is my command line correct?
> 
> Many thanks,
> Andrea
> 

