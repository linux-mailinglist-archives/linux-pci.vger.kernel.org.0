Return-Path: <linux-pci+bounces-26511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309CCA98510
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03AD37AF75A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CD25C807;
	Wed, 23 Apr 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RYspRLmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6A223DFE
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399542; cv=none; b=SHOXI6p+4SGRZLJkXXroxK8m3ilaWX8b6y22IfI28IESyNg/KfWbGxuAcztQGHyTGzrWNvEs4UIhLxACtvfn9eFwZfV3hR0EzSIxIoiIKFOzsHhXbl4kl6XbWkJCSWlL2LS8sT3rFtKx5FhCHOvWLo7LqA0BNIpMHtS+hQ1EL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399542; c=relaxed/simple;
	bh=de1r1o2u9lGBX4KI8lIOzHQacrEwN8MR7tL+rtn6y+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZydpmrBdcpgqTfiLmgKW1sqAFheP4QvfBExr9AP6lc0oxQfs8VpEx4+dcTYGE3wvx04oJsmcUrOJTsOrXcPFbF4bttWSQ1AJZF6+Pna+jnWnvjTLRYTnc5qMDaysr3Mn1+uowTbohk1chG+yL18hcseBbSQOjWVQwgSYVgcrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RYspRLmC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 04DAA41A30
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745399538;
	bh=rRzYjzT3WDJpMJezd9qFsBfMHFovYScnhtnYa/Dy/yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RYspRLmCYC5A0OHyJ4mfmVDNANhKkPXRLbl07tK8rdwwnbeONT9NwQYrdE896QBiQ
	 o66HFhLKpgJLFrtBRJCK9/uGBBUErFq4cscOhOcRCgcqlUYiFKrTm8c+OSh3PwXGmA
	 hK0GmovKj+cQsz30ELiHxF6vHmzTu03AZukjmiVyixeudM/CXVs4Kcyb4x/NUyhL0M
	 2EjauSkhtPTxOP/3zBzt80tnDBreA8iOjwXTJjXDeFZTlb9+GNsYYAq/kqN8BBLyw1
	 Le0Dw/KEiVMKwPJJHdWRh04awsR5+H1lKxY7Ip5R9Nm2jgj24fIrJZY3OpeTgVqCLF
	 SR8ASViEtO++w==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d22c304adso2721385e9.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 02:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745399535; x=1746004335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRzYjzT3WDJpMJezd9qFsBfMHFovYScnhtnYa/Dy/yw=;
        b=P0ffaqz6ZeoCA1k2pAVeY106Xrylxws80c5Y0fM6H1JeIo2uCEy4BeYRqVdJauJV7s
         hKkbKg6FYXwwA+1E9Ky4P1qJiVMhwHMwN4SE3Iutq59KuCC+p7CXoBx7fcDTvowZNALD
         wZbJT0XFcMnZ0B/1ujs5+10S2j0AC4ZAjbfLyTjLblqEOShXCDjG2c7x0+pqbcqffa9Z
         /6FWzfOogXSq5n1hCC5l7lrLOeIGHPv58UK7B3jL77CXYOBBxcJf+cn/vidRZ4R0Alpm
         ZA2+fk/tNIg04omdvBYwkPkCxpIeVrugNGm3QiSoi8veKfoCkujeeUFzNRXzZWkrmfwY
         bcyw==
X-Forwarded-Encrypted: i=1; AJvYcCW31oQQpgrctM+bHLaXEXMUNh7rzT3snw2X8F5p9R84z05F0HTfFYsSsNoUnUtQLCJ4U7N02TE+0pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FUQPO/8cR4174xPPOtoUG0rOPBc/7K5608fU7EEz9oI4y6ac
	JmcsAvtmlKt6K2f08OmLwUIicnQF7lO2hdj0MWXCfq0NPhwTunvzyr2vTR31zxDa+TTR7Epb7Cr
	jizQGiEwJRzwgpxB809ro6NPI2Fifvjz5XQPnS5iawUA9GX9m9KqlaSSPuNDe8fTab/easXVqsb
	vE4PsYPMHYt1YcCs1vkJg/vxD4q3ZnJ6e9MP8dvQTFUF2+/Nvs
X-Gm-Gg: ASbGnctq/GesHzBLdkeZEGAJNDVtO7VLLW8H16vCt3SLnCKrO/sOHYHjmab3agyaMSj
	pBtTQlx7MJ2XL+lNTVCysLymxXJuwTqUVOs1eh1dw/uyXC+MdCO3Ew3v04boChzuwRzRLYA==
X-Received: by 2002:a05:600d:a:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-44092d9db46mr16915215e9.14.1745399534877;
        Wed, 23 Apr 2025 02:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNWXSk9foZwQq3PNothLWFONL+TEe1gc+Hom1pXzJ1+KM4OJAQbWuk7BYcKSu/hSgMUi94sYl7iXFeZe7wnuQ=
