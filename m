Return-Path: <linux-pci+bounces-40570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B6C3F239
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 10:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EED6B4E5013
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498029DB99;
	Fri,  7 Nov 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gLti3+pi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904F2D63FC
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507433; cv=none; b=mV6fHk7TnWCYOVzY1wdm7PCmB1Q1sLIOgJHDj94XAOm1CBlWtymH4Fl3jbgPy1fypZsdgpUZSVsFqyf4M7NPLSzbzYGKBw1suRSSoTarRb3DvbPOs5SgmNeQjprgWYbUxvqK0IBKJLH38LQvnp7TQfQND6eDtJTFpYeMooElXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507433; c=relaxed/simple;
	bh=k/i/Wu1HPmOKq4PDi4yywjLAHiF74coVwwDp1hXMDpM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEkExP/WdItQ4UkfzH8ZfqXkGppU+6Y1jNMADUEHMPHXgOPZcXC0SGM1p4AfytJ2uJgtTaJrX8RKfG17lV+FbQoLfX4c07MHQqHVo8jad6uJk+KJWfkic2voPFT3m+ERY3ycY8edAtlbv6NrMdN/pIpkGqzg0lgIULxQlegbl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gLti3+pi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so81677266b.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 01:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762507430; x=1763112230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LacQSXGw7TbWuQyoWzY6N7WYy+KmingdHmAdQBcwPC0=;
        b=gLti3+pi0Gzk5jPU3yZGJFeB0bUJ4ksmSBql++f61gZ2lU2FrVF8FT0LLYABuh1Npt
         7h1f9OziA/xSax68dbqzX9ju9UCl2+inomCaRka+OvM2lJ50z4yrF1RT4Vphj3j0cdxc
         GqSoXSYyPNXbg1ctfwzdbIsPRwvmeICnKF9LPPzOVITE2g16oM+FsmXJI1H3xWExDqA4
         zQH1d5IeCDa/sC05e8+84TwJ8gShxzU9fL2QmLp2/ZxLekHxEi8ErfTdzyUejW/i5qUO
         YXW1v0a7COmWNRZemZzcn41P7xtEXcEs1znEEtf6cVDpYXtVgPcnyvRR5D3QiYW+oibi
         iyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507430; x=1763112230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LacQSXGw7TbWuQyoWzY6N7WYy+KmingdHmAdQBcwPC0=;
        b=EgZIWOeuE8zgJljD7DWGK2+BxY59yhXUAcPmKJJWBtCeNCBWmbHWXPfqIuYi4c3qma
         EcBz1GitvhEPIOZxar3p4Z9Wod7iurWZFoM34JK9EWOPnK5Qw5Vmv08ekCRGIyKp2aaj
         BZHUQ5LVbv4D8FtumzOANgBTbxNe8J4mvkpFehbcKWT5OOj6K3gK6VwnO5DPGM9Pitjn
         H2I74IhjYqRFSlBp/QLty8JelMycaY9G2OIwJ9eHuFiNpLEnml1kzXVGnMA1tYJciBAw
         dussOlGR29nxTSiUlX3w3NMJqtgvL7ZPR3PHN977QOfhSypuGPwk/9lu8k0PJSzAVfwT
         x8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfgru8MiFc7mY7PWKXhjnfvUpJamFL7ZsQ5Sl+8XAqKjc6yELIcG+IS4OJWLlskXz5onef85EbSjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwucMbyUELhwNpQWo05RIPxmZO0Ml+PiuiiiTzvpug3IU0JDZaU
	TstV3ShA/8vQyQ6i1hfRTFKhl8BGSnJ+1W7OmSFKfOAifcJsgoH0zcf5FLu4l4YaEhE=
X-Gm-Gg: ASbGncsvG5LGMkNzO+7pdarNKkdUEvW5gw0FebmJxPTpPGkkOcCqM1GlSS93XWgRkY0
	Zbw5BH6a6gT91JR+rI/uLjDQC9nPe0PjNuDWUWEZWx1I6DHzI7w6xyk12VV2LgOWYCmZg/9lvkl
	sYQnPsEfrceAYNND6fiG6nHhfMpsyEDNjIQ+/uAwM84sb0b46SOUqb6mjBJMejgRruNwNX8Nm94
	oFPQXzVudgb9369DZpUu4ZvCc+Uldi2rPdcAIsUR6ae7Mu3cHAOa/nISR1y1WERU8ZDpVv34nSu
	6g+Ojmkv64bJOxn4QfZSbK/hpBFIXL5sXa86a2CxVfvwFcM9Ns4O917uiFRqREa1tIak8L7q+3x
	REPpG19MB4n3KYJ5NgSVdgB01hgJQD+O1DuiVsaBX8/faNKRUtUya73OkxbEuU+rvAsOq1W8ST6
	q1RJeIbhfOmIBlnlFun9aDGPMbI6jj28vHnViIVNvwIhVCZtHhgkXIgbXY
