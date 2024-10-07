Return-Path: <linux-pci+bounces-13943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DF9927D9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D6D1C223FB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8C18CBF4;
	Mon,  7 Oct 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsV9XaSz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03818CC10;
	Mon,  7 Oct 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292164; cv=none; b=WuEXaMOZI5A8cMo8X7pkLVBFOpP+pNzA+NfeRbq0IrnKnUQp9bRNG3/1NRDCQ6vFm+Ka9cc7NxTeCFJfgwtLQIiGLHqRAYbLWy06dqnFh0hX85L3UWv0QkqTTdyByThMmCLIpub1HK6STJFkJEfkgUvOYbYxTw3EzlQ6QBVHzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292164; c=relaxed/simple;
	bh=Su8XUq+sJnz9NdA6tq77XAy4mDQAg17s693MdewAyXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXH/S0qLhEDRXrmVsw7kp1LNjkm/LEOZ/z85WyzTPzvQtBXJOViPfwzoF3AjMRP/O3YECiWNL4knx/icJcusdvpofT2Rvfvhp2YFJEFH9oyooqyl7wlZF4wrhO03nxiL1qjmaDkcP/b1OnsClb7cNweB22avmTLhFwq/RIVal6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsV9XaSz; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e7c88a9af8so2208827eaf.1;
        Mon, 07 Oct 2024 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728292162; x=1728896962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vO/wVWYQXa64Ph3Ozg7JWxoIsbitIFEplk6FEILOj50=;
        b=NsV9XaSzT2pOfqdxHCqqyadBPizky1Bydha3rp1vHkoxAuws1DywPFuz07rx0l4ply
         RXlGCFwcWy2DKQ+cMML+IvDwTG2x+sFtcqgBf72a5rWX/vS7XhedPU8chvj0FF48QnQe
         8Q1ka9NOcW1a3ZDFHKV6bv+HR9XZFBfS48MiGyyDlW0ftJLQaIe1DuTZBr2E5Fzq2nos
         o3hzBJ0vuDdcTQPF7yhhYOBsQcO7xaxiHjQi43grZpevY6eCAeZs5Ux3+P7scChjcd+t
         O7KUSc2YiaZHWnuhyB8dUHn8ZcZgQsBhilK1KNcX7eaFr4vyat5AJH/uuTpCuhHjaaAx
         tCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728292162; x=1728896962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vO/wVWYQXa64Ph3Ozg7JWxoIsbitIFEplk6FEILOj50=;
        b=xDpd8kdmGPxlRKfmhfL1IUbNmU7PAc5+gxVXKLoVMS3ot6yyiRGmFNpfbIiHeIiFF7
         bdjNIWP3RvPFuSZ1KL5eHp9tWHSRXPVS5V/UIwA98ju03q/YWtvaaAQB6cvNwd0qLeZG
         UzfToAxzpHnmasyB2Vc9V+U91KBlVvek9OA5uGaPQKWsVtIWNgQG6RJjmJnpk9GL2HFe
         fYiMiXdkUGrB6NzyYXa4mVF8giQy19JA/ezgnfxP51UINdEB35AsVDl+LfE6BIjSeWhL
         o8Z7VJqIQRXcjP/ECm1iCStiRSqfWgcyQv/CmsPTI40Ab0iENNSM8twUmqDgdqwcAevw
         lJHA==
X-Forwarded-Encrypted: i=1; AJvYcCUPJcJdHfQKW5TC9sVmSCJLMGhLksQrPzcn1QoL3k23YzuWOa7bFG1zJAraTYqkevrcnh9vQhoKnpM+@vger.kernel.org, AJvYcCUgpeNVhkUdPVHRswogfMJJ74wEqErWQ/G8H87B+RHrMfououeE78qE4ryJ6PGVPhApZi0V30qenvbCFOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5Fzk0FSIoPKthPGDDxjgARzUBObP2c36pdvzKre1lXeopQVB
	s9O5/r0plDiHR2G1Pq+8/Lo4p9IQVEgT7Onfuo1rqqcPh6NvvaSHu6A/oywRp8jpaQbCEzLvoRy
	AVlWklyH11n9Y4xyS9KK3l6rqg78=
X-Google-Smtp-Source: AGHT+IGSN2hd+1S8H14t4yjBgBmiF/vETV1Pwx57/H4xXqwPC+rL9LS9yvqub9DTBWgck3LWRv7Ipy7SvuYPdCx1KAo=
X-Received: by 2002:a05:6870:700b:b0:261:360:746c with SMTP id
 586e51a60fabf-287c1db2ccfmr6469356fac.19.1728292162473; Mon, 07 Oct 2024
 02:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006182445.3713-1-linux.amoon@gmail.com> <20241006182445.3713-3-linux.amoon@gmail.com>
 <64c560c483f09d90c788eb949890d00f3b94cc87.camel@pengutronix.de>
In-Reply-To: <64c560c483f09d90c788eb949890d00f3b94cc87.camel@pengutronix.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 7 Oct 2024 14:39:06 +0530
Message-ID: <CANAwSgS15E4-KzexTqEYd4=o3ew9GvigEjBCZ-dAUs0No_b6Hw@mail.gmail.com>
Subject: Re: [PATCH v6 RESET 2/3] PCI: rockchip: Simplify reset control
 handling by using reset_control_bulk*() function
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Philipp,

Thanks for your review comment.

On Mon, 7 Oct 2024 at 14:14, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On So, 2024-10-06 at 23:54 +0530, Anand Moon wrote:
> > Refactor the reset control handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for assert and
> > deassert reset controller using reset_control_bulk*() API. Using the
> > reset_control_bulk APIs, the reset handling for the core clocks reset
> > unit becomes much simpler.
> >
> > Spilt the reset controller in two groups as pre the RK3399 TRM.
> > After power up, the software driver should de-assert the reset of PCIe PHY,
> > then wait the PLL locked by polling the status, if PLL
> > has locked, then can de-assert the rest reset simultaneously
> > driver need to De-assert the reset pins simultionaly.
> >
> >   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V6: Add reason for the split of the RESET pins.
> > v5: Fix the De-assert reset core as per the TRM
> >     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> >     simultaneously.
> > v4: use dev_err_probe in error path.
> > v3: Fix typo in commit message, dropped reported by.
> > v2: Fix compilation error reported by Intel test robot
> >     fixed checkpatch warning
> > ---
> >  drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
> >  drivers/pci/controller/pcie-rockchip.h |  26 +++--
> >  2 files changed, 49 insertions(+), 128 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> > index 2777ef0cb599..87daa3288a01 100644
> > --- a/drivers/pci/controller/pcie-rockchip.c
> > +++ b/drivers/pci/controller/pcie-rockchip.c
> [...]
> > @@ -69,55 +69,23 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
> >       if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> >               rockchip->link_gen = 2;
> >
> > -     rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
> > -     rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
> > -     rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
> > -     rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
> > -     rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
> > +     err = devm_reset_control_bulk_get_optional_exclusive(dev,
> [...]
>
>
> Why are the reset controls optional now? The commit message doesn't
> mention this change.
>

Oops, It should be  devm_reset_control_bulk_get_exclusive(),
I will update this in the next version.

> regards
> Philipp

Thanks
-Anand

