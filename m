Return-Path: <linux-pci+bounces-13000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DA973DB7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C81C1C25106
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573211A0B10;
	Tue, 10 Sep 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="iJ8rkFqX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260F1A0729
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987019; cv=none; b=CuRXqCCHjS/wzY5c/VqfXAPmcBsgNSpCaFTyKUCCPrUUceGF6U2f6RJm0XggZLiRgoAPahQz9EpRYbbHFHOULnyqSV+epqgcUPJoXulttYN1q7jybXAogM0VQ6rbLKjKtm4w6HGbA/MtFHjLnWqYExi4PM++Tt/WkMIIx/q9WeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987019; c=relaxed/simple;
	bh=/a1GiFtWgyr1Dr/9eYBGZ2Ylhaw0vnFXTO7+0OsOYYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcoJLVofLtwdo+H8Y49qTKO76eW24G7QoDxikc3meBO2AtQccLxmZ1306pW0vcMEaIIN/h1ozUUBI8AQvpchNNkeQ75yglHzhZcAFd0JypnsXhMlkQCIGLNz9DEU8fGwu+VMBSrhMjHhYuWhW2/vb1IZqhm84wBFGWMuiNF9cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=iJ8rkFqX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d64b27c45so300790066b.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725987015; x=1726591815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoZM2ZKZs7DtZ9cjXDDQHYs9xIbj4XnMvziKMGP7wYI=;
        b=iJ8rkFqXPUpn1JL54DKohjb9+V5PHIm0gx4MQWA4FvkXXrih6fNpjRDC3YOoy2gyy1
         FOQ97ygoE/qNyZ2TCnS4QXaWGg9mdHR3p55I0La5L1UmiEdfEf6qM7qBDJMgUU5UiL7Z
         VNKNiYkQ5LPzdRz8w96Ni/UX+TmXLBCNJZIANazs7164V+gm5a7SX82HViiNe9q+wV7g
         JeIJTvqNw6NSChcJ1VC/XP+N6KTQHDTbHU0i+VeHkl/YkdrTn+KXaRe3sRM16g48Z6g5
         iQG6fK+imh3zy/J8hP7KUzbrKRaesf7vsJJnaf0Qk8TQHdmdoMmOxjjIuU25j6h0m2Fv
         V0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987015; x=1726591815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoZM2ZKZs7DtZ9cjXDDQHYs9xIbj4XnMvziKMGP7wYI=;
        b=sZlbN+pFQltxF1CJD/iAyAB5DjkUfyce5bv2NQy6TjMAgQIcJ3BLjphp4qJxhedcNO
         A7AoL0pkFznsQ04pgD+TEH5ZxNjdlX7gic3CInb6yxPWy+GUXRdTr4KeUF6Zmm+eAZah
         /4B/rqJYjP+PCsEEESSPByAnVqGSry7epueAHJQeIS/hBQerBMARiyw5vg5xUwDpbGt3
         k5gUs3dm6bnaMkauzOn8eUwVyuvhGHsulh2OTyCTW4FSoJCFauvilL/38blxBxB5BFCg
         3c7iWFSbRuTCsG9Kb/CkfyWT1dgx7Iq7o0w5CmTQ8wcXbWvWqD82yUu4hItD8qGjKDOI
         7NIg==
X-Forwarded-Encrypted: i=1; AJvYcCUP8W32IZ0GFQ37SQ+YyWwE0U2bXjVUYb+gxgI6M7Bz98BsM9RsCFwMKPuB/eJl/5qs4qKTU84T2Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcq+pCjYb2xEK8tSXeQNBnP+fA7HkQ7uCpyN/kyk1r3srX/Emj
	WSmkM9/y1VptHynEqUTQ/+I3647cDITUQCC+gPaUgzviwMZUIVau2CHCkbMLSB8TH7uGA1tMTZI
	zeGEX7wLkzXwJkbDpN4Puwa/7Mn8F3yDjhia8BQ==
X-Google-Smtp-Source: AGHT+IGXTCPd5uQw5i2bRf9ZtWJO/Rm/Jpp0E+MtOFkGK70d0la18H9O1tNo70ezuufBtFjr3PYu5pBI7SI3KLb4yZ8=
X-Received: by 2002:a17:907:2d26:b0:a86:6a26:fec7 with SMTP id
 a640c23a62f3a-a8ffab88fa0mr132930066b.30.1725987014630; Tue, 10 Sep 2024
 09:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU1=XqwpzREwo_aNoRwZrMMRpxw_9qvrUW=iU=5u5PjReg@mail.gmail.com>
 <20240906195811.GA433355@bhelgaas>
In-Reply-To: <20240906195811.GA433355@bhelgaas>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 10 Sep 2024 09:50:02 -0700
Message-ID: <CAJ+vNU0fuoBtpmKSs4hgi9=deBazML+KSJy+cqkou6mPumjwvQ@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:58=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Sep 06, 2024 at 12:37:42PM -0700, Tim Harvey wrote:
> > ...
>
> > I have the hardware in hand now as well as the out-of-tree driver
> > that's being used. I can say there is nothing wrong here with legacy
> > PCI interrupt mapping, if I write a skeleton driver that uses
> > pci_resister_driver(struct pci_driver) its probe is called with an
> > interrupt and request_irq on that interrupt succeeds just fine.
> >
> > The issue here is with the vendor's out-of-tree driver which instead
> > is using pci_get_device() to scan the bus which returns a struct
> > pci_dev * that doesn't have an irq assigned (like what is described
> > in
> > https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci-devic=
es-manually).
> > When using pci_get_device() when/how does pci_assign_irq() get
> > called to assign the irq to the device?
>
> Hmmm.  pci_get_device() is strongly discouraged because it subverts
> the driver model (it skips the usual driver probe/claim model so it
> allows multiple drivers to operate the device simultaneously which can
> obviously cause conflicts), and it doesn't play well with hotplug
> (hotplug events automatically cause driver .probe() methods to be
> called, but users of pci_get_device() have to roll their own way of
> doing this).
>
> So I'm not aware of a documented/supported way to set up the INTx
> interrupts in the pci_get_device() case.
>

Hi Bjorn,

Makes sense to me. Perhaps some changes to Documentation/PCI/pci.rst
could explain this.

Thanks for the help here, glad to find there is nothing broken here. I
think there could have been some confusion by the user here because
they were used to x86 assigning irq's without using
pci_resister_driver() but they were also using a kernel param of
pci=3Drouteirq which looks like its an x86 only temporary workaround
that may have made this work on that architecture.

Best Regards,

Tim

