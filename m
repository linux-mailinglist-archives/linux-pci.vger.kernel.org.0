Return-Path: <linux-pci+bounces-38487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59434BE9B53
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE7B1AE10C8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21532C941;
	Fri, 17 Oct 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjzG1vrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA31D5CE0;
	Fri, 17 Oct 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714254; cv=none; b=UqeMbd770WDxvtR71PSPVHjyz22FdS4oGtXZU4MhKa+nJOh2UmfN96pXv8LxOQ79fCJYOeQqLqTAcy/sGsvdz58yff3drMPsp5lJAbTmsltkX4GrZwwgKmv6e/0MS+yXdjZzsxOmMjL3807Vtw/7nLKN7e344B4r929g9TXpsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714254; c=relaxed/simple;
	bh=UELNKYaVfuic64Q2TAthiZ0D/w24Xzmlvf+JP/ejdcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgSXQB5iA7wwAfU0cRlxAo+TFJ44pca/zXBlUTK1RtWlEeWhmEfrEWnsiCdGp4FOLmne7kIIQsiXkGwVK1rwl074+XVKLTiPNQOLei1TsnaaDTYUwMQ+NdaSttDxNZNhGXngvPWorS+LB3E0cxJ+CQB5oEHYRhMB4CC97wqqEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjzG1vrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C928C4CEFE;
	Fri, 17 Oct 2025 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760714254;
	bh=UELNKYaVfuic64Q2TAthiZ0D/w24Xzmlvf+JP/ejdcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjzG1vrtjafVsJEfJLgW80QEFGVUAVTdJGBCdoy+5jZnY1/DFYZz1ByQaK5GWPyhL
	 Owt/47qNWgZkADS+7hOSY9LtM6z6yBuOM962KpKFSl+8Q7NhYoM4XbY3qzWXE0+iMH
	 ZA25pMI02VQbRcDl3ro4C+fYfaLkwpRW5Cqea+BhXXz+7838TJUxRvvOxpdXefI3Tn
	 TCdcgReh80zCu8rkKgQsSKnUmBGSsiS99M8Tt5WJXRuVaLqQfDQToGVKZ7bnbbVNxp
	 xkKPv2x0O1mOupQSBzoZCfZyfL+jWwqfHCA3E4NmVVhgciMQMiexZ5BWIVBivHqPdu
	 9dudKMddAEJsg==
Date: Fri, 17 Oct 2025 20:47:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ron Economos <re@w6rz.net>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Conor Dooley <conor@kernel.org>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, Paul Walmsley <pjw@kernel.org>, 
	Greentime Hu <greentime.hu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	regressions@lists.linux.dev
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
Message-ID: <v5ziiexkr5tncfocmxtke52kewdjhaxq3mrz3bh52p35ercjzm@vpxhbsxgnqrc>
References: <20251013212801.GA865570@bhelgaas>
 <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
 <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
 <759e429c-b160-46ff-923e-000415c749ee@oss.qualcomm.com>
 <b203ba27-7033-41d9-9b43-aa4a7eb75f23@w6rz.net>
 <yxdwo4hppd7c7lrv5pybjtu22aqh3lbk34qxdxmkubgwukvgwq@i4i45fdgm6sw>
 <18ef2c73-fb10-47b3-838f-bc9d3fd2dbc2@w6rz.net>
 <xfpqp3oign7c3336wxo5yexgitxotttrxgkyzbfknjmfk6pmdc@drsk3ardfl5t>
 <432e4026-208f-459e-82dc-e74ef5da6a87@oss.qualcomm.com>
 <6bf478b8-2194-4ffb-aaac-8e3e314ad71c@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bf478b8-2194-4ffb-aaac-8e3e314ad71c@w6rz.net>

On Fri, Oct 17, 2025 at 07:21:06AM -0700, Ron Economos wrote:

[...]

> > Hi Ron,
> > 
> > Can you try with this series and let us know if it is helping you or
> > not.
> > 
> > https://lore.kernel.org/all/20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com/
> > 
> > 
> > - Krishna Chaitanya.
> 
> The patch works good. Here's the log of PCI messages.
> 
> [    3.221506] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
> ranges:
> [    3.221594] fu740-pcie e00000000.pcie:       IO
> 0x0060080000..0x006008ffff -> 0x0060080000
> [    3.221658] fu740-pcie e00000000.pcie:      MEM
> 0x0060090000..0x007fffffff -> 0x0060090000
> [    3.221696] fu740-pcie e00000000.pcie:      MEM
> 0x2000000000..0x3fffffffff -> 0x2000000000
> [    3.221783] fu740-pcie e00000000.pcie: ECAM at [mem
> 0xdf0000000-0xdffffffff] for [bus 00-ff]

As a nice side effect of the regression fix, your platform is now using ECAM
mode by default :) Thanks for testing.

I hope Bjorn will merge this series for 6.18-rcX.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

