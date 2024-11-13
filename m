Return-Path: <linux-pci+bounces-16696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C39C7DBB
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4038B26B8F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECDE18B494;
	Wed, 13 Nov 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyGmpIxR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9518BC14
	for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533934; cv=none; b=A/Vd/BMZiM3w4X4vVTHKAe74UsRIqkKPvJhP1mYX0jT3QZR8YjZdmtvAyBPOV6IiXEqUyg7fUo2LAlj7mJK2a15vxoDdgc07rAxIcs15fVvCFRLw9mAEEHCyH/HQS3t3baZTQ18kUHUhSMyJ1tiJXVR8DB5IFBKACbzpNIwmjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533934; c=relaxed/simple;
	bh=h3pNFM0oblrUYOB6pkkCwK/sr+vTUFr1C8PiWtlv8rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEibl1XTVTO0mzLLmyI6ldWl6MQ8zMtSqLe/vj9reSjCswcX13gSGsCFo5EF2UT9YeOtUPiVw68dBc1DVwMI8urcbTQ106fToIqDLMeUOO8FXVf1YJjsmkM4ZkQfgEYd6K+d7bDoKFDM1rRRxops4iB5PFJdwUmssJNYRkg//+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tyGmpIxR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c70abba48so73340365ad.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Nov 2024 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731533932; x=1732138732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/SIxTh7J31xbTMjPP69b/bUoDVK1zzpUJ9rscgsMJY=;
        b=tyGmpIxR2G8GWmo1ECXKwrB/S61FrGFI6J+mU082jp1bade0uh/BpZDpthLvYrd+hz
         5p67nLz2PAyngYFFVQHsBVjXDyZ+0KoHoqqCK2D37x8bZ07TzMK6gPL4QLj2R4L0KgC3
         sVOFagi8bvmbao9rvorJIJjCCB1Qz9J2e3JAiHirPwcJxFjSQlMJoEG6qZTiXFKIKLPJ
         K/le1vkzw/1/nCcEzqlMc9hLCuKOscOi9yaLSF7bpBAPQvSP4KLu4o/q7W8cS//OASPT
         i/yydlo/4UMMjKTjNEPkiMJmnVIH/gR4N3dstqf8YP5t+oOwdz4joxnbO631e2pQBDX/
         xy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533932; x=1732138732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/SIxTh7J31xbTMjPP69b/bUoDVK1zzpUJ9rscgsMJY=;
        b=bzYhyWh6NgAwtukyUoXM0tSccguClXzPgr+p/NN+ACUCHSjSK6n70ZVTkqAsAsReQP
         bGx3sRII0U38HXHkZenjjX/798VADr2DqHUevyFgCuBvBc6Kp1ysf/RBl5/4aktEYqbd
         w4rMOBlUqGaBSGHe44ybGsIQe/zoMjkSMe020u578ezpSwrlJQeNkbF/dCJwEguuRxvi
         veBeS00fholfpiuFu+mDwMQfXhLaFKEsf0fkP0qJ4V+Gz1vSv1GCfWN/QFa18bwZ4Evf
         +RDqSz9DQjXeLCK0wVRmtUIKEpMiOFHOPQKBCiNAWGoKmpRim/UoN9b6eEA3yb8x4bf9
         AIXA==
X-Forwarded-Encrypted: i=1; AJvYcCUh3YkjVEs8k1ezk2UxPVja7pjafQMC0tHTfDmMgcbEgvF7e6FyDkydy26E/yJ8N8bGD5qPyGg9grY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAP+jhKVY7pj0I8+RRM7DX2+9vy27C9JWI637qXxquo/KSfbPu
	R0p2TAMfsZJ45MLUIwm0SLbjSTC8zr9ydRQgevFwZtSD9y8kAOV3aMwHcGIZTJfimYTwU18hsIG
	EvgvThX9wJsEsmFkPSV+iv8jucdTzGSK4KYcU
X-Google-Smtp-Source: AGHT+IFSTZo8eDq5AVjULTxkBdn1QAACx9SVOAxHbG2ogMZWy2xpiXhaZKNwmM2oe/A96ZXy7LtkzQ+cUTRsIShcqKg=
X-Received: by 2002:a17:903:2447:b0:20c:895d:b41c with SMTP id
 d9443c01a7336-21183d55336mr284292875ad.41.1731533931844; Wed, 13 Nov 2024
 13:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220426172105.3663170-2-rajatja@google.com> <20241113202214.1421739-1-jperaza@google.com>
In-Reply-To: <20241113202214.1421739-1-jperaza@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 13 Nov 2024 13:38:13 -0800
Message-ID: <CACK8Z6FHBj2eUp9Wrqg_ehY76hUZF7iEa+y7tFP0eT_7rdVT1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, gregkh@linuxfoundation.org, helgaas@kernel.org, 
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org, joro@8bytes.org, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatxjain@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:22=E2=80=AFPM Joshua Peraza <jperaza@google.com>=
 wrote:
>
> This patchset rebases two previously posted patches supporting
> recognition of Microsoft's DmaProperty.
>
> Rajat Jain (2):
>   PCI/ACPI: Support Microsoft's "DmaProperty"
>   PCI: Rename pci_dev->untrusted to pci_dev->untrusted_dma

Thanks for resending. This probably dropped off my radar since I moved
on to other things. But I can confirm a lot of Chromebooks today in
the market already use this property (and this patchset) for
identifying untrusted DMA capable devices.

Thanks & Best Regards,

Rajat

>
>  drivers/acpi/property.c     |  3 +++
>  drivers/iommu/amd/iommu.c   |  2 +-
>  drivers/iommu/dma-iommu.c   | 12 ++++++------
>  drivers/iommu/intel/iommu.c |  2 +-
>  drivers/iommu/iommu.c       |  2 +-
>  drivers/pci/ats.c           |  2 +-
>  drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
>  drivers/pci/pci.c           |  2 +-
>  drivers/pci/probe.c         |  8 ++++----
>  drivers/pci/quirks.c        |  2 +-
>  include/linux/pci.h         |  5 +++--
>  11 files changed, 44 insertions(+), 18 deletions(-)
>
>
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> --
> 2.47.0.277.g8800431eea-goog
>

