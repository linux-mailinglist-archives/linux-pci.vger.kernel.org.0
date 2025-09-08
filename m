Return-Path: <linux-pci+bounces-35702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D062EB49C6B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915584E33FD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001D23BCEF;
	Mon,  8 Sep 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6u59PSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDA22A4D5;
	Mon,  8 Sep 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368357; cv=none; b=SrHUPMoXCGA9StkO6wee5Ij5ytdAHqh8gvLBrraVkKRHbqvtIufuB6bqBwgPwtOHw+AmA/KHKGBRmmZlkfbVlQEgvkIMxxtT1QznJb96Oyr3PcHsq6+AZzM/nRVRGpxwG00SuFA1n4EdpzpxLsfV1NYy9u61McOQTdRD1rvA3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368357; c=relaxed/simple;
	bh=UjtDIvZYjEWZH3kRKI9614LSSjakj2QKhQXXNwaBl8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsIXuIVKUVa62u6QRaRAC8Yrr8o7s3TckKN6nC5KHVK89lTpqdBlBsFOL2vjMVlrkSuIiOHkWPHu8q7WXTWojGU0FlhCroGPeLR0VnA7hOPaqRwVaT1TLDZ73QMBGcrG188c03iKiu5ukCH0QPnf6FYbFD1TMcAk9r4yloo49zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6u59PSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F265BC4CEF1;
	Mon,  8 Sep 2025 21:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368356;
	bh=UjtDIvZYjEWZH3kRKI9614LSSjakj2QKhQXXNwaBl8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H6u59PSMlbvOILddp3WNHEOz866E9hf3I8aIPPd/b3tAl9UOaJ9JqB9nXZmNPWEyC
	 ZBfwsiyRjOL2HFWv/wd4w7kdVGXizhaEUVFi3xTW22Pm2gm5qTyPKy3Ghmx3KmFl1Z
	 mGvtUlmCct7ht3TYjNYWupt4vz5mkafScBDxTZQRfU6aPm65zbqHL5ZZi1ZUZooYzL
	 RWa7RoSe2SVBeEuWpMK5o72EPxJPrCc67Qd+LhJrKVHtB+CqoD1OOt7st7hAN5+4kR
	 h6j55QnMspz2Pk83fm0TsoRwvGdPH2oPQ4Vh4UtwdtgH6+2huzP5yFbtNTWBho5EWO
	 wYx3jQwCsiFHQ==
Message-ID: <f33c93cd-92c6-49c9-aa83-9f46841c5879@kernel.org>
Date: Mon, 8 Sep 2025 16:52:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/11] PCI: Put PCIe bridges with downstream devices
 into D3 at hibernate
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Eric Naim <dnaim@cachyos.org>, Denis Benato <benato.denis96@gmail.com>
References: <20250908215031.GA1467002@bhelgaas>
Content-Language: en-US
From: "Mario Limonciello (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250908215031.GA1467002@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2025 4:50 PM, Bjorn Helgaas wrote:
> On Sun, Aug 17, 2025 at 09:00:59PM -0500, Mario Limonciello (AMD) wrote:
>> For the suspend flow PCIe bridges that have downstream devices are put into
>> the appropriate low power state (D3hot or D3cold depending upon specific
>> devices). For the hibernate flow, PCIe bridges with downstream devices
>> stay in D0 however. This can lead to PCIe bridges that are remained
>> powered on needlessly during hibernate.
> 
> s/are remained/remain/ I guess?

Yeah, I'll adjust.

> 
>> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
>> pci_pm_suspend_noirq() by using pci_pm_suspend_noirq_common().
>>
>> This introduces a functional change that the hibernate flow will now
>> call pci_save_state() and unless bus PM is skipped will also set
>> the PCIe device into an unknown state.


