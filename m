Return-Path: <linux-pci+bounces-14344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E999AAB3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4CC1F225B2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F8219F12A;
	Fri, 11 Oct 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="karPNvp3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5E195811;
	Fri, 11 Oct 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669224; cv=none; b=VImuAp0Bp5rsJWLhRH6xys8vrXR0W7mTMb+sLxZWPRs7DtdbHe/pKkt2Z0U7WuoX7MXoK/wGV8D33duMCJPP2kfOVslkP1Vswj2bqRFRaqamLmq6zwBxjHefzjo75aMlcIV+QNmNQIQmoPSwj4qwUmIvEHI/g7oOr2fffSOtCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669224; c=relaxed/simple;
	bh=yi0IOHhsXYP7btvr12gW4x200lHHEqtCf0KvtVlB3c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnSTTDm08yK0XQVZoUO9UEEjQoG5YCw27ZRyWqa+kKyGxW3Dir3tdIjiU5jZ3myUrR0avGrdKvPy4cHTTCk4ZtPKm0B0M3JpBlXj4a9U7AO1JfdrPhJVBQxamCm0Z8wYz81bqXSbawTqB0bzeeHD9v3QQO89KaiWAaTYYlVT68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=karPNvp3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1115798e87.2;
        Fri, 11 Oct 2024 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728669221; x=1729274021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi0IOHhsXYP7btvr12gW4x200lHHEqtCf0KvtVlB3c8=;
        b=karPNvp3MUdgmu0ipD3oeKwNvEDiS+7NOejBEb8qwcBnNAvJIFTRfZh1ED9+C0Bom+
         w+nJ7PeDYsfIKpgcuk9kue+PMrKEl9Ou53A1v80GiOWMv5MX7Dp1musehqE2cosITgfe
         EDsPBO2M/mZ1o53yshLIKUB/FBaKYS//+Xgd4ouUXkMzG019uAGNSsI1nvFn0++02ywu
         V5C0q6v31m3TbxtiCPYv0cb+GNjE2TvO2qAquGJncG4gf6aW3idD4fKzeSVCHlCf7s4J
         gflSKxSxY/JybeyvzTjT/Ju6LF0VzYh2N1OBGjMBczUcNYZPqDKvyrHSN3uCniQXis5V
         HUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669221; x=1729274021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yi0IOHhsXYP7btvr12gW4x200lHHEqtCf0KvtVlB3c8=;
        b=xTy899WvHLBGb6URZnZprWZLxkoJFwtRPAFf32PxpNaJF4q/Okckqxyp0yej2PBhe4
         JQ3cYmD2w5X9HZBHFd6rnd58tXjRdni3VirTAC/7Y8U7XWn0MOM60aLOOJgA/BgGEEAq
         kDms/z5H1GheoLluhBCOXg3gftgDv5EsXvudgQqRoLpA2FUJXPc2qDyasUsuFLNlqE1Y
         YpxDqTAI8f5FgUcuqjsUoDVYZURf//04v6QgUf8uVNcrrXyrWL3bCzdBwjKl7dlFM/Ra
         fUkaiZlY+TlAaL2XHe1J9tXnopxEsGCe17rz2WlVgs2HHPgPrh/pRhDtwg6oXmnqy3ri
         rN1w==
X-Forwarded-Encrypted: i=1; AJvYcCUuX62ZWFlbXoEqyAwpT2KC0uQAR/+wVIAi7P4bP3BrU9+lFhHbDz/dhB5ffTDUDw8SWIi+DGS+eiX4rSE=@vger.kernel.org, AJvYcCVIXHEQsO41yiOkJnVdDKf4Oy34nn1QaX/6luRPqBaZn+2aV6CjK/+ToUeAZyH5LgHv5iUcvdX8xZBd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1qY4zN/Bb/mjWXlZI0WqV5iZ8zu2B8AdWjQHok23jxtBOYbI
	pPAPYnLKF5w8nw+RM0l7l9BO8Fw9JcXV2HbkwkQrSU5jrrVrNBwUKFAhsxZqIfeujl7uL/RY9bd
	T5n0+Etp8OLu1tK3JmSp8svTdSYhgAQ==
X-Google-Smtp-Source: AGHT+IEtZAwtQ3Jy0M0nPbX1jfHsYx5J6HKTKpBofyp3A65IBy2lbYIrGATmFKv2yJcksyi9nBkbyNxGrjkEjAtWog4=
X-Received: by 2002:a05:6512:1091:b0:539:8f2d:a3bc with SMTP id
 2adb3069b0e04-539da595574mr1837328e87.49.1728669220393; Fri, 11 Oct 2024
 10:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009131659.29616-1-eichest@gmail.com> <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
 <20241010201121.GA88411@francesco-nb> <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>
 <Zwk35efNI4EO1eir@eichest-laptop> <ZwlF4VhRPv6mzURo@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwlF4VhRPv6mzURo@lizhi-Precision-Tower-5810>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Oct 2024 14:53:28 -0300
Message-ID: <CAOMZO5Bi_iAJsx4sQW7YzpJHrNYWs-mC+0cTo0c7w0XjCMunXw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
To: Frank Li <Frank.li@nxp.com>
Cc: Stefan Eichenberger <eichest@gmail.com>, Francesco Dolcini <francesco@dolcini.it>, hongxing.zhu@nxp.com, 
	l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	francesco.dolcini@toradex.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:36=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:

> I have not met this problem at arm64 platform. what's your .config?

Stefan reported the problem on imx6, so imx_v6_v7_defconfig.

