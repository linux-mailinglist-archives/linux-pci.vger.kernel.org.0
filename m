Return-Path: <linux-pci+bounces-5139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE588B6FB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 02:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EC61F3B70F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A4208A0;
	Tue, 26 Mar 2024 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyqaD/b5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75288210E7;
	Tue, 26 Mar 2024 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417204; cv=none; b=aECGl7dNfNEArOHA65A8tTiqo8LMcsjo0dpceU98Bmf6q+QTboFnDaEuMNbxCtIpbzhWsZdVAxUn2ARZ/oktiBhJ8eXoXQbk7iktlWVv6Yf40uUZiJ0As1L81oRw1pjojRxDTFq9brvs9z6k0QXj5Qoh6AZufKYcQHN/3fJ0dko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417204; c=relaxed/simple;
	bh=fxaAJQ+kSn8nKb0OEa7bo1CfKPOsd0+BK2jb2R82ysM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jabc1zmN2w7/XgKwNkIHU7SyA2qNxLKPbPtrgkP1PbsKacq1dP1M/7kZbFd+aIwzl6QQnNqNk/0YA6ULDUPx4+1Y6mM4zxuNKQk8eedOZRq7ADpJDh6dJnKQTRr9I85E5kcig7fv6VkySl4GN8Mf0k9QR42p1i/3w6j3bzxsJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyqaD/b5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711417202; x=1742953202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fxaAJQ+kSn8nKb0OEa7bo1CfKPOsd0+BK2jb2R82ysM=;
  b=YyqaD/b5kO3KA30njoSTmJMbDxnbDmzQDwJzFJvvDxPamAiItYuey9h5
   28+qRiI/78RDt1iZuV1++gcjI9rJQXLKtmX5XMcTWxaVQD0OF8B5IA8Ln
   5trCDVsBkUYp1SRblfvcW+679T7+fmBvYrIbvh0/mir0jN0Ap73ERpw2P
   mnm/s32RsE14FgHCqS9a4snytQjFZ4fNs2tZXD2bLl7eXUiTO1UR8gBmL
   v4N6KI86cNSU++OTHRQ3NqYrmcWOwNMA8Wk+b/LB55tD2uFPkZxhl/S+p
   C14v+uU0X+oX/ZK3sDPJO1IumPfBzdhFVuu3+57Zoem9WxT1l5wPX3g1C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6635340"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6635340"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="53262206"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.209.117]) ([10.254.209.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:39:58 -0700
Message-ID: <a1d7b4c9-b47e-4b59-a4d5-e091bbbff5d7@linux.intel.com>
Date: Tue, 26 Mar 2024 09:39:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
To: Xi Ruoyao <xry111@xry111.site>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, oohall@gmail.com,
 rajat.khandelwal@linux.intel.com, rajatja@chromium.org
References: <20230918193913.GA203601@bhelgaas>
 <0a44fd663e93ac5b36865b0080da52d94252791a.camel@xry111.site>
 <38601aef-b082-463f-8e41-f73a4307de21@linux.intel.com>
 <ba78805af8b39237b22a0ff87c4ba3c614a43910.camel@xry111.site>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <ba78805af8b39237b22a0ff87c4ba3c614a43910.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/2024 6:15 PM, Xi Ruoyao wrote:
> On Mon, 2024-03-25 at 16:45 +0800, Ethan Zhao wrote:
>> On 3/25/2024 1:19 AM, Xi Ruoyao wrote:
>>> On Mon, 2023-09-18 at 14:39 -0500, Bjorn Helgaas wrote:
>>>> On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
>>>>> ...
>>>>> My workstation suffers from too much correctable AER reporting as well
>>>>> (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
>>>>> Generate Correctable Errors" and/or the motherboard design, I guess).
>>>> We should rate-limit correctable error reporting so it's not
>>>> overwhelming.
>>>>
>>>> At the same time, I'm *also* interested in the cause of these errors,
>>>> in case there's a Linux defect or a hardware erratum that we can work
>>>> around.  Do you have a bug report with any more details, e.g., a dmesg
>>>> log and "sudo lspci -vv" output?
>>> Hi Bjorn,
>>>
>>> Sorry for the *very* late reply (somehow I didn't see the reply at all
>>> before it was removed by my cron job, and now I just savaged it from
>>> lore.kernel.org...)
>>>
>>> The dmesg is like:
>>>
>>> [  882.456994] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
>>> [  882.457002] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
>>> [  882.457003] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
>>> [  883.545763] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
>>> [  883.545789] pcieport 0000:00:1c.1: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>>> [  883.545790] pcieport 0000:00:1c.1:   device [8086:7a39] error status/mask=00000001/00002000
>>> [  883.545792] pcieport 0000:00:1c.1:    [ 0] RxErr                  (First)
>>> [  883.545794] pcieport 0000:00:1c.1: AER:   Error of this Agent is reported first
>>> [  883.545798] r8169 0000:06:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Transmitter ID)
>>> [  883.545799] r8169 0000:06:00.0:   device [10ec:8125] error status/mask=00001101/0000e000
>>> [  883.545800] r8169 0000:06:00.0:    [ 0] RxErr                  (First)
>>> [  883.545801] r8169 0000:06:00.0:    [ 8] Rollover
>>> [  883.545802] r8169 0000:06:00.0:    [12] Timeout
>>> [  883.545815] pcieport 0000:00:1c.1: AER: Correctable error message received from 0000:00:1c.1
>>> [  883.545823] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
>>> [  883.545824] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
>>>
>>> lspci output attached.
>>>
>>> Intel has issued an errata "RPL013" saying:
>>>
>>> "Under complex microarchitectural conditions, the PCIe controller may
>>> transmit an incorrectly formed Transaction Layer Packet (TLP), which
>>> will fail CRC checks. When this erratum occurs, the PCIe end point may
>>> record correctable errors resulting in either a NAK or link recovery.
>>> Intel® has not observed any functional impact due to this erratum."
>>>
>>> But I'm really unsure if it describes my issue.
>>>
>>> Do you think I have some broken hardware and I should replace the CPU
>>> and/or the motherboard (where the r8169 is soldered)?  I've noticed that
>>> my 13900K is almost impossible to overclock (despite it's a K), but I've
>>> not encountered any issue other than these AER reporting so far after I
>>> gave up overclocking.
>> Seems there are two r8169 nics on your board, only 0000:06:00.0 reports
>> aer errors, how about another one the 0000:07:00.0 nic ?
> It never happens to 0000:07:00.0, even if I plug the ethernet cable into
> it instead of 0000:06:00.0.

So something is wrong with the physical layer, I guess.

>
> Maybe I should just use 0000:07:00.0 and blacklist 0000:06:00.0 as I
> don't need two NICs?

Yup,
ratelimit the AER warning is another choice instead of change WARN to INFO.
if corrected error flood happens, even the function is working, suggests
something was already wrong, likely will be worse, that is the meaning of
WARN I think.


Thanks,
Ethan

>

