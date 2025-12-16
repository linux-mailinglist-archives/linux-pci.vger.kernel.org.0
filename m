Return-Path: <linux-pci+bounces-43088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E270CC0975
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 03:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D13E93003052
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230102D9EFC;
	Tue, 16 Dec 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyfGuVAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281F2D877F
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851540; cv=none; b=phlIkc76OPf/+YdTc642PQChWIN3/OJpiavqNs4byvFtUnyDzjgdfyjitCvLpvCuda44KUS+7kHyQFlVlr8T9p/I1dRCvltf3PjBPIWw2Rr1xl+xvnG3LBk5q4p4AX83Kq1T85mvUONLktROvvXorDQrJYVVSXMYOOqFWe3YrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851540; c=relaxed/simple;
	bh=4JFoCG9If5tB3iqR5NtPiIwHM5+YiLPesQV7/ZikZQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA4BFb0gFkQarWdqP4wgvQ4lJHOHn9IF44YRGspDeARu7v+86y/tfOIu6WyZz0JC8H4BfwquPebrz5lrLwmnTHWnQ40WZ+jCUkw72Qi83qeVLQhkpiOpYGMNDDNA1OnURsACO0mK1q5IjU9t3cFGcEvP9USowbKtKMPmuRE0Db4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyfGuVAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0849C19421
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765851539;
	bh=4JFoCG9If5tB3iqR5NtPiIwHM5+YiLPesQV7/ZikZQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NyfGuVAJv/QEY2bcARVonqHNfYA+JuwyB20TWD03IdnYQKPeEcexb8QzTfNbRqK3c
	 uEKRuVaQXx6K6rwjzn6g2sSHxzCE1/YRCpTbZMMToRULt4s2QRVfSsVt2xXarhyNG3
	 BIiysGbuekFPN1gDDo6qyKznRTmZFBmR8Bpd6YODehpYTjJ6MSkkGA29u82gVEkWn3
	 uxBo3WAV1dbmVhKBaUWp5F6lFFVpeNKyl0xbMhsKdura5Mfwca0583uj5PQKow2Ff1
	 O33fvHCUvZN+21nD2iHeCp/NUtE8E55ddBIcVomK8ncSF0aqLvmoAafXCsXuOTRxEM
	 1HkJm6sYyfzpQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b725ead5800so625497766b.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 18:18:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc3qQ8UhTytNPr8+SKdc28yyQfOrs5adzmUQvs5FuadrXslp9+NbdWVkz/0Gx1jGHFofZcTWFQaA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfRgVfFYPS7lGXn3lg3trha9VbTV7k6ayliZ9PhNYjp9EhoKq7
	+VGwXa7hAWsj0pEeVaxxbO9jbE4qS8OfTsIQA9Hn8QshiMEHk7N3gLVWeUvep1JLPZ3YaRRtgGw
	8nnHlAlpW34XfhHzGm4Fy0UbZgDmUwA==
X-Google-Smtp-Source: AGHT+IF8vGt6ajNelT4B/K7XHFLr9QG4M8S0hXfRfi33LxOzf7V9qsrSQ1r2+OIcRtCUwFMJNU7gNKNpTvCYqLxm6Eo=
X-Received: by 2002:a17:907:3e10:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b7d23b84caamr1055488566b.47.1765851538210; Mon, 15 Dec 2025
 18:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215212456.3317558-1-robh@kernel.org> <3f1b7852-1494-4a73-8783-b578f9ad5d40@socionext.com>
In-Reply-To: <3f1b7852-1494-4a73-8783-b578f9ad5d40@socionext.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Dec 2025 20:18:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKpQRMEac4e1T-s+6HWbR9mOZXRQCHVeTCnHqJYa=TYg@mail.gmail.com>
X-Gm-Features: AQt7F2rTRnyOQZ6KvlYwXbGLSjJsM7VHzB8YZxXTxLEwIFQhb8L6Y1pd-C5epdY
Message-ID: <CAL_JsqJKpQRMEac4e1T-s+6HWbR9mOZXRQCHVeTCnHqJYa=TYg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: socionext,uniphier-pcie: Fix interrupt
 controller node name
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:21=E2=80=AFPM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
>
> Thank you for pointing out.
>
> On 2025/12/16 6:24, Rob Herring (Arm) wrote:
> > The child node name in use by .dts files and the driver is
> > "legacy-interrupt-controller", not "interrupt-controller".
> After your change commit bcd7ec2cd720 were merged, it was a long time
> before I realized I needed to fix it.
>
> "interrupt-controller" is included in the list of Generic Names
> Recommendation. Would it be better to apply (i.e. restore) this,
> or fix the PCI driver and .dts?

It's an ABI. So we are stuck with it or have to support both names in
the driver forever (and backport the driver change).

Rob

