Return-Path: <linux-pci+bounces-35243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 215DEB3DCB5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DACC84E1DAD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E742FB61A;
	Mon,  1 Sep 2025 08:39:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4082268C40;
	Mon,  1 Sep 2025 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715953; cv=none; b=eKKBq4VZvUHze3M6wVlFK+145oqYjDF/kLe+CUSq8cUGOIiFCYV+bDsQ4kKAf2jzvJBoab8W3cTjze/F+WsHnFeYnin6pm0ZA6k08cxa44Or8WDvKHwb/M0VdYcCtQMuOaEFpGcBZTxK4UvnkQSeZCcRKyelyqKprSBLT96ysWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715953; c=relaxed/simple;
	bh=WTjzIUF3S1zA20EdM2pk/6KkYo46Fw8eYT1zQTtvK4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfIh/MRg/wMOxn99eHDqYxcs3iAKRy/cUrpTaR6oYZYBS15O5eYpGbe0aRxMsI9vXOEnIMzZFu4vVgoeBBKwhBsXdYg2WIJG9S7fB9ZdckkznfTELuqyxQFTkiS4FW3deAaBq3q6ThyfbHZzNCLYiTqGgBSW4e4uuL55KUGS+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-523b965b984so2427883137.0;
        Mon, 01 Sep 2025 01:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715950; x=1757320750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulv02t6E8nasXluvV9ehM0QMWfZqnXi7fBl8WMsUhHw=;
        b=UFzZZoz2fYAxf05YFDnCiU/eAh2QeOOs3yVSdWzK6nrLMLgHT+PUwsATJKmHV/XEyC
         fTF2+kQPZoPHqUBo38th9tydfcNw3RsO3eGtSF7SeV0g3H4zp+HoZGSrnYtsvl8SxdIH
         4zIrO3qC1m+q84x8ruhhosgU2qg1OtCTT/U9kZZsmCQdx5UzoZV5GRQJIqoPzQxE/L+Q
         mOyzGZRKBsonFoQ7VzM+P71eS7UqFVy/14wBb8/WfSFhE5yZQLJkPq67J4yoDeRqs0TG
         F72zDFzX00oBPNPYErnuf5QbYsN3hnr6PjxhB+W6wk7SUglYbkKgnIxR1kXA1reUSrXb
         EE0w==
X-Forwarded-Encrypted: i=1; AJvYcCVwiTptOa1Av5BgelfdxSE1e+BRwf0GGhcVRtAwgw9vEuu+jrckc9fUpGhRsC0iNtwXc8o6Qc5mkdNW@vger.kernel.org, AJvYcCW9/mq41ndd/XwAmIdrb7tKOfYoUTyPeqfKNo6cqui42QNlOSPq2/e8k7DLSOGTrOqL0t0G8+pS4zVYSg==@vger.kernel.org, AJvYcCWLRHVKX63P0GgAGk7A/3NF7jZ+vMOJo7WgqWrwvyo/BbZ26CjIn3Pl1iH1L8dC+Yp53S0gjmC4yPIGYlA=@vger.kernel.org, AJvYcCWccyqFSgGv/szKqZUOXSA8tAwVQBC/hjik2f9ZiGd/LVpwDXUoYXNUZ25ZjHSDo/dQiibZwOcMDDul/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5lEV5KHu3g8TCEZEkDHgrbTru+fJ1lWJf5D/DT0sAIZiMHuH
	Sp9UPDLpGG9e6OJ4grAxNIIpk/6P2X3tYc+XD9KQ+Zbsx9MjqwD2WpltR+LKqX0h
X-Gm-Gg: ASbGncsgBjh21xFkgbhfMnUBykkN5m4vAHFT/UW3TeQTXH43N7blqW5XJpkjM6lJ9Ou
	hzkOuBvZ64iZdkG0H3FCbV7Y0N3xRl6DjKOHwwvSn6yLjDUxl2hJRatJR7NZesUSKokDvSyW+O1
	Zh4CpiDeo1lmUXSP4SRqaLrgfgDkwF6D7kZ0RcV6/pPuk1kAhEYtxG+wU5rh+Cc+28Pcdq1vZyw
	5JvUDrek6tjIDucdYoGZtomZg25XXBV+jGnWjla+lG55Rw4nM5OMRin4EWxQocw96XFNKA9jvNB
	q0dJPRebPVBQb8BbO4Ldl0p5xYXvwxWYHdj423bwYsPNinVzFME+LtElUN8fFd8n8O8e9HAghvw
	vrGRp+31KZDLzo8Ag3ZyzSmSBDQWUqfqqhf1b4z2IFjm3bTkNflFlQJiXEKOD
