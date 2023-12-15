Return-Path: <linux-pci+bounces-1048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28EC8142E5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 08:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4021F21B5A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175910787;
	Fri, 15 Dec 2023 07:42:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CB10952;
	Fri, 15 Dec 2023 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rE2pW-0007pk-C4; Fri, 15 Dec 2023 08:41:54 +0100
Message-ID: <9bcfa8a1-3da3-461a-8873-bf3963f5ffbf@leemhuis.info>
Date: Fri, 15 Dec 2023 08:41:57 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US, de-DE
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702626122;af73442c;
X-HE-SMSGID: 1rE2pW-0007pk-C4

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 29.11.23 16:22, Fiona Ebner wrote:
> it seems that hot-plugging SCSI disks for QEMU virtual machines booting
> with UEFI and with guest kernels >= 6.5 might be broken. It's not
> consistently broken, hinting there might be a race somewhere.
> 
> Reverting the following two commits seems to make it work reliably again:
> 
> cc22522fd55e2 ("PCI: acpiphp: Use
> pci_assign_unassigned_bridge_resources() only for non-root bus")
> 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"

#regzbot fix: Revert "PCI: acpiphp: Reassign resources on bridge if
necessary"
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


