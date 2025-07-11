Return-Path: <linux-pci+bounces-31963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B88B026E8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183E01CC0628
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB9221281;
	Fri, 11 Jul 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRPBfk/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E311EEF9;
	Fri, 11 Jul 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272618; cv=none; b=nzrtdvkf8EOm16pCkA7K0QBouSK6Qi7cYmXvaO7j0YH2wLXUdd+YZYcPk4SbKj2ko7tbbRmZGJNDz+qh1ytEFF/mTL+p3XUkzQBp3puJHbC6BDZXwhQOXYH/sWa1a73vQv2RJhmMecftYxXluHYycfjLqxtUzxNeZ6wHlHuA9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272618; c=relaxed/simple;
	bh=skBlVZohMnUnYt5aoT76+cuAKlWXY74hu4CgtyUg+HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6pWLkOqRcnj2Kxamxd6ordtqqxnjS4MZPP7enkQsV2PCBCjBhpgDWfJpLNuKkyrG0gPh3fPxnqolCiUQ5Krj7+pA4JsPoNlpUp5qlEYbwWs5ayH7vAdSmrv5qfyrw7PdoBQOXuWFi1m2Isxd9aZ8kY7JYBrHnrbPoEhAMqRNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRPBfk/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8D7C4CEED;
	Fri, 11 Jul 2025 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752272617;
	bh=skBlVZohMnUnYt5aoT76+cuAKlWXY74hu4CgtyUg+HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kRPBfk/YmqYW5jC6GAV66AvEVpfeOmi2XaS0Xc6Gv9HtuHD6rsUye0/AO1cBSr1aB
	 3T6vSo92K7l0qIY83X7Wy0FDZj0WMv8rp+dE1wksXS8BWL2o9FvdSEHkur15/ODl0e
	 z3ZwJ7HkZMOpdjkioAn1C/KtCXceeuu7Uidovcs2MKETTqob2pygUuBQVZ9gsaUW+t
	 LKAawVgcAjvevxWwoq3jmPCBgAuRY0ZdfdexRSD+OPq40Kb11n/2rFbuadKV6Ea/na
	 0w3Nlyq26U/hKsMQ4ZFG9FXwcKk4gIsWY99D++uYcaQKHJKGv231iuIIUXh56u2u/d
	 u24qIkA30Q9rg==
Message-ID: <a138b3ef-eee9-42bc-b861-e5037f96940e@kernel.org>
Date: Sat, 12 Jul 2025 00:23:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rust: device_id: split out index support into a
 separate trait
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, gregkh@linuxfoundation.org, ojeda@kernel.org,
 rafael@kernel.org, robh@kernel.org, saravanak@google.com, tmgross@umich.edu,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, lenb@kernel.org, leon@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
 <20250711040947.1252162-2-fujita.tomonori@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250711040947.1252162-2-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 6:09 AM, FUJITA Tomonori wrote:
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index f8dd7593e8dc..a8f2675ba7a7 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -170,7 +170,7 @@ fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
>                   // and does not add additional invariants, so it's safe to transmute.
>                   let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
>   
> -                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> +                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceIdIndex>::index(id)))
>               }
>           }
>       }
> @@ -204,7 +204,11 @@ fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
>                   // and does not add additional invariants, so it's safe to transmute.
>                   let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
>   
> -                Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> +                Some(
> +                    table.info(<of::DeviceId as crate::device_id::RawDeviceIdIndex>::index(
> +                        id,
> +                    )),
> +                )

Just in case someone wonders why this is weirdly formatted, while the acpi one
above is a single line, this seems to be a bug in rustfmt.

>               }
>           }
>       }

