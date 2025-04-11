Return-Path: <linux-pci+bounces-25681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F4A86043
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 16:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489E616E532
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B81F37BA;
	Fri, 11 Apr 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Vq6il/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339141F30AD
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380893; cv=none; b=KyGCRdGPDjLtikunVyCdbV5ZA1Q6BhIhABShmqNzuya2qzd+MJEwisXz0ho3rYa/GFJY3vgtqLkKj0cAuh4aGOkhSsV7tXBf7q7q5qonRPLKU0NtGgz5r7GTpNYoatskNeqSzBShqwKEe051VVnC+ENw7VD/dimaugaWNmNk3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380893; c=relaxed/simple;
	bh=3I/jo4GVACXTfj3jcxaqe6QYqUY4G0brexzhnK0ZACQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXflWgVLfZU6JVOJZxvjrxlwKyqFjodguG0PGmRBVsFCQP9Qt29gpWF9tJJs51YAOP3NNAJ/8Bn7k+oFGi18TI0cKgCf/NByIvNJUMBkqh1mC1WRCk1eCgaV8VWxqZUtWiDQSJSd5k7SAOZkau7yFD0WJ7AUSwU0ZAVbjheg+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Vq6il/s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso1222317f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744380888; x=1744985688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXMGF02aLSnVhhQjfgbwPODzDlrVvGFax9i6l7P95zQ=;
        b=3Vq6il/sCVD5ZKXiwUv+117yMDTw/VyqFHjMo8Mo/xhN81MZnac0O6UPv0LG/zZZzu
         qtp+f2IcAb73rselEvAG0EJUWXYD0in3jWUftxo6ls+332W6OtE35eVw/QH1B8ZGq9UG
         17PGVdMMwMBSJmYdfYv+cFyYRyqy5H7wpfnIodAId/6d6ZNm8YC5gBWGNWhy/ntXqzw8
         2zklx+jZCClTvAUtjwjM9BqrRQcx4o5Lv1i9iI6yelghgLAiOylCf5ZkuH0G4YsseFEg
         S7hChU1ELbv42HCK9bs8YpcJRG+MzyrXQP1kuQmL56ZPhmkp5baJOPc/MT1ySOZy5via
         Y2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380888; x=1744985688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXMGF02aLSnVhhQjfgbwPODzDlrVvGFax9i6l7P95zQ=;
        b=hxE3+6McQ9rofjE6FDbJNKToJFttRl1s4VgZfNBkt/WcdcYb8JXX5326NmwuOkqxyZ
         9tIMy3xrNcx9qplYvItDMsYv+iJnOZYKOGeXi6+K914Z7FWrpEoOtrxMzQLnFML0DVzU
         b1qR+CndXKiAO2E4fTGA4oTMNDN4tdSt+amV6ROwfww84X2X7gpatRXdegXKijXeSyFx
         WW0mSE3agPgElojS3ci9tuT2FtfkWtV0uNXerC6ASZINMAyq/S644MPg3c+WGNTyh7AC
         eV+c+Nc+MpoGx9BYCjScTwnNGcKuTH0NHdksyB0xKOcdmIvcnSlAuFuFS8Z9LbB1mevP
         AhyA==
X-Forwarded-Encrypted: i=1; AJvYcCUMPzFuvxysfVdMDGuZZaDPv+3akWN79ahR/fyLtHvF0K/3ie1mb+kkaO/d0s1VyEg2JsLp7lch69Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBk1bKc/f+o2o9N1jbdprHXjG4UtGP7hsYEo0XtvAO3OqMrVRa
	OtgG24QwpqSGQwcx35zVC8HBARXWVUWIoI6KRVzFBgQqKu0v99zoS7lZvbNGPNEr8Wvy5FEOTqI
	AapnBXp0KuWDvFRv/9zHdh9hT/ZUSuexyn4dh
X-Gm-Gg: ASbGncvlKMEKrijOpAy04vj2HlzbM+9PFqc25dpQ6U1A3NVAkM8o4un7RFDdnwaeueT
	cVC4+7V2d0DD+xKkad6MmPuibnLvkElr97EvB7FouW8VXiWOqgfr1MZ5XE83se8/KjfqgvQ1ULw
	vD+kIwDoMQ5jToi4PeYgT28DadhuHDJmS2Sw==
X-Google-Smtp-Source: AGHT+IEvfllzR2JPfvaVSPMfFR259rJ0LInD1vvPV1cUQw8WY9tKKwVRF8+YuZkXX5HFgCCrO2dQv4csvUmAfS+p+8c=
X-Received: by 2002:a05:6000:144f:b0:38d:dffc:c133 with SMTP id
 ffacd0b85a97d-39eaaebc5c4mr2768779f8f.44.1744380888247; Fri, 11 Apr 2025
 07:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
