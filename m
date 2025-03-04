Return-Path: <linux-pci+bounces-22867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A77A4E523
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C42C17EFF8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF72063F9;
	Tue,  4 Mar 2025 15:46:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBE24C063;
	Tue,  4 Mar 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103202; cv=none; b=UQe7feSLN0iLxnuDC/YUqZBAO5peZXSPo42+xKeDfccHqAV5NpMHQ4GQFqcA7wy2GflF4o5ddqo7/9a6Khdh8+MwnnrtXArAg14G4qoZDwqN44/C7808X1pAyyQwq3qrUz2PNPXkUcz/VQmmbDQ5cyb9BRkEYG9hnHL16UX95BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103202; c=relaxed/simple;
	bh=msyzO0UYK4O7STic7nVv1CFyyWG3MIkiJBnBLQ9y/KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FORaG4S3hdK6BbyyCU1t/I1Z09JROBNH+k4myrCNkZKdopnUE3cLOuVkMUFdS6hyFNEaY2DorCjzkapJQK8sjDXtfzB7/n+Xqc8iTUaWISY7Hahk2ubEkkjso2F+vBC6zOBbW412MgNoX2cjt3MqPeqLLgARg16C8R5ISPBMiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22382657540so63595355ad.2;
        Tue, 04 Mar 2025 07:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103200; x=1741708000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW1cKuRtFgc98VoZXyjtJAQFKd78PcnO2hM7lIoduzI=;
        b=ADv5vCOTXRfip53oPUwGGyUjgLOK7cllqlm1/AUgZZWQuS8FMvq0KPVyHRiyvpqpHN
         t3QStcx4Q1XyplFUXuHRjIxurQt3zNn0GUGQyK9lhBKold8Dud+9WUNRjXsVJYdpdRas
         ockWE8gnfyrqHaa+2zoV+v2Ojf45cftJHFt3wL2y7LJosZVqJcYSpEgz5WJw0CGkIhyG
         RTHoCwVIXzSF+AZ9jptH1f/9LgeWP0GNAvB4hqCpWJ+IHcNgudCgVRBTw46u4wWscFSi
         hyBqCX3APUuYgziBIfeqDfGmgD7WNoFm5q3eXyZlUfGcUUWO7NTBfUG6UEMroTiQqJXt
         DqIA==
X-Forwarded-Encrypted: i=1; AJvYcCV0FUZCcO20MpJx26F9d008rkDxiH0AAcmoeRB5T9EFDAEb3BwCPy6yDgKNhjSBBWCY38F+4ftTIUc7sE+JxgUbDw==@vger.kernel.org, AJvYcCVHagZ+J8gZFgFv8TChFx6t7UduwGj1BPbfi1PDBEdMpNcmQGlgHEgI56fCpRKK+teqRUO0bpHzANldp1n+fFmO0q8=@vger.kernel.org, AJvYcCVW2rbx6fTnbG6tu5UChAXuaqzmOAn6SLi2aI2LVXrixxAK/SfWPe109BWIeS/wLkerhyC36Onsgb8n65o=@vger.kernel.org, AJvYcCVpq3FHYEhkJYq0sTr7RNvxV7sgG4y9N7Sh/7XqpUO9twtUc8jhbqYnAd+r2/VZ6IdZcyrenGWs5Grz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5l7z0y+YSKdwVmngNob3XA3kPEKAgotuC/1434MelchFFzwjJ
	osKPWwruwfT8hwrmwPxUwmSX2uX3jzIYYI3MA3s2dIZ7O70Si+Kf
