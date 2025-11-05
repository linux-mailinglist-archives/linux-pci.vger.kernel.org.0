Return-Path: <linux-pci+bounces-40340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE3C352D7
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EC756500E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 10:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B13306B21;
	Wed,  5 Nov 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrOpLL/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3730749E;
	Wed,  5 Nov 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339403; cv=none; b=g0sKmoGd4DffB3GYCM8G4zwcsTaqju26zTMVPTwSh6gr7QYnFLpmL2K377p9JrZsARIRMqGTiB/c2jHW2zinOTwkkxJzJm61BHx+V2/newQuU6mr59M5/XG8CHxTrm5KJTYol2oG8Bzd4qz65p9t+8m6w2dy4rOEyWVAxgE5DBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339403; c=relaxed/simple;
	bh=xiagzVBevityIRA/xHOUPEL9BTQxWFUSQ4DwL3QsZ6Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j7CIJzX09lbhmrRd+LYt7iaCc5RbnK09qKtaMNIE3a1R6Vt1Hn+zBO1jZFSqlxcb7dsFjcd/Ws5QG0ZHiqTQAJlVdmLTGcK21Z5zL4y0HuYZArD8RUuv7LFqXA1llhkpxfAazudgcK5gKqGUrAPR8o/2Etpu2nghQbu+x5RWkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrOpLL/4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762339402; x=1793875402;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xiagzVBevityIRA/xHOUPEL9BTQxWFUSQ4DwL3QsZ6Q=;
  b=nrOpLL/4oiNd3t28fNB+NYuXQZ36XWCXpxGTA+qSfVGJIyYONm21waDA
   KJQU4vjTPIJDQ5MhA5TsN2uO7wpBi48CysiuvEycjdY4aRv+K9nKm0L0J
   f/eekroL87SG9FtzPgNB1WlVq8fWJPyGzaP8Gl58X9XdNZjaaL/VgieO9
   zCB6RSfo2XR/VWkgyT7yF8H9SCEAzeHENT7zTRnNGErl91ooGEX5y3yd9
   N5xfnf6c1oFw3l64GZjq4w27yewlVs6aQaeCgS6qHPn6WAuD86hlr0MEc
   +iJVxBxeW9NWq8NuohU8NHM0XP/X1ITqIuTl15dDk+6eWKTHTtlLCUYvK
   Q==;
X-CSE-ConnectionGUID: phepiw9WR2KHMuCfaOhrkA==
X-CSE-MsgGUID: aimTRDd5Q0aWtOcFPoCKew==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81852624"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="81852624"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:43:21 -0800
X-CSE-ConnectionGUID: Isd4eBPLRcKDgK5YT6ErMw==
X-CSE-MsgGUID: OiLDIX16S4G9aa1KuMyt+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="218203072"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:43:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 12:43:09 +0200 (EET)
To: Niklas Cassel <cassel@kernel.org>
cc: Vincent Guittot <vincent.guittot@linaro.org>, 
    Bjorn Helgaas <helgaas@kernel.org>, chester62515@gmail.com, 
    mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, 
    bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
    kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
    krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com, 
    larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
    ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
    linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    imx@lists.linux.dev
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
In-Reply-To: <aQsmtKsTEmf7e7Sd@ryzen>
Message-ID: <bf3b2d2a-ce3e-87af-4154-abd022c6a3b4@linux.intel.com>
References: <20251022174309.1180931-4-vincent.guittot@linaro.org> <20251022190402.GA1262472@bhelgaas> <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com> <aQsmtKsTEmf7e7Sd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Nov 2025, Niklas Cassel wrote:

> On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> > On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > > +
> > > > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > > > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > > > +     dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > > > +
> > > > +     /*
> > > > +      * Set max payload supported, 256 bytes and
> > > > +      * relaxed ordering.
> > > > +      */
> > > > +     val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > > > +     val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
> > > > +              PCI_EXP_DEVCTL_PAYLOAD |
> > > > +              PCI_EXP_DEVCTL_READRQ);
> > > > +     val |= PCI_EXP_DEVCTL_RELAX_EN |
> > > > +            PCI_EXP_DEVCTL_PAYLOAD_256B |
> > > > +            PCI_EXP_DEVCTL_READRQ_256B;
> > > > +     dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> > >
> > > MPS and relaxed ordering should be configured by the PCI core.  Is
> > > there some s32g-specific restriction about these?
> > 
> > I will check with the team why they did that
> 
> Most likely, the reason is that, the PCI core does not set the MPS to the
> maximum supported MPS for the root port.

PCI core set/doesn't set MPS based on config. Perhaps try with 
CONFIG_PCIE_BUS_PERFORMANCE.

> So without that change, the port will use use 128B instead of 256B.
> 
> I assume that you should be able to drop (at least the MPS part) if this
> change gets accepted:
> https://lore.kernel.org/linux-pci/20251104165125.174168-1-18255117159@163.com/
> 
> 
> Kind regards,
> Niklas
> 

-- 
 i.


