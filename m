Return-Path: <linux-pci+bounces-11297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1E947BBF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D2B1C21B79
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2B158DCC;
	Mon,  5 Aug 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt4iGDP1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57855155C8D
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864290; cv=none; b=Z1v4bd7BrdMan8QOKhKXwrCfMSDkqtgcsZiuafwdMaxPUSCLlA+zVpMi9bcxmx3S1FQAg0r0rJGs6brVYqi2WeBeDGzYVrmmopu3CqgAZm7Bfx0ZrcnELTnpgiF8rJLETg2fpQ2ZsfvMe1iEft5lvrBcYaNsEy8Ha2Sxke/Pfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864290; c=relaxed/simple;
	bh=TZATUwU6iDMhtqysoYgKMFJfhQgZNs4raEb2aAFBWXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9wZSpxkBDNRudAf/xTT2Tt9aMI12WC/QD+yfcxnv90DaLc/2+aA3Le24IW2jqtlW8ZvxEg2/z+64OqZrx25WyXFjR5hvmtiybCeU3rLrtkf6a2wxOQTbYiFCtSGT0cyDvhzXoFXU9T9YzF51MCdeXZ2u0RLFIuRB4hDSQQc7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rt4iGDP1; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260e12aac26so6856132fac.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722864288; x=1723469088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgWBpeW+c8UsIAW6t5xDuJojZNlu5tiBF3elgCc/hzE=;
        b=rt4iGDP1sN/tjOQqqmwYRKT3FKNJF4TraTg+x223FyLajHZOmIVcprwJ/vMMb2Bv5n
         w92ZA4D9oCSOdDrB4sMaCGn2DCXP/XUJ7FbrMIypgKTBGvjD2Xe9eki41UqKFl7b+ydF
         5f3oITm7+A1WwSFXd0UWJLWT0MpDH1H82aM/J3raut6uyE+9QRnY9Vm6ONo7BNY5JAgW
         6ucZpmtjM11fHmGNzuFO57mdgehBYntbs7TlEAg9wz7KZgtGCSauPvHbARIylfp7O2WM
         I1rrCNYQ7B4DZaiWXjmLYBJ2oUVHW8uwyLviybsW5xZMUKIOgj6lRSJsb9ShrZUomOq/
         sUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722864288; x=1723469088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgWBpeW+c8UsIAW6t5xDuJojZNlu5tiBF3elgCc/hzE=;
        b=rFdWqS9Ebo8szcVgdeOBiPv+F3llDyL+C0N3i3bExH4N3cLzuUkTELvPAhKsZNLiNi
         FMn1hkPr9tbZU6hq95SppKOIotYVXh0JChM1ksLoYg9YYjR7LnugtQrUZF+wfrKCmlpY
         2Bssvi8W2zP1qk/AhXyCy/illsGkASCUL0G6GIq94TAyVBB3oClN78mKFZjwK60cKVvd
         9Z+IRR9gWtr96K8T33J0wm5qnp4234rFuAzIwphZiD2Icxii+gV+UdKfT/F32YgeCl1a
         bT6zBEV9nKGXgiqx7LSSX66RjNYGl7kbN+fbribeqvoavunQvIycPGRnDug3Gq+RPodD
         W/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUufY5bokdwZ4VmslGwgf4Fuq5h/3Fpcqz8JxyG83SvLh0xp7BKDwMj4sgCPr2Iz7QJZlliq0GbHBDBM/0eSQDopMCr1yYRuh9L
X-Gm-Message-State: AOJu0YwMH4HQE2MPXJRS2I62Y2nVqFCtrazkVk93fU2YVwsGm/8trvm0
	k2BwI+fdewtlevh13hLlqnJw7M8xuvJ+W56uQ1XbFmG1n3jwjCCMdOQb7lVioA==
X-Google-Smtp-Source: AGHT+IFT6HKcVwhCHdgf3H5pt/UkTYjavM3s6b+M2jbxZ4twj8oeHQB6x1XNEJm+43Oe93LNk7Ig1A==
X-Received: by 2002:a05:6871:3a25:b0:268:880c:9e0a with SMTP id 586e51a60fabf-26891d40a1emr14029560fac.20.1722864288389;
        Mon, 05 Aug 2024 06:24:48 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763469e79sm5445269a12.26.2024.08.05.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:24:47 -0700 (PDT)
Date: Mon, 5 Aug 2024 18:54:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Message-ID: <20240805132442.GA7274@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>
 <Zqyro5mW-1kpFGQd@wunner.de>
 <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>
 <Zq08i2i_ETHsJiKW@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zq08i2i_ETHsJiKW@wunner.de>

On Fri, Aug 02, 2024 at 10:07:39PM +0200, Lukas Wunner wrote:
> On Fri, Aug 02, 2024 at 01:19:24PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 2, 2024 at 11:49AM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 11:25:00AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > PCI core is already caching the value of pci_bridge_d3_possible() in
> > > > pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going to
> > > > change,
> > 
> > Is that really the case?
> > 
> > Have you seen pci_bridge_d3_update()?
> 
> Okay the value may change at runtime, e.g. due to user space
> manipulating d3cold_allowed in sysfs.
> 

The last part of the commit message is wrong, but pci_bridge_d3_update() is
already updating pci_dev::bridge_d3. And pci_bridge_d3_possible() is not making
use of any checks that could change dynamically IIUC. So what is wrong in using
pci_dev::bridge_d3?

Even more, if the client drivers have changed the state of pci_dev::bridge_d3
during runtime, then pci_bridge_d3_possible() won't catch that. Or is there a
reason to not do so purposefully?

> > > I don't know if there was a reason to call pci_bridge_d3_possible()
> > > (instead of using the cached value) on probe, remove and shutdown.
> > >
> > > The change is probably safe but it would still be good to get some
> > > positive test results with Thunderbolt laptops etc to raise the
> > > confidence.
> > 
> > If I'm not mistaken, the change is not correct.
> 
> You're right.  Because the value may change, different code paths
> may be chosen on probe, remove and shutdown.  Sorry for missing that.
> 

Again, pci_bridge_d3_possible() is not making use of values that could change
dynamically.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

