Return-Path: <linux-pci+bounces-29492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD5AD5FD0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7CB7A2564
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7C286D57;
	Wed, 11 Jun 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MHLCf4Nf"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CA322B5AD;
	Wed, 11 Jun 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672503; cv=none; b=V4ui7Lr/26gN1cQ/ekKWIgZL097YzjZ/be27gDK4qzPd55FoJy7pCGqCcb0syCnLlr/NxnzYZ4VUAkYu+VZkqvi3UWQot1gKsPIbUPVZ2U5hYCvtvVwPxB0wCl/RrB3TUjmZ/B6UqQDosgcplrYQpscH7l8yaf//DNFH8iH15TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672503; c=relaxed/simple;
	bh=9dte98wA25RugD7vFBF8pAYG1GDxBkzlGS+rfWj0mx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiI//wp3lG0Po6WGkrZmUkvRD7fSyKj0XPbi+9S6ILBtAR4fC55ydw0Q3JlOkmHfqz2YUIKgkr1VhS51quZg/dhShCP9kZPmi2jGd/9/hIUYaPHdUYgpWA5KGFtd5c8t+bWzt0WYwqhNZgipmKFJpzAPZdhZ7bOjbU8h5Hq690I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MHLCf4Nf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.14.36] (unknown [70.37.26.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id C91C82115191;
	Wed, 11 Jun 2025 13:08:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C91C82115191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749672501;
	bh=Un6/Vgv9rKYfD3CNjrrC2nZ3EzZZaYcSViwze4kSTew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MHLCf4NfqP/UAgaWBtH7FU8Jn0yaoZf/tKBPoHaAgrB3JHj/C/RnwyNmx0xH5AjA8
	 /MWXmrAmio0zrrhkvPK1HQ/3Le7FI+EFF6Ksod8YwX73MuJpUlx0fwnr8oau+jqqMc
	 K96tioVSeDktZYP91xpVXoXWJvwPikArxsCVzZ3g=
Message-ID: <1ccbaac5-7866-42f6-b324-cb9e851579e6@linux.microsoft.com>
Date: Wed, 11 Jun 2025 13:08:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
To: Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
 code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
 <aEj3kAy5bOXPA_1O@infradead.org> <aEku4RTXT-uitUSi@ryzen>
Content-Language: en-US
From: Graham Whyte <grwhyte@linux.microsoft.com>
In-Reply-To: <aEku4RTXT-uitUSi@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/2025 12:23 AM, Niklas Cassel wrote:
> On Tue, Jun 10, 2025 at 08:27:12PM -0700, Christoph Hellwig wrote:
>> On Wed, Jun 11, 2025 at 12:05:50AM +0000, grwhyte@linux.microsoft.com wrote:
>>> From: Graham Whyte <grwhyte@linux.microsoft.com>
>>>
>>> Add a new flr_delay member of the pci_dev struct to allow customization of
>>> the delay after FLR for devices that do not support immediate readiness
>>> or readiness time reporting. The main scenario this addresses is VF
>>> removal and rescan during runtime repairs and driver updates, which,
>>> if fixed to 100ms, introduces significant delays across multiple VFs.
>>> These delays are unnecessary for devices that complete the FLR well
>>> within this timeframe.
>>
>> Please work with the PCIe SIG to have a standard capability for this
>> instead of piling up hacks like this quirk.
> 
> There is already some support in PCIe for this.
> 
> For Conventional Reset, see PCIe 6.0, section 6.6.1, there is the
> "Readiness Time Reporting Extended Capability":
> "For a Device that implements the Readiness Time Reporting Extended Capability,
> and has reported a Reset Time shorter than 100ms, software is permitted to send
> a Configuration Request to the Device after waiting the reported Reset Time
> from Conventional Reset."
> 
> 
> For FLR, see PCIe 6.0, section 6.6.2, there is the "Function Readiness Status":
> "After an FLR has been initiated by writing a 1b to the Initiate Function Level
> Reset bit, the Function must complete the FLR within 100 ms. [...] If Function
> Readiness Status (FRS - see § Section 6.22.2 ) is implemented, then system
> software is permitted to issue Configuration Requests to the Function
> immediately following receipt of an FRS Message indicating Configuration-Ready,
> however, this does not necessarily indicate that outstanding Requests initiated
> by the Function have completed."
> 
> 
> Kind regards,
> Niklas

We can ask our HW engineers to implement function readiness but we need to be
able to support exiting products, hence why posting it as a quirk. 

