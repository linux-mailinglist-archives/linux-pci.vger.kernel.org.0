Return-Path: <linux-pci+bounces-35061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059AB3ABE6
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93B73A591A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4028506A;
	Thu, 28 Aug 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duuC6gdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536C27702F
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414028; cv=none; b=ePmKNMAgniA5is3VlM756+i4AuZol6n1Lz7qnWyJIkDQkXtzeS+en8DdioVLYUCTDES1I4K/1M583XcKY5bglqFXW7CK83L84Zjq0oe8EoLlRgoe35mtTMOsj7DN8uFc9jck7mLdvLz+uljQT90jgawHKRD4OTA2EK7WyUezJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414028; c=relaxed/simple;
	bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtCX1BN8H+3AqPmtO8bCtf0qt03kHSkmV8iN7TjjFluNL36NAtykSHTDCtUCLRiMqqa2L4HpfJdwdWGJBDLsspeDUW5C10ptz8dWG7BH/Z4NxLiHCuGmaJa/NRC1b7SkIgvKK75QDdS21YRqmXx/+VD/A9Ghnc0f5UKNng8Wjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duuC6gdi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3366ce6889bso9892861fa.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414024; x=1757018824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
        b=duuC6gdiDFxj9zSs7kJC5i30idcZkpCgXs3RsvTPLn41WIrZiLyjg47iKXVgDp0fGy
         sR1Ykp9kakPLjsqHqgAhVFhbv0MJWFPX7+pp+j8qDVg8p3yorBM7KzMIzdrCtrwfybW1
         o01WRpxJ90KqhKvZoQJJZ1i49LoC3j6DIjaxxgSUalbD83CnnK/OMUPPX1R2VkjF9EJm
         Fk5hvnS9St196MU70qE6Hm+tZ7nVCmBFILCDK0S7awwxLZAt9vNPeb/KWS6HLNT8iS/R
         KZfT7vTv1YgLyn6coGjbr57UB3adlC6qzvmLRus9O1SIvmDkWsV+8bN4ho9ZEdC7M9BF
         7sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414024; x=1757018824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yypyaBN746HsDrUzE1kCYfLJaG9FQJercS2A7aMVfV4=;
        b=uYQJu03AyHiPXHqBSWvldh5y2hDEJRBiQsqp0dzVF8x2LJEI7zjpZleNTBIFcrz7G8
         5MGAhPcDKN+7QWod+Y5s+4rje30cXXCjk1xlSMsZdumJ0gYEbTJkmFGZd7F6117QNfl4
         kqtpi7iq8/qUnjieYocus8SrC5liGpGRWV6rHneNSnzQIbIuPmriav3aSjdvmIBEgb5g
         3tLq8ZqJVHp8GTNrZ8z04I8IgN/j6yL1zpEHzUr7NSTWwq+l8P1wXHBm9f2I01U+Vko0
         +uTNZnA2mbuwQGZtqXnNaSC/4J5atZtgV0bx7aGeK2Wd5kCTvTt9K0fx3Hni0QMvrhwN
         291Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuocWR4rLxVxLd11gzFTkEoy4V2vhjKAPVbE+5E3Jp9fkcAc63PcDGbtn1OnwBd7NRRpULCqotxu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgd+RDQKL6vayapIPbGOPYV96iAYIJZotVj3WToFludZNrj4B2
	qgmRTvJH7LE8OVAtuQ8oZ2XEUEOfNdBOCwh2Bv6TxLiaGNFGlHyq/n53X7F1bVU7BUFLFGU39Jg
	fsma0/npfLJxRiiBaiWpXTneZP+ZbdTXd0Bu0gd41zA==
X-Gm-Gg: ASbGncsN7acUfRHqCxVxInygR5ks8lvK3DLOgOhR/cx+QN7k0+axR20S8PgodXj5gd6
	SyqXVEm0/Kwgam0jAuprd6UGcQLNyJHf/rtsVO3Ie+yQM0pEgwynTC+OpEy7rThusAQifNzHkl5
	BGSYgqYUvcbjLcurlmePehy/byX6FeaSfTpI5wG3AVetYgGmkrJT1x26RuM4Tesah6kkR7W4jwM
	T71Dsg=
X-Google-Smtp-Source: AGHT+IE2uWhuibXcObFZ5VTNIy6zlok6JnK2MWtwL7cqbL+/SAGd1n7jHXQKxLY98v4CVTQiyLHeR0E2ooltz4RMmZg=
X-Received: by 2002:a05:651c:23d2:10b0:333:f086:3092 with SMTP id
 38308e7fff4ca-33650e704femr56328661fa.11.1756414024499; Thu, 28 Aug 2025
 13:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-8-jacky_chou@aspeedtech.com> <CACRpkdarn16N9637dL=Qo8X8o==7T=wBfHdXPczU=Rv3b270KQ@mail.gmail.com>
 <SEYPR06MB513491FF4398138F8A52A5469D38A@SEYPR06MB5134.apcprd06.prod.outlook.com>
In-Reply-To: <SEYPR06MB513491FF4398138F8A52A5469D38A@SEYPR06MB5134.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:46:53 +0200
X-Gm-Features: Ac12FXzlvTJpPFPcU9uQ_fN2isTkkss2_BjIEzvxJnxhjmRwD11F1FNpCNVPGsc
Message-ID: <CACRpkdbmRpH1+HtW+vbK7rVk6OCEve54BxTAxrUhX631a2KP1w@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 5:08=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> May I remove this patch in the next version of this series?

Yes, and in fact it could have been sent separately from the
rest as well, no need to keep things in a big bundle, it's
easier to merge in small pieces.

The only upside with the big bundles is to help developers
develop all in one place and have a "big branch" to test.
But it doesn't really help the Linux subsystem maintainers.

Yours,
Linus Walleij

