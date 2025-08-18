Return-Path: <linux-pci+bounces-34191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3DB2A046
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E043B43D4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD1A31815A;
	Mon, 18 Aug 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXPhIcpr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D221322F;
	Mon, 18 Aug 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516246; cv=none; b=WY4fTciQf8rmK6g6xRnl0LwBvo0Q4Hq8czucBQGRYg+RyvqQT7IeGbuDs5tkUCHVkOe7ik5xgAxOCtHEZyu1HdBa6VgGCL+VjRmCTqVThCzF6bx6FrVDLAqpiLTZztsJGHHLb088sFwC4JU39i9KZUC9a4U/vykX83nh94o1zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516246; c=relaxed/simple;
	bh=S8fx28ZOFv/aRwZ2Xxu1HcW0LeO59Bf0W+4lw52lHUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJE0TKSJUi2FNBr19dhvBWPxC6xL4MwXwOSiewpXUASFDNJG1Dd1IwJ2eSJfohvPFU9VTIm+HJ2RH72FxS1Fxpm9j5gCsXGholuj2fCgPu6NQKyuobGFdxQKUYqXWUStntiK338d1eYqoXd5pTzRYcwbXE3wyJ3HHzbw0mhHJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXPhIcpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E674C4CEEB;
	Mon, 18 Aug 2025 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516246;
	bh=S8fx28ZOFv/aRwZ2Xxu1HcW0LeO59Bf0W+4lw52lHUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tXPhIcprcunHMleGFLIvoG1s0XiCUEY2N9lcE3i6sadmegRADVYTVBlq3c242EyOX
	 8sNT3sdezjIpZqJpS4aioZ0DzojutaxSXEkpDyl8YOKEf2N5wefVvj4kwhUYaPX+j3
	 dHhf2o/643YaqP84+2K2k2IF0Qrq3BXNbXM+FO8xZU7AjwXHhN8A9Qb/uEWuKjMg6L
	 GtNb96H8fqsjP/nYrP2xTdw5csi276T6jCX8kZF08Ijf2y1Dji/QvjrjOOo7vsau6z
	 u2B5jxc3FCK33EQ6d73QTTJUQgqHoHJqiYw55TUuk1GsHsCPH66WZeGrRlH1oFirNL
	 5Ej4ll1/hIcUA==
Message-ID: <4574e72d-5cc3-4ad2-beab-78dbeb34d42f@kernel.org>
Date: Mon, 18 Aug 2025 06:24:00 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] USB: Pass PMSG_POWEROFF event to
 suspend_common() for poweroff with S4 flow
To: Oliver Neukum <oneukum@suse.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 Eric Naim <dnaim@cachyos.org>
References: <20250818020101.3619237-1-superm1@kernel.org>
 <20250818020101.3619237-5-superm1@kernel.org>
 <a1cf393a-9901-469b-90f4-81211f2e1b9b@suse.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <a1cf393a-9901-469b-90f4-81211f2e1b9b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/18/25 5:50 AM, Oliver Neukum wrote:
> On 8/18/25 04:00, Mario Limonciello (AMD) wrote:
>> If powering off the system with the S4 flow USB wakeup sources should
>> be ignored. Add a new callback hcd_pci_poweroff() which will 
>> differentiate
>> whether target state is S5 and pass PMSG_POWEROFF as the message so that
>> suspend_common() will avoid doing wakeups.
> 
> Hi,
> 
> how will Wake-On-LAN work with this change?
> 
>      Regards
>          Oliver
> 

 From S5 using a USB dongle?  Is this a use case that is intended to 
work today?  Does it?

I had expected this only intended from S4, S3 and s2idle.

