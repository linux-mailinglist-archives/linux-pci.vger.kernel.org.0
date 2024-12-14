Return-Path: <linux-pci+bounces-18439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762789F1D07
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F7816943E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD113AA2A;
	Sat, 14 Dec 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW913tGc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998381720
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734157832; cv=none; b=dX//EiOPl2gxqHWq+PM/PaEkbAe7YcXGiMF4HLoFUBTwRhg6rhtr77f65aXNOh6eh+wx0gDMAolUCifwvu40Hf9MrEhFQUWignrGqNLXslPAmwrZN0EK2Yj/Z02jAb1z6HLSfVAUPIkHve99+1FUt6s6txCOfadgWK+YplOAZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734157832; c=relaxed/simple;
	bh=KuGfBG3h1XO2QKIY6ZxLEUXPJlDUunNSyY3Zc7k6rLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naNd5zfO40KkxJ1nqkRMTdf2+TQB/8qJMHlxuvcWBvrE8M8NN4C96sWDs5AKm6SwvVERjyb52LWOXrg7+XnbabwXtTRnaOGAuUORTLEu16/X716aTikgGkw217tAIpM3tsOPGLlMcCT0DmytxlN11pLXvf578XcLfkqds0WS8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XW913tGc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2074452b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 22:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734157830; x=1734762630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZlgMCaOaC31D3cOsxfoNKxD9p5p+eSeVRC9kaoau9Mk=;
        b=XW913tGc8NNfyb+K3DO8vGKbn0GGgNLJTf2k1TT7utf2shVH4wEtt6lZqS2Oho643k
         j662XNoKINhxvMRZBGHuUSv3fuEmhgy82YGimb2RUqJzKEFxjOk2BtTGA3+fJ0LVjTME
         KFQwPn9tiqvLcGDBha+C24Kd4PeF5meOeg1wvAFSRJaV0uj/fUUgNjeZYvwvZk+8SIRa
         md0E2cweJ8cnsgKTmpEwa8vNPWLKfQs5Y+DzKCIPZwKTWRBT0QsdA6S6jnA3+Lak9HGm
         hIHtQkM3WOJXFoUgaqwvTPCgQbC3Yo8dC9mKNAfLOg5ZLIAZGl88pc7CKeByd4goSCWN
         IKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734157830; x=1734762630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlgMCaOaC31D3cOsxfoNKxD9p5p+eSeVRC9kaoau9Mk=;
        b=eTdH17YfG+CIeDkAc3P6esAG8n5LZMR9nf83sBD44gEx7SrE1Jlp6xn8q22MSHW2+J
         n8jeOSpJZdIH/2Z7JARb9pLveIGinRqLw5Gwxnn3Pjbw/nelwuVL926U1ehq9DdheqSn
         6Qx+bjsH0jl2phLpnBp8FvHfLOjJ4j299XpZDJxEtXcgvYkEM4nUVueNlsFpiZ92gKdY
         sn5TBSNyXht3Tg2T/x+Qi0XstUBzL6WQcObOEuB6IjpbeSaujVBsULHvFaR/yM9DvZTH
         U2QuPGXPJAiZ4HERg8pVynE/tZGLH+oyS8OE8NVZBBD/yBRNp+kk9m1HKMMcCwxUn29o
         q2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXq0XLf92RyP8SZhKTBwemf5BbyYz6Q9544zEQeaslDSzLZSRwsNazn5aVsYLpDnDDqFRl+wKNXEis=@vger.kernel.org
X-Gm-Message-State: AOJu0YypD3WsriAS39+wcPMP9iJx4ZS8zVUVLHbOufWtYGcjSf4fs62j
	Hpzo0W0c+0qrN8gPl7jbxWC4lDijQLlD/SKu4sD+rukWXRecx6D1dKzHP/WMOm5yUuKc4VzD5Vk
	=
X-Gm-Gg: ASbGnctIeXqAIQvcrSsq73sTd9UOZf80f+NXcX2idss40HEkoxoiMKw9LXyvIG+YCwc
	YmgmIu0CDaiisxf5H3m+kZzwAm2JAxhYU6SXefd+nq3MR8VbHOqjEbZ0VxlawFukK4olPy86M5J
	E1z46Be9sQjw3FHlm9QOEaqgdQiPefIILw2HYIr7YuvxlJwVSIUDO6rxeWQsBWqCcVdOQSSD8iw
	fkMAdUKNdQWbWK8gdJCrhVgxnTVWDeIFmQNjvsSW/lMIgRrCRm4CqELi0OpEEcMLOiD
