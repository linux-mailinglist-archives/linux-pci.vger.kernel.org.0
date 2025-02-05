Return-Path: <linux-pci+bounces-20780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568EA29C19
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D938E166A83
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805621505F;
	Wed,  5 Feb 2025 21:48:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1514F9FD;
	Wed,  5 Feb 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792139; cv=none; b=PHTByazRCM4je6a5DzMQC5/QDs9aoavlplGbe2ZCoIIIiGxlT1u9pehYyMLDlR63TTZGU9d7+cCjf0IjJq57z/hJZ3MY/EbFnaJHQjmHojgaqWMVM/EFYOFxuxGw7eEaXbRZd+/lqSjeYNZ2YTzUqi4vKgZO1v1jmcoD0uoVDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792139; c=relaxed/simple;
	bh=HGlN6Lerm3dgGJK7wrSbhUF1CVnE4TgF1Bj6J2HcwDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jshRCLEpafAOhLJTu8T/nemG9B+bHJxsd6pukuRGyzCAYcId/pDnwZyQZoL8wX1lJbjoCBflWEW5DXFrGqLdR918ApTAWEGWsPoBhFY8Sb1+/zKCxY0Rsi18Xb45GtjXIk1HyPd50nVQazTK8Lt/xBELJxVTLDW0X2vYKrzZckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.59.18.202] (p57a7ad4d.dip0.t-ipconnect.de [87.167.173.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6C6F761E64795;
	Wed, 05 Feb 2025 22:48:25 +0100 (CET)
Message-ID: <e30f47ea-396e-45c7-a2aa-d141d27dae4c@molgen.mpg.de>
Date: Wed, 5 Feb 2025 22:48:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `rtsx_pci 0000:3b:00.0: PM: dpm_run_callback():
 pci_pm_resume returns -110`
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <d7246feb-4f3f-4d0c-bb64-89566b170671@molgen.mpg.de>
 <027efc9e-bc70-49af-7d48-fb474533993d@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <027efc9e-bc70-49af-7d48-fb474533993d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ilpo,


Thank you for your instant reply.


Am 05.02.25 um 09:44 schrieb Ilpo Järvinen:
> On Tue, 4 Feb 2025, Paul Menzel wrote:
> 
>> #regzbot introduced: b46c89c08f41..aa22f4da2a46

>> On the Intel Kaby Lake laptop Dell XPS 13 9360, at least Linux
>> 6.13.0-07632-gaa22f4da2a46 logs the new warnings:

(Just a side note, these are actually logged with level error.)

>>      rtsx_pci 0000:3b:00.0: Unable to change power state from D0 to D3hot, device inaccessible
>>      rtsx_pci 0000:3b:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110
>>      rtsx_pci 0000:3b:00.0: PM: failed to resume async: error -110
>>
>> These were not present up to including Linux 6.13.0-07078-gb46c89c08f41.
>>
>> It looks like the first warning is not always logged:
>>
>>      $ sudo dmesg | grep rtsx
>>      [    8.612537] rtsx_pci 0000:3b:00.0: enabling device (0000 -> 0002)
>>      [ 2010.081170] rtsx_pci 0000:3b:00.0: Unable to change power state from D0 to D3hot, device inaccessible
>>      [ 2010.236503] rtsx_pci 0000:3b:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110
>>      [ 2010.236525] rtsx_pci 0000:3b:00.0: PM: failed to resume async: error -110
>>      [ 4115.541202] rtsx_pci 0000:3b:00.0: PM: dpm_run_callback(): pci_pm_resume returns -110
>>      [ 4115.541216] rtsx_pci 0000:3b:00.0: PM: failed to resume async: error -110
>>
>> Logs from Linux 6.14-rc1 are attached. Bisection is only possible after next
>> Sunday.
> 
> Please try if this fix helps:
> 
> https://lore.kernel.org/linux-pci/20250131152913.2507-1-ilpo.jarvinen@linux.intel.com/

Yes, after applying the patch these errors were *not* logged in three 
ACPI S3 suspend/resume cycles.


Kind regards,

Paul

