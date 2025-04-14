Return-Path: <linux-pci+bounces-25817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C45A87E43
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3617C1896F9F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041027E1CB;
	Mon, 14 Apr 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQijKSKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F527D777
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628264; cv=none; b=RndobRAvXmYWZRtYMcoquRhv38eIsAATxqgUrGQ2gwawXm0gps7uG87eTBvonESYU9XQy+o08XBSi0oa/otMj3+pZBZDhLSvwTZjlw6N4BJw7pIEYsDa8x3D8CnwTPD24kliPWnTW6IGVxhDRWel2m+/v6JnL4tZQXlKp1w5cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628264; c=relaxed/simple;
	bh=BoqcpGLsoABX4vg4/Ivt2I+MXhyCCQay6STb45Ufw+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvTEE9jIEX9oj+qk1cRo0yFgA+c+spZZbHiTIP5cplSPEvyEVzxTewgOX6T3uE81BekKyXm2j0YOVfqYOkrGUvHEictPEXzsGcIP4b4KghI7LCVLbb5GJJbAoA4zwfohlHFvqs5rsIk/nXW3DHuME4QrU2WlITWZmg2koGTlvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQijKSKs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so4367232a91.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744628261; x=1745233061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gYGD0102TT7Kuba2ulJFmxLeAypj29hAhExmb/Q6KY=;
        b=FQijKSKsdiXb/vmlvTQZ8leJiD3YZzoyTm7oxONr1ArZcTbmsSvTt8J3M/PlmRumVO
         8oLjfGDVzTZA7RYgAQz27NGJrCHFrvLOGq078pFhXIqDhHoLKQm0t7taU5+HS0Pz8L65
         Ht4pNWLlhThSQNflvXuJKqzUMtTg6YanuUboJVGVJhD4bRC0/9+mliSBjBjuMZFtXNFc
         /qUWT28oq/NPxNML1/zMvqdzwuJVDxgYxyF3HGcWEzlCfd0flkFOlSN+u30pBowtrfm+
         BSA0pma4kwCpMrdMIyAIIBjcnKBNcKTP4FojazO5f3z+/LoSusM70Nk/xCEQOhVjjZeo
         i6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628261; x=1745233061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gYGD0102TT7Kuba2ulJFmxLeAypj29hAhExmb/Q6KY=;
        b=ubQfozHTAphOz/EZMJzYVR6sDdoH9tIkI6dWst/jo8n/Wm+1UOjwDraZTtHh7vk37V
         mrLpO+8dpUmcASrWnK1XzLL73EP8QKy/ytPihzo/aYDnChlrQaTtGYO7n7XR9gTdkSWp
         FDpsZyoIaDP78m8ltr4riOvyy1ik7dGgQnHJ9GHZDHQ+NKcDProI4DYCWoNpe095/3lj
         oBMmHrfUCsrwPRMw3EaJxUKgjg1LV+zWvHMnfQaiN06J6cyOnQU0P5IbpUwBaUCu1g/V
         z6TwfYIsQcyF5m+JJIg/md9RaddFQi3lvzTp9VtfjlerCudiEmT/dfG0xIqJu27TssC1
         S7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgnEhSuNNZjSdjAKYijmj96HgmMgnjl59N0rF21WcjpZ25jlQpX1uODBPO1Qi8FTYa3GGp8MCZADQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+MBb9LfkDggdWgGAxIXY6Yqg3Zmjyg71evorgdEUQBiG3BA4
	tMK29q17WYpdhdt40wrx/xMIFLlbBBH4G1ngbEcr3riEFiPKxG4g4p4RBlqwpg==
X-Gm-Gg: ASbGncuw3FJj0+Qm3wPtSbs3yLgPUa6G9o9bwJoWtvvCxwhD9N8Yb2rN/T8IAIqGcjd
	bydX0v4cHkOv2wK7WB/Ov0yaUjwHrQXVzfcnyt+ojxlhHXnwAKb7exZh328Cr3RoaIfw53YfliB
	nspA28tbL0T8WW711YMS2wqcxOTM9mYW7cBtbfSdvPCJJXZsCWBykhMyUZOPK3LbMBYIfWZoLpD
	TBtDuq6yW1Xb8ajLHEQkLRxxpXuQAvEMqH0bGL986/zk5f2GUSkJ+fgacJlezKDROGCIcIGOiYa
	9aNJNLUBXKtV0Wc+DNQCdh2QIxTGRTe6MN4kx/p30fOwK8xwSr5h
X-Google-Smtp-Source: AGHT+IFrTaFVyOPiYJivy5MghxyEC8vM+3s641uXVU9gQnpG1AwmzV3RmWIzhztYD7luXmb/H7jf+w==
X-Received: by 2002:a17:90b:5206:b0:305:2d27:7ca7 with SMTP id 98e67ed59e1d1-308236523femr20387289a91.16.1744628261382;
        Mon, 14 Apr 2025 03:57:41 -0700 (PDT)
