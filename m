Return-Path: <linux-pci+bounces-34384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04924B2DBD7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C829C5A7F4C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343E2E5423;
	Wed, 20 Aug 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAfSqlxm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466971ACED7;
	Wed, 20 Aug 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690981; cv=none; b=mXTD6W7qfPJCSxMDoyemE7hSvHzxVJUC86hqAbrbj3epuHqkI0cWpGOCDtTEt55OMDvIWUvNDlZuuprNz2hw0l3UOwaFBQ6DHGlWbyzLS/tQCzhjACmBnZupa2p8v73P7AGaHtejiDrjBad9NFJl5gXUdnlJsHRGtwvyZxvah0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690981; c=relaxed/simple;
	bh=6M6pVjOhBfeqwKpYkqz5paUIiMzASEW08D70GptOgJA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=n5XIw97Gms/KcKG40F1GbZRpqJm2aDHXf56J1/mGoVpfBlA35nqJjRnFUqS15rBfoy1o434AWISva2PjAIpgGc9tPsOC3K+aoYCrSycTUhHL8yubz0c9rJneynihwJ3lP+/8MuXEXxtx62d6CWL5uVJTKRRoUj9GMIFuw2Tfniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAfSqlxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE46C4CEEB;
	Wed, 20 Aug 2025 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755690977;
	bh=6M6pVjOhBfeqwKpYkqz5paUIiMzASEW08D70GptOgJA=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=eAfSqlxmkPHJo5yDX5t6UQTQrD0VFx7zJF/ZOOyguTzkP5uA62dDGkrGDcBPzl3te
	 oxebeKWufKYdm84RpdHWR1kSEknK6c6mob94Pb8OngKRwKu2PHEopElVZkX+bfawt1
	 344PX6/6kKj/bYMxgBRow/8/0RDhBEQfDfRmsI+zRcYGqQ7JWSMRFLA2nkzMCR6eVA
	 ab6ga22cFBXP3XkRaM4STSrt4fju6QETApBbVheqJHDPgxkeuf8xYfh3Q+J0NQynFX
	 E0GJFmuTSk0x4voxqWCkHmMFFjIxn/n1Gadz4XCra/fUgTqXW2N+rP/erXX1WxOC62
	 5pyqTKe36HYDg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 13:56:12 +0200
Message-Id: <DC78IA71Z47V.1N46WE5U3EI5C@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 3/3] rust: pci: provide access to PCI Vendor values
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
 <20250820030859.6446-4-jhubbard@nvidia.com>
In-Reply-To: <20250820030859.6446-4-jhubbard@nvidia.com>

On Wed Aug 20, 2025 at 5:08 AM CEST, John Hubbard wrote:
>  impl Device {
> -    /// Returns the PCI vendor ID.
> -    pub fn vendor_id(&self) -> u16 {
> +    /// Returns the PCI vendor ID as a validated Vendor.
> +    /// Returns an error if the vendor ID is not recognized.
> +    pub fn vendor_id(&self) -> Result<Vendor> {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> -        unsafe { (*self.as_raw()).vendor }
> +        let vendor_id =3D unsafe { (*self.as_raw()).vendor };
> +        Vendor::try_from(vendor_id as u32)
>      }

Same as for Class, I think we just want Vendor::UNKNOWN.

