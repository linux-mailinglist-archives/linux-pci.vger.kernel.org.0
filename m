Return-Path: <linux-pci+bounces-27803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B874EAB8883
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9483A1BC053F
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B232132122;
	Thu, 15 May 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFK2sYYF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206224A24;
	Thu, 15 May 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317065; cv=none; b=B3LDm3Oz3dHezzmfaJi3RD8Hehn3b0e/3DymFflu3wyCD8/YeHApvWYgA07nZ833f08T88T8/SXTySmra2IBak3ljPRhXxyRjmN/A+NwiqSOUQ5uG17CaA4ndJN4Mg2AF1lw/UDcHr3ZQzkpYiiUaFAjvxC8rPitjX8jyMnJw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317065; c=relaxed/simple;
	bh=7SR+pCTlePTZVEP3G9ZrogSNkG0kFVs8m73DIu5eyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV2LzVqy2NGMy4XgrBEB/KA2wF7jNW97lpxol1wiWKuBzSAaF9kDbsU9sgnI9t03VXAgtWXFyIiOakvNVa7LTA1DN/hkCHof0BqIdwBCZr/ESXXFw5CVFoKoIYJAsUdH2f+xjL4/QjZvdac7Mj76vQau/7evRuVxAilTO1sIbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFK2sYYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC62C4CEE7;
	Thu, 15 May 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317064;
	bh=7SR+pCTlePTZVEP3G9ZrogSNkG0kFVs8m73DIu5eyaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFK2sYYFcjzu9QO33iuHPO3Yk/3TorRaj6hIrmG6fbDB70o3WpWYMQa3qHic26QHz
	 eqpqeHSvLm5IIrGbBguNRKtxJfOFXWNDkb4e6C8gn15ZUYRfb8blkDiLNYWc1j+WZv
	 PicBvs47Aucx9wQY2CBeROvPIDRbJEDEywzel8UH1opUNjpNbqb4RuTi3vly+Z1e8M
	 a+Mc39gPEuofekX9Xrp25A4Se+eJD81FXnA11fX9AkiXcoKaNH3u35jK5KRmILeFIV
	 xyBuM+z48oUmhRNa7jpnHlMx48xhkX3bHq+ok/ZIetlrwcLUrStSpvnAFCJujv7bp1
	 O8SY21eI2Qtiw==
Date: Thu, 15 May 2025 22:51:02 +0900
From: Krzysztof Wilczy??ski <kwilczynski@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <20250515135102.GA3596832@rocinante>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
 <20250515084346.GA51912@rocinante>
 <aCXZdfOA8bme-qra@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCXZdfOA8bme-qra@wunner.de>

Hello,

[...]
> > Done.  Squashed with the first commit from Ilpo, see:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=bwctrl&id=2389d8dc38fee18176c49e9c4804f5ecc55807fa
> 
> Awesome, thank you!
> 
> > Let me know if there is anything else needed.
> 
> Actually, two small things:
> 
> - That patch on the pci/bwctrl topic branch is still marked "New"
>   in patchwork, even though it's been applied:
>   https://patchwork.kernel.org/project/linux-pci/patch/20250422115548.1483-1-ilpo.jarvinen@linux.intel.com/
> 
> - Version 1 of the same patch is likewise marked "New", even though
>   it's been superseded:
>   https://patchwork.kernel.org/project/linux-pci/patch/20250417124633.11470-1-ilpo.jarvinen@linux.intel.com/
> 
> Unfortunately I can't update it myself because I'm not the submitter.
> (Ilpo could do it if he has a patchwork.kernel.org account.)

I had a look and I think Ilpo beat me to it.  Thank you Ilpo!

Also, thank you for chasing after this.  Much appreciated.  Good to know
people use Patchwork to track what is up with our tree. :)

> Something unrelated (only if you feel like doing it):
> 
> On the pci/enumeration branch, Bjorn queued up a revert which was
> waiting to be ack'ed by AMD IOMMU maintainers:
> https://lore.kernel.org/r/20250425163259.GA546441@bhelgaas/
> 
> In the meantime the ack has arrived:
> https://lore.kernel.org/r/aCLv7cN_s1Z4abEl@8bytes.org/
> 
> So the remaining housekeeping items are:
> 
> - Add Jörg's Acked-by to commit e86c7278eba8 on pci/enumeration
> - Remove the "XXX" marker from the subject line
> - Remove "Needs AMD IOMMU ack" from the commit message

Done.  Have a look to make sure that things look correct now:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=enumeration&id=3be5fa236649da6404f1bca1491bf02d4b0d5cce

> Again, only if you feel like doing it.  No urgency.

No problem!  Any time. :)

Thank you!

	Krzysztof

