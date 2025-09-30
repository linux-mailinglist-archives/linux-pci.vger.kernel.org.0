Return-Path: <linux-pci+bounces-37263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCABADC51
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B1188FC0A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2320303C93;
	Tue, 30 Sep 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJlUN5Xw"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9E2FD1DD
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245795; cv=none; b=OBInXchQsCOzSrCxLUDIfuHcRRhNzysnPb+LpA7l98wDlm2p0cRpFPuEy6yQLmj+rwVURbzxnUyXQudHLRiIRg0J+SC7Ml9fKdCulzpHeBD7oUXxQkeXzxmZS5MThMwQLzeUOu3/Qmfs5AyLLTtL4BLIApDlOkHekAfp7aAoXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245795; c=relaxed/simple;
	bh=kwWN1ojFN23w2IyndKFywgE+0NXKrHOWeVJ1sBs3XHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwauMudofmTct0xZ8wMAxb9kzPSSAqeMUKyEnscRvyZV83urjY46vutjqLArb2ezpSkOO4bUOjIGOhKNX/0RWqB9bg+LCqixAudtb+4WVXlGyzlQrY4SSUY9ZHiUCNvMPmfgrIQnlJfcwkpw7zjxFBTpDSD+HrI+DN5RXsdzxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJlUN5Xw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759245792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsuyPtDK6XJK760Eoqkd4wK0OmUB8NIH50EbT0njy7Q=;
	b=NJlUN5Xwnv+Rq93i7FzWlvQM4VVtDB3r2n1fs1Vg3byKXLxoQG22xSqHt/z8xG0BGkYTne
	QgZ97DwqADEfrHskO6Q0vl1nYmTbDGDPrBCp54TMA8UDDvAbbe6OOhseByUUFMTWM5TWIj
	jupNqboHlcPsROaqlg1Fng5sArYtXUo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-pqtSLfFAP6ycwYDHuVQ08Q-1; Tue, 30 Sep 2025 11:23:10 -0400
X-MC-Unique: pqtSLfFAP6ycwYDHuVQ08Q-1
X-Mimecast-MFC-AGG-ID: pqtSLfFAP6ycwYDHuVQ08Q_1759245790
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-859b89cd3f2so1317985185a.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245790; x=1759850590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsuyPtDK6XJK760Eoqkd4wK0OmUB8NIH50EbT0njy7Q=;
        b=PNKmmFYmRTPj2MTgw1wQyR84iAQeoGhbzLppJCQhnt7a8otDZSKZugTYsrIuhaHHMT
         VgZ6a/z40LCIO0H8QRmn/vUxvdcRYRTDg3vPVNnsahMLf7xa6KgCN7Ia6TMUFutLPBEb
         7Z6PDq7nUUtOWHfXP65fzzc7A7MFTukj6K3hZqmeCKLTmwkzZqNsF8lsai6A4/Q7QCDu
         O8Tw2BIQoi6vwG8flk0LFnEAavz4dTZn1BdOHEiiQilGjY5NIqUWe6Bin4qy7n5y/gkt
         Q0hgu8LBFzoc3eTG/Y/PWMujY+MB3N5nRB0s3YpqUMcgzX/Gr0/KxRocK88ohcKRsj+r
         jRcg==
X-Forwarded-Encrypted: i=1; AJvYcCVE3F0oSngFwv1v971RtH3oiqM8U+/hfALAslPUbGz54q8dvu0086LZWMxNE6jJu3RbjS5FBUpi65s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UDumkuyBLNC0/d5NAmbtARn+rnviH/5eJhofbjFEWHFpASRI
	NjUIAlPSzj9nh+WxBGLmu7QWXObssZtzPcoqZynn4in1bIq2x49X0u/PgYkzTvqJsfmAtcBO+uJ
	mbLdUw0GaGdh/5lM2ilQ88HxTtqfdTpx6ccEf4mcd9pl1jayGsPzbXCyU99yQuA==
X-Gm-Gg: ASbGncv5mIoy+KtvJEW4ZiTIU0s7D/A+MD6qOx3vsQG1qxG0/okz9IIuUQtYL4sSLek
	yExYibc+RZOWkRBWp7vVY68VljymTggi6/lRb9gvr1558hClm2TYmEGB0aDg1VQDXipnoDZqTZY
	DGxe5CZ7Y0qEQymtPFl+79GcbyAAbBfvSfAMyGzskJ8aXGmvAZGFj+QfKLMY1Gy6w4PzXVDG0CY
	+nnwudWZjNWprcOLXUcsk7N77Nzz2AJ/Av7DQvfizJQlszxzpq6EwMp24Zsqk/ddqP3FyTfW4l9
	2utXE5TRUM+gUTCS2q5bDPJSHJ5EFWS3ZRvN9Pm4gD7Vpw==
