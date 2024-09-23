Return-Path: <linux-pci+bounces-13359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2445E97E956
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 12:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41CF1F21E66
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4621194C8F;
	Mon, 23 Sep 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mqd31uB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061039AE3
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085950; cv=none; b=PWo+q6gvDBc9bPJAG8gSSKtUY9Uzjey/LJYcAjqYOk21zi1+2oWgusXJ7Jbj45e7Tb8vGwGxpYGkNVAii+bv+/DiBPPPwrPdTyd0v3eoKerT4MSGhTwlsMd2UcsiYhKTvTQrf2qz7ziO2rIeB/ELQWpRYxURcd5ix7UZjnmSYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085950; c=relaxed/simple;
	bh=5xJdtdhV7q8ohpMQklnYYogPu+uXAwCgLJrxI+TZY9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLRGoNuDOSlJGbSaydlq75A2ZAFRAf1o59weo1Huh69vxrr9boxC94ppUkE1X47qBHvIPZ19zG4B3DIZAwHTFZaTtsj1VyfLX9nt32P2zUL0UKGD8tEmtKcPudbOPXlKK2yAki+QCNK20Lt7YCnob8nY5SZWrL8RCerbF0ANeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mqd31uB7; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-503f943f115so405222e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727085948; x=1727690748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xJdtdhV7q8ohpMQklnYYogPu+uXAwCgLJrxI+TZY9k=;
        b=mqd31uB7KcsIHxUWDYAnn6mtL4OBDDEFwMc/hx3S0lQ/tHtOD2ucBiuIBtCoZN1Lin
         C//mJHp8Mi8ezyw/5smkcmNJHFY4PmXJ9cD/G8psv3O7HJE2xlMkmMhO8/L2n7gP2Sra
         +DHOGGD8K5ZwaGsbXm/m5rT1+H+wO4pes3NhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085948; x=1727690748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xJdtdhV7q8ohpMQklnYYogPu+uXAwCgLJrxI+TZY9k=;
        b=ioqp59mzlE2fGrHQ6AvdTgLACPVVqMnKc+c6jau8iJ3kJRLHQJyWf/esccrt5Tr8Fc
         pd6pV2V0e4uNia7VjC9VVMHydXWGarccVO1qTinl/2SI1qtJOOA0YWBlbxJ7qrV9qt02
         lK2+oAXrto/qW6IdK/qDI8Hb37BYheIus/lHoI2JTpiNQiBAfQ6MNXZjd+DTwtNLTFW9
         1cPssgU9YeL5jQYHxIMNvrhpfDcd/kD/Ybld233YJs7V/WZAAacJ24DEdzdPGEmCVLNU
         7OjgXEybvwXRDPOKSnW7lPst34zyZiz2yst0/GY3MfwbETc1DG5wNrci44u5ergym83g
         mNVw==
X-Gm-Message-State: AOJu0YyENoeYWPMAs0m7HyDa0z1t2ekliCxbVfFQ6GxjbptxJiPgAaxd
	TEylrF/SW2tn8Z60+4Kxsy/7WKtvnsyfhK5114LCHyKC+B4zXjTOyqSoLOUDK5y4kuSgYVim67E
	=
X-Google-Smtp-Source: AGHT+IH1A/CsKZnzN9Dcyu4WXqpKMYU/B5ZHFn1YXm/PDvAZkBSOB8PLUxvneCH87mt/Z71Y6B3Asw==
X-Received: by 2002:a05:6122:1d4b:b0:4ec:f996:5d84 with SMTP id 71dfb90a1353d-503e03d84f6mr5975509e0c.2.1727085947845;
        Mon, 23 Sep 2024 03:05:47 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035b928fd1sm2632635e0c.6.2024.09.23.03.05.47
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 03:05:47 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-846cc83c3c4so1053630241.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 03:05:47 -0700 (PDT)
X-Received: by 2002:a05:6102:41a6:b0:497:50c0:a6cb with SMTP id
 ada2fe7eead31-49fc7626228mr7350845137.19.1727085946795; Mon, 23 Sep 2024
 03:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com> <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 23 Sep 2024 18:05:10 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj6AdVHoBUJsduHiGfpRRijTx+zJ5e=a30+pYENqO-GOw@mail.gmail.com>
Message-ID: <CAC=S1nj6AdVHoBUJsduHiGfpRRijTx+zJ5e=a30+pYENqO-GOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Wed, Sep 18, 2024 at 4:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for respecting the max-link-speed devicetree property,
> forcing a maximum speed (Gen) for a PCI-Express port.
>
> Since the MediaTek PCIe Gen3 controllers also expose the maximum
> supported link speed in the PCIE_BASE_CFG register, if property
> max-link-speed is specified in devicetree, validate it against the
> controller capabilities and proceed setting the limitations only
> if the wanted Gen is lower than the maximum one that is supported
> by the controller itself (otherwise it makes no sense!).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

I confirmed that v3 addressed all my comments in v2 (with some in a
more sensible approach), so
Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei

