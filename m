Return-Path: <linux-pci+bounces-14896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD09A4B88
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 08:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B990284A34
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E971D47BC;
	Sat, 19 Oct 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXV30+CK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A211D2709;
	Sat, 19 Oct 2024 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729319094; cv=none; b=bIPqbi11o4z3VrmDLgb16LZLXSlxEV9r10PXWp6I+O1D3ihxtzI+en2YvVSAvVQ/faEU9MdOQQAIOZZAN3ZMLug8TNH4Lssa14Zev1OuZsoi7bQll0JhVFRprYr/KiDxyaL1rucLi1GMwfzOLn6T5ghtR7fqm8FkFMMQUM5k1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729319094; c=relaxed/simple;
	bh=6c8tEprlgRpyEOGnmSBzvEd8iZ7WJriunKqL1qrH2jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAEpcN8YvKCTfCWb0Uk22wG8CGidiZzVgdnUh1LNmNcuL58AyeLOIqsb5FELnM7XxLFm5ldOS1LLmU+ajLHmfw6abYFmIJYJ2McuFh9wvcKKURpMku3diVHidjY5i2y4Cevzzmlmg9vraE2UJh/S1EGhXt+eOHaMnLinkE/IPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXV30+CK; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e60966297fso177282b6e.1;
        Fri, 18 Oct 2024 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729319091; x=1729923891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aqfDVL0Ui2+N+plDVqix8L5EBySMGbGA6cirRvu98po=;
        b=OXV30+CK8e3Dn32+ZK+wvWeHv2PNPbtDJO+ObzrjyZFfiWb+G96Tfdz5LcKp/xGlJV
         nIKoru6rGg9rSCL/IRKG6F5yX6RVtn31ZQv24h/jukhP2aSihaDEJWbgfnnp7c5+1/Pp
         9a3HvKWkCXGXpemjVQAssqd3WF/diQpQHkGbmcPvsMRVeKF6JZBrCkClHEoetWjlxf6B
         CMty8UL4X/nsTri6XQoC/HsefGwT9l3D4Vx8VIFjgdyCJ1mAijJiAXTIyFfV9CMwYZ7d
         TY5QCYFHSc7a55vHIL1j7/shcNc70BWnBYiFfaKlbodI455UfaI8dVNVzzSDVdVgnajo
         GeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729319091; x=1729923891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqfDVL0Ui2+N+plDVqix8L5EBySMGbGA6cirRvu98po=;
        b=JHbBuh5DwqQBNCjmJXd2VY/hPC6yH0uCCzgbgNbmZatdHztUgY96gpVMz/mcPFCaqx
         Tx5wh1zQWL3Z2k4kuvwkwf6swpr74PRWrv9RDEzy35JIA7xpd1b10E+P3Cir7BZEwcaB
         zQ9BQeJbHzAJfYRz/HTT5c+lvpPEwQFTnROadFx2J2bH42ft8unh2g8Nq7XZ382UAdCK
         DDli8YZKttjpqTyseLNsGNhX7N/tSoQRYKYIX2+jbuhh0atggsMJQXMcCpV2Pl5xo75S
         nrPIWYS7ufDpFzlXT03zD9UQfCQVzGAiJeIxzx/y+tt6r3i1kdAUenn/vnbztROGu5QQ
         Oa1w==
X-Forwarded-Encrypted: i=1; AJvYcCVB5zGdZjX2aLkUBAwpqxeH5mxwjJwKeE+caX6gi7Cadlid4YKY39ICNlk03JqJBEp1jTO1D9KeyE2m@vger.kernel.org, AJvYcCW5h1OkK50N70Bn8Vt2QXrs9HltY5EZJCsm/9F/tnScIroaZb/6Zx0ZGaBs7MhDH18rDQ9xYjYYrLD1@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxFHAd4cw7FI5nWKw71VtfKcUKmL+TbkwrWcOmuJKNQCyHb6U
	VclwqJeSCHO0fm+Pxdu53bBI0YThV8xE5DmdJoWcKIAB6li4FG32nhg2V3/Mu5dx1QsqUUn0nZQ
	nMJFDbQwDfnGGx8WHoqnXjKXnhHk=
