Return-Path: <linux-pci+bounces-26723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888CA9BD79
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 06:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F999920F54
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 04:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD915C158;
	Fri, 25 Apr 2025 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEQOndB+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7221348
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554759; cv=none; b=Q1QllOBD/fHhtQkNzM5A2tkExBte4elWjeA/cK0fLKZMeWKxtqR5avz6LoYDoKty8Jo9HnEB/jjyONaIMVE3giclJzljFwE3aeTckKT07Jm5j6NIIMDrnsbUdzcEVZDEabsqyIYVyYMZP1YbmLMhod/MmeSLHh2ABOYWI2ZSdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554759; c=relaxed/simple;
	bh=AwJXzKVf5Idq0A9ztAoUzFpVA0NGYpVb2KKCC61Enwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ssu7q2EjQK7CS9pldaUgSDwZIjzADb38X/kKRquEJGJy3bELcV0ST0SEUFvqqW88zSob6sH0opprzBPofakwxARHi4Qk+TWw9qn0JuXBMHxAkiHuE0hpCmjnTRPwXuhuEoFaa6fFaTgpzWonLnNQszpSPoIbmplMIPsYPawqSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEQOndB+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70825de932bso26026207b3.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745554757; x=1746159557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1FFX37NUNshsy2J5hJCJdwU4AE7jGWv/GpE4pJa4d8=;
        b=OEQOndB+oZoyzwX1YODnIkZYhI8niA1/5rzHL/ss72EHdhcjGmFquqhbL1ytRBPb6Y
         Ntx2sVFiu6kQfhs0wD4+LF/orhHqhu4KP4utMGhyeaQ6rfPre7z4POEExGfk7Iiij2CB
         MyLx8X8JAz5fp3vuk/dusculQ/1G33e7d37Dg6NrVPJxUR1g4iANFpOyrKFueLrU0cJV
         OCA1jXvYm09t8DkMCzp7ZAm1sOnGEb+FS6cPYDeHXVbfZEjC6O2YHeCZncxL5VIN3EQM
         /aPeTpPcW4H7+fvAcHiM1Z85/A/mAV/Q0BrR+7iytwWe8F4pPwxOiekiNxQem3JKrSCk
         074g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554757; x=1746159557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1FFX37NUNshsy2J5hJCJdwU4AE7jGWv/GpE4pJa4d8=;
        b=cG/KX7ir4fnHtwBVyvF3L2wVbbyo7ANkwXUI4WuhUyHB378pOlnOWBOcrESeK2xQbw
         mDGWBGNll+ugCpCTNH8enZjrMgzwB80jgMh7Opu/LjCow7OnKbjfNO9W3F2yUK/5Losr
         l7TVe11ROtlDnWn/qtBOdN3gyMqahtNHqJ1+ArFgAP468NhmmLq9IteUL6gTqdetuoJw
         vnbvneU+keBqQgyuP0NIbw8FCcyKc+KjooSP3bDVzSmwRNPCehnkyJewT3ifX3lXyyu4
         LaZIV2cyjuDYRbeuFsqAh3sJTPsGZX+t9tzPpL5s4cs91bBs3brFRhrqNJOIzYARzl6g
         slaA==
X-Gm-Message-State: AOJu0YwZ9GxSBCNDHQbhgiK1khDEOT17/BMJr0zjwoi4mwqxcW2IuMnC
	DGWum1K/KcwaSmZypggvg5pOGE4+aYgNL8K35mOrgSEqlmhXtvKpBMN+tj0QyLGUlxaJLrhRUgM
	p7ae+9gFBzVyXcYzMKbcAM1Dprqs6Bw==
X-Gm-Gg: ASbGncuxMtqu3e4lFnIG4rsALDZPlut9tH+37RPAXsoWskrbl86fYUfBffekxrWvFsb
	mscEg248ebRKWPqwyMjXMX3a5etXo8quVs/ELl+Mdyphi4kBL0XZD59SPtewhzxON5xApDP1P55
	KAg/u1QVft5tna1ymLHCzfAg==
X-Google-Smtp-Source: AGHT+IFXX3Z7/bxVfNywBTLLxAqxbXzzvrR+1Wz6ZxF3O4/GMqd8OopmTOAat3sTWVDMUmtLBZ65Kq0DRuZvtnGS9Fc=
X-Received: by 2002:a05:690c:4a0d:b0:6fe:c2b4:f099 with SMTP id
 00721157ae682-708418a9464mr57566197b3.7.1745554757382; Thu, 24 Apr 2025
 21:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTsD40J3PAv4LXit6oTmJmeZOVjN+FG-PN2Aj2+KyPFahA@mail.gmail.com>
 <20250424171337.GA492527@bhelgaas>
In-Reply-To: <20250424171337.GA492527@bhelgaas>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 25 Apr 2025 09:49:06 +0530
X-Gm-Features: ATxdqUEtL73lcrnI2wSOu-BdwxCrpbkxoZQWl1Qhs-KUdLzkPqaF5IrpafAhweo
Message-ID: <CALfBBTuTgcUzyE=G2zrCOdvnBTrSO36E09B66Lsvru_YjqH-Kw@mail.gmail.com>
Subject: Re: Problem with kernel rescan and realloc BAR resource for endponts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Thanks for the quick response.

The DSP memory behind the bridge is 32M and the EP BAR0 requirement is 32M.

Looks like the issue is that the emulated EP was not honoring multiple
assignments.

Will reach out if I need more information.



On Thu, 24 Apr 2025 at 22:43, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 24, 2025 at 10:19:44PM +0530, Maverickk 78 wrote:
> > Hello,
> >
> > The command line parameter
> >
> > pciehp.pciehp_force=1 pciehp.pciehp_debug=1 pcie_ports=native
> > pci=nocrs pci=hpmemsize=256M,realloc pci=noacpi pci=realloc=on
> > pci=nobios
> >
> >
> > There are a couple of endpoints connected to downstream ports on a
> > switch, and the endpoints are not visible during the BIOS (seabios)
> > enumeration, but they are brought out of reset just before kernel
> > starts pci scan.
> >
> > Even though the kernel enumerates the endpoint with proper bdf and is
> > able to read the config space but its not able to properly program the
> > BAR register, the lspci lists as
> >
> >
> > Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
> > [size=32M]
> >
> >
> > This is an emulation platform.
>
> Can't really give any suggestions without seeing a complete dmesg log
> and output of "sudo lspci -vv".  This will give insight into how much
> space the devices require and what space is available.
>
> Bjorn

