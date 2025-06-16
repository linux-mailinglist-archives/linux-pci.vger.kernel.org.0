Return-Path: <linux-pci+bounces-29887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A4ADB94D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2F216AB1D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C111A23A9;
	Mon, 16 Jun 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QhhiY1he"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85921E2312;
	Mon, 16 Jun 2025 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100590; cv=none; b=lcn/LNQXD1A74AqfTuv9Y4RRSHudQLJm8e9/3M2XPEEnmkphA/lv99vSzx+q0ZVDKr2KGd7zLL1lr8itRPdpYyDtgglf4MmsW0JGGDH0IN83lGoByJGD1Xi4/pEjZD0P/97ktyPKXjggABTvO4Ly5N7XAxOLS/AcriHeVFLn7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100590; c=relaxed/simple;
	bh=TiGn5vLTbl/cgQnK+m/xLhluHVT+QlPWoPVKqHQbM7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBPmnsZc92IsaVAGfHpszBsNUMvhr5ok9o4+4FiJayVP9u3ltMWBG92lejCd/31SmLPYe9ljoSziMy1G5QcCndmaH1wxVnv2Rg8M9l1pfjQN81ZWNAK/FdFjBy1BPrfA/JH7V90ZwkDfvvdCvugvZJSXlwxfrowFq0YWZIHcIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QhhiY1he; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.32.75] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B9562115DDF;
	Mon, 16 Jun 2025 12:03:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B9562115DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750100588;
	bh=Ms/yjK19i4V4dUp6b/HkFTJmVTcWiMdjhEutCQP1Ui4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QhhiY1he/OSRHCqghlsYJW44c9cGf3ubQZ/wSbYDD1hPk4sbD0mV+0ZYfHFBuO+cq
	 ypYC7Mav5mJpnlUW3yk/q5qkT/7envmc6VsrgWSNAdyRmr/Yj1GfYxOXD7Xy14i36S
	 Tte9h9EuH+I2E/VnpnTpf3+4avI24JhfLv2AA93c=
Message-ID: <56b926e8-4b5c-45a8-882e-7c6be0e2fd26@linux.microsoft.com>
Date: Mon, 16 Jun 2025 12:02:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com, code@tyhicks.com,
 Okaya@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org
References: <20250613153304.GA959741@bhelgaas>
Content-Language: en-US
From: Graham Whyte <grwhyte@linux.microsoft.com>
In-Reply-To: <20250613153304.GA959741@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2025 8:33 AM, Bjorn Helgaas wrote:
> On Thu, Jun 12, 2025 at 09:41:45AM -0700, Graham Whyte wrote:
>> On 6/11/2025 11:31 PM, Christoph Hellwig wrote:
>>> On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
>>>> We can ask our HW engineers to implement function readiness but we need
>>>> to be able to support exiting products, hence why posting it as a quirk.
>>>
>>> Your report sounds like it works perfectly fine, it's just that you
>>> want to reduce the delay.  For that you'll need to stick to the standard
>>> methods instead of adding quirks, which are for buggy hardware that does
>>> not otherwise work.
>>
>> Bjorn, what would you recommend as next steps here?
> 
> This is a tough call and I don't pretend to have an obvious answer.  I
> understand the desire to improve performance.  On the other hand, PCI
> has been successful over the long term because devices adhere to
> standardized ways of doing things, which makes generic software
> possible.  Quirks degrade that story, of course, especially when there
> is an existing standardized solution that isn't being used.  I'm not
> at all happy about vendors that decide against the standard solution
> and then ask OS folks to do extra work to compensate.
> 
> Bjorn

Hi Bjorn,

Should someone want to implement readiness time reporting down the road,
they'll need to do the same work as patch 1 in this series (making the
flr delay a configurable parameter). This change lays the groundwork for
that work, while also supporting devices that can't use readiness time
reporting.

Alternatively could we use a sysfs file to make this parameter
configurable via the user space application? Similar to switching between
d3hot and d3cold by writing to /sys/bus/pci/slots/$DEVICE/power.

Thanks,
Graham


