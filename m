Return-Path: <linux-pci+bounces-16738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5369C8528
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 09:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E391F22963
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC81F81AD;
	Thu, 14 Nov 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LS5jb6QI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4131F76BD
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574003; cv=none; b=Z9yW01nzqFWfeSbMloou2JqcMMcMgiWpCk0v97Y331OI8htyfQdHtk13Av8cPnfxzQiVqpDeeJq1RwQMSCfqLk8pNITPWEYDm7fLencDhl+jJ/ah92d9L3KYP+cXpiA7XMuiGhGGgJq5gws9w200ZIYFr20ZE2YLNp3qGrfRfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574003; c=relaxed/simple;
	bh=Vlwv78Jmx8PtyWV9jzUFNSXiAEcvYzgDAK5oa5BErbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+7cmVYBaf17YQyKVKVzhD2tvfGGhpqvXP+gqlSo7+6rRHqsASDuJaTwJyd/CXt7wRGagUZtTeByqvXq0zx0sQK2a6zivw0d9Xnd8KQkWSu3mc0Lp7GdQ5QzFXe5mpmQDXB+hXvs551bLjSLJsi8XyoJbfumRdLIcO/usU+c7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LS5jb6QI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e9ed5e57a7so3381277b3.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731574000; x=1732178800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQk070VnTWQtqIqFikoSqiSm1iFWMwR2xaQu4Ky8zkc=;
        b=LS5jb6QIo6TJey7dMOaI3qTj9hm4WojHUx6U33JnQJQ3R7A6SLMhtcbJlC+7p04raB
         3Ouv5hWGoATu8Y2wKeloKASs/H3gZ7QR42ALz/UoYEwWOjfFVolzDkbNJibV9ZSwFKLY
         j6ETmg3k+6Hi70Lu+F/3i1yxXeDS7lBLrxTBx0BTJ2GF9yYxsRM4+yQULMDduSbfdhYp
         kF2+4Hk0/onoLv4qtbQRTDeLPugAHbe9kS4dACzpmcmw3NZHa4V9qXPiqPImMVLcW7V8
         FsxBzw7BrcKB1xlBqM8evHsHIf1kNuVPlTEL6Be4kVtGp4nESOXERdoEsiCvLlabHRFP
         657Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574000; x=1732178800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQk070VnTWQtqIqFikoSqiSm1iFWMwR2xaQu4Ky8zkc=;
        b=f8kdzSoQRjUm5ik9uq6SYIbPgpiGvlOUj56fukaX6JMqsTtb88X5Ylg/l6mW4w3f1D
         jo8/VxezaBk8bN5UM9RP9c382DvDWF78nAH6p0Urdj9cunDJ7ewTCT4wxgRrS20T2X1K
         TFxTzCQZuqIrc5K0x+XuvFKL1M8hsT9DqRE5A/ayZkS7i45qgZuC3AyYrhqkYgF5qmI+
         QBtTilu49RF7JIYzR/h2pc1aNmYcRP2JGKXXCtBoXBLhPXemxVhXlYpf4CtaybAz3219
         JA7afOIXFOSt7m1RDhYTimneTBC2KnwiMgM9J3A/lLbefclKaBKeb3VcvSiAczUlZCXH
         Rhzw==
X-Forwarded-Encrypted: i=1; AJvYcCVm6VXAN4eMJGc1EMQQ5PII21nJ8D78adtMxV3QIYMsibS76VTkmMQJiwvcr83OWHJ3KPRKM9SnbQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43svQZyx8wT7FwynOsIWM+oYqAHWpylPsprTNd6IMOgcdkeUP
	EPIlg+0CGtjlLUOmPpSVZm90AIhtbIb9y45BsWrLdWhqijWpMHF1iQIcA/ZSxUFnS/WrHwG6dt7
	EziA354Iv1YKEAiLquUnzr67WZjO4q42tLZwTUw==
X-Google-Smtp-Source: AGHT+IEptOSJqLLMi4ZF/HZTAppM321heaBoMo6X041LBRdBo/RkECxvPVue4UqSVc3K2eKfZS0ZLP+18Qu/6LfHtDU=
X-Received: by 2002:a05:690c:498a:b0:6d6:aa50:9267 with SMTP id
 00721157ae682-6ecb359dab1mr66938427b3.39.1731573999808; Thu, 14 Nov 2024
 00:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023221904.GA941054@bhelgaas> <20241113214850.GA1912974@bhelgaas>
In-Reply-To: <20241113214850.GA1912974@bhelgaas>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 14 Nov 2024 09:46:29 +0100
Message-ID: <CACMJSeuU78R8W+m9s0mV9y0DLNJ=JSRHjC70FiVT36bMbimj-A@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] PCI: Add PCIe bandwidth controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"Maciej W . Rozycki" <macro@orcam.me.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Amit Pundir <amit.pundir@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Nov 2024 at 22:48, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Bart, Amit, Neil, Caleb]
>
> On Wed, Oct 23, 2024 at 05:19:04PM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 18, 2024 at 05:47:46PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > This series adds PCIe bandwidth controller (bwctrl) and associated PC=
Ie
> > > cooling driver to the thermal core side for limiting PCIe Link Speed
> > > due to thermal reasons. PCIe bandwidth controller is a PCI express bu=
s
> > > port service driver. A cooling device is created for each port the
> > > service driver finds to support changing speeds.
>
> > >  drivers/pci/pcie/bwctrl.c                     | 366 ++++++++++++++++=
++
> > >  include/linux/pci-bwctrl.h                    |  28 ++
> > >  tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
> > >  .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++
> > >  .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
>
> > Applied to pci/bwctrl for v6.13, thanks Ilpo (and Alexandru, for the
> > bandwidth notification interrupt support)!
>
> How attached are we to "bwctrl" and "pwrctl" as the names?
>
> I just noticed that we have "ctrl" for bandwidth control but "ctl" for
> power control, which is slightly annoying to keep straight.
>
> "ctrl" is more common in the tree:
>
>   $ find -name \*ctrl\*[ch] | wc -l
>   691
>   $ find -name \*ctl\*[ch] | wc -l
>   291
>
> so I would prefer that, although "pwrctl" is already in the tree (as
> of v6.11), so it would be more disruptive to change it than to rename
> "bwctrl".

"pwrctl" is shorter and it was the only reason for me to choose it over pwr=
ctrl.

Bart

