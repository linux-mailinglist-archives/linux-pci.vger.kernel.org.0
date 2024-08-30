Return-Path: <linux-pci+bounces-12521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC496666E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B47E1F259F0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C5199FAB;
	Fri, 30 Aug 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="Gjtkbx7m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3D192D94
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033808; cv=none; b=ToYmWikFMBAj6WgjlTZVgVkFKjAvfRAEPi5hInh6249CDb6auM+TuQ/75u2hHGEbqBxoq/LDT9u8nvalxmyvAa2ezRlfw5KOOJG08cSSUv/+YJip9UsU+QMrDKYQHE9i67H97htKjOXUDT12tckmQ0gyOS7ODUqJhRXydk76/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033808; c=relaxed/simple;
	bh=ksEcxmrRgT9UafvDUHSs+zIoz94LPLhQy5/7oqWgpOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9gITuCtvUK32Yvmg6CdO1OzosMquj6ByfeH1KO8TKvhD1v1BDNujvRQwtRQvR4vXNtaRfrP2zh74jhoDUkjlKb1ubDOXrgfhAZeoBpsg7GTw6i5VwXmOdKmDyfW8Z7fWJYAs5xjPYKBxSES933WCuP3dLxKK4PA6kAmwTTneGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=Gjtkbx7m; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so2233894a12.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725033802; x=1725638602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSxCgTGyc+YmDrRUAaBuR+R/BIs9IGWGgzxeeaiz8Qo=;
        b=Gjtkbx7mV+8Hhgv/aDHIspd0zz8K2rKMoF6/JlUpy0s1gaCrOf3TuXKoEHFvTPu8yN
         VrWQ4nwRaeYG6pNlGRDOnPrghNA5Nt6lzIgLo8eri3BDiwcHwy/P/g33G0kXAoq4fL7Z
         8VNnEOxAFAZ0NZdFZ3NHJNpLFsssCINcY8fUu4h+XDMNSUbmfxe+3hZEaa9jE/j1p7si
         osBwnG96ZdvMEEuRYLEhpJlQrT/a0uqWjxcLC0QSGzZwnUBNgxieH9wOhSNoRhPuLcDj
         s5tRCR7j2itMe4heFNtjk2p4tCYEfPVsjdIGxq0QPjdZZoBWfBHjO8sRf2CEEknQiXcv
         ydKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033802; x=1725638602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSxCgTGyc+YmDrRUAaBuR+R/BIs9IGWGgzxeeaiz8Qo=;
        b=gc7+puS8zjYGE3dGY+P1rZNbWGClTTa8g6ju/svMoViIRIx0qbPU4tX9oPzBm/0Xnr
         umV2pEoRVajS6Jnml3+HQIuslc1CWeUuiOJxRuE61+n+5ouvX/HoqMKJDS66oLUNLcgv
         UlknjMTD/ho3AeEkr57zfLa51a2BFuj1RxGqqgZPo/rAZwLqvg2Q7DyVx21ec7qJLha3
         EJSw28WtfzrzUOZlTOCirqrdtezQcZgXu+/HPkZ8afBFcMna03AqZ0r0jar+vXV6M0ce
         C3Ulh9zuk4d2TC+c9pJuY3/jnR05IeoSIzsTF9lD26mza/NFEkFbRineCCP6iOMsYUef
         Da1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF7C1RGyiYs2s1st5tUG5t1d70ob/JroWkWt7ZNqOJ7FbY6ffwm9pYhGN4tmnKMutNCVSUCsr9A+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEM5dAZ1L3ZJoRyZRxymba19V2ErrGat3gvCMB1ydG73aiNJtu
	ej3VA3DkOC9K9xxfVsFXz96ZBn6D4agGCB1pLj6jxOOXfRNV7lEZMOCyqL2zecyfn9BlRnXd8ZO
	ltXWd3PO77WidXo/pyLQZyYYQSkjWgif6qOvxXQ==
X-Google-Smtp-Source: AGHT+IHAD4XF7Ig2atwtZDbPZ/ZzY555PhYCV6l4TqqycS4j/fUd45hOKtSjE1FP+zjEeatYxD+lv40iy+ll1S8rYcI=
X-Received: by 2002:a17:907:eaa:b0:a86:9cff:6798 with SMTP id
 a640c23a62f3a-a897f91ff6emr572130866b.30.1725033801627; Fri, 30 Aug 2024
 09:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>
 <20240829212235.GA68646@bhelgaas> <AS8PR04MB86760487CB68BC5AA90634AD8C972@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86760487CB68BC5AA90634AD8C972@AS8PR04MB8676.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 Aug 2024 09:03:09 -0700
Message-ID: <CAJ+vNU2e9__ftVct0zY56HGTkUyF_QEpEDN6_n5uCXCnQwo6Ng@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:50=E2=80=AFPM Hongxing Zhu <hongxing.zhu@nxp.com>=
 wrote:
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2024=E5=B9=B48=E6=9C=8830=E6=97=A5 5:23
> > To: tharvey@gateworks.com; Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas
> > Stach <l.stach@pengutronix.de>
> > Cc: linux-pci@vger.kernel.org
> > Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ =
on imx
> > host controller
> >
> > [+cc Richard, Lucas, maintainers of IMX6 PCI]
> >
> > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > Greetings,
> > >
> > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > device and the device is not getting a valid interrupt.
> >
> > Does pci-imx6.c support INTx at all?
> >
> i.MX PCIe RC supports INTx.
> Add pci=3Dnomsi into kernel command line, can verify it when one endpoint
>  device is connected.
> Based i.MX8MM EVK board and on NVME, MSI or INTx are enabled.
> logs of MSI:
> root@imx8_all:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
> 01:00.0 Non-Volatile memory controller: Device 1e49:0021 (rev 01)
> root@imx8_all:~# cat /proc/interrupts | grep MSI
> 221:          0          0          0          0   PCI-MSI   0 Edge      =
PCIe PME
> 222:         14          0          0          0   PCI-MSI 524288 Edge   =
   nvme0q0
> 223:        382          0          0          0   PCI-MSI 524289 Edge   =
   nvme0q1
> 224:        115          0          0          0   PCI-MSI 524290 Edge   =
   nvme0q2
> 225:        521          0          0          0   PCI-MSI 524291 Edge   =
   nvme0q3
> 226:         53          0          0          0   PCI-MSI 524292 Edge   =
   nvme0q4
>

Richard,

off topic but I've seen in the IMX8MMRM a claim that it supports MSI-X
but I have not seen this to be the case as you are showing above with
an nvme that would clearly use MSI-X if available.

Does the IMX8MM hardware support MSI-X?

Best Regards,

Tim

