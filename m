Return-Path: <linux-pci+bounces-11155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956A9455D9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 03:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7EC1C224D2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 01:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3AE56A;
	Fri,  2 Aug 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rCDxwrBH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3179F0
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560681; cv=none; b=Nz1oTqWHuEdtCga/LAUKiQsj/BODfQo3qehwFhI+s4s5msYJBTj/A5ES01a8V5EaofLmyHzbL6Macz4BTGG6u6JT/aHjtIEWBv72B/SILh+bSgsQuQFJ2y+ncvHdwsxVT2cn5BfTqW9oa3fpBfxBSMngTANhTxnXoQJcdz1woF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560681; c=relaxed/simple;
	bh=qhM7Rkoo/wjgyet+sVe9Ojyo+y5fgscuRJSoHTiEu8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSOsRjt0a525LrfpCrCykcJBhIgFEXZBWMqR2CtwW2SX4DJLetvWvksWVoSdjzeyr8BTfQ6g7oDERqw7pXBd2gRkYXJZVyKOuStLtFsFleAmGNGc3onj5YTcl2Ueli6A3v1J81aGdVjNPG3cX8q8SIoKF8n6Y5yJSbXSiyKKAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rCDxwrBH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D94EC3FB67
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 01:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722560676;
	bh=+ZPWBr+Q3IbRsWrbuL1qMThGGqMu0789Q6IwfLEtpY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rCDxwrBHAdQBE1yJUlYGv7Ft4wpujA2isQGze7FMwsQbF5czDZmqJRz5XxsINYG5P
	 j/alSxFUliDWeZeRTdYVZ0jXz3Eays4wRku0JgV6UPmmvFOh/rLR0fGNtcum2GQgcp
	 6C97CEWC4bIPhb+VhD/OBvFa1NxQiYwuDvca8OqsnsVjrj0Djx6fYGWjclBju98x2E
	 9PDRveSfOwy7u5UKNqI9iPoFcn3jzQikAQLy75zYvPxS26boj2EYwWJNj8dEDI3QMy
	 R86UDdqVBjTbhR7ZELeD6Fmozcc36R8uyOpn31xqThkarbfS95fcUK0jLaaRueKpXN
	 SB7ISctf6I7vA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb6b642c49so2845625a91.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 18:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560674; x=1723165474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZPWBr+Q3IbRsWrbuL1qMThGGqMu0789Q6IwfLEtpY0=;
        b=hjf5tZpGDBTP9y3j+hdNIiNXeG56NIIa30mYG+xCPRp9NDbGTI6TFTUtT6L60GgIlh
         a/o/HsPPNvv1Abcfyk/yt/k4EnWbc2d6jYmRUVfaicgsbpvenzTmu6exxqIny4/TUnOd
         gyH9l13micZRJGxxZh+VunyFs0ZTLx+Yb9xjTxXzADRxD6QCEhjp7k2SNixmVF49qw26
         IVY8y61IygLYtGVGiEnxvRoJ4g/UAvtSewx+IgbzxyAauqThkXXki9fQibLZ/a3fbdvX
         EROZxC8FReUYFeKQGwx74Aesu4sH4uoFTKX3qmlXgnqf2n7ooo6ljBSSXHCWEmYDtb9/
         516w==
X-Forwarded-Encrypted: i=1; AJvYcCXm3wRprtuDAq+SCeDQOCpl+OAB7JhJpBPWTrf53ATzfpUc81pTGLQbU9vR3hnc7dHR6GXJQZB5LG7pQ6SIpzrzpVYaPrbWEKqd
X-Gm-Message-State: AOJu0Yy8pfZOyyWlLl6r4Eyi67EkbFQ6o9P/2GR1QUlhCZtC+7nPTQAP
	u9HXVvG3WZPAfOg6KwzDwjxIH3Ie/1Mf/bGB8J4lrld3P5f4dCrcwK5mxhA+ITXV8vgDyQh4dvH
	9QF83B2K9bZxiBLqR1SPg/Z1n/hjf5hb3KnsbEL7yb6aMnqyQp/JfUhxP1yX8pNH817Viw3B/lq
	J2NSFwFKP0BPikSLJF2uJ0lM4c5SFqIla/A2VWG3Buz5gUfMA52FBbGgzaqcw=
X-Received: by 2002:a17:90a:bb81:b0:2cd:40cf:5ebd with SMTP id 98e67ed59e1d1-2cffa0ae819mr2788359a91.5.1722560674112;
        Thu, 01 Aug 2024 18:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi1XbnIuGlbutYrJYDsV2mpUlSCSSjGOSbhqAhT5XfgwjkLY9Xoo5Lh/RtULrVhIg4zRHNi+WyHSEwurJ43oQ=
X-Received: by 2002:a17:90a:bb81:b0:2cd:40cf:5ebd with SMTP id
 98e67ed59e1d1-2cffa0ae819mr2788327a91.5.1722560673667; Thu, 01 Aug 2024
 18:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530085227.91168-2-kai.heng.feng@canonical.com> <20240802000414.GA127813@bhelgaas>
In-Reply-To: <20240802000414.GA127813@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 2 Aug 2024 09:04:21 +0800
Message-ID: <CAAd53p66NNOaD=KdvW911gKSf+QOSCik9c-dJmn6zQqXaoFQXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: vmd: Let OS control ASPM for devices under VMD domain
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com, 
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com, 
	david.e.box@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:04=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, May 30, 2024 at 04:52:27PM +0800, Kai-Heng Feng wrote:
> > Intel SoC cannot reach lower power states when mapped VMD PCIe bridges
> > and NVMe devices don't have ASPM configured.
> >
> > So set aspm_os_control attribute to let OS really enable ASPM for those
> > devices.
> >
> > Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LT=
R")
>
> I assume f492edb40b54 was tested and worked at the time.  Is the
> implication that newer Intel SoCs have added more requirements for
> getting to low power states, since __pci_enable_link_state() would
> have warned and done nothing even then?
>
> Or maybe this is a new system that sets ACPI_FADT_NO_ASPM, and
> f492edb40b54 was tested on systems that did *not* set
> ACPI_FADT_NO_ASPM?

I believe it's the case here. Vendors may or may not set
ACPI_FADT_NO_ASPM, so f492edb40b54 works on some systems but not
others.

Kai-Heng

>
> > Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83d=
d48@panix.com/
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/controller/vmd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> > index 87b7856f375a..1dbc525c473f 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -751,6 +751,8 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev=
, void *userdata)
> >       if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
> >               return 0;
> >
> > +     pdev->aspm_os_control =3D 1;
> > +
> >       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> >
> >       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> > --
> > 2.43.0
> >

