Return-Path: <linux-pci+bounces-28513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715DAC6F40
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 19:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E441887FE6
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1D79FE;
	Wed, 28 May 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlRNj5dP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747E1DE881;
	Wed, 28 May 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453171; cv=none; b=RHXf7SwackIO7fQGPe7Te/7RwiXRtgrVAAfZ5Qw7qVilEf2vBU2UngQ/hgCgrkjq7Q7cFVVrDwIiu4hARcWSs+QlDDT3iOEKTfKSt44aGTW/fs2/4LhdQGxxsSo/l8LJXhp0JDy3bNChZq3qKpiCPRRb/2IcoXTUVgGGiLirBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453171; c=relaxed/simple;
	bh=HgsEhS2sAmmOIZVLiGhDdAQFM5SB/+50Njb9ruDD5sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC3JnCPYijdoTQP2V4HDPuELIUFsF+ie/vare/6BAiBhkwXPO9AkXQszRQLnJ1Kw0VCippXytwuyZNFkOIN//CXMsBSV+8v9mceUNpu9twTEdDLxmjm2CJCXSrGGXCj4mE1zmDTzCPZsYE+2YgeFmlUBpDk+sq9Orvzu3bgyKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlRNj5dP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d6f933152so7784776e87.1;
        Wed, 28 May 2025 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748453168; x=1749057968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgsEhS2sAmmOIZVLiGhDdAQFM5SB/+50Njb9ruDD5sA=;
        b=OlRNj5dPmY+eASSfZ1PbcvMlKJZGsjMbu1Z9V8KdMybLC/c+kCU8OmiUOJfW4UrPLT
         jCdiE1FBQcpxXEfb1r9PWHrF6iyZ88+vKCphBoG7G7ybt7DqcEUPBh85QuIW/1pfzid0
         wmQ38sOOA7ddSTlmCczylo5LC7y26CoP3PWc+bjGEk0Of77Z2ddK21Gvy1b42cAwtR6J
         zY2jPeoERrt9xGqrL/AKphi/PCfgyQPH7rTplibBiQgmaHihzruuCwjHpIlS/lDq2HNp
         yWnCtqCrskBd6VmCgrjms49kMrV4WFveoj0r8eUtvcKccBw0kLUi499NDeO9I44h0PXZ
         Yv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453168; x=1749057968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgsEhS2sAmmOIZVLiGhDdAQFM5SB/+50Njb9ruDD5sA=;
        b=TEyoOqc+9XxxpQwEpxb8n532SZsp982qUv/EpC66axjEi4LKgcSDgP3F+SY4pD9m/R
         cNZ/yTXfe5mLW14Eo4Kt8cJPPaVovsK/+SXuMryy65/8IQk0xst8aZHpexyL/zW7gy6c
         gtIqLaQkjxKr+ZilZ7FtAXbgBJB8VZDlKT78Fo9+QMnV5i0Mky/ewXJ70U7MlnwW3EIm
         uWrWwVS3nzi1w6oOR417UAmsu7/2rkxPhF9RKRcfRM76rOIIIAuCaekZ+HxTBTvhjf8F
         889fDgkQdw+hsZ7wFVFbU3ViTGU56OGim6gbN36sNsigCuEWpT0uj9g4N5+4aab3fQDa
         Ewbg==
X-Forwarded-Encrypted: i=1; AJvYcCVNTEXuyueRM4YRMiqCleM9c3/IJV8SjWNih2Ao9N0HZio8CjWRZHWcvE0tgyH8HJLhM01rCvW8Mv8=@vger.kernel.org, AJvYcCVXdYx589uXR+momGiYBMzQFKdVaRsWCoEBm4dvTrXPfg3s/K0e5GRV0FQA0Pfshgy2/J6INfq4peQC5M4=@vger.kernel.org, AJvYcCWEAMkCT6fkk8kNr6m+V/J3Vbnw8pwJZYfiPoclv2gA+jW43vqgzj2lNsR4I2zL8yJEjp+xk0J2sPCZcwI=@vger.kernel.org, AJvYcCXBlgxyY8u6pkcaRn9Ov0lrnUqItNkCr0SpwJDUKzGqpvALpKHMcD4BpH29SudXll7u2BmSTna+y74m@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+Z4l09rWZr+GlDC3EPijAsPlvpBlAUfUn4y1hqmV2w+qMi+0
	5v6zshqqCJ/kbsR5CMuI88HzOR7xieksft8nkmlwvW0SHP4A+uUrNP1A3agGmAU654g5Zd+aTaZ
	nEc72NrgYb9xYsVSFUKerAba71+sFGdI=
