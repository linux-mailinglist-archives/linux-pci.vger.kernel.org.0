Return-Path: <linux-pci+bounces-30982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56651AEC2FD
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 01:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E2D561543
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD234290BA5;
	Fri, 27 Jun 2025 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK0v4Sp9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483C28DB71;
	Fri, 27 Jun 2025 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751066853; cv=none; b=Vdh54T0qM4OKrOVKwfbX+YGd21EDL9NLCn4E0ADipVGcyjwdtrQIVRJx62rIoFQBYLA3JYrDmFop53WIt2P12RKJDoQlENEdt7mPudCyKlng8nAVGi93vJzLx9EharHeA/C6P5on2rBna07A8yRn+JDzHXR3csuPgnY8jMiDsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751066853; c=relaxed/simple;
	bh=DzeC/ItIJ1IKYPWFENclfRURS3c24iRf6j/N4B8dPAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4S1Sb2DTrPgj97LxWh5+JG0RgYU1Zy824zikh3Y5oF9biEBVUCinNlNm0abkagmRMuJcV018ohx7ti7fMlPc+ueWJr/RwUSRgQm+dXYAReu0IMc1ABrpdu9w1nTSKes+rj0qHKnc5HMqMtd6GWnklaMEcQbV7j5F2eQABqNUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK0v4Sp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76827C4CEE3;
	Fri, 27 Jun 2025 23:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751066853;
	bh=DzeC/ItIJ1IKYPWFENclfRURS3c24iRf6j/N4B8dPAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bK0v4Sp94EyI0JB5esjyP/GChQ/RNh6VTd1xLu9yUMzfDxVw/JrNjOZyNb0G/IY+P
	 hDd/jAZe/VQ4DIDgAM+yglQnrvubDPyVtlsm8gIJRBLjRm+SXPXXlPWxNQjlJuBkTg
	 XjypdGgSO9OBmyJ+d5TTDrJQg1xxTW3SyohShXwP0U7BJXpNhUM9rIUvgEQ5xRWh+U
	 DxB3GQztByKRGAEp+XSJl+/AFNG7dXcLPk0GdnCoG95ZmZ6GzN0QMBz97AxVoC8Gwe
	 M5mX1MDcEQnmV0dXqTID2Tcrl3CdjABAvzMqB5q32wq+kVahRmjvlL0mhCn8ynuHHq
	 PcVPmzyMp87GQ==
Date: Sat, 28 Jun 2025 04:57:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <qy2nfwiu2g7pbzbk37wseapvsen7mx4fgqdkdwjbclsj5dltu5@7o2xtj3qhedm>
References: <20250616053209.13045-1-mani@kernel.org>
 <20250627224502.GA1687792@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627224502.GA1687792@bhelgaas>

On Fri, Jun 27, 2025 at 05:45:02PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2025 at 11:02:09AM +0530, Manivannan Sadhasivam wrote:
> > pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> > built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> > independently of CONFIG_PWRCTRL. This creates enumeration failure on
> > platforms like brcmstb using out-of-tree devicetree that describes the
> > power supplies for endpoints in the PCIe child node, but doesn't use
> > PWRCTRL framework to manage the supplies. The controller driver itself
> > manages the supplies.
> > 
> > But in any case, the API should be built only when CONFIG_PWRCTRL is
> > enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> > a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> > fixes the enumeration issues on the affected platforms.
> 
> Finally circling back to this since I think brcmstb is broken since
> v6.15 and we should fix it for v6.16 final.
> 

Yes! Sorry for the delay. The fact that I switched the job and had to attend OSS
NA prevented me from reworking this patch.

> IIUC, v3 is the current patch and needs at least a fix for the build
> issue [1], and I guess the options are:
> 
>   1) Make CONFIG_PCI_PWRCTRL bool.  On my x86-64 system
>      pci-pwrctrl-core.o is 8880 bytes, which seems like kind of a lot
>      when only a few systems need it.
> 
>   2) Leave pci_pwrctrl_create_device() in probe.c.  It gets optimized
>      away if CONFIG_OF=n because of_pci_find_child_device() returns
>      NULL, but still a little ugly for readers.
> 
>   3) Put pci_pwrctrl_create_device() in a separate
>      drivers/pci/pwrctrl/ file that is always compiled even if PWRCTRL
>      itself is a module.  Ugly because then we sort of have two "core"
>      files (core.c and whatever new file is always compiled).
> 

I guess, we could go with option 3 if you prefer. We could rename the existing
pwrctrl/core.c to pwrctrl/pwrctrl.c and move the definition of
pci_pwrctrl_create_device() to new pwrctrl/core.c. The new file will depend on
HAVE_PWRCTRL, which is bool.

> And I guess all of these options still depend on CONFIG_PCI_PWRCTRL
> not being enabled in a kernel that has brcmstb enabled?  If so, that
> seems ugly to me.  We should be able to enable both PWRCTRL and
> brcmstb at the same time, e.g., for a single kernel image that works
> both on a brcmstb system and a system that needs pwrctrl.
> 

Right, that would be the end goal. As I explained in the reply to the bug report
[1], this patch will serve as an interim workaround. Once my pwrctrl rework
(which I didn't submit yet) is merged, I will move this driver to use the
pwrctrl framework.

The fact that I missed this driver in the first place during the previous rework
of the pwrctrl framework is due to devicetree being kept out-of-tree for this
platform.

- Mani

[1] https://lore.kernel.org/all/vazxuov2hdk5sezrk7a5qfuclv2s3wo5sxhfwuo3o4uedsdlqv@po55ny24ctne/

-- 
மணிவண்ணன் சதாசிவம்

