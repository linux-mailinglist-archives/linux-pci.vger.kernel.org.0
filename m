Return-Path: <linux-pci+bounces-44534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E7D1445A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92EE314A089
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6F37FF5C;
	Mon, 12 Jan 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqo+LXfQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6D37FF42
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237439; cv=none; b=SkY7Z47tc3X5A8HfYKKXTanTz5Wsq7k68Mh5x4/OJsSP73nlHUq6GNRUUjqX7aBw+mD7fV6zSPSXARkzaTWDIXiCQ+Mcjj3/bCmvYWjY/6gYOnseSYN+864fw1d4JBuhJa3ViQkdezPPWrw4vCA9OkFlLGDa1mMmfFRxT6ks97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237439; c=relaxed/simple;
	bh=8Iy1IcR4WdDZ40F/cbvYBbM6qfiutOQuVhBz64JcOVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELYavdsv8NkXZq5UcUjEjl4IQogeyQXA987uJB5EakmfdwOVNuagAUfhf7oiMKymEcLCFwokA8LLDOJntilxzv2jeKWMpEnWUewignpm4JzDPpOxeL8y2Za3zgRP6gUfR2tn9YUC1a/VqVOiaJ2pg0Y7i5JSYaJh9X5BW9sJCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqo+LXfQ; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11bba84006dso564672c88.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768237436; x=1768842236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Iy1IcR4WdDZ40F/cbvYBbM6qfiutOQuVhBz64JcOVc=;
        b=Cqo+LXfQ1Palutq8SbjzY8ad1fv78FgVWzJ1BV7bR8N3NhAulzvGcSl9t5iIMfh5sH
         Ztlr7gh4AIIZLgDG1iGY6RyjEvUFEtvInVOM55ryeyz5+7s6odX6SG2HN8EyiU0Jtybf
         BDKp3LCc1XvGZoxh9srOcpze3doZc/HejjhE9kzI4OeOmAIzy9+IbDAMH5/aafDQXbPU
         H33rXXpJND5kPmlLTPGK5slr/fIW5vVlptmu10qfldRzuNvqZKIntGjjG+Rmx6X5Lysw
         loQqlcNTMEWxE6+EoBc2n+/S5nwGWgtEtjT+M3VdCKpvHv1j53qxGAz896z3KNAo7JJf
         PX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237436; x=1768842236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Iy1IcR4WdDZ40F/cbvYBbM6qfiutOQuVhBz64JcOVc=;
        b=YIrX0kP2A63cVMmQphz2XYqldNCp1fQkVf+czJgUPltXAo/V/6Mkr0AyKhIN5UKnqa
         T+4vOkTkh4LabMlGOIp6W0N9TFkP63Vrp0HxybnpL3LGVAP9tuV1bzz6bcqB0ZgMx2Kp
         vfZaIaU+CIRqddeOr9xXNq8NvuDyYSXwZv65ZJ7WpY4SzDtW65B2GaaVYSXV7VJ3lrh3
         QN2ExCz1oUIvsUCBT1LtpMT/DthLwT5jDKtDo3thVPkYd5/gTjfJ9yXhSKiWLLO2C5C8
         /RZoVe1hj5aPTCzcPmu5t7AFxVaFSBjhjRjWPwYg0kztL9INO07FIj8sml1YYkTkdxZE
         zGMA==
X-Forwarded-Encrypted: i=1; AJvYcCVd8BBgyyaBWCRFpBMZRTt/wnCze95ukNYiHZa/tzO47Xl4cVp72FyWp4QyBXfPPlieTgTqojfgar0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4UfYozRb+l5VAuawKrLfZIWyq2CleTpXl2nuaQyRvpkntgvh
	rSlI/HLl32VZCp6EIf10idDHyKwo2PgZGJ0YWo5T7t63duQRdimzDy9Rqk+acJ8yFRg6yHvWAeh
	mMyqWmEnGkfl+NZ1hEGWhuT6x1mniPjE=
X-Gm-Gg: AY/fxX5fzXn/68zH2EpURF+wNuRD2Vj4fJReDnBmgi5Cgil7NiIyG9ZJmi99GayKD4v
	mXrhAnR/lck3EJcgKo8cWXXEzWUbq42tBWGln/4ey7HduGQuzsVOs0O6I1KUQyk1AX4EQrgLhuN
	m4yDksYA7CquPVXnnTbxSV2Kovs9RGm2ppnH2PaYnkOiZ9yoYbINmvwsTqlIGrrrywrQVqmdx8S
	jxCUcXpQqwcqmkEW0xxFyLbA/lXVJgB5wYdNAgH0VrJofpiBB7voQMAn77DkDAcjU8pMrToEblP
	tGUOrxrRHdDBLvaY9fXrgGOnTTOtoCHMq4/b4XpvnZNc9Nf5bNxK51BjafbhTdMNmLv/0xhMoEn
	AYs7zvlHWV5WA
X-Google-Smtp-Source: AGHT+IH3gHl2WRkpzbvqMnsr8nKEV/fav+2+W6EdkH1VggpSF5ZqGvrctMsTlSbwXPg03XsBfcCIM0QUSc9w9t6L2Ac=
X-Received: by 2002:a05:7300:33a4:b0:2b0:4e90:7755 with SMTP id
 5a478bee46e88-2b17d336a74mr6966704eec.8.1768237435657; Mon, 12 Jan 2026
 09:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226113938.52145-1-boqun.feng@gmail.com> <DFMR5480EBNW.2TGBZVU4XZ8U7@kernel.org>
In-Reply-To: <DFMR5480EBNW.2TGBZVU4XZ8U7@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Jan 2026 18:03:43 +0100
X-Gm-Features: AZwV_QiykkaHQuMOJgwclKcq2vfuj1usgpuYK6X9o-JqFIdMrA4xHt4Y0Ob7ia0
Message-ID: <CANiq72=sNPJjfR9Oz75qS_oUm3WNVL1Q1vtaBif9_31MhOdDSw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Dirk Behme <dirk.behme@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	kernel test robot <lkp@intel.com>, Liang Jie <liangjie@lixiang.com>, Drew Fustini <fustini@kernel.org>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 5:30=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Bjorn, I just received another bug report due to this issue. Can you plea=
se pick
> this up for the next -rc?
>
> If you don't have anything else to send, I can pick it up as well. :)

Ditto!

Cheers,
Miguel

