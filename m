Return-Path: <linux-pci+bounces-30458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BCAE4E00
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E68189D424
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EDA2D5C6B;
	Mon, 23 Jun 2025 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Act3DK/V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8729CB2D;
	Mon, 23 Jun 2025 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709819; cv=none; b=lHtuIs4yYujv04Yd8V5cgeVXoE3rlZjt0UlFTRV4WsG/j4umjB4t7Z0jcqRwLmgJH/LmO0lPilDjnKCyCffjfXo/ZBR48fUtcA+aBXrseZbmHlppVjk9vZnJN+2AX3if6+Qaphh2w2lVz2PvkzFE3a01KR2O1v4REE1EmowVaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709819; c=relaxed/simple;
	bh=O8nRMlbUasS2vg8+zAx590EiTcMsRdsyDbXO8JvrHog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVnxiHckra+hziBScDsxOure+p2ILGxNTOVV55GudbMQWVbixu9apFGiQSx0ytqLEatH33KupM2MjYSeawBPUEC1zd6NwsEUWtCvcDbnvBOkuFO9NaKCc5xvBVPXQlxAwhtGiDREgpscBIsayhVjm11KLnMEdJmfOokEwGRcsxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Act3DK/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D89C4CEEA;
	Mon, 23 Jun 2025 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750709819;
	bh=O8nRMlbUasS2vg8+zAx590EiTcMsRdsyDbXO8JvrHog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Act3DK/VGWW80bkRmU24tdIx+IJ3O8/57bsUTs809/dXeGuKHNPLRft6ASOdVJ4Mp
	 7tk5ir92YIFYLnaO6OnhVBvIs75YKdHnJgKawK1SirJMV/y5xa10JDA4omaTrbcHO4
	 QgmRGu4gvaNebbaDof9YitqvzV+9BjB/G5dpQWT94hxN4HfFMokxYuCbYbWNAL8fee
	 1blqgefsR1gim9rGLqrv/aBTqW1I0tkBFfCDRnCF2r5k1RcuccHzinbHry4lhgYmbe
	 M/8ZI0X8E7imgssMrqerQ2mVKM7tlbJJmeclb44G1C7KVKw+ooVHhf6KUYnlP/v0YK
	 NvOra/kQiLUbQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-408e0986303so3046946b6e.2;
        Mon, 23 Jun 2025 13:16:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF+q8aiyfPWwhQTl0JeSEN3OWk94c6VO4vBVFwDZAsPstJiqbSuTlbqTwGNnzoSNU+9+GfFRQLaHR0@vger.kernel.org, AJvYcCV0/HGWpdV9aGCltR3d/1pO+SKHPi7Zr4//4o/SqJHAjybN4QEQVd31M66bRWIyakr+5K0OZzFzEnQIftTW@vger.kernel.org, AJvYcCX8Jm44gmcfKFSAT8J42srRRsn5b/AGEg5NEcTagMncfgSbBrehYi3TeUXXa39tsJ63LTaZZjUwtdyU@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcATe1IoFeVeLVC696gPkm83dAHDWpU0/6lM9TIZrkykOm8br
	7/LoL1AeNFFlFEGmu0AUo6b2QEd+XWxcNDUO9IfQDCW1j0r1bTADntsCdQlMGooIHuzpvMMJLRH
	8zLt1Sqv27gUq6cSJbVDTgX0ZDl2ApxU=
X-Google-Smtp-Source: AGHT+IGuPTmqnPYwk3rQdbnQIBeJ6bHfYz8AfO0JkE88ctyXs8LAGZJ23yFSVmOfMpwWCx1tMDoeNXlKF9WdA2xgnoA=
X-Received: by 2002:a05:6808:1442:b0:3fe:bc96:b82d with SMTP id
 5614622812f47-40ac7147d56mr10053650b6e.36.1750709818502; Mon, 23 Jun 2025
 13:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619072608.2075475-1-qiaozhe@iscas.ac.cn> <87a513bd-096c-45ab-8f5f-a8d3d6ad6b2e@suswa.mountain>
In-Reply-To: <87a513bd-096c-45ab-8f5f-a8d3d6ad6b2e@suswa.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 22:16:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j7DjqF7qYHt8w=HrY8q1QYMw9qjizv03Z1g5uQ__Lrig@mail.gmail.com>
X-Gm-Features: AX0GCFvJtUEOkybDoDrS9ruDVDrax5KYHEYK7r0bf87-StvWnNPSF0LHJO7YeZY
Message-ID: <CAJZ5v0j7DjqF7qYHt8w=HrY8q1QYMw9qjizv03Z1g5uQ__Lrig@mail.gmail.com>
Subject: Re: [PATCH] Revert "PCI/ACPI: Fix allocated memory release on error
 in pci_acpi_scan_root()"
To: Dan Carpenter <dan.carpenter@linaro.org>, Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: bhelgaas@google.com, helgaas@kernel.org, lenb@kernel.org, 
	kwilczynski@kernel.org, sashal@kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 4:30=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Thu, Jun 19, 2025 at 03:26:08PM +0800, Zhe Qiao wrote:
> > This reverts commit 631b2af2f35737750af284be22e63da56bf20139.
> >
> > The reverted patch causes the 'ri->cfg' and 'root_ops' resources to be
> > released multiple times.
> >
> > When acpi_pci_root_create() fails, these resources have already been
> > released internally by the __acpi_pci_root_release_info() function.
> > Releasing them again in pci_acpi_scan_root() leads to incorrect behavio=
r
> > and potential memory issues.
> >
> > We plan to resolve the issue using a more appropriate fix.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/aEmdnuw715btq7Q5@stanley.mountain/
> > Cc: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Reverting is probably the simplest option.  There is still an issue in
> the code where in acpi_pci_root_create() the goto out_release_info
> doesn't free sysdata except on the last goto.  So there is a small
> leak.  But it's probably more theoretical than real.

Applied as 6.16-rc material, thanks!

