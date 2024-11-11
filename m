Return-Path: <linux-pci+bounces-16432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3B9C38F7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45962807F3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E950276;
	Mon, 11 Nov 2024 07:21:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818C136A;
	Mon, 11 Nov 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309693; cv=none; b=hkT6Wo01I3xaNj8IwAUD6kS4WwYE3z40wWn0Rp1mlP9Bo8cETdQOW47AzjeSQ5NDBOB3AZZgg8lxk7elAufNGRfY29UofPUupd99mJfIEGinc3pM+G0NfUXs7+3TR5vYZyovWnQaD0J3hPpUVntRd+P8yt7ib9q9XFjYfAExcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309693; c=relaxed/simple;
	bh=fOsAPC1aCReILnAtNZ8hxSF319BoJu3a3LVc+79V7pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvNXJwBduUCH9em/2DlrFkOKY2O9m+gd2pT6ZedMOpmcIJ0rrIdvgGjlH7wn9/bK5AGhOF3VDOdlNF9f/JjR+cxb4n1qvZT5RTCecWq81ZHf6bSm3vvkMmJXUt9DXi8d12jdid6CfBxqooE5cBh79uVGjl/DLy4HGkXvoAq8VbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (unknown [95.90.237.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F3C661E5FE05;
	Mon, 11 Nov 2024 08:21:05 +0100 (CET)
Message-ID: <cb38ef85-363d-47aa-bc01-55a3fef5b0af@molgen.mpg.de>
Date: Mon, 11 Nov 2024 08:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
 Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>,
 Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
 Kiran K <kiran.k@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20241108143931.2422947-1-chandrashekar.devegowda@intel.com>
 <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>
 <PH0PR11MB5952C7090EAA4F6B75145611FC582@PH0PR11MB5952.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB5952C7090EAA4F6B75145611FC582@PH0PR11MB5952.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chandrashekar,


Thank you for your space.


Am 11.11.24 um 07:33 schrieb Devegowda, Chandrashekar:

>> -----Original Message-----

>> Sent: Friday, November 08, 2024 2:49 PM
>> To: Devegowda, Chandrashekar <chandrashekar.devegowda@intel.com>

[…]

>> Am 08.11.24 um 15:39 schrieb ChandraShekar Devegowda:
>>
>> The space in your name is still missing.
> 
> I have added my second name, my first name doesn’t have a space so
> please consider ChandraShekar as a single name.
Thank you. In your email you now do *not* use CamelCase, which is more 
common in Western culture. (Of course you can write your name as you 
want, and I just pointed it out.)

>>> This patch contains the changes in driver for vendor specific handshake
>>> during enter of D3 and D0 exit.
>>
>> Please document the datasheet name and revision.
> 
> Datasheet is internal to Intel, sorry wouldn't  be able to share at
> the moment.

Although it is not public, the name would still be good to have. Intel 
employees can probably get access more easily, and non-Intel folks could 
directly approach with the name, and in the future it might be even made 
public.

[…]

Thank you for acknowledging the other comments.


Kind regards

Paul

