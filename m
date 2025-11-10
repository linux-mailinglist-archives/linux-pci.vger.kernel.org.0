Return-Path: <linux-pci+bounces-40682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C83C4565D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 09:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612A71888461
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37F2FD1C1;
	Mon, 10 Nov 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bovRykUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CF2FB978
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764080; cv=none; b=pJxywQdFy/1MSovcanS8xjCBbLydR4HyqhuYpkmrnl5NnUYEBQ6/L8ZofYXNkpUOXVuxfVDlLqyGNXCNlBsbiz1NezR5GcieLoQGwrqCTiUqTY0d7ekVvPUoee1nyYcNzrU04o+/S9mgXF8ohheHrsbGP6xhy7FOBXfa4aCc9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764080; c=relaxed/simple;
	bh=jgIEC3io5JNbRWacuU/h993h9DriZXR9D2I9x9lfLPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHd3DvPZzu+orwdUbMij5FZpvpv1L/anLRCVAE21fvuDbT5xBxDUMzR3JDtQ5VgUFW9iEk8NC+2n88a3UzkCfjw4g7Khaq0/8QGrFgEkyuaiKeyyoAlsyUOhSUMZP5khWjGy8826FtzB9Qwyp6+7JFVTcmDhh8JUERmqNaDG0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bovRykUg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so1295778a12.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762764074; x=1763368874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P0y/Q79WY1s2WSJKAVn4OYeud7z6vgKLms8t7x+yjg=;
        b=bovRykUgnAqiB+pop1jaF80oFF1N6ziudOzx1wnsVLvbzKpbYojkvpzZh8IIL76Lzy
         JKIeWRw2jk89TNZA4Hy7E+onx8k4SaETj0gYExY3XBhMEvzOOiDaGJ+rpDFGHte3EEXT
         IitteGXtzGEQ21kWXJPHvy6VAoODnQx56mwBfwT9g6scYM/4wI9uBYQepbpYDfsQdZtF
         FkKf7UmzNtdzjTn4fDJNRNs2l2Dj40v8iCuypd8tLTXQhKhzzBkAvi0qQvcxOPf04MsU
         U0J6IBxLLpMTuHkEyhkH9MXNDM/ZiusBvKCI+uIHQa8oB0sbk2eg508Mpvr6bKsvxIjz
         QGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764074; x=1763368874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6P0y/Q79WY1s2WSJKAVn4OYeud7z6vgKLms8t7x+yjg=;
        b=i+daOoEksQPleuzWGAS+rq0R/0kzCxtHupLjBptEc6qBQOSsGlZLqLvFSFMywkeU4+
         oszQk4+9RwO1TnC6sZ/fyZT0UCDuOyAI99AW6BRaZ9OezKsNX/VHg8dcL2Bm7j0Koz2W
         oiwLRcJnVnUJb9ww2lnXHQz+KUPMJPb9TiObkJqFC2R6VtqVPnnaQ4PJ2EG+5FhPfHFS
         L4x0TjrOK3DabKCR77YH9x8o4bZSvsSg1WfbtP9E6KWLLZ2Rz1qbHLIFCgjKRXp5706y
         8HE9vvf/wltg9ikrhI48vKYYYweC5/jS4UkI+805gtttHr84ZON903FZPRUgtgRD5E7f
         rejA==
X-Forwarded-Encrypted: i=1; AJvYcCUddd+iGBhrEJEHX+YVRiotAC6r0nG53vq6bEO9OLC7yKNwzBB53bS/kvZ+xyp1jsGh0QnG0ML5hi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEbR5S6iar/Ke9OiT/wHJ0wIiAYfxdZvFonDdA/HhSBAINnd1
	EQkbKUTItq8ju41Rwi+Usre2Sq+3vJuwtThNVV8WeWarZwOdNUTgfeFHZhb2KD48sUHGB5Itsmf
	mP0IrKyi0BsHChbtidgAdUjOOIacHWA8=
