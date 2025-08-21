Return-Path: <linux-pci+bounces-34433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA29AB2EDF1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 08:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67EB5C12D1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E39288C0E;
	Thu, 21 Aug 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/4HHmaL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DBB25A325
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756703; cv=none; b=n7FCg7cJ8GAdKoz/HmTsxp0Ubj4VBfi9h9mStFagjTSQ0DRSHJQF/C90Uv9ZmRAi5e510q2Opp6h6UZndfJBYstKaeIaNomZhdnZgVUjbP3368UJ4JWVgxt95ZhKfAfMyy3lAHfwpPxkBdyo/pbJU2xYGpwgSNNslWBxrxo1HgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756703; c=relaxed/simple;
	bh=qEk88g9fuzyw6OHjRtX1J3LqZB7wVsTVZRqXoqPf/uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuP4Ie4q9QGNI5+yTqAUbI9SBjFWba5fj1lsVK/gX4pgXqfi7IRKg1EbkadvFH1TNWvwAb2dkb2T2kLy78faKFtFuZmUn2wXusQtTzsieKZK05zmQ6STmfpFcpGG/ULLCb4cnhseavAaomfhUAJBylOSQNISl44DJ4pRyH3i0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/4HHmaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D258C4CEED;
	Thu, 21 Aug 2025 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755756703;
	bh=qEk88g9fuzyw6OHjRtX1J3LqZB7wVsTVZRqXoqPf/uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I/4HHmaLeQR3ueSkX1du2eNCLMjU/mI8rP/L+MEaufLIfs6QxvRlEk9+8XJW5PUOJ
	 AHIZrQOPDT/FB29PrVyec95ZRoMkvRY3+mSFAaW6KlNtGF3utPXZSRu+GptNWOXcmj
	 pwXIW59VxH8+C6MoRMhPriZLwB2eKxjoAVDcuzmdyQB9fRXeWiQM4NooDCNYGJ+Y3h
	 OnpaDbqzSoiLSYncX9bpDkY5CUfmvd9Hak1mfsOuV4yAuvtKp7xfZMB5ptuTVj1S+Z
	 pNjH2IXtFfPXdy60z7A08pM+G1AjtYcVCJ18jFQxJ7bKwG9Ia9VaRNBl3pTIe66xXN
	 W18CZAh9rJO5w==
Message-ID: <7301fa0c-5092-42c4-9b33-acd96082d990@kernel.org>
Date: Thu, 21 Aug 2025 08:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: Add Andes QiLai PCIe support
To: Randolph Lin <randolph@andestech.com>, linux-pci@vger.kernel.org
Cc: ben717@andestech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, jingoohan1@gmail.com, mani@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 randolph.sklin@gmail.com, tim609@andestech.com
References: <20250820111843.811481-1-randolph@andestech.com>
 <20250820111843.811481-4-randolph@andestech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250820111843.811481-4-randolph@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2025 13:18, Randolph Lin wrote:
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>

...

> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pci@80000000 {
> +        compatible = "andestech,qilai-pcie";
> +        device_type = "pci";
> +        reg = <0x00 0x80000000 0x00 0x20000000>,
> +              <0x20 0x00000000 0x00 0x00010000>,
> +              <0x00 0x04000000 0x00 0x00001000>;
> +        reg-names = "dbi", "config", "apb";
> +        bus-range = <0x0 0xff>;
> +        num-viewport = <4>;
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x02000000 0x00 0x10000000 0x20 0x10000000 0x0 0xF0000000>,
> +                 <0x43000000 0x01 0x00000000 0x21 0x0000000 0x1F 0x00000000>;
> +
> +        #interrupt-cells = <1>;
> +        interrupts = <0xF>;
> +        interrupt-names = "msi";
> +        interrupt-parent = <&plic0>;
> +        interrupt-controller;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 2 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 3 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 4 &plic0 0xF IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +
> +      pci@a0000000 {
> +        compatible = "andestech,qilai-pcie";
> +        device_type = "pci";
> +        reg = <0x00 0xA0000000 0x00 0x20000000>,
> +              <0x10 0x00000000 0x00 0x00010000>,
> +              <0x00 0x04001000 0x00 0x00001000>;
> +        reg-names = "dbi", "config", "apb";
> +        bus-range = <0x0 0xff>;
> +        num-viewport = <4>;
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x02000000 0x00 0x10000000 0x10 0x10000000 0x0 0xF0000000>,
> +                 <0x43000000 0x01 0x00000000 0x11 0x00000000 0x7 0x00000000>;
> +
> +        #interrupt-cells = <1>;
> +        interrupts = <0xE>;
> +        interrupt-names = "msi";
> +        interrupt-parent = <&plic0>;
> +        interrupt-controller;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 2 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 3 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 4 &plic0 0xE IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +
> +      pci@c0000000 {

One example is enough.

> +        compatible = "andestech,qilai-pcie";
> +        device_type = "pci";
> +        reg = <0x00 0xC0000000 0x00 0x20000000>,
> +              <0x18 0x00000000 0x00 0x00010000>,
> +              <0x00 0x04002000 0x00 0x00001000>;
> +        reg-names = "dbi", "config", "apb";
> +        bus-range = <0x0 0xff>;
> +        num-viewport = <4>;
Best regards,
Krzysztof

