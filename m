Return-Path: <linux-pci+bounces-12331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D296232F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289C5B2159C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A715B125;
	Wed, 28 Aug 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/pbpCNA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAA15B10C
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836753; cv=none; b=lCavExlaEqss/RVoMKLCPuGmkirzq7xC3BndpNJ2e3t23KEibm011K2uXwSYv2u0k1g/W2lvicVhHZdqAZ11144/cb2fkZ4WTte6DHHhgUpRQ+TE8Z/2B7S+WbmCOFmV77GGBkid5oCbD8e1MYJ+Zo+SZuidObiuuyaciE2JurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836753; c=relaxed/simple;
	bh=8wL+LD2dD93APYoKWFP8ydkXpZM6IzqzZri9EO8Hn3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlvlRBTRQnjnfhW4wunSoskogbUqph7YYd7ZIuDZ+OHlulEYiQioXULBUPa04nUUC/imQjIN5GTdwApH2+smrQFcBTO4Ph5L5gtL9KrbzFFVewtioPFTE12kuwsuG0a7SzdMwUtW1XtRJ9D0pfauTHlFu13S1h2BNItZNsZbie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/pbpCNA; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db1e21b0e4so1081126b6e.2
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724836751; x=1725441551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bPd4Jqf/Q4W7VTe/WJy9YNJYpSS8OMy4lLEHCzNLN0=;
        b=T/pbpCNAj72rLWGsuGfRuboHpeORdrkqDLoYHvkNc1pNjdJoqhlp2DvP3pJ72FG1AJ
         UQboiknS5G+K0pxH9hUdbUnJLHX2fBKZwNlTD5QkHIu1A6izIAiuuaQWdTFkb89nvfzF
         41xJlCQ8EbRcGkPoP72aO/QLvW41I1Bt0PVbvdkLGZew6H0B1lzcHDOBpMerJCqGjOpv
         ylKf4Sux8CT3Kbc9ilV+OpUDsxvmqNJCI4tg8ksH/KoUlnUqY4+5mlKDMPuN3Y0j+ixp
         vCCocZ/v+3FoA5ACpvHDYyy/z8mrbfPPO/Eijl+BmIP7kl47+HNTSPVzgQ2/S+mpT55c
         02gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836751; x=1725441551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bPd4Jqf/Q4W7VTe/WJy9YNJYpSS8OMy4lLEHCzNLN0=;
        b=OzCBn0vymUkXGQ21DF4MXrPerpyLQRPxMQyI1qznI6lHu8u7bbzTe04XoWAROKi+9k
         5bm/3B8cgJOrZ+hQQ9Uw5t04/xBJq3/8f9WRtpaQJGouCL/jwiD2SBukmuK6bEA8tHhU
         9OEnCqh26a3XP9nOzwXYrQTn0/NG6PiZ2m4g8en87Rwc0wbFAvRH9WeRCs4yfvFJy77R
         Z4ngG1M+yLAlI5HARs4JaopVHoqjmtImlRqcFY3mEwHIoihc62vVEq1jc/1e6Zy0jbwO
         oMdPLaztn165zgE3MlvMmMu5vhJsJYMSlOyM7n2g2nGGTMp8yxP2CLXvtE2SZjQdAzPO
         pkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgP0/ze61D2JOyhBFC1Fm0MDHcqXkAZf4/EDXPWFLt0UnV/y/SylrQ6j9frtDoOIloSLNB2M4r4XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pNA6khn9pS+wpqiJMjXajYpg5kPRwpID6+pTv7RDH9F6uzlB
	Q/IE6OQTE/mzwzZDDx+XRH9DemS6FOOGfdnAMJwa7RhHJezqkC+mhHeLVllu8tV1yS/ltqvKvcH
	RUbifEmpfTaju6eOv9vUFBjUNU2Y=
X-Google-Smtp-Source: AGHT+IGyy/fg1ZmdXHMyBFq6oAusrypWzA1b4bkts7zKdmEtOMoVm/4DGP6dbqQNK/BTKl7hIn2JSjftQ0tnSeqihZM=
X-Received: by 2002:a05:6808:2e9b:b0:3da:a721:283 with SMTP id
 5614622812f47-3de2a84093bmr19834718b6e.7.1724836751222; Wed, 28 Aug 2024
 02:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828073825.43072-1-zhangzekun11@huawei.com> <20240828073825.43072-4-zhangzekun11@huawei.com>
In-Reply-To: <20240828073825.43072-4-zhangzekun11@huawei.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Wed, 28 Aug 2024 11:18:59 +0200
Message-ID: <CAMhs-H8kQ+KeJC1oy4E4ASrch3zGpSd5f8g3ZaJr7o6agKYG0g@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: mt7621: Use helper function for_each_available_child_of_node_scoped()
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com, 
	lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com, 
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

On Wed, Aug 28, 2024 at 9:51=E2=80=AFAM Zhang Zekun <zhangzekun11@huawei.co=
m> wrote:
>
> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functinality to put the device_node automatically, and we don't need to

typo: s/functinality/functionality/g

> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>

With the typo fixed:
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

