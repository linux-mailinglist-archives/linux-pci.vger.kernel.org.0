Return-Path: <linux-pci+bounces-40220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09DC31E51
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9104423487
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D393254A7;
	Tue,  4 Nov 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyezfKar"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD62FB619;
	Tue,  4 Nov 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270924; cv=none; b=AMSFuO3vZMU0ZNOKMw1fLYvan6bitfk4ozB5ltPOonOdyucUUq1myG4oCi/+kDH8axqP+zetSj4S5anW9MFFplpOtMtNZ28bGIuXhj37WZQjBxPGFlYLv8gr0nfelJ5Osh9gOLXPtEZcSxxa08VfZRgiS1lHTw6ojwmvK/Q+9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270924; c=relaxed/simple;
	bh=ccWZxb/7YDwDlOfRLcY7+NbRKQ9bCeYNsmlsu4cWyTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LzpkSBlhw8lTx5gs3shDw8yXAFA4ORm7VBjfN2zKymn1iAbKpNE8eGc/fLsqVDhGG4bxDH15V4zQdaKCUMggJR0YyU4pVPz4zhBI0e/hLFfDQEZpjcbkl/fOZPX+IVw1bQHqAxbWeBBGWTKs3Gcz0rcLbDdpX4f6zCyRB30g6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyezfKar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64A2C4CEF7;
	Tue,  4 Nov 2025 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270924;
	bh=ccWZxb/7YDwDlOfRLcY7+NbRKQ9bCeYNsmlsu4cWyTU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=FyezfKarYNXTqrFgkQhHTirzGVFNArCWLfYa/LaHTCvkFIisu6wGxzX147Hgz+jsX
	 UxLRyaH8yf0u9qAe8F4XCgtaaNA4as5CCB0CsERugEZufcJqW7O3FM9jGiO71WuJiY
	 Tia3T6ed3DpSKmiJB0KzR4anjYySR6/V5dBmpzWgnkTcXbt2TwRgSPWsHsdgbSVk5e
	 HwO6Adf9onKkpANr5vIDtqwbJIE6+yEwuM62jL7ilOerI7n7I1pjyBI901lPTrxPVv
	 T2u2jqVyNtFutd27/GaD+oauTSQnyfFlSC3syCrFrfTBbOc+y7JcdbEJV+DY/JWVz3
	 Qi+5RaNkZzGGg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 16:41:56 +0100
Message-Id: <DE00WIVOSYC2.2CAGWUYWE6FZ@kernel.org>
Subject: Re: [PATCH RESEND v4 4/4] sample: rust: pci: add tests for config
 space routines
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251104142733.5334-1-zhiw@nvidia.com>
 <20251104142733.5334-5-zhiw@nvidia.com>
In-Reply-To: <20251104142733.5334-5-zhiw@nvidia.com>

On Tue Nov 4, 2025 at 3:27 PM CET, Zhi Wang wrote:
> +    fn config_space(pdev: &pci::Device<Core>) -> Result {
> +        let config =3D pdev.config_space()?;
> +
> +        // TODO: use the register!() macro for defining PCI configuratio=
n space registers once it
> +        // has been move out of nova-core.
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space read8 rev ID: {:x}\n",
> +            config.read8(0x8)
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space read16 vendor ID: {:x}\n",
> +            config.read16(0)
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space read32 BAR 0: {:x}\n",
> +            config.read32(0x10)
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space try_read8 rev ID: {:x}\n",
> +            config.try_read8(0x8)?
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space try_read16 vendor ID: {:x}\n",
> +            config.try_read16(0)?
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space try_read32 BAR 0: {:x}\n",
> +            config.try_read32(0x10)?
> +        );

If we want to demonstrate the fallible accessors we should try accesses out=
side
the bounds of the requested config space size. However, that doesn't really=
 make
sense, because in this case the driver could have been calling
config_space_extended() instead.

So, I think the fallible versions don't really serve a purpose and we shoul=
d
probably drop them.

