Return-Path: <linux-pci+bounces-19922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B5A12ACB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF823A63B8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE9199244;
	Wed, 15 Jan 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2MO15j+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401D24A7D5;
	Wed, 15 Jan 2025 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965376; cv=none; b=KwjMH5YMwVQAb1w8kER3J6vSaqTxrNmyNwqxHbAM5I1wQbbxGxS7feHbh3U1D0BO2uz/1LG4XFe+V2DWB8baKOZT2nTxtDGZfJxVEsJQKuMVWLjfL+bTNQRd2j0yKYbC8Zm0tbLa85Itkk/pclrmpGS8b6Z5f6j9Fq6IUQlLFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965376; c=relaxed/simple;
	bh=wtFOqkBVbdu6zNF6h4YnkKJZaUS0WkW/Wxv1qDA9ygA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTC7D1YHL4emieasR22UKx+sstgfEm/fUu1W5mufPUnAiU/LGaBDZExihjc5yaW+myWUTR3aD6oApdo/Q5700lc5tcPkEU2CykmIxF5jt3sVzxQM84DhCGh4eN1Y+mI2pZhtvZ3o2F02U1Gcug44EM6haogjEz/c4vpJNpS8YL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2MO15j+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so53764a12.2;
        Wed, 15 Jan 2025 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736965373; x=1737570173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtFOqkBVbdu6zNF6h4YnkKJZaUS0WkW/Wxv1qDA9ygA=;
        b=R2MO15j+VBYNeZPGQDw+4s6Dcmc4taiWJ2IHRZ1txxCqyHfW/RcUm8X0rc5say7Fue
         QlwmcFMmeyVRVU63WikdxEzT6bfILzRu/WgxDcIE9PrhU+tHuHLrJasqzrPHKRW7gUDo
         vWNil1mpW+gPPzwyiZpxGxn8LoHWn+iHInLdMUdvtxBYPGCbUSg3hxwrVjZcvZrE16vb
         wcJoNhsDIwncWvFo5o+ynH6Tiro3+IJ02/dh4lKwQeSAhYiHGn23dKL4UAqU8p7A/LgJ
         dfKX8lP1u1iRpXmZ6136EQQddeKv8dw5im5AB7/IUWsJHG+Qc9XShFj73cezPWtq4bE0
         Fsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736965373; x=1737570173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtFOqkBVbdu6zNF6h4YnkKJZaUS0WkW/Wxv1qDA9ygA=;
        b=oiXF4xacgbj0ZnIvi8HvnamjHHVde9bDqnKE03+Ld2/gidbtcN5XqAskn1i+Ij4LH9
         XLCnygSjmhRmk0LZ0OhRbTCK6d7BYTtBVVOiLDA9YRiQDxmktkThUiVEQRRYyPnCk1Jj
         cJAVQI8ZRecYRaH1q4J+CMu0CGQnSge3cD0uyUddDwt18mKeQIZseaPYClZizpZwno/D
         MJAjOhQ+MpLdqTcDFA2VQ6Ow9Pm3Bz4lbt7GJ4zI8Fly4qf9q19Lr5Ax78mAxTsJahw1
         e8ulrBt+QpCfrnXENRpMPoy5nZXCv5d0T5fodPCXjs7iLW5RKqcd8Qv2/8YdrVTht1Dt
         ouAw==
X-Forwarded-Encrypted: i=1; AJvYcCVpxs7w291b66B+pwlvdy5XuvxYUabmiNWeCftNoNFzu4ImOepSeSDAfjdv8tvfN9S4ImcLFqjzP2Cy@vger.kernel.org, AJvYcCWF0c3EQrwm2IuiBIhfn31l7S9fj6y8MG1pjSCgE6xMLty9MrY/Rh8HFFLgugNVAqxGtkCnZGaX4GlQIco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyblklhnOebYAvpTsVsrZ0dvbYiKxhC4Vcc3RTJMGn/nOEETNP
	T5of/hD17nUwXrNPRzKJ9pWCC+rxrVh6fZGHQZAQopF8OfCxvqByHWSO+8i+w01JSBqOG0p0YXQ
	UHhjcO+UmJcxVMKkGw/+u6cnGt3A=
X-Gm-Gg: ASbGncs6gMHfa7hFSCzBqor4FNlhIuOLzmSb2HE6DbolBFkOWv8IGsyFiEt6tCgkXZB
	2XTg1ELDKjo+UKZVEaVp7wP2DajtlwnAfMciXBw==
X-Google-Smtp-Source: AGHT+IH4ZBPCX1+Zs+u6aD4i/Mk+EEOp4Zxu5uuiRB2111BunzMgKFahuNg0HGJ0e/tCZoud1qbk+dK1yM9Wb1ed+A8=
X-Received: by 2002:a05:6402:4023:b0:5d3:ba97:527e with SMTP id
 4fb4d7f45d1cf-5d972e47717mr27159444a12.25.1736965370851; Wed, 15 Jan 2025
 10:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115174012.bdny6nxxr4tuzyis@thinkpad> <20250115174834.GA538101@bhelgaas>
In-Reply-To: <20250115174834.GA538101@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 15 Jan 2025 23:52:33 +0530
X-Gm-Features: AbW1kvZ50fXNCVlx0U9GjzuVih3n2_IhFXemWMJd-_PuYqVJD6pFzYzcMcNZWiA
Message-ID: <CANAwSgQ2-r5gHmNwf9YTWXEU-mQ6dVpjFV4gzM+sVGsTUit7ew@mail.gmail.com>
Subject: Re: [PATCH linux-next v1] PCI: rockchip: Improve error handling in
 clock return value
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mani/ Bjon,

On Wed, 15 Jan 2025 at 23:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 15, 2025 at 11:10:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 06, 2025 at 09:00:38PM +0530, Anand Moon wrote:
> >
> > Subject should include the word 'fix' not 'improve'
> >
> > > Updates the error message to include the actual return value of
> >
> > s/Updates/Update (imperative form)
> >
> > > devm_clk_bulk_get_all, which provides more context for debugging
> > > and troubleshooting the root cause of clock retrieval failures.
> >
> > Btw, it is not just updating the error message, it also returns the
> > actual error code.
correct.
>
> Already squashed into
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=abdd4c8ea7d7,
> sorry I didn't mention that here.
>
Thanks,

I will focus on improving my communication skills and delivering impactful
commit messages in the future.

Thank
-Anand

