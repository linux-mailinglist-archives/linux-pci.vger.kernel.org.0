Return-Path: <linux-pci+bounces-6113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA98A0892
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 08:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266C01C2279C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4313D617;
	Thu, 11 Apr 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QudKxKt8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD213CF9F;
	Thu, 11 Apr 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817442; cv=none; b=ht2PoyHum38PZU0p7AOMU72Ht76Bv7XWqASmFr/hmnZLQRz/zpHYpdwNpdCKQuwsnMxoVYQcxonT0d/qrHpZmhcx7yD7xmihv5zHE1H4aZYHTEuTTXMMTMRdHHdUBjTO/n/ZWanpG2F0lLG9Df/y8kdRMYqSKJ6uBmZm1mFQ9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817442; c=relaxed/simple;
	bh=2ipZN9n0TtN3o+SfMKeB61oRs+EH1yEZUxvjc7CAjrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUGrpRgybC8TRRXF5cF9vq1WTKPCoad89chTkxxGotryrmMmhu1tlAGxCmQYv+BrgUfPFqLBVqcl3fbVL/20pYsFC9f0UOQypIT0HWrAXGuoqKj4hIVUZD0ZrLaenkHAYuN3PmC/mO8kKnfU3iCPqAvyeYsbOR2yyfCUfr2F98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QudKxKt8; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa400b917dso2493138eaf.0;
        Wed, 10 Apr 2024 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712817440; x=1713422240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVtF0FbxwDL1+EyVXXt8m5PuumkGURWxInjDGKcvjBg=;
        b=QudKxKt8WRSuOcBggswmX19sSrnaLJY8oqE2eB3Zz/M5jCejqZ8FMSmwb7DtDgxgSr
         NHBtNB+QOzt7z+2+MQhMrPEWSlsxceXXmtVeobYcsbANF36YKchzxtf7ZNbziaKiEI0H
         XxkgJlN/tADOp6wl9cHY6GWIFJFPyeZqWq/2vlfxdLMpK/yPvx9zL97N+AJ0gq4o3rG1
         HbhMPnoxk0/6nmrgVUAjVgQL2pUfkmsbqsL3mz3iVnhTJ24mb898VVACswXb8Fw6q/KO
         Z3qRw3qKeKqsQ1zUZIumDnNvxbOAQY7l9+c6OqzA4nXoKybJQ1oWUZi/FCNiU93sA70I
         ra/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712817440; x=1713422240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVtF0FbxwDL1+EyVXXt8m5PuumkGURWxInjDGKcvjBg=;
        b=s79n/GDwRhnfowyqxh/M/i0UJDm/PI7FOEpTaPHioHvPlVJE87Pe+eTS9TnZOer2J/
         yV7q5lw7i9IjSt4aDsu4yA6p4/oO/o4jCl7U6usIyJOZxqHhf7v5PB+hH5ugtAiKiQta
         1zOXpznzz7bZrs8QQuUyErwdFUo7iUD8ueqZoVz0MVariWDohRemMSE1nCk2PL0zeMxr
         8xN3Awr9Fc2ioL3RaJQggJksPlvgEQ2Tfc31spVwx7emf4MzI3Br6D4758PkOkoxbo2Z
         TCvsBmSXL3l4qucvXUfY+pslYd4jFu8qcHCZghwT7G1eFysD8Ryx+aZhxdl88HAybhbi
         RTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuStSMoVGJurBq4h+J/BCRArVej44w/wPf2zIiZ0OHwLxnbXicXxLKeVZYgfU4KV1WgyY4TXqDTMPcI52zWQmGCM1iNPLofPhv86fzW9Ad8QmPddIcWGQIOwkjW4qxlIO0BQwBh+8MjVxAGg0oissvOUbMK7zMC8yegTIC4to6MTEsoimBGCOX9TDSmbBoS3Q/+KwL4+elimzNoK1ApQ5Edqo4Py8H9U4iGVm69z+gEUzZao8uqR8Pr8ftZROoD+TLzPRVTA==
X-Gm-Message-State: AOJu0YyL0hc9o0lRp1Kbjz+b9reBOoDjXxiv+hx2rUciPuHoGZ0mH/j+
	+4UtfsxrbfDa0GYcC2Rv7VKeehJhrNmvJxZuXGCLVGl2LZem3La7zB8nldXp+30hN8ouhjbGZMi
	u5KXW7edtFLTTYGnR02E4OpCeGTM=
X-Google-Smtp-Source: AGHT+IES9majFVr22VozspwWyOs+YbISGsgQi1H0N7wgH6XHm1MFch0WdzdzAv98JrRwXB0nazk545ZDOwQPlvcyYH8=
X-Received: by 2002:a05:6870:55cd:b0:22e:6b4e:d2ac with SMTP id
 qk13-20020a05687055cd00b0022e6b4ed2acmr5468350oac.12.1712817440529; Wed, 10
 Apr 2024 23:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410212638.GA2159326@bhelgaas> <458ce909-0616-487d-b4bd-42b58d059198@linaro.org>
 <CAMhs-H82Ymc=isxu6AX4_s1QnNpSSNt74--ED1j7JxpzE=eCRg@mail.gmail.com> <0336b752-ba98-497b-96d0-efc01ffbd93c@linaro.org>
In-Reply-To: <0336b752-ba98-497b-96d0-efc01ffbd93c@linaro.org>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 11 Apr 2024 08:37:09 +0200
Message-ID: <CAMhs-H_yWFn7JvCYhVqELmBjwHO8KCU_UVE5XTas2WVJC1UsAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: mediatek,mt7621: add missing
 child node reg
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Tom Joseph <tjoseph@cadence.com>, Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:20=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/04/2024 08:13, Sergio Paracuellos wrote:
> >
> >>
> >> I think the question should be towards Mediatek folks. I don't know wh=
at
> >> this hardware is exactly, just looks like pci-pci-bridge. The driver
> >> calls the children host bridges as "ports".
> >
> > You can see the topology here in my first driver submit cover letter
> > message [0].
> >
>
> Useful diagram, thanks. It would be great if you could add it to the
> binding description.

Sure, I will do it depending on time hopefully sooner than later :-).

Best regards,
    Sergio Paracuellos

>
> Best regards,
> Krzysztof
>

