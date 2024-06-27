Return-Path: <linux-pci+bounces-9386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E291ADA5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252801F21726
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF524199E89;
	Thu, 27 Jun 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="UyJF5CEt"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6A197549;
	Thu, 27 Jun 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508378; cv=none; b=bipoJO2JYMufXLZLR3oNmHzECnyOyaS7gPf8Dh+qjRjaz+T/eH0n9YodiZcLglMM7LaqIOJp/mwS1W9pfcAu0et1d9h2T4uhTSupnIGrK/HARJHjVo7PCLkUg+LHk7gSP9fMQLTWh1HJH2mRe64fkzS44NNZI2ZuX7u7665AaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508378; c=relaxed/simple;
	bh=x0paNmrzPbz/jmBMj25p+GgQaoamDJejk56BVcITTBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGtt2M1TrjDHRCDIVbhxsvxETaxwY3c5iyzIr072f5wpYoPWSki72Se8I/ImTdcClkcxhQ+stg9lRmXDCY0Zw54/RsXRbM2uYbWK//5L/qZiS8CzyPyXLu5xyzny+sKkyobrt11ARwYjlv1wiuMBpXdpWIzk/I688J1Sb8Jif0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=UyJF5CEt; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 3899C82871B7;
	Thu, 27 Jun 2024 12:04:05 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Z0AZFKoChWpd; Thu, 27 Jun 2024 12:04:04 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 759F482871F3;
	Thu, 27 Jun 2024 12:04:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 759F482871F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1719507844; bh=lxG8sC0/ltpBtPDS3WyH/p3fZxyBFAQa4wHnHvd9qOQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=UyJF5CEtwodZS0AOmdl/Xe0uxiSxyqQJHRJ5WHGh794xkqqwdOw0GKBPwrDxZ+8eX
	 3yO3V2HpVP1xLj4cvvlxmVk0QV3aTYmnq//UqGpCtjyKTkNfTIf2fiJFfd+rdW80Yq
	 bI9E/iHQvuaAvotGXRWxmvkZBEDw24oMyhr/h8VU=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nqNGWJcLLn22; Thu, 27 Jun 2024 12:04:04 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id C6C9682871B7;
	Thu, 27 Jun 2024 12:04:03 -0500 (CDT)
Message-ID: <4826c905-720d-43bf-98a8-c4be076a3ebe@raptorengineering.com>
Date: Thu, 27 Jun 2024 12:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on
 Powernv
To: Krishna Kumar <krishnak@linux.ibm.com>, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 gbatra@linux.ibm.com, bhelgaas@google.com, tpearson@raptorengineering.com,
 oohall@gmail.com, brking@linux.vnet.ibm.com, mahesh.salgaonkar@in.ibm.com,
 linuxppc-dev@lists.ozlabs.org
References: <20240509120644.653577-1-krishnak@linux.ibm.com>
 <20240509120644.653577-2-krishnak@linux.ibm.com>
Content-Language: en-US
From: Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <20240509120644.653577-2-krishnak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krishna,

On 5/9/24 7:05 AM, Krishna Kumar wrote:
> Description of the problem: The hotplug driver for powerpc
> (pci/hotplug/pnv_php.c) gives kernel crash when we try to
> hot-unplug/disable the PCIe switch/bridge from the PHB.
> 
> 
> Root Cause of Crash: The crash is due to the reason that, though the msi
> data structure has been released during disable/hot-unplug path and it
> has been assigned with NULL, still during unregistartion the code was
> again trying to explicitly disable the msi which causes the Null pointer
> dereference and kernel crash.
> 
> 
> Proposed Fix : The fix is to correct the check during unregistration path
> so that the code should not  try to invoke pci_disable_msi/msix() if its
> data structure is already freed.
> 
> 
> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>

I've tested this on a POWER9 box and can confirm that it fixes the panics
when hotplugging PCIe bridges.

Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>

Thanks,
Shawn

