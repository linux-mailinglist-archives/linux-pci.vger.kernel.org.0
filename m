Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F73C9AAE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhGOIem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 04:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGOIel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 04:34:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE0C06175F
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 01:31:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f9so6606581wrq.11
        for <linux-pci@vger.kernel.org>; Thu, 15 Jul 2021 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sUXDXq9O5oxNO4ucFAk/sbTqPstAOcXV4+cgrl8bH8Y=;
        b=b7XLnF0EJI+PzGtEUJXL8iBJkMhcz1HF1XkoijFrFIGAh7ODBLcLzoxrY57a11u/dT
         jty+6PyXHbpWNwN+qpP76ulznB9xJohYMqoOEyIv/64C+y+9aQHjvW2MOc65UNya/X03
         tumFJ2cUO9k93SdicfHKmf8plR7+u9c4hFqNST4I2jh5i5JbfDlTmxP4D5hoJ61ic+qG
         sH07zlmBP4/TkPI4dglPR9BNk4JoVoR7OqXQxP6sS6RV+fYRI5pqefkqVxqMGSDC0wzs
         CuOmx9l88j71AXkoRXgVduQNbza5qv26LiD/jgrJkVo8OGHZhbIU0Mb5FpDdhv/3Svzf
         skdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sUXDXq9O5oxNO4ucFAk/sbTqPstAOcXV4+cgrl8bH8Y=;
        b=M2wE9BUlurfeR5G8jS2F/ildXITDEBQBro5CUXyA2GSkN4WERhPxrDPpzvpbDNkE6D
         DwQi6bMXr4/sHbE/djEzKl18kcPR9tLa/mGKaTJUxTIl1nboOAlhHuKhcML1u0jHosp0
         ySqqFiOqHlt6WRoQ9hx+qPSS0mOch36tPYvnVwOqvpaOqRn7OsIL2Z/1V+7fWfPuTtwF
         9cgT4173JUHeAblWosEq+PpCkM3TRF1lV592STl+zDjjoALHN/AbFldPHtMcQdxzhMZm
         rFe+3pTG3o/oX+FhulssScEHzMAmbucXhu2DgCGH2O7kpuHz6GTPS/G0hmyH9NaXKMr+
         u/Vw==
X-Gm-Message-State: AOAM5319tixrhPjPXV9VcSUU49Q/4pQRvw/yIJml2eHmOlTLIYTx+fw2
        X/zA2twD+ySJ4pkRuqo8eTKsNYADMDdhGQ==
X-Google-Smtp-Source: ABdhPJwK9FPaa/oTdab/mim8UCw6MXS/00Wfeh+6PlUPIzHKSIjYyJrC87coMmbGRRW7U9kj+wAAKw==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr3993436wro.232.1626337907037;
        Thu, 15 Jul 2021 01:31:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3f:3d00:a44e:35f:5dc8:75e? (p200300ea8f3f3d00a44e035f5dc8075e.dip0.t-ipconnect.de. [2003:ea:8f3f:3d00:a44e:35f:5dc8:75e])
        by smtp.googlemail.com with ESMTPSA id 139sm5261924wma.32.2021.07.15.01.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:31:46 -0700 (PDT)