X-Google-Smtp-Source: AGHT+IGjqnIFhOHt8hQqqDysIqkslkMDsww40WzD+GUYcyzJ2RM/VnTIs5id9OUp76YAk8O1Lbzb38x57yyqf4Rmmp0=
X-Received: by 2002:a05:6870:b487:b0:288:33d1:a95e with SMTP id
 586e51a60fabf-2892c528028mr4349259fac.30.1729319090940; Fri, 18 Oct 2024
 23:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121408.89890-1-dlemoal@kernel.org> <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
 <f13618a6-0922-4fc8-af01-10be1ef95f0d@kernel.org> <CANAwSgRDbCCridYMciq=xSDPV0qGhs-OhCJ_uniXFbp-yM5CcQ@mail.gmail.com>
 <0f2cf12b-3f27-403c-802e-bb8b539766b0@kernel.org>
In-Reply-To: <0f2cf12b-3f27-403c-802e-bb8b539766b0@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 19 Oct 2024 11:54:36 +0530
Message-ID: <CANAwSgRXfZ9hgdJpSrwucHQfMToZwSC8N-b4MYLZjsryid=Fpw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Fix and improve the Rockchip endpoint driver
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	Rick Wertenbroek <rick.wertenbroek@gmail.com>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

On Wed, 16 Oct 2024 at 13:38, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 10/16/24 4:22 PM, Anand Moon wrote:
> > Hi Damien,
> >
> > On Wed, 16 Oct 2024 at 11:45, Damien Le Moal <dlemoal@kernel.org> wrote:
> >>
> >> On 10/16/24 2:32 PM, Anand Moon wrote:
> >>> Hi Damien,
> >>>
> >>> On Fri, 11 Oct 2024 at 17:55, Damien Le Moal <dlemoal@kernel.org> wrote:
> >>>>
> >>>> This patch series fix the PCI address mapping handling of the Rockchip
> >>>> endpoint driver, refactor some of its code, improves link training and
> >>>> adds handling of the #PERST signal.
> >>>>
> >>>> This series is organized as follows:
> >>>>  - Patch 1 fixes the rockchip ATU programming
> >>>>  - Patch 2, 3 and 4 introduce small code improvments
> >>>>  - Patch 5 implements the .get_mem_map() operation to make the RK3399
> >>>>    endpoint controller driver fully functional with the new
> >>>>    pci_epc_mem_map() function
> >>>>  - Patch 6, 7, 8 and 9 refactor the driver code to make it more readable
> >>>>  - Patch 10 introduces the .stop() endpoint controller operation to
> >>>>    correctly disable the endpopint controller after use
> >>>>  - Patch 11 improves link training
> >>>>  - Patch 12 implements handling of the #PERST signal
> >>>>
> >>>> This patch series depends on the PCI endpoint core patches from the
> >>>> V5 series "Improve PCI memory mapping API". The patches were tested
> >>>> using a Pine Rockpro64 board used as an endpoint with the test endpoint
> >>>> function driver and a prototype nvme endpoint function driver.
> >>>
> >>> Can we test this feature on Radxa Rock PI 4b hardware with an external
> >>> nvme card?
> >>
> >> This patch series is to fix the PCI controller operation in endpoint (EP) mode.
> >> If you only want to use an NVMe device connected to the board M.2 M-Key slot,
> >> these patches are not needed. If that board PCI controller does not work as a
> >> PCI host (RC mode), then these patches will not help.
> >>
> >
> > Thanks for your inputs, I don't think my board supports this feature.
>
> The Rock 4B board uses a RK3399 SoC. So the PCIe port should work as long as
> you have the right device tree for the board. The mainline kernel currently has
> this DT:
>
> rk3399-rock-pi-4b.dts
>
> Which uses
>
> rk3399-rock-pi-4.dtsi
>
> which has:
>
> &pcie0 {
>         ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
>         num-lanes = <4>;
>         pinctrl-0 = <&pcie_clkreqnb_cpm>;
>         pinctrl-names = "default";
>         vpcie0v9-supply = <&vcc_0v9>;
>         vpcie1v8-supply = <&vcc_1v8>;
>         vpcie3v3-supply = <&vcc3v3_pcie>;
>         status = "okay";
> };
>
> So it looks to me like the PCIe port is supported just fine. FOr the PCIe port
> node definition look at rk3399.dtsi and rk3399-base.dtsi.
>
I have a question can new test external low power GPU with external cables
which supports PCI host (RC mode) with external power supply for GPU card.

Which mode is suitable for the PCIe endpoint controller or PCIe host controller?

> --
> Damien Le Moal
> Western Digital Research

Thanks
-Anand

