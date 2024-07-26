Return-Path: <linux-pci+bounces-10864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423BD93DC6A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 02:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE45A280D17
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2024 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C92155306;
	Fri, 26 Jul 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CtJDPhIC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C0153BF7
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722038378; cv=none; b=VZk2ULIi2wHF+rayxhaV0w3giQPf3Yqe1NItqKjVBvJpSYH6bWnOJkr8D88jipOViM2Kso9FzeO7gZ3uj3wcZCGsXxQ8s5GLi62S7c89Ka6Opwj1mtAgf7iBRCtz36p3Lp7CusPDwNYUc8NghGlCFEDztXGB/US+7mT4YKD5kDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722038378; c=relaxed/simple;
	bh=m7LuLCjQ/j+TTkkT59oo8ZrDtTBwZjxarsE1h/MTodw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moHVy/S25kvBmb5r/C83PFDjzFGC2s7/VicdhkKWhb06hvmYepHnHlzEbyZcKRo49bOXS9qIxXNvLXDpYaMqohYyLBJlq3HQZVPzKcmgJTsnJdDxgX90DQRKQqRAKmSkVHTs6MGT5fDNWR8tQKAzPUKm+FEHy0KnhOMfAUvmDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CtJDPhIC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd855adbso2617752e87.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 16:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722038374; x=1722643174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ALvoJaa39vJJ5aGLOtMJDC5BISEBE6uiZ0PlObc8xs=;
        b=CtJDPhIC3or/V70HepFJBTD6aV0aVdBsNdyZ2RaNrjTJxUqGI8dVv1NyskTD6fuBk+
         Q9dYgzFeauU97rvefQfBuAFd28d3MlM7QsWwpR0FmouUnZ/D2m77LH6/UEdkfBGaSjZd
         W18sN7ot8zuCWcSk4bzZXkNAHq8zYXHWcmmWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722038374; x=1722643174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ALvoJaa39vJJ5aGLOtMJDC5BISEBE6uiZ0PlObc8xs=;
        b=DMMGeEtovblbqnro1A2qY4/Gwmbf6vmIycWs70M/o+eYBO8fNN9Gc3aEfcQ12R1P2V
         iT4zVdca8ReQQUZhW1wwIhYdrcgmvsp7XRMn5dVQYKYRZeGGdi1t2qwClLekzh9az2n+
         hw8DjuFG1wL7t0Nq2rBEeKFX/g5xmVrayfYVjpzafcJdc4CcM0DiuCKSDO9YH2goqsV2
         hPgfjUOXenPC7KN4xcU/cDpfJXfzFcK0viQ14n30nP92pkxFJNTIZLRcQWaEp3V7PV1B
         CUuuPJ6ljNEVtiGg8BOdD0NkyWrg+zYg2zJW0R2I0vbvdZ9MMOr2nPl9zbGjW6SdE4OL
         QIcA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Q7e6dAAgkvulYu8wmU07S/UTXFiBB9ieWP+s1PHpLgipyam4ElKjuffQY1gstGUshMQNNf1F4iQGtGdWuA3KiuIhzoSMOkO6
X-Gm-Message-State: AOJu0Yy7SXQT1jd8K9xfMHSvwRS/tIyx9A3+oseXw9XD1b6mRZzJexjK
	9g9Ct+K8nc5fHLl9OZTfEM8t0MCGyd+FAjfacaTHQY2tMJKMqtTvnie7qvlFt3VUCCZdmnnqpmk
	gbESEABWBIDGFtdwWQ3lpDJ3Re8RZJMiThBbe
X-Google-Smtp-Source: AGHT+IGOd8Il0pzT52TArreVzxc8P27a7UUPdkqEpoezwz3UFLMxq+teWXsDPYoQh47JNu+b94UHf51MCHK7rHgJsKU=
X-Received: by 2002:a2e:7315:0:b0:2ef:268a:a194 with SMTP id
 38308e7fff4ca-2f12ebc9810mr6755791fa.9.1722038373804; Fri, 26 Jul 2024
 16:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240511071532.GC6672@thinkpad> <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
