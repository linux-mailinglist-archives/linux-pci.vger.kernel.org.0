Return-Path: <linux-pci+bounces-29758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE9AD9313
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E3D3BBC26
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE11E00A0;
	Fri, 13 Jun 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRmQyvx1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710420DD40;
	Fri, 13 Jun 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833141; cv=none; b=OVtf+jMM/XWQELr+iliLfqp51mDNi7zPD6PBadKYxxFV5bCHzUVSAYLfD6nOWkRij+ZovO/1/Un7nP0IZodtv3xMZOOGS8OzR9WDdoEAmY9eNfse+UDWnwurNndnwaupjARkDwRiiEUDqy5vdv19tN4etDFwEqGmimBA2s/TNMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833141; c=relaxed/simple;
	bh=S0zyK/GY1rA3FSqhRjuAct93VjLVuOwJ1yGwVpnbLUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fy7fc4Q0ioL7BVHXA9yM7jQ3jR6nHgISV3EFGkn6iC2qOjGdTqyDTGJejUeAKOJp390AZuNPoayxO1FJTrd9HawCXTAt8wMzHTNTUY+Or2m1Vs8B3y14pMTSOxOpy2dw+TJAm9U9wqUQaDB4EKcKygSyxLUdTcKrGx7gaHvyjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRmQyvx1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30f30200b51so23313721fa.3;
        Fri, 13 Jun 2025 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749833138; x=1750437938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0zyK/GY1rA3FSqhRjuAct93VjLVuOwJ1yGwVpnbLUo=;
        b=QRmQyvx1EjYmJnXVmqavghlbZ3WNFynCY/kMLRxkNMwI/6hN6JwQFYM7KFYaVXpe/j
         /4eexcSFetyNXGWuX43+sBx8XlWHXWo2uM/5++Gsf2TtUHaFratbY1VZaTXJ884aziMb
         qFxajJBxN5ZIidir4QKtX7BbfhkFYzYuViMXjX037TaBJedL/ZrynyCDfNZ2b9rT/40l
         gmzPIRTBdjSkGKuUSkmBucK+yF5EcAUWTF4U1QMv/Lxx0ZPrYDEZ98ZfZrw1yS+/x0uu
         MsfGy6jdXHaGW3PfCmWlyVlSAMd9KUXqM0KymZ8QbKeCv+eSJ/fTFbp27LDw1zP+7aLp
         gNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833138; x=1750437938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0zyK/GY1rA3FSqhRjuAct93VjLVuOwJ1yGwVpnbLUo=;
        b=W66fv/vXYDbzP3w2A0E29sB3pvXhSODTkz0/PNXmoYq0B/efuF2hHYz00hVj2XjC2K
         5ow3zDakj56oJCoyuAbY2nkJ/aOedfjS5zAtevF3fw3SUkteogVsyj4Jp7wygtyx80sy
         SWLSv5hN7qiVyNeeHD6oZlt3zn5Oze8FQKHt9Qxx3PEdgcOFHtZhMQksTWBEfaDpzP5o
         5YYjtWgKHryI4cLh/PJnWlBfKb2YE6bRnfT++pRHKT7UgRvnUXfJcHeRBNvlvo/ZZLf4
         Kug8QwmwPfRFqanPn1MkkWPhRTG7nbTDGoGdOOtbQp0Lwr+nrEC2uIC8C3mpPEhMLnxd
         fG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDPgfMAFVe28aBoflVnCgkymszUI2kYrxW9HeBBmEWrxqrtFpVvAM2Pm+YYYrVMFXhb6T2OAW3eOqpD98=@vger.kernel.org, AJvYcCX+/v1CEVTtqkDgi31Lsckiz6OxKCbH7LHa2RnbhrPCByT/+ECgyM93cadqSnnqhE0Hjrrj02icM9J5+B5N344=@vger.kernel.org, AJvYcCXrYnx4fBVXQ+MZB3r0sInCqxxa3ESHroPcNasMXIAwj2T3ICCnnoipU/+REfa2+4n0aA28nYZulvVh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhc8aQOHDRvPynIzXQkAaxqLJUISHz+RFzBZFnbJAuSd77XCLF
	jIDpphqYufRN72fUHErw0PlGRVwuzt9Hwj9IpfqvQj7GGgkQBuqtTnsPGxsJEzckCOX6jtCFQeT
	kXSlYcdnXHNWFZEdh1u5mcxEKsGivRuFt1aSo
X-Gm-Gg: ASbGncsJ8GPYwZVtsEYfqpu3qGbvvu/3NP0TDEPxw3DcyaxaoaJBCA04u7BFXWQ74Qz
	BoCgxDlFMbA7ZBs7+w91v8CSLPgf4LKto53buT05V3clAF9AjZqCYrDjNtzDeDFGAcM3W/+91ZR
	2taY/UY5i37sQoNBeyCbDD8hxEWNmgWCTcPspr3j961z/D638V5prsjoFqzPE=
X-Google-Smtp-Source: AGHT+IFMV9/Dsdhdbnvbfn5+xkOvEa6Z7kEha0BSODFi02M026bNUoCF60wCk4CTk28DH9/iZjGOtBsn3L7I1XSlBzc=
X-Received: by 2002:a2e:b888:0:b0:32a:8ac3:93f7 with SMTP id
 38308e7fff4ca-32b3ea562cemr9979901fa.14.1749833137656; Fri, 13 Jun 2025
 09:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com> <aAkoVfiZDAXdYxrr@google.com>
In-Reply-To: <aAkoVfiZDAXdYxrr@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Jun 2025 12:45:00 -0400
X-Gm-Features: AX0GCFvlR_lP-p0sk3-QO67Q9vxrmgVX-5FVQbNhAZfIbp4rOoPEVpF9GuPXBiA
Message-ID: <CAJ-ks9=vPJJ9H0+vCb9=5MwQavcYqvQQ3D+heFhE+xHW+kq=MA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rust: list: remove HasListLinks::OFFSET
To: Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:50=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Apr 23, 2025 at 12:30:01PM -0400, Tamir Duberstein wrote:
> > The bulk of this change occurs in the last commit, please its commit
> > messages for details.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> This works with Rust Binder and Ashmem.
>
> Tested-by: Alice Ryhl <aliceryhl@google.com>

Thanks Alice. Could you also review? I guess this still needs some
RBs. @Benno Lossin could you perhaps have a look as well? You both
reviewed my other series[0] which was quite similar.

[0] https://lore.kernel.org/all/20250411-no-offset-v3-1-c0b174640ec3@gmail.=
com/

