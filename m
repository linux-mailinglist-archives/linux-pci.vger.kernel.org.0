Return-Path: <linux-pci+bounces-14024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615A9960DD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8451A1C23712
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF217C7CA;
	Wed,  9 Oct 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdKl3UfB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FB17B50E
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458967; cv=none; b=VIkIT7HSrR3Pi7yVu69xR6ad3LGfXacTuNRSwca8eyaD16+kcEes0RMO/ZQ/CIll1Gg11NqAS/FhagCQOOoDU+chpODcYxbm8nq87TSSDZ8nHlI3KnQgyOj4nQIiJ303W2AIMuwV+XOiXY9pULYPqPBCUhecbHnksKknA27f0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458967; c=relaxed/simple;
	bh=EUGDLaFxOcsu4nfdm8VUJya0q/PT9+RysRlUrA5JoNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIQLnlQfPO0jtQHMcy1KxqXC4gx4yr+OyIOU4uzCry/w3d9Zqh4nuD/HaACE2apzR7K9a9hsL8JBosPeU/Okc8t56HVPx3jzYHm8BYznoZBCKodP703Tu6QLLMvKCv+9gq5OsYJ35Oap3al5xmGF2VaEi3zEDZkWnyABBP67gzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdKl3UfB; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e290333a62cso204205276.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2024 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728458965; x=1729063765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7wsUBBpyLsHvIcpuWZOmppXiQmagQNXt+Y3YerXGt0=;
        b=PdKl3UfB/mMdTE1wovoBDDiNnkffgMGCUs7cVdCFtwV+tJV9V6njZ4BBxQ7tvBQUks
         y5rnv31aNFmxS60M+V4buHMce4uiuGN03iWRQhrZd/YtCWK4x/QPG7/v7/CyD9y0PBlb
         icUjXHr3l0+q8qmhURQnBzsKxZZjrLZEGFPi4ZOHYb41lXLhQURhOuB1HSI8WXi59sch
         wegbeXJupLp+V4ZDXwCVwDpcFDv+RceOXUOdTN+CP1CO1ffXwpGb/iM7dv3E+C8/IN3l
         vJJTMJhYYqn2YBOtETDvt0rIt0kaL49z1XEpcIYYTGFurDFFII1HfcdjKFECieuvwm98
         TvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458965; x=1729063765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7wsUBBpyLsHvIcpuWZOmppXiQmagQNXt+Y3YerXGt0=;
        b=MG9mPv9YBBUv+uX4RtVWUSK+3RrsoSWT4d5dyKBQ4v2MBAvQDLSfZ+8ztl1c5ucMY2
         WEfFaM1F04O0qa01WnK3550yw7+OINRHgwk4SXMqiQtJATF0VlY2eGT/bu5Lmqc2liDg
         6wZiWKhCTksOr3zTL18z2iX63mBV+aTJ6J9nKoBzmxhOdw2TOfSgTo94E3K9S8TN8kG+
         alIl3NKlo0W1wRbpBTn2GetV+MEQBMPeoq2KByrOyl84vKsA00rnTWYYDpkCuJjC7g6p
         7+JlrG410Hmc+s85VsnXcS/nhvZkVe18lfU1ozsjjPAi1SmT3+UpNYHEOMIQFKgc4S78
         dvcA==
X-Forwarded-Encrypted: i=1; AJvYcCWP4JgyQxXrTOtek1gpeagI87ii74q8es/tW3gxNIeWtNrsoFj0LtFnf3mkuzy/wmSi5rJWaAJgvfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyroeLbkfb4Id7LjvZc8pG5ZrtqBkRGI5JZz4b3Y4Gmk036xNhN
	DMTG2iYIY/1JsPR6ztH14kia3AzQ5A0RPM2slEZIO0bWVwsusSdriPk8a7xDHEDEVlgAkIbg2hg
	vbL7CA46azxGnvnniNTc38qctPo0=
X-Google-Smtp-Source: AGHT+IGGImEZpS6v5xk+2Z92nkV1YU7EdG1EaWEgmDxgG/K4t3PwC4fIGN+fMb3TYrqJuyntagmd+ahXNdHfDV92NCk=
X-Received: by 2002:a05:6902:1203:b0:e25:cfe3:9b50 with SMTP id
 3f1490d57ef6-e28fe4d6a04mr1317597276.37.1728458964556; Wed, 09 Oct 2024
 00:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007044351.157912-1-dlemoal@kernel.org> <20241007044351.157912-5-dlemoal@kernel.org>
 <ZwO0H0WCnORq9EzQ@ryzen> <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
In-Reply-To: <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Wed, 9 Oct 2024 09:28:47 +0200
Message-ID: <CAAEEuhqpthLsNX70WWCn6+udPaNhks41d=oCZRKpPSHKnRc-AQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:26=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 10/7/24 19:12, Niklas Cassel wrote:
> > On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
> >> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >
> > (snip)
> >
> >> Early versions of this driver code were based on an RFC submission by
> >> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/=
).
> >> The code however has since been completely rewritten.
> >
> > Here you state that the code has been completely rewritten...
> >
> >
> >>
> >> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> >> ---
> >>  MAINTAINERS                                   |    7 +
> >>  drivers/pci/endpoint/functions/Kconfig        |    9 +
> >>  drivers/pci/endpoint/functions/Makefile       |    1 +
> >>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 ++++++++++++++++=
+
> >>  4 files changed, 2506 insertions(+)
> >>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
> >
> > (snip)
> >
> >> --- /dev/null
> >> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
> >> @@ -0,0 +1,2489 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * NVMe function driver for PCI Endpoint Framework
> >> + *
> >> + * Copyright (C) 2019 SiFive
> >
> > ...yet here you claim Copyright (C) SiFive.
> >
> > *If* the code has been completely rewritten, then you probably should
> > put yourself and/or your current employeer as the copyright holder.
>
> Oops. One thing I forgot to rewrite :)
> Will change the copyright in v2.

Hello Damien.
Thank you for acknowledging my contributions in the commit message. I
would appreciate it if you could add both our names in the copyright
for the v2, I don't mind not being in the MODULE_AUTHOR() but I would
appreciate a mention in the header comment of the file, thank you.

Best regards,
Rick

>
> >
> >
> > Kind regards,
> > Niklas
>
>
> --
> Damien Le Moal
> Western Digital Research