X-Received: by 2002:a05:600d:a:b0:43c:ec72:3daf with SMTP id
 5b1f17b1804b1-44092d9db46mr16914935e9.14.1745399534529; Wed, 23 Apr 2025
 02:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418193411.GA168278@bhelgaas> <74142526-b11a-4b31-b3f4-09391ed7927c@intel.com>
 <CAMqyJG1nm2mYnsXeF=h_xM_0ydAVFK9gdEznJO8hwd-B_2sm_w@mail.gmail.com>
In-Reply-To: <CAMqyJG1nm2mYnsXeF=h_xM_0ydAVFK9gdEznJO8hwd-B_2sm_w@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 23 Apr 2025 17:12:03 +0800
X-Gm-Features: ATxdqUHI33eM4qfMxz3S3rPsmdmY-rrMO06WwiUJdELGj_noXFNpLYEbrbU5O10
Message-ID: <CAMqyJG3YfKZ9LX4C2OuhPMrKTNGr=tHFquwnNiZBEb7JsXnurQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3] igc: return early when failing to read EECD register
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, vitaly.lifshits@intel.com, dima.ruinskiy@intel.com, 
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, Mor Bar-Gabay <morx.bar.gabay@intel.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sure, I'll access the machine and do the debugging next week.

Thanks,
En-Wei.


On Wed, 23 Apr 2025 at 17:10, En-Wei WU <en-wei.wu@canonical.com> wrote:
>
> Sure, I'll access the machine and do the debugging next week.
>
> Thanks,
> En-Wei.
>
> On Wed, 23 Apr 2025 at 01:16, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>>
>>
>>
>> On 4/18/2025 12:34 PM, Bjorn Helgaas wrote:
>> > [+cc Kalesh, Przemek, linux-pci]
>> >
>> > On Tue, Jan 07, 2025 at 11:01:47AM -0800, Tony Nguyen wrote:
>> >> From: En-Wei Wu <en-wei.wu@canonical.com>
>> >>
>> >> When booting with a dock connected, the igc driver may get stuck for ~40
>> >> seconds if PCIe link is lost during initialization.
>> >>
>> >> This happens because the driver access device after EECD register reads
>> >> return all F's, indicating failed reads. Consequently, hw->hw_addr is set
>> >> to NULL, which impacts subsequent rd32() reads. This leads to the driver
>> >> hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
>> >> prevents retrieving the expected value.
>> >>
>> >> To address this, a validation check and a corresponding return value
>> >> catch is added for the EECD register read result. If all F's are
>> >> returned, indicating PCIe link loss, the driver will return -ENXIO
>> >> immediately. This avoids the 40-second hang and significantly improves
>> >> boot time when using a dock with an igc NIC.
>> >>
>> >> Log before the patch:
>> >> [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> >> [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
>> >> [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
>> >> [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
>> >> [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
>> >> [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> >> [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
>> >>
>> >> Log after the patch:
>> >> [    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> >> [    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
>> >> [    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
>> >> [    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
>> >> [    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity
>> >>
>> >> Fixes: ab4056126813 ("igc: Add NVM support")
>> >> Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>> >> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
>> >> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> >> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
>> >> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> >> ---
>> >>   drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
>> >>   1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
>> >> index 9fae8bdec2a7..1613b562d17c 100644
>> >> --- a/drivers/net/ethernet/intel/igc/igc_base.c
>> >> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
>> >> @@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
>> >>      u32 eecd = rd32(IGC_EECD);
>> >>      u16 size;
>> >>
>> >> +    /* failed to read reg and got all F's */
>> >> +    if (!(~eecd))
>> >> +            return -ENXIO;
>> >
>> > I don't understand this.  It looks like a band-aid that makes boot
>> > faster but doesn't solve the real problem.
>> >
>> > In its defense, I guess that with this patch, the first igc probe
>> > fails, and then for some reason we attempt another a few seconds
>> > later, and the second igc probe works fine, so the NIC actually does
>> > end up working correct, right?
>> >
>> > I think the PCI core has some issues with configuring ASPM L1.2, and I
>> > wonder if those are relevant here.  If somebody can repro the problem
>> > (i.e., without this patch, which looks like it appeared in v6.13 as
>> > bd2776e39c2a ("igc: return early when failing to read EECD
>> > register")), I wonder if you could try booting with "pcie_port_pm=off
>> > pcie_aspm.policy=performance" and see if that also avoids the problem?
>> >
>> > If so, I'd like to see the dmesg log with "pci=earlydump" and the
>> > "sudo lspci -vv" output when booted with and without "pcie_port_pm=off
>> > pcie_aspm.policy=performance".
>>
>> We weren't able to get a repro here.
>>
>> En-Wei would you be able to provide this to Bjorn?
>>
>> Thanks,
>> Tony
>>
>> >>      size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
>> >>
>> >>      /* Added to a constant, "size" becomes the left-shift value
>> >> @@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
>> >>
>> >>      /* NVM initialization */
>> >>      ret_val = igc_init_nvm_params_base(hw);
>> >> +    if (ret_val)
>> >> +            goto out;
>> >>      switch (hw->mac.type) {
>> >>      case igc_i225:
>> >>              ret_val = igc_init_nvm_params_i225(hw);
>> >> --
>> >> 2.47.1
>> >>
>>

