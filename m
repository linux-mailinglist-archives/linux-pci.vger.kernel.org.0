Return-Path: <linux-pci+bounces-3712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEF859F96
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F9D284C1B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED023763;
	Mon, 19 Feb 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVYPHXv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFE22F0F
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334553; cv=none; b=gQXH3P/luiepXV2v5rfbfkZveUWgbVsYAckNMz+T84VEns/ekFBiPKDxinCKj6Cbqk01rjijO3ONv/WYeLhMu6qMmfGpJHCHg16Bq5BEIHW9lxORa8XtEhmLgvO5sB8zllL0PCljEVOaQexC19Z65FFK+EVW+HXIECri6XfqDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334553; c=relaxed/simple;
	bh=jHvPNV9uRImzRG0O9mrSCOyCxKrfITzEMjQ0xEJ075c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETmHX6SsoMbePGeolOa4EchjVrVbr1LDIMtAjCBJ5LJAFyx9b8Dfec6MzvYPGgy+gRvUqeLK4LqgowARFllDJm5367bXDg6Su3DbcT9LVpM0bZpSqnpjc3w73s3/n5KBgRSIn0wXBEZyFK3OMNgEhaq6ve8V96nSjYv3Am14HRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OVYPHXv2; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74435c428so3694507276.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 01:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708334550; x=1708939350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qZYTlm/0sq1vUrT38iiUN2NletxitEq6HPMC2WegY44=;
        b=OVYPHXv2DN1j6gS1Q8BWWCiBctMdiDqRo1MyTcpmRP0F43CEoCDb27ZJN5wjWcN1RU
         I5Ry4vzaF6qdRIvj6bG+pyvi7ZeM39rpFHeoWDemBLKc+J4s3/rT59fIK0eHJOrF7LAL
         iSp6lU2N9VbDSrxmIgk/Xh3dmyk2EPSFqTp0l154JUL6/2KdHJtdBAH0zQtstz+x2y+7
         AlgLx0tv7fT0FSV8VBeoQWjOfwdPRBcb3rus0RfCmPOQZFSCXWSSie5bUXiexe+PEnFA
         +2NbVm9lB0g5qBODaV1y134p8QQ2Rd7yGY4ePKOqJFzYUb5ptxNd1WOFVFFIIFk1XLhb
         jn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334550; x=1708939350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZYTlm/0sq1vUrT38iiUN2NletxitEq6HPMC2WegY44=;
        b=WasgXASHPr2vXRmSshN7fzEYuW1xig45lBcEIT1ykuH45MhOUzNN32IZb/3DugBOd/
         U06naxMmC5VuWkd69dCylpH9jNJ7c79sA+6aQagwdqQgDL0MeG+AVMC+ODhoFXa++0bQ
         WGbFG1r/EkRE6r5WaXtw5VZRtJ8IWyf0w4gy6tmhiasHNKZOlMcQLgc96UqIR66lqSeP
         3AweZYujpozjBtldwRkxylVXAummuLovFCOB2NA3O8w7nVI3vTL/I8iFhrKNPZiAyQTU
         Vq1mHSBLypGj5IGPMU/z0OB30SfN1ZNcKRX0XyQ2vn6b7eJYBNHPGOyD0FvZAz5vQAWz
         zKrA==
X-Forwarded-Encrypted: i=1; AJvYcCU/qAS+AY8leKQmGye/H1b4ZTqe5cqmQS+hNBfMEgLirjgv+RCiuVEJEp8NI2Ory7Z0nJ/Vdu9WtYJBiEQofvmIawqqD7z1OLlA
X-Gm-Message-State: AOJu0YydhG/e1tTDWpDtX8DbFbuX9nGJXyrlpy3L3EwmOx9ZEOGPj8uR
	Aj59D4dRGT17iXlAHUvYXqDap8jQOx/GQL0piDofOIgTN8SR1OqbwVCXVERZwGyp9CUOb0QlSDC
	jFLoivE02eeWHLBHuXy9hTz+wTQ+2IOLWS+fTHg==
X-Google-Smtp-Source: AGHT+IF+LL/RccnNnrVPV95NB7kYrHT+EoXkoik0+2tgdiu93HUqpLdT6cgixvw0en9NUQfCx5Dc17RlNM2cOSkIlm0=
X-Received: by 2002:a25:b048:0:b0:dc7:4859:6f1 with SMTP id
 e8-20020a25b048000000b00dc7485906f1mr9761270ybj.33.1708334550133; Mon, 19 Feb
 2024 01:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org>