Subject: Re: [PATCH 1/5] PCI/VPD: Refactor pci_vpd_size
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210714155033.GA1781777@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <f0b951c1-088a-5dad-c34f-02c753deba7b@gmail.com>
Date:   Thu, 15 Jul 2021 10:31:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210714155033.GA1781777@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.07.2021 17:50, Bjorn Helgaas wrote:
> On Tue, Jul 13, 2021 at 11:13:31PM +0200, Heiner Kallweit wrote:
>> On 13.07.2021 22:25, Bjorn Helgaas wrote:
>>> [+cc Hannes]
>>>
>>> On Thu, May 13, 2021 at 10:58:40PM +0200, Heiner Kallweit wrote:
>>>> The only Short Resource Data Type tag is the end tag. This allows to
>>>> remove the generic SRDT tag handling and the code be significantly
>>>> simplified.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/pci/vpd.c | 46 ++++++++++++----------------------------------
>>>>  1 file changed, 12 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>>>> index 26bf7c877..ecdce170f 100644
>>>> --- a/drivers/pci/vpd.c
>>>> +++ b/drivers/pci/vpd.c
>>>> @@ -73,50 +73,28 @@ EXPORT_SYMBOL(pci_write_vpd);
>>>>  static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
>>>>  {
>>>>  	size_t off = 0;
>>>> -	unsigned char header[1+2];	/* 1 byte tag, 2 bytes length */
>>>> +	u8 header[3];	/* 1 byte tag, 2 bytes length */
>>>>  
>>>>  	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
>>>> -		unsigned char tag;
>>>> -
>>>>  		if (!header[0] && !off) {
>>>>  			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
>>>>  			return 0;
>>>>  		}
>>>>  
>>>> -		if (header[0] & PCI_VPD_LRDT) {
>>>> -			/* Large Resource Data Type Tag */
>>>> -			tag = pci_vpd_lrdt_tag(header);
>>>> -			/* Only read length from known tag items */
>>>> -			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
>>>> -			    (tag == PCI_VPD_LTIN_RO_DATA) ||
>>>> -			    (tag == PCI_VPD_LTIN_RW_DATA)) {
>>>> -				if (pci_read_vpd(dev, off+1, 2,
>>>> -						 &header[1]) != 2) {
>>>> -					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
>>>> -						 tag, off + 1);
>>>> -					return 0;
>>>> -				}
>>>> -				off += PCI_VPD_LRDT_TAG_SIZE +
>>>> -					pci_vpd_lrdt_size(header);
>>>> -			}
>>>> -		} else {
>>>> -			/* Short Resource Data Type Tag */
>>>> -			off += PCI_VPD_SRDT_TAG_SIZE +
>>>> -				pci_vpd_srdt_size(header);
>>>> -			tag = pci_vpd_srdt_tag(header);
>>>> -		}
>>>> -
>>>> -		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>>>> -			return off;
>>>> +		if (header[0] == PCI_VPD_SRDT_END)
>>>> +			return off + PCI_VPD_SRDT_TAG_SIZE;
>>>
>>> This makes the code beautiful.  But I think pci_vpd_size() is too
>>> picky even now, and this patch makes it more so.
>>>
>>> I don't know why pci_vpd_size() currently checks the tags for
>>> ID_STRING, RO_DATA, and RW_DATA.  That seems too aggressive to me.
>>
>> It checks for these tags (+ the end tag) because it's the only ones
>> defined for VPD by the PCI spec.
>>
>>> I think these data items originally came from PNP ISA, and it defines
>>> several other tags.  Of course, that wasn't for PCI devices, but a
>>> Google search for '"invalid" "vpd tag" "at offset"' does find several
>>> cases where VPD contains things that look like PNP ISA data items.
>>
>> Right, the tag format is based on PNP ISA. But PCI spec explicitly
>> lists the supported tags.
> 
> Yes.  I guess my point is that I think we should make the minimum
> assumptions required by the spec, and we shouldn't make things fail
> because of minor spec violations that don't get in the way of what
> we're trying to accomplish.  Sort of the "be liberal in what you
> accept" idea.
> 
> In this case, we're trying to determine the VPD size.  We don't need
> to know what data types are in the VPD; we only need to know the size
> of each data item, which is determined by the small/large bit and the
> data item length.  The "name" (ID_STRING, RO_DATA, RW_DATA) isn't
> involved at all except that we need to recognize the END tag.
> 
> The value of rejecting unrecognized data types is a bit fuzzy.  Yes,
> it may keep us from reading beyond the VPD end.  But it's no
> guarantee; we can still read beyond the end if the VPD is
> ill-structured (missing END tag, too-large item length, etc).
> 
> The kernel itself doesn't depend on any data from VPD, so I don't
> think it should be in the business of validating that VPD only uses
> the approved data item types.
> 
>> I tried to do the same search and found:
>> - "invalid short vpd tag 00" and "invalid large tag 7f"
>>    Both are symptom of a missing optional VPD EEPROM.
> 
> If we read a tag that is inconsistent, we *have* to stop because we
> can no longer compute the size.  Neither of the trivial cases of a
> missing VPD EEPROM looking like all zeroes or all 0xff can be
> interpreted as valid tags, so it's easy to discard those cases.
> 
> Incidentally, I think we may be able to improve our diagnostic
> messages a bit.  The "Invalid VPD tag 00, assume missing optional VPD
> EPROM" message is good, but the 0xff case isn't quite as clear.
> 
Right, we should handle 0xff together with 0x00. I'll submit a patch
for it.

>> - "ixgbe 0000:0b:00.0: invalid short VPD tag 06 at offset 4" and a
>>   similar message for igb
>>   I didn't see any response explaining what causes this issue.
>>   My personal guess: Some OEM provided invalid VPD EEPROM content.
>>   Offset 4 is the first character of the ID string. The message
>>   indicates that the ID tag declares an empty ID. That would be weird.
>>
>>> I think we should compute the VPD size by iterating through it looking
>>> only at the type (small or large) and the data item length until we
>>> find the End Tag.
>>
>> Still I didn't see any example of a rejected valid VPD image.
>> Not checking for supported tags increases the risk that we interpret
>> a random byte as tag and read beyond the VPD end, what is known to
>> cause a freeze on some devices.
>>
>>> This code originally came from 104daa71b396 ("PCI: Determine actual
>>> VPD size on first access"), so I added Hannes in case there was some
>>> reason we do the extra validation.
>>>
>>>> -		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
>>>> -		    (tag != PCI_VPD_LTIN_RO_DATA) &&
>>>> -		    (tag != PCI_VPD_LTIN_RW_DATA)) {
>>>> -			pci_warn(dev, "invalid %s VPD tag %02x at offset %zu",
>>>> -				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
>>>> -				 tag, off);
>>>> +		if (header[0] != PCI_VPD_LRDT_ID_STRING &&
>>>> +		    header[0] != PCI_VPD_LRDT_RO_DATA &&
>>>> +		    header[0] != PCI_VPD_LRDT_RW_DATA) {
>>>> +			pci_warn(dev, "invalid VPD tag %02x at offset %zu", header[0], off);
>>>>  			return 0;
>>>>  		}
>>>> +
>>>> +		if (pci_read_vpd(dev, off + 1, 2, header + 1) != 2)
>>>> +			return 0;
>>>> +
>>>> +		off += PCI_VPD_LRDT_TAG_SIZE + pci_vpd_lrdt_size(header);
>>>>  	}
>>>>  	return 0;
>>>>  }
>>>> -- 
>>>> 2.31.1
>>>>
>>>>
>>

