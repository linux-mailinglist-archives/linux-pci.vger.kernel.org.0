Return-Path: <linux-pci+bounces-28354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB9AC2A88
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63E54A590D
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F0297A61;
	Fri, 23 May 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2wEoCmv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AF1531F0;
	Fri, 23 May 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029489; cv=none; b=kLLfL/9AVGlaRJPAN102pE7scAFxFXU6DV6AWWfC0qeM+8JBHEkaoApsmUR+ekx0lyq9ARabFGdkcZdlDY34DITTy3ZYXR8gGOBR2KbAtGotZy53lJYLQDJ+71slq7X+xgUw5ukc1xvt/zczOez1WpcwiLzvrr8HW/2/yk9TMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029489; c=relaxed/simple;
	bh=p2qITD20YSBB4hnNbHBch9rvmIplfjjfNEzZZvafuic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyxXr2KZD1pjk6Kl9cLKeYsVEV8J3hEJt+QjD5qMSo27055oL0eDQ2d6dfQAIpig2zhShxVUP7Tkafnb+rM8KNbeIHFQS31xj/uldCd1wp57xgONv/7DuPnxU/cwVujkIsFNjHbevgpZy2HqKybtF0dGivZShbYHNZE3sitm5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2wEoCmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E6AC4CEF0;
	Fri, 23 May 2025 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748029489;
	bh=p2qITD20YSBB4hnNbHBch9rvmIplfjjfNEzZZvafuic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u2wEoCmvKXDsxjk22b0zjfhv2WJ1kwghSzx38VYnpUl51W7dOvri2FG6eJ8WOPYUP
	 uE4kSGclxDIoy9ce4DIOceC4zbgAgMfW5lLT02kV/W//TqYZcQK+MqJAPywtDEjogo
	 tCQnrvkpyYTNt6CbNc6y3bU1y8X2WXlRTgjEAkNxQNIxserd2k0Hd4ELRA+m8jV2BG
	 Bgjuw7qsrQ7BV/K3xVSJQzCTtSxs29GC364SMoiAKfofEfT4+KvZLAsl0JvQDa7NMq
	 7B9j9xEHStsU6H6bHoIG+TwwuBe3BIUM58v/+bhrjlL77q/Di/cEm61A/Npf054Wgr
	 D/RRolPS5XMDg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d5e5e21b92so157403fac.0;
        Fri, 23 May 2025 12:44:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyO+0v95cr5u2OzMF1Wm2t1RqGtOgRIt4Gm7Uc0RhKQ4WQTXOaWAeDqL7+j2DXYCKNR/LSlKlMOzE=@vger.kernel.org, AJvYcCV7nlmhnx1Hj+pmidoORbk0amGoFP6k4boqqOtRN29DoFnYADnAev4BJ7vAXKum5D64rBSMYBOPEQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvtIJ5oCt5Z1ZoBd/fZ32DuMpbgF87S/n2UY+ADW58+vOZwXx
	52X/XlkkzPB3Au0/VTMEIpNkEQXvenKPhZrnS9IVOHRUdOOYFLgou/ASFJJw9M8NPNsdHrkcJDv
	rBjZPgSyqviZJcKOygAUZ6xZPpYbYQBs=
X-Google-Smtp-Source: AGHT+IEI73k2jPg3EjVWDKv5Ptp3jzyUGizZ0IApSY04qVPFWowELVsOzLK0JNuzc0rfgyMPbciW/ZiKAZhLEPzt7EM=
X-Received: by 2002:a05:6870:ef0b:b0:2c2:cd87:7521 with SMTP id
 586e51a60fabf-2e861d43fc3mr419666fac.4.1748029488323; Fri, 23 May 2025
 12:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210938.GA1128238@bhelgaas> <7aedd720-c29a-4225-a79a-d44a3a9ca129@gmail.com>
 <b52a2045-0b26-4287-80a4-e1b571d76a26@panix.com>
In-Reply-To: <b52a2045-0b26-4287-80a4-e1b571d76a26@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 21:44:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWAbwtvZm4WrFc06v79JEpTVQ9KeHPuzVkvm5Vp9gK3Q@mail.gmail.com>
X-Gm-Features: AX0GCFsl5y8KlU0nB-4OHFXVK5ssEpeMlmXcYreuhiBUWeVe-VKMXJEXWP1unsc
Message-ID: <CAJZ5v0hWAbwtvZm4WrFc06v79JEpTVQ9KeHPuzVkvm5Vp9gK3Q@mail.gmail.com>
Subject: Re: Raphael, I'd like your help upstreaming this VMD power-saving
 patch, please
To: Kenneth Crudup <kenny@panix.com>
Cc: Russell Haley <yumpusamongus@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, rafael@kernel.org, 
	linux-pm@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Andrea Righi <andrea.righi@canonical.com>, You-Sheng Yang <vicamo.yang@canonical.com>, 
	linux-pci@vger.kernel.org, Sergey Dolgov <sergey.v.dolgov@gmail.com>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Jian-Hong Pan <jhp@endlessos.org>, 
	"David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 9:21=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
> Raphael, any input?

Well, Bjorn's concerns are valid AFAICS.

> On 5/14/25 18:23, Russell Haley wrote:
> >
> >
> > On 5/12/25 4:09 PM, Bjorn Helgaas wrote:
> >
> >>>   static void pcie_aspm_cap_init(struct pcie_link_state *link, int bl=
acklist)
> >>>   {
> >>>     struct pci_dev *child =3D link->downstream, *parent =3D link->pde=
v;
> >>> @@ -866,7 +891,8 @@ static void pcie_aspm_cap_init(struct pcie_link_s=
tate *link, int blacklist)
> >>>     }
> >>>
> >>>     /* Save default state */
> >>> -   link->aspm_default =3D link->aspm_enabled;
> >>> +   link->aspm_default =3D pci_fixup_vmd_bridge_enable_aspm(parent) ?
> >>> +           PCIE_LINK_STATE_ASPM_ALL : link->aspm_enabled;
> >>
> >> PCIE_LINK_STATE_ASPM_ALL includes PCIE_LINK_STATE_L1_2, so I think
> >> this potentially enables L1.2.  The L1.2 configuration depends on
> >> T_POWER_ON and Common_Mode_Restore_Time, which depend on electrical
> >> design and are not discoverable by the kernel.  See PCIe r6.0, sec
> >> 5.5.4:
> >>
> >>    The TPOWER_ON and Common_Mode_Restore_Time fields must be programme=
d
> >>    to the appropriate values based on the components and AC coupling
> >>    capacitors used in the connection linking the two components. The
> >>    determination of these values is design implementation specific.
> >
> > Does that apply to VMD?  As far as I know it's not an actual physical
> > PCIe device.

The devices on the VMD bus are physical PCIe devices, but they need to
be accessed in a special way and the BIOS doesn't have access to them.

I would try to replace the PCIE_LINK_STATE_ASPM_ALL in the patch with

PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1_1 |
PCIE_LINK_STATE_L1_1_PCIPM

and see how far it gets you.  Please let me know how it goes.

In the meantime, I'll try to find somebody who can pick this up.

Thanks!