In-Reply-To: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Apr 2025 16:14:35 +0200
X-Gm-Features: ATxdqUGt2HpUIhfbszKbRnHcJkw44XStGlH5K6VgtPiPDEF_Tvxme1ItV2cYEZU
Message-ID: <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:08=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> the interface of `HasWork` and replacing pointer arithmetic with
> `container_of!`. Remove the provided implementation of
> `HasWork::get_work_offset` without replacement; an implementation is
> already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> `HasWork::work_container_of` which was apparently necessary to access
> `OFFSET` as `OFFSET` no longer exists.
>
> A similar API change was discussed on the hrtimer series[1].
>
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3=
bf0ce6cc@kernel.org/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Seems reasonable enough.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> ---
> Changes in v3:
> - Extract first commit to its own series as it is shared with other
>   series.
> - Reword `HasWork` safety comment.
> - Link to v2: https://lore.kernel.org/r/20250409-no-offset-v2-0-dda8e141a=
909@gmail.com
>
> Changes in v2:
> - Rebase on v6.15-rc1.
> - Add WORKQUEUE maintainers to cc.
> - Link to v1: https://lore.kernel.org/r/20250307-no-offset-v1-0-0c728f63b=
69c@gmail.com
> ---
>  rust/kernel/workqueue.rs | 50 ++++++++++++++++--------------------------=
------
>  1 file changed, 17 insertions(+), 33 deletions(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index f98bd02b838f..d092112d843f 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -429,51 +429,28 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bin=
dings::work_struct {
>  ///
>  /// # Safety
>  ///
> -/// The [`OFFSET`] constant must be the offset of a field in `Self` of t=
ype [`Work<T, ID>`]. The
> -/// methods on this trait must have exactly the behavior that the defini=
tions given below have.
> +/// The methods [`raw_get_work`] and [`work_container_of`] must return v=
alid pointers and must be
> +/// true inverses of each other; that is, they must satisfy the followin=
g invariants:
> +/// - `work_container_of(raw_get_work(ptr)) =3D=3D ptr` for any `ptr: *m=
ut Self`.
> +/// - `raw_get_work(work_container_of(ptr)) =3D=3D ptr` for any `ptr: *m=
ut Work<T, ID>`.
>  ///
>  /// [`impl_has_work!`]: crate::impl_has_work
> -/// [`OFFSET`]: HasWork::OFFSET
> +/// [`raw_get_work`]: HasWork::raw_get_work
> +/// [`work_container_of`]: HasWork::work_container_of
>  pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
> -    /// The offset of the [`Work<T, ID>`] field.
> -    const OFFSET: usize;
> -
> -    /// Returns the offset of the [`Work<T, ID>`] field.
> -    ///
> -    /// This method exists because the [`OFFSET`] constant cannot be acc=
essed if the type is not
> -    /// [`Sized`].
> -    ///
> -    /// [`OFFSET`]: HasWork::OFFSET
> -    #[inline]
> -    fn get_work_offset(&self) -> usize {
> -        Self::OFFSET
> -    }
> -
>      /// Returns a pointer to the [`Work<T, ID>`] field.
>      ///
>      /// # Safety
>      ///
>      /// The provided pointer must point at a valid struct of type `Self`=
.
> -    #[inline]
> -    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> -        // SAFETY: The caller promises that the pointer is valid.
> -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> =
}
> -    }
> +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID>;
>
>      /// Returns a pointer to the struct containing the [`Work<T, ID>`] f=
ield.
>      ///
>      /// # Safety
>      ///
>      /// The pointer must point at a [`Work<T, ID>`] field in a struct of=
 type `Self`.
> -    #[inline]
> -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> -    where
> -        Self: Sized,
> -    {
> -        // SAFETY: The caller promises that the pointer points at a fiel=
d of the right type in the
> -        // right kind of struct.
> -        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> -    }
> +    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self;
>  }
>
>  /// Used to safely implement the [`HasWork<T, ID>`] trait.
> @@ -504,8 +481,6 @@ macro_rules! impl_has_work {
>          // SAFETY: The implementation of `raw_get_work` only compiles if=
 the field has the right
>          // type.
>          unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_=
type $(, $id)?> for $self {
> -            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> -
>              #[inline]
>              unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workq=
ueue::Work<$work_type $(, $id)?> {
>                  // SAFETY: The caller promises that the pointer is not d=
angling.
> @@ -513,6 +488,15 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crat=
e::workqueue::Work<$work_typ
>                      ::core::ptr::addr_of_mut!((*ptr).$field)
>                  }
>              }
> +
> +            #[inline]
> +            unsafe fn work_container_of(
> +                ptr: *mut $crate::workqueue::Work<$work_type $(, $id)?>,
> +            ) -> *mut Self {
> +                // SAFETY: The caller promises that the pointer points a=
t a field of the right type
> +                // in the right kind of struct.
> +                unsafe { $crate::container_of!(ptr, Self, $field) }
> +            }
>          }
>      )*};
>  }
>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250307-no-offset-e463667a72fb
> prerequisite-change-id: 20250409-container-of-mutness-b153dab4388d:v1
> prerequisite-patch-id: 53d5889db599267f87642bb0ae3063c29bc24863
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

