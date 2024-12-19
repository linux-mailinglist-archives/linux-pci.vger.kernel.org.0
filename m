Return-Path: <linux-pci+bounces-18782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C119F7DA2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 16:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79912188E77A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABB22619A;
	Thu, 19 Dec 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu15QJeH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD672225788;
	Thu, 19 Dec 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620837; cv=none; b=gjJM5Jbiy2sKPxoyf7kZNO4lSpPCqdTbStsJT45s/FVXUwNoL4OFgGJrdSwoQNm8e9JScrafepd6I+5mrTKuKai9BGwRfF26M5T5oFGDmT3KqahOyjpt2TaPBzgCz4en5qYmAabqcVCNcb8A37fOvnywi0u3wAD+eVLfrmChq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620837; c=relaxed/simple;
	bh=pkEUowd/uM4MPorVImAC2M5988GASgMMRYF0vEx3zM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNrFtTJ1NzGjwMbT6TnEZZnY7kdm4xsiFxr6bUfjE1mKgXNniNd6G+NCBj3YwiHaRepkNxyOsw1DO42CM9y7Ea4AZFlgrqwiiWbpwjguoOWNxmHf3/yvxL6ZcEWiQ0G9w5GqRHfgK6/hIsP3IZkjkJ/2bOpbRMDGfZP6yph/v5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu15QJeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB1FC4CED0;
	Thu, 19 Dec 2024 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734620837;
	bh=pkEUowd/uM4MPorVImAC2M5988GASgMMRYF0vEx3zM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu15QJeH3+NLP+eD6uY35HNHzqfEC4VZbS2OZDVfbm9IA31pwkAtJR2r1MlXHc9SV
	 VwmbZMoyD1q4Iy5NVtd/WMJ8HXbsirKxzxR/eb82OQMVpz7CmL5Chjkij7E5g9/n8Z
	 xAvgwehqCGkwKDqnOuZBY8lSFO5IHU7r3/FXmznA55Idgfrba++2J20bHduZYe4q+P
	 /p5glJ6zwdpuCf95FXDxM0s+Fm6oP7LOrAGuvt5A/ty7nRVEbzkE7FHJp1oxpKtsE4
	 zMxwrmfbjSg3lN1QiUCj4zQDLNhXmHMK5XsRR+dlu2xnn409GSWFmdaXeHWHSxHtSP
	 Td1E6XDLnTDTA==
Date: Thu, 19 Dec 2024 16:07:09 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v6 13/16] rust: driver: implement `Adapter`
Message-ID: <Z2Q2nYIJs2hqU_mo@pollux.localdomain>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-14-dakr@kernel.org>
 <87r064kkq5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r064kkq5.fsf@kernel.org>

On Thu, Dec 19, 2024 at 11:53:06AM +0100, Andreas Hindborg wrote:
> 
> Hi Danilo,
> 
> Danilo Krummrich <dakr@kernel.org> writes:
> 
> > In order to not duplicate code in bus specific implementations (e.g.
> > platform), implement a generic `driver::Adapter` to represent the
> > connection of matched drivers and devices.
> >
> > Bus specific `Adapter` implementations can simply implement this trait
> > to inherit generic functionality, such as matching OF or ACPI device IDs
> > and ID table entries.
> >
> > Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> 
> I get some warnings when applying this patch:

Ah, that's because your're probably having CONFIG_OF=n and some imports are only
used within `of_id_info`.

Gonna fix it for CONFIG_OF=n.

> 
> >   RUSTC L rust/kernel.o
> > warning: unused import: `device_id`
> >   --> /home/aeh/src/linux-rust/rnvme-v6.13-rc3/rust/kernel/driver.rs:10:13
> >    |
> > 10 |     device, device_id, init::PinInit, of, str::CStr, try_pin_init, types::Opaque, ThisModule,
> >    |             ^^^^^^^^^
> >    |
> >    = note: `#[warn(unused_imports)]` on by default
> > 
> > warning: missing documentation for an associated function
> >    --> /home/aeh/src/linux-rust/rnvme-v6.13-rc3/rust/kernel/driver.rs:158:5
> >     |
> > 158 |     fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
> >     |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >     |
> >     = note: requested on the command line with `-W missing-docs`
> > 
> > warning: 2 warnings emitted
> 
> 
> Looks like the latter one is from patch 13.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 

