Return-Path: <linux-pci+bounces-31744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE179AFDE0D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19875403BD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25631E7C24;
	Wed,  9 Jul 2025 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="MJ+rc8Mk"
X-Original-To: linux-pci@vger.kernel.org
Received: from lovable-gwydion.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.216.144.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E581DC988;
	Wed,  9 Jul 2025 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.216.144.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031418; cv=none; b=IKZ8lOueWxGNEU3ysCY8hn3pG3urWK+jqvBV9RIhuULA3lvwzbgubPOySyPIdsmq/1FrPMi6AYbJDBJQX71KzyZ5MAHtagVXwf6ebFYXRpFIE7QvQ3zsCKWVKAw3yUqGpf0Vlxu9oZibrURQyicjtpCEKVgkLCDC2EeUsW5wje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031418; c=relaxed/simple;
	bh=J79g9vzJT3nMxJqDIoa708wQy33SBgmf1m8Cws4Ftow=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ixR4ezPjqLFjMVeCBoNx4HhXQ48tyUaxKMUWTTH/O9O+9OlguYLuyln6biBU1aav/AA8PQNzVOcVEk64J1T/Gm2eU9aDHrDaV+OYiA0p7dp1F8r/AsuL8NZYOhwzblWYrbYon0HaTNlfIoqh2aDlgmsAJnTDCpYMCbZAMMdr76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=MJ+rc8Mk; arc=none smtp.client-ip=18.216.144.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from debonair-kikimora.authn-relay.a.mail.umich.edu (ip-10-0-72-73.us-east-2.compute.internal [10.0.72.73])
	by lovable-gwydion.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DE0B2.2864D6D3.2572D355.1083628;
	Tue, 08 Jul 2025 23:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752031405;
	bh=gRADj6VLSdadP6HhLwpFe0zFZFVzVf7XWMgj6Aw9DlE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=MJ+rc8MkYnUEeecM6gzgQXV71IN2FrHafJW7K9hzIptIc7L/SmE/yQvQvQNU626X3
	 sNyO3mcuR9vxiKd9qawWNoSOrU5FeyuEmvVfJtRfwAs2IE7t6CnbqyNFfEEIATXFCv
	 OsIVChby1YgPACOOrclQp/S751GTT0MgiOLkiRCDUW1VeU/zUmniB7l1dfqkDK7FCv
	 iSqtUmbPWcfQlKs0x5+EAF10pHHidJGapSSwNqUySx6rDdNdMgj1TrMNNkSoG6Ng37
	 ORR435zHhFJJR71U8omE0lvRcl8i4DQaPA1/nt9zStuFppn0pfZXobztyjCjZLvZ3g
	 zFsXXU5en8NFg==
Authentication-Results: debonair-kikimora.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by debonair-kikimora.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DE0AA.29C8EFF2.5B22297C.2861961;
	Tue, 08 Jul 2025 23:23:25 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 23:23:20 -0400
Message-Id: <DB77AQ53YOFK.VBSAP1H7FFB9@umich.edu>
Cc: <a.hindborg@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <david.m.ertman@intel.com>, <devicetree@vger.kernel.org>,
 <gary@garyguo.net>, <ira.weiny@intel.com>, <kwilczynski@kernel.org>,
 <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <lossin@kernel.org>, <netdev@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] rust: net::phy represent DeviceId as transparent
 wrapper over mdio_device_id
From: "Trevor Gross" <tmgross@umich.edu>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <alex.gaynor@gmail.com>,
 <dakr@kernel.org>, <gregkh@linuxfoundation.org>, <ojeda@kernel.org>,
 <rafael@kernel.org>, <robh@kernel.org>, <saravanak@google.com>
X-Mailer: aerc 0.20.1
References: <20250704041003.734033-1-fujita.tomonori@gmail.com>
 <20250704041003.734033-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250704041003.734033-3-fujita.tomonori@gmail.com>

On Fri Jul 4, 2025 at 12:10 AM EDT, FUJITA Tomonori wrote:
> Refactor the DeviceId struct to be a #[repr(transparent)] wrapper
> around the C struct bindings::mdio_device_id.
>
> This refactoring is a preparation for enabling the PHY abstractions to
> use device_id trait.

Should this say "the `DeviceId` trait" (different case)?

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 53 +++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 65ac4d59ad77..940972ffadae 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> [...]
> @@ -734,18 +733,20 @@ pub const fn new_with_driver<T: Driver>() -> Self {
>          T::PHY_DEVICE_ID
>      }
> =20
> +    /// Get a `phy_id` as u32.
> +    pub const fn id(&self) -> u32 {
> +        self.0.phy_id
> +    }

For the docs maybe just:

    /// Get the MDIO device's phy ID.

Since `as u32` is slightly redundant (it's in the return type, and that
is how it is stored anyway).

>      /// Get a `mask` as u32.
>      pub const fn mask_as_int(&self) -> u32 {
> -        self.mask.as_int()
> +        self.0.phy_id_mask
>      }

One optional nit then:

Reviewed-by: Trevor Gross <tmgross@umich.edu>