X-Google-Smtp-Source: AGHT+IF1qZdiCv20zyVSp63JMQBIBSxSIe0ltCHbfrxCz8Ri2Bw6xNnbLmKF0vNlQnSnOzeS4RTRJQ==
X-Received: by 2002:a05:6a00:2e89:b0:724:d758:f35 with SMTP id d2e1a72fcca58-7290c0def31mr7842131b3a.2.1734157830253;
        Fri, 13 Dec 2024 22:30:30 -0800 (PST)
Received: from thinkpad ([120.56.200.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bcdf56sm805168b3a.182.2024.12.13.22.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 22:30:29 -0800 (PST)
Date: Sat, 14 Dec 2024 12:00:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>

On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 12, 2024 at 4:14 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > Right. This seems to somewhat work for ACPI types of systems, because
> > > ACPI is controlling the low power state for all the devices. Based on
> > > the requested system wide low power state, ACPI can then decide to
> > > call pm_set_suspend_via_firmware() or not.
> > >
> > > Still there is a problem with this for ACPI too.
> > >
> > > How does ACPI know whether it's actually a good idea to keep the NVMe
> > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > > only for S2R and S2disk!?)? Especially when my laptop only supports
> > > s2idle and that's what I will use when I close the lid. In this way,
> > > the NMVe storage will certainly contribute to draining the battery,
> > > especially when I won't be using my laptop for a couple of days.
> > >
> > > In my opinion, we need a better approach that is both flexible and
> > > that dynamically adjusts based upon the use case.
> >
> > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > but I don't really know enough about the PM core to drive it
> > (as the reply from Rafael to my mail makes pretty clear :))
> 
> I'm here to help.
> 
> Let me know what exactly you want to achieve and we'll see how to make it work.

I'll try to summarize the requirement here since I started this thread:

Problem statement
=================

We need a PM core API that tells the device drivers when it is safe to powerdown
the devices. The usecase here is with PCIe based NVMe devices but the problem is
applicable to other devices as well.

Drivers are relying on couple of options now:

1. If pm_suspend_via_firmware() returns true, then drivers will shutdown the
device assuming that the firmware is going to handle the suspend. But this API
is currently used only by ACPI. Even there, ACPI relies on S2R being supported
by the platform and it sets pm_set_suspend_via_firmware() only when the suspend
is S2R. But if the platform doesn't support S2R (current case of most of the
Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe won't be
powered down draining the battery.

If the platform is using DT, then there is no entity setting
pm_set_suspend_via_firmware(). So NVMe will be kept in low power state all the
time (still draining the battery). There were attempts to set this flag from
PSCI [1], but there were objections on setting this flag when PSCI_SUSPEND is
not supported by the platform (again, the case with Qcom SoCs). Even if this
approach succeeds, then there are concerns that if the platform is used in an
OS like Android where the S2Idle cycle is far more high, NVMe will wear out
very quickly. So this is where the forthcoming API need to "dynamically adjusts
based upon the use case" as quoted by Ulf in his previous reply. One way to
achieve would be by giving the flexibility to the userspace to choose the
suspend state (if platform has options to select). UFS does something similar
with 'spm_lvl' [2] sysfs attribute that I believe Android userspace itself makes
use of.

2. Making use of pm_suspend_target_state to differentiate between suspend states
and powering down the devices only during PM_SUSPEND_MEM (S2R). But this also
suffers from the same issue as mentioned above (when platform doesn't support
S2R).

TLDR: We need a PM core API that that sets a sane default suspend state for the
platform and also allows dynamically changing/overriding the state (by taking
inputs from userspace etc...). This API should also forbid override, if the
platform has limitations (like if it requires powering down the devices all the
time (x13s laptops)). Finally, this API would be used by the device drivers to
decide when to safely power down the devices during suspend.

@Ulf/others: Please chime in if you don't agree with anything I said above.

- Mani

[1] https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-driver-ufs#n1041

-- 
மணிவண்ணன் சதாசிவம்

