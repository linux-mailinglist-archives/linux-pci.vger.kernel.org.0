Return-Path: <linux-pci+bounces-3393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30785327B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A941C229A2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0390756762;
	Tue, 13 Feb 2024 14:02:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA457300;
	Tue, 13 Feb 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832944; cv=none; b=twYYh9elI111WATVr4rZ0MAo2jiw1bj35V7/OBhzeTfAW8e08SStGSGGww1UJqK29K4HiDBxSv1ysq0fRFYwkp0lH3iGZhZnPdA/DAVyTV+s0ebp/624KINjOC5prrsnG8OrXIPoG3X/8eS/RvodC4UBhcrp+6xWHgRMMxETmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832944; c=relaxed/simple;
	bh=x0qXZH3kJEepjTNqW7t+XjZ668V1LMFYMTAebEXWNck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5RrGBDxSuokdT17SKziaD5wRtmEA6scshBpOQA4DbOFPB7M1+TQPYW4Ybm54i5w8dc+bE6LgaYlGVOorUQyMvmXxFbqcxyWmkhQUw21L3Fpmh+jxi28hQZFG1X38h2C7b2dTpIJIPSAjcqksXkB75ujxDz5kr+xIa0fxipxKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5958d3f2d8aso1797631eaf.1;
        Tue, 13 Feb 2024 06:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832942; x=1708437742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQZGa2j+slpWb59zzZSHGyPHGPCdHKBm7wfB42qCupU=;
        b=YM3/MHwIF68deVXJYCINbD05rSO7PzKOS5yhp20NF4ayWcK8SH1ib09bcmwJSeFMyH
         Z99DgcXXP/ztlegfqxE9+gtlNOt0eIxJI74oqAg+fxTOrayvQXd2afga/VmWygybH7kO
         f+6svh8cOukPqf0xt2xroAwvnpyy/9tqA1VYPExrP6HneyLqcCzPy2kJj+zpf+dXmvhi
         20dyEDX5KLuqYXLfBtGzjal14CzCjMNL4MZKGHdKHVxJzTMVzz3IupJUDZeo13rs7vTy
         O9a50OngkNItp22dNR4N/yIXM8j/0Qj0Rn7m+6nqlKj3KEu6Bm/yHWxpapfopneRZrqO
         KGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfaQ0heVqD1cfbrLFnHQ+Sr/j1SNyGWZDfP7fcnY0QRAdA5+jXux8tKOYeC5InpEzqmIjAl9rlhtiWdTa2GYA38bQQlEbWFKImxDIl9iBw6XtJwArEbv4ML9AqjvJxVeyYXSqWRdjnZ9Wwtpn/6HJ6TxlnodfXo6uUeWjYRowNQB4=
X-Gm-Message-State: AOJu0YzIkhc130tBrPsOMoMNYUl4JKq+3drhhSDD6Nfwk5gVrProZOUf
	bTX2UQEj04wkfyNSRyLRZfo2YAOwyTFcRabMQN4tn5OrH6B+7CwOEj84t4cSht393/6iB58YR7O
	xAEClTlGaaKhf8qYkx1Ww1vq+GiU=
X-Google-Smtp-Source: AGHT+IGlCzIUVy90I1wgB1ghdkVAqGB1LLuHU6JD1WH51gYXfkk5KAEJ6wLWnOgJSpUCt8Jo6Yli5+jFZcCNNFGvCo8=
X-Received: by 2002:a05:6820:a8f:b0:59d:6ef2:7b01 with SMTP id
 de15-20020a0568200a8f00b0059d6ef27b01mr3252579oob.1.1707832942323; Tue, 13
 Feb 2024 06:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212063233.5599-1-raag.jadav@intel.com>
In-Reply-To: <20240212063233.5599-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 15:02:11 +0100
Message-ID: <CAJZ5v0huF=T_QH_Vzfmq07x2L_BPdCCdZSKzKOMYY19s37kjOw@mail.gmail.com>
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback functions
To: Raag Jadav <raag.jadav@intel.com>
Cc: bhelgaas@google.com, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	stanislaw.gruszka@linux.intel.com, lukas@wunner.de, rafael@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:32=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> Commit c5eb1190074c ("PCI / PM: Allow runtime PM without callback
> functions") tried to eliminate the need for runtime PM callbacks
> by modifying pci_pm_runtime_suspend() and pci_pm_runtime_resume(),
> but didn't modify pci_pm_runtime_idle() with relevant changes, which
> still returns -ENOSYS if the driver supplies no runtime PM callbacks.
>
> Fix this by modifying pci_pm_runtime_idle() such that it allows PCI
> device power state transitions without runtime PM callbacks.
>
>  0)               |  pm_runtime_work() {
>  0)               |    rpm_idle() {
>  0)               |      rpm_check_suspend_allowed() {
>  0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* =3D 0x7fffff=
ff */
>  0)   4.840 us    |      } /* rpm_check_suspend_allowed =3D 0x0 */
>  0)   1.550 us    |      __rpm_get_callback(); /* =3D 0xffffffffb4bc84f0 =
*/
>  0)   1.800 us    |      pci_pm_runtime_idle(); /* =3D -38 */
>  0) + 17.070 us   |    } /* rpm_idle =3D -38 */
>  0) + 22.450 us   |  } /* pm_runtime_work =3D -38 */
>
> Debugged-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>
> This is not marked for linux-stable for the need of extensive testing
> and can be backported after a few releases if no issues are reported.
>
>  drivers/pci/pci-driver.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51ec9e7e784f..bb7f6775b350 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1382,10 +1382,7 @@ static int pci_pm_runtime_idle(struct device *dev)
>         if (!pci_dev->driver)
>                 return 0;
>
> -       if (!pm)
> -               return -ENOSYS;
> -
> -       if (pm->runtime_idle)
> +       if (pm && pm->runtime_idle)
>                 return pm->runtime_idle(dev);
>
>         return 0;
> --
> 2.35.3
>
>

