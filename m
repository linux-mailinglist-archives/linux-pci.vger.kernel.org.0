Return-Path: <linux-pci+bounces-41070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B70DAC56557
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F946354875
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68B7333753;
	Thu, 13 Nov 2025 08:36:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21904333459;
	Thu, 13 Nov 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023019; cv=none; b=g/kFuR8rvdyS+YXyd00Qf07VDzGZudyv+/yPR3rt71rEb8CifQ8qKnUPt+O8ooDZOvSGKjfY5BBkV/VJlw91owl8XvRY0ZMYdBR6MeMlymPtAUhMwvn/7iMBhhs35swkNy2BqfW9oe1n+nJLmxuC3hxnSdPu/VERGkWonHtU6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023019; c=relaxed/simple;
	bh=9tmZNT31eqYFTJ2Nfxp+D1J2uiA9NkpKSfKBy+GJCx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaOLZUcum+yGPAU8gSEAI/4PGeso6pDhkrTRpLVTrbkXSl7EqY7TFck2eoTj3D9YuzvkHFzFLseYUblP/R0mx/3SZU5Lf9yVBGMNaAvi4F69dUF7/3dT11Vs9LNXA6bcSojz3POGvnGkLa8in/xvMwEcqpYf2pW3FZB89Zp2yBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8D6692C06646;
	Thu, 13 Nov 2025 09:36:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7A4635160; Thu, 13 Nov 2025 09:36:48 +0100 (CET)
Date: Thu, 13 Nov 2025 09:36:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
	krzk@kernel.org, helgaas@kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <aRWYoHvaCCN95ZR9@wunner.de>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <aRHdiYYcn2uZkLor@wunner.de>
 <44c7b4a8-33ce-4516-81bf-349b5e555806@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c7b4a8-33ce-4516-81bf-349b5e555806@oss.qualcomm.com>

On Thu, Nov 13, 2025 at 09:33:54AM +0530, Krishna Chaitanya Chundru wrote:
> On 11/10/2025 6:11 PM, Lukas Wunner wrote:
> > On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> > >  From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> > Please use the latest spec version as reference, i.e. PCIe r7.0.
> ack.
> > > minimum amount of time(in us) that each component must wait in L1.2.Exit
> > > after sampling CLKREQ# asserted before actively driving the interface to
> > > ensure no device is ever actively driving into an unpowered component and
> > > these values are based on the components and AC coupling capacitors used
> > > in the connection linking the two components.
> > > 
> > > This property should be used to indicate the T_POWER_ON for each Root Port.
> > What's the difference between this property and the Port T_POWER_ON_Scale
> > and T_POWER_ON_Value in the L1 PM Substates Capabilities Register?
> > 
> > Why do you need this in the device tree even though it's available
> > in the register?
> 
> This value is same as L1 PM substates value, some controllers needs to
> update this
> value before enumeration as hardware might now program this value
> correctly[1].
> 
> [1]: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
> timing
> 
> <https://lore.kernel.org/all/20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com/>

Per PCIe r7.0 sec 7.8.3.2, all fields in the L1 PM Substates Capabilities
Register are of type "HwInit", which sec 7.4 defines as:

   "Register bits are permitted, as an implementation option, to be
    hard-coded, initialized by system/device firmware, or initialized
    by hardware mechanisms such as pin strapping or nonvolatile storage.
    Initialization by system firmware is permitted only for
    system-integrated devices.
    Bits must be fixed in value and read-only after initialization."
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These bits are not supposed to be writable by the operating system,
so what you're doing in that patch is not spec-compliant.

I think it needs to be made explicit in the devicetree schema that
the property is only intended for non-compliant hardware which allows
(and requires) the operating system to initialize the register.

Maybe it makes more sense to have a property which specifies the raw
32-bit register contents, instead of having a property for each
individual field.  Otherwise you'll have to amend the schema
whenever the PCIe spec extends the register with additional fields.

Thanks,

Lukas

