Return-Path: <linux-pci+bounces-7354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB718C236F
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3522865D4
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C11779B8;
	Fri, 10 May 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="esPKBCkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33C172790
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340461; cv=none; b=dma8AeVYnA5vBQnEWadoAUtPdN7OPSFl57tS2yxUBjaNrEvjk892zhvLA4eZK6/dM68F6zkhE60vLkPB+mmgjKmjH2qr1hegg3EeluWKw9SVXckMkeIe6gK65RFwkDvsWTss0WVirNofgzWPegm3CCYvpKAuClS2CPJPLojeD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340461; c=relaxed/simple;
	bh=zNXwSOWeBMueOtABnUo69wqjco2rwqNtJ/nGjlKDC3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZlVRIRhxIGlvDHxuu8mzIp7JjTtDv8FCdQJt7Q+5ifDHiUcYVTLpHRDXtlEmulmxva0Oee8ndWf9WlJ1RosebsikIMW1bwVMMKwRy5ybJZTH30Gu34GShrn9BXjKNtHBoGIn4/qy/cITI5LzAwk58U9vMd8W28t1IYabZ6o504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=esPKBCkP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a1192c664so504873766b.2
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715340458; x=1715945258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNXwSOWeBMueOtABnUo69wqjco2rwqNtJ/nGjlKDC3g=;
        b=esPKBCkP7bBK7iPHa/ipNqAmhGzxdtQaZC9mLpj2zYIyTClXdxfgcBX8gRK5mRc1qt
         xmTcu9T7Ip+xWL8I5FPoNVvnxv4bXzLfFKqqZgPG0N9L36a85vuTLAtmC5R40i3DOTk7
         jEki5Les6qHJZlFdONe/8r7esYGgqHWrIGYIX2RSmQ22WbdEaSGIUDr2oB3kiahHowfd
         /XsdHSb4z9s1iYf13qZK8AIPsys5NzMb/ZEPuq00sJdaeaZPbOZenJeQoK2cPw/ki+rR
         79zGzHLpz0R0cSdOd3Eh3TOf6+YQ9droAkmB4BBubg1agX9gM7sIn/2drvoNSJQNcVw/
         7P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340458; x=1715945258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNXwSOWeBMueOtABnUo69wqjco2rwqNtJ/nGjlKDC3g=;
        b=i1vLCMiIkCZytuL7RCcb5vNSLc1bkXCTbNDpbH5EbAJlzBJWd4rN6m+bY2rQHVwuen
         KI4VnV2NO8E5sOOg3gw99IGO36nfdB9LA6MD1i+cjad+Op00eVAYcdACxfZe24iDHR47
         UuimVyOq/sFNREyrbC/TdEgc08MmM8XlkMdHUvZSVUy6RjZ1iv2dcvJuXcqClGazXyji
         d2dER2qrkfIeyxnXeWLtuTQDWi7APBgta0wdz9rE78arQJKzGnIVUs2i5WhxYxJC7VSN
         ei+JsPgD7sQcj/JLUVq6g4UnyDzO6RvOh0vy7q4ipHtq3GR2OwrdBg04ygOhyOZa61pX
         UjWw==
X-Forwarded-Encrypted: i=1; AJvYcCVrPY31TqOrH3lnBuyyyslTGXLIsxmms/exO7cyrEPShWmkLUBpSeV2YrLUEc3BOD1efmDun50PvE3yllbLQ/PSKAy3a9uXv0jg
X-Gm-Message-State: AOJu0Ywsih7xgLwCjc6n2DrbkHodCk5rJQIh1pN6c1ngGaMip7L3bmMs
	8LqlBHzLfmHKFpRWhFty6ETaXLfA7o41OSSTiJrGuR5WD7z4WNVYzd8woMsysAU=
X-Google-Smtp-Source: AGHT+IGWH9NtKldOHxG5Jn85QZLrAtp/ZGMY4ac6yPg5kx3Hs4lPh9R3ZW28bnofErwGNFhMNfHAYA==
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr2421443a12.21.1715340458312;
        Fri, 10 May 2024 04:27:38 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea651asm1706341a12.11.2024.05.10.04.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 04:27:38 -0700 (PDT)
Message-ID: <0aac68ac-cf40-4c3d-ac02-95b9a37aaa11@suse.com>
Date: Fri, 10 May 2024 13:27:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
 <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <d0b5e7d5-3503-49be-9fa3-4b79c62059ca@suse.com>
 <BL1PR12MB5849F1DE8B4A3538C79CE5D3E7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <BL1PR12MB5849F1DE8B4A3538C79CE5D3E7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.05.24 12:32, Chen, Jiqian wrote:
> On 2024/5/10 18:21, Jürgen Groß wrote:
>> On 10.05.24 12:13, Chen, Jiqian wrote:
>>> On 2024/5/10 17:53, Jürgen Groß wrote:
>>>> On 10.05.24 11:06, Chen, Jiqian wrote:
>>>>> Hi,
>>>>>
>>>>> On 2024/5/10 14:46, Jürgen Groß wrote:
>>>>>> On 19.04.24 05:36, Jiqian Chen wrote:
>>>>>>> +
>>>>>>> +    info->type = IRQT_PIRQ;
>>>>> I am considering whether I need to use a new type(like IRQT_GSI) here to distinguish with IRQT_PIRQ, because function restore_pirqs will process all IRQT_PIRQ.
>>>>
>>>> restore_pirqs() already considers gsi == 0 to be not GSI related. Isn't this
>>>> enough?
>>> No, it is not enough.
>>> xen_pvh_add_gsi_irq_map adds the mapping of gsi and irq, but the value of gsi is not 0,
>>> once restore_pirqs is called, it will do PHYSDEVOP_map_pirq for that gsi, but in pvh dom0, we shouldn't do PHYSDEVOP_map_pirq.
>>
>> Okay, then add a new flag to info->u.pirq.flags for that purpose?
> I feel like adding "new flag to info->u.pirq.flags" is not as good as adding " new type to info->type".
> Because in restore_pirqs, it considers " info->type != IRQT_PIRQ", if adding " new flag to info->u.pirq.flags", we need to add a new condition in restore_pirqs.
> And actually this mapping(gsi and irq of pvh) doesn't have pirq, so it is not suitable to add to u.pirq.flags.

Does this mean there is no other IRQT_PIRQ related activity relevant for those
GSIs/IRQs? In that case I agree to add IRQT_GSI.


Juergen

