Return-Path: <linux-pci+bounces-29017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB366ACEAE2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 09:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E5B7A9E4D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991A1F4624;
	Thu,  5 Jun 2025 07:33:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605811BEF74;
	Thu,  5 Jun 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108806; cv=none; b=jiYNgXkx2+/WxHuxitwOisC3GseDmDpAFY6DGViO6WbN882V/XgCNjVQ3WFM63RxCebsUJFCsAmj7CLABE5jcGxC/dnny3qezfJlRrj1biY+ZKHiGhv8GLi8twH1COiuTj65pRkAlQiz+Dpz3oUpzwcwVkC3QsrRNEDHxg7EQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108806; c=relaxed/simple;
	bh=3HU5Hw5tR0oA02ajckSNgdgzpmuDD96VbblNWpCR6yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF+H7Uf66zcTyXZkyja2nRL2pBIf0rFesYeekBMYhNHhhqx4cEM6w8l6KkHAvZHf4g104SQtFsLuajPb87yBcmBRVU6CGE0Ke98jEhmYeRfEVLuwtaiK97mDBAfRkDKquGZbL9Q6lJRtUlLDX/Dx1xcV1/dW0qaK4A9EudWqfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-52f05bb975bso253513e0c.1;
        Thu, 05 Jun 2025 00:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749108802; x=1749713602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPXygViugK2qDdRyZqMS+7O5LAWGbwutgev5XJq8gb8=;
        b=asIflDm20qWZfcpmm5Fot/pQZY7LKJaTDRBjz36WhCC+A6VzKqtenP3lE181XXN1b+
         1/prCCFptm3yUkj6dW56q5nbFpF9ZuGrL+FejZYG7Ge3ed4ul2FN5XBUhONrjpbHLvPw
         XjcxoQog1GbWmqT5Xu37vx5UKNiL+qsaaw5W1XwmuzIFCh28bLjepwYIkA9AGsX4tyIJ
         slethI7gJDK2/Dfcej8LqyNTN07TQeLZCJL/XvPCsORBwm1cVTZ5OZAfcjJZWqeXOtFD
         QuNEI5p5rCK2YwgvM/4DGu2tyuJdjevLLGO8tgK7gIGI6xB/GvB+owFke9WuqU4v1wUO
         dXJg==
X-Forwarded-Encrypted: i=1; AJvYcCWEeGprwU46w9e+SAr0//xEBA1WUpUyoX93x8l8V9Q4KC53I+Ilg0DFX1EWAlX73/TZNwQ3RqaDWMup@vger.kernel.org, AJvYcCWKqGBceZhbcq+VCIM7morK6qrGNsucAJxLFbvIySAPNVg+DmLL5M29Qk4v4WVc7AixNnefxaThr3YR1RQy@vger.kernel.org, AJvYcCWcYJ6OhR2P+grSVZxpjd4mJAsRDQd3AOVoK0GA4paraFnneZ7ltWFYYQnkjVgFofrdriIUqpKRhpcB@vger.kernel.org, AJvYcCXhpozIN5Sg1ZZK6EqGZdSbm0heHOZB979Q0aGk5gGpsrAV/NanTWedtRvne064cf+jNuNKYs2NN1Wu0Ma7V80ZN1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qFkgJDiHLROufE5vbtAjg+y7cyJdsYbeIhMi6qZxfmfVtfFB
	YK8FjEObNhA6hp9T+fclP+K8LasWQyUln1TWhfcs5xxlXv4ErvR+y2ovj+szovPd
X-Gm-Gg: ASbGncu2ijzFz8kxEQhk60fKrd8wmiFB5UM2+tqhGc4OREAjBrvui1s0FVogT2PSKq5
	6E/Jrha/1CHxvAPukfYYhlBWxZqq8jyGb6XHfsTASM3YdCqOCbcUD7o86al+iOWAQV+6iTsjZ4/
	c4HPtQLi/Ff/c8ifpagLJxHNWkT3psErRpPqtgbklVrkTQSShtFQleUx4pqpFgzs2661xhIlk2R
	ehBiF3FDunKw//EEntp0JvNU2a+4pITnJgezvN+ldOCcb1ZgB0xgzjwUnmyzVPa87AMhEk8+FnY
	7R6QnGj4POv7GUh4TeChyKPn4+i56/9H3CO0cx9hfY6uUOChfZoBtwL+EisHTByJvdqdBLOaIGX
	R5qJurOywvkvl8XhZLGgmBemO
