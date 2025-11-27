Return-Path: <linux-pci+bounces-42217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F23C8F4B2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F723A7BE0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34BE3375A0;
	Thu, 27 Nov 2025 15:32:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4133711D
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257539; cv=none; b=CoGO252oqyxKCeojnrdjTuIE6P64FbGLcv59ImjCWDG+Zmy6YjPxTNEMkSuLAq1VgHh719+BpnM0LO2BtUdSa2t/DmBu4l7oCqY++ydvj8l+GktYdaxHys/HqA//h8dKYlouTEnnfjN/4qgeFig239B2sSRJgaTD50oDhcJ0rVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257539; c=relaxed/simple;
	bh=sHl5pwlmEItohvFZHZI1KjlDkMBVN2T/fYskflBGJd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaDIkzdBdeFNKEHZdfdKXbg1Pa0GL7lwmfe2CXnrm4MMsFt1NNdlP9DeNlZ7TR0Xr2Cs0gn6pxavkG5jZg641OOBI2jrz5o10Xd5jb0CCCU4rVNbaeEUqEWkgPlg1iV/MHPfGni79cg8qri3gbaN9uZuQ8dp7p7aRU/qWakkeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93516cbe2bbso273336241.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257537; x=1764862337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrz1X36yjHl1z7T/FMljFcnnUdnxdHtX5H28vUmRBT8=;
        b=AiRQDhC36LGhqGX1fzRNPEeHuiwpr9vqZM7vIg3UiWwOzg55AW6tjhQWixQPig7NIl
         xs6LzmqdYyfBasr8HflI+I3zB0k7q0kumKMg+FbPoMDHjh+4snO0cXzS/uiz2hauYdxE
         N5gVg8pU212fc/sV+vjofNG29PQxaERusBAlZA0I8rhEg4ND9xG0TqtevvKqQnmv2nwL
         XORvM0cbidjHYFmTCPtmRJ5PalDiGMJmtRXuYV6whYX5MARg4M1QpjVzcBncDeKCUdrT
         uoqCYpc9xtf7iB72y1EKRnQ66rFr5j3pusCc8tZRuQvrBGmJjtcbDvbFr1IQrXcvNJJY
         eEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf5kr/xerjw5476l7+nE75KNnwd/WQs+0RspZCLMIcdFC7MLgbV39Mhrx/zA8MyzOBTpeTq+GIGq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xX/EWHGxg30S9FKA9ai4UFFZHPuYsc4kxG2kd5Tm1CdQeKfw
	J74qchHLvnjMunFFn0KnJwEHnxHuvqB2KGqSEnv4U/6uhPtY1yV9pT7OaiwNrC+G
X-Gm-Gg: ASbGncu4TDLiM36X1u0PMYRYMSJksw/3r3efSMMcCIrhDEhm/pp8YOtPpOo0he8ix+e
	k6BaSbHIfYA7dval+hxK+oy7R80SzGQsx3KXXkmsKceQxVOxX7BRSwtkUjggOZNyKSMgWp3GnA1
	M6m80S2wpWDECwiVlwOXcWA2L3wPdJ3BayX2uReo5E1RCqm1fhl4XQbEGWDPRa9K1IRdm6gqn8L
	inIq3tBuPmR3eNyrI6/bunL4Hin8Ep3iLk9b0bJ+0YvYtiRqNZM8uJ2K0dCCSVHpb06IdzmzEYV
	0W8xnItnPn7h7i8QHSt/BuVE4f88oecAGuIfibf+nkE9zF+KTXrlKxlhLvrXhTHGz46mdiqwuie
	o+S2e0nCsB19jOSzw+8VQoGwCfoTJQUtsrtgkfHbE+9nSoLNFM5Mfj+7i/kajldPm72S7JVtT6E
	fIEqGjP8XRCUkYMvvCjyK6jpWqdvxUQdd2fRJRnAAbxF0WkJCu28I+qQ5PI8Q=
X-Google-Smtp-Source: AGHT+IE2fuTJYGxsbVVuA82+lhEvCCl9MY2zWLdPL0Xp+XQlW5+c2CbTYR32YfDRdjQxVHakLvlrIw==
X-Received: by 2002:a05:6102:4411:b0:5d5:f40a:4cf1 with SMTP id ada2fe7eead31-5e1de2f8e05mr6751201137.24.1764257537012;
        Thu, 27 Nov 2025 07:32:17 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd75f3a59sm675073241.11.2025.11.27.07.32.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:32:16 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so362557137.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:32:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXg/Fo8fPx2AEV4z/zsHXW9WYA6t52zSGivEqQkYzylwopAT7cIA3k5x6wvYBPWpyhMAjp4C7cMhis=@vger.kernel.org
X-Received: by 2002:a05:6102:5107:b0:5db:ef30:b74f with SMTP id
 ada2fe7eead31-5e1de0c07b0mr6881793137.8.1764257536406; Thu, 27 Nov 2025
 07:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-7-claudiu.beznea.uj@bp.renesas.com> <c24nuqtczt2jxekl67boramlgullnxftwjfjlwcjjnyv47ykwc@tlpojiyzdk6r>
In-Reply-To: <c24nuqtczt2jxekl67boramlgullnxftwjfjlwcjjnyv47ykwc@tlpojiyzdk6r>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Nov 2025 16:32:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBG9VFJsm6mMAUDev2d_+2xta74PwN791_NV-=rZhyHQ@mail.gmail.com>
X-Gm-Features: AWmQ_blQk_Z_QzvT5Ty6xKUF9xdppK3UfiIhR9w996WFFGRzUjAlrY7O8yUugfs
Message-ID: <CAMuHMdWBG9VFJsm6mMAUDev2d_+2xta74PwN791_NV-=rZhyHQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] arm64: defconfig: Enable PCIe for the Renesas
 RZ/G3S SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 06:55, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Wed, Nov 19, 2025 at 04:35:23PM +0200, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Enable PCIe for the Renesas RZ/G3S SoC.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thx, will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

