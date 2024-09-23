Return-Path: <linux-pci+bounces-13361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B697E993
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CE3B211E6
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7AA194C73;
	Mon, 23 Sep 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4KwL17W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23419938D
	for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086136; cv=none; b=CAV3ywZxTuKpj659fID65L5ljvhgFoCsK2JiKUt0glZIiMnSEAZBa1maRrtxGbicoMRbVUr+w1vdBnCSCrcBy9TrdmWDIY0A1sXBDRJMvpYId4t44DvjmuUrItXg5ffj5oBQ/r7U8yI9vQtV77YXl4teApvTiZ3Bjxq9iDJGcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086136; c=relaxed/simple;
	bh=U5GXWrxFCux5MYHjtn40XJVN/g1vrOfIlhTBREhsD1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KecQa4aR8uXb4CRAA8yKNW2mkiFvAn0hZLRHB21jYfjJUZ9RAigaKEf8kVz5haDFT2q7Ry9m66YPyl2M76qpif0NQdYVdbKXeDIhfeNTUYxdunJNDPOVZ1xmoZuxTDHgUDyqJoU1jO67YG9jTQ/vpOel6Jy+AZOnzB2HUYxWOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S4KwL17W; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-501213e5ad4so3103530e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727086133; x=1727690933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5GXWrxFCux5MYHjtn40XJVN/g1vrOfIlhTBREhsD1o=;
        b=S4KwL17WOjAAKSYuEyPrVGoBsvtJUf2GtkTLGKxMzdxjjcauI+RZ2lmyedNCEaNBxL
         5bIAOWx6KHaOgHCF7FbsN93tOy6tw3OCyCNNfXGVnLT92ghT2AEyvpNpHl35cv7IRwdB
         xWRox2oFM+r2Yu1zAQnBjTtE2gZrEDsxOu+pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086133; x=1727690933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5GXWrxFCux5MYHjtn40XJVN/g1vrOfIlhTBREhsD1o=;
        b=K2vXiGy16satf+t0xQH3ePAccBqoZTsXz1KXEDW7f78oK+fogAtpOapKTllpGKrZbe
         m6gW7gWA+qGT6aqpsEXHLXR2zDMwdGrEjwrTySHDhLRCuX4JFWVMHoBEPR3f+m0G0kkQ
         ZsYKP5+SCSwiZtCpuEh8zEHyk2YYEQY57tceTsRsfXK3AlKRtuuZnSSkeoOuM/r26oAU
         edJfRcvxhOkN4UxfHxUApZ4FhsgJwmHl6BhD6Hy6xAVJB0Ch1FNGPt7GG637t7Jksfys
         aK219IW5/4Spx/JaanzuJ+qWXBfZTuZkFuaimVirzI32OWsvxBSiPp4RYC8FyQcCrwRs
         XYOA==
X-Gm-Message-State: AOJu0YxHpYebTgFNL42hIMHVilZgLeDX2zfw4DAMXK5A5K7AxVvCiiTQ
	KbQ0VO05YOEmoHD4kR7JQfTyuFITLLY/PPzj8aZ/8gej4MH6+94KUXdBHXXN9E9kZx1T7V3p63k
	=
X-Google-Smtp-Source: AGHT+IHTF2PObxM5HnhUSZJvs4UtCwLXlmAQMpwKdFTiO71wHl3+Vi2oSOwwxgLik47gIckHS+88fA==
X-Received: by 2002:a05:6122:3191:b0:4ef:58c8:4777 with SMTP id 71dfb90a1353d-503e0540f9cmr5683133e0c.4.1727086132581;
        Mon, 23 Sep 2024 03:08:52 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035bc6b78csm2647039e0c.50.2024.09.23.03.08.51
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 03:08:51 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49bd250b0f2so3048295137.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Sep 2024 03:08:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5087:b0:49b:dca1:15c1 with SMTP id
 ada2fe7eead31-49fc72407c5mr5952529137.9.1727086130667; Mon, 23 Sep 2024
 03:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com> <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 23 Sep 2024 18:08:14 +0800
X-Gmail-Original-Message-ID: <CAC=S1niSEG_9kFDBGL+i=MjqvfiuQBmAhv+7He9A3_7PXUi8Gg@mail.gmail.com>
Message-ID: <CAC=S1niSEG_9kFDBGL+i=MjqvfiuQBmAhv+7He9A3_7PXUi8Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 4:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add support for restricting the port's link width by specifying
> the num-lanes devicetree property in the PCIe node.
>
> The setting is done in the GEN_SETTINGS register (in the driver
> named as PCIE_SETTING_REG), where each set bit in [11:8] activates
> a set of lanes (from bits 11 to 8 respectively, x16/x8/x4/x2).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

