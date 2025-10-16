Return-Path: <linux-pci+bounces-38350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CBBE364C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC18546C5D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37931CA4A;
	Thu, 16 Oct 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pml1mIUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D541AAC;
	Thu, 16 Oct 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618102; cv=none; b=R0KBKcPNESMQfrRYcT/OYpW6jrYcRU/dGnmQx+wQettm4t6zrrB8Z6cH/1El5FXpqSXv9ErVTCzOrOKpBUCi1r65kSpXEOyAG7tGk3kOy/YiBXWHviCJIQ9gOqIIS64B1jyS2Q7hlRADBrn8ordXtscVtGQrGH9ymAkFqWblFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618102; c=relaxed/simple;
	bh=veU+m3zE4yA9d0E4qY1nqKHDTFULUOv9qRfKl8VF4Lc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RnPE4RZnWjZ6IqSSKgS9lFj1utq8RCMeRCmyTjy8IJ498Nq5d6mfxTorVjcQtCHIkltE1qyVvESjy8csNYL6G3MQhigniBNrCpT8J0PnyHWNRWqQu1SMxlBfhPlq1GEQHYDsqAoK9h9DCm/Px1uYOeZE20VHujL5XbSqowAcAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pml1mIUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186AAC4CEFE;
	Thu, 16 Oct 2025 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618102;
	bh=veU+m3zE4yA9d0E4qY1nqKHDTFULUOv9qRfKl8VF4Lc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pml1mIUNg7O889IvbciMBTaeiZ//J535Yi7LVIm6UpPrnkeHTcZfvCiOKIJKh3G6N
	 Qpc4ohNCSSe2U197oCQmpgHZbQoXy4+Rg9RxJZ7Qqtuq31VMqaBZXZ27yQr4kJxoNU
	 mnIDzbmWJjDgii+57ljwSVXj8x5+7zAjoNO3FDjA8pXCTNKybow2evdeee3VAuXs82
	 cEwouaxeAg/oeH5A6SSGtShLMY/7Q/YDQRa4Z1QQMEFqFZ/ucUtjqY7aRc1ZHGbDcW
	 IrpvAHSxhJGoPZ0aJV2klLLCzcpksdBOw9d8iHuGOyNGIvxGFH6yUqzUAo09/ZXxK+
	 eu3jQ/0AFSCkw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 14:34:57 +0200
Message-Id: <DDJR102F5NFB.1X5IVJQ6FK3CD@kernel.org>
Subject: Re: [PATCH 2/3] rust: pci: move I/O infrastructure to separate file
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251015182118.106604-3-dakr@kernel.org>
 <20251015225827.GA960157@bhelgaas>
In-Reply-To: <20251015225827.GA960157@bhelgaas>

On Thu Oct 16, 2025 at 12:58 AM CEST, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2025 at 08:14:30PM +0200, Danilo Krummrich wrote:
>> Move the PCI I/O infrastructure to a separate sub-module in order to
>> keep things organized.
>
>> +++ b/rust/kernel/pci/io.rs
>
>> +/// A PCI BAR to perform I/O-Operations on.
>> ...
>> +/// memory mapped PCI bar and its size.
>> ...
>> +    /// `ioptr` must be a valid pointer to the memory mapped PCI bar nu=
mber `num`.
>
> I know this is just a move, but "BAR" vs "bar" usage is inconsistent.
> I think "BAR" is clearer in comments.

Yes, I agree.

>> +    /// Mapps an entire PCI-BAR after performing a region-request on it=
. I/O operation bound checks
>> ...
>> +    /// Mapps an entire PCI-BAR after performing a region-request on it=
.
>
> Similarly, s/Mapps/Maps/ and s/PCI-BAR/PCI BAR/

Thanks for catching those!

I think we should fix those in a follow-up patch. Even for trivial things, =
I
prefer not to fix them with a code move.

Those could also be a candidate for the list of "good first issues" of the =
Rust
for Linux project [1].

(Same for your the "legacy vs. INTx" inconsistency you spotted in the other
patch.)

[1] https://github.com/Rust-for-Linux/linux/contribute

