Return-Path: <linux-pci+bounces-25519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A7A81790
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC81B86E1C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF72550AB;
	Tue,  8 Apr 2025 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dbh1Oa5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61E254875
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147590; cv=none; b=qurCc1n9lNN16nu9R/5L86OL8TOmdZhYf6JTp7/+++BJTux9RxWUmWnahAOgr5QWUeCDRbbnnJSo4F0g/BBGPbKCocY42gYg2QVhw2SZamnpkcmFsMJB9+nriOWeF+a1LXDRlEXr73hHMBzAm+mI1hBI/Oa1GveW1GOHRhb35XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147590; c=relaxed/simple;
	bh=bOYcVCH7jUtLC+s56g/zmnXTCYBbHKKlwNxQVfwM7CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/ZZpn6xwNmT8z8E3/vY5WXJrSuHGneeFzFr1hYHRD6ljtChza/78O4CDGV3m/R8jOEj9jTN65myuICUyXr2r+x4mzzgw2aZ3dEkOPB/opgVY5sAoACXlIdymHiPgRIpBca0stTlV5Qe2dBJaIVlR8l6DF7CLwMAzAErHaK4fYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dbh1Oa5q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af28bc68846so5348361a12.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2025 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744147587; x=1744752387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZXenv5NdRxAPmtDIgNSh4oCYjmXRf9QV8n2/7t4A18=;
        b=Dbh1Oa5qfoim0aPo+7t+97RidFLLZx5YuGgcec7OjWmrmhOUoyTcdsaSqjo2dLaY4u
         08WzspXIUiRbe/eEXfIomy1nR3Y2GDvSg+4wbpuWI+EDtFEJzufrcm8VIJVHzV0RZ8yI
         V4WQZsypqGTa2UeETTW5HBVPvlyFnod1Nvb3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744147587; x=1744752387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZXenv5NdRxAPmtDIgNSh4oCYjmXRf9QV8n2/7t4A18=;
        b=kyqzauKiIW88S0i6QdsV+D5KXDKxmuPQ3UbMHslf26MZpLMPBadSp6TJlHck1Hr+q1
         3KRX5VOqtkr8VVf5ymX1vBLZ5DQU/LQ+mFQMPWCIlQNHNDvxL0hJmJwc4laqZ7YLOODG
         yBAXCQAgRueF2W+Q7ISsmiy5lBveHxjgXolzemdo0Olj6BnkAND0/CPc5jW9ipLB1W66
         R8R5mgHulMAyXrKmwYfh9+LVUWDrgAYtPnsJg9o7b4FuM1/hoKbMsMDh33C6zQts02UB
         jcy7bkooyRbadrdyNpXlN84GG5uxRx6eZFnmTFmqvWadPYMxOG59RYvSGhzNKRMNzLTJ
         8vfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6VxJR7DcJl/tDaE+bWy/uJcl06G0yuZGZYtO/NCmYkGzVHtkPnfn96N+u8Cva4PZtxHln7oRB8V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7NB4TpQk7zCRHUuIv/yP392GCwqWqDNpvkGAqt4VepBeccPj
	eGMprkJ2Ml1actsSJgk3H68LaWiVDUJlIDjeFtiLLHd7+R6cSgt6QbxWwmZKqw==
X-Gm-Gg: ASbGncvYwnScQedmVSY4sueHhy40eMvpvKtbRz4ROe9yX+I5AWHWZrq5VeyNSjK9hfW
	Rs716y3oebI0nvEPxCbsGWYswemkDP7clhWgs08wwgK5u/dVqAM+eS8rFpoyvTAc0qnvI3CCYz1
	4HZfhREdX/C5QsmlCRt6AWF+unq+1KNWrmsMFVQKV+1R8cBLEUv7YDEF0dbVzz6NmMiAbAWESn+
	9WcNSLA2AuT+OJzE/FiqGJoqqKm9nyTbsCj327Zc5Uu8nDxCQlTo93cWSPrNkBRAb2QDcrwGlIZ
	fbywnvkxH1njDZ7vZK68n+ZB9Kmvjt0kE9D7DtCNkbpVabr8KBod67mg3edkBqGL3aalBIe0fdr
	4cO7MjrY=
