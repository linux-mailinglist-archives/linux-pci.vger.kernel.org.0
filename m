Return-Path: <linux-pci+bounces-43708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDCCDD918
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C064301D649
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D44314D1D;
	Thu, 25 Dec 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+i5DDdb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855082F1FDD
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653818; cv=none; b=k//ha76uuwAw9t6hWfnga4TOLwdCk6Wz9Bwg7WixJnvPl5lM8gWCZH5Bg37vr3dx73lS9V+jm8KHezN+CN8XXqUoBETVUyeE+hTWJqvr7w3a1wZwyK22FkNaAE8/wdf301hkSoQQSo+5cuUdSZOv0iO4psVBPOfASiElWTKtQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653818; c=relaxed/simple;
	bh=fidimhvskzenC8vv31RTcoVsNcs3n7YKe+cqigb2wvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmA1axSupax5xqFol5I8jBdSRkM5R1a59ynncuyD5uYQNoOBQSRHL0gzmTK3mH5/HxYIT9yeFjGGp+TlphgHJjtHTImOKqdOimP49C3IyKQ7iZbKzJNghQHPP8+AjxqaT96L/Y6gjdwpdcTGwfHnzWuvalJJUnSoX333OL+Da9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+i5DDdb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34ab4ac9a34so1035867a91.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 01:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766653817; x=1767258617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fidimhvskzenC8vv31RTcoVsNcs3n7YKe+cqigb2wvM=;
        b=O+i5DDdbAJJj21ZaDgaIHWMxgo7WgQrHK/VDvdHPlwrVYEXYmheYkIdx6Wqf9quEbT
         0cNfhZNnXQshmzjnmynSD6F6mdxSxt3jT3wg+FzRcnOmnOsQTk5k10t4RX55csB463ya
         a7PkZCqtUpgmLGEgV+tVX3+CF7N8d+9ZX3osT5X9mShw6Ho4a51gjYSrpBszaqiozH3y
         9ExPKtcLVYVmXStqBncpE4Fp5wgNSWwRw/KoTkqXZYqQxVq9RQNyjwNt3gzV9Fo9prjN
         L8kHpyYkG12Kj/Q1uGmBVfhBSG7plnviKoiOgnpInqabVxiEdtQjc+c6ZZQSurV4tyrF
         r5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766653817; x=1767258617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fidimhvskzenC8vv31RTcoVsNcs3n7YKe+cqigb2wvM=;
        b=BpQG+fy4XAQwgeQygzsS+MAFCa8zchhu/E9hj1hpFPC3U5lqGCR0syJiirw9QjpLVZ
         HAda8SS6/0x4IJEMbeXHBPDRJPrRDmCuvC0Gv+H3PtERXcY/zsCSX+MkQrv55Pbzbm9E
         QSaLWdH7/XXMbm2Y5N/8MnWrpYengS0M+45bBoGIXOlROoOGUwzpMcsOS4Ef7cwWvNjR
         FOu+hZjU4dGlG9bJDn9GDkqq1VQzbFNY66qHtPIIh4FaIZr0YDylr26tqIFZduWw6APN
         6zA8Vc8g+IEWU+Qx+QmS+b1nDiI4W7QP2qRYk0h3YkCXRS0A496HUYhE+C+wJ5+OlGrb
         bZTw==
X-Forwarded-Encrypted: i=1; AJvYcCW7lrTLuL0QJS66zp8DYkUiJqhyON3N0HWvQVCrKFRkNnxqKdv+ixn476Gsz1fNRMSUnXzelBhTCfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8iWT5p0MGtX9/jp+OOpgirUgnPhJ8zQBpDhK7rwWKDEXlxHU
	KSLcmfbpoP7W1g+/uzlBRwuru0nrOuLP4dn/XD/HrgvefFUiPrM4Bjz9WoYXftFiauDiBjNBRH6
	2CBiab8XOMgb0ymdvIqsAWIJQ4KbsG/g=
X-Gm-Gg: AY/fxX6v0woWV/Lsn+5Jg0Dc5fgP9B5Moq2BUIygVH8LGZMhpEOHWYPnRNxqFJ0L2v9
	HkhvmzqYHVNZ/0enp3kbDF06ImzgNhnX4tUpJOa8mQnaFrZHXIUFdlbfQ72LRzLspd4Y75bP1b/
	oZ4bX3w+EROyGw6Cc6j4gwWdbN01KeKjnMnxoLTYiBnV8yI7SAppW3xFgYAhV1a/TyCqXUCi+cE
	dvgsp2Vq/NIWILo0WFf/1fUcy/hKSrr34PDkfaAykEHcCqR01BIoe4uOJPp4Ma4VATkaYH8IS06
	fWQL7wGWSKlzeKafw9XS9yJYv2kbxLnnp7ZhdOj03ecLnZndxi2QvCWPcXi1ULh75IapPrTNOF+
	RilPhmcRu0cuw
X-Google-Smtp-Source: AGHT+IFcX1yBOStOKm5HdMQUD4DJ1B1ik5oviZQe1zo9UG/MP8cNODSPMd1h6tL4mWPgoT4qrIX/TF6a+BH8rDBCMsE=
X-Received: by 2002:a05:7301:4090:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2b05ec45daemr11153031eec.6.1766653816672; Thu, 25 Dec 2025
 01:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215025444.65544-1-boqun.feng@gmail.com>
In-Reply-To: <20251215025444.65544-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 25 Dec 2025 10:10:04 +0100
X-Gm-Features: AQt7F2o6kyHN8cKX_uujVj8hNOuUsXA5ClwSn19v52Gv06vvnfMS7OSidQW-HuY
Message-ID: <CANiq72n1SX4OGFR4wNzurNX2RQki_ZmD13bBfywxxOEmw6cGZg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
To: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 3:54=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> is disabled") fixed a build error by providing rust helpers when
> CONFIG_PCI_MSI=3Dn. However the rust helpers rely on the
> pci_alloc_irq_vectors() function is defined, which is not true when
> CONFIG_PCI=3Dn. There are multiple ways to fix this, e.g. a possible fix
> could be just remove the calling of pci_alloc_irq_vectors() since it's
> empty when CONFIG_PCI_MSI=3Dn anyway. However, since PCI irq APIs, such a=
s
> pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=3Dn, th=
e
> more reasonable fix is to define pci_alloc_irq_vectors() when
> CONFIG_PCI=3Dn and this aligns with the situations of other primitives as
> well.
>
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is=
 disabled")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Related: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fuj=
ita.tomonori@gmail.com/

I guess it counts as a report, so we may want a Reported-by (Cc'ing Tomo).

Cheers,
Miguel

