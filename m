Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC68C3D9D78
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 08:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhG2GKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 02:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhG2GKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 02:10:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887DEC061757
        for <linux-pci@vger.kernel.org>; Wed, 28 Jul 2021 23:10:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z4so5345829wrv.11
        for <linux-pci@vger.kernel.org>; Wed, 28 Jul 2021 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iKbB3e0LdB9sfD9vM8yygIP15t+TG6FplkTkS4EB6jA=;
        b=Ucjy0HddCmWKDhnmS9ICakKBmnLVnBCQfgbOwIBuBquALyFqL2s+QbtLmYaC27YdSX
         ppHe6q0zxFw6/6IUyRLtKbxn5ZqDZ5BAbe3XRf4IG0+ILdyBEhPr45I5oPGU8s5p5bm9
         +gCFaXUKUPNrZtCxPVorcN+RHdhGwFUJKFp/xCGLOietSPWHEh7dwOtIGPvWkqWXlNuZ
         Z/AnuJbr5NifOSQkRlxhfQ+Tk69w52zUyhqEHFnr/92yfSvQDfW57cFjLy/XZg7EIiFT
         qu82VC2W087MnPH8yseTxIAryRmZheY91lD11f0MmOVH31vb8NalHJ2ModwZKnrXt3En
         +RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iKbB3e0LdB9sfD9vM8yygIP15t+TG6FplkTkS4EB6jA=;
        b=FPrNf0UcmonU/8zSovymWJQ0NFE+dvONAQiPDB/Rjxr7SqV5bIR7tQAOuitxktGA/h
         yWbPQ/208r9BJ+sYvmnLeOq8kCE8GYQVXMFgnB1upbYZaKnAoZY/emF1UZExY5cNpgm8
         HlB+PUiP1YZZlFZhTqM1QQ6QCKK2W4rQt94eAlkZ3Uxj3vdNoueiajWNxzl6aVC9lA4r
         KiHikfuEXSVmadu/zPnA0Erx79dS56ORxf5FTlQNJw3ZbdCTgOvnNmq767wVMas+Zwd7
         qXb9xm/AHK4sYKw+v+zFSZ2A8NH05RyT7yPytG6gOTdB6WJyKPaQiNYPmbHeiBoK3bIK
         oR2A==
X-Gm-Message-State: AOAM532q3iQj6hq1wE4LZ8eLGHxZqwaxK/27qLdtOGNwOIUPyMA8KCpI
        CR+pFgafC8kAxIPNMlnc2a8=
X-Google-Smtp-Source: ABdhPJyuqmU3/EWGKgV/e3RQHqdW00GNmjGG7usm/Szg5FmlQwE+3RZOx27ANEGjSfxMYU0nT0SC9g==
X-Received: by 2002:adf:cd86:: with SMTP id q6mr2825042wrj.422.1627539031219;
        Wed, 28 Jul 2021 23:10:31 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3a:f500:1c4e:4b69:7ee7:669f? (p200300ea8f3af5001c4e4b697ee7669f.dip0.t-ipconnect.de. [2003:ea:8f3a:f500:1c4e:4b69:7ee7:669f])
        by smtp.googlemail.com with ESMTPSA id v5sm2116496wrd.74.2021.07.28.23.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 23:10:30 -0700 (PDT)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210728234245.GA868725@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 3/5] PCI/VPD: Consolidate missing EEPROM checks
