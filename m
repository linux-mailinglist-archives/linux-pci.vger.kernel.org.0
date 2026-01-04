Return-Path: <linux-pci+bounces-43968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C3CF0EFC
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 13:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 563903011EFC
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205C2FD1C1;
	Sun,  4 Jan 2026 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYnrZef5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7E275114
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529933; cv=none; b=qkmoGKm2ahdRQrQLYDXROVgzbUy8Px6LvkfI1SmbyfITqOWalguZW9as/ZR6hDid08T6JeeXrAyEeIq6MTiicNcKK9EoEBK4dnRXfpyRswDwYFsPMz4vmg0E8jH035tDM0PHeQ4/98Iw+a5xYeh4pIEGp+1N7lU1w9L4AaJMHa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529933; c=relaxed/simple;
	bh=Dy90ydZC3ZdcbNYymaJeHe32ZCOoMbKQWnBxgJoo2dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9KsjvPf4IQeQcL6fSYyTK7A4VrmKZjl6JGIMpSjptMsSO4ZBz0BitaOM5g7zhzLMMt3x2PXMtYJzHclVPtc73z1whK/+5mRvD+PQh5n1WuYN5DS4SHNWQgF3Atc0thvy7lkzmhdE9E9v5AhbfMPTIF7NLa+iq52FzOBWmKhb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYnrZef5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a355c8b808so13538365ad.3
        for <linux-pci@vger.kernel.org>; Sun, 04 Jan 2026 04:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529932; x=1768134732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy90ydZC3ZdcbNYymaJeHe32ZCOoMbKQWnBxgJoo2dw=;
        b=XYnrZef5SiRjdfVlSjbsm0xKJO6AZR7pKWMjZ+i2nXGx/tYfR9CMwHBro+pcFRI1ds
         Mun7eJtmiebrfnHlWdTIesSIsmwegkgq/VJiOjnG7RlrduCxzVMTG1Em+Yai+RSLZCCa
         fyDni8R8m7oz57kJLFSgapQO0u2wpvbwa52Gjo2zZh5dO57N6hC3asbpzIJnDLUTV/TW
         7Q9EMjDU0JozzTj7IOZmcxIEU4gqnyDQLcXPLHLAlnpqRFr66gW4NmznU5uzwfVMRcrr
         KjLxkOPTQzEGr5mN0uYvgI3OPRxc+M7fz0neo0ItO+E9VvBJaWaUDD4wgiksdoZc7wOA
         Eh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529932; x=1768134732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dy90ydZC3ZdcbNYymaJeHe32ZCOoMbKQWnBxgJoo2dw=;
        b=Jrdnc9/XJ1mvOi+ibH0ihd1xlY9EXiSKHnBS1b9Nua42tQ/nSLxedWouKKmMI0c/8h
         T2PwTYQEdfVgCtiIxzfuAF2ymQsJtfrhMrLI0dlaveplG8E4OViYYXxfFPGeOn3O6jQR
         pIuTAOAA6ecPSepizmGMtYVAacK04N5unKDpOVQ5vBMRQL1D+C6dCibcPqeT9HZYoA00
         n925Uf9nDqdMcLxkFhSpNXrxY39xnvghJIY+wI9n1igL7v3zKUDtotfBM9t9AYfNrFPg
         C965lG+eQuMYrhNftOKPXZ10lcfhouKPDxv/KmrRndODE6om2s1dsJIcIbNmLSmjl80W
         bcTA==
X-Forwarded-Encrypted: i=1; AJvYcCW9qrn8RUG+yvxlpzMduwRK80XxpRC4uKntmQt92ALRtobXtxR0wSqia9xEE1CJFLnGhCHgbgnak6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtjuf5rKWDAtOUZxuuhBPDxl6j5s/MQ1gfrEpRgRoC4W/Zgvb8
	7tVLTp3IFMQymYfXabgt5T2vyIpvZNxXYp1TeLs4lZ8XQ0kcNeAUEsoiSYfTgCicMEUCR74uwBD
	nOA5fclu5PtS1FYQOE0GQ++1nZ7jXXik=
X-Gm-Gg: AY/fxX4Sjdpwe0E2LqMqVeU9Cpwbrf53Tx/ckBvfdls6S3KXt+kQZn87iI2/xVqGOmv
	xQ12rcImDh332KG89vWBdCckoNRaMu4dxeXtbpQUrec95rZOwHfDzVO0WU3grHS1odFoiq33P35
	YWXdCEqq2vYLdyYoLZ6jNWWqYL0vA/MR5Wu3Vb29/d/Vc1U7H0rTQ6RgtjIqXavBbKQkbh+T2+h
	SDkuCRZ54KH6zRyCFrWS3gvbl23/7s5IJFNlE3iXjnpZSFZVdvLnK/x56gRUHkRiDMNyBJLYaBw
	JCq5kUKgS//LcLq33/lZvYeEbWi5QwRgH+PlkTzxLUbDDRLcMI2QJENXeB74LCEEMBYrBeJqpM6
	4vEsFF6bC34MA
X-Google-Smtp-Source: AGHT+IHf7KpKpbJjsjinhofN56soZ+FW9sI05KvxZsvyV3VyGs2GMrGDywwEqQ8lvklCE76LNM4JtlcDP8BOPIC6r5o=
X-Received: by 2002:a05:7300:c695:b0:2ae:5f73:1968 with SMTP id
 5a478bee46e88-2b05eb7b6d1mr16001886eec.2.1767529931694; Sun, 04 Jan 2026
 04:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103-add-rust-pci-header-type-v1-1-879b4d74b227@gmail.com>
 <DFF1Y5LEQ85Q.V2AC0R1EFXNZ@kernel.org> <CAGAB6648kOCF4GZV=wKUxEptzW_91BySPMqFSjE+L-TA3ufH-g@mail.gmail.com>
In-Reply-To: <CAGAB6648kOCF4GZV=wKUxEptzW_91BySPMqFSjE+L-TA3ufH-g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 Jan 2026 13:31:59 +0100
X-Gm-Features: AQt7F2qedD660SgLCt10xNgjysXE_wVd0hQW4dUtEw9YoI3cwjDMZMBc39nOS2g
Message-ID: <CANiq72mAcgoX9RtM1qZCQNeNYRJQ0soy3G6WFa0ELFGDTGRhjw@mail.gmail.com>
Subject: Re: [PATCH] rust: pci: add HeaderType enum and header_type() helper
To: =?UTF-8?B?7ZWY7Iq57KKF?= <engineer.jjhama@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	SeungJong Ha via B4 Relay <devnull+engineer.jjhama.gmail.com@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 4:39=E2=80=AFPM =ED=95=98=EC=8A=B9=EC=A2=85 <enginee=
r.jjhama@gmail.com> wrote:
>
> Yes, I am currently developing a Rust-based driver for nvme and ixgbe dev=
ices,
> which requires identifying the header type to check compatibility on
> initialization.
> I sent this patch first as it provides a foundational API for the PCI
> abstraction.

In those cases it is usually a good idea to show the initial user of
the API, even if as an RFC patch, typically as a final patch in a
series.

Even then, landing the abstractions usually need to wait for the
concrete user to be ready to land, depending on what Danilo et al.
decide.

Thanks!

Cheers,
Miguel

