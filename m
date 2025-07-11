Return-Path: <linux-pci+bounces-31926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E5DB01BCD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 14:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5009C1CA7CD8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38E29A32A;
	Fri, 11 Jul 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilwu63lF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C4299AA9;
	Fri, 11 Jul 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236140; cv=none; b=JoKzE+j/HUOuWcUUesNMMBfS3I+qC2bVDD9hjEf/ldCFy3ERQYr31fc2dl3lsimMd/jRpSLCW+Woqtvv+xq1WSUh1ZpmgjXBvD2nuYK80Zfcg5ts6ac9OtYqt8KnQenKO4vdvYyVMRWsPgBBLzBSPPMiBNAu1JIdjw9fG4jf3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236140; c=relaxed/simple;
	bh=n82RM4cgT4El7yNKeOkJ1+B9gFq+IBgDJwiJGDyoQKw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W+Wzf/pNgiWd5kuupp6VkllRIZDR3DkGH+1pSrtmxxssCXPFHeIPyBPLfMgavS4C0VzEuxpYjDNPhyVXBxqEvChxJlp2Z9VtsOz3360t3MrJE26PsFYjVAoGVSqpP3uiuREFwj8wSAviLrs8FCjsmPHJvFahI568qjTdjair4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilwu63lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC62C4CEED;
	Fri, 11 Jul 2025 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752236138;
	bh=n82RM4cgT4El7yNKeOkJ1+B9gFq+IBgDJwiJGDyoQKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ilwu63lFCyYgGCXpzoljE+Ssp/LjbyGVktjqkhe+S5vf8WIYt7R/1iHH6nC9IYpeA
	 EdfwpsLFcWOrzMG5Juf5bLwjvC/feIl6gtjDVaA2TLTFL+wtS7riYM33x722uYj6Vx
	 F9yOIimLMfCqg27rzoHqdggfrY/JFn3HUFWQCcN4GUIYYkfeQUqosBqEyMRVpKEBAi
	 smbmkHQXo+rpfwcXwSUHjQ9ZCODE7C2pE0XJdB3EYNh0II9jPPSxwguXeUgDHSnBVP
	 dlBsXWSjJg11MpoMcum2NRMu9SWjdJqHk/8htJFweRk0lp3dYqXTNIyaokJyzPjeCb
	 kj5Gb/1ABU+xw==
Date: Fri, 11 Jul 2025 07:15:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
Message-ID: <20250711121537.GA2289649@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmM+Qj=TA=WtQAXQZx6wCUpdsOQ4j66Kpyze3KNZHC79KfyRA@mail.gmail.com>

On Fri, Jul 11, 2025 at 12:36:12AM +0530, Bandhan Pramanik wrote:
> Ok, we did it. Could reproduce the errors properly.
> 
> Here are the journalctl logs:
> 
> Kernel level: https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180/raw/a9e93c4ba41fb0b3d7602e6bfddce9aa5f3a19b2/KERNEL%2520journalctl%2520v6.16-rc4
> User level: https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180/raw/a9e93c4ba41fb0b3d7602e6bfddce9aa5f3a19b2/NON-KERNEL%2520journalctl%2520v6.16-rc4

Thanks.  These logs look like the kernel doesn't include the patch I
sent at https://lore.kernel.org/r/20250705195846.GA2011829@bhelgaas

Can you please try with that patch?

> Just so you know, I have used v6.16-rc4.
> 
> Bandhan.
> 
> On Wed, Jul 9, 2025 at 11:00 PM Bandhan Pramanik
> <bandhanpramanik06.foss@gmail.com> wrote:
> >
> > Hello,
> >
> > I was actually a bit distracted by the things caused by the Automatic Partitioning of Fedora. I'll inform that in Fedora Bugzilla... anyway.
> >
> > I realised that making the modules will take 8-9 hours, I didn't even have much of a success (because all the modules didn't properly load, particularly the firmware-N.bin files couldn't be found).
> >
> > But I'll try to recompile the kernel, I'll just have to give it overnight time.
> >
> > Bandhan

