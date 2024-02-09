Return-Path: <linux-pci+bounces-3284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37684F561
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7B41F24D56
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E21374CC;
	Fri,  9 Feb 2024 12:45:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453002E652;
	Fri,  9 Feb 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482758; cv=none; b=U6VXfU3LBsAoy91I4yxuel7/yygBuTIvxM2zYiDR4YZCRwcwF91rX+5UhbAYylkIxK7y2FrRFrxn10L+lYD8KYavxgEOPedRvCGOFEJZrjb7exlFtIoR+PUccqvUaNRM7DGej1YhvCnrftUaQRyoT5AUhokQ4xSDehbwQaqAYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482758; c=relaxed/simple;
	bh=qKBRPL7yrrIg5Y4ptXY2iWkD34ZgZJBHr1MKLFuQ17A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L0aUPCpbbAg8K3hthv14uIPYBC6CI93NWvC095BskAAQaA7FZeCqdRe4zX50pCMWUBqL7PYvcCWpcSdJtvILza9zhx7nUK77bZggKZEMwqge0H0/J4xr7sv0yOiiPWQfBs5hU/GOLxpKJYVmf00LG8I/1FftNsVo8sb7LrSdUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rYQGQ-0007It-0F; Fri, 09 Feb 2024 13:45:54 +0100
Message-ID: <45f23ab9-2086-419e-a23c-b689cd25a6f1@leemhuis.info>
Date: Fri, 9 Feb 2024 13:45:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI/ASPM locking regression in 6.7-final
Content-Language: en-US, de-DE
To: Linux PCI <linux-pci@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <76c61361-b8b4-435f-a9f1-32b716763d62@5challer.de>
 <20240102232550.1751655-1-helgaas@kernel.org>
 <ZZu0qx2cmn7IwTyQ@hovoldconsulting.com>
 <Za5JLxRC-K20sIfG@hovoldconsulting.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Za5JLxRC-K20sIfG@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707482756;4cf2fa77;
X-HE-SMSGID: 1rYQGQ-0007It-0F

On 22.01.24 11:53, Johan Hovold wrote:
> 
> So to summarise, this patch, which is now commit
> 
> 	f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
> 
> introduced a regression in 6.7-final for Qualcomm platforms (and some
> Intel platforms) similar to the one recently fixed by commit
> 
> 	f352ce999260 ("PCI: qcom: Fix potential deadlock when enabling ASPM").
> 
> #regzbot introduced: f93e71aea6c6

#regzbot fix: 1e560864159d00
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


