Return-Path: <linux-pci+bounces-41061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803DC55D9B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 06:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B643B17A0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC783009DE;
	Thu, 13 Nov 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBOlwr4R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C362512E6;
	Thu, 13 Nov 2025 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013074; cv=none; b=LDt4PtRZVC+Bs5ha6Z080ky8GUXEfZYPBdrtHL4D/+Xb3PjIanuVNSNwPtsggRs2xMe504VPecVGdNnognfOKxI/Oyhkjj4MJr9FEZ4vP2Z3c1neemeIEMFNTjCM9Vg3QMOpYSA0y6I8QDJE60AI2iUPSY/J5MfgUtrPGA4lRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013074; c=relaxed/simple;
	bh=DLX5/XZfkVtg0LES4vcbawkAfBpUPSg8sV2FGqstTlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwr5vAVlYOtIyKLgmlmzO8b2CsUi1YJpi0C5QxUXVN0I8V71ZZ3gyLnwmKQjo3S0KDdODXmp7dEV4Awj2aUoJumdJ5SJRONz0QDlxKyiHYl8FEC0tDfOoucboMh70T0U8ZpUO91IW8cwpiBKiCWoLyi9VXh6kCIip8Merix9aCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBOlwr4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF0EC4CEF5;
	Thu, 13 Nov 2025 05:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763013073;
	bh=DLX5/XZfkVtg0LES4vcbawkAfBpUPSg8sV2FGqstTlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBOlwr4Rg6b5wenq2KuXkhqgUYtlGPisHGdb/YePoOitx330sUCu8OWw3QzTxDCNW
	 /ww0LwaWJxarbp83GgoqJsHvdTzMNdLYSGjfOe4onmuDAFQgjprSSed9X8wR/gv4by
	 iwwR4Xu3O5WXX7uxRelM58JCDBj8oY+8LkW1b0BUUkLzSm4pHvb6FbtVTB3L9j4jrt
	 LyChZPunGbI1N2mlQdtj9TRZNXnJUOP72qjTbm1FFn9flt0wVAxf1cF2/rGeLj268O
	 pwJ6331Bodj8+FovI8lrI9MUq3bAZQJkj0YYD0gkPWuBX2KsQVEIHKd4gniCf3dWKG
	 TpgLwJDmuE7RQ==
Date: Thu, 13 Nov 2025 11:20:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, andersson@kernel.org, robh@kernel.org, 
	manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, 
	conor+dt@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <vnfjiakbgw3s7dxqh3zriifxjoqcjhshat3hrnikebpa57yh3k@erc4nb5enqes>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <aRHdiYYcn2uZkLor@wunner.de>
 <enri4affdgq4q5mibnmhldhqqoybqbdcswohoj5mst2i77ckmu@dwlaqfxyjy3w>
 <CANAwSgQcMDXitA2RLbFsD_v2KoOQMcHywxcxNs-ab-O2JddAuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgQcMDXitA2RLbFsD_v2KoOQMcHywxcxNs-ab-O2JddAuQ@mail.gmail.com>

On Thu, Nov 13, 2025 at 10:46:59AM +0530, Anand Moon wrote:
> Hi Manivannan
> 
> On Thu, 13 Nov 2025 at 10:01, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Mon, Nov 10, 2025 at 01:41:45PM +0100, Lukas Wunner wrote:
> > > On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> > > > From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> > >
> > > Please use the latest spec version as reference, i.e. PCIe r7.0.
> > >
> > > > minimum amount of time(in us) that each component must wait in L1.2.Exit
> > > > after sampling CLKREQ# asserted before actively driving the interface to
> > > > ensure no device is ever actively driving into an unpowered component and
> > > > these values are based on the components and AC coupling capacitors used
> > > > in the connection linking the two components.
> > > >
> > > > This property should be used to indicate the T_POWER_ON for each Root Port.
> > >
> > > What's the difference between this property and the Port T_POWER_ON_Scale
> > > and T_POWER_ON_Value in the L1 PM Substates Capabilities Register?
> > >
> > > Why do you need this in the device tree even though it's available
> > > in the register?
> > >
> >
> > Someone needs to program these registers. In the x86 world, BIOS will do it
> > happily, but in devicetree world, OS has to do it. And since this is a platform
> > specific value, this is getting passed from devicetree.
> >
> According to the RK3588 TRM Part 2, the DSP_PCIE_L1SUB_CAPABILITY_REG (0x4)
> It is a commonly configurable parameter, It can be tuned on for the
> Rockchip platform.

T_POWER_ON is a generic value defined in the spec. All compatible platforms
should support setting this value through 'L1 PM Substates Capabilities'
register or by platform specific register.

> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> >
> Thanks
> -Anand
> 
> I could not apply this patch
> 
> $ git am ./v2_20251110_krishna_chundru_schemas_pci_document_pcie_t_power_on.mbx
> Applying: schemas: pci: Document PCIe T_POWER_ON
> error: dtschema/schemas/pci/pci-bus-common.yaml: does not exist in index
> Patch failed at 0001 schemas: pci: Document PCIe T_POWER_ON
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"

This is a dtschema patch, not Linux kernel.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