X-Received: by 2002:a05:620a:290d:b0:870:66d5:5284 with SMTP id af79cd13be357-87375854bdamr22871385a.51.1759245789802;
        Tue, 30 Sep 2025 08:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoV0XR/bU5/GBGvKDQ/F8SMF4jsGamSO5DIEeVU6HtXJ5tudJzUxrgoBnOdQayLxjabnl6Gg==
X-Received: by 2002:a05:620a:290d:b0:870:66d5:5284 with SMTP id af79cd13be357-87375854bdamr22863685a.51.1759245789173;
        Tue, 30 Sep 2025 08:23:09 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c28a8a7b5sm1070665585a.26.2025.09.30.08.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:23:08 -0700 (PDT)
Message-ID: <8e679dad-b16d-45e3-b844-fa30b5a574ee@redhat.com>
Date: Tue, 30 Sep 2025 11:23:06 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Fix incorrect iommu_groups with PCIe ACS
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 galshalom@nvidia.com, Joerg Roedel <jroedel@suse.de>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, maorg@nvidia.com,
 patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu <tony.zhu@intel.com>
References: <0-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com>
 <20250922163947.5a8304d4.alex.williamson@redhat.com>
 <e9d4f76a-5355-4068-a322-a6d5c081e406@redhat.com>
 <20250922200654.1d4ff8b8.alex.williamson@redhat.com>
 <0eb2e721-8b9c-40d0-afe7-c81c6b765f49@redhat.com>
 <20250923162337.5ab1fe89.alex.williamson@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250923162337.5ab1fe89.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


note: I removed Joerg's suse email address & Tony's intel address as I keep getting numerous undeliverable emails when those are included in cc:

