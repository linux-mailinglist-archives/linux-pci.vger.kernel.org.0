Return-Path: <linux-pci+bounces-36300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA95B5A320
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092EE521346
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228433871A;
	Tue, 16 Sep 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcSt/IWZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132C338709;
	Tue, 16 Sep 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054334; cv=none; b=bHo0/M5fkWEoNpKvATB5BOVfBI0gFV0FouOk8JIJryCL+EM5NCUP9XGdxPDhwKRzzxLaZ2UOwcn6qwweCUH3+mwE0hbMw3M4hl4gSzgMdAjuQVMxQPdAZXZ12H9y7ivvcW+kckdeMUdpzJY81lm0qwkJjCj0/4vhzA4zYO+Rtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054334; c=relaxed/simple;
	bh=e7jzOkM+tM0itcBQdYH6jgZne7M3gryxqDyMPNdTG1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=avCRA3vumkB7gcvIzmlZkA9Po2EWgQnXq0Nmc4sr3T1lI1x+bl5qa4wLlDOTs250pmTsuMQ7VDCr5M4m2mGs36AZqrLNUrXOtp4WhXja1dEHB90f443mJU46pd+1hFud08TA+pAJW7fC725LaUYG/B3M5YbHBcha298+klQUGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcSt/IWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA80C4CEF0;
	Tue, 16 Sep 2025 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054333;
	bh=e7jzOkM+tM0itcBQdYH6jgZne7M3gryxqDyMPNdTG1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XcSt/IWZtWMmrpr0LojNprn+5hr3wMBdGIxCQS0PWfDRtgy0r4ipOX//G8d4DCyW4
	 Z1T20rwCastliRwkNc5mv86xAXuhYXNJBsmHm3Rk6fHTsFA/091HmMqKVlx9FF0eJv
	 /eHR2DcJWtshosUefi1Yr6CynXGUkbgZCcEU+4uEntptS+Z9zM5KGfirk5KmaXqKWB
	 ias2UKe+b5rsI/b/FLV9vK4lT7POQhVI0kTzBJgMUiI7l2LuDEXQLP8GOQKjbyT9O/
	 22lGoNakLiaGK22xKBKVnMdjaqok/xTedkCH8i0zXK+7VVMG2bR49OYsjuKsY/I6N/
	 kbgoRvbwjWJZg==
Date: Tue, 16 Sep 2025 15:25:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: Question on generic PCI ACPI/DT device property wrt ASPM
Message-ID: <20250916202531.GA1814806@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b00870c-be1a-42d6-8857-48b89716d5e2@gmail.com>

[+cc AceLan]

On Tue, Sep 16, 2025 at 09:48:06PM +0200, Heiner Kallweit wrote:
> There are drivers (in my case r8169) disabling ASPM for a device per default
> because there are known issues on a number of systems. However on other
> systems ASPM works flawlessly, and vendors (especially of notebooks) would
> like to (re-)enable ASPM for this device on such systems.

I would definitely love to be able to fully enable ASPM on these
devices everywhere and rip the ASPM code out of r8169.

> Reference:
> https://lore.kernel.org/netdev/20250912072939.2553835-1-acelan.kao@canonical.com/
> 
> Realtek NICs are used on more or less every consumer device, and maintaining
> long DMI-based whitelists wouldn't be too nice.
> 
> Therefore idea is to use a device property (working title: aspm-is-safe), that
> can be set via ACPI or DT. In my case it's a PCIe NIC, but in general the
> property could be applicable on every PCIe device.
> So question is to which schema such a property would belong. Here?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/pci/pci-ep.yaml?h=next-20250916

I'm not super enthused about yet more knobs to control ASPM based on
issues we don't completely understand.

Quirks that say "X is broken on this device" are to be expected, but I
have a hard time understanding a quirk that says "this feature works
as it's supposed to."

If ASPM works on some systems but not others, it's either because some
Downstream Ports leading to the NIC have defects or Linux (or BIOS) is
configuring ASPM incorrectly sometimes.

I think we just need to figure this out.

