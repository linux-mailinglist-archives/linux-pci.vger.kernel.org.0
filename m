Return-Path: <linux-pci+bounces-20088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F571A15AC8
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 02:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113B7167A45
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A5249E5;
	Sat, 18 Jan 2025 01:03:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C957FC0B;
	Sat, 18 Jan 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737162237; cv=none; b=mXlUag/iKpJlv8gxvmIyjH3dIatg5yfcJSMvYDOxlRY+0gAko5eDfR1YZX/n2NKsoHtngDdnzdAfvVrIg2aN/kmQ2ZUzLSwh68z7EWwq8w9DUlzZy9FksD3Y5FBLbUtkhL/ooAt6PJD7CqlkRdArZky6HaTyme386Pxh1502rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737162237; c=relaxed/simple;
	bh=a7YjHMKzsXXxf4ie0q98uvqOuX34cL35hsERfMrpDdE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gofcN8/rgF9fWiTEVavh6OZXtEdaa/oYHrdjwYQTCd/4u2Lc5D7KoKSIjtqqHT9RNa6D13SqTqAwqgHBdMFHVAbqaLhEsGLv9qyb2Wj0IrCmlKwqR73HNs+e+lGyJaaTmNljwuVf2+IbP83xMv/ipe5lik2MUIl300EIg5Xk1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3735692009C; Sat, 18 Jan 2025 02:03:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 30E2392009B;
	Sat, 18 Jan 2025 01:03:47 +0000 (GMT)
Date: Sat, 18 Jan 2025 01:03:47 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiwei Sun <sjiwei@163.com>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org, 
    Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    jiwei.sun.bj@qq.com, sunjw10@outlook.com
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
In-Reply-To: <417720e7-c793-4c36-a542-a7e937e5a3cf@163.com>
Message-ID: <alpine.DEB.2.21.2501180101360.27432@angie.orcam.me.uk>
References: <20250115134154.9220-1-sjiwei@163.com> <20250115134154.9220-3-sjiwei@163.com> <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com> <417720e7-c793-4c36-a542-a7e937e5a3cf@163.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 17 Jan 2025, Jiwei Sun wrote:

> However, within this section of code, lnkctl2 is not modified (after 
> reading from register on line 111) at all and remains 0x5. This results 
> in the condition on line 130 evaluating to 0 (false), which in turn 
> prevents the code from line 132 onward from being executed. The removing
> 2.5GT/s downstream link speed restriction work can not be done.

 It seems like a regression from my original code indeed.

  Maciej

