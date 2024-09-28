Return-Path: <linux-pci+bounces-13615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C208988DBF
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 05:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D08F1F224C4
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B215B12F;
	Sat, 28 Sep 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1kG9cXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89C4A1B;
	Sat, 28 Sep 2024 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727495656; cv=none; b=BhNUOhANGaN5YMXUsmYEE188LCKnS4eDOVVLC1Bm83mCX3lqc91kYbVu0PsEtundpwWD68F6cnE/xLgj4oz3AWf6dRRr6jkH59CEDcMoqP8tfysWOcf3OlZV5Ll5mLsXofsqegFmaswfteleUnaLRapFcwZ6f/d/HGOSXnZWe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727495656; c=relaxed/simple;
	bh=x82iWF7eXQQdQXKKJVmDu/4AANMqTHSwpVsRnGv7kqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8KBXmZ5VeOT7mAvX/H1C/KODqzrGFCVxC+yM9qCngYed2Cw6zPjinezkZwv8Q1A/ORsSU1QxhrdjcZmn4qVMmpu6E1XoWfiP7IJ1B+Mg6/QuZn62IXC7vrEP5UWtSP5/yc5pOUKWNH9NgpJJXlo2QoA/yQyyEhfP8m6grVPqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1kG9cXi; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e5b57127e6so1386250eaf.2;
        Fri, 27 Sep 2024 20:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727495654; x=1728100454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xSAL7rchY/v+2Rzw+lrnyuOu9f7/62fqJf77xc7j10=;
        b=W1kG9cXi/7LeA0avguEdQiqRck1a24NW/p6mm+EgaXiMIXysXCaFQkGvw+yl72OF33
         5KyagbqLS3InaQSAX0izK5BMXlZDb34JcrkC7cYf73ifh/WGVpNVds6b4idZsIYZiliP
         bbiiwk2L8EUCv2tWDD1Akjd4YWu+f7HGHYchpqlwnm2huvMfVSF5AvIkSduULkxGT9nB
         Qh+xdEHdq2A+7KuiAigX8oVJ3lWp7OtcrQD7edsdflxfeiN3WfM8Rqaa18CJYTeU4MS3
         qe8O5rOO7CrZxuivM1/ZfGQ866OuMxoCqc/6piIvV0zsVZ9EO7nYzNhxOngkWUDS26Sz
         ODwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727495654; x=1728100454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xSAL7rchY/v+2Rzw+lrnyuOu9f7/62fqJf77xc7j10=;
        b=Y9QYU/rV9Tklqzg740inE7EgJHTdOVnKb9byp1X8fmHtx7aX0sN7tCU8q3Ja0zeLNP
         1Azoc4V/k5sqcaWL/fzHEZXWXxLhFFqIxaQJqs0QIaZSPj86UCVF52fVdi5BOW/CNBvd
         zZ6cAwsP9V30EGla9Fv6nPGs6jQiWPDXnX0EmI+k/rHBWO3L4KB+nRoQi8u/IReV1/3R
         74Y2syA2Q4CupeCqMeP5xYIlTYjJD/K+14/+YhD4PZiG1Ni5poWtbOKWKsu8Wrd0wWnS
         6lGe+z5XXq6u4JjdyCMxONnKBdF6rzUxl/TmOfJVKVmbhXFG8UHbd+KpIcnp8iNPp62E
         PqRw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhXy93Rvnwn9C6vvlcqxn03P6w4+EgZe9+vyYSEZclaPnL6Y5kFMj6Kh4F9b1Qmgb0hwPmFjvXNO+sr4=@vger.kernel.org, AJvYcCVzzZ8DVPI3QwmPzlmCo+/hjwMvcmn6dQ8JFRiDxkA3xTygud0N2fdGpU0NwyU3j3S6F4SmjDOBPHmR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fDyURSYmpdycwWTdwLEAzGhCAF9iUiCIwCORh3nLF1T/ihIv
	IJy8bSgKfQ5FYmaqkGxeRBdkMMuzIHfrvkhlVIgmfSLKJM2Bmh64K9/hYKA/qkTzQRt9HYoh12J
	L76JeL/1gMpX46LCVjLvkC4/pUVE=
X-Google-Smtp-Source: AGHT+IFFVM/jy3GYgQAk0AUcs3/sUs86ULzn48zHEdO6RjqIDIiJRQA43uZkEY2zPfymuKbW/S4rRLppwl3fVJ6w2Tk=
X-Received: by 2002:a05:6820:50d:b0:5e1:c19d:3f4e with SMTP id
 006d021491bc7-5e7727bb098mr3002051eaf.8.1727495654182; Fri, 27 Sep 2024
 20:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAwSgSgwx0kuV-boF14_WXiPkE8KXxOWOfS2e_QOWMKgKSLnA@mail.gmail.com>
 <20240927182238.GA85539@bhelgaas>
In-Reply-To: <20240927182238.GA85539@bhelgaas>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 28 Sep 2024 09:23:58 +0530
Message-ID: <CANAwSgSfdU9Ms_JCDdU+c9CxmBqGy1i8QkLtuorjMAw9GQe16w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Thanks for your review comments.

On Fri, 27 Sept 2024 at 23:52, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 27, 2024 at 01:47:44PM +0530, Anand Moon wrote:
> > On Mon, 2 Sept 2024 at 00:03, Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Refactor the clock handling in the Rockchip PCIe driver,
> > > introducing a more robust and efficient method for enabling and
> > > disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> > > the clock handling for the core clocks becomes much simpler.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >
> > Do you have any review comments on this series?
>
> Looks like nice work, thanks.  Minor tips below.  We'll start applying
> PCI patches to v6.13-rc1 after it is tagged.  It looks like these will
> apply cleanly, so no rebasing needed.
>
>   - It would be helpful if you can add a cover letter (0/n), which is
>     a good place for the overall diffstat and series-level changelog.
>
>   - This v5 series adds drivers/phy patches, which are also related to
>     rockchip, but will be handled by a different maintainer, so best
>     to send them as separate series (and of course send the phy
>     patches to the right maintainer, linux-phy, etc).
>
>   - "b4 am -o/tmp/ 20240901183221.240361-2-linux.amoon@gmail.com"
>     complains about something, I dunno how to fix:
>
>       Checking attestation on all messages, may take a moment...
>       ---
>         =E2=9C=97 [PATCH v5 1/6] PCI: rockchip: Simplify clock handling b=
y using clk_bulk*() function
>         =E2=9C=97 [PATCH v5 2/6] PCI: rockchip: Simplify reset control ha=
ndling by using reset_control_bulk*() function
>         =E2=9C=97 [PATCH v5 3/6] PCI: rockchip: Refactor rockchip_pcie_di=
sable_clocks function signature
>         =E2=9C=97 [PATCH v5 4/6] phy: rockchip-pcie: Simplify error handl=
ing with dev_err_probe()
>         =E2=9C=97 [PATCH v5 5/6] phy: rockchip-pcie: Change to use devm_c=
lk_get_enabled() helper
>         =E2=9C=97 [PATCH v5 6/6] phy: rockchip-pcie: Use regmap_read_poll=
_timeout for PCIe reference clk PLL status
>         ---
>         =E2=9C=97 BADSIG: DKIM/gmail.com
>
>   - In 3/6 and 6/6 commit logs, add parens after function names as
>     you did elsewhere.
>
>   - Super nit: In 5/6, s/Change to use/Use/.  Every patch is a change,
>     so "Change to" doesn't add any information.
>

Ok, I will try to fix and improve on your suggestion in the next version.

> Bjorn

Thanks
-Anand

