Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4263C7887
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhGMVQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 17:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMVQ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 17:16:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F0C0613DD
        for <linux-pci@vger.kernel.org>; Tue, 13 Jul 2021 14:13:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k4so434840wrc.8
        for <linux-pci@vger.kernel.org>; Tue, 13 Jul 2021 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZWgSXwVMZjKjD4eA0vP++QBEI8Mms6KB3JA83NarNJE=;
        b=RcdGkSoqAK4YEieKfnE4JeS6glpxoo09dhkWwz+nCUx/wkHDnLW5q4FCmYVd9ZF4KG
         ocZ2RpzQTQIF7WKrzRfsmvoyTDJq5F4ESbQ0QqZU2AU5rC7sbKXrRArtxDgbro84Cd/F
         Z4/SqPKyVymmXMp4oDvRMgQFiL3pl3ddQJhGheb7TrAFBNxVyZzLn0BXIuNYwQXIjf5d
         LZjX7bQJ47n1Kn5ttWq5GWj75ri0/dP+NqtblryODbW7VpGEw0oaNvbTOaZBfOLaaLEn
         c6QtnlTLRKkaYTGq6ybt0E+QRADT85w4lDp/W22rqyd1HbQ1zzOjLLkOSttvUgNM8qct
         DLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZWgSXwVMZjKjD4eA0vP++QBEI8Mms6KB3JA83NarNJE=;
        b=t9F3TZavgr2SCpoBYc50mRh5uu8Mba2vmel4/AO/m54scvE800YZn0gLkqWszyDVCm
         gG+uPstYE5UZBEX57zBSJCC1aq9MEHtBzUktUjeqfAc1+fR3GXUCXs0rskoKe8uwcKLW
         uXSO8VbYluWrtrS4WkFRnMoUDxiXmkrFzt1iG/Gpppzbs5DguuA1UX/Nd3AwNfZvdtQ0
         PhrCwOpJrSXDKm5qlp+SEdFgjbUttYg8mbCAZ3UVWazO5DFmLL9dPt+c65k6FmYwJGaE
         ah7c+WdrON8c9JTEQxGdtY8BITmUXq+BT2kjk/JeVsMx6wDrz/o8eJ59Jq8KNGKix4+t
         6Ong==
X-Gm-Message-State: AOAM532bjR3bfwJ4RmO7H/Vw6oPHm4nt2mhx+SuM16YIuI+L5Kw/xHIp
        Gh4c/zLtZZNggJqInYP2jckfAq47ksxBWA==
X-Google-Smtp-Source: ABdhPJyBeLjN5GlJQpOIdiwqBiSMkfH8dAhCAd8baB9qTXrABwAyPObLlpmk8fju+MfBNe+EwAHfeA==
X-Received: by 2002:adf:ffcf:: with SMTP id x15mr8414963wrs.76.1626210817540;
        Tue, 13 Jul 2021 14:13:37 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3f:3d00:3810:5e81:4d98:f8c5? (p200300ea8f3f3d0038105e814d98f8c5.dip0.t-ipconnect.de. [2003:ea:8f3f:3d00:3810:5e81:4d98:f8c5])
        by smtp.googlemail.com with ESMTPSA id p3sm3340071wmq.17.2021.07.13.14.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 14:13:36 -0700 (PDT)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210713202555.GA1771351@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/5] PCI/VPD: Refactor pci_vpd_size
