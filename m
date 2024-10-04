Return-Path: <linux-pci+bounces-13792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346698FC72
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B15F1C21FC8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 03:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351EDDA1;
	Fri,  4 Oct 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIxSp7hF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD45288B5
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728010838; cv=none; b=tlBn8R1NspJ5dn2/jPPPirrfuv3ai0Ptjgn69CdBKK3+sEfEDhggUvsyZZofmAy5o7VJfZg1xPWJgOtoNbqwtu/p660ihsMBxo+zbDBY3n4JYeLBpt4JwlUrIVzvoLrvDz8rKr2xxGNsqnLMXImJu5bjnyqyPh1/23RJ36HcJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728010838; c=relaxed/simple;
	bh=nW7wqiDCtMpBBru9fQpWsqTDpgKrjXUQFwUX4ryMVZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmYzbkx1hf90thmHCM+M+/G09dfK0ynFAi24/e7shpgCSy9uMkGgpqu245dK/jMdn1fXrgsL6ajsyNsSGfSuY7CIwLw7ESKaYQvLYsczfazSC5un741KtFMqBumJKox8CjMFLb4/rnnwwDT53eAvdAdBrNLqzBVuoTwSX2vp9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIxSp7hF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b90ab6c19so17848165ad.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728010836; x=1728615636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qLUBCKQLtoABPl15OXigTRRzuAktX7KLGR2tbJ2/Ac=;
        b=AIxSp7hFkzsXKhPUff98dIhNP/kW8WLdmNTqphmOWxiCSR9zRrOI2P+recD0qA3wi6
         pkEbOwgNxEJcoET7BfJqdQtbREnokFTY/UK55ZY9vcAkxHP5xJunYO2tdUNja/a9vc/+
         yf7mXeaOqPDXpABg/TEI5GKlFq1ihiVzKnnSPkxytTZnpi/B51Jk9/lGoiXih09B6QHD
         ekPEnTZKJOLNQehkMc9aQPtbB8SDWQLmXQ7grBGUkIa+DEY0CcSg8Cqhl9ZtVbBWAgbZ
         VKmkVvfCUoZ/Zl5KptoEk+uBzcpn5j8xWhkH8WKJyz+kzqdfG2welV5JCYi4hF9sxt+g
         35Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728010836; x=1728615636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qLUBCKQLtoABPl15OXigTRRzuAktX7KLGR2tbJ2/Ac=;
        b=KTGwrysJ7F32Cl8qHDBUFYS2TSHqwzN/WLroM5EUWO4pf30LQRzdVQF346X8ZG0kch
         zksUIJ1duDSYhAo/3FU7BYBGVYJDO3Kb/QTDzMvbJy7JuAcuwxPddn4qE3YbjcUbuULE
         y1haVqZ7HuX80B46WvJHIUp4/2n/HuyNKaQhS9WXA/zCLPDsEVx3pcux7Mks39+NF/zD
         d7j53b/llQEPyzFS5rV3PiedWRScyrYaCOtXiEOY9vaMeVWUfb6DznDGQz+eSv+Q87AG
         QddlMKdhNGQ7nQUWVe1p3WBSQUvKilMDtwUUSrJ+9CTyE0KRyieDo4x9w25TFVYuT9Wx
         VwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj01Fh9NWC+WIftjrFZbChniQ9gIqoxejaR6wxSwyhH0ZR+eBRvdxdPknCCWXAb8b/n++KA5Lw++U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBd4en9lnzFEdnjlRh0HO4+4oogmUXlEcyFp5M0P2LnQRJDSO0
	ZCAAMmwY8/489TXounTOaOmgRxfHQqorGN2CU4JIhdnWWNJIJ4H0Qgf2OFaScQ==
X-Google-Smtp-Source: AGHT+IEQM1Pk6BmaHKYNgcH6wIPGIrUYBBrtgdRKO7S5nze7M4EYP74HBAwb4FeAkkN3UBAYbhpIHQ==
X-Received: by 2002:a17:902:f650:b0:20b:cae5:dec6 with SMTP id d9443c01a7336-20bff074ab7mr18543665ad.59.1728010836207;
        Thu, 03 Oct 2024 20:00:36 -0700 (PDT)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefafc65sm15329605ad.217.2024.10.03.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 20:00:35 -0700 (PDT)
Date: Fri, 4 Oct 2024 08:30:27 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <Zv9aS_FpDZpvmGnQ@google.com>
References: <Zv7TLs9_CMaYQ--b@google.com>
 <20241003202321.GA321551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003202321.GA321551@bhelgaas>

On Thu, Oct 03, 2024 at 03:23:21PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2024 at 10:53:58PM +0530, Ajay Agarwal wrote:
> > On Thu, Oct 03, 2024 at 12:01:22PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Oct 03, 2024 at 06:55:03PM +0530, Ajay Agarwal wrote:
> > > > The current sequence in the driver for L1ss update is as follows.
> > > > 
> > > > Disable L1ss
> > > > Disable L1
> > > > Enable L1ss as required
> > > > Enable L1 if required
> > > > 
> > > > With this sequence, a bus hang is observed during the L1ss
> > > > disable sequence when the RC CPU attempts to clear the RC L1ss
> > > > register after clearing the EP L1ss register.
> > > 
> > > Thanks for this.  What exactly does the bus hang look like to a user?
> > >
> > The CPU is just hung on reading the RC PCI_L1SS_CTL1 register. After
> > some time, the CPU watchdog expires and the system reboots.
> 
> Wow.  Good to know that this is outside the PCIe domain.  I think this
> is a good change, and since it is partly motivated by hardware
> behavior that might be legal but seems somewhat unusual, can we
> identify the hardware (CPU and PCIe Root Complex) involved here?
> 
The CPU is an ARM A-core. The PCIe RC is a Synopsys Designware core.

> > > I guess the problem happens in pcie_config_aspm_l1ss(), where we do:
> > > 
> > >   pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
> > >   pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
> > > 
> > > where clearing the child (endpoint) PCI_L1SS_CTL1_L1_2_MASK works, but
> > > something goes wrong when clearing the parent (RP) mask?  The
> > > clear_and_set will do a read followed by a write, and one of those
> > > causes some kind of error?
> > >
> > During ASPM disable, in pcie_config_aspm_l1ss(), we do:
> >    1. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
> >    2. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
> >    3. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ... 0)
> >    4. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ... 0)
> > 
> > We observe that the steps 1 and 2 go through just fine. But the read of
> > PCI_L1SS_CTL1 register in the step 3 hangs. I am not sure why.
> > The issue is pretty difficult to reproduce, and adding prints around
> > these steps masks the issue.
> 
> I guess the L1 disable is between 2 and 3, right?  And 3 and 4 may
> enable L1 SS (using val, not 0)?
> 
>   1. same
>   2. same
>   2.5 pcie_capability_clear_word(child, PCI_EXP_LNKCTL_ASPM_L1)
>   2.6 pcie_capability_clear_word(parent, PCI_EXP_LNKCTL_ASPM_L1)
>   3. pci_clear_and_set_config_dword(parent->l1ss + PCI_L1SS_CTL1, ...  val)
>   4. pci_clear_and_set_config_dword(child->l1ss + PCI_L1SS_CTL1, ...  val)
>
Thats the sequence when L1ss is enabled. When it is disabled, then steps
2.5 and 2.6 do not run. And 'val' remains 0.

> Bjorn

