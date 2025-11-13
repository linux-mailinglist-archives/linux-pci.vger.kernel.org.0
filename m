Return-Path: <linux-pci+bounces-41118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C098C58AFE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9251E4FFDE9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BF351FC2;
	Thu, 13 Nov 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLg62xZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78578352929;
	Thu, 13 Nov 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049251; cv=none; b=pR86j1etO8sODJ6kOFcmhkzJYgIc97USys1WbfAm+oKjn8Ey6vEwvHlf4lDscutwpC25KuSs27PVx83AUD7a+c2k/Uq1mgBfJYXZ42LPRR3iOCt3HtQcxKYjSwq9TvLXaCHL6nZg4PZnj35Vrhn7CrlPGYNLo7KbF0r6SESW394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049251; c=relaxed/simple;
	bh=PksXhfm6DxsOyKhs9Ke2wv9TNPEzGflef5ZRqcdeWFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i2d97IAyUpVGBYCHCeyCLFjBPGwBei/WQyNrVst5dm3UpmGqR6yzt0K1f6y+pwPYt7/DicDU4qxxcDeQEUrde3GK186fZJ3KJmFKUPq72wbb8+VNW6epiF2ANEdzlSPFLmHKJPjllHZnKhSo9mgKiSru2DcKwJjyq2Bagnf/oxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLg62xZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AB2C4CEFB;
	Thu, 13 Nov 2025 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763049251;
	bh=PksXhfm6DxsOyKhs9Ke2wv9TNPEzGflef5ZRqcdeWFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JLg62xZp+Cf9n4/V4/JASc36uOkBlJrNjWaDfju6VfwTy+RABTfYoPqm6vm3xxzl7
	 AVHGsKSC5c/aq5FTqBNKdcTWd/Lt5HtSJGqYb0P+gERHBPfuyfdupdR4nJYWkS60ml
	 1g0SNcgYsxcMi0pAJkzvjyq/8e5MvwuyT7uhITQWpo0o3abebssykmL7QtAmkBaUxz
	 0IQnlkddtndT3OGd40fCrWTgQnFaQQo8EofQRKsEN00VfdcYsfGpE5DQw63stVVZct
	 JTrunFYjFoshIsaJHUIGn1MBYcTKPsSqX/cbyQGqKhp1SCb2wJ+Yg3AVmhB9IfZkU1
	 6m4fcuj/9dAng==
Date: Thu, 13 Nov 2025 09:54:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	andersson@kernel.org, robh@kernel.org,
	manivannan.sadhasivam@linaro.org, krzk@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <20251113155409.GA2283653@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRWYoHvaCCN95ZR9@wunner.de>

On Thu, Nov 13, 2025 at 09:36:48AM +0100, Lukas Wunner wrote:
> On Thu, Nov 13, 2025 at 09:33:54AM +0530, Krishna Chaitanya Chundru wrote:
> > On 11/10/2025 6:11 PM, Lukas Wunner wrote:
> > > On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> > > > From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON
> > > > is the minimum amount of time(in us) that each component must
> > > > wait in L1.2.Exit after sampling CLKREQ# asserted before
> > > > actively driving the interface to ensure no device is ever
> > > > actively driving into an unpowered component and these values
> > > > are based on the components and AC coupling capacitors used
> > > > in the connection linking the two components.
> > > > 
> > > > This property should be used to indicate the T_POWER_ON for
> > > > each Root Port.
> > >
> > > What's the difference between this property and the Port
> > > T_POWER_ON_Scale and T_POWER_ON_Value in the L1 PM Substates
> > > Capabilities Register?
> > > 
> > > Why do you need this in the device tree even though it's
> > > available in the register?
> > 
> > This value is same as L1 PM substates value, some controllers
> > needs to update this value before enumeration as hardware might
> > now program this value correctly[1].
> > 
> > [1]: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2
> > exit timing
> > 
> > <https://lore.kernel.org/all/20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com/>
> 
> Per PCIe r7.0 sec 7.8.3.2, all fields in the L1 PM Substates Capabilities
> Register are of type "HwInit", which sec 7.4 defines as:
> 
>    "Register bits are permitted, as an implementation option, to be
>     hard-coded, initialized by system/device firmware, or initialized
>     by hardware mechanisms such as pin strapping or nonvolatile storage.
>     Initialization by system firmware is permitted only for
>     system-integrated devices.
>     Bits must be fixed in value and read-only after initialization."
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> These bits are not supposed to be writable by the operating system,
> so what you're doing in that patch is not spec-compliant.
> 
> I think it needs to be made explicit in the devicetree schema that
> the property is only intended for non-compliant hardware which allows
> (and requires) the operating system to initialize the register.

I don't see a driver patch that uses this yet, but I assume the driver
will use a device-specific way to set the value that will appear in
the L1 PM Substates Capabilities register, and the register visible in
config space probably is read-only as the PCIe spec describes, so I
don't think this makes the hardware non-compliant.

> Maybe it makes more sense to have a property which specifies the raw
> 32-bit register contents, instead of having a property for each
> individual field.  Otherwise you'll have to amend the schema
> whenever the PCIe spec extends the register with additional fields.

I don't have any personal experience with this hardware, but I think
the device-specific registers that back the standard PCI config
registers sometimes use different formats.  pcie-brcmstb.c is a good
example that I've tripped over several times:
https://lore.kernel.org/all/5ca0b4a2-ec3a-4fa5-a691-7e3bab88890a@broadcom.com/

Bjorn

