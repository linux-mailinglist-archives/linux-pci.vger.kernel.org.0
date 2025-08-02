Return-Path: <linux-pci+bounces-33327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E6B18DD0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24667B9426
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469E23A9B1;
	Sat,  2 Aug 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sts9XNSq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE621A435;
	Sat,  2 Aug 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127379; cv=none; b=Tn6hk4ISPLGt/+ykl6+Gwakekv312mn5eM2srRcak7nXBX1CIx+2K/4rl9LzOzbgYVWJIOV5YSOs51oUt030WYy+YQ7CvysMFZke+B/GXFzR5APC41N7SGqH/8fly9P6gFC/rdbLeMmbeFV0agV047kkdb33U/MF3Ujow47OFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127379; c=relaxed/simple;
	bh=58VHC7Mi4TeuAi163qriS0ffCP7GjWSqQy+r8mSTT2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFKV5x5+ZomYXJpdyaxyOubl5dPWAiHKfTQl3tCqoGH7FEJ3Y/Tm133fsOgt0yxQIJLPl3/aKb9M67WjPDzV7WKvnG2DwtScySkVf11pvHYmc67upws13PLF85sCgX2tGHWw2h95g5IV5Z8dR96seJemG057K1MtZpqAh4v52uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sts9XNSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFC0C4CEEF;
	Sat,  2 Aug 2025 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754127377;
	bh=58VHC7Mi4TeuAi163qriS0ffCP7GjWSqQy+r8mSTT2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sts9XNSquPiYTtj2bfDwL5AS4K8D0Or7sdR+KHftWpEs40fqczZiotSPv340XnL1d
	 ur1CcGPtElbWIpQKQeG3P4ZLlfzes2Iny7ySZb5hFSxHsrAU2sKCP1OdRwN2S9zBeo
	 J4tQg1BghhZmMafDC77l5VvqFJGt0/+Z4947o9MZgwoNGfjnAW7p/GL/kglbZYqccf
	 wB0pUb5VxNiucrRQK45M7yPCCHIC9y0Wm8Uf73hvDM0flcUy5Gw1zB+OlQOEq+5ImJ
	 W0pWDFfXSgHYkwzE00rf2NnMMp7gYWK7oCthKEEjO7FUJRfazlRJQ6gInl0evBamYc
	 hj0ge10SP8TdQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6196ca9a2edso675448eaf.2;
        Sat, 02 Aug 2025 02:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVoErOMt+HDj/TljJFzf5EBTnZ4rCJTzi9sv75Ri7sU7KsSY/uVxDnGFpYJtOlE9XTutz5VinX3CiD@vger.kernel.org, AJvYcCUgvImntkhZSriNlEBOmzBfNzwMiJpN1hKvmfsNhQLjFu8Cdegyq5N+iojdoGh+V/X0fFchu2kZgm4=@vger.kernel.org, AJvYcCVitY2ybxgnvmlVUiiuP5v4n8NFEfWbcXBYaK0P9D3OO7f/UD568Nbm1ChR9FW1o19COK2havGbZQeB@vger.kernel.org, AJvYcCVwTLt5zgi8SWNQJDfEVxWbxHNACV796pXxVLb+ypQp/sJi85khD2IEobXuN4xDVERnO+Q4PneaBTick6qS@vger.kernel.org, AJvYcCWCPHqrwSDpq1xSDocoGCwkwHnpgZfNlAdg+VRURsGhmi1tiIf/Bid5acO0qlOeF/Q5Z9M/08QMR3LyTDkqBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0R+YQfjB91iav2tx88Yi25Y2K/xw7C/qGQi68bbVJBbBzA3z
	BPTLQyYjEarfOMgW+uH9g0QnVLKhcGYs/aa2KClrAAAq3KFCPvXXFUkiVVseM4dK031L1LXIR8y
	El4RxloVeRAWmoBpqqjtbiNPHui2QQZE=
X-Google-Smtp-Source: AGHT+IHnhknTEMDLbuTEKMh9lcCSja/NjO/klqpCZxfW7EQGD247lmqRVINJryqxHY7tsuRemkuIh7F5glei8+UCtIY=
X-Received: by 2002:a05:6820:f01:b0:619:7ffe:b0c6 with SMTP id
 006d021491bc7-6198f2dfb57mr1376577eaf.8.1754127376290; Sat, 02 Aug 2025
 02:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-wake_irq_support-v4-2-6b6639013a1a@oss.qualcomm.com> <20250801213111.GA3511902@bhelgaas>
In-Reply-To: <20250801213111.GA3511902@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 2 Aug 2025 11:35:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipbMLTTLab933TpugX1NO3bJvJY8AS_LNo+7C8xGvLhA@mail.gmail.com>
X-Gm-Features: Ac12FXyZqjsVrbn0WJzw_IJDJnwK-FjYKy28NaP1ZUaO9Na2BA0Qj7Pg140AlMU
Message-ID: <CAJZ5v0ipbMLTTLab933TpugX1NO3bJvJY8AS_LNo+7C8xGvLhA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PM: sleep: wakeirq: Add support for custom IRQ
 flags in dedicated wake IRQ setup
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 11:31=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Aug 01, 2025 at 04:29:43PM +0530, Krishna Chaitanya Chundru wrote=
:
> > Some devices require more flexibility when configuring their dedicated
> > wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
>
> I guess the "dedicated" in dev_pm_set_dedicated_wake_irq() means "an
> interrupt that only signals wakeup requests, possibly used by several
> devices," not "an interrupt only used by this device"?

Yes, it is supposed to mean "dedicated for signaling wakeup".