X-Gm-Gg: ASbGncuJGL+YxNhEe1jicfD/EgZaG44sMaJ80cTpJ15EkNdBrJrORmrSbd/wLYt28mN
	MsJkItO31qIjF5EB+6wSidme303JED+lxKxdPIX4HxfM3gv/2x3NuxcXFLBjVWOy8t4Wi0VQ1TO
	WmY4QfML4OaiCBwBCa4T+dBKRnRsysHOvd0rr+fxcRkQahB3UJeB/Ony+pCtH+RZZu797ed+Rw/
	3F6osIafVW4+DQFQTwuFu2AGoxAKFRe1/hrUxEYk9kWF9PCad6D00DtxwbfAqspy2o9GN7FP+25
	JIRe
X-Google-Smtp-Source: AGHT+IESNTw6qjYvvZVQIviNrko/W/ThLKfPP6Zlh7jZBNCmaaRmiw1Z2ff+JZpJCCEs3KNCeqlEMNKff6nGkITYWsM=
X-Received: by 2002:a05:6402:51ce:b0:641:72a8:c921 with SMTP id
 4fb4d7f45d1cf-64172a8d10emr3999634a12.23.1762764073934; Mon, 10 Nov 2025
 00:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <cf6zumlp4iiltglu7bbrpdeysaznrkyvlemwl4lxwkfjkgux7a@wl37bxilsprx>
 <cbvcjgcd7saxj42ifgqn3l6mwpgenlhbr4zuf5ibqbtj6rmzqh@yuc7flbwyi2y> <CANAwSgSvtc57kh-VJewk5=_MvfL3KVxNFU8C+tGh4iqJhnEVtw@mail.gmail.com>
In-Reply-To: <CANAwSgSvtc57kh-VJewk5=_MvfL3KVxNFU8C+tGh4iqJhnEVtw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 10 Nov 2025 14:10:56 +0530
X-Gm-Features: AWmQ_bmU-RlL1-d4qH4b9tmN5UWK_GZG4fHWCZvQROFJ3et4gEEIr6Y6zbTvTnI
Message-ID: <CANAwSgTj0JzFN2CHOSG=X_gx5KttP-tZeLaC5uYZYhcPheP_Vg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI: dw-rockchip: add system suspend support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Fri, 7 Nov 2025 at 00:31, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Sebastian,
>
> On Tue, 4 Nov 2025 at 00:29, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > On Sat, Nov 01, 2025 at 07:29:41PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Oct 29, 2025 at 06:56:39PM +0100, Sebastian Reichel wrote:
> > > > I've recently been working on fixing up at least basic system suspe=
nd
> > > > support on the Rockchip RK3576 platform. Currently the biggest open
> > > > issue is missing support in the PCIe driver. This series is a follo=
w-up
> > > > for Shawn Lin's series with feedback from Niklas Cassel and Manivan=
nan
> > > > Sadhasivam being handled as well as some of my own changes fixing u=
p
> > > > things I noticed.
> > > >
> > > > In opposite to Shawn Lin I did not test with different peripherals =
as my
> > > > main goal is getting basic suspend to ram working in the first plac=
e.
> > >
> > > Wouldn't it break users who have connected endpoint devices and suspe=
nd their
> > > platform? I don't want to have an untested feature that could potenti=
ally cause
> > > regressions, just for the sake of getting basic system PM.
> > >
> > > But if your goal is to just add basic system PM operations for CI
> > > testing, then I would suggest you to do something minimal in the
> > > suspend/resume path that don't disrupt the operation of a device.
> > >
> > > But this also should be tested with some devices for sanity.
> >
> > My goal is proper system PM support, but I would like to go step by
> > step. Right now system suspend on the Rockchip RK3576 EVB just hangs
> > the board and it has to be power cycled afterwards. In parallel to
> > this series I've send a bunch of fixes to get it working. It surely
> > isn't perfect, but I fear things regressing again in other areas while
> > the complex PCIe system sleep is being worked on - simply blocking syst=
em
> > suspend is not very helpful, since it effectively hides suspend problem=
s.
> >
> As per my understanding, the current DTS configuration is missing definit=
ions
> for critical PCIe power management GPIOs (clkreq-gpios, perst-gpios, wake=
-gpios)
>
> clkreq-gpios, such as PCIE30x1_0_CLKREQn_M1_L (not sure if it is used ?)
> perst-gpios such as PCIE30x1_0_PERSTn_M1_L
> wake-gpios, such as PCIE30x1_0_WAKEn_M1_L.
>
As per the TRM 11.5 Interface Description
Signal Name     Direction   IO Attribute             Description
------------    ---------   -----------------------
------------------------------------------------------------
BUTTON_RSTN     I             Pull-down                    External
reset button input; pulled low to initiate reset
WAKEN                   I/O        Open-drain, pull-up      Wake
signal; enables device or host to signal wake events
PERSTN                 I/O         Pull-down                     PCIe
reset signal; asserted low to reset endpoint or root complex
CLKREQN              I/O         Open-drain, pull-up      Clock
request signal; used for dynamic clock management

