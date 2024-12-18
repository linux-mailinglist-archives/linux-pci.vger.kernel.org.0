Return-Path: <linux-pci+bounces-18724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342D9F6E20
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6336018804D5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1693597C;
	Wed, 18 Dec 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="n4Iy9Mxc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E509461;
	Wed, 18 Dec 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549712; cv=none; b=YNpr669OLTbzUFq4phXnck7knehTRDGhDBJTDyryd78eyOw2hnRs6GTXKKOIiK9zbkkofOuDG9Wk5UM8g3KAEmwa/8GF81dS6SN5auROZcxn1UP5KvbBBArjzke/8p3apiXN/oL41CjUxPSq9JKgvgzRIzF0OhVbXkTOsdiITv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549712; c=relaxed/simple;
	bh=XOOAg+9NyusyFnHK/VT5RSEuo12t6r9zreSZg9YDJo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha29IORGkqdEGvm3ttImGJ/rFfiyiwy06qhV95dowT/nishk6vwV1POMhGMEXM2ZCL3Jr+XTAb9e24gp9REgnJ5Zscvs/eeVx+jhT7t49YANpKZu01nYo9AigDlazYRjgkvdHd4PV+5F/qqfYzq1l3bpGHFOS5E7bqvPgGlqBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=n4Iy9Mxc; arc=none smtp.client-ip=81.19.149.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tOtmzgBrXNpnRWLYy9N50Vkhc34EB9OOhkcohKuZ4oE=; b=n4Iy9MxcJ+btrLbm+6tvm07Lbd
	Hg7F+N4LF1KChrHtH+2+TKHensIyj7k0cokUuFEEKU8+ZTfc0/ZxEKDISxuLQOqJj0RuufM93AC3h
	Ix1QEgz3HU5Ikatoxe8Qz1PCEFXUjYMTiiMoWLuelfE4ohCkxc0EaiuHpb2dqqaEU4Io=;
Received: from 88-117-62-55.adsl.highway.telekom.at ([88.117.62.55] helo=[10.0.0.160])
	by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tNzcB-000000006xh-2Ssf;
	Wed, 18 Dec 2024 20:21:47 +0100
Message-ID: <54d9d905-1cee-4922-8631-c2b69779d18a@engleder-embedded.com>
Date: Wed, 18 Dec 2024 20:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] e1000e: Fix real-time
 violations on link up
Content-Language: en-US
To: Avigail Dahan <Avigailx.dahan@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bhelgaas@google.com,
 pmenzel@molgen.mpg.de, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20241214191623.7256-1-gerhard@engleder-embedded.com>
 <cd7d3122-5231-bb7c-cb2c-7b8b94a46968@intel.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <cd7d3122-5231-bb7c-cb2c-7b8b94a46968@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes

On 18.12.24 16:08, Avigail Dahan wrote:
> 
> 
> On 14/12/2024 21:16, Gerhard Engleder wrote:
>> From: Gerhard Engleder <eg@keba.com>
>>
>> Link down and up triggers update of MTA table. This update executes many
>> PCIe writes and a final flush. Thus, PCIe will be blocked until all
>> writes are flushed. As a result, DMA transfers of other targets suffer
>> from delay in the range of 50us. This results in timing violations on
>> real-time systems during link down and up of e1000e in combination with
>> an Intel i3-2310E Sandy Bridge CPU.
>>
>> The i3-2310E is quite old. Launched 2011 by Intel but still in use as
>> robot controller. The exact root cause of the problem is unclear and
>> this situation won't change as Intel support for this CPU has ended
>> years ago. Our experience is that the number of posted PCIe writes needs
>> to be limited at least for real-time systems. With posted PCIe writes a
>> much higher throughput can be generated than with PCIe reads which
>> cannot be posted. Thus, the load on the interconnect is much higher.
>> Additionally, a PCIe read waits until all posted PCIe writes are done.
>> Therefore, the PCIe read can block the CPU for much more than 10us if a
>> lot of PCIe writes were posted before. Both issues are the reason why we
>> are limiting the number of posted PCIe writes in row in general for our
>> real-time systems, not only for this driver.
>>
>> A flush after a low enough number of posted PCIe writes eliminates the
>> delay but also increases the time needed for MTA table update. The
>> following measurements were done on i3-2310E with e1000e for 128 MTA
>> table entries:
>>
>> Single flush after all writes: 106us
>> Flush after every write:       429us
>> Flush after every 2nd write:   266us
>> Flush after every 4th write:   180us
>> Flush after every 8th write:   141us
>> Flush after every 16th write:  121us
>>
>> A flush after every 8th write delays the link up by 35us and the
>> negative impact to DMA transfers of other targets is still tolerable.
>>
>> Execute a flush after every 8th write. This prevents overloading the
>> interconnect with posted writes.
>>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Link: 
>> https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
>> Signed-off-by: Gerhard Engleder <eg@keba.com>
>> ---
>> v3:
>> - mention problematic platform explicitly (Bjorn Helgaas)
>> - improve comment (Paul Menzel)
>>
>> v2:
>> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
>> ---
>>   drivers/net/ethernet/intel/e1000e/mac.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

Thank you for the test!

Gerhard

