Return-Path: <linux-pci+bounces-32792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445CB0F13E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB965461BC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5512DE702;
	Wed, 23 Jul 2025 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtWWXbZR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825E2D94B9
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270387; cv=none; b=B7zIH+fk9leZp7cq9wa/4QyextdqXAWef8+cH51pXFd+txqhXJsfNhsPPmfmauguo6rm94D4j+He7Fi9wImL5lz4WGg//849Dtbmk/byDBx3GLnUR7YkP8+dFcjdgatjVNyf7bHDStJzA4fBZr1rWF7p2mVgPyodTv5tJxVIHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270387; c=relaxed/simple;
	bh=aAjvSl8CP8e8poOdqbC32WczsF+aY5e0wedprJiV2Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qICFzeULlJXl7OzzbXVKIlI+lM2CKdce1oE6GvRwLCMmQIpURfiUfjg2X2tv6Gl6tZ787eKmwsqzjZPcdh6xorE9PUnSWiCQlfLZf+F9Vvpiw4Q0yxeEfQD8sAPzgh7xO2+ph7jarAeUd61c+ROWzFss90rehwJ/OJTJB/OJgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YtWWXbZR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so8424984e87.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753270384; x=1753875184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWJ1vaC9mhdphahBr4AxdkgQcamHOy69P9zg4SNDFJE=;
        b=YtWWXbZRP+8yhBvBXY22DxrsIWNl27hACDq/BJo083tD+gw6mR3Gu96a2Wzyi3qRyW
         cTwiiXYWJVK6wtou9ie7ChC859awFYv4BVVN1DBkumd06ViaqNdPZ90ps7FE6pFviDqf
         9evPVGD/liatxLrR7sDumg8OtiTk/GIbovA/VsUW+kQOx3TJ1R3uh5CXwOzpYVZb98+C
         cEg55gR5NLlrj8Mbd2jY+67JS8V52N/ONlt8ciV790YxzFU1t34zDCq8tewelpfYcV63
         0obiYVynZtY5obbzW8Ua5oTYacoNUUJV0INZ7TmAbxwj5kGEHeJM/KlmCPCpdXXk4t6v
         PTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270384; x=1753875184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWJ1vaC9mhdphahBr4AxdkgQcamHOy69P9zg4SNDFJE=;
        b=ECD7yaM7nnz7ykNKfZ5UkEFxceVWb+EuRC+9/Om72yLOdFk1KCM2VYqpwiDI+W/IND
         dWt+IoGbSNiZrPLL4O7NGKg2lRajxRM0W6vdMnpo9e/5yEguiJB67XLErQg/3TojYzNA
         h3CqcadL5EI8rHCbvN1a+0MQFWuIBtK8pPBrpb47j52gQkwf0J3RQhyJAfJvLsPq25u8
         e5v7D9kXBacCj+xa6q/e184QrnKQlJ/0I6CwqdCcn50B/jQKuylWzBgo4zPYb0fOlKHr
         6h6DSn5ols+Z0qSrMFmI5zep2+Q0Dj3vWEoymEVd1es9dQFATmxC+llqMM4t3p4WzYqw
         4jQA==
X-Forwarded-Encrypted: i=1; AJvYcCWutt3Qt4Z4YmXIaTSfFiBjnDYjwr/k0OLCChf4cmktFBUSLnTfy+6izwUf6DlVChjLe0ifs6jgtq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuqKjnt+m1Iq6jNJcQJjHZuzR3gncnA5m7IS0biM3uCoSAmd3
	ZMZky43BkfsUEmJT5hstJsB9PPY5M0PJepsDsxTt9HzY19A5H3fjQ2a20rA/NFeQtvvsKWLtPSi
	lwz8fHdf/gIsP1F8tb6LIlUEIFLOs3UhbWMM314isFQ==
X-Gm-Gg: ASbGncucJlXBwxmsuXLxcdSXgB6iMGdmwDNqUKvnvCXGDILjTbZgwT38EYhwNqvF2zk
	sbzUvr473dA+ZbT/3iqvNZeyklXK6UPK6sfqzJjzPJn9AU0BPkkhCgflHaeudrewda9cRsYtIHY
	cdlxG1EGGuHCvYEyRHII8dY7mPXSXCI02SrvyekLX7H/9ODIDnFQYhsu8il1t8Ogz6m3tehbkk3
	G7+9+A=
X-Google-Smtp-Source: AGHT+IGAxN/JXh1EsU6InJKjwWnNX99YeFSCDuYAjM788AXYCd+mzZfDQU6t+N5nE5+MTj/X0VenBnfY0SKgi/lR+VM=
X-Received: by 2002:a05:6512:3e1f:b0:55a:826d:fa31 with SMTP id
 2adb3069b0e04-55a826dfcfemr569462e87.37.1753270383732; Wed, 23 Jul 2025
 04:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717063042.2236524-1-christian.bruel@foss.st.com>
In-Reply-To: <20250717063042.2236524-1-christian.bruel@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:32:52 +0200
X-Gm-Features: Ac12FXz0suPsP2VK94jurXo8uzOTltHa9LM0UQkrYO80w5wNLroNiLg4heFForw
Message-ID: <CACRpkdZHw8am05Qcjp7FJyo7D7bZcvzZKVjdB7BUCq3FuQCy8A@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/2] Add pinctrl_pm_select_init_state helper function
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, linux-pci@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:33=E2=80=AFAM Christian Bruel
<christian.bruel@foss.st.com> wrote:

> We have the helper functions pinctrl_pm_select_default_state and
> pinctrl_pm_select_sleep_state.
> This patch adds the missing pinctrl_pm_select_init_state function.
>
> The STM32MP2 needs to set the pinctrl to an initial state during
> pm_resume, just like in probe. To achieve this, the function
> pinctrl_pm_select_init_state is added.
>
> This allows a driver to balance pinctrl_pm_select_sleep_state()
> with pinctrl_pm_select_default_state() and
> pinctrl_pm_select_init_state() in pm_runtime_suspend and pm_runtime_resum=
e.
>
> Christian Bruel (2):
>   pinctrl: Add pinctrl_pm_select_init_state helper function
>   PCI: stm32: use pinctrl_pm_select_init_state() in
>     stm32_pcie_resume_noirq()

If Bjorn Helgaas is OK with it I can apply this to the pinctrl tree.

Otherwise I can also just apply patch 1/2, but that doesn't solve
any problem.

What should I do?

Yours,
Linus Walleij

