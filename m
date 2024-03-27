Return-Path: <linux-pci+bounces-5212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967188D536
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 04:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A009F1F2EB42
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988422EF3;
	Wed, 27 Mar 2024 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxqHrO38"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBCE22616;
	Wed, 27 Mar 2024 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511435; cv=none; b=eljMHelg/2E5bZ7JXZYyhZXYFQSHGg/ydsqPe7WQ7s4YGPz69yu9j2fkqRRk92qYsMHYDKXBsALBSAIiNuw52K+trXOMgHkmuYopYIg7I+Bpx+GHlQZjpQPtD2uwXb5rrs1qPcLfIoEPOnTYCX07JhcA2LO0GqCnXwe0X8SiLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511435; c=relaxed/simple;
	bh=8FuvHj1lo7MqFCoSr7VmIEgHXsnZYyUvy3bJUnQm6yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQ4OFF0txsF+g2BZa2/4HRvnKM4M1Rl6fblXuNb+TWb3FbrQWv41W8zFlnuSznXHqUinRjk6FGkjN6h677kJdZHSJHL7TMTxjvgY3DAkhQJyboG4/QBd2aez5ef40PSvJC5GNVE4cfmbE2GL1bHHUBmDtWIHdOcmjoZT1MygiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxqHrO38; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711511434; x=1743047434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8FuvHj1lo7MqFCoSr7VmIEgHXsnZYyUvy3bJUnQm6yI=;
  b=BxqHrO38YtHJ9zC1mgQUCw+yujzgwou92LtLD5YDTCm2+fKcL37W3wm8
   Maeta4GM8L0jYD56OrGFgmZbw46NBgnEXC8DYDIdhDMUg+j7gRcbxUBVn
   Jxv23S8H22zaAJ2n2lSXyucQDLTYZ5Qe9BF/Q2M6RBYvfg+BTqrBUF5JV
   A17DbJKw/sJd6rGXRpFl0adv3Ks8pw4bu/S+6b/Ad2KQTi1IjgU2KzlLB
   a4r/IGYzSh9xy0U6Ky4Jywi2aAKC65UX+MuZz3q2eTRmSt8CzfzxBpUoY
   1Vq03D4/B36cSB8629r+YO7uhzmC8rv4SGBtHxlQ/Zg/uSuse2fiNzVK/
   g==;
X-CSE-ConnectionGUID: 7mwmToZtSb2O5iri4IJnyg==
X-CSE-MsgGUID: YFuImnXbSK6bB4vvdIJDmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6449941"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6449941"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16095770"
Received: from zjiang7-mobl.ccr.corp.intel.com (HELO [10.254.212.75]) ([10.254.212.75])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:50:10 -0700
Message-ID: <ac855191-1289-40f5-b910-fb9558d5df76@linux.intel.com>
Date: Wed, 27 Mar 2024 11:49:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Grant Grundler <grundler@chromium.org>,
 bhelgaas@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mahesh@linux.ibm.com, oohall@gmail.com, rajat.khandelwal@linux.intel.com,
 rajatja@chromium.org
