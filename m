Return-Path: <linux-pci+bounces-21037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B8A2DACC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2025 05:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5719F1654F6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Feb 2025 04:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2951F95E;
	Sun,  9 Feb 2025 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+Vb2RNA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF710F4;
	Sun,  9 Feb 2025 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739074997; cv=none; b=Jk6qlEq7oeayxT+zDDwSuw3oTVXU/PIgnAPLbY+ZQ1tHUg2a/U9LyqWLcMlXKna1TEgByN/IibcOsTnC6vmW9CqxL+RMsdZ1Y/mtsHtR9GvEyFOjIa5m0k6kZ0VvrmxXqYgvZFs55DpvQ2YOk2C30JaWS5sijiupM7G4exyl0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739074997; c=relaxed/simple;
	bh=l8JrRtV4sGe1LU2gUZ6Wgzv0c5YkeUzwzp/wHB+OWNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEIgAl6XMueIcckhU/2ns2DrlCFlgchGcXzpUYrlvitLIfRHOT0GhpNFCfJApe9G4jXB5wjvtqUrYtL1sFayFt6B/5digHmPPRjsCuOJseJlv3HmHol/fZuNEjstR5SP+CR1Y/iOns91VFbng20VXCGb/hmKj2oFiQDw05ej0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+Vb2RNA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so2202107a12.2;
        Sat, 08 Feb 2025 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739074994; x=1739679794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8JrRtV4sGe1LU2gUZ6Wgzv0c5YkeUzwzp/wHB+OWNg=;
        b=F+Vb2RNA9xuGw/RerXZyX1xoFwV7pm/AGhKdMtHYQH9oQV6gPUM0kTcHmQUuB9keTu
         CFX5+l4jJw9d2wuW10a6uM2trgX+Ir15lzzHLMO5brbJaJxXIfNYe4N00MsbOz+uwTV/
         jSKIeAk6pnnGXAA261oagTIpalnperOq73M5nnsUncORm5P0C2G5nI6Q8eepDkFv8hjY
         p/+3RSyFp7HDnD+zNwKcRm/OWP4GdnGPHf8PnKsjJjy+H1faDWis9uOxROoHyyfr7/XE
         Dd1s9raaa47baLgoSxTsB6JA2dsG7B706BozR039HklfyFqWItYwAk02+TyzFU3mID6Z
         rmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739074994; x=1739679794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8JrRtV4sGe1LU2gUZ6Wgzv0c5YkeUzwzp/wHB+OWNg=;
        b=DPraQwd8igLW76n2ERX1O/n5V9FVmz27j5CUfaFYIYmF90sl6WvDBoYUf/kgCI9/yM
         O5laFY3cdRGMHT7w1TinR9WV4tptVq0/jLcU/CU1S7wsqIlTlv7udoollWFXwQZoqY8j
         NtrGhi0y7ygxB+jSI7SG8YiVj1qdZ3pVbKj6o5HB/7JLiekOhJNtlRRBEa2ln/i2siJL
         bpdR6wWYRlLM9BE+a3VshF+OeaJ5pyfskL4Xnxa113BVZKy6KZMN/LWQFUA4vnBlih5m
         ACJzwjJQoZm9H0r9RlnSVdxfGLtRkiKa7MYhrNix5VRmyDQaZNCC0B0628BcFq4xnhKM
         z7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVlYAnfSNGIlbAoPI+asaful2kCCm1SG2Zw4XVbR01R7EL16a+zNjRHo3abHqeO5QDA13RcDDjFeSGh8Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1sFcwUJfe4M2zqrEE651xCchuuB3s5l8FJa994hwhhWQfWjxX
	div6ZP63gKtQgWNya8IdYnNL+pObOuOf+LkLfH+7z37xI18bRUExJS4eapATPPIbiKWkkCO5W2a
	iXES4pbDaAbV5slFLGiA7f5CYcRs=
X-Gm-Gg: ASbGnctwvT+SuOJ8hLV7xHjyuZlnZcJ5RE7EUC7fb+67+XUffp5FZ0pKQP1v/jtA9Uv
	tXD2Y2+Z9lGyqgVWtH66oUfTNIBBP9pLl39W2o6/I4V+t/1jzowPdv4Waoxmdv99FdQIiNJEs
X-Google-Smtp-Source: AGHT+IFXuIswiYNGIV/3nYG3sDkmW61kwCzxNPQ3uP1m5326Boih2OLgeupM/VJxWHHtnPS7tFhXarniWjHDkIOH9Ew=
X-Received: by 2002:a05:6402:2483:b0:5de:3c29:e835 with SMTP id
 4fb4d7f45d1cf-5de45099149mr10110034a12.29.1739074992774; Sat, 08 Feb 2025
 20:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208140110.2389-1-linux.amoon@gmail.com> <4195480d-f2f3-41ad-a035-c81e8f2ab0f4@web.de>
In-Reply-To: <4195480d-f2f3-41ad-a035-c81e8f2ab0f4@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 9 Feb 2025 09:52:55 +0530
X-Gm-Features: AWEUYZkhBrvbm9lo1XXoxwnYAgAcNrgCCCUmFDmDePtM8tlF2AIf1Jn5lrbGzlg
Message-ID: <CANAwSgTb6LfKJA8EkuX6iFh3zxmUkOoO1-yUBP7rsqfsx43X2g@mail.gmail.com>
Subject: Re: [PATCH] PCI: starfive: Fix kmemleak in StarFive PCIe driver's IRQ handling
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Minda Chen <minda.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Sat, 8 Feb 2025 at 22:03, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> =E2=80=A6
> > This patch addresses a kmemleak reported during StarFive PCIe driver
> =E2=80=A6
> > This patch introduces an event IRQ handler and the necessary
> > infrastructure to manage these IRQs, preventing the memory leak.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.13#n94
>
Thanks I will update the commit message, one I get more feedback on
this code changes.
> Regards,
> Markus

Thanks
-Anand

