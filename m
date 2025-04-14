Return-Path: <linux-pci+bounces-25852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406DBA88A41
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D39B17B85E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AFB28B4EB;
	Mon, 14 Apr 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqa9N0Nr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE028B4E9;
	Mon, 14 Apr 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652711; cv=none; b=LBaHrUHfuPzLjnNh5y6CIep1ujtm8Xb1vxKJh/5X0JeXY8slfEyEtqnzhLzlgXdObP9QK9/6MiNKaKoWEN3YU8K0wYjXcbz3UgB2Kw0dN7/EDolc7mpEohGeuqWQTdoPMhNfmi9dp9OjwB71HDDD1LO04ZkJXT9Y/+MGqLLro4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652711; c=relaxed/simple;
	bh=M2AKqkaCjSql4LURtrMJTH44kcFM1m5wnz0bivArmL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBZbZzt26hJGMbmA6Y28kTmsBvFpaDt1pjG1haiKnGQUA+ITM1UzokWjm8tKeqadG0K4GlUjNz3kp8zApyaPWjtLKpTJjAHLnHeriyXa2tfqO3D2BtxHDcGKiu4vCAOfQWKynsrrbotqLs2i5cs5ucSa0pgSxUBpplu1EwE1hjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqa9N0Nr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6058638e87.3;
        Mon, 14 Apr 2025 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744652708; x=1745257508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2AKqkaCjSql4LURtrMJTH44kcFM1m5wnz0bivArmL8=;
        b=Pqa9N0Nru50Cb+Z2g6AZZ/QM+kG3C6R8T9KuPKTb7VG9HLoDP5LO3gJemmrDof965y
         jbhw4d5K0BwsZa/0vvbJiqsPLlzGzAu038+dePqkY/+VI/te8uTnBm3QVkgu6gNo4NYl
         be5YatTi9cYNiMCV49qkAV6Fj0xeL4IwVdT+wq9VFFdTYPQe92xw2+azJwOQ2jY7SMO+
         LFOSs/+GljJW9hZzU8cWD9Oq2y+iTi8AT8cxkF1ElfbeMUdCvVNM6doUUNj+jpz0FB59
         0Tr4xAQC/X6D4qc287CmqRYHGSfXsUOVpWuWWltvfgxK3l7eWJtx8VgzfSFFbcJB9p+B
         tYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652708; x=1745257508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2AKqkaCjSql4LURtrMJTH44kcFM1m5wnz0bivArmL8=;
        b=r4nbAgqQo1/TFLWdIszV9LaEgmpUoUj2joxndULZGlHkBFD8YBc/fGNTecR1WYBTyJ
         m0gTdL/fAVco5KkrLsNO08M8NMe0ghjFrxSDtvgP0jyNPChcgWBEp1sZotES4RV8ZM3/
         QBVJmz6PdBS6knOXZfmBHP6qdMU+U4Q5iM5pzjtSIizva1FGW1fPbjhbJI7ZAlpuU+hV
         x4RYeNbiEK8OUkhBVkIsteLN/M/O9U6zXPasvpos3IdNbL+PIn782ta0g7Pv9clJcnzo
         TNFDcs2FL1Iikz8cIQizO2eOF9puYfleYszFZyVU8p+2P1iX1I2C3NcnDRyP4GU/A+I6
         iNSA==
X-Forwarded-Encrypted: i=1; AJvYcCWfrI/hC5vIBz61vD69/QNi4ubT9TK1mZHMJKLi32xSpQgeAKS2zfVxurtT7TloEI90jkr3ZcUHzl+r@vger.kernel.org, AJvYcCXE4nJ/rmPHkVnqmWj7bMS3tYZLxIotO5pQrp6dpgtjUYOnLrqhROyPbH3gnA2Y2rtVMxn4sfdATDKWhe/2vqM=@vger.kernel.org, AJvYcCXw1vBlxPuBKZEqayq8Y3HgUUUDPMssUZcI+TmG+wRIZtCGf1X8pUzdYpSdFy8aIDocHDpoQcshTGG6Ozg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/WtyJA7VON+Rd4Ew38KMWi3bNTggMqCur9ltsDesji/o7MZQ
	9ALF/QEDoyB92VdeQMeCeVORUMg8oJpDgUAdMONI3B+LQ+Cv4QOjb3XwiMBtU2ZbdBdKqO+F0jm
	s/UbG0zaVSWO4plRLBYcETUJSiM8=
X-Gm-Gg: ASbGncuMNW3A3qS850tW8AVK8107AI1dlmxrtvgX9nmwP4F9y6Zq5RwbiwDJnyLuhnw
	JlRCPsD411aOtPuXxefu0o5ok4TEKMxqV2HoULBXbKcpaDt+4TBYCm0iUm3cjMzKvIjfghSnLIJ
	3LkQSfiQNb84t9/bP938keoY3V40P7CXe8Vlr4SQ==
X-Google-Smtp-Source: AGHT+IFlAX/ZVd2XkgfST9Qg2yZrfo/F9AQfOqBP+2TavGwjIcjNWxwASHKuF7mQUp9tETKQ9kI1BZJ5ZI1mBxMqQ2E=
X-Received: by 2002:a05:6512:b82:b0:549:38d5:8858 with SMTP id
 2adb3069b0e04-54d45298faamr3916877e87.20.1744652707674; Mon, 14 Apr 2025
 10:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-no-offset-v3-1-c0b174640ec3@gmail.com>
 <CAH5fLgg6_U4OAnDXy1eM98ur=MZonnDq3tk2o=KAf+YXNPtBbQ@mail.gmail.com>
 <Z_1E2z-l1xG--BSc@slm.duckdns.org> <CANiq72keUDCzhwW9E0aw-QV4ST7k3zqit1Ea=2yj2VdKS1ujWw@mail.gmail.com>
 <Z_1H6KkIt0YnkeLB@slm.duckdns.org>
In-Reply-To: <Z_1H6KkIt0YnkeLB@slm.duckdns.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Apr 2025 13:44:31 -0400
X-Gm-Features: ATxdqUG4UJH8DhoXgzxBjaf74NSn7cpZwQ9hhh65DHGFNp7n00u-q5jkDU5JVzc
Message-ID: <CAJ-ks9k2FEfL4SWw3ThhhozAeHB=Ue9-_1pxb9XVPRR2E1Z+SQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: workqueue: remove HasWork::OFFSET
To: Tejun Heo <tj@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:37=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Apr 14, 2025 at 07:34:51PM +0200, Miguel Ojeda wrote:
> > On Mon, Apr 14, 2025 at 7:24=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > >
> > > Please let me know how you want it routed.
> >
> > If you would like to take it, then that would be nice. Otherwise, I
> > can also take it.
>
> Alright, applied to wq/for-6.16.

Looks like you took it without the prerequisite patch.

