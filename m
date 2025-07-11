Return-Path: <linux-pci+bounces-31919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49036B0183A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954B11717C5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E827B4F2;
	Fri, 11 Jul 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YnF55Iyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0C27A440
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226795; cv=none; b=XNeTvajLY/Z6ZWfTKwMqzAX7Y1QPgBxFgWGksYh6WJ0jmCiqI+YrD0/M+GcDiKL9W8P3gBvoL9Oc9UGM+wxCXDD8DHiQg+GWsr8ABHsCQkIZsi+N0QMFjMfdI8iRas5PPB1SywN801TonvzvAeGVNfh8hSNPqx1YJniU4P6ufu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226795; c=relaxed/simple;
	bh=pGQpbekutr1+Uf+KF67JGtP7oLUb+5ENqzKXL2RpdgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3jnnpVZAIYZZmgVXnvrqj8a6E9R+UYQatrAd2y6zIK2qPKKxNU9f8/ws8DTzpoDnzC0M3rDLqBMbXCXzZzMwkbjrtaWJH/FH4DKx/ijaA/ZnI7PkZ9kcSiD7VZRKKjqKAkNSVD9jxY99XAGej8h1Gq69116hdT2Rokbl0vDHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YnF55Iyr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so1606713e87.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752226792; x=1752831592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGQpbekutr1+Uf+KF67JGtP7oLUb+5ENqzKXL2RpdgY=;
        b=YnF55Iyr+f1TQQBbW+4dbQpbrWbGMYN1qe48O6u6eLvCyjKF7Apae2xFP0GknxCzpx
         yEqV86rbbOVvww8lcw8A9ML6J4FOTGrf9pd+F14XixhNimXWJJ2oYAuV/gw3fQ5sOZ1x
         jx5OLZSMCgXc0PgXDo5FS4tv+dta7z4+2zzQ+5ca3eMVV0sNxlhsyXdX8KXH2H6mcGv3
         tVQpzyrTzm2Ih8dViGm3M0HblxcHo0FKsvSaqhJwRy25FDDbl7bB/Wyk+KvUXOX2eqJn
         MZEXQ9tuhKMFVI2a6dzFz/fG28TyrWWyb5cbGvMB+4SgOl9CxUk8FfHnxHJA+rA1yInY
         Nwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752226792; x=1752831592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGQpbekutr1+Uf+KF67JGtP7oLUb+5ENqzKXL2RpdgY=;
        b=F2kiB98UQR4PLAZa0X+gHIORctwPOg2TM3SPKrwo+qYKOtQ8Pt5smzOXQIhWZm/Dxv
         5fBbiDDT49IB2nNRmXALSVkUfnwfRaVFJL1iUNohCSeNFURW8o6aDgX01RaTHIzpl7Q1
         CIhoevHeeeOnH0xufg9Rw890+KY7lj95RzTQQ739jHhNfnt/bNdFXkN+uIO3hM84zQFr
         +zEN4jQoNxwVUHWioqFNmZoQL+rKTzh04rHz0iwQOj4WMuzQxo32HScy+o66PTD7ZIGa
         YqEz4gwFMMVhdDFgW6q7tyCJB+Wot1bRlaHxuW9hpwF2Z0Bhy++Teelltp9wb2vY5y8n
         khMA==
X-Forwarded-Encrypted: i=1; AJvYcCUiupWRt6PPqM0yKBo2yWAGI1Ox0oNQbk/MCgoJseAzoFcKdL5zGiO9LZMQgQfZLfH0kil3vj8d/PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpu4IVnuzbt2FygLBYWawnAh81YYsntkNOZ6L/GaMo75BQe16k
	rsseLAwXj/tC9H2cglRC5HbKfi376UN7anrnttbhuzeWqnjBAQpWG+WtFN36Qq7hqb8S6vCtrEv
	BmW8UCmCQydv0B0Bz3GExnXdipXZWApOZRl9QdC0ehQ==
X-Gm-Gg: ASbGncsAk4bITzZeLLLVHWRN3WG0iXsjgm5Yltk8bVVdfpvoBKkb4Zp1F/or9mnR5sl
	CVQfUi8g6pvzdFEJBk0NHYO4mqtM+7Dwb6PcjcatrSNe5QuBkaeTJgnu6KAgBZHkBzIOolVAzfQ
	BqGpoE9QcTLfhMXX3j7Vq6FzozjC6igNDb4b7nDpj7lIQvDkzIJKzgc0gGlRvGCvQ+PrVqKJml4
	RKzWG13E6H0l+MyhKVKnPlwUzqB2Gk/QMrnrEQVm8PrEEXE
X-Google-Smtp-Source: AGHT+IEFk4At+JNCjXR8Uv2tek5dQDztaiCpOCt16GcwngGIlLiBnZEyMFdRM1jzv3F2PaNLrKmME9qrl+gtzXvZYmI=
X-Received: by 2002:a05:6512:10ca:b0:553:2375:c6ea with SMTP id
 2adb3069b0e04-55a04625e5dmr712182e87.50.1752226791849; Fri, 11 Jul 2025
 02:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org> <20250707-pci-pwrctrl-perst-v1-1-c3c7e513e312@kernel.org>
In-Reply-To: <20250707-pci-pwrctrl-perst-v1-1-c3c7e513e312@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 11:39:40 +0200
X-Gm-Features: Ac12FXzo6YM4ZlaH08l4154uUlIyN8MLpDwn2Iir1feRC033f3iJ5476U0K0Xzg
Message-ID: <CAMRc=Me5992+A0UhR3BA0+oRBepb94k2TWGDiY1Wdwh_9cC-eA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] PCI/pwrctrl: Move pci_pwrctrl_init() before
 turning ON the supplies
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 8:18=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> To allow pwrctrl core to parse the generic resources such as PERST# GPIO
> before turning on the supplies.
>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

