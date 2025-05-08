Return-Path: <linux-pci+bounces-27436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4CAAF8B4
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862797B6B63
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A92221FA5;
	Thu,  8 May 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyXWj40o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE022154A;
	Thu,  8 May 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703617; cv=none; b=TJOeO8pEabWR33S5osvaIZ7HYWLveCnhygPz0aBPkYpXiXOfM0JxoG91EzJ0zIJPJ9D5e2BCw+2sZw60babFUs65zc9EbHWnpthDIxYzPaGVGTNA+L9IC7Ke6fOJYpojxp2JxQYlvzCVF3hjFMusvx8JuQE6bz3xLFYZTABy3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703617; c=relaxed/simple;
	bh=UwqdZjavUhNfdPs8P/IRq9MCV1ehSBWln2HaUUuXZ6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odEZ1OJhZxB4V9AG72RD/sKhV3+y8B6zRzGVFfi2+TXgj9Ucyz6kfm94gj2zPPECSLht2tikQ3NJv7K3N8D1hwBYrYjoLJ03ziTRGQ02wSh7aNKq5znQ9Efu5o/MvSd+pPJAqVqoH1HW59fG5LlEsLwy4ORrZSF2kw6GY4/uRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyXWj40o; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso7634751fa.0;
        Thu, 08 May 2025 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746703614; x=1747308414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwqdZjavUhNfdPs8P/IRq9MCV1ehSBWln2HaUUuXZ6A=;
        b=QyXWj40oehcBxrB6m9lBR2349UIrkWTWoWBMM4IpmENxk8r6tcPUj7ufAfkd9RyRvZ
         phvHloqHdqI8VK93XxPcl6tActizIBIJ3fINFAOqvYxz41igMaUwJAQP6BnBz3DL0nYY
         m0cDEwFwMllo++H1WmHcUrnv3kJTkxmGzliFRX4j8+Dc5c5eYJApeWXAXxP4PeQRrB/J
         Xn/soRaiQSo+IwdsGOJfPmGt1wH3bIlZt8W9K4s8WlcVtldCNvMPTdllZFAH3MpMVv/B
         i6v4IQE+1d2X8Q04gd3UkuQ0KVC+gNzw5lh0TAtAx5yAJi3Zw0PljLj938VGdQEeb9tl
         FQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746703614; x=1747308414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwqdZjavUhNfdPs8P/IRq9MCV1ehSBWln2HaUUuXZ6A=;
        b=vFgp+CTvZ9u5wJvj5Fi7/v9pqkGPC1Xo+hzN+sHQdXnLVMeUbf358gvpdYcMo77dtM
         YzxDYpbIhD24xSa+5pxwvMQcisl3nKukg1tSLcN2jF8sMqmm4zc4K0pjfrRxeupXCO6y
         KIXZfsxdlz/AQW689ej1QfZoKj0D7F9RWqK6LXDTwAAtai43euJyH30ncWI/Xcxd2Zqu
         lxRdnhPkvx3ALBru1tOSZwCtAMivH+QuLSHPSBgoE4lt99565rElLFktaV1SZzfAMIWX
         1oR3m9skQmknxQB6Sr4NDQplFqD9NTQB3bxcUXSL2M+1gZrCkTnVxbCLQNpC9+66EYOI
         xFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVbxNVZluDQfbm93jcKfD2qHLaULmYtTlEhGP+3zqg8tBRudtuYkGa92Ox5KuVZA3pqLAcYp7cNCnA=@vger.kernel.org, AJvYcCW5/WR5gVKQsnNJJteW5Co4n4nhIzMayHiFzCgotP2JTCy+dzBcS5k8KMjInPJMn+CYwkhr6OMIwVcokr0=@vger.kernel.org, AJvYcCWzRYiq3KOpAbxB4G0Q5htdvrTpSkx489Akl2Ujy/hdyUFaw/TxvCd2SZlQovDZQn2xU4pDk9zmEleUTAg=@vger.kernel.org, AJvYcCXKSK7KwGW/eqoVdh7FIuhamWqBFZaPxtA2Rd7bmfnLiCO1EDiSH9DOqfjE6ZkMm6yNtp33g+Mm2xP6@vger.kernel.org
X-Gm-Message-State: AOJu0YychMfHktFde8Ma4RGYeyRsblUj5AqdDpLH/NPODLQxQRRu0Y7w
	F4WBN9MWj8I/IwxPkrO8c+jy75qbTk733xG2FMFGgYQilKkLTsLRCLolTz57yruRmnSDro3FUq8
	/D7VtNmodKbT2AW90Rbrn0vpe7YA=
X-Gm-Gg: ASbGncvX2MRxX6P2eLRgOJA2STe1cES55c7iSWSVDCGdjU4rCEBRdvmd2k3ZX3+o/Ag
	aLEYJFD8XDSMegdpd2S6DlZ5krQxNl7hvQDVial0mvq8zifKdtP972QZEc79bqs+vnn5ASFYz39
	yq/mVZ2k5FnEZQRPlsSRcpBRs=
X-Google-Smtp-Source: AGHT+IEd3RTS5tFkCDfVtx+pBxGffB6x8KVD5klUtDaAhuxiIEXoPS9/TVA+TqNUh4Sdl/LHg54A08o0LN2KL3ISF0w=
X-Received: by 2002:a05:651c:150d:b0:30b:9813:b010 with SMTP id
 38308e7fff4ca-326ad32331fmr27545361fa.31.1746703613470; Thu, 08 May 2025
 04:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
 <20250507-pci-tegra-module-v6-3-5fe363eaa302@gmail.com> <w2ertcizgmtu27kcike3lpw5dvhvqi2b4c6amqzwdfs2xtebfy@itrpen3oblhs>
In-Reply-To: <w2ertcizgmtu27kcike3lpw5dvhvqi2b4c6amqzwdfs2xtebfy@itrpen3oblhs>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 8 May 2025 06:26:39 -0500
X-Gm-Features: ATxdqUFB97ndpbhzQ5rwxdLhAukeBPDgXsdzB0UK835iwPge0aY5C8MO-nVf2I8
Message-ID: <CALHNRZ8899t0BYMgn1a3iDKz_J9z_Wv_XYM2d8Y4AoiXPZaFjA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: tegra: Allow building as a module
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:40=E2=80=AFAM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Wed, May 07, 2025 at 10:25:54PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > This changes the module macro back to builtin, which does not define an
> > exit function. This will prevent the module from being unloaded. There
> > are concerns with modules not cleaning up IRQs on unload, thus this
> > needs specifically disallowed. The remove callback is also dropped as i=
t
> > is unused.
>
> What exactly are these concerns? I haven't done this lately, but I'm
> pretty sure that unbinding the PCI controller is something that I
> extensively tested back when this code was introduced. PCI is designed
> to be hot-pluggable, so there shouldn't be a need to prevent unloading
> of the controller.
>
> Rather than just forcing this to be always there, can we not fix any
> issues and keep this unloadable?

For the short version, see this part of the conversation on v1 [0].
For the long version, read comments on all revisions. Basically, I
originally submitted this as unloadable, but got told that due to
generic concerns that affect all pci drivers, including ones already
modules and unloadable, making this one a module would be blocked if
it was unloadable. Which leads us to this revision of the series.

Sincerely,
Aaron

[0] https://lore.kernel.org/all/4u4h27w77sdjvy43b3yonidhfjuvljylms3qxqfaqwy=
w3v32qo@kzgrrenxr6yz/

