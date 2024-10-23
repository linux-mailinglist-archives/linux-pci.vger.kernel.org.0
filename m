Return-Path: <linux-pci+bounces-15116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7685F9AC803
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED990B23367
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51FF15EFA0;
	Wed, 23 Oct 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0bLxgUG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FF156F3F
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679443; cv=none; b=ChIytfDHy9NCCJCD6S43dk67hRfAxx3nXnqEpXdhu0Aeb8/dZT1njfVhOZAN0duPCuN7bce1WjFI6HKrd5V54/+Ulpb43KAzCY1oKAzeyenX2t2fbE7kmG/7AL3/q7j7mVL71tM5PckzFfSShVpd9HfSjSWgh1gJgP/TZFpFmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679443; c=relaxed/simple;
	bh=R6g5/T333p7bL09fgwrAKHE6ys9mRtrOaG0WuCbPMRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3HFxLWtHuOoyEKr0A8/db+OiJi8X4xoUGT1THeST/cK3hkPaudFj3ZPwpzw/sysm96s8tVrLLus1jhwLE+KHbZZJLOdU95KjcQ+EHzj29X4DDIfk59NLPrk6wNoEYXif38Hnv8ZmM1n1yBXcC0ovl+GnRN/mlqtfSt8sGOecVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0bLxgUG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e305c2987bso63020107b3.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729679441; x=1730284241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fe1yjQgKJ3ayziVzgIhHJB/NYEugDt6h8bA0vccQE6Q=;
        b=P0bLxgUGIkrN+EmObavwfgzXawpavcOvtlIqTHkkGe79uocnNJA+4ISNfMqvzYPThW
         9HKqkNEcClncCKrjIYxeIOz+Krgp5blDDuAbK/iVDI1Sm10QExQ86rJx+jmfIiEr1m8x
         2Mm21k/YzH8fZO2uIkle0y8Ha94aZn82/Q0yM+VO1lhv1oii3X1sC45PIVmfuf5/ZBAW
         tpxX4s3SqtqILfrm+jFI+TH6yP/BLb5W5V2TlCCrNsZLVNHDd7xCdIghvFSj/DObnPUU
         DC+XWIp0KJCtVxFe2lLfLV12c02AFNFBSHwJ0Gwydrfaf46nB68outXyJjmV093JTwfs
         bLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679441; x=1730284241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe1yjQgKJ3ayziVzgIhHJB/NYEugDt6h8bA0vccQE6Q=;
        b=OpLxBhZxQN6vxUwaDl26dCMd5yxwe3AkklZhC+aIpaEqjq5U5fLMJz5TTbDnLX/YIZ
         ypKBvs6tLtoXu5tToUnRW/Ur2P8+vT48FvEqrhN2AvWIqWUmXrrwDsmSOguEc8lWDUyb
         EBJmVptvOdenMaMWG4S7hAuangcho3/GWRU+lS8wIF1QDOuKZGZV+MGhDXpKU/+tXXYR
         FfC+AE8nYNqPQPR7J3HHeQvjGRCA5s4EkniUJB9bYHlxF+xqdH57UjfvgJ3EdKMHnQSC
         Wb6YipVJA+BbOpH2Kbgo8ASaxlc/BFCEAZiA6YUQFuXTArRG+VYEOeyGcXRNTrw9FQ+r
         W/sg==
X-Forwarded-Encrypted: i=1; AJvYcCUPbSJJV+TewevAOBqdXJAl/X19loDDzSKWt5F3iR61ZHU+Jf1rpnp0tXVVnODFbevjn4Ss6B46NxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnj5Ljev/e8mohDHaYw6O5ujHkb/4qy9nThYzco8FmWWLTIn7
	9l/6ufHUk0/tVyOyVFecLw2HqI6dFnGV2+KYP96Hnn8FFXE6P40OqTTTc5St6FH+OY6gbiEVfUq
	lHSrNyPgMRqkF/H453uUpmXI7ekDLDUQgcK/7s5IOGeLINGfRles=
X-Google-Smtp-Source: AGHT+IG1MdstemASpIV41utWb+Ie0/963OIcwmqLoWX6VsLbWq+ezDQWnypptlgoS0AAEAV5lWswidzGLnskvX3v+PQ=
X-Received: by 2002:a05:690c:38b:b0:6e3:178d:1873 with SMTP id
 00721157ae682-6e7f0fa6d6fmr21170907b3.33.1729679441094; Wed, 23 Oct 2024
 03:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 12:30:30 +0200
Message-ID: <CACMJSeuhEQVaXhB8hotG_cimQ4rqQVyzF1DyPwtV4m1T5D=o+g@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI/pwrctl: Ensure that the pwrctl drivers are probed
 before PCI client drivers
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> Hi,
>
> This series reworks the PCI/pwrctl integration to ensure that the pwrctl drivers
> are always probed before the PCI client drivers. This series addresses a race
> condition when both pwrctl and pwrctl/pwrseq drivers probe parallely (even when
> the later one probes last). One such issue was reported for the Qcom X13s
> platform with WLAN module and fixed with 'commit a9aaf1ff88a8 ("power:
> sequencing: request the WLAN enable GPIO as-is")'.
>
> Though the issue was fixed with a hack in the pwrseq driver, it was clear that
> the issue is applicable to all pwrctl drivers. Hence, this series tries to
> address the issue in the PCI/pwrctl integration.
>
> - Mani
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (5):
>       PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
>       PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
>       PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers
>       PCI/pwrctl: Move pwrctl device creation to its own helper function
>       PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent
>
>  drivers/pci/bus.c         | 64 +++++++++++++++++++++++++++++++++++++++++------
>  drivers/pci/of.c          | 27 ++++++++++++++++++++
>  drivers/pci/pci.h         |  5 ++++
>  drivers/pci/pwrctl/core.c | 10 --------
>  drivers/pci/remove.c      | 17 ++++++-------
>  5 files changed, 96 insertions(+), 27 deletions(-)
> ---
> base-commit: 48dc7986beb60522eb217c0016f999cc7afaf0b7
> change-id: 20241022-pci-pwrctl-rework-a1b024158555
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>

Excellent work, thanks for doing this.

Tested on: sc8280xp-crd, RB5 and sm8450-hdk.

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Just a couple nits from my side under respective patches.

Bart