X-Gm-Gg: ASbGnct78M2A6tClYPF/aiTkznsss6NbBMR3uKfXZUWu1/M0th4r3OQJ9Xr8TH7FlDW
	WWKE73M7r4OVddKp45Gz63PUCsV31Y3gksZ2IUdPWpRqv/RZMiQZLaOJkNz32nkNCGcBqfe3b4t
	+xru+yZUSiJz5za+1knY2s1/FWDXHtq5fn
X-Google-Smtp-Source: AGHT+IFDyDQi/9wO2SzKKhtMYaaAss1hk+he7j9jtV0kBiJqcwFAaGlSBAYFYPErvYDNN+uLccqGF2iegKs7RZUaWRc=
X-Received: by 2002:a05:6512:a90:b0:550:d534:2b1a with SMTP id
 2adb3069b0e04-5521c7bc046mr6331845e87.31.1748453167469; Wed, 28 May 2025
 10:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
 <20250507-pci-tegra-module-v6-3-5fe363eaa302@gmail.com> <w2ertcizgmtu27kcike3lpw5dvhvqi2b4c6amqzwdfs2xtebfy@itrpen3oblhs>
 <CALHNRZ8899t0BYMgn1a3iDKz_J9z_Wv_XYM2d8Y4AoiXPZaFjA@mail.gmail.com>
In-Reply-To: <CALHNRZ8899t0BYMgn1a3iDKz_J9z_Wv_XYM2d8Y4AoiXPZaFjA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 28 May 2025 12:25:55 -0500
X-Gm-Features: AX0GCFvjYatE1CdKxTKUCkSaQv_HFCfRBq0g_jM2U1KiL6rRWZ40WAWZ1-Bt-YE
Message-ID: <CALHNRZ92JPds7DYPTt3A6EvQMMw=PJ50wuSLz526UWgJNo=5rQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: tegra: Allow building as a module
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 6:26=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com> =
wrote:
>
> On Thu, May 8, 2025 at 3:40=E2=80=AFAM Thierry Reding <thierry.reding@gma=
il.com> wrote:
> >
> > On Wed, May 07, 2025 at 10:25:54PM -0500, Aaron Kling via B4 Relay wrot=
e:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > This changes the module macro back to builtin, which does not define =
an
> > > exit function. This will prevent the module from being unloaded. Ther=
e
> > > are concerns with modules not cleaning up IRQs on unload, thus this
> > > needs specifically disallowed. The remove callback is also dropped as=
 it
> > > is unused.
> >
> > What exactly are these concerns? I haven't done this lately, but I'm
> > pretty sure that unbinding the PCI controller is something that I
> > extensively tested back when this code was introduced. PCI is designed
> > to be hot-pluggable, so there shouldn't be a need to prevent unloading
> > of the controller.
> >
> > Rather than just forcing this to be always there, can we not fix any
> > issues and keep this unloadable?
>
> For the short version, see this part of the conversation on v1 [0].
> For the long version, read comments on all revisions. Basically, I
> originally submitted this as unloadable, but got told that due to
> generic concerns that affect all pci drivers, including ones already
> modules and unloadable, making this one a module would be blocked if
> it was unloadable. Which leads us to this revision of the series.
>
> Sincerely,
> Aaron
>
> [0] https://lore.kernel.org/all/4u4h27w77sdjvy43b3yonidhfjuvljylms3qxqfaq=
wyw3v32qo@kzgrrenxr6yz/

Is there any more comments on this, Manivannan or Thierry? I'd like to
get some form of this series submitted.

Sincerely,
Aaron

