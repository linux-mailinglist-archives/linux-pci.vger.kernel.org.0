Return-Path: <linux-pci+bounces-16178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE09BF993
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD2C1F22187
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE21DE2CD;
	Wed,  6 Nov 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekx2C9jZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303813A244;
	Wed,  6 Nov 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934022; cv=none; b=Zgk3prvk8jSR1DFVC0a11kS2J1fZer5nGoXAuOB6fHTWMfB1i+q7M5UUvHBtKUYYjKbRnJfKDX9FU5M+2eqDMZG6mOVm8YQjZB/CBau3sXCjMCSpq1gQm1yIg8zWMxO3hMseT31SHahOG/nE0yyaedRnmxVkb/cVd5PekVcpbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934022; c=relaxed/simple;
	bh=ekYSaQc3UpI6lAdcOHKDSEFeDzRTnrJnU6bzQ5VCZ+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaihDPO4JdnPZ3THx3IVW2aClCQI19yJ3a7qOe2eetBCL8EYQj1PMC0+2vZk04IK/e+D5I7M66jihHnBnyk2PxjvXPseCxRk+T1wtl3RkIzHc2S8m+Qs2RUOJYQTjNjaoX7nJzlBITMbGg6SPU05/nW9preNUP2wFfVzFCQ4Z0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekx2C9jZ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84ff612ca93so134618241.0;
        Wed, 06 Nov 2024 15:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730934020; x=1731538820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCr20x8z8sRkhTPvZqrUzLvN/Ib1WmukL+yzAP4ZNi0=;
        b=Ekx2C9jZLNuWC9K1Bjd59xLxpbjIMy4oBU+7KMnFb4Y73uxXPWVLYEv75dXnsvl1Sn
         dA2Vn2Dyzeqw8Om4dwfTf+oEQGI606edBvTICalpyMIFFZsYNzlndxFXF/Q1TFeBMO3w
         syEB4Q5mrqaVxUQPvDTwwcQ2tQhO6BPIt+EW4mNZfd0co9MF+UzxfhOiGltj22r90sQ1
         sczGE6MhwiGqeyc5uj56wQhXepB16V8VUuSZcK+pSpn6huwFdbyMCBl1aJNeCMjKe/02
         zS8tdmL4iQpK9sKiEJqYg7TRQ9SQ2JpQIBavCKJeJgaemxn7bPma5AyEEd12cJHt6fc6
         8jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730934020; x=1731538820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCr20x8z8sRkhTPvZqrUzLvN/Ib1WmukL+yzAP4ZNi0=;
        b=T3yj2HidSI/YzVMYWHsr8yFbql8DBsmYLldRtbwpjNgeCfRETZWIS9KQGp6G7aVVYf
         BauYTNKNibymdGnLd5vENtrE7Oyd9AmGlBirpqpzgYRwTJkKLHaHLiJl3n4yvMirQ4dd
         +88O3kX0LUl4JA4vrj8puLCS09e+QMIK8pS+vJOX7FdQzdnD/EbIQdzv6Hxtf5BiOThV
         JJ4+jif+aVaoz6F1npyc/wMQc51V5awM5hnEEB4hafb5GBNH5RXmxDIjKHOX/e2Xe5PD
         aI2CB8hi7W1RjeKY7yOFdyhzurXBTLe0nuvuZpCRyN0/4a95MQAtacYPVykwxlD6Hd0K
         XP5w==
X-Forwarded-Encrypted: i=1; AJvYcCVBeiftRjYlQO+4tZpsjSVJU5BbFgJo3xpGEgPDZxgTbYS/Vg2mfffvt+p346bbabYWTFy6Og01QNBb@vger.kernel.org, AJvYcCWCfwkt2KyE0T6qhiBCGgQi4pS6Xb0bTerztAYSSmJu2unJFo1OF9PubLPlYBwLV45QK5YT6lvkonmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzWehM2oMwiR2D0dEN5edpFfeKGYErPYp3LtLawetIZZz5pEXJN
	NS00kkjkHOxXn6mQHOxWqWWz2ME/9gUvyk1Xr+/QPdRxwsG90jBE3g1ORUtnAS0H5ogOs9wWG30
	BhAxMpdMeQjX/m/KrgQXOovaYWd8=
X-Google-Smtp-Source: AGHT+IFo1RR/AdVhpssmUpxzpPIge7KofwhVYW5Ad3uzitsFg+8Ea84XoncezE1UFB6bQpJj6zNAhVjXGdNO8YtEVEY=
X-Received: by 2002:a05:6102:cd2:b0:4a5:ada5:7b27 with SMTP id
 ada2fe7eead31-4a8cfb4c602mr40754597137.9.1730934019692; Wed, 06 Nov 2024
 15:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aca00bd672ee576ad96d279414fc0835ff31f637.1720022580.git.lorenzo@kernel.org>
 <20241105213339.GA1487624@bhelgaas>
In-Reply-To: <20241105213339.GA1487624@bhelgaas>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Wed, 6 Nov 2024 18:00:08 -0500
Message-ID: <CANCKTBuxKA8JdfYMCcGS=CpyuXGiLz1NdereCjqo-_2Er3Pfww@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, linux-mediatek@lists.infradead.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, nbd@nbd.name, 
	dd@embedd.com, upstream@airoha.com, angelogioacchino.delregno@collabora.com, 
	Jim Quinlan <james.quinlan@broadcom.com>, 
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Jim, Krishna, Vidya, Shashank]
>
> On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > PCIe controller driver.
>
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
>
> > +#define PCIE_EQ_PRESET_01_REG                0x100
> > +#define PCIE_VAL_LN0_DOWNSTREAM              GENMASK(6, 0)
> > +#define PCIE_VAL_LN0_UPSTREAM                GENMASK(14, 8)
> > +#define PCIE_VAL_LN1_DOWNSTREAM              GENMASK(22, 16)
> > +#define PCIE_VAL_LN1_UPSTREAM                GENMASK(30, 24)
> > ...
>
> > +static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
> > +{
> > ...
>
> > +     val =3D FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> > +           FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> > +           FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> > +           FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> > +     writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);

Not sure it is worth the trouble to define fields.  In fact, you are
already combining fields (rec+trans) so why not go further and just
write each lane as a u16?
>
> This looks like it might be for the Lane Equalization Control
> registers (PCIe r6.0, sec 7.7.3.4)?
>
> I would expect those values (0x47, 0x41) to be related to the platform
> design, so maybe not completely determined by the SoC itself?  Jim and
> Krishna have been working on DT schema for the equalization values,
> which seems like the right place for them:
>
> https://lore.kernel.org/linux-pci/20241018182247.41130-2-james.quinlan@br=
oadcom.com/
> https://lore.kernel.org/r/77d3a1a9-c22d-0fd3-5942-91b9a3d74a43@quicinc.co=
m
>
> Maybe that would be applicable here as well?  It would at least be
> nice to use a common #define for the Lane Equalization Control
> register offset from the capability base.

FWIW, these registers are HwInit/RO.  In our (Broadcom) case we have
to write them using an internal  register block that is not visible in
the config space.  In other words, we do not use the cap offset.

Regards,
Jim
Broadcom STB/CM
>
> Although I see that no such #define exists in pci_regs.h, so I guess
> there's nothing to do here yet.
>
> The only users of equalization settings I could find so far are:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/controller/dwc/pcie-tegra194.c?id=3Dv6.11#n832
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/controller/dwc/pcie-qcom-common.c?id=3Dv6.12-rc1#n11
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/controller/pcie-mediatek-gen3.c?id=3Dv6.12-rc1#n909
>
> Bjorn
>

