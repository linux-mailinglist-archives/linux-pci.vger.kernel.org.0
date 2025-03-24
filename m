Return-Path: <linux-pci+bounces-24526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2EA6DB69
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8412B1894064
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB825EFAC;
	Mon, 24 Mar 2025 13:27:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02925EF81;
	Mon, 24 Mar 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822862; cv=none; b=ZNtuFiDYKUcTQ/VL/LwbNZo5nVzSC4J+r4huRVfWUZ1ofQH8IIjYQLXY23JAK2hLOeXjh0fHnuqoUHuK7JiQqXKuDW3IPL0pZLvdtkTHKQNJQOnTX37/vV//tMabsdXB5gQyxuGnDSCEv8Uvp19kT7yJS9hN5pwkDlynHtBiIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822862; c=relaxed/simple;
	bh=Hz+lHqMcrt47SWNjmBgQ77sCHMdM7OH6gByDyjmmoHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU1t0mj/gQl38OMJ6fOkUaQzg92MvThcFy5oQ45RxxE3bWAD9h/2wQazbl7/WWb8IcWxUlesxZuJciQAARFGCANJLEcsrEBmh/Fq7sV6X7U1jgYU84mKDeumLYucBW6NyKNBQiVwfLFeUa9GODuJ0FPZJtfKeK45EG8xqcC+bI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523edc385caso1630132e0c.3;
        Mon, 24 Mar 2025 06:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742822859; x=1743427659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQ+K7YM9+7vb1XXWZkvn/CJUu3nmvB88QVFZm2AQkeg=;
        b=BPT/cFKPr3NmI8l+fsK5Gu+PWGDD0z3cwYwUb8K67Wh2hbC6X5ydbJvc2nhVCSkKdE
         3HOjvhwf2s6yNiBM2u387qpkURcaiU9pACzEKkeJsQ14gxFiAaX9orXrzb3Nh6CmVCUY
         MHE8eLk7ba9IccQF9Iz1dDf+P50hmA5udF9rPKCiyXiwY8QfG9IzCfgd+99APAkBDmIQ
         V+tu8f0cRMAbb/2ua1ld4jja8tS+9qwTmZSJ1ydJK2KQ6ctIUJfAT+alO/4ZDuA8l6sN
         x8NnrRxGGLk4/DLYpRJOm9NrTfY7BzpXe8thbLNWcutK8XVBAvM7aFs1N403PDpmeRH4
         NH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmzgXh/94SQC6N58zCY658OsXKRLQRqLuhbkeWIDbsL3NsWnohvMhjmINCtrgl8pFjny1h/c298U2MNAKi+r2bNE4=@vger.kernel.org, AJvYcCVuhwehvYZ6zC39P0K9Qh3g3tsDUBIK1w99RrVTWH2Bt783wlWGx5A5RRTALJMJYfsPmrHMwzao8kK6@vger.kernel.org, AJvYcCXBpkSFzsKi7nfq2Ln89wtz6gC4Vvi5vUOIpFrCt6fXt9jNaWl1J+FG5TjtJuBhJ/mK0SaIDHwwulQ9@vger.kernel.org, AJvYcCXZmsHSDOmdPHMdOyZ6BepVAVJavkNc7ffHucvnTsKKYc8XYxBip8z8ykE8tEHL7mga2RVidd9D4W+0lcxh@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtdHAZzv2p1mJGuWoqyOhnofWlNI5zPxRSylt58cRAbKAQi66
	8Z6gHNq08d60XC16bvaQhDsfwBeZuJ+VnlQ09VnSd57R8KdWyX2m4lQn/vJW
X-Gm-Gg: ASbGnctYATErdw8fOH1TbAszZHfopHq3FPw7n2/Wh72g/vGo2TVtgAt0UJFN3OjmFjn
	LBnypSTl3lcdFunl8HKoJzMmmSXTg6YRcWmdDyadzBCsphsKNI587CywpCoK6CT3HlV9pqJoWDa
	Zgri+Hp7YQpNq3TYXYsIKTTk2Zh+K80blqUWsxIIzWzBdk0OJijslHj7FcpC7zb21oUpSQHu6On
	aII7HfKGLb4Lq1+TtowMfk5yPZlvCi9Qtx0B+bF6VCj1ItBwNt+j8urFHFBPTwgiVxm/piUGwEk
	36dPBjPT5LNoFGnX8iBAJL0xwpO5h/kMutzD/SaF0V+pA3GrQ/vV2n/hk2TRPKHU1jeEN1wGxy5
	tM8l0f2hMcKH2ojP9rj3hZg==
X-Google-Smtp-Source: AGHT+IEaIvL4qcl+HGvHyopbqwbkfuBWZ+UOQLBYO6R3Rzn0zYW5sjAO+2kzxBfTbmRDnMWvTcERSA==
X-Received: by 2002:a05:6122:3989:b0:523:7316:7f31 with SMTP id 71dfb90a1353d-525a8379913mr9183241e0c.5.1742822859229;
        Mon, 24 Mar 2025 06:27:39 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a767186fsm1371593e0c.46.2025.03.24.06.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 06:27:38 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-525b44b7720so853303e0c.0;
        Mon, 24 Mar 2025 06:27:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe/weo3VhPN5jzNOM1a9666ICTlFokT1e1yhBj3jTWKAuYsKkbpEn56SJBFUhE1mZWwCz/BYlzZ7Wj@vger.kernel.org, AJvYcCVgQxEOK97uLImruluv5X3b1eB6EYTL7jtF1yvLgQQGTSEIaNUi06yzlvlnhR+qFyp1i+2cDDOgxaWdce7H/OdkFmY=@vger.kernel.org, AJvYcCWU9WKtWpYYX78chOfsewfVncnk/OPG2BDCYsJ2iHeQhpo+eBpDUC0KVXiuNIB9SW4RFGZ+M8mi/B0XWB/t@vger.kernel.org, AJvYcCWp0nmHJ0I0x2gn/8RcRp/Khki2Z3XcpMOUP4NghZ/SYGb04DK2iGRsDglC1THt+fStTmTwKJgksaoK@vger.kernel.org
X-Received: by 2002:a05:6122:210e:b0:517:4e40:6838 with SMTP id
 71dfb90a1353d-525a8519f0amr8262190e0c.6.1742822858639; Mon, 24 Mar 2025
 06:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 14:27:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOND_TJqGckmGVB2jda=xxZmY8C5q-QAzvztcW0yPuMg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqy03btuV5Gp3EW0QPI3_1fSYM7sA6rvEy343cRRLCgBG9ZP_0N-abJFTU
Message-ID: <CAMuHMdXOND_TJqGckmGVB2jda=xxZmY8C5q-QAzvztcW0yPuMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Correct indentation and style in
 DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Tom Joseph <tjoseph@cadence.com>, Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your patch!

On Mon, 24 Mar 2025 at 13:52, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.

+ While re-indenting, drop unused labels.

> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

