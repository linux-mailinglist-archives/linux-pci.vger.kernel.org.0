Return-Path: <linux-pci+bounces-5078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774588A1B1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 14:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BF62C1FD6
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A113DAC1A;
	Mon, 25 Mar 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6esWeq/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC40156C4E;
	Mon, 25 Mar 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356332; cv=none; b=juGrcGJcdSEbqNTiFza+F3y6EH8Ctf/o6yBb3HZ6OY+MpA9x0oTAyQr+JTTamezxaRpUBuKYs7nHuRvcPbXfPsbPXKDBcbE07HoHW6z4BN1d8rgBVirWuzxhA4XgYZ0WuUe2P3kQR3qde71qxMY6ZVHT6gG+1IVXfQ4GnNobdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356332; c=relaxed/simple;
	bh=knUdCX/JOXqL4snKEL002fjNHL5rz0BFYkaGhcfpTvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inB2YfXiFArquK4+DBviCWFifZ2UvViaYUUwXtygeLU9uoDolPwAE1vThszhIjjWKo3znwurm/y5yxrVnjiDdoktMK8xU3Aon94BU1PlX+LgJIhGC4kaSyT4l9q5RtEDoS1sdi70+0pF19bU7E9wMgpVwcSGMOqW5UreY/At/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6esWeq/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711356331; x=1742892331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=knUdCX/JOXqL4snKEL002fjNHL5rz0BFYkaGhcfpTvA=;
  b=Y6esWeq/YL90tUTozZ0miM+/Ui38kyaC33sZrPsi1t0Sjk2JPv84OCo3
   ZGX7CZhQ7W7g4Ji1WsXOK0KE9/ieHOsnIaFoJaLZCvIQ/4ozOiTAJWADx
   PLeqhR9XfqutylNOxerrAA3SQMgWzSnouKYEPO2jlO9z6P6mvgC3xAeCm
   6QxhOLZta1SmIlsWi4UcC7OsMt7fm88D+tb/vAnoQIHTrZl6D3SXm23MD
   dQSEl2jhlHMb/xZRsHdswcjEjsU3GCvHL/vVzgPkAXlqTVPRdkEMBHvKh
   qlogBT+9a89eL8TXObBUz37Q5VarXFk0jR+nG9pyAMkcw6sgOkOnpkso2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10139249"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10139249"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 01:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15601892"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.215.245]) ([10.254.215.245])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 01:45:27 -0700
Message-ID: <38601aef-b082-463f-8e41-f73a4307de21@linux.intel.com>
Date: Mon, 25 Mar 2024 16:45:08 +0800
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <0a44fd663e93ac5b36865b0080da52d94252791a.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/2024 1:19 AM, Xi Ruoyao wrote:
> On Mon, 2023-09-18 at 14:39 -0500, Bjorn Helgaas wrote:
>> On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
>>> ...
>>> My workstation suffers from too much correctable AER reporting as well
>>> (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
>>> Generate Correctable Errors" and/or the motherboard design, I guess).
>> We should rate-limit correctable error reporting so it's not
>> overwhelming.
>>
>> At the same time, I'm *also* interested in the cause of these errors,
>> in case there's a Linux defect or a hardware erratum that we can work
>> around.  Do you have a bug report with any more details, e.g., a dmesg
>> log and "sudo lspci -vv" output?
> Hi Bjorn,
>
> Sorry for the *very* late reply (somehow I didn't see the reply at all
> before it was removed by my cron job, and now I just savaged it from
> lore.kernel.org...)
>
> The dmesg is like:
>
> [  882.456994] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
> [  882.457002] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
> [  882.457003] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
> [  883.545763] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
> [  883.545789] pcieport 0000:00:1c.1: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> [  883.545790] pcieport 0000:00:1c.1:   device [8086:7a39] error status/mask=00000001/00002000
> [  883.545792] pcieport 0000:00:1c.1:    [ 0] RxErr                  (First)
> [  883.545794] pcieport 0000:00:1c.1: AER:   Error of this Agent is reported first
> [  883.545798] r8169 0000:06:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Transmitter ID)
> [  883.545799] r8169 0000:06:00.0:   device [10ec:8125] error status/mask=00001101/0000e000
> [  883.545800] r8169 0000:06:00.0:    [ 0] RxErr                  (First)
> [  883.545801] r8169 0000:06:00.0:    [ 8] Rollover
> [  883.545802] r8169 0000:06:00.0:    [12] Timeout
> [  883.545815] pcieport 0000:00:1c.1: AER: Correctable error message received from 0000:00:1c.1
> [  883.545823] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
> [  883.545824] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
>
> lspci output attached.
>
> Intel has issued an errata "RPL013" saying:
>
> "Under complex microarchitectural conditions, the PCIe controller may
> transmit an incorrectly formed Transaction Layer Packet (TLP), which
> will fail CRC checks. When this erratum occurs, the PCIe end point may
> record correctable errors resulting in either a NAK or link recovery.
> Intel® has not observed any functional impact due to this erratum."
>
> But I'm really unsure if it describes my issue.
>
> Do you think I have some broken hardware and I should replace the CPU
> and/or the motherboard (where the r8169 is soldered)?  I've noticed that
> my 13900K is almost impossible to overclock (despite it's a K), but I've
> not encountered any issue other than these AER reporting so far after I
> gave up overclocking.

Seems there are two r8169 nics on your board, only 0000:06:00.0 reports
aer errors, how about another one the 0000:07:00.0 nic ?


Thanks,
Ethan


