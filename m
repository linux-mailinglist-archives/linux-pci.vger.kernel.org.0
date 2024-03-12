Return-Path: <linux-pci+bounces-4748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95511879060
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CD71F21F3F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80477F1C;
	Tue, 12 Mar 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/TpW1HD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C777A03;
	Tue, 12 Mar 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234505; cv=none; b=UhB0S+3rxJapWGT8lKyEi1kJv0MXQKXtPoJ3qnZ0oUp5WwjCeeCuLiObz2C6H9H6gJEtY62kEVdUNRw0cd6Odylc3AasEMqHSD1lcDp32MuB1cUj03uXP0/jOv8lkwLttqUIZGOaWtPA3uSDMWhWxE4G9rZBwGIIB8tDVks5nC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234505; c=relaxed/simple;
	bh=Hovp2SpFqNAcSQbRYkflVVphrfZ4KQbQv0e1t94NEC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Og3ofUJiHBKHbBd2QCkAu77mSuZdRSED7bwpLatCd9I/jKJh3Oy4tAtvxdj3Aug7oZ7zjV2VWav+hWSssDvDphM2pqJq02YNymar1Fkx06xs0MS6GGyUqwUe6wrsAt2Yhauoub/ouECEdWiTQBB86vCz2KTNazUQYggUUCB1b6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/TpW1HD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710234504; x=1741770504;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hovp2SpFqNAcSQbRYkflVVphrfZ4KQbQv0e1t94NEC0=;
  b=U/TpW1HDb/0KQmZcGQTbeQvhCuupM+LSuHWhTu3vc142D8TX6g7Ysetw
   9bJzz80968XNoSfKDdeXHMICWAn2I368dZLdrojNJpmUpFNekSFpVKIdA
   a/U7O6OH1M18LbMzUZx25LI1ujeVvgI2BKPlotyewcfFwD/nSTt0OgVmh
   BfcbUShVMXmriPA8QCpbulXk+HO7DzPv499oMk+fzfuEdcT1mFi9Oju4Z
   dytCvQMEeFQkC/3MvYWjitEnR/L+w9QD+p9CpGLlkJJ21pp2+0pQL8EBq
   +IGe9lRytGgXkqQuPU+ZMdxi/5k7SWkcWaDLaz5ITV1QFMYoksnuNLZdj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4789521"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4789521"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11925428"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.98.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:08:20 -0700
Date: Tue, 12 Mar 2024 10:08:16 +0100
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, Dan Williams
 <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-leds@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240312100816.000071ec@linux.intel.com>
In-Reply-To: <CAL5oW00nSZV=oAjWPbYTwVGZ9OS1hW9hyZ5C0yzWbMjAstAA2g@mail.gmail.com>
References: <20240311104750.00000c24@linux.intel.com>
	<20240311221337.GA819923@bhelgaas>
	<CAL5oW00nSZV=oAjWPbYTwVGZ9OS1hW9hyZ5C0yzWbMjAstAA2g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 17:30:06 -0500
Stuart Hayes <stuart.w.hayes@gmail.com> wrote:

> > > No, Linux doesn't support _DSM. It was proposed in previous
> > > iterations by Stuart but I dropped it. We decided that it need to be
> > > strongly rebuild because "pci/pcie" is not right place for ACPI code
> > > so we cannot register _DSM driver instead of NPEM as it was proposed
> > > and I don't have _DSM capable hardware to test it.  
> >  
> 
> I'm not sure I understand why pci/pcie isn't the right place for ACPI code--
> there are other _DSMs used in PCI code already, and this _DSM is defined
> in a PCI ECN.

I looked into internal review history and I found out that I dropped it after
discussion with Dan Williams:

> After review and discussion with Dan _DSM extension is dropped.

Unfortunately, I don't remember what exactly he suggested, I just remembered
conclusion that it needs to be reworked and I decided to drop it.
Maybe, I didn't understand him correctly.

Dan, could you take a look? Do you remember something?

Thanks,
Mariusz

