Return-Path: <linux-pci+bounces-30144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAACADFA4B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 02:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C02517E777
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAC03597E;
	Thu, 19 Jun 2025 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="fCNQwZSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8D137E;
	Thu, 19 Jun 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750293486; cv=none; b=gATV1phHva8NbYqj21fIMYpBYojep38Q+hK1m5I3aF5tm4XoXAqgK5lQpEmIPBWOLbSUD5KLplriav25HgjAvh5/WVdVZyK53g4C3zQGSd5pACUvHjFkTNnD5MX1fpw3j3lpxvGY8t4QNTrcexMf6RStPmIl7zOZg0jOBxfNdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750293486; c=relaxed/simple;
	bh=FUV+Ha5L59rakUQc78bmuMWZrU4d94rlXYQCrQ74qSY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=B0IsnaejUEIEB9PTjIWBTkUi7ecPKJEx6ImN9gvsW37Nf+XFSPwUKALQeeLJVGgURG04zEULVOnekueOabAlTDw2Cm9dq7LvwkKYi5wUWdZqRsI/TDOHBI9PmXYVYpZVoxmEayIJho3L5qiC2img34TvA5YqoiOqJmWCn7C0fpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=fCNQwZSN; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A29968287A6A;
	Wed, 18 Jun 2025 19:38:00 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yMleV-6kXUQY; Wed, 18 Jun 2025 19:37:57 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id CDFDB8288035;
	Wed, 18 Jun 2025 19:37:57 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com CDFDB8288035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1750293477; bh=Q9w+b4fYJ33GmI5ccuzAIoUJBfCmv1gJrhUlRTyPCDg=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=fCNQwZSNHwvwQKBGcGpFbsyfRxDhvc9QAjlsE5UWR0Teasz5/r1ioK8ie6DjdfS28
	 Bi3zH1vVYMzHKBpxhNyPipsRHMwkeCODPv/GoflkA5rvNwsbMsimTTkBPh6m038/V+
	 9130BbtCYN8KH/YrwM1xX79qThIfY9aayg3bAal8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zOSsFrDhJwnk; Wed, 18 Jun 2025 19:37:57 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8A22E8287A6A;
	Wed, 18 Jun 2025 19:37:57 -0500 (CDT)
Date: Wed, 18 Jun 2025 19:37:54 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <1469323476.1312174.1750293474949.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20250618190146.GA1213349@bhelgaas>
References: <20250618190146.GA1213349@bhelgaas>
Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention
 indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC137 (Linux)/8.5.0_GA_3042)
Thread-Topic: pci/hotplug/pnv_php: Enable third attention indicator
Thread-Index: yG5gRsIlLAjK/qBNlVwR8Z2oiwzhPw==



----- Original Message -----
> From: "Bjorn Helgaas" <helgaas@kernel.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-pci"
> <linux-pci@vger.kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> "christophe leroy" <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>, "Bjorn Helgaas"
> <bhelgaas@google.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Wednesday, June 18, 2025 2:01:46 PM
> Subject: Re: [PATCH v2 6/6] pci/hotplug/pnv_php: Enable third attention indicator

> On Wed, Jun 18, 2025 at 11:58:59AM -0500, Timothy Pearson wrote:
>>  state
> 
> Weird wrapping of last word of subject to here.

I'll need to see what's up with my git format-patch setup. Apologies for that across the multiple series.

>> The PCIe specification allows three attention indicator states,
>> on, off, and blink.  Enable all three states instead of basic
>> on / off control.
>> 
>> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
>> ---
>>  drivers/pci/hotplug/pnv_php.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>> index 0ceb4a2c3c79..c3005324be3d 100644
>> --- a/drivers/pci/hotplug/pnv_php.c
>> +++ b/drivers/pci/hotplug/pnv_php.c
>> @@ -440,10 +440,23 @@ static int pnv_php_get_adapter_state(struct hotplug_slot
>> *slot, u8 *state)
>>  	return ret;
>>  }
>>  
>> +static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8
>> *state)
>> +{
>> +	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
>> +	struct pci_dev *bridge = php_slot->pdev;
>> +	u16 status;
>> +
>> +	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
>> +	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
> 
> Should be able to do this with FIELD_GET().

I used the same overall structure as the pciehp_hpc driver here.  Do you want me to also fix up that driver with FIELD_GET()?

> Is the PCI_EXP_SLTCTL_PIC part needed?  It wasn't there before, commit
> log doesn't mention it, and as far as I can tell, this would be the
> only driver to do that.  Most expose only the attention status (0=off,
> 1=on, 2=identify/blink).
> 
>> +	return 0;
>> +}
>> +
>> +
>>  static int pnv_php_get_attention_state(struct hotplug_slot *slot, u8 *state)
>>  {
>>  	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
>>  
>> +	pnv_php_get_raw_indicator_status(slot, &php_slot->attention_state);
> 
> This is a change worth noting.  Previously we didn't read the AIC
> state from PCI_EXP_SLTCTL at all; we used php_slot->attention_state to
> keep track of whatever had been previously set via
> pnv_php_set_attention_state().
> 
> Now we read the current state from PCI_EXP_SLTCTL.  It's not clear
> that php_slot->attention_state is still needed at all.

It probably isn't.  It's unclear why IBM took this path at all, given pciehp's attention handlers predate pnv-php's by many years.

> Previously, the user could write any value at all to the sysfs
> "attention" file and then read that same value back.  After this
> patch, the user can still write anything, but reads will only return
> values with PCI_EXP_SLTCTL_AIC and PCI_EXP_SLTCTL_PIC.
> 
>>  	*state = php_slot->attention_state;
>>  	return 0;
>>  }
>> @@ -461,7 +474,7 @@ static int pnv_php_set_attention_state(struct hotplug_slot
>> *slot, u8 state)
>>  	mask = PCI_EXP_SLTCTL_AIC;
>>  
>>  	if (state)
>> -		new = PCI_EXP_SLTCTL_ATTN_IND_ON;
>> +		new = FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
> 
> This changes the behavior in some cases:
> 
>  write 0: previously turned indicator off, now writes reserved value
>  write 2: previously turned indicator on, now sets to blink
>  write 3: previously turned indicator on, now turns it off

If we're looking at normalizing with pciehp with an eye toward eventually deprecating / removing pnv-php, I can't think of a better time to change this behavior.  I suspect we're the only major user of this code path at the moment, with most software expecting to see pciehp-style handling.  Thoughts?

