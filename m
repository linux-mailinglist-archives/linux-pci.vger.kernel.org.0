Return-Path: <linux-pci+bounces-7261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93D8C0407
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED411F2606B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E512B153;
	Wed,  8 May 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYbzNTes"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C44DDCB;
	Wed,  8 May 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191397; cv=none; b=Co2RbMP0EIdVrniHXWffti0sH51/DlZoTBSoKLygi5kGe2gNMdP7HuXdGnNegBjUEAsoJlt9L14dlGtxHO5ZJuV3kIh/fKENOqEyM7kPyBHBji3TNpn1y/LZS8bzShNs9FsP8yF2qfTyHJ9nC+2BRZmi62n2WxC+d0H9Z1d/fvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191397; c=relaxed/simple;
	bh=vtX9OYTf6vDlfS0ktBMqMcHyn0uiHbfJiCyhtnV0OXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkRnBv9VX+jY/KlTZQEoMyc2LVBhpnAjT2nOMKqD2ooQI3PYJAmYZS74HXdAS7Jqym7+muRpS4rUSmFGlnRYRkFjn6xfRRsRB53ysz6HwQlSqn0Q9gN6IMf4E310lcxYQ/Fbr7C/aDGzz8mbPPeI8z3NhzW08vv11xkULVY7Hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYbzNTes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25185C4AF0A;
	Wed,  8 May 2024 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715191397;
	bh=vtX9OYTf6vDlfS0ktBMqMcHyn0uiHbfJiCyhtnV0OXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MYbzNTesUFW2fDlrB2ZDrQE7o/dn/z+EtJZyE3u1wWHbJ62kluNZauUa+wxvkWjsP
	 /PV1r17b3JRJwDOk3lVi0MGoTmRt0vt6Z0CoPCCbpaCiok0LjrkZyJ4L2dIzQnWWfl
	 RciULehgYlzP1GXZMgvog3KMkhd/blMEU7pNW5vCIbbqoHs56aSO0oLcJ2Ds8lr5oP
	 jPXxDo9rqNkEhb+LD7jIpPSBcuv1pP0XTyyt4Oi6sJgfg96BBnLRetVeb7A778OJz8
	 HUUmPdEgSCitvxPesDl3eqQ1apKJC3bZFWHLnoaEztDYMCR0FHkhQYLJ+OfzRRgUrm
	 zI9+BelRbKS6A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51fea3031c3so6130588e87.0;
        Wed, 08 May 2024 11:03:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUahiycJ4n6nxK4QsmcPBMD4IlEEGNK+o5DPLf5aX0EEYy9SC6CJEgGcesfwuIqUWMSVt17soORLcUUSDXYz6VLLTfV+nXlG5Ew1EWqSw4eH57l0881VLtQaEhjwKBir/xD+AheMs5rSTEQN8dkXJjesM6/pPxjPeOyvPEL78+O0X50wo51CO0cr8lAw8WLwatvHl+nNeVD/WxHSw==
X-Gm-Message-State: AOJu0Yxg8dpUOljj+KcVp6BbT5EfW1RHrvwjxv/yiSE9WZRj9CavaS9x
	aFBqpzgVtUu7o4E50K8AipOaRQPMMei9Sga5U5WPb1YDGe5xZiz9U6eBPPei1fkjW1ZFe0cAaoJ
	Ab9HtYMvhxhvMqaEOZ9nB89+xVg==
X-Google-Smtp-Source: AGHT+IH0zN0FOFcNEuZcJi5LH/Uw8GX6uuPb5ReSqM+j+elaOKtK7fdmCjjC3HJJyCFq8nUkTj/1rG7NKu7z9ZSzDVo=
X-Received: by 2002:ac2:47fb:0:b0:51d:5f0a:8839 with SMTP id
 2adb3069b0e04-5217c373ed4mr2700393e87.5.1715191395399; Wed, 08 May 2024
 11:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430083730.134918-1-herve.codina@bootlin.com> <20240430083730.134918-15-herve.codina@bootlin.com>
In-Reply-To: <20240430083730.134918-15-herve.codina@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 8 May 2024 13:03:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcgYJQUd-g3NQ-Z03fcGWswSByzh1=_0jkYsmGjK=RHA@mail.gmail.com>
Message-ID: <CAL_JsqKcgYJQUd-g3NQ-Z03fcGWswSByzh1=_0jkYsmGjK=RHA@mail.gmail.com>
Subject: Re: [PATCH 14/17] of: dynamic: Introduce of_changeset_add_prop_bool()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:39=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> APIs to add some properties in a changeset exist but nothing to add a DT
> boolean property (i.e. a property without any values).
>
> Fill this lack with of_changeset_add_prop_bool().

Please add a test case.

>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/dynamic.c | 25 +++++++++++++++++++++++++
>  include/linux/of.h   |  3 +++
>  2 files changed, 28 insertions(+)

