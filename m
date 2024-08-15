Return-Path: <linux-pci+bounces-11716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E115953C6C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226341F23053
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619F149C45;
	Thu, 15 Aug 2024 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4Ny6AK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD881AC8;
	Thu, 15 Aug 2024 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756566; cv=none; b=K5H+pYubMvsZfyWh1OcS+qqLVax/xrvEI2xASYIglbQ4xQFyVXk9s47UhiSzypmATEPe8KmUtBFNA6enzshlVRxvrRmd+kg173nnQ+ZA75CCVTl5PQGPlGVThgcfbXre46kMUS6jqbTzLve0S6B7c/HnQTRu3n3W9RWLYAuVtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756566; c=relaxed/simple;
	bh=fVvBMj0UULUZnkQupCpjBG+u2rUcVi7Aqx85RV1nSBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTeLo2LqEvyNFaHgd69UIV0dgUk7vgt31DAgwwz1LqbHwpYBKY54/9bcoy/8mcvjIQmxhm9sGIB9nSgnz2bwUjLLjMc1ZhcaHendyl5TcX5Tri5rfE6E1waYvhpyUt2PKOwfqEN8h0Z57WqWYAA8qv0KgKLvevAMKuRwmTqF1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4Ny6AK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7391BC4AF09;
	Thu, 15 Aug 2024 21:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723756566;
	bh=fVvBMj0UULUZnkQupCpjBG+u2rUcVi7Aqx85RV1nSBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p4Ny6AK6aivo+N0XnPm6uyDgqCJNjYmqDhT+pvKNNKmOKGrHrtexokGziPmJddHUB
	 GFm0RLOhf2JbzY4lmVPeC7Fb9J1Rp+invGOcSQkNiuzm5E/VXEUI8yX5p1w1tjvq/s
	 tmrNpELaV2XXsBXs5aUMXqrCz7OaKqm8vn+3XlGKju8SAQZo2iGqij4F/xatZehzZ3
	 Z9+qgJZ/YoqyVZ7ceI66GG+K6hQvvxYvhSpR4O9U1CzNCbAahxqXMKPORTL/4M1wt+
	 a9bXFnShPk2QOtZ3pO5ul1powEcEGk8qeA0zvj4W0cT0oh/Jlwa1wk/LYoZ7r7lZI+
	 i9W2Wu5HaM2sA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd530a4eso2188664e87.0;
        Thu, 15 Aug 2024 14:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeYaZVhyNV4043nfbqTaszq7JMKCwShVD9yMcGdj6kPWJzW8p691sW0SeqMT8jO8rZjDrqzu6DITZA2DfvD5R2zsP04dc8sbz0mdSuWxqP+HamSyeGxV4J415O4Cn6bKTxGuxDQ9JOiT2r+EPjImkGDuOn1cYrqRA3TG7oCJ5bn3OxkA==
X-Gm-Message-State: AOJu0Yy2IxNzbTOnHHsJFbAhN0c6MK95nFK6MIBIvAkPv4b97iTMlSsq
	pjrwpPCCF4M4DTm2V7CbCWp0X/NoF8CliGYBC+azozPFiyZFWcaVDDyo/1+B21hyHXwFsdze4la
	tVH9oI9iJB/XH1N9mOSuRAR0C/g==
X-Google-Smtp-Source: AGHT+IG75J1dLWeE929MrvP/646DHbWXKwwu5k/xY6k1Vbtyh/V0SOpjl2x8t5yUzLueSCvTeDVosBwOzZizLZLnKGg=
X-Received: by 2002:a05:6512:4019:b0:530:ad9f:8757 with SMTP id
 2adb3069b0e04-5331c6e3865mr414811e87.45.1723756564740; Thu, 15 Aug 2024
 14:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
 <20240808-mobivel_cleanup-v1-4-f4f6ea5b16de@nxp.com> <20240815155343.GC2562@thinkpad>
In-Reply-To: <20240815155343.GC2562@thinkpad>
From: Rob Herring <robh@kernel.org>
Date: Thu, 15 Aug 2024 15:15:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rnUB2pDjf6qFF7ThtSD-C8MMZUrhJmTYKfts34Zhr-A@mail.gmail.com>
Message-ID: <CAL_Jsq+rnUB2pDjf6qFF7ThtSD-C8MMZUrhJmTYKfts34Zhr-A@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:53=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Aug 08, 2024 at 12:02:17PM -0400, Frank Li wrote:
> > LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
> > PCIe controller. Rev2 is mass production chip. Rev1 will not be maintai=
ned
> > so drop maintainer information for that.
> >
>
> Instead of suddenly removing the code and breaking users, you can just ma=
rk the
> driver as 'Obsolete' in MAINTAINERS. Then after some point of time, we co=
uld
> hopefully remove.

Is anyone really going to pay attention to that? It doesn't sound like
there's anyone to really care, and it is the company that made the h/w
asking to remove it. The only thing people use pre-production h/w for
once there's production h/w is as a dust collector.

If anyone complains, it's simple enough to revert these patches.

Rob

