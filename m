Return-Path: <linux-pci+bounces-15529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2ED9B4B95
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19E11F23996
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB81EB9E6;
	Tue, 29 Oct 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/1PBN+O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEA205AB8
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210369; cv=none; b=Txjm1KSjxPWWofJqJjxul0JXYLpUhTxaH2BUzUhyVymBBaTB//nPsNVBFDH4G7y1BOu1QFU7dYVRn9uqwznbOd61NXXSQVn7hnr1m7/hnMi8vF9+n+Bc0XDTlm+ZWBd7LRiQUY5ix/SRagUDhg9RgeUmU/7MD/OuF+lNzv+KO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210369; c=relaxed/simple;
	bh=HWBADJXnoh2NUNrdZ4R8VuuNYl1bmNxvyx9KhUtUxEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvQXxFF3fGhkXwpd5h7H28MATojfb3n76iIb9v4D31CVEFN4pkLvv5FyqM4anCJ8PIKNpMIAva+t5ddHN7OL3EQpffKBJN8dIs36rifLqqxFgOpjR8hMxJ1E1pe7yg4Tv7ZRGFydVzZVHHKwnpA1iemnte/nWrkghC9TCwqu4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/1PBN+O; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so71957985e9.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730210364; x=1730815164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0+r5DXauPWMBo80TC003d10oYhw7X04leDKPh0fruY=;
        b=s/1PBN+O4ssMce33ShcFRDVxgnF0bzyFMTPkXBQD+CHNpuVcPuUuWVIeFbSTQ2RKAX
         SzyfVCwgP9Gr6Pg6PF4WkcbBPDkpqXzHpLIp+XaOAZKHslD9yMLSO8njq8gWrrtDp20b
         FJBYhxAFMCe6o1QLNfDMRgaa51ritTL6O1Exth+2EPQ75ob8OOZ39+RqdTFbpYWkXjsv
         ZSMABo/ZMKJ4IFg+lSI2eA6UqEQQr2UI6VrBgva2iMmHufjp57xL/PCEJz4jkhV1HKFE
         5F4IVQrn3D0tk7wvtLul1Cti40IuvA1GDUxOTxTDsuBu0cdPxSfHiCAT3PZ6BvJNCBS0
         I59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210364; x=1730815164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0+r5DXauPWMBo80TC003d10oYhw7X04leDKPh0fruY=;
        b=TlDHiGXj9m+gHbyCpelHYQkYEGTLNyNM2hhOGnwZBxISwAOYD7QBb/pNu8/t3grk/f
         lPdLx+0TQ7eEiJam4L3Utu427Ylfu4vsXCg2Cy8gFZPJWiRRVOmGno/M3iMkw3K18AOt
         L1SlqgO15WxHg7EF4e4w0zyVA21C4OsCPPeai+8As0Dr5FAsenOnbMnZnr5Jeqt7P0h4
         /sFQK/WlUItc20RqpGmtpKCRpVMy664e+hGplXdprld4jrVUc9h3b49HhOFquCZzh297
         rbe8oCLx2CU5/xJT9RqgbwWZRDXQuCVcqIevix5Z1UpOl1jkqVdsecFEGLwd2pAD3yNr
         ZHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXaqldQZrI6l7T16ghNO2VaTW+ZNupBxv/plBOG1qtto67NdVA9uXoUjxzWjlznb7z/SGAjKm+x8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5cQN7hsFJIlN1dyjs0IdMktCubE+YQ6SVEYXKbW6QnecCdwd
	iPsVFXM2MEW7fLRHWx3dP6uhC9aq7+5Hp5QNcuBdbUiuiHwy6LP+h24mthhDl6dcDlkCV/I9r4L
	h1BwEr02ZkegvU+FIuUhMJ2dOypaNJiF07AY4
X-Google-Smtp-Source: AGHT+IHKguE544j9cYCAx/GnN3x2cBIU4yFs+FD0nSAsUtdOZzL/B0VKKdtS72gv2gH4vafJAmdHPLNGHnEY0QP/rKg=
X-Received: by 2002:a5d:56d2:0:b0:37e:f4a1:2b58 with SMTP id
 ffacd0b85a97d-38061172aa9mr11280347f8f.16.1730210364034; Tue, 29 Oct 2024
 06:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-7-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-7-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 14:59:10 +0100
Message-ID: <CAH5fLgji5SozS2Y+G16pPS3iiKnee-p94xO+uZZykTd_7EBOpQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] rust: add rcu abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> Add a simple abstraction to guard critical code sections with an rcu
> read lock.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/helpers/helpers.c  |  1 +
>  rust/helpers/rcu.c      | 13 +++++++++++
>  rust/kernel/sync.rs     |  1 +
>  rust/kernel/sync/rcu.rs | 52 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
>  create mode 100644 rust/helpers/rcu.c
>  create mode 100644 rust/kernel/sync/rcu.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 20a0c69d5cc7..0720debccdd4 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -16,6 +16,7 @@
>  #include "mutex.c"
>  #include "page.c"
>  #include "rbtree.c"
> +#include "rcu.c"
>  #include "refcount.c"
>  #include "signal.c"
>  #include "slab.c"
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> new file mode 100644
> index 000000000000..f1cec6583513
> --- /dev/null
> +++ b/rust/helpers/rcu.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/rcupdate.h>
> +
> +void rust_helper_rcu_read_lock(void)
> +{
> +       rcu_read_lock();
> +}
> +
> +void rust_helper_rcu_read_unlock(void)
> +{
> +       rcu_read_unlock();
> +}
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..1806767359fe 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@
>  mod condvar;
>  pub mod lock;
>  mod locked_by;
> +pub mod rcu;
>
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> new file mode 100644
> index 000000000000..5a35495f69a4
> --- /dev/null
> +++ b/rust/kernel/sync/rcu.rs
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! RCU support.
> +//!
> +//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdat=
e.h)
> +
> +use crate::bindings;
> +use core::marker::PhantomData;
> +
> +/// Evidence that the RCU read side lock is held on the current thread/C=
PU.
> +///
> +/// The type is explicitly not `Send` because this property is per-threa=
d/CPU.
> +///
> +/// # Invariants
> +///
> +/// The RCU read side lock is actually held while instances of this guar=
d exist.
> +pub struct Guard {
> +    _not_send: PhantomData<*mut ()>,

Once 6.13 is released, you'll want to use NotThreadSafe here instead
of PhantomData. It's landing upstream through vfs.rust.file.

Alice

