Return-Path: <linux-pci+bounces-22996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022F0A50687
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ABB3A7729
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FE22257F;
	Wed,  5 Mar 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV3flwBU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F81957E4;
	Wed,  5 Mar 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196308; cv=none; b=phtqB1s79B2bE4A09sLigSPxYO39gKSBNxV7biwjEdBZhZQ0JCzdFLy7l0j8P8irNuKzge2qVCyRQwwexExZg9cjE1Qv7D1QCyhj1eQ+10D718aT9bBMHu3F1pI/ugTWrCPGHPlMMLESquV6RJU9cSrjKSSULy4I7Ne6wuM3Xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196308; c=relaxed/simple;
	bh=ijeMNbdG6/t/MFEhbiYg7NxdfQyaCwL0KeoeZZihREw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tHrEvKlb228smlQ92OXil3HgWWRFK44eontkbughOoXJfGJBPHMgomgXlOEls+nNLyWBWPn9i+0zEywIG/KyQL133uq8mNZyGb2wbdqZhJqD8Ue2KabQf1r0BnVD5BEMR49dbd2xxUa1Ar5jpfPx0hCwd3KDg90JzxBwQ/Xg8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV3flwBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906A8C4CED1;
	Wed,  5 Mar 2025 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196307;
	bh=ijeMNbdG6/t/MFEhbiYg7NxdfQyaCwL0KeoeZZihREw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TV3flwBUO/G0FQf09lT08iTdwkyHwQLxOvyCqIuBuMonT1GOwm0cUoemhaPTTHeix
	 h+8jch8k0QjY3uKAtLRojI7MG+hBjyNZ702wCXv2vaLEbYNJVD0++H/MhU33skYvp3
	 7quINAI0nSkLMZ6a32qOQKcn+Faf0eFW03TjGB52SmUHh/l+w0PQgL7Q5H489hEgZy
	 AL0uN49J4r0jqbO9L/62YHpoW6QE1Gzqo3Ifnxki16OdKKp78RkRCluQYYiioTTVqS
	 T7gISCH9FLq5trvXbfXhw+9xoxwOGynufWk1wMnppCXeDJmuuJncKkgnHJODMYbjna
	 NOYdAqxliI+Jg==
Date: Wed, 5 Mar 2025 11:38:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250305173826.GA303920@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304171154.njoygsvfd567pb66@thinkpad>

On Tue, Mar 04, 2025 at 10:41:54PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 05, 2025 at 12:46:38AM +0900, Krzysztof Wilczyński wrote:
> > > On Mon, 3 Mar 2025 at 20:47, Krzysztof Wilczyński <kw@linux.com> wrote:
> > > > [...]
> > > > > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > > > > +{
> > > > > > +   char dirname[DWC_DEBUGFS_BUF_MAX];
> > > > > > +   struct device *dev = pci->dev;
> > > > > > +   struct debugfs_info *debugfs;
> > > > > > +   struct dentry *dir;
> > > > > > +   int ret;
> > > > > > +
> > > > > > +   /* Create main directory for each platform driver */
> > > > > > +   snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > > > > +   dir = debugfs_create_dir(dirname, NULL);
> > > > > > +   debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > > > > +   if (!debugfs)
> > > > > > +           return -ENOMEM;
> > > > > > +
> > > > > > +   debugfs->debug_dir = dir;
> > > > > > +   pci->debugfs = debugfs;
> > > > > > +   ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > > > > +   if (ret)
> > > > > > +           dev_dbg(dev, "RASDES debugfs init failed\n");
> > > > >
> > > > > What will happen if ret != 0? still return 0?
> > > 
> > > And that is exactly what happens on Gray Hawk Single with R-Car
> > > V4M: dw_pcie_find_rasdes_capability() returns NULL, causing
> > > dwc_pcie_rasdes_debugfs_init() to return -ENODEV.
> > > 
> > > Debugfs issues should never be propagated upstream!
> ...

> > > So while applying, you changed this like:
> > > 
> > >             ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > >     -       if (ret)
> > >     -               dev_dbg(dev, "RASDES debugfs init failed\n");
> > >     +       if (ret) {
> > >     +               dev_err(dev, "failed to initialize RAS DES debugfs\n");
> > >     +               return ret;
> > >     +       }
> > > 
> > >             return 0;
> > > 
> > > Hence this is now a fatal error, causing the probe to fail.

> Even though debugfs_init() failure is not supposed to fail the probe(),
> dwc_pcie_rasdes_debugfs_init() has a devm_kzalloc() and propagating that
> failure would be canolically correct IMO.

I'm not sure about this.  What's the requirement to propagate
devm_kzalloc() failures?  I think devres will free any allocs that
were successful regardless.

IIUC, we resolved the Gray Hawk Single issue by changing
dwc_pcie_rasdes_debugfs_init() to return success without doing
anything when there's no RAS DES Capability.

But dwc_pcie_debugfs_init() can still return failure, and that still
causes dw_pcie_ep_init_registers() to fail, which breaks the "don't
propagate debugfs issues upstream" rule:

  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
  {
          ...
          ret = dwc_pcie_debugfs_init(pci);
          if (ret)
                  goto err_remove_edma;

          return 0;

  err_remove_edma:
          dw_pcie_edma_remove(pci);

          return ret;
  }

We can say that kzalloc() failure should "never" happen, and therefore
it's OK to fail the driver probe if it happens, but that doesn't seem
like a strong argument for breaking the "don't propagate debugfs
issues" rule.  And someday there may be other kinds of failures from
dwc_pcie_debugfs_init().

Bjorn