X-Google-Smtp-Source: AGHT+IEVmL7i6g3P14iHsNDxLrjc/GlcChpd4piofTo7cncsNFgBYbd/qCZ6OBv/3l/PQz24dxz9ew==
X-Received: by 2002:a05:6102:370b:b0:523:e010:df0f with SMTP id ada2fe7eead31-52b166d7d27mr2018552137.0.1756715950341;
        Mon, 01 Sep 2025 01:39:10 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52af1915741sm2831187137.10.2025.09.01.01.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:39:09 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-52dd67b03c8so717852137.2;
        Mon, 01 Sep 2025 01:39:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyIXCFzTwWD5h+A7gwd2pUWvyaw4GOgI7V3A2UnYyYkAokCOcvfiNfuazTlG9c5Ti2r3Ph11jFRPsiewE=@vger.kernel.org, AJvYcCXOi0YN/Myjp3txZ8OejHygPzfSNmCY2N3GAs9OiTafxCQFMbaiSVefbqxWwtaD1veeoZ06oW0aOnkveQ==@vger.kernel.org, AJvYcCXUV9FzWoz9iTFuW+Bh/UA8VcErWSv6AcBvWlgansoNoinvROAtrcxDUvhoKK1L+XmyjWtwiaG4BBn0@vger.kernel.org, AJvYcCXXH6ugfRRGZnKJZUCjMvZa+mfub/WyFPLZbv6je7/j9ehm8LHN95ZtcMkv4RJP9rxj21PjCsYTnBLdnQ==@vger.kernel.org
X-Received: by 2002:a05:6102:5789:b0:51c:4443:16e0 with SMTP id
 ada2fe7eead31-52b1be316e5mr1967209137.30.1756715948932; Mon, 01 Sep 2025
 01:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com> <20250827223606.GA915856@bhelgaas>
In-Reply-To: <20250827223606.GA915856@bhelgaas>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 10:38:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqKT4OaX6P_1CW_e2U1GwiCmyV5sAoDVa7EWUX2r6SsA@mail.gmail.com>
X-Gm-Features: Ac12FXyky2hWsQI9uSpsphCp4R_EUgbfbVJ67zlGAAXkq-snhjMBdE6QAlpgqhY
Message-ID: <CAMuHMdUqKT4OaX6P_1CW_e2U1GwiCmyV5sAoDVa7EWUX2r6SsA@mail.gmail.com>
Subject: Re: [PATCH 00/24] PCI: Bridge window selection improvements
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andreas Larsson <andreas@gaisler.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-pci@vger.kernel.org, 
	sparclinux@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yinghai Lu <yinghai@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Greg

On Thu, 28 Aug 2025 at 00:36, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Aug 22, 2025 at 05:55:41PM +0300, Ilpo J=C3=A4rvinen wrote:
> > This series is based on top of the three resource fitting and
> > assignment algorithm fixes (v3).
> >
> > PCI resource fitting and assignment code needs to find the bridge
> > window a resource belongs to in multiple places, yet, no common
> > function for that exists. Thus, each site has its own version of
> > the decision, each with their own corner cases, misbehaviors, and
> > some resulting in complex interfaces between internal functions.
> > ...
>
> > I've tried to look out for any trouble that code under arch/ could
> > cause after the flags start to behave differently and therefore ended
> > up consolidating arch/ code to use pci_enable_resources(). My
> > impression is that strictly speaking only the MIPS code would break
> > similar to PCI core's copy of pci_enable_resources(), the others were
> > much more lax in checking so they'd likely keep working but
> > consolidation seemed still the best approach there as the enable checks
> > seemed diverging for no apparent reason.
> > ...
>
> >   m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
> >   sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
> >   MIPS: PCI: Use pci_enable_resources()
> > ...
>
> >  arch/m68k/kernel/pcibios.c   |  39 +-
> >  arch/mips/pci/pci-legacy.c   |  38 +-
> >  arch/sparc/kernel/leon_pci.c |  27 --
> >  arch/sparc/kernel/pci.c      |  27 --
> >  arch/sparc/kernel/pcic.c     |  27 --
> > ...
>
> I love the fact that you're doing so much cleanup.  Thanks for all the
> work in this!
>
> Obviously all this code is quite sensitive, so I put it on
> pci/resource to get more exposure in -next.  If it turns out that we
> trip over things or just don't feel comfortable yet for v6.18, we can
> always defer this part until the next cycle.
>
> I will also watch for acks from the m68k, mips, and sparc maintainers
> for those pieces.

