Return-Path: <linux-pci+bounces-23084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D5A55D71
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 03:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B071171686
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 02:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE75346426;
	Fri,  7 Mar 2025 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="Q0ZTWrag"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDF17C79;
	Fri,  7 Mar 2025 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313067; cv=none; b=c7tYxYVedVjJCIGGTaM7m+553G2+8vLuPCmwaAnIwHjN4/98VmniIqmD0oGKiYMtR68rJMylujSrj8z8gw5ypdFBWnrhWjaVJ9EOzqzpY1bQT2Zsfl5erCegpjFjkQLgMbaRCwGT5hSQMBaA4jT3MmoisY7d3mbss+Jv3USfhwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313067; c=relaxed/simple;
	bh=Zz1CxZkmtmg31tAg9LWsnMekLcNzLiU2onf7rKUwvjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEQn66FahEYe7ZLTxdGMKtXJH+OqK916vcs7aOitJJIvlqMB511Kbl6/HKed3kDzU9eQnbkHzImSkKQXJEH/W1K3bPeU/gKYB17Yvn412OjDFpohJMe+Ctitla/6wUmGlaSipd8fcYbbkYNUS8m28fqy1WkBlasT9gC3XjqNFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=Q0ZTWrag; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.189] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z88jg0kRkz4dCC;
	Thu,  6 Mar 2025 21:04:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1741313064; bh=Zz1CxZkmtmg31tAg9LWsnMekLcNzLiU2onf7rKUwvjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q0ZTWraggZoYusdIthxj4dwENxn4KSdq1+SPGfbeBbovgUlhmGSM1n92El+7bUDF8
	 9G45QZDr1IgYtpaeKDABSRrnagNddmiV73Y7aUbJgzqXgyddoR5gnTXE1T80a8oKF+
	 5iTEYCMTERUdV3R9ZYeKHNVZr0sMSPpGddfhYSo4=
Message-ID: <4cbde456-9a2e-4404-abff-3f3c53ed9d15@panix.com>
Date: Thu, 6 Mar 2025 18:04:21 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
To: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com> <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com> <Z8YKXC1IXYXctQrZ@wunner.de>
 <20250304082314.GE3713119@black.fi.intel.com> <Z8nRI6xjGl3frMe5@wunner.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <Z8nRI6xjGl3frMe5@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/25 08:45, Lukas Wunner wrote:

> Thanks for testing.  Would you mind giving the below a spin?
> I've realized this can likely be solved in a much easier way:

OK, I've tried all the scenarios that had failures with your original 
commit, and with your latest change I've not had any issues.

ACK :)

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