X-Google-Smtp-Source: AGHT+IGoPdAK7xoPICutFq0mu9VODkcVC0PSvVKCb9eCGVKQbdy9OnN4H9kVkO+cnJOGFBfaIXx8Ew==
X-Received: by 2002:a05:6122:658e:b0:530:626b:7d43 with SMTP id 71dfb90a1353d-530c73159a7mr5732695e0c.2.1749108801834;
        Thu, 05 Jun 2025 00:33:21 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074c32036sm12119147e0c.43.2025.06.05.00.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 00:33:21 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e5adc977ecso205167137.3;
        Thu, 05 Jun 2025 00:33:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp7BhIzJ4kpmBWwkYBD7Sm54Qa6BJfZmvXXileYEAEa/HbEeJvHgZUPsYqlVmcXdiT2yBqvLYjquC3bPpy@vger.kernel.org, AJvYcCWDOA8n8AGNC+XfFitmLEQTQQblMzRRYGE1g8q77/5Liua94NkYU4lMgqFW9f0gbbz9K2q9YnozjviOW5T0a7S8L24=@vger.kernel.org, AJvYcCWX5gykN777tHN0bIN9ptbKL/gALrfS7jhMD/bnRkhx2V2FZCmBgBIN0zc/82MgcJtDgGxYqTHeAU3A@vger.kernel.org, AJvYcCXbnLLNyenimupoyPba/0HE222yJU4nt5pcIZJK37DtQdu0OLZfoAmu5Hlrspi9kC0bpvjQYnkh6GwC@vger.kernel.org
X-Received: by 2002:a05:6102:1496:b0:4bc:82f:b4e0 with SMTP id
 ada2fe7eead31-4e746e4976fmr4848002137.22.1749108801250; Thu, 05 Jun 2025
 00:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
 <20250530225504.55042-3-marek.vasut+renesas@mailbox.org> <CAMuHMdUVYzaUyP=OUOST8SK66_BpubOh0WCXcaVWBy=RxBrquA@mail.gmail.com>
 <egtsvxsfc5c2s4hrwucsqk3s5dv7xsi6ghrnf6jd3mvf3zvskb@z7hvehbd33t5>
In-Reply-To: <egtsvxsfc5c2s4hrwucsqk3s5dv7xsi6ghrnf6jd3mvf3zvskb@z7hvehbd33t5>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Jun 2025 09:33:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEmGk0iE0vroGRWOwsK3+EFpbqzO-OH3aVDQTud3wVtQ@mail.gmail.com>
X-Gm-Features: AX0GCFtG6IELptLOfKa-AavRTgQeGCljZvKI3BSZXgMtp-NgzVLc1G-6_2R8iug
Message-ID: <CAMuHMdWEmGk0iE0vroGRWOwsK3+EFpbqzO-OH3aVDQTud3wVtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r8a779g3: Describe split PCIe
 clock on V4H Sparrow Hawk
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mani,

On Wed, 4 Jun 2025 at 19:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Wed, Jun 04, 2025 at 11:24:17AM +0200, Geert Uytterhoeven wrote:
> > On Sat, 31 May 2025 at 00:55, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> > > The V4H Sparrow Hawk board supplies PCIe controller input clock and PCIe
> > > bus clock from separate outputs of Renesas 9FGV0441 clock generator chip.
> > > Describe this split bus configuration in the board DT. The topology looks
> > > as follows:
> > >
> > >  ____________                    _____________
> > > | R-Car PCIe |                  | PCIe device |
> > > |            |                  |             |
> > > |    PCIe RX<|==================|>PCIe TX     |
> > > |    PCIe TX<|==================|>PCIe RX     |
> > > |            |                  |             |
> > > |   PCIe CLK<|======..  ..======|>PCIe CLK    |
> > > '------------'      ||  ||      '-------------'
> > >                     ||  ||
> > >  ____________       ||  ||
> > > |  9FGV0441  |      ||  ||
> > > |            |      ||  ||
> > > |   CLK DIF0<|======''  ||
> > > |   CLK DIF1<|==========''
> > > |   CLK DIF2<|
> > > |   CLK DIF3<|
> > > '------------'
> > >
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Thanks for your patch!
> >
> > > V2: Use pciec0_rp/pciec1_rp phandles to refer to root port moved to core r8a779g0.dtsi
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > I understand this has a hard dependency on [PATCH v2 1/3] (and on
> > enabling CONFIG_PCI_PWRCTRL_SLOT), so I cannot apply this before that
> > patch is upstream?
>
> TBH, this patch is describing the binding properly. So even though the driver
> change is necessary to make the device functional, I don't see it as a hard
> dependency. But since people care about functionality, if both driver and DTS
> changes go into the same release, it should be fine IMO.

Applying the DTS change without the driver change would introduce a
regression in my tree.  While the regression would be fixed in linux-next,
it would still hurt bisectability.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

