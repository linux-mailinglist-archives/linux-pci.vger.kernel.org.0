Return-Path: <linux-pci+bounces-12012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A195B7AB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B5A2877C5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62231CB146;
	Thu, 22 Aug 2024 13:52:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49171CBEA3;
	Thu, 22 Aug 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334727; cv=none; b=U4Q+K4EV52DGGn+ZWdrcdOdKfcOyye9J8ygYPF1HmuQ0FkTIE4VUGKBtAgiWkJ/TJmROFNGr5kuiLW043mEKtHqv7oRzcfqASXK7SegiZ0IYrVLoxp3h5Az2n/02OFMhxMMJwA052q8R+FRTg52a9ewX2G9zlzRpkrqpOtfIO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334727; c=relaxed/simple;
	bh=cdP8D5nOdLPPqQJ415/Y3P9x57hlsKwciShZAY6k0fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C39KJU8jUOszdouLp79eYfMkeiuZozxSOUDbmKnjY/cH2bB4/6Fjkh542e8vY+i/uJCqZUyN6Zz/R9d+aV05024rtqM35CpLJVzIJBo8FYdPm9qXfNGA/TavRPC2Er8JfDLtXLK++RRmQYwg9cwv0ym+Shd2LAqxoz4rblkhOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690ad83d4d7so8452357b3.3;
        Thu, 22 Aug 2024 06:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334724; x=1724939524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy8XZgRrIJvytnwUd2nDpXU7XiqXEXvxmbqA0xs+lHM=;
        b=kT8GAPI+UpXSOHcJQ1rx8MOzTDY7xxL4veCQoxkATFnTXUTIaZTLq9XALH98MM/opg
         V0eC8U2MAtJquCPZM7ggyi8W/ASgJvXGl6qKanL59rawv9FOaP4AnIsy/KjPdCsL9+eR
         RETDiK26QIDm0Ttd0ZUBEQfL2vc8kxBxdBObfUZVw8BbIT4oOI0R1oxL6Yx/x9UyoOqe
         l7RoGRKZHkf+A9YqBIF5ZYscsd3oJZNw9caJr9+JBoMqXXqoOuEFsmuaU1op8OlU/y+o
         e2q0FYRftE4CBhwkjhfqFvpjJkWTdf/6sSM68SxeJ2ccZuuBVOyHqz4gZG8F1BAFwthA
         dYkw==
X-Forwarded-Encrypted: i=1; AJvYcCUTz/ZWJraT3NH0eQnmzIEYytoSLqQsu66P152cf/20T6dAmgMd/cVSHYTN4YUfnPgeJ2jnP4kRVYhn@vger.kernel.org, AJvYcCWCzkHOnA93Fgd4uH1OKDDVLc0pMJtvsEoTf+UMJp+yoLXaiIhiaEvL+TwxRUbU4uUsuDK901tAE4nwB25xA68rTQc=@vger.kernel.org, AJvYcCX5D+VtkqSVC32iX8RKYYBEGMXoGNthpa6EpLns3dGGmKhZHi7h1K/Go6pf7B+EE6gvwOddZrSiNhnf@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/FFc9qf2tRN/QkvxTj64wPqzxjvcRbeQOA2qb5XJJChPJLo8
	FxbRRY0BNkgvDZi7rrzFcdj/rVJ1XaCbcZ6vsessrzmZlUT1TfFzMJ3MRjs6
X-Google-Smtp-Source: AGHT+IGTRoy9b5/LHBYYF3glkoKHfLfqKMWCschMnwSPS2QIkNJtX0G+w9d4VzLWgQdW9yxhRW7lZQ==
X-Received: by 2002:a05:690c:ec5:b0:664:ce37:40b4 with SMTP id 00721157ae682-6c3d1a684ccmr24723517b3.6.1724334724199;
        Thu, 22 Aug 2024 06:52:04 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9fdasm2172107b3.76.2024.08.22.06.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 06:52:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-690ad83d4d7so8452177b3.3;
        Thu, 22 Aug 2024 06:52:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjo7WLU+31xXadApSlmzFxrhuA0qf01pmt6VFVMYuHOrIxBWDtaFS91tzukYJ/xXfQiQKWIuHLIGLe@vger.kernel.org, AJvYcCWRlcZjhUiZy29wmL1H5BL8DbAFigPyVLnPa5SoPFVVB2KGiwUhnK9UcW5LMK157OJJEWOTZ8XYRqU1sFHvuJki9mM=@vger.kernel.org, AJvYcCXP1pMzuBzmGdELE+IjpBQpJP6tu4awGQO0xpinZNUutRomiqWzvWCK8pd/Y4AiVxB/Y6x5L7e6O/9r@vger.kernel.org
X-Received: by 2002:a05:690c:580f:b0:6c1:2b6d:1964 with SMTP id
 00721157ae682-6c3d5fc1af0mr17320157b3.38.1724334723534; Thu, 22 Aug 2024
 06:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com> <20240822064459.1133748-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240822064459.1133748-3-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Aug 2024 15:51:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjmaRRf9rbKY8UYRrEx-BcKzC709f9eQowiwxAc_xPXQ@mail.gmail.com>
Message-ID: <CAMuHMdWjmaRRf9rbKY8UYRrEx-BcKzC709f9eQowiwxAc_xPXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4M compatible
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: marek.vasut+renesas@gmail.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:45=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for R-Car V4M (R8A779H0) PCIe endpoint module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

