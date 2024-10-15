Return-Path: <linux-pci+bounces-14530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C899E1EE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 11:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E751F24C79
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBC43AA8;
	Tue, 15 Oct 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBMbIueZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2341B0137;
	Tue, 15 Oct 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982844; cv=none; b=mDiqCySWuGZCLQQs0YsU9/X9LrzRhZyK4BcRJKE3q+q2raR7jo1ofOPmDrPOs1nBksdYkXDLdwIj0Qsv/3UwZJQ3BcGtOHHp7AlVG0fac7mwXs0HW4Ne5gTxYnBFfd0NqKxpKury/Y+KVkG3rbPXsOrKgplodsQ39mKY4PBAiZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982844; c=relaxed/simple;
	bh=qe+VieO/eCTvYDsrp/UAKb2T83UiGqmE9oBxmFoHN+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCfilgkD8SdJ6NMcFiKVnhLkGQQ6S+2ScRte3AO0nQrpzEU7zMVJlEmxNpAS/6sTWCorQdjnPcg0vz3OA7lWg9h9qWPI/PzFAlgIOBvuKPOA4wyecBUD4MTt6MFy0u0JSa7qhQolMxzhV4ZvLsq6HOOr432+jAMdoz+z0ssErxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBMbIueZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-287b8444ff3so1889544fac.1;
        Tue, 15 Oct 2024 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728982842; x=1729587642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLp6JVFP095nF2eYEIFQ7G5HMe9lih7YXmsVYNx7OwQ=;
        b=BBMbIueZXl0oaApXRDpD4EY1fSsNv0KXG2/5qHQtYM5qHNI3kvBXBOcWXWfd9x41it
         GscZ85aHygfjlGx252VjWg3oSk4Ozb8DfJTYesZEgEup215uzjeS+hnva4/EiPjFxwL/
         esiEAghHlVjv70uvYozDK8nGiYPAUZuH1jRATquTWrYWFHbeGpgvUORB7xiWtmR8m9gx
         nWqJvqzkOnlCNKe1oS/lHYC8OAlYSTDPJQMrSaUZ7p9pKaVz8zik8IqPXsBlkpLZRvLT
         QVFN5AHzoWSqo9xBfh59PN4bnyFAq8dPcem6aHsjqxkYOi89uI4kj4YQ7y7sXsnTNNbg
         AI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982842; x=1729587642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLp6JVFP095nF2eYEIFQ7G5HMe9lih7YXmsVYNx7OwQ=;
        b=XrafhARqKYHhZ3ipLqVIk51/IqV6UK5SrHLuZVvXnn/dw6+H2e++ON7+qaN1W+PGQ1
         eR7RwWNExDNTP7og0bebESBlJZtiGd0DNtJX6NfUAwxfl2giOgrAuIBV61cMhuYN9zUs
         OkZvF0U92AUjX97zYD4U4Ykx3dVk4VigK3HxUEt2PTq6IVXv8sDnBFVV1l4KewJNff+E
         ai2n5GrhbBdfAeXg1hYpgmgoO0NpYLEoOkcXUYPdBA43V/O21izYkXmzyAR+QbG/yd94
         3K57MYSteq7rC9xOawDB5To4ASwXDNB+nrqQ5hWb3o0eDhC9cZLc+u6Oz7T0kq/57G/c
         DYWA==
X-Forwarded-Encrypted: i=1; AJvYcCU+g4CHIAJlQuxroYL08aTrCW1jmqJMjRjHo/Z1LPJ9QCsIlIk8ZuZ1XCL6gyDY50yuk+pxr9EYZtKnTQE=@vger.kernel.org, AJvYcCWwPM92xMO9ufPKvdCWw3/cog4yE2RVYbFhdX+RjbiEnfTZVe3iwPFGfg5hx8rx9Z0MAmpVmGBt91nH@vger.kernel.org
X-Gm-Message-State: AOJu0YwshgqZZ9fgE9XL44UuLdqfqyPODdwIXWi1XTxt5gGi90zpEuOK
	OloWfdnyDzHKixC5HogOyop3qOAg+5aaRMc/1OiRN3Hya9hvfcILz3Zqlq1QZXqZ5gEa9nJAI3y
	qLUkDXbzJF/9rjKuO91eKavZVZHA=
X-Google-Smtp-Source: AGHT+IGFGtlzDsf36x9uxxnLnYaB/UrLJC/zDnON1yPfZ7aozRRs96CNtkoqkrN3NerehmbM1Xihyj4mT9OyRW0OvyU=
X-Received: by 2002:a05:6871:250c:b0:288:aad0:b098 with SMTP id
 586e51a60fabf-288aad0b2a3mr2635253fac.46.1728982840464; Tue, 15 Oct 2024
 02:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014135210.224913-1-linux.amoon@gmail.com>
 <20241014135210.224913-3-linux.amoon@gmail.com> <20241015051141.g6fh222zrkvnn4l6@thinkpad>
In-Reply-To: <20241015051141.g6fh222zrkvnn4l6@thinkpad>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 15 Oct 2024 14:30:23 +0530
Message-ID: <CANAwSgSEkFtY6-i3TOPZbwB5EuD4BHboh_jsTwByQw7NLLrstQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>, 
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

Thanks for your review comments.

On Tue, 15 Oct 2024 at 10:41, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Oct 14, 2024 at 07:22:03PM +0530, Anand Moon wrote:
> > Refactor the reset control handling in the Rockchip PCIe driver,
> > introduce a more robust and efficient method for assert and
> > deassert reset controller using reset_control_bulk*() API. Using the
> > reset_control_bulk APIs, the reset handling for the core clocks reset
> > unit becomes much simpler.
> >
> > Spilt the reset controller in two groups as per the
> >  RK3399 TM  17.5.8.1 PCIe Initialization Sequence
> >     17.5.8.1.1 PCIe as Root Complex.
> >
> > 6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
> >    simultaneously.
> >
>
> I'd reword it slightly:
>
> Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
>
> 1. Split the reset controls into two groups as per section '17.5.8.1.1 PC=
Ie
> as Root Complex'.
>
> 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per s=
ection
> '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> reset_control_bulk APIs.
>
> > - devm_reset_control_bulk_get_exclusive(): Allows the driver to get all
> >   resets defined in the DT thereby removing the hardcoded reset names
> >   in the driver.
> > - reset_control_bulk_assert(): Allows the driver to assert the resets
> >   defined in the driver.
> > - reset_control_bulk_deassert(): Allows the driver to deassert the rese=
ts
> >   defined in the driver.
> >
>
> No need to list out the APIs. Just add them to the first paragraph itself=
 to
> explain how they are used.
>

Here is a short version of the commit message.

Introduce a more robust and efficient method for assert and deassert
the reset controller using the reset_control_bulk*() API.
Simplify reset handling for the core clocks reset unit with the
reset_control_bulk APIs.

devm_reset_control_bulk_get_exclusive(): Obtain all resets from the
            device tree, removing hardcoded names.
reset_control_bulk_assert(): assert the resets defined in the driver.
reset_control_bulk_deassert(): deassert the resets defined in the driver..

Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':

1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
as Root Complex'.

2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per sec=
tion
'17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
reset_control_bulk APIs.

Does this look good to you? Let me know if you need any further adjustments=
!

I will fix this for CLK bulk as well.

> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> Some nitpicks below. Rest looks good.

I will fix these in the next version.

> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

Thanks
-Anand