See the following commit 4294e3211178 ("arm64: dts: rockchip: Split up
RK3588's PCIe pinctrls")

    These pinctrls manage the low-speed PCIe signals:
    - CLKREQ#: An output on the RK3588 (both RC or EP modes), used to
      request that external clock-generation circuitry provide a clock.
    - PERST#: An input on the RK3588 in EP mode, used to detect a reset
      signal from the RC. In RC mode, the hardware does not use this signal=
:
      Linux itself generates it by putting the pin in GPIO mode.
    - WAKE#: In EP mode, this is an output; in RC mode, this is an input.

    Each of these signals serves a distinct purpose, and more importantly,
    PERST# should not be muxed when the RK3588 is in the RC role. Bundling
    them together in pinctrl groups prevents proper use: indeed, almost non=
e
    of the current board-specific .dts files make any use of them.
    (Exception: Rock 5A recently had a patch land that misuses _pins; this
     patch corrects that.)

    However, on some RK3588 boards, the PCIe 3 controller will indefinitely
    stall the boot if CLKREQ# is not muxed (details in the next patch).
    This patch unbundles the signals to allow them to be used.

So we can use these pinctrl to perform different tasks
like PERST# to reset and WAKE# to wake the PCIE in suspend / resume state.

Is this a good way to split the rk368 PCIe pinctrl into separate components=
?

Here is the example user wake gpio.

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 19a08f7794e6..13a7aa3ec1fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -359,9 +359,10 @@ rgmii_phy1: ethernet-phy@1 {
 };

 &pcie2x1l2 {
-       pinctrl-0 =3D <&pcie2_reset>, <&pcie20x1m0_clkreqn>, <&pcie20x1m0_w=
aken>;
+       pinctrl-0 =3D <&pcie2_reset>, <&pcie20x1m0_clkreqn>, <&pcie2wakeup>=
;
        pinctrl-names =3D "default";
        reset-gpios =3D <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+       wakeup-gpio =3D <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
        vpcie3v3-supply =3D <&vcc3v3_wf>;
        status =3D "okay";
 };

I haven=E2=80=99t come across a working example for this in RC mode.
Is there any confirmation that this approach functions as expected?


> However, the RK3588 TRM indicates that these power management functions
> can be controlled programmatically using specific memory-mapped registers=
:
>
> The PCIE_CLIENT_POWER_CON register at 0x002C provides comprehensive
> power management controls, including link-state management, wake-up
> event handling,
> and clock management.
>
> In PHY GRF, we have the PCIe3PHY_GRF_PHY0_LN0_CON0 register at 0x1000 all=
ows
> direct control over the PHY's power state (P-states like P1, P2),
> enabling transitions into
> deep suspend (L2/L3) via register writes
> clkreq_n Clock request for lane X. This is a side-band signal that a
> PIPE 4.2 controller needs
> to enter and exit P1.CPM, P1.1, and P1.2 power states.
>
> My thought is that using rockchip_pcie_phy_deinit() in the suspend
> routine and rockchip_pcie_phy_init() in the resume routine are
> incorrect; these functions
> likely perform full resets or power cuts rather than managed power
> state transitions,
> thus disrupting the desired suspended state of the PCIe link
>
> I tried a few things on my own, but I am not moving forward.
>
Thanks
-Anand