References: <20240326211705.GA1497507@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240326211705.GA1497507@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/2024 5:17 AM, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2024 at 09:39:54AM +0800, Ethan Zhao wrote:
>> On 3/25/2024 6:15 PM, Xi Ruoyao wrote:
>>> On Mon, 2024-03-25 at 16:45 +0800, Ethan Zhao wrote:
>>>> On 3/25/2024 1:19 AM, Xi Ruoyao wrote:
>>>>> On Mon, 2023-09-18 at 14:39 -0500, Bjorn Helgaas wrote:
>>>>>> On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
>>>>>>> ...
>>>>>>> My workstation suffers from too much correctable AER reporting as well
>>>>>>> (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
>>>>>>> Generate Correctable Errors" and/or the motherboard design, I guess).
>>>>>> We should rate-limit correctable error reporting so it's not
>>>>>> overwhelming.
>>>>>>
>>>>>> At the same time, I'm *also* interested in the cause of these errors,
>>>>>> in case there's a Linux defect or a hardware erratum that we can work
>>>>>> around.  Do you have a bug report with any more details, e.g., a dmesg
>>>>>> log and "sudo lspci -vv" output?
>>>>> Hi Bjorn,
>>>>>
>>>>> Sorry for the *very* late reply (somehow I didn't see the reply at all
>>>>> before it was removed by my cron job, and now I just savaged it from
>>>>> lore.kernel.org...)
>>>>>
>>>>> The dmesg is like:
>>>>>
>>>>> [  882.456994] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
>>>>> [  882.457002] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
>>>>> [  882.457003] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
>>>>> [  883.545763] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
>>>>> [  883.545789] pcieport 0000:00:1c.1: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>>>>> [  883.545790] pcieport 0000:00:1c.1:   device [8086:7a39] error status/mask=00000001/00002000
>>>>> [  883.545792] pcieport 0000:00:1c.1:    [ 0] RxErr                  (First)
>>>>> [  883.545794] pcieport 0000:00:1c.1: AER:   Error of this Agent is reported first
>>>>> [  883.545798] r8169 0000:06:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Transmitter ID)
>>>>> [  883.545799] r8169 0000:06:00.0:   device [10ec:8125] error status/mask=00001101/0000e000
>>>>> [  883.545800] r8169 0000:06:00.0:    [ 0] RxErr                  (First)
>>>>> [  883.545801] r8169 0000:06:00.0:    [ 8] Rollover
>>>>> [  883.545802] r8169 0000:06:00.0:    [12] Timeout
>>>>> [  883.545815] pcieport 0000:00:1c.1: AER: Correctable error message received from 0000:00:1c.1
>>>>> [  883.545823] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
>>>>> [  883.545824] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
>>>>>
>>>>> lspci output attached.
>>>>>
>>>>> Intel has issued an errata "RPL013" saying:
>>>>>
>>>>> "Under complex microarchitectural conditions, the PCIe controller may
>>>>> transmit an incorrectly formed Transaction Layer Packet (TLP), which
>>>>> will fail CRC checks. When this erratum occurs, the PCIe end point may
>>>>> record correctable errors resulting in either a NAK or link recovery.
>>>>> Intel® has not observed any functional impact due to this erratum."
>>>>>
>>>>> But I'm really unsure if it describes my issue.
>>>>>
>>>>> Do you think I have some broken hardware and I should replace the CPU
>>>>> and/or the motherboard (where the r8169 is soldered)?  I've noticed that
>>>>> my 13900K is almost impossible to overclock (despite it's a K), but I've
>>>>> not encountered any issue other than these AER reporting so far after I
>>>>> gave up overclocking.
>>>> Seems there are two r8169 nics on your board, only 0000:06:00.0 reports
>>>> aer errors, how about another one the 0000:07:00.0 nic ?
>>> It never happens to 0000:07:00.0, even if I plug the ethernet cable into
>>> it instead of 0000:06:00.0.
>> So something is wrong with the physical layer, I guess.
>>
>>> Maybe I should just use 0000:07:00.0 and blacklist 0000:06:00.0 as I
>>> don't need two NICs?
>> Yup,
>> ratelimit the AER warning is another choice instead of change WARN to INFO.
>> if corrected error flood happens, even the function is working, suggests
>> something was already wrong, likely will be worse, that is the meaning of
>> WARN I think.
> We should fix this.  IMHO Correctable Errors should be "info" level,
> non-alarming, and rate-limited.  They're basically hints about link
> integrity.

This case, hit following errors:

[  883.545800] r8169 0000:06:00.0:    [ 0] RxErr
[  883.545801] r8169 0000:06:00.0:    [ 8] Rollover
[  883.545802] r8169 0000:06:00.0:    [12] Timeout

#1 Timeout -- replay timer timeout, means endpoint didn't response with ACK DLLP or
NACK in time, that caused the re-send timer timeout, the sender will re-send the
packet.

#2 Rollover -- the counter of re-transmission reaches 0 (from 11b ->00b), means the
sender had tried 3 times. that would trigger link retraining to recover.

#1 & #2 happened together, but no uncorrected errors reported, means the link was
recovered, the issue mostly caused by improper TxEQ, receiver equalization, bad
signal integrity.

#3 RxErr -- bad DLLP, bad TLP, clock issue, signal integrity issue etc.

so, yup, basically, the signal integrity is not good enough.
Though the function could work, its performance will be impacted.

If we change it to "info" level, by default, users wouldn't see such errors, they
might hit more serious data corruption/malfunction in the future without WARN
precaution to them.

Thanks,
Ethan

> Bjorn
>