Received: from thinkpad ([120.56.202.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10c3cdsm10893869a91.2.2025.04.14.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 03:57:41 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:27:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	Tsai Sung-Fu <danielsftsai@google.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <vfjh3xzfhwoppcaxlov5bcmkfngyf6no4zyrgexlcxpfajsw2t@o5nbfcep3auz>
References: <Z_WAKDjIeOjlghVs@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_WAKDjIeOjlghVs@google.com>

On Tue, Apr 08, 2025 at 12:59:36PM -0700, Brian Norris wrote:
> TL;DR: PCIe link-up may depend on pwrctrl; however, link-startup is
> often run before pwrctrl gets involved. I'm exploring options to resolve
> this.
> 
> Hi all,
> 
> I'm currently looking at reworking how some (currently out-of-tree, but I'm
> hoping to change that) pcie-designware based drivers integrate power sequencing
> for their endpoint devices, as well as the corresponding start_link()
> functionality.
> 
> For power sequencing, drivers/pci/pwrctrl/ looks like a very good start at what
> we need, since we have various device-specific regulators, GPIOs, and
> sequencing requirements, which we'd prefer not to encode directly in the
> controller driver.
> 

The naming is a bit confusing, but power sequencing and power control are two
different yet related drivers. Power sequencing drivers
(drivers/power/sequencing) are targeted towards devices having complex resource
topology and often accessed by more than one drivers. Like the WiFI + BT combo
PCIe cards. On the other hand, power control (drivers/pci/pwrctrl) drivers are
used to control power to the PCIe slots/cards having simple resource topology.

> For link startup, pcie-designware-host.c currently
> (a) starts the link via platform-specific means (dw_pcie::ops::start_link()) and
> (b) waits for the link training to complete.
> 
> However, (b) will fail if the other end of the link is not powered up --
> e.g., if the appropriate pwrctrl driver has not yet loaded, or its
> device hasn't finished probing. Today, this can mean the designware
> driver will either fail to probe,

This is not correct. DWC driver will start LTSSM and wait for the link to be up
if the platform has no way of detecting link up. But it will not fail if the
link doesn't come up. It will just continue hoping for the link to come up
later. LTSSM would be in Detect.Quiet/Active state till a link partner is found:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n558

> or at least waste time for a condition
> that we can't achieve (link up), depending on the HW/driver
> implementation.
> 

Unfortunately we cannot avoid this waiting time as we don't know if a device is
attached to the bus or not. The 1s wait time predates my involvement with DWC
drivers.

> I'm wondering how any designware-based platforms (on which I believe pwrctrl
> was developed) actually support this, and how I should look to integrate
> additional platforms/drivers. From what I can tell, the only way things would
> work today would either be if:
> (1) a given platform uses the dw_pcie_rp::use_linkup_irq==true functionality,
>     which means pcie-designware-host will only start the link, but not wait for
>     training to succeed. (And presumably the controller will receive its
>     link-up IRQ after power sequencing is done, at which point both pwrctrl and
>     the IRQ may rescan the PCI bus.) Or:
> (2) pci/pwrctrl sequencing only brings up some non-critical power rails for the
>     device in question, so link-up can actually succeed even without
>     pwrctrl.
> 

Again, failing to detect link up will not fail the probe. I don't know how you
derived this conclusion. Even the PCIe spec itself is clear that the link should
stay in Detect.Quiet until it has found the link partner. So failing the probe
means we are introducing a dependency on the devices which would be bizarre.
Imagine how a controller will end up supporting hotplug.

> My guess is that (1) is the case, and specifically that the relevant folks are
> using the pcie-qcom.c, with its "global" IRQ used for link-up events.
> 

We only recently added support for 'Link Up' event through 'global_irq' in the
controller driver. And this was done to avoid waiting for link up during probe
(which is what you/your colleagues also want to avoid I believe). But the
problem in your case is that you are completely skipping the LTSSM and relying
on custom userspace tooling to bring up the device and start LTSSM once done.

> So how should I replicate this on other designware-based platforms? I suppose
> if the platform in question has a link-up IRQ, I can imitate (1). But what if
> it doesn't? (Today, we don't validate and utilize a link-up IRQ, although it's
> possible there is one available. Additionally, we use various retry mechanisms
> today, which don't trivially fit into this framework, as we won't know when
> precisely to retry, if power sequencing is controlled entirely by some other
> entity.)
> 
> Would it make sense to introduce some sort of pwrctrl -> start_link()
> dependency? For example, I see similar work done in this series [1], for
> slightly different reasons. In short, that series adds new
> pci_ops::{start,stop}_link() callbacks, and teaches a single pwrctrl driver to
> stop and restart the bridge link before/after powering things up.
> 

This switch has a crazy requirement for configuring it through I2C. The I2C
configuration has to be done before starting LTSSM. So we disable LTSSM first
since it was enabled way before, then do I2C config and then start LTSSM again.

> I also see that Manivannan has a proposal out [2] to add semi-generic
> link-down + retraining support to core code. It treads somewhat similar
> ground, and I could even imagine that its pci_ops::retrain_link()
> callback could even be reimplemented in terms of the aforementioned
> pci_ops::{start,stop}_link(), or possibly vice versa.
> 

Retrain work is mostly to bring up a broken link, which is completely different
from what you are trying to achieve.

> Any thoughts here? Sorry for a lot of text and no patch, but I didn't just want
> to start off by throwing a 3rd set of patches on top of the existing ones that
> tread similar ground[1][2].
> 

No problem. If you want to use pwrctrl in your platform and get rid of the
custom userspace tooling, I'm all in for it. But for that, I need to understand
your controller design first. All I heard so far is, "we want to skip LTSSM and
let our tool take care of it".

- Mani

-- 
மணிவண்ணன் சதாசிவம்

