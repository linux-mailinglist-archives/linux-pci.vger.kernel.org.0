Return-Path: <linux-pci+bounces-8069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C08D45EA
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 09:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67ADCB20CAF
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41F1C2A3;
	Thu, 30 May 2024 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ubpzFVbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28A7F;
	Thu, 30 May 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053527; cv=none; b=pTIqEvD5VQCHgdcPaAUnhIvjqllE+LlTxe0DSjDNDtWIJX7tJBSdW6zbG1MrZrMGGl12ehaaoHU6epcu8kuh2xp/RESTue+k1531hMWT6GTzjUJFCRgiu0HVcTM29pt4tELfgGkytgWXt2onWFyQHV0xz6uxVLg7cY0r0/qtLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053527; c=relaxed/simple;
	bh=Jlffi05sG7E24hiKq4xvGXSdBs5C7tsCEr5WRiQxi/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npx5pHMXTyClEULZSvS8uMXPOZv083Za4+tRQlHltGFHZ0Zdb55CHZAFiIOaLgshYgxkmu0oTEnlA3vTubxlBkCxcxNBtIn99qJCp36Vq1C3P5bpIJgYxd7vtdshf0Zv4DNIhrTKPwGYvIMZJgUw+fQxPXvFBt6c55hclPZ7qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ubpzFVbU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Jlffi05sG7E24hiKq4xvGXSdBs5C7tsCEr5WRiQxi/c=;
	t=1717053526; x=1717485526; b=ubpzFVbU9shmwG4mtL1MyPqZX2tS8pemsxo7n9sESOb2wXL
	GkBH1iOPiH+LMKktyJHNdOO8pR0sq4FluNepXJYRyWrKF9k9FXIbKBnr3SfxCLBrADYorgG0rdgO3
	nFmMgEwurW4ji+hFcEa/CNkcXiy1l7I6VEQb2hGgi2j4LCo+JAP5gYijpKEolKv+J4PSWUGbD4/Ex
	WBy7igAKKyI8Jm6EsajMGX8+OyKIkUDMWWjdENtcA0dz1LUDbqTUY8+77cARjz7QZCGv+le5PdkvZ
	55x4BGV0PeTqeY5BuSsOEwoeyTJJFLfV5GH918o/dWjEHnS/1RKQ2JJIVUXldXxA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCa3Y-0007Lh-V1; Thu, 30 May 2024 09:18:37 +0200
Message-ID: <93e4a06b-731d-4fe8-8ceb-e3b56d5ba2bd@leemhuis.info>
Date: Thu, 30 May 2024 09:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] BUG: KASAN: use-after-free in
 lockdep_register_key+0x755/0x8f0
To: Kalle Valo <kvalo@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 regressions@lists.linux.dev, Jeff Johnson <quic_jjohnson@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <87v82y6wvi.fsf@kernel.org> <87wmncwqxf.fsf@kernel.org>
 <87sexzx02f.fsf@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87sexzx02f.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717053526;689211b9;
X-HE-SMSGID: 1sCa3Y-0007Lh-V1

On 30.05.24 08:53, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
>> Kalle Valo <kvalo@kernel.org> writes:

> I found my mistake and was able to finish the bisect. This seems to be
> the commit causing my problems:
> # first bad commit: [7e89efc6e9e402839643cb297bab14055c547f07] PCI: Lock upstream bridge for pci_reset_function()

FWIW in case you missed that: there are a few other discussions related
to that commit already:
https://lore.kernel.org/all/?q=7e89efc6e*

And a patch with a Fixes: tag for that commit, too:
https://lore.kernel.org/all/171659995361.845588.6664390911348526329.stgit@dwillia2-xfh.jf.intel.com/

Ciao, Thorsten