X-Google-Smtp-Source: AGHT+IFi+fpxy9purLfTBg++sUcxlN2Azn7yKLv30XH2N7uE0nRjNLH/v6fkpMZZkJGpfSiMDkd+Ig==
X-Received: by 2002:a17:906:c103:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b72c08e0249mr225878566b.4.1762507429649;
        Fri, 07 Nov 2025 01:23:49 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf4fbd8csm196766666b.24.2025.11.07.01.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:23:49 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 7 Nov 2025 10:26:07 +0100
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <aQ27L_95tgaj1qT1@apocalypse>
References: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
 <20251106002345.GA1934302@bhelgaas>
 <aQyApy8lcadd-1se@apocalypse>
 <20251106131854.0f0aa8b7@bootlin.com>
 <aQy9C8315Gu5F5No@apocalypse>
 <20251106182708.03cfb6c6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106182708.03cfb6c6@bootlin.com>

Hi Herve,

On 18:27 Thu 06 Nov     , Herve Codina wrote:
> Hi Andrea,
> 
> + CC Rob
> 
> On Thu, 6 Nov 2025 16:21:47 +0100
> Andrea della Porta <andrea.porta@suse.com> wrote:
> 
> > Hi Herve,
> > 
> > On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > > Hi, Andrea, Bjorn,
> > > 
> > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > >   
> > > > [+cc Herve]
> > > > 
> > > > Hi Bjorn,
> > > > 
> > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:  
> > > > > [+cc Lizhi]
> > > > > 
> > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:    
> > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
> > > > > > is generated if no 'of_root' node is defined.
> > > > > > 
> > > > > > On DT-based systems, this cannot happen as a root DT node is
> > > > > > always present. On ACPI-based systems, this is not a true error
> > > > > > because a DT is not used.
> > > > > > 
> > > > > > Downgrade the pr_err() to pr_info() and reword the message text
> > > > > > to be less context specific.    
> > > > > 
> > > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > > pci_register_host_bridge() path.  Does that mean every boot of a
> > > > > kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT system will see
> > > > > this message?    
> > > > 
> > > > This is the case, indeed. That's why downgrading to info seems sensible.
> > > >   
> > > > > 
> > > > > This message seems like something that will generate user questions.
> > > > > Or is this really an error, and we were supposed to have created
> > > > > of_root somewhere but it failed?  If so, I would expect a message
> > > > > where the of_root creation failed.    
> > > > 
> > > > Not really an error per se: on ACPI system we usually don't have DT, so
> > > > this message just warns you that there will be no pci nodes created on it.
> > > > Which, again, should be of no importance on ACPI.  
> > > 
> > > I my last understanding, all architecture (even x86) have the DT root node
> > > set. This node is empty on architectures that don't use DT to describe
> > > hardware at boot (ACPI for instance).  
> > 
> > This does not seem to be the case for all arch, see below.
> > 
> > > 
> > > This DT node is needed for PCI board that will be described by a DT overlay.
> > > LAN966x for instance.
> > > 
> > > On v6.18-rc1 kernel, I successfully used my LAN966x board on a ACPI system.
> > > This means that of_root DT node was present on my system.
> > >   
> > > > 
> > > > The only scenario in which this message is actually an error would be on
> > > > ACPI system that use DT as a complement to make runtime overlay work,  
> > > 
> > > It is an error also if you use a PCI board that needs PCI DT nodes
> > > (CONFIG_PCI_DYNAMIC_OF_NODES) Lan966x for instance.  
> > 
> > Yes, I was referring exactly to that.
> > 
> > >   
> > > > i.e. the overlay approach for RP1 on RPi5 with ACPI fw. AFAIK this fw is
> > > > more a PoC that something really widespread and currntly the overlay
> > > > approach is in stand-by anyway (meaning no one will use it unless some
> > > > major changes will be made to make it work). But there may be other
> > > > situations in which this scenario could arise, I'm thinking about Bootlin's
> > > > LAN966x driver which also uses runtime overlay to describe thw hw.
> > > > On ACPI system the root DT node is not created because unflatten_device_tree()
> > > > is not called.  
> > > 
> > > I am not so sure.
> > > My LAN966x board is working on a x86 ACPI system.  
> > 
> > Indeed it depends on the architecture. On x86 an empty DT node is created,
> > provided you have CONFIG_OF_EARLY_FLATTREE defined (which I guess you have,
> > even if it's not in default config).
> 
> Indeed, I have CONFIG_OF_EARLY_FLATTREE = y.
> 
> > 
> > On arm64, ACPI and DT are mutually exclusive, unless the DT is basically empty
> > (i.e. only root node and chosen node). The DT root node is not automatically
> > created if not provided at boot, though. This reinforces my idea of providing
> > the only root node DT on arm as well, but I'm not entirely sure about 
> > possible side effects.
> > 
> 
> Isn't it possible to have the same kind of operations on ARM64 ACPI and on x86?
> 
> In order to have CONFIG_PCI_DYNAMIC_OF_NODES working on ACPI, we need a DT
> node, even empty.

That's a good point and it's what I'm proposing, indeed. Maybe it may worth just
standardizing that across all platforms, if it is possible. But let's get there
step by step, and arm64 could be a good starting point. If there is an empty DT
on x86 I think it would be logical to do the same on arm. But the if guard that calls
unflatten_device_tree() only if acpi is disabled makes me wonder if there is some
rationale behind it that I'm not aware of, that's why I'm asking if anyone knows
of any possible side effects. Maybe Rob could give guidance...

> 
> ARM64 ACPI without an empty DT node means that no PCI boards using a DT
> description will work on this system.

Indeed.

Regards,
Andrea

> 
> Best regards,
> Hervé