X-Google-Smtp-Source: AGHT+IGWBL43POLyTKIVtvqCNnHwPO80WghJhRq8bDGo1CpD365Z+Gt9wZXz61k815bEhQ2ufO5cSg==
X-Received: by 2002:a17:90b:2f46:b0:2ff:592d:23bc with SMTP id 98e67ed59e1d1-306dbb66ae3mr1063923a91.4.1744147587486;
        Tue, 08 Apr 2025 14:26:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:f6a0:ca46:b8a5:169e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-305983b9954sm11484930a91.32.2025.04.08.14.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 14:26:26 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:26:24 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	dmitry.baryshkov@linaro.org, Tsai Sung-Fu <danielsftsai@google.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <Z_WUgPMNzFAftLeE@google.com>
References: <Z_WAKDjIeOjlghVs@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_WAKDjIeOjlghVs@google.com>

+ adding pcie-brcmstb.c folks

On Tue, Apr 08, 2025 at 12:59:39PM -0700, Brian Norris wrote:
> TL;DR: PCIe link-up may depend on pwrctrl; however, link-startup is
> often run before pwrctrl gets involved. I'm exploring options to resolve
> this.

Apologies if a quick self-reply is considered nosiy or rude, but I
nearly forgot that I previously was looking at "pwrctrl"-like
functionality and noticed that drivers/pci/controller/pcie-brcmstb.c has
had a portion of the same "pwrctrl" functionality for some time (commit
93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage
regulators")).

Notably, it performs its power sequencing before starting its link, for
(I believe) exactly the same reasons as I mention below. While I'm sure
it could theoretically be nice for them to be able to use
drivers/pci/pwrctrl/, I expect they cannot today, for the same reasons.

Brian

P.S. My original post is here, in case you're interested:
https://lore.kernel.org/linux-pci/Z_WAKDjIeOjlghVs@google.com/
I also leave the rest of the message intact below.

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
> For link startup, pcie-designware-host.c currently
> (a) starts the link via platform-specific means (dw_pcie::ops::start_link()) and
> (b) waits for the link training to complete.
> 
> However, (b) will fail if the other end of the link is not powered up --
> e.g., if the appropriate pwrctrl driver has not yet loaded, or its
> device hasn't finished probing. Today, this can mean the designware
> driver will either fail to probe, or at least waste time for a condition
> that we can't achieve (link up), depending on the HW/driver
> implementation.
> 
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
> My guess is that (1) is the case, and specifically that the relevant folks are
> using the pcie-qcom.c, with its "global" IRQ used for link-up events.
> 
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
> I also see that Manivannan has a proposal out [2] to add semi-generic
> link-down + retraining support to core code. It treads somewhat similar
> ground, and I could even imagine that its pci_ops::retrain_link()
> callback could even be reimplemented in terms of the aforementioned
> pci_ops::{start,stop}_link(), or possibly vice versa.
> 
> Any thoughts here? Sorry for a lot of text and no patch, but I didn't just want
> to start off by throwing a 3rd set of patches on top of the existing ones that
> tread similar ground[1][2].
> 
> Regards,
> Brian
> 
> [1] [PATCH v4 00/10] PCI: Enable Power and configure the TC956x PCIe switch
> https://lore.kernel.org/linux-pci/20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com/
> 
> [PATCH v4 03/10] PCI: Add new start_link() & stop_link function ops
> https://lore.kernel.org/linux-pci/20250225-qps615_v4_1-v4-3-e08633a7bdf8@oss.qualcomm.com/
> 
> [...]
> [
> [PATCH v4 08/10] PCI: pwrctrl: Add power control driver for tc956x
> https://lore.kernel.org/linux-pci/20250225-qps615_v4_1-v4-8-e08633a7bdf8@oss.qualcomm.com/
> 
> [2] [PATCH 0/2] PCI: Add support for handling link down event from host bridge drivers
> https://lore.kernel.org/linux-pci/20250221172309.120009-1-manivannan.sadhasivam@linaro.org/

