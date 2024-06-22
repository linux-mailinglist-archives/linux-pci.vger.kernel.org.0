Return-Path: <linux-pci+bounces-9109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273C9131F1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 06:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51D02864B7
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 04:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6722D02E;
	Sat, 22 Jun 2024 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDXuxr81"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F122F5A;
	Sat, 22 Jun 2024 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719030595; cv=none; b=eOKEwzBHan4bjkNMyuyiAwbVibrwwfw1LsPMVEyk9nqr9i0eEQnxYBI5SANuCO03XUTYQ/EpN6jy/7n2EyD0wQcV6z5mkuyiaxr+pKEMa+IBK9mm77DhaMd+1nS0A6iWOFkpKtu1isfgd+205ci840AohIQcZfgvTMXM5n2Ocf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719030595; c=relaxed/simple;
	bh=MqEmGdf9SB+swNuEACU5958c0vsUzARjJZsQOdKU2TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNeSRrOc+8O73YlifU1K4NLqGIHW/Q+qH63mL/XLJ19FwBaXu/cyJwUu0NH36d10iuF0FohFAY4ps+ZSc216pz5aSdMKywCTq1QD/PH4PjODaCEz413bCtrgRzY81Rhr7a2q33fbOIi+DWELwmqu1msIU7OVJ57wN9DbLIG5G3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDXuxr81; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9706c84e5so1520605eaf.1;
        Fri, 21 Jun 2024 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719030593; x=1719635393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9KsD8yt6Ys8mXDglDi64CvjPaqmJRjrP6+6ZL6aKWI=;
        b=BDXuxr81sQjEtDpA6wUf/zlC10OwnIewXeB+5C0J4sJUWW7ViNFPLdXzzjCnqChGdO
         7JjZEfxuM18To7dBdTPx0x2H/2jlDyfjAjHC2+24bawKCwyj1kIN3ibLD0/8SEK36T32
         X76niponqDl4qumr1Hs02z4sIEyXhdesDVz4DwTCS1RLmMeazn7yrIZcG6Scz/fsw2iG
         KNUHe1X0krKDwpN1inQGtSCJJSgOPbOORbdcxm2Y5/4T+RhXFYjvwF6UFtzp73gjYu+4
         K9124do+jYFzV9hSeyEbu/gXVcAGef6y90CJlnGVDCZx63cmCWQuPLFUSqCku/GBLvFb
         wBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719030593; x=1719635393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9KsD8yt6Ys8mXDglDi64CvjPaqmJRjrP6+6ZL6aKWI=;
        b=F+fu1SEvpKudCJd4TUg29TsgIm7oKnGaA4InHs7FuvOa9TMksIGWq1MRj9L2bnXveS
         j5Pltvu8aNvrWo7Yvv6Y1uwo/bhPC7iOqF7ERnKNwRU0RhGf7elezN5ttS4YAM4wDrw+
         hJF8JgZVdKuJiIymgOySsLCbPWLN9en+amYpKYA2oVlBE2lcl7TzePtKv/tVo/igWjon
         +sePf0038LlRu5tHZVXEoJKnPqf3H9PIUa0ZFQHtqrc1ARVdvqxZuPCRhsY66x2Sxw/r
         6rfJ/Mo0C60bljDT2lAkz9NHJmxhxOCRGtaHEPhoZUJQcM6kfT2B3MV1iiIgpMhvizaq
         CQWw==
X-Forwarded-Encrypted: i=1; AJvYcCXz93/LhDrbhDx6inYRbUjLEF6ZroFjmsBd7uoDLMF5+n0Xj6JfOrUfEDnNwcbtWaeyUmoJSwA2BAwILH+IA6MGEdatTW20vvfLQKymaNP6FJw78JAoNIiVghwmo4kzgPaKy1W6ETOx
X-Gm-Message-State: AOJu0Ywoe6D395GY1aT8DfMM3zJYcDZJ0dnWP9z/oyPstZKLFP24Dzj8
	moYvNZ1AtHzmXJXUpX3oIl55Pg/Ld6aXr9S0/Qg5i6nzyK16AzQOkHD2JM9kSPL2voE3qM1rcS9
	eXk8NKo2rwdxN/B45L9ecACrm450+0A==
X-Google-Smtp-Source: AGHT+IE1+yk8ZA9XkU/ojx39oXVgXLE6ORoPSVISfOrRYQzqC1BHglAPcab/AKI4UKiw3FAoN067oBVJ79pWX7QhtAI=
X-Received: by 2002:a05:6870:d389:b0:254:c95f:cdb6 with SMTP id
 586e51a60fabf-25c94d5c85fmr11605824fac.52.1719030592833; Fri, 21 Jun 2024
 21:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621064426.282048-1-linux.amoon@gmail.com> <20240621212125.GA1406213@bhelgaas>
In-Reply-To: <20240621212125.GA1406213@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 22 Jun 2024 09:59:38 +0530
Message-ID: <CANAwSgRiOg4sXX5yEoTcogEAKUvO=r49sheSCjiCC7CF10kd1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn

On Sat, 22 Jun 2024 at 02:51, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 21, 2024 at 12:14:20PM +0530, Anand Moon wrote:
> > Refactors the clock handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for enabling and
> > disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> > the clock handling for the core clocks becomes much simpler.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406200818.CQ7DXNSZ-lkp@intel.com/
>
> Drop these two lines, as suggested in the test robot report:
>
>   If you fix the issue in a separate patch/commit (i.e. not just a new
>   version of the same patch/commit), kindly add following tags ...
>
> This is a new version of the same patch, so it doesn't need those
> tags.
>
Ok.
> The problem you're solving with this patch is that the clock handling
> is too complicated.  The test robot didn't report *that* problem.
>
> Since you'll repost for this, also s/Refactors/Refactor/ in the commit
> log so this is in imperative mood:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94
> https://chris.beams.io/posts/git-commit/
>
Ok, I will follow up on this process in the future.

> >  drivers/pci/controller/pcie-rockchip.c | 64 ++++----------------------
> >  drivers/pci/controller/pcie-rockchip.h | 15 ++++--
> >  2 files changed, 21 insertions(+), 58 deletions(-)
>
> Nice reduction in lines!

Thanks
-Anand