X-Gm-Gg: ASbGnctZGk+s1MVjO97dS6jaNw7ULvUk68CGGscs5BPi99c6ktwBSHsWo+x//qqc/7I
	Oh6BHeslbzLDE/zCWPj8CybshbtxAEiDqMwNB4Jp3SpYSxTp1zHGMx8wcmZUQFZhexS2k/AgmcA
	BZ5FfZX0nxBPxY71s7zdCwMyVUBmIs3Qri+rh+/y1Lcf46OyhXJp6Kv+2xAaJuLr2Ough/mMuOD
	VvvpY4zEYwXP9JlqgSwWKMvrRf1M5yYJYvSmSV1dlDn/8xmapxbudeRPU/CvQMF/IPlptOvhag1
	LvdNXrviXGh2O9PQ2Qaadw5gek16gRLifhQ29L3OjR6/ZHqXpHEMOMqApEu5Sgrcj4rXPEnTjRA
	Saaw=
X-Google-Smtp-Source: AGHT+IEzaN/r/FxaRDaAv2WPggcOLIm/6Vm7eMmJxC9+tfE4ygUZ5mXkWtuc2TbBMjwycyUGGLoq3Q==
X-Received: by 2002:a17:903:230c:b0:223:7006:4db2 with SMTP id d9443c01a7336-22370064ea3mr216436475ad.31.1741103200544;
        Tue, 04 Mar 2025 07:46:40 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504e18b3sm96918945ad.182.2025.03.04.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:46:40 -0800 (PST)
Date: Wed, 5 Mar 2025 00:46:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250304154638.GB2310180@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
 <CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>

Hello,

> This patch is now commit 1ff54f4cbaed9ec6 ("PCI: dwc: Add debugfs
> based Silicon Debug support for DWC") in pci/next (next-20250304).
> 
> On Mon, 3 Mar 2025 at 20:47, Krzysztof Wilczyński <kw@linux.com> wrote:
> > [...]
> > > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > > +{
> > > > +   char dirname[DWC_DEBUGFS_BUF_MAX];
> > > > +   struct device *dev = pci->dev;
> > > > +   struct debugfs_info *debugfs;
> > > > +   struct dentry *dir;
> > > > +   int ret;
> > > > +
> > > > +   /* Create main directory for each platform driver */
> > > > +   snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > > +   dir = debugfs_create_dir(dirname, NULL);
> > > > +   debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > > +   if (!debugfs)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   debugfs->debug_dir = dir;
> > > > +   pci->debugfs = debugfs;
> > > > +   ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > > +   if (ret)
> > > > +           dev_dbg(dev, "RASDES debugfs init failed\n");
> > >
> > > What will happen if ret != 0? still return 0?
> 
> And that is exactly what happens on Gray Hawk Single with R-Car
> V4M: dw_pcie_find_rasdes_capability() returns NULL, causing
> dwc_pcie_rasdes_debugfs_init() to return -ENODEV.

Thank you for testing and for catching this issue.  Much appreciated.

> > Given that callers of dwc_pcie_debugfs_init() check for errors,
> 
> Debugfs issues should never be propagated upstream!

Makes complete sense.  Sorry for breaking things here!

> > this probably should correctly bubble up any failure coming from
> > dwc_pcie_rasdes_debugfs_init().
> >
> > I made updates to the code directly on the current branch, have a look:
> 
> So while applying, you changed this like:
> 
>             ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
>     -       if (ret)
>     -               dev_dbg(dev, "RASDES debugfs init failed\n");
>     +       if (ret) {
>     +               dev_err(dev, "failed to initialize RAS DES debugfs\n");
>     +               return ret;
>     +       }
> 
>             return 0;
> 
> Hence this is now a fatal error, causing the probe to fail.

I removed the changed, and also move the log level to be a warning, per:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=c6759a967e69aba16aef0d92f43e527b112e98a5

Would this be acceptable here?

Mani, would this be acceptable to you, too?  Given that you posted the
following recently:

  https://lore.kernel.org/linux-pci/20250303200055.GA1881771@rocinante/T/#mab9cbd5834390d259afea056eee9a73d8c3b435f

That said, perhaps moving the log level to a debug would be better served here.

	Krzysztof

