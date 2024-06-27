Return-Path: <linux-pci+bounces-9385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91191AD98
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C51C20988
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564819A2B3;
	Thu, 27 Jun 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="bZbZIRvu"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E81199EA5;
	Thu, 27 Jun 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508283; cv=none; b=MJXXiBHeL4kC7+4aUeL4G4UNVn3oVsL4IOQxLugwygenzxg0EqC1+ug08LPpPoGpu595Wf7O9yf7p6M7vWTJ+FFe2+o4OQGlwoFKqdTFgS7W5j2q1qMWXgvOXdupvkqqkwPMFWAq4vSZ6w5l3m7b07FFxSmKcZHarNJE1Xo5e/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508283; c=relaxed/simple;
	bh=AAWwGMnsqG8qfE98q0gh/lUrQ+ksPhNFMnWRShNE9kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVgt3Om5mjyRbG+Tx7PfvuWwi7X7SmMuvj/kh+nLJ36u73TQ4wMnG6ePFS8akhcPBWZmFIuI3UIAWfvHEIAiRZLQH2+RAsNlNialr2ii87tOuZyh/0Ksy1JqyZovN+w/QPRVexvxO0v5PE7yFerwwcZFN46QBsK4Brd3cto7HaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=bZbZIRvu; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9A9808284676;
	Thu, 27 Jun 2024 12:11:19 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8M9sTC8IiM0Q; Thu, 27 Jun 2024 12:11:18 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D1C748287291;
	Thu, 27 Jun 2024 12:11:18 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com D1C748287291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1719508278; bh=w0cEudny5PU8YvBvvlFhixxtK4IKtgz3lssxEp5pCGw=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=bZbZIRvuEntX4eYzCC3cMaso2r9eE/hUjToEQvGXbLDmgNP7Rm8yAZqFYBbUkXuop
	 JG68k6rTbQx7SI0fHE9Al/g4Qb7vdRaAmtzppTw6y2BZvQ9BGbh/LMqPmVmzL0ya4b
	 B3HXKoZR60vOefzlalffebwbI0HgqFinHoiEoHjc=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1p0pndOz2WXs; Thu, 27 Jun 2024 12:11:18 -0500 (CDT)
Received: from [10.11.0.2] (5.edge.rptsys.com [23.155.224.38])
	by mail.rptsys.com (Postfix) with ESMTPSA id 3864A8284676;
	Thu, 27 Jun 2024 12:11:18 -0500 (CDT)
Message-ID: <36276ba1-fc2c-418d-a80e-388e1f7988ed@raptorengineering.com>
Date: Thu, 27 Jun 2024 12:11:17 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] powerpc: hotplug driver bridge support
To: Krishna Kumar <krishnak@linux.ibm.com>, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: nathanl@linux.ibm.com, aneesh.kumar@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.leroy@csgroup.eu, gbatra@linux.ibm.com, bhelgaas@google.com,
 tpearson@raptorengineering.com, oohall@gmail.com, brking@linux.vnet.ibm.com,
 mahesh.salgaonkar@in.ibm.com, linuxppc-dev@lists.ozlabs.org
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
 <20240624121052.233232-3-krishnak@linux.ibm.com>
Content-Language: en-US
From: Shawn Anastasio <sanastasio@raptorengineering.com>
In-Reply-To: <20240624121052.233232-3-krishnak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krishna,

On 6/24/24 7:09 AM, Krishna Kumar wrote:
> There is an issue with the hotplug operation when it's done on the
> bridge/switch slot. The bridge-port and devices behind the bridge, which
> become offline by hot-unplug operation, don't get hot-plugged/enabled by
> doing hot-plug operation on that slot. Only the first port of the bridge
> gets enabled and the remaining port/devices remain unplugged. The hot
> plug/unplug operation is done by the hotplug driver
> (drivers/pci/hotplug/pnv_php.c).
> 
> Root Cause Analysis: This behavior is due to missing code for the
> switch/bridge. The existing driver depends on pci_hp_add_devices()
> function for device enablement. This function calls pci_scan_slot() on
> only one device-node/port of the bridge, not on all the siblings'
> device-node/port.
> 
> The missing code needs to be added which will find all the sibling
> device-nodes/bridge-ports and will run explicit pci_scan_slot() on
> those.  A new function has been added for this purpose which gets
> invoked from pci_hp_add_devices(). This new function
> pci_traverse_sibling_nodes_and_scan_slot() gets all the sibling
> bridge-ports by traversal and explicitly invokes pci_scan_slot on them.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gaurav Batra <gbatra@linux.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Brian King <brking@linux.vnet.ibm.com>
> 
> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>

Other than the case with NVMe devices failing that we discussed in v1's
thread, I can confirm that this patch resolves many of the issues we've
encountered with PCIe hotplug on POWER9.

Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>

Thanks,
Shawn