On 9/23/25 6:23 PM, Alex Williamson wrote:
> On Mon, 22 Sep 2025 22:42:37 -0400
> Donald Dutile <ddutile@redhat.com> wrote:
> 
>> On 9/22/25 10:06 PM, Alex Williamson wrote:
>>> On Mon, 22 Sep 2025 21:44:27 -0400
>>> Donald Dutile <ddutile@redhat.com> wrote:
>>>    
>>>> On 9/22/25 6:39 PM, Alex Williamson wrote:
>>>>> On Fri,  5 Sep 2025 15:06:15 -0300
>>>>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>       
>>>>>> The series patches have extensive descriptions as to the problem and
>>>>>> solution, but in short the ACS flags are not analyzed according to the
>>>>>> spec to form the iommu_groups that VFIO is expecting for security.
>>>>>>
>>>>>> ACS is an egress control only. For a path the ACS flags on each hop only
>>>>>> effect what other devices the TLP is allowed to reach. It does not prevent
>>>>>> other devices from reaching into this path.
>>>>>>
>>>>>> For VFIO if device A is permitted to access device B's MMIO then A and B
>>>>>> must be grouped together. This says that even if a path has isolating ACS
>>>>>> flags on each hop, off-path devices with non-isolating ACS can still reach
>>>>>> into that path and must be grouped gother.
>>>>>>
>>>>>> For switches, a PCIe topology like:
>>>>>>
>>>>>>                                   -- DSP 02:00.0 -> End Point A
>>>>>>     Root 00:00.0 -> USP 01:00.0 --|
>>>>>>                                   -- DSP 02:03.0 -> End Point B
>>>>>>
>>>>>> Will generate unique single device groups for every device even if ACS is
>>>>>> not enabled on the two DSP ports. It should at least group A/B together
>>>>>> because no ACS means A can reach the MMIO of B. This is a serious failure
>>>>>> for the VFIO security model.
>>>>>>
>>>>>> For multi-function-devices, a PCIe topology like:
>>>>>>
>>>>>>                      -- MFD 00:1f.0 ACS not supported
>>>>>>      Root 00:00.00 --|- MFD 00:1f.2 ACS not supported
>>>>>>                      |- MFD 00:1f.6 ACS = REQ_ACS_FLAGS
>>>>>>
>>>>>> Will group [1f.0, 1f.2] and 1f.6 gets a single device group. However from
>>>>>> a spec perspective each device should get its own group, because ACS not
>>>>>> supported can assume no loopback is possible by spec.
>>>>>
>>>>> I just dug through the thread with Don that I think tries to justify
>>>>> this, but I have a lot of concerns about this.  I think the "must be
>>>>> implemented by Functions that support peer-to-peer traffic with other
>>>>> Functions" language is specifying that IF the device implements an ACS
>>>>> capability AND does not implement the specific ACS P2P flag being
>>>>> described, then and only then can we assume that form of P2P is not
>>>>> supported.  OTOH, we cannot assume anything regarding internal P2P of an
>>>>> MFD that does not implement an ACS capability at all.
>>>>>       
>>>> The first, non-IF'd, non-AND'd req in PCIe spec 7.0, section 6.12.1.2 is:
>>>> "ACS P2P Request Redirect: must be implemented by Functions that
>>>> support peer-to-peer traffic with other Functions. This includes
>>>> SR-IOV Virtual Functions (VFs)." There is not further statement about
>>>> control of peer-to-peer traffic, just the ability to do so, or not.
>>>>
>>>> Note: ACS P2P Request Redirect.
>>>>
>>>> Later in that section it says:
>>>> ACS P2P Completion Redirect: must be implemented by Functions that
>>>> implement ACS P2P Request Redirect.
>>>>
>>>> That can be read as an 'IF Request-Redirect is implemented, than ACS
>>>> Completion Request must be implemented. IOW, the Completion Direct
>>>> control is required if Request Redirect is implemented, and not
>>>> necessary if Request Redirect is omitted.
>>>>
>>>> If ACS P2P Require Redirect isn't implemented, than per the first
>>>> requirement for MFDs, the PCIe device does not support peer-to-peer
>>>> traffic amongst its function or virtual functions.
>>>>
>>>> It goes on...
>>>> ACS Direct Translated P2P: must be implemented if the Function
>>>> supports Address Translation Services (ATS) and also peer-to-peer
>>>> traffic with other Functions.
>>>>
>>>> If an MFD does not do peer-to-peer, and P2P Request Redirect would be
>>>> implemented if it did, than this ACS control does not have to be
>>>> implemented either.
>>>>
>>>> Egress control structures are either optional or dependent on Request
>>>> Redirect &/or Direct Translated P2P control, which have been
>>>> addressed above as not needed if on peer-to-peer btwn functions in an
>>>> MFD (and their VFs).
>>>>
>>>>
>>>> Now, if previous PCIe spec versions (which I didn't read & re-read &
>>>> re-read like the 6.12 section of PCIe spec 7.0) had more IF and ANDs,
>>>> than that could be cause for less than clear specmanship enabling
>>>> vendors of MFDs to yield a non-PCIe-7.0 conformant MFD wrt ACS
>>>> structures. I searched section 6.12.1.2 for if/IF and AND/and, and
>>>> did not yield any conditions not stated above.
>>>
>>> Back up to 6.12.1:
>>>
>>>     ACS functionality is reported and managed via ACS Extended Capability
>>>     structures. PCI Express components are permitted to implement ACS
>>>     Extended Capability structures in some, none, or all of their
>>>     applicable Functions. The extent of what is implemented is
>>>     communicated through capability bits in each ACS Extended Capability
>>>     structure. A given Function with an ACS Extended Capability structure
>>>     may be required or forbidden to implement certain capabilities,
>>>     depending upon the specific type of the Function and whether it is
>>>     part of a Multi-Function Device.
>>>    
>> Right, depending on type of function or part of MFD.
>> Maybe I mis-understood your point, or vice-versa:
>> section 6.12.1.2 is for MFDs, and I was only discussing MFD ACS structs.
>> I did not mean to imply the sections I was quoting was for anything but an MFD.
> 
> I'm really going after the first half of that last sentence rather than
> any specific device type:
> 
>    A given Function with an ACS Extended Capability structure may be
>    required or forbidden to implement certain capabilities...
> 
> "...[WITH] an ACS Extended Capbility structure..."
> 
> "implement certain capabilities" is referring to the capabilities
> exposed within the capability register of the overall ACS extended
> capability structure.
> 
> Therefore when section 6.12.1.2 goes on to say:
> 
>    ACS P2P Request Redirect: must be implemented by Functions that
>    support peer-to-peer traffic with other Functions.
> 
> This is saying this type of function _with_ an ACS extended capability
> (carrying forward from 6.12.1) must implement the p2p RR bit of the ACS
> capability register (a specific bit within the register, not the ACS
> extended capability) if it is capable of p2p traffic with other
> functions.  We can only infer the function is not capable of p2p traffic
> with other functions if it both implements an ACS extended capability
> and the p2p RR bit of the capability register is zero.
> 
>>> What you're quoting are the requirements for the individual p2p
>>> capabilities IF the ACS extended capability is implemented.
>>>    
>> No, I'm not.  I'm quoting 6.12.1.2, which is MFD-specific.
>>
>>> Section 6.12.1.1 describing ACS for downstream ports begins:
>>>
>>>     This section applies to Root Ports and Switch Downstream Ports
>>>    that implement an ACS Extended Capability structure.
>>>
>>> Section 6.12.1.2 for SR-IOV, SIOV and MFDs begins:
>>>
>>>     This section applies to Multi-Function Device ACS Functions,
>>>    with the exception of Downstream Port Functions, which are
>>>    covered in the preceding section.
>>>    
>> Right.  I wasn't discussing Downstream port functions.
>>
>>> While not as explicit, what is a Multi-Function Device ACS Function
>>>    if not a function of a MFD that implements ACS?
>>>    
>> I think you are inferring too much into that less-than-optimally
>>    worded section.
>>
>>>>> I believe we even reached agreement with some NIC vendors in the
>>>>> early days of IOMMU groups that they needed to implement an
>>>>>    "empty" ACS capability on their multifunction NICs such that
>>>>>    they could describe in this way that internal P2P is not
>>>>>    supported by the device.  Thanks,
>>>> In the early days -- gen1->gen3 (2009->2015) I could see that
>>>> happening. I think time (a decade) has closed those defaults to
>>>> less-common quirks. If 'empty ACS' is how they liked to do it back
>>>> than, sure. [A definition of empty ACS may be needed to fully
>>>> appreciate that statement, though.] If this patch series needs to
>>>> support an 'empty ACS' for this older case, let's add it now, or
>>>> follow-up with another fix.
>>>
>>> An "empty" ACS capability is an ACS extended capability where the
>>>    ACS capability register reads as zero, precisely to match the
>>>    spec in indicating that the device does not support p2p.  Again,
>>>    I don't see how time passing plays a role here.  A MFD must
>>>    implement ACS to infer anything about internal p2p behavior.
>>>      
>> Again, I don't read the 'must' in the spec.
>> Although I'll agree that your definition of an empty ACS makes it
>>    unambiguous.
>>
>>>> In summary, I still haven't found the IF and AND you refer to in
>>>> section 6.12.1.2 for MFDs, so if you want to quote those sections I
>>>> mis-read, or mis-interpreted their (subtle?) existence, than I'm
>>>>    not immovable on the spec interpretation.
>>>
>>> As above, I think it's covered by 6.12.1 and the introductory
>>>    sentence of 6.12.1.2 defining the requirements for ACS functions.
>>>     Thanks,
>> 6.12.1 is not specific enough about what MFDs must or must not
>>    support; it's a broad description of ACS in different PCIe
>>    functions. As for 6.12.1.2, I stand by the statement that ACS P2P
>>    Request Redirect must be implemented if peer-to-peer is implemented
>>    in an MFD. It's not inferred, it's not unambiguous.
>> You are intepreting the first sentence in 6.12.1.2 as indirectly
>>    saying that the reqs only apply to an MFD with ACS.  The title of
>>    the section is: "ACS Functions in SR-IOV, SIOV, and Multi-Function
>>    Devices"  not ACS requirements for ACS-controlled SR-IOV, SIOV, and
>>    Multi-Function Devices", in which case, I could agree with the
>>    interpretation you gave of that first sentence.
>>
>> I think it's time to reach out to the PCI-SIG, and the authors of
>>    this section to dissect these interpretations and get some clarity.
> 
> You're welcome to.  I think it's sufficiently clear.
> 
> The specification is stating that if a function exposes an ACS extended
> capability and the function supports p2p with other functions, it must
> implement that specific bit in the ACS capability register of the ACS
> extended capability.
> 
> Therefore if the function implements an ACS extended capability and
> does not implement this bit in the ACS capability register, we can
> infer that the device does is not capable of p2p with other functions.
> It would violate the spec otherwise.
> 
> However, if the function does not implement an ACS extended capability,
> we can infer nothing.
> 
> It's logically impossible for the specification to add an optional
> extended capability where the lack of a function implementing the
> extended capability implies some specific behavior.  It's not backwards
> compatible, which is a fundamental requirement of the PCI spec.  Thanks,
> 
> Alex
> 
This is boiling down to an interpretation of the spec.

If the latest PCI-v7 spec is not backward compatible, that a function within an MFD
not having an ACS struct must not be isolated from other functions within the MFD without an ACS struct,
then the current Linux implementation/interpretation, and the need for the acs quirks
when hw vendors improperly omit the ACS structure, is the safest/secure route to go.

Historical/legacy implementations of MFDs without ACS structs have bolstered that
position/interpretation/agreed-to-required-acs-quicks implementation.
The small number of acs quirks also seems to support that past interpretation.

I believe a definitive answer from the PCI-SIG would be best, especially wrt
backward compatibility.  Such a review & feedback is likely to take quite some
time.  Thus, taking the current-conservative approach for omitted ACS structs for
MFD functions would allow this series to progress with the numerous other bug-fixes
that are needed, with a minor change to the MFD iommu-group check/creation function
to use acs-quirks to create better isolation groups if a hw vendor interprets and
implements no ACS as having no p2p connectivity.

- Don



