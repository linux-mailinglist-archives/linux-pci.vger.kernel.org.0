Return-Path: <linux-pci+bounces-15931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2F9BB010
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 10:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0570F1C2222F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A021AF0AE;
	Mon,  4 Nov 2024 09:44:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18D1AE009;
	Mon,  4 Nov 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713465; cv=none; b=rgFozNQ+28G/p8QdkzTGGyLlR0RnOlrhwojEhNhWbr9GYWjFTZGLbCkyUR1o7dL/Qw+s+R9oYCPhwXo5d4m8ktboXHGUlzNapCS0EhHOn/7lNg35sCeflYWNj2pSS8nxmEpa7sRIZBHKXW+9YFSAQiHHjJHigW9FS3DCHRIcTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713465; c=relaxed/simple;
	bh=yLlNRec+TIZER2OAwD8NyXy090ESZc462VeydNrxhTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1xkgKJgrIvLULujAAika18I1BaN5bo/MCF4ox/zVpSWbIHSpHgTJt0zRw2Ypv7hmYZPq4HU5C6MQoGIGCmDR3AR1k4ZUECcvrBLHzXvYlgBEgMCZgfngnXqKagcOon7vzXZzUmnHgbGPkWmsvB/okFcB2QFircWi8h9XV459oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (unknown [95.90.234.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0FAD461E5FE05;
	Mon, 04 Nov 2024 10:44:09 +0100 (CET)
Message-ID: <d4561a55-1568-4290-aede-2e5f69009e5d@molgen.mpg.de>
Date: Mon, 4 Nov 2024 10:44:08 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support
 added
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
 Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>,
 "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>
 <e6bd065d-0b9b-4c37-958c-fc2a09ea0475@molgen.mpg.de>
 <PH0PR11MB595244C38429E3AF6CAD73F6FC512@PH0PR11MB5952.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB595244C38429E3AF6CAD73F6FC512@PH0PR11MB5952.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Chandrashekar,


Am 04.11.24 um 10:18 schrieb Devegowda, Chandrashekar:

>       Thank you for the comments

Thank you for taking the time to address them.

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Wednesday, October 23, 2024 12:49 PM

>> [Cc: +Bjorn, +linux-pci]

[…]

>> Am 23.10.24 um 13:46 schrieb ChandraShekar:
>>> This patch contains the changes in driver to support the suspend and
>>> resume i.e move the controller to D3 state when the platform is
>>> entering into suspend and move the controller to D0 on resume.
>>
>> It’d be great if you elaborated. Please start by the history, since when Intel
>> Bluetooth PCIe have been there, and why until now this support was missing.
> 
> The initial Intel bluetooth firmware supported only the FW download
> and Bluetooth Tx and Rx data flows ,further now the firmware has
> added support for vendor specific handshake during enter of D3 and
> D0 exit. So corresponding to FW changes this is the incremental
> changes from driver.

Interesting. Please also add the firmware versions to the commit message.

[…]

>> Is it also possible to use Bluetooth as a wakeup source from
>> suspend?
> 
> Yes BT device initiated wake up of the platform from suspend is
> possible, which will be enabled in the next patch

Great.

[…]

I am looking forward to the next iteration.


Kind regards,

Paul

