Return-Path: <linux-pci+bounces-12171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1C295E35F
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 14:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B165B21F95
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 12:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6D13D281;
	Sun, 25 Aug 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8fL7pGB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5C74076;
	Sun, 25 Aug 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589468; cv=none; b=pwX+V0MkQNn45HJnFvKujqBULBhhXzDPofi64zV0httgmo+bHJPgbRhuRi/kqnoa5EPMwxkZ2SzOwNetk62sAxt0jakY6iq03Jz3v6J6HeoIFuczhv2f1NpaiVSL46FI7MkxFkFqg8/vUQbQ3BVYjrBq4vnx4l2Rc2y1ah9z4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589468; c=relaxed/simple;
	bh=ehb4C4WLmyUJs/6wpAK5MGPHln+w8i78S61mk5Dy0Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSQ1gFr4czor+t/4l9C+gGzCZ5ml/rlwjwdUZE/Nxm3SIsDcKhxrqc7CWkCM1QzmhQiaGbmdBcTeB0VgMBTprDEiS1+drvS63Q5GgIrFR5Cchbt6CxMBZFyW0cUqWFxWAXX8gbcGGeXgrCnZA5W47xOU57MG8ZkTbD/b6sJ6a7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8fL7pGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99F6C32782;
	Sun, 25 Aug 2024 12:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724589468;
	bh=ehb4C4WLmyUJs/6wpAK5MGPHln+w8i78S61mk5Dy0Qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H8fL7pGB4Tyv4QF/tTKBsOFJO25D/8OEzzgIqEP481LY/IToFchHlucyskmROfoht
	 azAtUGdaEGxqVG7fNpBPhMJthdYxRD3jY+U7U9issHIAiNdiBY/6kY1YR38fHaLQtl
	 sHpOe+hM5n8vFGhneIQMO/0bkrrosbsUj3uePba5Ro/Y2F8u6cOKJxHHPWCEk9HCPo
	 uNaOcHheCXmOoabjKxxEWKxOSm8B0P5K4/W6/Wd7cZ+RLfmdGG5/6tTuidvcua82T+
	 M6AM4a5HD23Ezu0OAGpd6Vx9Cc34PpHRMrnPF7o2d2fE+2oVbl4btUqJ7/G+NOjTmE
	 34QkaOUgcBwDA==
Message-ID: <979c3fc3-33d3-49fa-af80-52ec09325a08@kernel.org>
Date: Sun, 25 Aug 2024 07:37:45 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsc: Use rdtsc_ordered() when RDTSCP or LFENCE_RDTSC
 are supported
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240823042508.1057791-1-superm1@kernel.org>
 <20240823042508.1057791-3-superm1@kernel.org> <8734msg5ce.ffs@tglx>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <8734msg5ce.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/24 07:22, Thomas Gleixner wrote:
> On Thu, Aug 22 2024 at 23:25, Mario Limonciello wrote:
> 
> Why is this hidden in a reply to the middle of a PCI patch series?
> 
> Sigh.

As I mentioned in my reply I didn't mean for this to go out at this 
time.  Sorry for the noise!

It's still under testing that it REALLY helps things.
It was in my working directory and I totally missed it when I sent this 
PCI series.

> 
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> On AMD processors the TSC has been reported drifting on and off for
>> various platforms.  This has been root caused to becaused by out of order
>> TSC and HPET counter values.  When the SoC supports RDTSCP or LFENCE_RDTSC
>> use ordered tsc reads instead.
> 
> This really wants a fixes tag.

Yes; assuming it really helps I will send it properly with tags and to 
the right lists.

