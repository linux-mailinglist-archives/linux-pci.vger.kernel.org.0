Return-Path: <linux-pci+bounces-14367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0F199B188
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E83428462C
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B0142E76;
	Sat, 12 Oct 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsV2dtBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11F13D886;
	Sat, 12 Oct 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717956; cv=none; b=jAOgAYV7JAJnqCNEJpKuBmjT5zIpVWWpUogXRXvWGZcAlRWDqSWvIdQJ2GZrRIXukQkH1W/Lnp/fTgGC9yDIHWNDXJ/OMMIqHfIy+FRU7w0i6SoJ06752ywD70QnLZG0m/MhkHEt3k/nDKXJP2GHQhfj1GK1eF/ICAdO31YtR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717956; c=relaxed/simple;
	bh=2akhxe6WSPpAAm/ei6X+bi2+69gjO4LGexVLgUCq/iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srf45mFqaQ1Q7xwm8bVDbWqQVKLviVlk7j0+btS6azZV4TTsOj1tvz7Axk9flNCuq8dosElPnjfvgl+R2uGf5cW9md6BIhGNmHRsDQoaT/FmZl/HlIvoRWAgKKFetrDEZSo3gKa8ngtehghuhqfNr7gFigt3viPNJV7FYcE9pso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsV2dtBO; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e4d7ae64f2so1156856b6e.3;
        Sat, 12 Oct 2024 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728717954; x=1729322754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2akhxe6WSPpAAm/ei6X+bi2+69gjO4LGexVLgUCq/iA=;
        b=JsV2dtBO11O6TmAEXnZzGxmGfw6Q9rSZnEdVOdqvZOY80IMOgDw51UKlcK/n18Pl0D
         S55elYYF0+HSf9zREMkL8XgX41dIYKd6bfKqXeo4ML8/qijXy8NJ9JwEuwUYD/28TMCf
         ciQt+iWWUT/1p8GpS8Fo4n0P1fR5s34ul09LgXHJNukDbRNq52O9Udldca8Uaefsv0yn
         +KxBppWSLEVOHKshD+7T9uI/SZsPHYurezvQchzJdkXWwzGW/zwKVLiSrayD0xmswjxi
         gYV6At5fiU5KYLKZS1bzDIhNd9yDNChifRMMM84sxMU8WpQPeAeolKPgcrCOb69boB47
         LwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728717954; x=1729322754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2akhxe6WSPpAAm/ei6X+bi2+69gjO4LGexVLgUCq/iA=;
        b=bgy03Vehg7Yo8RK2jrcbwTvVSz5YeJUCGLne3rAxB20kS0Sp3qVJ66lLoJpWwPC2MR
         vr2phYFxyCg7WJhoxKTbOFYiAbEOO9T0SvJ32bNEVubWvYPzvr/Dwv2yuTeGrEjhOc3n
         RM0YxQ0ROdaSmzDRhva1vG+PTJqQgEMWEkLEvpGGWxSYouBOMgbw1hW1Yhzeps0i7Hw5
         SysDr/xYIZhmJLovQdO2V6BHVFPz34p68Q+WP6D3mffzhk+2rQ1Fiklg4lPQZzRm/ROw
         3SaS7MbijY2atFTIW1VGQQGISyimtyX5YWR9QTQIxgWfgFhfPJE1fCTUXwwpZtfl3Nzh
         S4oA==
X-Forwarded-Encrypted: i=1; AJvYcCX1F7zvIlq7CuUgNXtJCqEaCGharMXoLw9dagG5nVWgASpKO5XvbwyJJhifUAxcHP9ErF3Sj50/desqoL8=@vger.kernel.org, AJvYcCXvZy6nSOsdDvV83UtSpGy6a6hAeDVsS78XwjQdO/iE0UP3SNiWY38zlXfEhrplvudltEatdIVZ2F1m@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDL8y8LDTuiGN+SJG8RfD6DC++OfALztitAyFR2g3kkZc1EGd
	D/yfwNIBJkakZPiVuhQDl4uMBY3ezXv0Jfok4BojhWIpdrRvOQByo2zKt4OCIHUDgo81cI/QBwg
	pHqSOAWXmmqTL7UjTRMF4krZLwtw=
X-Google-Smtp-Source: AGHT+IFdi/0GLg6z3B9P6WE9uWvrKWEOG+L6d+sxV2Beo0lP+WWsTzrGN/m9asLbpbHWkRNiy2eRpwQU73DiyR9ueo8=
X-Received: by 2002:a05:6808:23d0:b0:3e0:4db9:8c44 with SMTP id
 5614622812f47-3e5d222e336mr867239b6e.27.1728717954109; Sat, 12 Oct 2024
 00:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012050611.1908-1-linux.amoon@gmail.com> <20241012050611.1908-4-linux.amoon@gmail.com>
 <20241012062033.2w7jbfiptvdlklzl@thinkpad>
In-Reply-To: <20241012062033.2w7jbfiptvdlklzl@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 12 Oct 2024 12:55:38 +0530
Message-ID: <CANAwSgS68sL2JE5wafq98gFV-jhWFx5594Ax6+aVW8mpiBgHnQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] PCI: rockchip: Refactor rockchip_pcie_disable_clocks()
 function signature
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan,

Thanks for your review comments.

On Sat, 12 Oct 2024 at 11:50, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Sat, Oct 12, 2024 at 10:36:05AM +0530, Anand Moon wrote:
> > Refactor the rockchip_pcie_disable_clocks function to accept a
> > struct rockchip_pcie pointer instead of a void pointer. This change
> > improves type safety and code readability by explicitly specifying
> > the expected data type.
> >
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v7: None
> > v6: Fix the subject, add the missing () in the function name.
>
> Did you remove it in v7? Please don't do that, it just increases the burden on
> reviewers.
>
> - Mani
Earlier, it was reported that function () should be used in the function name.

Thanks

-Anand