Message-ID: <0e9c09b3-c964-2b34-5d67-db013a9258ae@gmail.com>
Date:   Thu, 29 Jul 2021 08:10:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728234245.GA868725@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29.07.2021 01:42, Bjorn Helgaas wrote:
> On Fri, Jul 16, 2021 at 12:16:55AM +0200, Heiner Kallweit wrote:
>> On 15.07.2021 23:59, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> A missing VPD EEPROM typically reads as either all 0xff or all zeroes.
>>> Both cases lead to invalid VPD resource items.  A 0xff tag would be a Large
>>> Resource with length 0xffff (65535).  That's invalid because VPD can only
>>> be 32768 bytes, limited by the size of the address register in the VPD
>>> Capability.
>>>
>>> A VPD that reads as all zeroes is also invalid because a 0x00 tag is a
>>> Small Resource with length 0, which would result in an item of length 1.
>>> This isn't explicitly illegal in PCIe r5.0, sec 6.28, but the format is
>>> derived from PNP ISA, which *does* say "a small resource data type may be
>>> 2-8 bytes in size" (Plug and Play ISA v1.0a, sec 6.2.2.
>>>
>>> Check for these invalid tags and return VPD size of zero if we find them.
>>> If they occur at the beginning of VPD, assume it's the result of a missing
>>> EEPROM.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  drivers/pci/vpd.c | 36 +++++++++++++++++++++++++++---------
>>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>>> index 9b54dd95e42c..9c2744d79b53 100644
>>> --- a/drivers/pci/vpd.c
>>> +++ b/drivers/pci/vpd.c
>>> @@ -77,11 +77,7 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>>>  
>>>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
>>>  		unsigned char tag;
>>> -
>>> -		if (!header[0] && !off) {
>>> -			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
>>> -			return 0;
>>> -		}
>>> +		size_t size;
>>>  
>>>  		if (header[0] & PCI_VPD_LRDT) {
>>>  			/* Large Resource Data Type Tag */
>>> @@ -96,8 +92,16 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>>>  						 off + 1);
>>>  					return 0;
>>>  				}
>>> -				off += PCI_VPD_LRDT_TAG_SIZE +
>>> -					pci_vpd_lrdt_size(header);
>>> +				size = pci_vpd_lrdt_size(header);
>>> +
>>> +				/*
>>> +				 * Missing EEPROM may read as 0xff.
>>> +				 * Length of 0xffff (65535) cannot be valid
>>> +				 * because VPD can't be that large.
>>> +				 */
>>
>> I'm not fully convinced. Instead of checking for a "no VPD EPROM" read (00/ff)
>> directly, we now do it indirectly based on the internal tag structure.
>> We have pci_vpd_lrdt_size() et al to encapsulate the internal structure.
>> IMO the code is harder to understand now.
> 
> I don't quite follow.  Previously we checked for 0x00 data
> ("if (!header[0] && !off)"), but we didn't check directly for 0xff.
> 
> If we read 0xff, we took the PCI_VPD_LRDT case, but it wouldn't match
> ID_STRING, RO_DATA, or RW_DATA, so we'd fall out and check again
> against ID_STRING, RO_DATA, and RW_DATA, and take the "invalid
> %s VPD tag" error path because it doesn't match any.
> 
> This results in failure for any large resource except ID_STRING,
> RO_DATA, and RW_DATA, regardless of the size.
> 
> My proposed code catches a different set of invalid things.
> "size > PCI_VPD_MAX_SIZE" will catch any large resource headers with
> length 0x8001 through 0xffff.
> 
> Possibly it should actually check for "off + size > PCI_VPD_MAX_SIZE"
> so e.g., it would catch a 0x20 byte resource starting at 0x7ff0.
> 

For handling the 0xff case w/o additional overhead the following is pending:
https://patchwork.kernel.org/project/linux-pci/patch/8de8c906-9284-93b9-bb44-4ffdc3470740@gmail.com/

As far as I can see the VPD structure hasn't changed since it was
introduced in PCI 2.2. This was how many years ago?
Instead of adding code at least my personal objective would be
to make support for such legacy features as simple and maintainable
as possible.

>>> +				if (size > PCI_VPD_MAX_SIZE)
>>> +					goto error;
>>> +				off += PCI_VPD_LRDT_TAG_SIZE + size;
>>>  			} else {
>>>  				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
>>>  					 tag, off);
>>> @@ -105,14 +109,28 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>>>  			}
>>>  		} else {
>>>  			/* Short Resource Data Type Tag */
>>> -			off += PCI_VPD_SRDT_TAG_SIZE +
>>> -				pci_vpd_srdt_size(header);
>>>  			tag = pci_vpd_srdt_tag(header);
>>> +			size = pci_vpd_srdt_size(header);
>>> +
>>> +			/*
>>> +			 * Missing EEPROM may read as 0x00.  A small item
>>> +			 * must be at least 2 bytes.
>>> +			 */
>>> +			if (size == 0)
>>> +				goto error;
>>> +
>>> +			off += PCI_VPD_SRDT_TAG_SIZE + size;
>>>  			if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>>>  				return off;
>>>  		}
>>>  	}
>>>  	return 0;
>>> +
>>> +error:
>>> +	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
>>> +		 header[0], off, off == 0 ?
>>> +		 "; assume missing optional EEPROM" : "");
>>> +	return 0;
>>>  }
>>>  
>>>  /*
>>>
>>

