Return-Path: <linux-pci+bounces-13727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB898E3F8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF531F215A0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C495216A17;
	Wed,  2 Oct 2024 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8zTo/qt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D611D0E17
	for <linux-pci@vger.kernel.org>; Wed,  2 Oct 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899774; cv=none; b=h4usbII1GaFvQ5cmNYNgSbmwvePL45JMMTJf/pfiG5vnKL9H0//UQdHpuxuKSjHemaJNkiSfsRanfnDI8Zy0iYox6XMhRkL1chsTyEAcMceaZhmTNoDuNICpiW3v2aaTYC7ZHrbxrV3XSJsDTskerDs6bQwrUq4T8z2780KsoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899774; c=relaxed/simple;
	bh=c/4Zc0xscLYxxMkERQl0yi0iPdBqIB2fMJga9wSOBoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gx0807ovtUAMJ0e83d58PLqP/4yWOQpGOwUV6aXFcUpj5ePrjrQvXIiNbWOgGV5huGvV56O+RPAulHfDOh+TimqJzrwj9+WTdFddoDem6wbLJHT3JhuwTzE3f6m/3qJ7Xjz9MMmYLeP7+m1WtssZ4YBgAt2b5Fsfz06po7LIH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8zTo/qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E8C4CEC2;
	Wed,  2 Oct 2024 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727899773;
	bh=c/4Zc0xscLYxxMkERQl0yi0iPdBqIB2fMJga9wSOBoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d8zTo/qtagndvHLYHjC7H2lFwS8Xthh5hJZRvyJX65dg745ftcI+OpTX0WWm9wxjM
	 ebD5KcUHwQ4kn/BkxupXRDYk9uzyqm3hhB17HIu+hhEdycKx+8zUFUjCSe94Y6uPJ5
	 UeeCrI8B8QLM/fk6dW00hU65/NPh0+MfAVL6X4i2AbyZJISnHNXmyhg+VWZUstmg0o
	 9wO0xjkcAviiEuLt73hpC5+Fw0b4m4Dw9IcZcExHNnc05U0roYUjtIa5XwEhOUjl6G
	 pAc1Zsq5hglGXGcNJK2KpEzX2aZfXxwBr2k4e6jMP9B76He8gwmaGWio3Drt+66p49
	 QBZbEy9+wQ+ag==
Date: Wed, 2 Oct 2024 15:09:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <20241002200926.GA268053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002181223.GA231923@bhelgaas>

On Wed, Oct 02, 2024 at 01:12:23PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 01, 2024 at 07:05:18PM +0530, Ajay Agarwal wrote:
> > The current sequence in the driver for L1ss update is as follows.
> > 
> > Disable L1ss
> > Disable L1
> > Enable L1ss as required
> > Enable L1 if required
> > 
> > PCIe spec r6.2, section 5.5.4, recommends that setting either
> > or both of the enable bits for ASPM L1 PM Substates must be done
> > while ASPM L1 is disabled. My interpretation here is that
> > clearing L1ss should also be done when L1 is disabled. Thereby,
> > change the sequence as follows.
> > 
> > Disable L1
> > Disable L1ss
> > Enable L1ss as required
> > Enable L1 if required
> ...

> pcie_config_aspm_link() has a comment ("Spec 2.0 ...") about the
> configuration order, but I'd like to update that, add a section
> reference, and make sure we do the disable in the right order.

Found some language about this in the ASPM Control description in PCIe
r6.2, sec 7.5.3.7, Link Control.

Also in sec 7.9.9.3, Root Complex Link Control, although I don't think
Linux has any support for this register.