Message-ID: <0fb70529-3b0e-4865-bf6d-460030948019@gmail.com>
Date:   Tue, 13 Jul 2021 23:13:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713202555.GA1771351@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.07.2021 22:25, Bjorn Helgaas wrote:
> [+cc Hannes]
> 
> On Thu, May 13, 2021 at 10:58:40PM +0200, Heiner Kallweit wrote:
>> The only Short Resource Data Type tag is the end tag. This allows to
>> remove the generic SRDT tag handling and the code be significantly
>> simplified.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/vpd.c | 46 ++++++++++++----------------------------------
>>  1 file changed, 12 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>> index 26bf7c877..ecdce170f 100644
>> --- a/drivers/pci/vpd.c
>> +++ b/drivers/pci/vpd.c
>> @@ -73,50 +73,28 @@ EXPORT_SYMBOL(pci_write_vpd);
>>  static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>>  {
>>  	size_t off = 0;
>> -	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
>> +	u8 header[3];	/* 1 byte tag, 2 bytes length */
>>  
>>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
>> -		unsigned char tag;
>> -
>>  		if (!header[0] && !off) {
>>  			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
>>  			return 0;
>>  		}
>>  
>> -		if (header[0] & PCI_VPD_LRDT) {
>> -			/* Large Resource Data Type Tag */
>> -			tag = pci_vpd_lrdt_tag(header);
>> -			/* Only read length from known tag items */
>> -			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
>> -			    (tag == PCI_VPD_LTIN_RO_DATA) ||
>> -			    (tag == PCI_VPD_LTIN_RW_DATA)) {
>> -				if (pci_read_vpd(dev, off+1, 2,
>> -						 &header[1]) != 2) {
>> -					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
>> -						 tag, off + 1);
>> -					return 0;
>> -				}
>> -				off += PCI_VPD_LRDT_TAG_SIZE +
>> -					pci_vpd_lrdt_size(header);
>> -			}
>> -		} else {
>> -			/* Short Resource Data Type Tag */
>> -			off += PCI_VPD_SRDT_TAG_SIZE +
>> -				pci_vpd_srdt_size(header);
>> -			tag = pci_vpd_srdt_tag(header);
>> -		}
>> -
>> -		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>> -			return off;
>> +		if (header[0] == PCI_VPD_SRDT_END)
>> +			return off + PCI_VPD_SRDT_TAG_SIZE;
> 
> This makes the code beautiful.  But I think pci_vpd_size() is too
> picky even now, and this patch makes it more so.
> 
> I don't know why pci_vpd_size() currently checks the tags for
> ID_STRING, RO_DATA, and RW_DATA.  That seems too aggressive to me.
> 

It checks for these tags (+ the end tag) because it's the only ones
defined for VPD by the PCI spec.

> I think these data items originally came from PNP ISA, and it defines
> several other tags.  Of course, that wasn't for PCI devices, but a
> Google search for '"invalid" "vpd tag" "at offset"' does find several
> cases where VPD contains things that look like PNP ISA data items.
> 

Right, the tag format is based on PNP ISA. But PCI spec explicitly
lists the supported tags.
I tried to do the same search and found:
- "invalid short vpd tag 00" and "invalid large tag 7f"
   Both are symptom of a missing optional VPD EEPROM.
- "ixgbe 0000:0b:00.0: invalid short VPD tag 06 at offset 4" and a
  similar message for igb
  I didn't see any response explaining what causes this issue.
  My personal guess: Some OEM provided invalid VPD EEPROM content.
  Offset 4 is the first character of the ID string. The message
  indicates that the ID tag declares an empty ID. That would be weird.

> I think we should compute the VPD size by iterating through it looking
> only at the type (small or large) and the data item length until we
> find the End Tag.
> 

Still I didn't see any example of a rejected valid VPD image.
Not checking for supported tags increases he risk that we interpret
a random byte as tag and read beyond the VPD end, what is known to
cause a freeze on some devices.

> This code originally came from 104daa71b396 ("PCI: Determine actual
> VPD size on first access"), so I added Hannes in case there was some
> reason we do the extra validation.
> 
>> -		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
>> -		    (tag != PCI_VPD_LTIN_RO_DATA) &&
>> -		    (tag != PCI_VPD_LTIN_RW_DATA)) {
>> -			pci_warn(dev, "invalid %s VPD tag %02x at offset %zu",
>> -				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
>> -				 tag, off);
>> +		if (header[0] != PCI_VPD_LRDT_ID_STRING &&
>> +		    header[0] != PCI_VPD_LRDT_RO_DATA &&
>> +		    header[0] != PCI_VPD_LRDT_RW_DATA) {
>> +			pci_warn(dev, "invalid VPD tag %02x at offset %zu", header[0], off);
>>  			return 0;
>>  		}
>> +
>> +		if (pci_read_vpd(dev, off + 1, 2, header + 1) != 2)
>> +			return 0;
>> +
>> +		off += PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(header);
>>  	}
>>  	return 0;
>>  }
>> -- 
>> 2.31.1
>>
>>

