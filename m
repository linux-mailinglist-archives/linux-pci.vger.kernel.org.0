Return-Path: <linux-pci+bounces-26519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA260A98642
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720973AD0CB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D6266582;
	Wed, 23 Apr 2025 09:44:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A62265602;
	Wed, 23 Apr 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401453; cv=none; b=pfjChZYLmX0iDEIyQCa84/ynLsa3YzDheQu/L8levO16jyuRixeTqitAgRUr5ihduzByZ3aEZdI/La2UpRqRIhYXz6C5kKrb/jZHjh0UYVdItE+/aT1pi8oQTPI0VFfG+SFj4EuD5ZLpMfhgrIHeqh3CTU3UmRZEePXGQrRP5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401453; c=relaxed/simple;
	bh=cFMJZxv4aZ/WbWfMI2okSUAOfjkTdQ1dpXVPk6eLkuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZxBohaDri4OvDF0VbOWz54OYfMl3ebUxJZ6XCQLiCslqZ+Tk/y8bMlkjWf9bX3lCfKZpHvteeDAnzHU3ETdDftjgDGSXdeyPNOEgaCfE8oZOSq7kYDG8tJFnAOep4YDlTDHhsJ9Kk2ZJSl70MK4kKqYmI2mQcjtXZLjw5wyMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso2298210241.3;
        Wed, 23 Apr 2025 02:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401450; x=1746006250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF++/aev6jNhzegBy5atlaShBegS0AcHCyK/R4zdaVU=;
        b=bn1wcvQ52C7lVbQoY70spLv+YWUCkZ29+SEsfxe6yAYLoE/Rmm3nD8BgSlObKIWW0k
         3vsMOc8bvgIy2ostzNdNe0o/iwEx485EzkFqaWRidAXQOmTnjxRcGTG9tIdUfIQyoRkn
         THOOoADovRlqpyPzvxlGxixZsasVoSWtdX++HecazFDx/2vWwbLxLPzRbGGNRfcC2V8o
         PzwFGU1BikcnugTiJT+Zzmm5gbGJW7ANJ8LcupUQQY8nVxys/z2B0OwMy/R4oiNwVxDS
         afc62XGJ8GHA9kE9YANo2wxVXpoF7v7oT42YTLlwPKxNpdRG3/QHAFV77IGqVsWnr7nS
         dZuw==
X-Forwarded-Encrypted: i=1; AJvYcCU0sEXUaXKyXiuH/bv/6Hxwq0IwMV7k+foApywD/gESJJT5+qOGthEhMsHsj+xMEZP7ZDwCWZHa4S96y2/6mqGsBzI=@vger.kernel.org, AJvYcCVukUXOt5Qpo5DdCiXerxaXisLhQPN9Q3nu7KSUrBu0A6ZDPMuE4iIOqwJXSYpp0J0O/QKjwufO9Za6@vger.kernel.org, AJvYcCWSPxYShzWKUT1DtuvlmXfyFyUgKH9m/YnKVXE4rB4bEpDuTVozPuU07VjVXrUEfv5mozgfkeH0bKdgbT9/@vger.kernel.org, AJvYcCWwr4FH+7r03N4HC4lXpWIUfhgwA0iUcqoAV7EQ99WwIZ7W9u2oCsR+I//D4gmGIguVfOOr9ahaDy0n@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6VWMYQelHNsNTNRyHj/HnvsiLYh+BEoo71YlqZCIcZiYx/IR
	cyRG1FBr2qNWm3HhlVkGWVLsl9jSFnxKLenVpNfKKqfVqAAxr4jssEU7acwk3nQ=
X-Gm-Gg: ASbGnctW2rQvMt/sEjuzi3BBRP5W2gEcFGMp7Gms420U8uWWJDVvc/djo3WZmOuqz4V
	K+x+O7NGft2sjlBywMgi2J0P+C1BqPuv14+USftwBvun+6Awp8KQTvu0odNY7LB8C+oXalDeYCJ
	wpBV3zvaIgWKwBMdqkQy1n4TXZxxkqoevPYHsyLL8EbNaQtOs3z6Jk7e4ImUWT5POzx5an8v0+o
	NH1SkwDbnCTGQak9c+97FBw5M9wRawt2HT/m3H7LOCcO8KFeHST09U79N5aMWM2lF4Q8hzD6/50
	DAwzHHo0wJ/iAvdZGEsOrrJJqdLcqUpA7W0HeRENb6ptnYWfSExzlrknyLI+PmoV3/mKbUZnh/k
	gX6M=
X-Google-Smtp-Source: AGHT+IEQMvlUiJ7/nhn5poWJ+TSemZLI9cygCFLSkYMhVptxulrHk5h4nyXm1b0BhqFJYIY8R09w5A==
X-Received: by 2002:a05:6102:5e92:b0:4c6:d008:7349 with SMTP id ada2fe7eead31-4cb80233c52mr10801468137.21.1745401450350;
        Wed, 23 Apr 2025 02:44:10 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87764776d89sm2663804241.22.2025.04.23.02.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 02:44:10 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86dddba7e0eso2416237241.1;
        Wed, 23 Apr 2025 02:44:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVY6q6xrztxw3+Ct+yQbPRbTIbvegLyK3y7MG/5eCi76Z/jxVf8aQ28eZmWBp8UDnL7vSdP2iQwKjat@vger.kernel.org, AJvYcCWlxZ50kBivFpkt/BLJSAbDd7b99pPqB0x0hMEZlu6Vn4WvUhDbnWp3UhzShJJgRfD6mMhBSig8FeUnvVM4@vger.kernel.org, AJvYcCWyQg2CIIGV0EaWgYrFcgdT3bl8sJPu9+2lz7RJZmtWkKP/letGBvjAqQnyJJ1/ha6gcMjPXkXqn12L@vger.kernel.org, AJvYcCXvqdyqnetMgxr/VtdklULYmx4TqBc2tDWM5OOqYnMqoxPfXH5F6lBhriK0hXzZdwIId/Hd2/LF9QNTjiAQ1PuRSyM=@vger.kernel.org
X-Received: by 2002:a67:f093:0:b0:4c3:64bc:7d16 with SMTP id
 ada2fe7eead31-4cb801fe2d8mr9882874137.16.1745401449838; Wed, 23 Apr 2025
 02:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org> <20250420173829.200553-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250420173829.200553-4-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 11:43:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf6ZRWv39f3qdyJFUwvgVMJRRc0TsfKiPUNca4JRvM=Q@mail.gmail.com>
X-Gm-Features: ATxdqUEcXQMXrldJVinPbdvd-wgbRX507q25YIFyRIZweCQdoMNB4nEDdseAvv8
Message-ID: <CAMuHMdUf6ZRWv39f3qdyJFUwvgVMJRRc0TsfKiPUNca4JRvM=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: renesas: r8a779g3: Add Retronix R-Car
 V4H Sparrow Hawk board support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 at 19:39, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add Retronix R-Car V4H Sparrow Hawk board based on Renesas R-Car V4H ES3.=
0
> (R8A779G3) SoC. This is a single-board computer with single gigabit ether=
net,
> DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD po=
rts,
> micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe=
 SSD,
> debug UART and JTAG.
>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.16.

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

