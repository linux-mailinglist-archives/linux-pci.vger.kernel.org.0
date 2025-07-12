Return-Path: <linux-pci+bounces-31990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E0B0299A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 08:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DE57AD0C3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658A719C55E;
	Sat, 12 Jul 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGOVlRn9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC78C11;
	Sat, 12 Jul 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752302928; cv=none; b=gEXlogKg35m4x240NKfF5S+Xlat2L56IjwurhUMEXG/fA0XRSKhUyjtcvWCK5UAE3GJU6EAAUM/wsaGNfCHjMGTyovgOpU6Q24tNNDEr4biXPYwrCjTQE4WqVmof1toqO7pydcYFbvtRcXSZRiYycmNGjHqYKqpl/qHzJ5P+c5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752302928; c=relaxed/simple;
	bh=NoITU62SQUOqjJ60zYOKiXN09WwQKOHafQ7dw0yybjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/nZQ7t63o3691T9s0wpDJi20rD0TddlDOXZPm26YwnZu2NNA+/qk1zxsJaAzaGYiA3q3gkceXWfbFgG87FAdtITC6HXxC4flvdSP7XR/dNE+zW3hJuJbzIfTogA37agnp5oHjOA33IAh81JAZTL/976pMi9dzpWc/agR8RLCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGOVlRn9; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-714067ecea3so22390067b3.0;
        Fri, 11 Jul 2025 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752302926; x=1752907726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoITU62SQUOqjJ60zYOKiXN09WwQKOHafQ7dw0yybjI=;
        b=bGOVlRn9FSd+HE8mTEUpjtdWlQnv5ywwLgH56rasUjnlKGG9Q3hnv5Us0q7dEP5bBR
         RG1ZuQeYP8ikJ8w/u0J+RT/Yl0rrxqxFgaJnv5vlo+Vo/QCeGnbg5k/z7PM+9lQom6wJ
         Vo8t2/gj8vbvumg7OnxWbgdaaY7j8iTrS/ZpqrPn2cgAOib7UC/KJEUFwsrIRnsH0+YF
         zKYpHNH6Trkavz4/PIJJlHDIhbfhTO5G8G/LUM1j9JeqaSkZsy7XNp69x/G6ljfZey1i
         9o1KHfz3pl/hMH/A0jn6h4mkxbXBgyF7YH2fhAm9vn4oY0VQnNr6z9kl5yGih1ABAOFT
         AAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752302926; x=1752907726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoITU62SQUOqjJ60zYOKiXN09WwQKOHafQ7dw0yybjI=;
        b=fGlDJ8tVCXVxCv7qxJXjwKcIG8GW7WymcI2DdAW/i5CAaPsIdzkf5K6ErNDiO8pNxe
         aPP9rlV6jb3RjDFJR7NTRKZKTSXh4F+Qw2X35y+DiGR7xlxxhbRXpLmf/CnVr08YjYGY
         bF8zAx+9377273qfx5n6bwvlu0PbfwPkTunN+NBoVjIRUVCfRKBwfMuyyftAHmfv3nbs
         7MXYRoo5vfxgpxhjw3yHz08RPMIMlDjFfBMIzZWYQ3vqaCBFxP4RPiS8EQjblGgc1xBJ
         dYgMWI9Wvs6y7643eaQUtov9Tk2sD8tAR2IC8SPe+TKxHy373TepzSahab+Zp4fUJMwj
         Z1FA==
X-Forwarded-Encrypted: i=1; AJvYcCUIphbC+R6xWohNHr66VvKmyoBqQ/Aunhnm30ultJkCJvCwQ2kqoH7iYZhUcrnnQ7eOA/YjfnOG@vger.kernel.org, AJvYcCVMMB+Bp7Ew1zBQItP1NF17U1/ZRJgnFAEG/87KQUxtq+yo3E5cejrP4H4RJQizNbUlkcchqdeoWR6a@vger.kernel.org, AJvYcCVkcfeHUYIELP6diSQETNDjypdieuX9K7Ckw3nXjvM9jPeEf2in/Sr70PZWQc4nNE2fN3eyGL6ndj8ENojeu4M=@vger.kernel.org, AJvYcCXQZ0m+suWufhf1B31gWzNlex0LiGXUFaY5CUauR1Hqt/mtuyK7KZupojByP8f6kd3XmdfsrJvLF2T1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TY4Kqp64xLw2e6cYWFIfIz0SXNWPMZTlaGO0G9vXhv41mO9T
	SavNHrGqo5zo47Hqf/j/M/bsNE7/WT8im29Tr3jxlNSOWvbptGWyiLr2fKKpYIMQ5RIVJ9koWmd
	+Fd2pHwlwuDY8cPWtLLmLpVONQNOIfjI=
X-Gm-Gg: ASbGncvusS6A9LGu3QLoxznAIsqfp60tRDR+fGx/aNPauxJomdQnvor5SpOAoIwn/a9
	GSJ35BEkc0+22ztQAqTegnUk+PpxEx9BfHLMo6/8EaFky5fKVqasQl4+I1F0HG45Q3fDCHY1EOc
	uN7qLJzWx+ensuR5Ng9ozIUCEmlGa5KfVXsQvx83YtG5BdFK8dotiku5zYCqJWv/3ttXruLiM9o
	pwJilqA4w==
X-Google-Smtp-Source: AGHT+IGk2GtuNzqxa+gKFQr9ayybypizulvCNPS3E5NzFiSXc5j1f3+dJAsXJ7xrNYFRci9jPv4ohCAmyQ/XVL4LRzk=
X-Received: by 2002:a05:690c:fcc:b0:70e:29d2:fba1 with SMTP id
 00721157ae682-717d79eb927mr90617257b3.23.1752302925506; Fri, 11 Jul 2025
 23:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FB546B0D-2209-4FA0-9DC9-A75C0BC9FA4F@gmail.com> <20250711163645.GA2294895@bhelgaas>
In-Reply-To: <20250711163645.GA2294895@bhelgaas>
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Sat, 12 Jul 2025 12:18:34 +0530
X-Gm-Features: Ac12FXw_McJ9cVak4RJs7lYmIOUMmOI35Ioch1M3g7fMO3XpzdtWBzgGrKF48N4
Message-ID: <CAEmM+QiSZBoJV2n6944tYU7fcrzKRTUgsKRdqwDEkKkZiPVCMw@mail.gmail.com>
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Compiled the usual way: the bzImage compiled within 4-5 minutes
(compared to 1 hour previously), and the modules compiled within 1
hour (compared to 8 hours previously). Also, the congestion strangely
didn't happen. It was instead silently followed by "No Internet".

Didn't add the kernel-level journalctl because I'm sure that the
normal journalctl includes the kernel-level stuff too:
https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d8=
32a16180/raw/07b34aa3fa19da5afa4bb161454e3cb2081b9880/journalctl%2520v6.16-=
rc4-PATCH1

Please let me know what you think of the logs.

Bandhan

On Fri, Jul 11, 2025 at 10:06=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Fri, Jul 11, 2025 at 09:34:43PM +0530, Bandhan Pramanik wrote:
> > Hello,
> >
> > I really couldn't find on the internet how to compile a single file
> > now that I have compiled the whole kernel.
> >
> > Any ways to do that?
>
> If you apply the patch (cd to the linux/ directory, then "patch -p1 <
> email-file"), then run whatever "make" command you used before, it
> should rebuild that file and relink the whole kernel.
>
> Bjorn

