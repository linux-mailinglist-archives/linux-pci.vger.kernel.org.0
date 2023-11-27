Return-Path: <linux-pci+bounces-181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BBC7FA280
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D231C20C5A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A1315B9;
	Mon, 27 Nov 2023 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F46198;
	Mon, 27 Nov 2023 06:22:03 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5cca68f6e01so42530557b3.2;
        Mon, 27 Nov 2023 06:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094922; x=1701699722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=834pVqsGyG/ThloFCq4Fg8uGigDw1US55aPZgUr69AE=;
        b=hZgxPAobZDD2wyA6PCv3abu3HYrdfeTdF3Y+Kjwkzx1BfAUIq0SXTU3FPSQoS5+G+s
         lPF8r9g3h07Rk9sret3Zs3/qhcPzZH8q0Swm2Ruves73yq0jxjWHiGBHmtzCXU4ySWS6
         hbBWIJAAKAqCAj66cq5Fs329tAxx9F1DCcdqg/qiHayf2LGenx5Yd2KG/H5oa2OXoJvK
         fWu9OdhBut4NGzU7RLwWQCNTFTzZHw1nY60O+xNn4NltRFP1rYZDjczI7+hlrL0sXv17
         9ao6uBHyxeeOFrFbRCl0oUudlihSIhgjlXcxuW5+CLC3Mmo9v4+R1YMLgsdjrrQ+i35w
         iNRQ==
X-Gm-Message-State: AOJu0YwT8soz50xGXB4jQ3HTJ0zUI8D9VpIWFvPZOHao3bFXqDbX3raY
	V5wdiTIyX+l5QfmeCwOjgy9DSnIk5Y8Fag==
X-Google-Smtp-Source: AGHT+IHIry33GnwZYxjABz1zje1OAyuJ5yzdqY1RHUsCssQtdGrmsmjetxCAOQFmRXv717eoprhxog==
X-Received: by 2002:a81:a507:0:b0:5cb:d645:8cdf with SMTP id u7-20020a81a507000000b005cbd6458cdfmr11688215ywg.48.1701094922153;
        Mon, 27 Nov 2023 06:22:02 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y66-20020a81a145000000b005b4501cb71csm3231244ywg.29.2023.11.27.06.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:22:01 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-daf26d84100so3819090276.3;
        Mon, 27 Nov 2023 06:22:01 -0800 (PST)
X-Received: by 2002:a25:6cc5:0:b0:d9a:6b1e:ef51 with SMTP id
 h188-20020a256cc5000000b00d9a6b1eef51mr10902367ybc.2.1701094921451; Mon, 27
 Nov 2023 06:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Nov 2023 15:21:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7cs_DCwkbD4FGy=OgxsfLe4poU0916dM1xUB62ahqqg@mail.gmail.com>
Message-ID: <CAMuHMdU7cs_DCwkbD4FGy=OgxsfLe4poU0916dM1xUB62ahqqg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:21=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Use only one and exactly one space around '=3D' in DTS example.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml           | 6 +++---

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

