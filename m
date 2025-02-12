Return-Path: <linux-pci+bounces-21269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D13A31D78
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 05:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8256F167596
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 04:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953781DED5F;
	Wed, 12 Feb 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7DgJxwZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DB27182D;
	Wed, 12 Feb 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334306; cv=none; b=kAWiW//b75CFAE+dql1xZ0LaCFHDk9SsTJiQrb078w0qT3qv0ikqvmTK9uH/zpBbTM7Jkgl5WqodWNx72Dn8Xv0PStDT4ePRaH7BWuK31+9EpbcY+xwAuXMbl9CSZjxDiQejvuBI4M3z/4GYJjRfg+rbvxXSBW8gxIYDv7uUYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334306; c=relaxed/simple;
	bh=nk3AROe87+4YshXi9GBSNoqzPpUikLHpL1nScJiTUVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HRCh48k1FYVKDSSVNr5oTR7Qljx87yrRo1MWWYd3cFsdVUwXeHWX8k8YJj6k9VkQ4pbvbhkQ8Ldi3YdTSLibYb6io9xpgcj3XFg5YLXqpYiyaYLrwW1FL61+antspO+BY1x3LKdcBN9sL+I2aK4tk6Qrx2rNhj45o2KxWcRX3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7DgJxwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF12C4CEDF;
	Wed, 12 Feb 2025 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739334305;
	bh=nk3AROe87+4YshXi9GBSNoqzPpUikLHpL1nScJiTUVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L7DgJxwZxf+zoDiz0Ezoiz7oy10JTxKsm0nQgnZA2Z1LwGIQqWRSdlhq0wUAjZODY
	 hPb078OI/3uJEXZg+ryHPim53pB1qdvG3zg605JsOS/q8p+6aRvDA2sM1McU/rDL/D
	 QKWRq7eTbr+OOK8vIzaegc3FTJjp+Exu+gyenCYVZyofzah/hDYNquGbr8vmrN3USz
	 1QcXApTIx115Ab0W8JuOcZcdciR0BS2e9Fm/Fp/c/hbtVA7P9xY5r/JgFtHSPT/xO9
	 EZe4OW6FPXKhxczMtwdXXV9d1h0Ucixt7G8Rrv9nUANxD6R+ObZjN29Y700z+AHz71
	 b0NG3ULidATqg==
Date: Tue, 11 Feb 2025 22:25:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
	inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbrobinson@gmail.com,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250212042504.GA66848@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BMXPR01MB244057AE697903F8C2947FB8FEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Feb 12, 2025 at 09:50:11AM +0800, Chen Wang wrote:
> On 2025/2/12 7:34, Bjorn Helgaas wrote:
> > On Sun, Jan 26, 2025 at 10:27:27AM +0800, Chen Wang wrote:
> > > On 2025/1/23 6:21, Bjorn Helgaas wrote:
> > > > On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
> > > > > From: Chen Wang <unicorn_wang@outlook.com>
> > > > > 
> > > > > Add binding for Sophgo SG2042 PCIe host controller.
> ...

> > > > "sophgo,link-id" corresponds to Cadence documentation, but I
> > > > think it is somewhat misleading in the binding because a PCIe
> > > > "Link" refers to the downstream side of a Root Port.  If we
> > > > use "link-id" to identify either Core0 or Core1 of a Cadence
> > > > IP, it sort of bakes in the idea that there can never be more
> > > > than one Root Port per Core.
> > >
> > > The fact is that for the cadence IP used by sg2042, only one
> > > root port is supported per core.
> >
> > 1) That's true today but may not be true forever.
> > 
> > 2) Even if there's only one root port forever, "link" already
> > means something specific in PCIe, and this usage means something
> > different, so it's a little confusing.  Maybe a comment to say
> > that this refers to a "Core", not a PCIe link, is the best we can
> > do.
>
> How about using "sophgo,core-id", as I said in the binding
> description, "every IP is composed of 2 cores (called link0 & link1
> as Cadence's term).".  This avoids the conflict with the concept
> "link " in the PCIe specification, what do you think?

I think that would be great.

> > > Based on the above analysis, I think the introduction of a
> > > three-layer structure (pcie-core-port) looks a bit too
> > > complicated for candence IP. In fact, the source of the
> > > discussion at the beginning of this issue was whether some
> > > attributes should be placed under the host bridge or the root
> > > port. I suggest that adding the root port layer on the basis of
> > > the existing patch may be enough. What do you think?
> > > 
> > > e.g.,
> > > 
> > > pcie_rc0: pcie@7060000000 {
> > >      compatible = "sophgo,sg2042-pcie-host";
> > >      ...... // host bride level properties
> > >      sophgo,link-id = <0>;
> > >      port {
> > >          // port level properties
> > >          vendor-id = <0x1f1c>;
> > >          device-id = <0x2042>;
> > >          num-lanes = <4>;
> > >      }
> > > };
> > > 
> > > pcie_rc1: pcie@7062000000 {
> > >      compatible = "sophgo,sg2042-pcie-host";
> > >      ...... // host bride level properties
> > >      sophgo,link-id = <0>;
> > >      port {
> > >          // port level properties
> > >          vendor-id = <0x1f1c>;
> > >          device-id = <0x2042>;
> > >          num-lanes = <2>;
> > >      };
> > > };
> > > 
> > > pcie_rc2: pcie@7062800000 {
> > >      compatible = "sophgo,sg2042-pcie-host";
> > >      ...... // host bride level properties
> > >      sophgo,link-id = <0>;
> > >      port {
> > >          // port level properties
> > >          vendor-id = <0x1f1c>;
> > >          device-id = <0x2042>;
> > >          num-lanes = <2>;
> > >      }
> > > };
> >
> > Where does linux,pci-domain go?
> > 
> > Can you show how link-id 0 and link-id 1 would both be used?  I
> > assume they need to be connected somehow, since IIUC there's some
> > register shared between them?
> 
> Oh, sorry, I made a typo when I was giving the example. I wrote all
> the link-id values ​​as 0. I rewrote it as follows. I
> changed "sophgo,link-id" to "sophgo,core-id", and added
> "linux,pci-domain".
> 
> e.g.,
> 
> pcie_rc0: pcie@7060000000 {
> 
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     linux,pci-domain = <0>;
>     sophgo,core-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <4>;
>     }
> };
> 
> pcie_rc1: pcie@7062000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     linux,pci-domain = <1>;
>     sophgo,core-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     };
> };
> 
> pcie_rc2: pcie@7062800000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     linux,pci-domain = <2>;
>     sophgo,core-id = <1>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     }
> 
> };
> 
> pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
> different "sophgo,core-id" values, they can distinguish and access
> the registers they need in cdns_pcie1_ctrl.

Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
both pcie_rc1 and pcie_rc2?

