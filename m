Return-Path: <linux-pci+bounces-21831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F3A3C74E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF92189328F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4DB214A7C;
	Wed, 19 Feb 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiDzNvJj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE021505D;
	Wed, 19 Feb 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989368; cv=none; b=Glu/bqqCDKNUwGZiN2H3/UBxIbrjJv5mIErlXNJ+R5FsUXZg2c1Zw/TPLz7uCfp1Zj23wL9lRIkDbI5Pb7Tm6QzCLglLEPAe37QkV0CEnxcVjgZI39LlaUtWCYIF5slS0ht4NKyIQ5UVt9StwpcJCAQaM/ZZSMjrkj+thOmWGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989368; c=relaxed/simple;
	bh=faBN0IDEHn011JJ6CBEbtJMdZifBloW9Uki3sRQ2NFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qeWKV/puom1LUECqVpFIeR3Cc5kONz2sg0LF6n5+oLWWekUUT+OYiQIJ0Ge88OyeTYYA0n/sFMUUQUVttBs02IV0viWIhbKGbgO5fStmJh85OnbpJiIxOszubNcOrDQ9VX+lI+4qiIkxEMPilkM7asL0cs1CO5IaUTXzrFa9WwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiDzNvJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABDEC4CEE6;
	Wed, 19 Feb 2025 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739989368;
	bh=faBN0IDEHn011JJ6CBEbtJMdZifBloW9Uki3sRQ2NFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BiDzNvJjL91V2HDPnBs7dKbPdXvA8S0BQ46CpANs2Oc4NEmRROuvTqAUbOosqJSmc
	 ucLGRNjf0LoUsW3EC8/78mNlImUUpGRGLbWj2eh3/xr9xXd6spSqlKKc959yRA2dtM
	 Q88ubglPWVKNTDsxFF0RquzIThh9F/6CQNgOSGwhlFWFOXRy7DnnihJbh5Ml0M/9sP
	 +ObCE42MLKwCylSWckR1ATbINC39tseHs7lMFpnI4v3MTHolIXj4LWJmHHe0fBztN3
	 c5BktpBJXnFlVwHUf1TOg36nIxXT0UBE9++JKOwMWfKsJMSk7wHZ5rdsitf+ER/LYb
	 jj9gcm86rmXjA==
Date: Wed, 19 Feb 2025 12:22:47 -0600
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
Message-ID: <20250219182247.GA225989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BMXPR01MB24403F8CD6BF5D4D2DDC57A4FEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Feb 12, 2025 at 01:54:11PM +0800, Chen Wang wrote:
> On 2025/2/12 12:25, Bjorn Helgaas wrote:
> [......]
> > > pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
> > > different "sophgo,core-id" values, they can distinguish and access
> > > the registers they need in cdns_pcie1_ctrl.
> > Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
> > both pcie_rc1 and pcie_rc2?
> 
> cdns_pcie1_ctrl is defined as a syscon node,  which contains registers
> shared by pcie_rc1 and pcie_rc2. In the binding yaml file, I drew a diagram
> to describe the relationship between them, copy here for your quick
> reference:
> 
> +                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
> +                     |                                |                 |
> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> +                     |                                |                 |
> +                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
> 
> The following is an example with cdns_pcie1_ctrl added. For simplicity, I
> deleted pcie_rc0.

Looks good.  It would be nice if there were some naming similarity or
comment or other hint to connect sophgo,core-id with the syscon node.

> pcie_rc1: pcie@7062000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     linux,pci-domain = <1>;
>     sophgo,core-id = <0>;
>     sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
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
>     sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     }
> 
> };
> 
> cdns_pcie1_ctrl: syscon@7063800000 {
>     compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
>     reg = <0x70 0x63800000 0x0 0x800000>;
> };
> 

