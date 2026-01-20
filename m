Return-Path: <linux-pci+bounces-45255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F9D3C537
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B3588F65
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536F3D666F;
	Tue, 20 Jan 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwQ8b5Rx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC938A9B9;
	Tue, 20 Jan 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903946; cv=none; b=G8FLMlR3MaqO+OxKnOpfGmj9Z4bKBVd10e3U78yPodIv0STqoc2TPEkPHXlUo6J5O6vuB8k5oS2YLcJW4n2XqAKeRf2+zG3IHAUVzpfWwfZ2rs72kLv6laDfhn2P73qNXQjihjU67w0UsFePy6ItMDnHXNA4M+mBub/JT/bcMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903946; c=relaxed/simple;
	bh=dxSOR0eN/vdhFUeOV8fumG7yv5nlIzfUzyKHu+4HI9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VtSMqxcEqKTb79xUduJHFFqoEfTVwrFyzv1scUu3cMTcFdwvuwsm3pf1x4AqxymbI7aUD5dginWek8kxD8BWV+KMS3qO6Bb/ATmWvBy3P8BcM++2c94z2m2taeyNPKbpKeC8HqNXCzJ2fQp03UbFGLEZAqSfZRgLtM7Lg8egkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwQ8b5Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82EFC16AAE;
	Tue, 20 Jan 2026 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768903945;
	bh=dxSOR0eN/vdhFUeOV8fumG7yv5nlIzfUzyKHu+4HI9s=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YwQ8b5RxobMJuydC53XBdRhHGFAUumBN0nRrXwCROoSRN85KxTHEoHCSaxpjlwc03
	 sT6QMXWmboLZwTb8Bhh8gC0fh8i/wajpyhhO8j6A9KSqm8Y6akCTpk0UIk93kPWnRs
	 EjajSiRpgmhhqF5eDXcp1bH4WT9vw0giZGpnWAd7ofEDM+5Fyw6bCfdx9Mr3301t+t
	 9M/zHZCyz11yN2GkTivHuU3dVKG61ZAFGMh0vrhkAoIysTTNrP4lCTXB1W6BHkJZXD
	 7HutSVlrgR8OauVpm4ccy+mhiySbLLoRqLydhmZCG3gI/q8uzW/wfs6V9ONUAhg2pN
	 rXG8JpCCVsLHg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 11:12:18 +0100
Message-Id: <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com> <aW83HV4lVR5MQlDd@google.com>
In-Reply-To: <aW83HV4lVR5MQlDd@google.com>

On Tue Jan 20, 2026 at 9:04 AM CET, Alice Ryhl wrote:
> On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
> Overall looks good to me. Some comments below:
>
> I still think it would make sense to have `IoCapable<T>: IoTryCapable<T>`=
,
> but it's not a big deal.

I think with this approach it's not necessary to have this requirement. In
practice, most impls will have both, but I think it's a good thing that we =
don't
have to have an impl even if not used by any driver, i.e. it helps avoiding=
 dead
code.

>> +    /// Infallible 64-bit read with compile-time bounds check.
>> +    #[cfg(CONFIG_64BIT)]
>> +    fn read64(&self, offset: usize) -> u64
>> +    #[cfg(CONFIG_64BIT)]
>> +    fn try_read64(&self, offset: usize) -> Result<u64>
>
> These don't really need cfg(CONFIG_64BIT). You can place that cfg on
> impl blocks of IoCapable<u64>.

If you agree with the above, I can fix this up when applying the series.

