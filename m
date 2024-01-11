Return-Path: <linux-pci+bounces-2071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D082B6C7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 22:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC4BB20BE7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F765813B;
	Thu, 11 Jan 2024 21:44:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE858200;
	Thu, 11 Jan 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbb4806f67so4241621b6e.3;
        Thu, 11 Jan 2024 13:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009458; x=1705614258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9527WbL3UHVjE0IkHquSWZsf0jL/XRwFPuGoiYaBzA=;
        b=Vr3Y7C5vOAqvfXPfSkBZfaS3h3UcsbbGnxmItJGgcswVw43z0qLWseWlJfn1OvWEJS
         EDmdRjY/M33pXYHtBovt8ynb8Zt0VgK2DB04Gxxqyc/m5PhMW/T0ahJNO1ouJ8Ds99mp
         Xd6zBPUgxvooSqMA40rk1tEfsPTOFam1Pydh1eRqAwS3+5A1KWdlb87+kT8oO0sAxMNe
         yZt01JFtaIuhEL+qYEmaT1HTecYrBwpu56LJfVVKlljDpjbZqJ4RDAWOiDwy+lwe2ovp
         r348NFro4lx0ain4ZJYwQsf3Yn9wjPtXUDG1Xy8Cllb0b9+hT5oDSxvLVxCdhqIe9y6y
         4Jwg==
X-Gm-Message-State: AOJu0YyhyKKXKTxpP5XQ3/bKbzFGTHp/wbvh+kS3jCkvCVJor3d+s8UE
	7/Dwx2YoZXJj1xfPpDAG2m9kY8Abm+CRMg==
X-Google-Smtp-Source: AGHT+IEJJ6RzZLxhRre83+gcPXtkyJG5JzAN+cbkrLJlK/Nj13azszg6b9uBTEvsP5Z9YfP1V6tRBQ==
X-Received: by 2002:a05:6358:c3a8:b0:172:de18:c9e with SMTP id fl40-20020a056358c3a800b00172de180c9emr507384rwb.18.1705009458436;
        Thu, 11 Jan 2024 13:44:18 -0800 (PST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id e11-20020a63d94b000000b005c200b11b77sm1698542pgj.86.2024.01.11.13.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 13:44:18 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3258370a12.2;
        Thu, 11 Jan 2024 13:44:18 -0800 (PST)
X-Received: by 2002:a25:ae10:0:b0:dbd:b56e:5e3e with SMTP id
 a16-20020a25ae10000000b00dbdb56e5e3emr310886ybj.83.1705009437049; Thu, 11 Jan
 2024 13:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de> <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de> <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
 <20240111150201.GA28409@wunner.de> <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
In-Reply-To: <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jan 2024 22:43:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
Message-ID: <CAMuHMdUnB_eGhzyOYRczXLMgb65dfHgwHgnv7eXSWDvOvTEdjQ@mail.gmail.com>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lukas Wunner <lukas@wunner.de>, Kalle Valo <kvalo@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Thu, Jan 11, 2024 at 5:16=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> No, it was actually a no-op due to CONFIG_PCI_DYNAMIC_OF_NODES not
> being set. But this is only available if CONFIG_OF_DYNAMIC is enabled
> which requires OF_UNITTEST (!).

Huh? Config PCI_DYNAMIC_OF_NODES does select OF_DYNAMIC.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

