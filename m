Return-Path: <linux-pci+bounces-38306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4FBE20B7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DCC44E0251
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC712281370;
	Thu, 16 Oct 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjK/FlTf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B12475CB
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601221; cv=none; b=Jd5EKoQXqKvDPDYk1N58hggxhL3poM5j5cG1VN08gdb4GJ7IcFXSKdP0HCIuqTq9kJaSOw01PPB/faZYcwofBS9ussKg4pZxLRFSgtfu3JlMY+jYdKWl731pTkzS/F/xvfDU1PyC2FRQ6tIU2TkPynBXiqghRN1P74e5abc50LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601221; c=relaxed/simple;
	bh=wjntWI2HpwORrYYs/RF4PW7NcPU8Dt5MGy9i5SPIAJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upHl5xjMOAgNA6SjgnAqXrqdJWmorN1MgLvqPDTZlbuNhS/PTxRPouh3+M6MROzDwXkdoSoCDU0L7WubVtcZ0+FNgqEf4y49rph0PC+0ZlAyuCPhkgsRsWTXbPAwWi5dnYIlzxKCvKEhk0uWhVL8T0yN1UjVLWrRtk86uUw/su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjK/FlTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B175C113D0;
	Thu, 16 Oct 2025 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760601221;
	bh=wjntWI2HpwORrYYs/RF4PW7NcPU8Dt5MGy9i5SPIAJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjK/FlTfEWsznCIvFMtEQIQFS2ySLSXHPdSz2VzphShnoqE6oUQVK9EMqzjQsz/7f
	 VDjvB5CmZjTjYADtWoSuikbC2eYJIOXa2vFVDwTumxOLvtahAT5uKA202s3Xy/fxiK
	 wF9e6Nctpbi9V+V35n3OVle/lBEWHdaB+2e48ZlBQ8WpXaj9aRNOrssinYUlz2QE5/
	 29CxiJudPNSNgwNs/Qy3irHCj1fpGJcmpFhdkX0XtE4oWudL2yAHqlYT1tuZq9DDAg
	 PW/7G1WPL7TE490QYaaso7p81n/Otwa+s0bl/bIMt67ULBDUfdPEjnAAmMnR/+4qiO
	 f0Ef0Luf1PdSA==
Date: Thu, 16 Oct 2025 13:23:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <oholvk65xtm5wlyfbx7vsi4zpmbuvih3kqblfcvt2yrw6qr5wo@zzpghtqp6cg6>
References: <A1E3F83C-3AE8-43B7-9DCB-6C38C94F8953@xenosoft.de>
 <48F07B75-2DF3-4E9A-BC22-ADF1ED96DB06@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48F07B75-2DF3-4E9A-BC22-ADF1ED96DB06@xenosoft.de>

On Thu, Oct 16, 2025 at 09:36:29AM +0200, Christian Zigotzky wrote:
> Is it possible to create an option in the kernel config that enables or disables the power management for PCI and PCI Express?
> If yes, then I don’t need to revert the changes due to boot issues and less performance.
> 

Wouldn't the existing CONFIG_PCIEASPM_* Kconfig options not work for you? They
can still override this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

