Return-Path: <linux-pci+bounces-33499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD8B1CF64
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 01:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8290118C0EE2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A422D7B1;
	Wed,  6 Aug 2025 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="BAn6RRZ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7D54279
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522805; cv=none; b=mu4Gpygx6CySKCpAFU6g73MYti8vMfxQd5+IymUebhBeJnnDc85rG6e54hj3+oCysJSCvQGIbCy4IqbaHZer9D8f86GHcCXba7Y2KB9etuzXHZ1F/iHwVDczNt+0CxBBTbe6Z0fwV0abLP6/k0qSB+Z5ZIH6hKuAdyP62NPbw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522805; c=relaxed/simple;
	bh=0bEUAwJ+E/DG1UgaHeYswoeGDyp/OjhCufHN4xPdSaU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=P4p2QspyS8YNyUKCiGnRSy8s6YUibNuGsHw01QpAQyoFY0hhfzssMg2n9CoIFMQvTx7+rNFMuYVAHR32MwnAVL6DN4em8i4+Tr7+lkO2uo1BzDcwBIRjpN4oFoloxu9uprJoJhyjmps5XDB3jH1WYnKE7TBseSUGQ1nW0G+H4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=BAn6RRZ+; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4by5Y663LFzDS9
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 19:07:38 -0400 (EDT)
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4by5Xy6zMYz4N3T;
	Wed,  6 Aug 2025 19:07:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1754521651; bh=0bEUAwJ+E/DG1UgaHeYswoeGDyp/OjhCufHN4xPdSaU=;
	h=Date:To:Cc:From:Subject;
	b=BAn6RRZ+N3JERm6f1fT0cOyiP4LaYHabgGM+v+1MKnMptlpIEtqSS4qKadEUzBmDU
	 K7Va9hFOnwya0aFGAjM5LsdWZS8bevU/tK5YuIWbZxQ2Per1D49ztmsszBmv+sBZzW
	 O7VbvBjSiFn0Kw4jFgAsS3BbJGDNr9ZpyyYyuB4E=
Message-ID: <dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com>
Date: Wed, 6 Aug 2025 16:07:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: namcao@linutronix.de
Cc: Me <kenny@panix.com>, mani@kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
From: Kenneth Crudup <kenny@panix.com>
Subject: Commit d7d8ab87e3e ("PCI: vmd: Switch to
 msi_create_parent_irq_domain()") causes early-stage reboots on my Dell
 XPS-9320
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I'm running Linus' master (as of today, cca7a0aae8958c9b1).

If I revert the named commit, I can boot OK. Unfortunately there's no 
real output before the machine reboots, to help identify the problem.

I have a(n enabled) VMD in my Alderlake machine:

[    0.141952] [      T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) 
i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)

If there's something else I can try, let me know.

Thanks,

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


