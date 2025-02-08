Return-Path: <linux-pci+bounces-21028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF57A2D760
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E616683C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AF24816B;
	Sat,  8 Feb 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WGrN0B4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37641F24DD;
	Sat,  8 Feb 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739032439; cv=none; b=HwtQ1LtVuHo5v6aoSvhOR+Cv+aCrWifbFQD+BQJHWOUUK0k+IwEI30oPO0JnbWk07kWoljUArKwUp5f9lfN9fokJIHMcp3RmKj+vstavvKwPQw7OxHJKXKK2N6PdGBJyZf86AqeI13nGX1c8Le9AQ0t+kz5e1FFuYPIX4nkhUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739032439; c=relaxed/simple;
	bh=2odnIPKdmRpcI4fWPxxLuCsa99gwlsPFuClUYQtj1p8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HdY8qXsTu2UKkpOevT+WMiVcg4jtybA0ymhpEfeMzxXGWNO09wWYCWB/YwW3FABg9/+Mv2HoMPC3eyKALBevuYGGDVeAALbhUUM8XuYEhxQUgR5apkypb3kHrcNERxgPdNbV2nQ44XZwAqt2Eyeu8FWPgpBraBqIpp4pLXQCdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WGrN0B4B; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739032422; x=1739637222; i=markus.elfring@web.de;
	bh=2odnIPKdmRpcI4fWPxxLuCsa99gwlsPFuClUYQtj1p8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WGrN0B4BRzejXR+jRSydrGGdzoqy2iu3CCnw9wRmHs2BqlGgGrds7nFMxljFhrta
	 I3fRI/HpHYtBqIbEn4yD1MJUmQnFwm/V5p8QWuvEKD7qMF2D5N+iUhMGfJTBK/Qov
	 vM8ihqZ/VTe7HZluTyQP8JrQfAWUHS1+XVrU218ZOEulqt9F5SqYqK5Ld0ob/KDgn
	 NzlK4gCtaUphLDGOf93hpkcHXTjTJ2fd2ARiEtLAxGNnscmuJIvIZYt5BrKC2YmpS
	 boeZQ+C6A3eYUxMZbq0aFnK1C3WgLmcSuyosCbejhx5em8m6jOSIl4VOxCcLogfQd
	 AYhzkRFFYbJuXza3Yg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1tbtx604LC-004d7Q; Sat, 08
 Feb 2025 17:33:42 +0100
Message-ID: <4195480d-f2f3-41ad-a035-c81e8f2ab0f4@web.de>
Date: Sat, 8 Feb 2025 17:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Kevin Xie <kevin.xie@starfivetech.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>
References: <20250208140110.2389-1-linux.amoon@gmail.com>
Subject: Re: [PATCH] PCI: starfive: Fix kmemleak in StarFive PCIe driver's IRQ
 handling
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250208140110.2389-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckmcvGlM0JdmTWKDkKFF9D6w0vSs1Cu1XzrhyP10Elfoz09yniv
 9bV+ee5DGnPrY3bTrhx8rQ2KV+Rjav3xea2CiPqervgOTKSVyA//AnbOgIEFDEDcfbIVERL
 nqpX2DXS0QqXi+1FQYlrWPhWFEDgXBH/RX5l769dJ/18ogC7B6Onyf0LPjIEQZn5noExmaM
 oQHL66Zy9FeRr338pP/Dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7VSHSfAg9bM=;VHuVFXf/3oCcPfEkxzr1q/timT5
 LZRc5El9LJyIAR4qc2wXCvX/sPqKuRCQcGd4hkV01GGSENbAYB8KuWlVSLh+DgLuBDK+xbzkk
 u5PN+S/4L79tD0T6perXmm3oRq6ytTBsCdy46KB9fBTCUMczdtxreMqPFkqW4DxdiJ7hTKT1X
 MyIev+GrdRe+49ftG0aIFGCMWuAKOh8q5O0wH4F/U+KXKiRrtCpoZ/urI5VVm3clKdFNtrToP
 4WBidwZGnRD99nYDrCo/Z+hzkDUn5+8Wr3O+EYLWTctZFxf0uaZjV3qoJ/Ms+0pYub7/weo68
 y3TzdKZ6P88x30GAok4LJEuBeg77XjyByXiMCN86wHg0Z7+/MpKJTrHEFiALumP96eYko+2Ue
 dah8f6Vr0p99KmnaalzbwOLJZhQv/FYawdSYIJgVD8p856SmnjtDsASX2goF6Go8OpK/JrMvh
 +im/81HM8FOxzQCV2SD1SdRqVEZhaPp0gk+Qys9zXepCJk57sVA2fVwjcX+MBaNEthC35Q5//
 VhJjRe1viinEBlsfcapJtQUhBmRxCHZ2vPqyJAlfOhR3y5NGNDa9PJuodTwUaX92OS42iZz/+
 Bj24ouuFbWuegQxwn3uuzAAxZ6IYUWVnXIzlvjSpFwVylU2u9mxB4kI0WjT1vN40Say+6LSpJ
 EtWmmcqKw1S9YXXtiwwKScqLJrq0KKcO1puqcTMdjHOBerE/7BIDlnEOkIjXPzkYlbns+Cp4o
 tugewgQszdBNxtnpuDgHwUCboawTEiTb1WgDadULdEiD9/2dxguUYPCVVOUBLo2EQ3w14mHf8
 EIaQELiT69xTbwM3OYK9TC104R/1CBBWYfwoBpVLMt6v+hl9raEvNg7PNRq05OAZC87fCSHDp
 URtXC3+OTnxtZY00vvqk53uZpIH/6pwNpTHq9bolD8tsw82NIf/ivH5Eet34I76J8EMHbBkcQ
 zqU4v2HKXXI5GLTb6tagVXNTNa4FpZP1rr355atRzr6Ft3yehhpCVqw65n+zTO+bFXqnwvUmt
 VvopRxNOlKc/myBOJ5MfrvvLDmuo23dKrhiB/W/1amdGTeFHpMc5Yy98FvXaKRBcfa6Wu6+Gv
 oVBFYPYrSGcCKBICwyVEVl6xw/S34pNuZ8Kyfy1qII7gvRq3CZBD+u7efLHfL9N0b/8/Q7fe2
 tQtCDYNakkwGbozMMthf25YygimbJjI61xP75zMK8BXRjfV7ZrMWr/jPWsdmZlpV6mmdr9oZg
 LUeEG+ZoieilmKOQcX0yUOeBcM9AGXmvojTI4uXzeh0R5aXvNiqASCqJHFRYrzy+y+5OsfQo/
 WCmIxRScV6iB8hNu2HfBvoUNRxxKUSfZSQzAyQZzrx+tjhfoH4J1rRozHbdc/HMj6bZwDRmub
 sJvle+xR2xLe2Cjjsf5KcMvZakohbf19TS5hM+scKQbAiPrpZhyZcarM8EmC6HEb/frikqmrQ
 3DXGF8A==

=E2=80=A6
> This patch addresses a kmemleak reported during StarFive PCIe driver
=E2=80=A6
> This patch introduces an event IRQ handler and the necessary
> infrastructure to manage these IRQs, preventing the memory leak.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13#n94

Regards,
Markus

