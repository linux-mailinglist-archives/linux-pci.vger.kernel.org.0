Return-Path: <linux-pci+bounces-25003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846BA763C3
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 12:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EEA165351
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175021DF258;
	Mon, 31 Mar 2025 10:02:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29291C8637;
	Mon, 31 Mar 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415345; cv=none; b=rm61I1A+1y1rlvXeu4wqoKXTH3xMOBnSxY363v/iGUE6TSha9bH65jtztRh53R3llvImD2PWctWCGZtCRwFsH9VNlWYOZ/OwGU8YwgCc84JCnKJb6qrl4FpkRih1TBSLPj9sUOAF/xPdhyAYNMOhDCUQy4r9v8JptdUeOeoozj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415345; c=relaxed/simple;
	bh=leMvSXSuV9GwLo65xjqP0+a36WwP4pHfbm7Oh8Ak15E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xkvk9Vqz5sZPthKnJddtrWqIqzYth1oQQjmu6BYk21hjljYmtjzlEp5gX6Rcer5WMzC6RKBymv0wIECZNHha9HahqWzgGrohcuEDI/k84oikeYvUYq/9IEiyG5Ivayu7GDYOPJdKuB1IXWfTpSORnvlm0Nn0ED2ekggH3y8t39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86fab198f8eso1887346241.1;
        Mon, 31 Mar 2025 03:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743415339; x=1744020139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKU5ssgS9U8JIuOC1fvhct5e36R0RAbHOX6C6hmSOLQ=;
        b=jZfc6cSisS6LehOzTm1l5pTW7HsTT83DE9pCLTDn7VFLl60m/A6j0Hwy+De0BBApKj
         WZAU+rXmAofAFqLRsa3iP4Euxz0GY4cqoCl2wGlXzYk2SLurFW4Z7lCUkTgHIuxz26po
         ihc9bpVgs09ykq+xT6O6UuTycCVTNDn9XCgSEL+QxTAb8wgXkkLQ9CPbBjIwzPtU1yUh
         boV4Xh4aUlC5cEATwIOpvRwb4dUsvXOrLDev86q/t12kxnmF40vp3wVYJxaaTeJT0fVi
         TaeL0PMN7dKcuuJgNoaBaxZzMQen5RYWixM11mzgr5eQx+ns1B/RzGJg5CCwCPD1x1GA
         beQw==
X-Forwarded-Encrypted: i=1; AJvYcCUKDOb4n9LMRsWKIQ1MOVlCGNgRreu2vWJaL+MgqkMWWMZOI1Q7zLCPmnrFJ4LSR/3M/pJYJzp8q/hQtXvm@vger.kernel.org, AJvYcCUlDIbHgC7Uclsy3ZGLE0byHDeBV+6EV7s91i8jIQSO7SFe8NtYqCD1ihH2O2DyNeP+AXsUUI0zloPn@vger.kernel.org, AJvYcCV3v/TMS0lG29qx7g/cx1neCIDhCLqE+sxS8JDcchOYji9f3RPZhzfsiP7+9xE5hwBI7QxvJrpXkfg3tKJE9yieSoU=@vger.kernel.org, AJvYcCVhCtDzKdWbkvQU2Kv09zMLt2lTsWx3XksM3aaLvy1i3qeYEneBtW/W9KhafM3filsIIKpfaQAAiTzJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnL0rdHfI1Z+BhBwJqh6SuA9j6Wm7per+tZ7lnRfqwRSTxyw0v
	VPP/6yMe4LP7tj67MVWw2SeIPbSLIjlpdX9h4i7O74QJ1D1oq9VBXTLwZdqo
X-Gm-Gg: ASbGncv2AoS5iaOGLepoMLjvkNQqqRe7+8Rg9HvXneV81RUhhkerHBReu/mDkgN9Bae
	WDlohKhP53Ar+75HDC3lny3uUche8JcDXiz4tkzVCGodV+tNRaaXk4VbkU48gvUWxcwi7t7iFBK
	MIRcSqCV1AjO2oIgmj6k0IikRSAnIKT6Xgkyn3nlgAH7oIQBvTj01cQX8E8wXVnmLMnHppsC3jr
	8j/nuw30Y9Y0swRxNcWOmcJbt4LAMtplZanMnRJ/ldp5AxArpSvIObxGoMpN+yIH4Dq7Nr+x/MG
	lrvSRpCSo1pxYZgN5hsOcOuDtEhubY0alsXbOBn1BhmpyzPnFbCANLLNUSuCcC1l/fV9toY9gOF
	5I5pJHok=
X-Google-Smtp-Source: AGHT+IGpRRmjXoI7vbAJKRn/QpM34fkuRcQOn5hm9wCvM2+J5Ep5yfxpjnZ8QGRlQqqgM2z3my4xCA==
X-Received: by 2002:a05:6102:e14:b0:4bb:ecb9:b34d with SMTP id ada2fe7eead31-4c6d3950f6fmr4400564137.18.1743415339484;
        Mon, 31 Mar 2025 03:02:19 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-871a33895dcsm1476859241.23.2025.03.31.03.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 03:02:18 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86fab198f8eso1887329241.1;
        Mon, 31 Mar 2025 03:02:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrRAYimDgWZ5j6ChQCPO6+9TtnKLcWK96XUenq/NZ3QnEcUHftrptHKH/oEazTMiubcorRdqZz1E4F@vger.kernel.org, AJvYcCW1nWVdgY1v5oHKMFPb58GTYorO3gzKh6fQ8Oeg+c0LLnbHNoB28GhtW3WSzs53Zuxc+L/ang6n1YuPPvy+@vger.kernel.org, AJvYcCWuapyyfRRkVxFpcSY3kFHaDAsSA0aIaWRIc+zKw2yMC0XnVurpg1cty4VT8CwbN2wJiBa+CfspOuZwkuCRN0k3ZRk=@vger.kernel.org, AJvYcCXmKnL3SBwnFN1i2QNmetWtrkuwoL2VEpauW/dxJX+UojHS7avXLlQXfcF80Gfv1zCdyXwx+lysA7n2@vger.kernel.org
X-Received: by 2002:a05:6102:510c:b0:4bb:c4ff:5cb9 with SMTP id
 ada2fe7eead31-4c6d388ae4fmr4100264137.15.1743415337988; Mon, 31 Mar 2025
 03:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org> <20250330195715.332106-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2025 12:02:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVgHezvsk75D1Z=+ZQXW7=174QZDUAycErPFmmmmO9cEA@mail.gmail.com>
X-Gm-Features: AQ5f1JqDdBD1I-JTXMgL1IxghxfY7n_rRBPJO23j4mio03-iZ44J2Q5D0QBXoMI
Message-ID: <CAMuHMdVgHezvsk75D1Z=+ZQXW7=174QZDUAycErPFmmmmO9cEA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 21:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add vendor prefix for Retronix Technology Inc.
> https://www.retronix.com.tw/en/about.html
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Although too many companies are named "Retronix"...


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

