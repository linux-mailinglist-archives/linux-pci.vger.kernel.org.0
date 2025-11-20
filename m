Return-Path: <linux-pci+bounces-41787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6DC741C0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3533B352F65
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CA33121F;
	Thu, 20 Nov 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3KOFK2vC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC633A6F8
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644402; cv=none; b=VEdps9NUkNJkoMwVT3DKnXhPrCFPVCkoUzvef3GvrrXq5WVBfB24vxPsAh189vNimnVbhl13O5iVViS0RuOaoZrGJSKJgKFTH1GhBpbaPQsRq6gJ/kM1p0u1AmNnD54eR8pEpHgOAHUvYHBonYs5eoZeaSug8yg2bDP959W57n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644402; c=relaxed/simple;
	bh=cYnw6mILUdG7jwQbmEOSZCzPn1Qy/X0WOmyM5lAFa2E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUvuK/cJuIep07eCMMI68l8gLWtSdRhBDvP6AnO61LaohdVU8SrIiDoAhF3VhD5dD+c5xNrp8TeA5EYxRZhipcWEs2onAIPlTcFA8uXq6h5fan6WfUx168cUar9RNk+7PtDJ8jDX97MLNA6Ks1NcvpW0lXt+iWajijATdPNMA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3KOFK2vC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-595819064cdso1197684e87.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763644399; x=1764249199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9CPUAfs7BP1bunU81Er2Ml1UC+NO1ZmM5hBAKDue8Hg=;
        b=3KOFK2vCYxq9yjPv6rWzkYJQMgBsU+80LuKX2wdHBbgUEFFM2yqr56K1yRGCLqquE6
         aBzJqI0RtOW5RbXj9//xl+lW+lJtL/7axyudXpI2phtbGm6+rSn5V1VpRQJSeKnljiS1
         80diGmJQeJzdkJopS2gnMW2Js3C3E4Fgd425bfo0QUmQiykxkfJ8T34M/+wAgLpjz2Ko
         kmA3biYesNpuY18CBy6Qstzy6xC/RtIw52tFjVGJtNVacbHcvOFjgcD3lwinQzYWyi3c
         ohn1ZqdLSETYZKD6teulm8jkXi0Us1ZmCyuScHYUhlf+VgqB/T8j0mHKrMKBJ639s//Q
         tmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644399; x=1764249199;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CPUAfs7BP1bunU81Er2Ml1UC+NO1ZmM5hBAKDue8Hg=;
        b=HhLi2j0v6zmrQjomrPTOmvCGrVzGeJ/CSgQe9eoEXzlsr74VGTLDMdiHctDhzdXbIb
         Ag7BDvFMa9CwIMq7zFgiZBL6ph0WH4Gj/Rovhgu2gQlOV9ygPyiTYbMu+QV2NMRd0tCK
         IaDrM+RxD5NIxH9JeiqkoOhz5pCmcp5IwK8cedOZPqMJbSLKvdLU5EAEqln2YD2aBAuZ
         tjC31o6O6H/a9QzlrhWY3lEupcdiZAzlksXPW0wI5pnlsqPRya8XgPP01Zh6WSMz6vKX
         4muQMtUJj3Xt9R0zmWhqvk+XjNrmK7OKDgCVNiMCoApsLNtTT012lNF0/yIaE8IKnLhM
         RDgg==
X-Gm-Message-State: AOJu0YyZNITx/cLGMQdd4WOMsLsRGXWldT/G/O2jlm7wvWQMQ7VwcVMJ
	kEQ8WxTKZe6qlBc7PBdLkGLDlVQSRLdiWOstOtqE7vK4U0GvApuTctK7V4owJXpzi3QYxuAW7Q3
	I1Dallu17YmdIXdsYeJ9m1H/F/vApLBy8lOpkNc9vqg==
X-Gm-Gg: ASbGncuGNE4Lt8MWAQR+TO/PGP2cWb/DvECWxp0w8GIFeD/+OqMCV53Z/r3APbzRm3P
	rvbQ00fwT7hIEjHU45xdU1G3WgzMy8+EJq7HADQ09Km91XmN/cHXAX1PHCXr7Em9jy4D9DebAxu
	qAbYi/HOX1O++Ml0V6pYbAhodinax0cXutyAAjr0RqD0XlHCPuE7NETYWVOolbVnjc/qfXiiN3V
	uiBenSAtIr32+w5w2yq31/EmK3AtKov8RiwjLrK42jCCSPwRcjDVUyOA28uFua/bz8XsxHcIw4C
	Q6RyieADF2I7xwe5khloCkOciQ==
X-Google-Smtp-Source: AGHT+IEriWww+bAHMRQLIcwsRuRhuu9DYBIt5585DuFOpFCwK857ghF7yKE+roKTC9cSScCNWGT1JYNKweaUPdZFL0A=
X-Received: by 2002:a05:6512:4025:b0:594:1cef:21fb with SMTP id
 2adb3069b0e04-5969e9daf8fmr827494e87.3.1763644398484; Thu, 20 Nov 2025
 05:13:18 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Nov 2025 05:13:17 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Nov 2025 05:13:17 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251120065116.13647-3-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120065116.13647-1-mani@kernel.org> <20251120065116.13647-3-mani@kernel.org>
Date: Thu, 20 Nov 2025 05:13:17 -0800
X-Gm-Features: AWmQ_bkVZln5Tiz1uB0lS6Iwksb6zInyNqeQ8H-JChy0IZD3_zXaDp9uc9XcsPM
Message-ID: <CAMRc=Mfv5i5nVeq+Xm2Oj5VR0CDUq_AnqYzdzx1wE0rdnBrTrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/pwrctrl: tc9563: Remove unnecessary semicolons
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	krishna.chundru@oss.qualcomm.com, Manivannan Sadhasivam <mani@kernel.org>, 
	kernel test robot <lkp@intel.com>, bhelgaas@google.com, brgl@bgdev.pl
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 07:51:16 +0100, Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> said:
> As reported by the LKP bot, semicolons are not needed at the end of the
> switch and if blocks. Hence, remove them.
>
> This fixes the below cocci warnings:
>
>   cocci warnings: (new ones prefixed by >>)
>   >> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:351:2-3: Unneeded semicolon
>      drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:414:2-3: Unneeded semicolon
>      drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:316:2-3: Unneeded semicolon
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511200555.M4TX84jK-lkp@intel.com
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

