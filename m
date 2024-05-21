Return-Path: <linux-pci+bounces-7696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A488CA60C
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 04:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D70B282428
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 02:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFB6FDC;
	Tue, 21 May 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOOTuSvw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C928FA;
	Tue, 21 May 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716257272; cv=none; b=ng1bfk4LSGgCRWuvBOUtheZqxWUPK5r1o0Hiwx14lJ/hQo1usi8F8CSBFkwK7aXD5c09gnoifygY+Aoz77NzjGZiNhQJidq2mspQZOv9FxxSupbY9FPA9nc04+BKi7Hewl9cnljiQTnc4VsXqJ65fIJlRje49SNZ4vrissHyu0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716257272; c=relaxed/simple;
	bh=JnXg8pfJMHBGNLoBzZhpD7GAXHPrm5AeRP3V4PN1C7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVbx2n+iKZDWnLjwHq1WqI19SAfZJLmLT+zH8vCVuNp3ZK6BBVqTH6yv3NfSZefh3Kz5JK7eIFAOeDDEdm8H5a2/Vu1lsdkNqvP50k4+l7LKa0/XfMA9S7bzL8e5fW38oJoojY69N5YYwhQnRT9bMBmP1SEtlp3UnNr7hMQjDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOOTuSvw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so685949266b.1;
        Mon, 20 May 2024 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716257269; x=1716862069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JnXg8pfJMHBGNLoBzZhpD7GAXHPrm5AeRP3V4PN1C7Y=;
        b=KOOTuSvwIKh9FdFEdnDY/sNhfIr8LxEnZvq54+kSVPcIEG8aiiSqbmN1oTC90XHDyY
         5lD3B4ZQozFNg5js+1x5wTWnGhVaYvONC5dQLOHR6Ev9zI4kfmuUeAniEmWGAUKtIqMp
         03ePNYoXAXBVPFIZSXlkM3m/8rtA8hal+RlfYXc/m3SEOTczlS2BVojzjAVI3jdLBOU3
         +Br5MNgO+Fa2U7B8zwrEP4bmfSGV/gyOp77P8D8/sy2qEzlOEtke8DaxzLREI2MgcvzS
         BhuuH+N/N2lCJDjAig2V1mIrpYH7r8E6/q17iMsRWO6D9yNLXIg8/Cxy3bMvXkpGvTk6
         IW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716257269; x=1716862069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnXg8pfJMHBGNLoBzZhpD7GAXHPrm5AeRP3V4PN1C7Y=;
        b=TxkBnxXp06nxOxG1WZXYHpYn5ViK2q7dbb7zEtFkGh4bmJlw+6U1UUDNNsQncBolxl
         OPaFAJyfdIokOKgPZd4nAFunWWt5brWgiOrwkfyk/il5bnzpN8RnEvwNCiTEzwyTWCB6
         qd1b+70gO4r1Lk9seoOw3e32IGTMQgUvmPujP9GL/cEM0lahs400nDy7A9DxqA2V3Kql
         yS+f59c/pFSsjKXHZoDbj/pgXJLn0XVKy5+HlaWKurmbdE4deb0UA7XAJQf6SULM3FOm
         uCF7exakcuuldkrIBLZOWIAwHBXEuu1N3Gj7IToZjP+4f2k93Zx8ZvmKZEnFL3INYMUx
         aAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUNbHUlGadPavN4PQBvkWuODFFRPSSi1nTzosUifSSIPJI/o6w5NomB6JrYbcNQKPW2Y1M8xfol+yNrfBQNu0utnzjxxxPJiR1y667twxun3aIIebRh1u7I/lIdpqb4R6ZmVSDS4Rh2Q6jpN1sDvcfELbmXUoKpGcw3++FuRjCnt4UfCjeaxRQ=
X-Gm-Message-State: AOJu0YzvWplndX5w//fj6Q+0Hh10cejBPoMZ7RiMn04oFCNEAo+KRjAw
	UOx0qB98y7xeTP14Bzp61SJJbyPjzrxDYi7QX5X33hTf8RyMIYQlaXye6mvpIO7d8wq+TrjblbD
	q5rQtZS8mjsqbJAsIHdhdoD8PsgI=
X-Google-Smtp-Source: AGHT+IEyaMlILGyj7b0QHHzQlhhrCIkJsgRr1o1ajs3mU8NpocESmuaeBvr/PGAxj6/AYqqDBCVaHxKYQ34DBG/DPfM=
X-Received: by 2002:a17:906:37d4:b0:a59:c28a:7eb6 with SMTP id
 a640c23a62f3a-a5a2d5c8bd8mr2104986666b.24.1716257269327; Mon, 20 May 2024
 19:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520172554.182094-1-dakr@redhat.com> <20240520172554.182094-11-dakr@redhat.com>
 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
In-Reply-To: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 21 May 2024 12:07:36 +1000
Message-ID: <CAPM=9txb5STBo05xiTy9+wF7=mMO=X2==BP4JVORPFAtX=nS0g@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@redhat.com>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Wedson wrote a similar abstraction in the past
> (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> compile-time `SIZE` -- it is probably worth taking a look.
>

Just on this point, we can't know in advance what size the IO BARs are
at compile time.

The old method just isn't useful for real devices with runtime IO BAR sizes.

Dave.