In-Reply-To: <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 11:22:18 +0200
Message-ID: <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: neil.armstrong@linaro.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 10:14, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 18/02/2024 13:53, Dmitry Baryshkov wrote:
> > On Fri, 16 Feb 2024 at 22:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> First, I'd like to apologize for the somewhat chaotic previous iterations
> >> of this series and improper versioning which was rightfully pointed out
> >> to me. I figured that the scope changed so much that it didn't make sense
> >> to consider previous submissions part of the same series as the original
> >> RFC but others thought otherwise so this one becomes v5 and I'll keep the
> >> versioning going forward.
> >>
> >> This is the summary of the work so far:
> >>
> >> v1: Original RFC:
> >>
> >> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
> >>
> >> v2: First real patch series (should have been PATCH v2) adding what I
> >>      referred to back then as PCI power sequencing:
> >>
> >> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
> >>
> >> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
> >>      modules inside the QCA6391 package (was largely separate from the
> >>      series but probably should have been called PATCH or RFC v3):
> >>
> >> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
> >>
> >> v4: Second attempt at the full series with changed scope (introduction of
> >>      the pwrseq subsystem, should have been RFC v4)
> >>
> >> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
> >>
> >> ===
> >>
> >> With that out of the way, I'd like to get down to explaining the two
> >> problems I'm trying to solve.
> >>
> >> Problem statement #1: Dynamic bus chicken-and-egg problem.
> >>
> >> Certain on-board PCI devices need to be powered up before they are can be
> >> detected but their PCI drivers won't get bound until the device is
> >> powered-up so enabling the relevant resources in the PCI device driver
> >> itself is impossible.
> >>
> >> Problem statement #2: Sharing inter-dependent resources between devices.
> >>
> >> Certain devices that use separate drivers (often on different busses)
> >> share resources (regulators, clocks, etc.). Typically these resources
> >> are reference-counted but in some cases there are additional interactions
> >> between them to consider, for example specific power-up sequence timings.
> >>
> >> ===
> >>
> >> The reason for tackling both of these problems in a single series is the
> >> fact the the platform I'm working on - Qualcomm RB5 - deals with both and
> >> both need to be addressed in order to enable WLAN and Bluetooth support
> >> upstream.
> >>
> >> The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
> >> takes inputs from the host and exposes LDO outputs consumed by the BT and
> >> WLAN modules which can be powered-up and down independently. However
> >> a delay of 100ms must be respected between enabling the BT- and
> >> WLAN-enable GPIOs[*].
> >>
> >> ===
> >>
> >> This series is logically split into several sections. I'll go
> >> patch-by-patch and explain each step.
> >>
> >> Patch 1/18:
> >>
> >> This is a commit taken from the list by Jonathan Cameron that adds
> >> a __free() helper for OF nodes. Not strictly related to the series but
> >> until said commit ends in next, I need to carry it with this series.
> >>
> >> Patch 2/18:
> >>
> >> This enables the ath12k PCI module in arm64 defconfig as Qualcomm sm8650
> >> and sm8550 reference platforms use it in the WCN7850 module.
> >>
> >> Patches 3/18-6/18:
> >>
> >> These contain all relevant DT bindings changes. We add new documents for
> >> the QCA6390 PMU and ATH12K devices as well as extend the bindings for the
> >> Qualcomm Bluetooth and ATH11K modules with regulators used by them in
> >> QCA6390.
> >>
> >> Patches 7/18-9/18:
> >>
> >> These contain changes to device-tree sources for the three platforms we
> >> work with in this series. As the WCN7850 module doesn't require any
> >> specific timings introducing dependencies between the Bluetooth and WLAN
> >> modules, while the QCA6390 does, we take two different approaches to how
> >> me model them in DT.
> >>
> >> For WCN7850 we hide the existence of the PMU as modeling it is simply not
> >> necessary. The BT and WLAN devices on the device-tree are represented as
> >> consuming the inputs (relevant to the functionality of each) of the PMU
> >> directly.
> >
> > We are describing the hardware. From the hardware point of view, there
> > is a PMU. I think at some point we would really like to describe all
> > Qualcomm/Atheros WiFI+BT units using this PMU approach, including the
> > older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
>
> While I agree with older WiFi+BT units, I don't think it's needed for
> WCN7850 since BT+WiFi are now designed to be fully independent and PMU is
> transparent.

I don't see any significant difference between WCN6750/WCN6855 and
WCN7850 from the PMU / power up point of view. Could you please point
me to the difference?

-- 
With best wishes
Dmitry

