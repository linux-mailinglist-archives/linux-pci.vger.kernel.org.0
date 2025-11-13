Return-Path: <linux-pci+bounces-41137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F199C58EB9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD1B4A33E8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666A357A5B;
	Thu, 13 Nov 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNgGXQIa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055913557E9;
	Thu, 13 Nov 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052123; cv=none; b=PD4jXBcN/XO8di+lg2JwqyKChERwZra81U9T19qwDK/XX1IMOdXCE0+y0Q3B+gM2cT87LWIk/JUIHiHaqRMcTSZj5TwnCkPRMgCci47LeuoQrg21XIR4Uc8IFZeWCkLLgIIbdrWxL+eS7MFrXpSifhcryz8CDnX5jsCWGKN3cf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052123; c=relaxed/simple;
	bh=tbI30SQdpsjBi0FiA0lyqvsLgdo6wOPvrHQ/VuIekYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbEb5YOHBOo6ymN6PVG5uu9UT1SxajoUjaYyND4B8CVfbyKUrswWSptf7s6Fv2QdmyCcU8dTvWgOANVPngv8HZNoEPE4ND3P3Vv1VPXWQtfk5pt76Tg+c7JP0bUsIBwyD712JQslAICNnYVaw+GjN7X5gXjg8B2goTn9WRUSxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNgGXQIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46851C113D0;
	Thu, 13 Nov 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052122;
	bh=tbI30SQdpsjBi0FiA0lyqvsLgdo6wOPvrHQ/VuIekYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNgGXQIajwxVe7WQ6kGYsfOs7tSWSzNInH4olIfs/uNUQzMJDBdh1uWvYgVARgS7L
	 MkAaVG9auvsafOddLcG45jmQc3v1nOehwRhRvHGQjzcKei4eZEe5Ym44vPahLnL916
	 QgDNMcuEuhc+oJ17Xpuavg9cl0TZ3yruFjCPTXVuEnk1T/5wBmKbNA/CfUlyK1V6se
	 HY2sE5/OILtgWAA75hTY+o9QlRhMRAw44S+qk+cObISqfwHdtorH238PvR2M0MBqj7
	 0GhzF8VV7KeT7s+YnwnEGp3be9KojOk5Tz6DEdtf/7g3QUK0KghiWpbgovzeetJB8B
	 xcm4CJq+pWrVQ==
Date: Thu, 13 Nov 2025 22:11:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org, 
	krzk@kernel.org, helgaas@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <epqkkezjnkwznh4minlvhh7vbnwh3isqeofqamgupj7rjnhjv2@wtrx4ecjgvob>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
 <aRHdiYYcn2uZkLor@wunner.de>
 <44c7b4a8-33ce-4516-81bf-349b5e555806@oss.qualcomm.com>
 <aRWYoHvaCCN95ZR9@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRWYoHvaCCN95ZR9@wunner.de>

On Thu, Nov 13, 2025 at 09:36:48AM +0100, Lukas Wunner wrote:
> On Thu, Nov 13, 2025 at 09:33:54AM +0530, Krishna Chaitanya Chundru wrote:
> > On 11/10/2025 6:11 PM, Lukas Wunner wrote:
> > > On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> > > >  From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> > > Please use the latest spec version as reference, i.e. PCIe r7.0.
> > ack.
> > > > minimum amount of time(in us) that each component must wait in L1.2.Exit
> > > > after sampling CLKREQ# asserted before actively driving the interface to
> > > > ensure no device is ever actively driving into an unpowered component and
> > > > these values are based on the components and AC coupling capacitors used
> > > > in the connection linking the two components.
> > > > 
> > > > This property should be used to indicate the T_POWER_ON for each Root Port.
> > > What's the difference between this property and the Port T_POWER_ON_Scale
> > > and T_POWER_ON_Value in the L1 PM Substates Capabilities Register?
> > > 
> > > Why do you need this in the device tree even though it's available
> > > in the register?
> > 
> > This value is same as L1 PM substates value, some controllers needs to
> > update this
> > value before enumeration as hardware might now program this value
> > correctly[1].
> > 
> > [1]: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
> > timing
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

I interpret 'initialized by system/device firmware', same as 'initialized by
OS', as both are mostly same for the devicetree platforms. So it is fine IMO.
Ofc, if the initialization was carried out by the firmware, then OS has no
business in changing it, but it is not the case.

> I think it needs to be made explicit in the devicetree schema that
> the property is only intended for non-compliant hardware which allows
> (and requires) the operating system to initialize the register.
> 

Sorry, I disagree. The hardware is spec compliant, just that the firmware missed
initializing the fields.

> Maybe it makes more sense to have a property which specifies the raw
> 32-bit register contents, instead of having a property for each
> individual field.  Otherwise you'll have to amend the schema
> whenever the PCIe spec extends the register with additional fields.
> 

DT properties do not specify a register value, but instead they specify hardware
configuration value and that's what this property is doing. The OS/other DT
consumers should interpret this value as per the spec and program the relevant
registers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

