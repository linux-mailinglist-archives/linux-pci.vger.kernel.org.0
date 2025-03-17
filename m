Return-Path: <linux-pci+bounces-23917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC884A648C5
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C7164051
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1838322CBC9;
	Mon, 17 Mar 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fzPCVVFd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4B142E67;
	Mon, 17 Mar 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206071; cv=none; b=e8Mgrvl6mAavAbk9OvE+qBNnMvXPFy8ZFlEI2UEX/u+2GpFI1/Po8RrzSiqAHDLWkTtczuSSk4TVsLP/hRyHwIRQn+fPpCuFmNaySj7W/hOYD876ZG0YqEJkHRGv1HB8DVqhrkDJoD86o4Esc2AZb/NwdorIwJA/562RFV0KXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206071; c=relaxed/simple;
	bh=xOdFdUpJqXs168lzXGK/iu7vViHn0S5IOwWenA0nwVI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ido8OzEmQDbX1rPMSR7edDgIDZwfJSKGuMofiGnPm4hfriwbrjXUUVb/YCrPLPDWATIV6+hHZXeD+9s15bd/q5RAFfWWOP2nSMzeQUFDZ/HkgROK3FDJ3/ttKXJNrgGD+sxPzFuloYfUFvAj/12vg/y8kk0tChMPVHGgesgf1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fzPCVVFd; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742206067; x=1742465267;
	bh=xOdFdUpJqXs168lzXGK/iu7vViHn0S5IOwWenA0nwVI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fzPCVVFdLnmSWb+djKDx6qAMrYdAsA9lVUQW8H48+r9V3ZP7WWP9eRU6wt+9/h5GW
	 t41nEA2wUFEhq42aF9+3pDiOkSxb6jvqjLC69pn68mIk1ueLuKkw3oqB+BMqrhBjqv
	 sLd096O1fJV9EVWK5pU9beMj2/QQjsaP3Cy0yKEgklaL95EfufB/eGwJZOJ8VOFZOG
	 u6ufFnXAAb3fvPhks+DpDxh9A6/a9R227c1dw1eblqiWPsZpef8sf5HpCPtXxKBtIw
	 SOlgAnvxGwsL6tiWo0Vnm46lUQBdJaT4Yz8bQX9hLZg+oSw/8KPvSbn4clfrxCshVV
	 a/fr0I7AXnm8Q==
Date: Mon, 17 Mar 2025 10:07:43 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
Message-ID: <D8IGI57498GK.1NX41N6YMNERZ@proton.me>
In-Reply-To: <CAJ-ks9nsEMALOFbQEjj69=griW=x_h_irDg4mHdo+hG+ZbGN5g@mail.gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com> <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me> <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com> <D8H1FFDMNLR3.STRVYQI7J496@proton.me> <CAJ-ks9m-ab9Y5RD01higxZxbowZi_0tsSmCCw2umJLxBLH4dEw@mail.gmail.com> <CAJ-ks9=AKR+LUMBjLNrC9NZst9+18Q3HTrWn4q+baz87BbG6Rw@mail.gmail.com> <D8HVKRW45ESG.3NP8BPWF76RYT@proton.me> <CAJ-ks9nsEMALOFbQEjj69=griW=x_h_irDg4mHdo+hG+ZbGN5g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f7d138c90f94a097e803782efe820c024cedaa0f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 7:59 PM CET, Tamir Duberstein wrote:
> On Sun, Mar 16, 2025 at 1:43=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> No change required, with my reply above I intended to take my
>> complaint away :)
>
> Cool :) is there something else to be done to earn your RB, or do you
> mean to defer to Alice?

Ah sorry, I didn't end up adding it (:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

It would be good if Alice could also take a look.

---
Cheers,
Benno


