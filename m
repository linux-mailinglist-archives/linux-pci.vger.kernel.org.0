Return-Path: <linux-pci+bounces-37984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6FBD6529
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E85613431D2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355CD1D88A4;
	Mon, 13 Oct 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/2LXsON"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99F219E8;
	Mon, 13 Oct 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389564; cv=none; b=U7SIgOrczD/gV4hBMKFicp+IGmCjqQ/BCpPIGER1ZPVuHPmmT1zAxbvHC4R6QMZKyFVt0PEHTYJaKkHAtGKp9b8ADoURFy+Jt+bvpQISewssaXFMM4ksRDNNGGlDVtqne8KKhefEaBpuw288zgxtYUhYuRjlOtDiJr3qGLFydy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389564; c=relaxed/simple;
	bh=gMimZXT46hTusGjQg/yFAkmHwf6pf0yukMIhp3DOs2U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GztzFPlY/QYwaScptTUrLJsLBUhEmMs1oPgs3aeOAQGkNfATWNSLKd3eKLdQeu+i+tfGy59MAcG4iOFC9U/dBRds8JjVsRwRUT2WvSC8Zy5tqyFjKfug9b5Z58g9hMdcVJZHhvZErQZhr42Cbs/hoNo5Mtny0Dzo8q2RwxuK1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/2LXsON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61775C4CEE7;
	Mon, 13 Oct 2025 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760389563;
	bh=gMimZXT46hTusGjQg/yFAkmHwf6pf0yukMIhp3DOs2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u/2LXsONWeMP2R8o7bZWhH9Q3uuAAPPdKPvYNpUDOneecaltzuMuzXFL4E6m7ZXxO
	 nB864Z2TSdkOrZdJSHYjZxzwCAzlETz+2jlVI6v/kQ/1bgevxKiH7cvMdSE7+m3a83
	 sIG632DRHu5kae8igKX3UUpcAjdarU1ZgVckLJ5GjFq+RHNXFX9QnBW6FoILU8Cy7v
	 bJe6E8VIO3uLfKjo+qJfq/zsCFKl3dV1A5YcivupeoiFJ0TSdUT9u5BrSKW5HHcwCx
	 jUX35n6WZmN89qcJ5tYAo1y7G3yTgchmiNqT/+aB+WTiOef1FIT7z8VTaBQ3U1B/PO
	 CwAsatACY/+rQ==
Date: Mon, 13 Oct 2025 16:06:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251013210602.GA864364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de>

[+cc Adrian, Lukas, Mani, regressions]

On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
> Hello,
> 
> Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
> 
> Without the pci-v6.18-changes, the PPC boards boot without any problems.
> 
> Boot log with error messages: https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
> 
> Further information: https://github.com/chzigotzky/kernels/issues/17
> 
> Please check the pci-v6.18-changes. [2]
> 
> Thanks,
> Christian
> 
> 
> [1]
> - https://wiki.amiga.org/index.php/X5000
> - https://en.wikipedia.org/wiki/AmigaOne_X1000
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92

#regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")