In-Reply-To: <CAJMQK-gBACa0s7qo=sOkK2UJB+9WbNHBkfg4NTxp3dVfjvugSg@mail.gmail.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 26 Jul 2024 16:59:07 -0700
Message-ID: <CAJMQK-giFp69717rby_jYwOJ5p11VxocQzL5eu+XL=GSo-Q0pw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, 
	mika.westerberg@linux.intel.com, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:06=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Mar 26, 2024 at 04:18:16PM +0530, Manivannan Sadhasivam wrote:
> > > Hi,
> > >
> > > This series allows D3Hot for PCI bridges in Devicetree based platform=
s.
> > > Even though most of the bridges in Devicetree platforms support D3Hot=
, PCI
> > > core will allow D3Hot only when one of the following conditions are m=
et:
> > >
> > > 1. Platform is ACPI based
> > > 2. Thunderbolt controller is used
> > > 3. pcie_port_pm=3Dforce passed in cmdline
> > >
> > > While options 1 and 2 do not apply to most of the DT based platforms,
> > > option 3 will make the life harder for distro maintainers.
> > >
> > > Initially, I tried to fix this issue by using a Devicetree property [=
1], but
> > > that was rejected by Bjorn and it was concluded that D3Hot should be =
allowed by
> > > default for all the Devicetree based platforms.
> > >
> > > During the review of v3 series, Bjorn noted several shortcomings of t=
he
> > > pci_bridge_d3_possible() API [2] and I tried to address them in this =
series as
> > > well.
> > >
> > > But please note that the patches 2 and 3 needs closer review from ACP=
I and x86
> > > folks since I've splitted the D3Hot and D3Cold handling based on my l=
ittle
> > > understanding of the code.
> > >
> > > Testing
> > > =3D=3D=3D=3D=3D=3D=3D
> > >
> > > This series is tested on SM8450 based development board on top of [3]=
.
> > >
> >
> > Bjorn, a gently ping on this series.
> >
>
> Hi, I was also working on a similar patch to add bridge_d3 to arm
> platforms until I found this series, which is what we need. Also
> kindly ping on this series.
>
> Thanks!
>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

> > - Mani
> >
> > > - Mani
> > >
> > > [1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-=
3a713bbc1fd7@linaro.org/
> > > [2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaa=
s/
> > > [3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-d=
ts-v2-0-1eb790c53e43@linaro.org/
> > >
> > > Changes in v4:
> > > - Added pci_bridge_d3_possible() rework based on comments from Bjorn
> > > - Got rid of the DT property and allowed D3Hot by default on all DT p=
latforms
> > >
> > > Changes in v3:
> > > - Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
> > > - Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-=
1-9dd6dbb1b817@linaro.org
> > >
> > > Changes in v2:
> > > - Switched to DT based approach as suggested by Lukas.
> > > - Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-=
0-46d7789836c0@linaro.org
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > ---
> > > Manivannan Sadhasivam (4):
> > >       PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3=
 possibility
> > >       PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
> > >       PCI: Decouple D3Hot and D3Cold handling for bridges
> > >       PCI: Allow PCI bridges to go to D3Hot on all Devicetree based p=
latforms
> > >
> > >  drivers/pci/bus.c          |  2 +-
> > >  drivers/pci/pci-acpi.c     |  9 ++---
> > >  drivers/pci/pci-sysfs.c    |  2 +-
> > >  drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++----=
----------
> > >  drivers/pci/pci.h          | 12 ++++---
> > >  drivers/pci/pcie/portdrv.c | 16 ++++-----
> > >  drivers/pci/remove.c       |  2 +-
> > >  include/linux/pci.h        |  3 +-
> > >  8 files changed, 89 insertions(+), 47 deletions(-)
> > > ---
> > > base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
> > > change-id: 20240320-pci-bridge-d3-092e2beac438
> > >
> > > Best regards,
> > > --
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

