Return-Path: <linux-pci+bounces-37203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7943BA975B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22B73A1C6C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAC1F5437;
	Mon, 29 Sep 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUPMOORn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3A3090E8
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154407; cv=none; b=hJpDH3kHjNWs1dc2ZgMIxqLKRMfXZgkyd0qjYitu7oGgGaj9JlaBnxevzDxzj3rw/Sqv1orfArOyzjXoUTX46iozHTFxUDCwGITCpk9sLYlFsVxKCyqOr1v07Vu6rr6d1lUk9Pa3wZZK8h4184vyi6cRl0elqVSC5a+NMIVP+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154407; c=relaxed/simple;
	bh=mzR02490frUw5bY39+dPtJ88bS4FGXn4GytLIPHkuzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXL0Mmf39zmzOi5GkL+3w/gl4OmxJwdHp2NPVNI2mGMeSobyn1cTvyBzLUbdS3nM/KuwCepR2JpO3BgABSrjYzCrCBSDVkOYRCfk9scYK7KfvR8Ql0nOYKihPBiz5x3CcYbb5TAhsysICCDi/a2cpKCDw9EvNBrdIrrAejT2Tes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUPMOORn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5323FC4CEF7
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759154407;
	bh=mzR02490frUw5bY39+dPtJ88bS4FGXn4GytLIPHkuzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SUPMOORnywuonOe3kEXWUi6bUgBDK3aKsTe3lomIqpIu5Lti+pmZUJFRv/OmZoqQv
	 oAjUf1A4H14PxB+obwqt4dqd2g8jDnyuRu7phsYxPDA7yJ5yTR6XkdEvQLr97rAzfX
	 icDQl1yjDIAn8vCUd/dC5Ugwv1PxRSxBCN65e16SBrF15f3UNzimsgC1drfPnIkNe/
	 61z8vjuKZxAAtNCsQyDAnzhG5hLBN5B3LEUy1z5x1de5i+fvIW0DOPGbNsq50etjzG
	 FE/zEcnMKCesO9D+H1z7vplLzlt0jtkBLAXrC3DLkOEdaYwZbTqniQ5f7sVGV5QmR2
	 SBj7ZkbWwpHzA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce892b7dso2848192fac.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 07:00:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcVDvhY7EbCz6MouuQNJ0DTzWXFK00MxEbdB9tV66hLdFvoVMqB+j8t4H6pOTn3t8h98YbwK1uwhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNwQPKWyUw84NkH92OTxgX6s3sUast/OIscFZzCIkAO652PbA
	8JyIL6rm3hioTn7S2MhuzSM1H9/cgDe0k91pJCgx5KfxNG54w6FVtmGzzVRZP689NgFxr+Ts/+k
	CdtoZpOC0qz1OY4yj1t3rvjg+7MnPnYE=
X-Google-Smtp-Source: AGHT+IGfnuFTAFMJ9mHkX2TvHJ8nsO6B7M6j37TMe9nlj8qXzEM60hjpcDaE5GntJxLQQkeNc61dLuimyEjYEw0vFpY=
X-Received: by 2002:a05:6871:82c:b0:373:e28e:b08 with SMTP id
 586e51a60fabf-373e28e0babmr5415118fac.35.1759154406658; Mon, 29 Sep 2025
 07:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki> <20250929121525.00001775@huawei.com>
In-Reply-To: <20250929121525.00001775@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Sep 2025 15:59:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gd00bRjoDjNdzFMVcQe3yQvy=OC=ZA7Dr-OxL_iP+x6w@mail.gmail.com>
X-Gm-Features: AS18NWAPSFmy8ggIgPAQd7RfGm4eceQhgU8B7dChIFjalUWtGmmSUIIZRzPPvrk
Message-ID: <CAJZ5v0gd00bRjoDjNdzFMVcQe3yQvy=OC=ZA7Dr-OxL_iP+x6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] PM: runtime: Auto-cleanup macros for runtime PM
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 1:15=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 26 Sep 2025 17:40:29 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > Hi All,
> >
> > This supersedes
> >
> > https://lore.kernel.org/linux-pm/12763087.O9o76ZdvQC@rafael.j.wysocki/
> >
> > which was an update of
> >
> > https://lore.kernel.org/linux-pm/6204724.lOV4Wx5bFT@rafael.j.wysocki/
> >
> > that superseded both
> >
> > https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/
> >
> > and
> >
> > https://lore.kernel.org/linux-pm/20250919163147.4743-1-tiwai@suse.de/
> >
> > It follows the Jonathan's suggestion to use ACQUIRE()/ACQUIRE_ERR()
> > instead af raw CLASS() to make the code somewhat cleaner.
> >
> > Thanks!
>
> Looks excellent to me.  I've already been pointing a few people at this
> in driver reviews, so I expect to see a lot of adoption in IIO (and elsew=
here).
> That RPM_TRANSPARENT handling is particularly nice.
>
> With the tweaks you've already called out.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!

> Given timing, if this ends up as a next cycle thing please could we have
> an immutable branch?  If it is going to make the merge window then no nee=
d.

I'm actually going to push it for 6.18 during the second half of the
merge window.

