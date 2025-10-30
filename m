Return-Path: <linux-pci+bounces-39796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1ACC1FA6D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A96864E902F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7433491FE;
	Thu, 30 Oct 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVec60u9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897733B95D;
	Thu, 30 Oct 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821566; cv=none; b=X/hWr+PCN1e/14Vnki/3HEYAAxjIAHrHUunmOjBYE6I+WivOnfg4pZ6u+lf4KENFQ8EknIg6iR6MG7NLYu0psE+xNlrS04+zYOHz8LpEYT2EViD4DPms6vO380lZOKuCaPRK177FzaEE2ey1DbUJ57LIj4IYbwc9eoZJrLNolnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821566; c=relaxed/simple;
	bh=szkwGplbJ5oUlGJfPgg0WAoGQrZxT9aT4v250fXRg0U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KsZaAIS6LecMO9HwUrhfrY/0H/EqYETNtHU67AnKM+B+4DLUISEe1FrwvmMHdilp/IAc0lk4RXyLfNyIcCXAU+9XAywBgrorXmkDNgcCpxpuGGWJxVYih5Ul3X3Oc/8tLrlwu5RUMl24u7g3HmyEK1pmJjQtsHGnPSf741RIFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVec60u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00299C4CEF1;
	Thu, 30 Oct 2025 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761821566;
	bh=szkwGplbJ5oUlGJfPgg0WAoGQrZxT9aT4v250fXRg0U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IVec60u9rkZkxlQVIAe3UYNTGek4XsSWuHuhXNL5t3DkI0U/r/URTnVFOQLpOvMBv
	 BBPkRZN/9dWMCkOw2Rue52ZqMcMOVnzt8t1X/qK8EXB0PJ24vlC6UpF4PmCn5Zut4S
	 LUZRrXznUIQXL/ms94+7dgD9H+NB3wJZ1yTqc4YxGKrngShWiAPDztF6x76/hvNzb+
	 NOvj4lpWLeRNRhNlYJLgcKuS8Elr/Df59j4r3MuVGmExKsdjykRUe5bGnU1mXFWXTG
	 T53DeTkz1sMQhGXQPim0sp8ThZTTWaVhZ+25jivhIvMqmUF4KxHKxIDBv/6vSJl/0W
	 9LV7ri1aelOeg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 11:52:40 +0100
Message-Id: <DDVLMBC40199.2BVFYHDGQP4Q4@kernel.org>
Subject: Re: [PATCH v7 0/2] rust: leds: add led classdev abstractions
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-leds@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>, "Lee Jones" <lee@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251027200547.1038967-1-markus.probst@posteo.de>
In-Reply-To: <20251027200547.1038967-1-markus.probst@posteo.de>

Hi Markus,

On Mon Oct 27, 2025 at 9:06 PM CET, Markus Probst wrote:
> Markus Probst (2):
>   rust: Add trait to convert a device reference to a bus device
>     reference
>   rust: leds: add basic led classdev abstractions

I don't see an entry in the MAINTAINERS file for the added LED code.

Did you hear back from the LED maintainers already?

@Lee, Pavel: What's your take on this?

Depending on whether it is likely for the LED work to land in this cycle, I=
'd
otherwise pick the first patch into the driver-core tree for now, since it =
can
already be used in the PCI and platform code.

(I'd assume you want to wait for the driver from [1] before picking the Rus=
t LED
code, which has to wait for the next cycle since it depends on the Rust I2C
code.)

[1] https://lore.kernel.org/rust-for-linux/20251008181027.662616-1-markus.p=
robst@posteo.de/

