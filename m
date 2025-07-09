Return-Path: <linux-pci+bounces-31799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E86AFF12E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FF6567C97
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842023771C;
	Wed,  9 Jul 2025 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XLa/sIxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7A17578
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087196; cv=none; b=Rd2M3f2veZrcUapPC7FcGd+dCRUtF5OPXUilZspWg163igfUy4nBwepjU2cH2fXlBWkMjMru49/9wBFgEzyfDr6Xn10M8Gb4YnfxQ+V7SJAs5qfQXD105OdJCPeaZuiE3mCV1iDgOv0KBwOoNsH7vjlH74C3dAcyMmpZD1v57dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087196; c=relaxed/simple;
	bh=4K78Yf9TlUlLc78YfT8HBWZby4r0fBDjmthx5+5R0R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3udNMWW+fCjNkWyfYv79XXhB+USS32ahdPmUx+7AEXuWZTfb87/3H1JSbi+iMadj8cJt5cdDtywYTDGQagULYybUBdBbMY6RcO0TdG6l8bOvUYxZMQxugDbHWZ4EcrOyEw2INcPhzhcmCQ02CDMAlf6XoXAqvPG65JcNBcbCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XLa/sIxH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490702fc7cso148103b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752087194; x=1752691994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaekIFKi6/CRdiasGzRjYYlHitvLGnjcU5Xct2vrPvs=;
        b=XLa/sIxHS4hj17lvArMStOOzk/PPMEINd711iIo2cBPWmJBBAstU2jE4BSkgWgBab1
         dWMfaH179WJE7QFz3EmX8tZnMYlUTjmwVMrIwF6WePkOB7lbAEE2W8F58DahCe8urXpA
         kOTgbMOa4+mXZPbQwbiXm86lxjz6LXaoumg9LRHkyTuLMX9puxSnPL18gMZdiyxlUtH7
         uUtoDSPgc+unXKMKeVoA6uZhSiZkqsBMki0fW26fAiKeeAjYIPee6j7kVcfi9GA79jD+
         VlobZ/J8YgvGFfjeb1ChHGl1uBvuNAWaFw1/mSVfkLjQuxTYCZMwBoErREBVj2xt5ysN
         F0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087194; x=1752691994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaekIFKi6/CRdiasGzRjYYlHitvLGnjcU5Xct2vrPvs=;
        b=Rv2lw39h9II+y1Snjir0GwNRfYrKEpkWJXiuCBycKwa4hTvHiS91VWAFe4TMycYg3/
         QsafQr86b+jxScq4kx1+NP+il5zixmxkdZ4uVJapiSLPfOFAXNSP+IPb9LVDOacJuTCE
         AXB+3edxBGyXGO6YMrzpRgTftSfJ9BT3WPwFfb3gdD1RWVA6ciJEYzkd6j5Dr8njJb8q
         UqQH0DADpUOWbpMqfUuUY9GknRm1+7Tbi5tsdYcp1ONgqi4XW/gQQkMCZWAAwRnERM6f
         kLT55+hy9/nFPj16YTgOJg982QIf/GS0Jwzzr3WNK5efWe7E8za58LP+X8blp6Jzk5Aq
         h9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWx7XV7Dbz8XKtUpC3T29bbLwRaJKe6qcZKVxp+euDuBIWNiARzQB3ojzBOVr+HxtFMTbfV1x9oRck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TJkB4p9PhAZY2ybcJMuDtbxVlfGAzbmVSZE0yTMsD0DWadn7
	FsdEFiJPr03WcvutYTtoG9W6mMSs3PEyWg3F0fT/69r0EFFGj3OVoG5kFPqcxDIJd9M=
X-Gm-Gg: ASbGnctW8xPiVFLacblD327QXRiusQT5yUzNXisMOz3lfHcFRJKOvLeneqAol0y03et
	gLOhu4YZzlXHcZNyv5vf6hnpOyDT9oUb1weBilL+Hm/ixHRxX5WBL/22oLKYD57FnnzP+he4Y/K
	wGxPSutWk4oZiVXF7JoykFChVWOSVJfl+zkdxbhWjoDRtc/s/opADBGrdf5UYDfV5ocPE2AKPAS
	54EOjKUP7aAFVkl+hDV0N/0G+hQE549PXjGDlaNfECkMEMCC8bbwgSfB/IYBSjYRpJ4I9IPJwDR
	FM16TVlSmD8eou/iZ3+9qExVImt8JLf1dy4ZDZa/IXy3ngo/d8SterDqgLyB54gEUiltFJa5glm
	KY0wmFt777jlS
X-Google-Smtp-Source: AGHT+IHOp0ILsfTwDd3ylE0VG8sKKK/bVLxzLJEoAqpo8yw7Aixye6sW9UUZVdOvG/utOvRK7NcJVw==
X-Received: by 2002:a05:6a20:2444:b0:226:492:3f82 with SMTP id adf61e73a8af0-22cd757d7c9mr6267390637.22.1752087193858;
        Wed, 09 Jul 2025 11:53:13 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce359ead0sm15748828b3a.8.2025.07.09.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:53:13 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: ilpo.jarvinen@linux.intel.com
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	macro@orcam.me.uk,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Wed,  9 Jul 2025 12:52:57 -0600
Message-ID: <20250709185309.29900-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2b72378d-a8c1-56b1-3dbb-142eb4c7f302@linux.intel.com>
References: <2b72378d-a8c1-56b1-3dbb-142eb4c7f302@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Jul 2025, Ilpo Järvinen wrote:
> Are you saying there's still a problem in hpc? Since the introduction of 
> bwctrl, remove_board() in pciehp has had pcie_reset_lbms() (or it's 
> equivalent).
I think my concern with hpc or the current mechanism in general is that the
condition is basically binary. Across a large fleet I expect to see momentary
issues. For example a device might start to link up, have an issue & then
try to link up again and from there be working correctly. However if that
were to trigger an LBMS it might result in the quirk forcing the link to Gen1.

For example if the quirk first guided the link to Gen1 & then if the device
linked up at Gen1 it tried to guide it to Gen2 & then if it linked up at Gen2
it continued towards the maximum speed falling back down when it found the
device not able to achieve a certain higher speed that would be more ideal.
Or perhaps starting at the second highest speed & working its way down.
Its quite a large fall in performance for a device to go from Gen4/5 to Gen1
whereas the ASMedia/Pericom combination was only capable of Gen2 as a pair.
If the SI is marginal for Gen4/5 I would tend to think the device has a fairly
high chance of being able to run at the next lower speed for example.

Actually I also wonder in the case of the ASMedia & Pericom combination
would we just see a LBMS interrupt every time the device loop between
speeds? Maybe the quirk should have been invoked by bwctrl.c when a certain
rate of LBMS assertions is detected instead? Is it better to give a device
a few chances or to catch it right away on the first issue? (some value
judgements here)

> As I already mentioned, for DPC I agree, it likely should reset LBMS 
> somewhere.
...
> If you'd try this on different generations of Intel RP, you'd likely see 
> variations there too, that's my experience when testing bwctrl.

Yes agree about DPC especially given that there is likely vendor/device specific
variations in assertions of the bit. There is another patch that came into the
DPC driver which suppresses surprise down error reporting which I would like to
challenge/remove. My feeling is that the DPC driver should clear LBMS in all cases
before clearing DPC status.

>> Should it not matter how long ago LBMS
>> was asserted before we invoke a TLS modification?
>
> To some extent, yes, which is why we call pcie_reset_lbms() in a few 
> places.

Maybe there should even be a config or sysfs file to disable the quirk because
it kind of takes control away from users in some ways. i.e - doesn't obviously
interact well with callers of setpci etc.

>> I wonder if it shouldn't have to see some kind of actual link activity 
>> as a prereq to entering the quirk.
>
> How would you observe that "link activity"? Doesn't LBMS itself imply 
> "link activity" occurred?

I was thinking literally not entering the quirk function unless the kernel
had witnessed LNKSTA_DLLLA or LNKSTA_LT in the last second.

Does this preclude us from declaring a device as "broken" as done by the quirk
without having seen DLLA within 1s after DLLSC Event?
* PCI Express Base Revision - 6.7.3.3 Data Link Layer State Changed Events
"Software must allow 1 second after the Data Link Layer Link Active bit reads 1b
before it is permitted to determine that a hot plugged device which fails to return
a Successful Completion for a Valid Configuration Request is a broken device."

> > One thing that honestly doesn't make any sense to me is the ID list in the
> > quirk. If the link comes up after forcing to Gen1 then it would only restore
> > TLS if the device is the ASMedia switch, but also ignoring what device is
> > detected downstream. If we allow ASMedia to restore the speed for any downstream
> > device when we only saw the initial issue with the Pericom switch then why
> > do we exclude Intel Root Ports or AMD Root Ports or any other bridge from the
> > list which did not have any issues reported.
> 
> I think it's because the restore has been tested on that device 
> (whitelist).
> 
> Your reasoning is based on assumption that TLS quirk setting Link Speed 
> to 2.5GT/s is part of "normal" operation. My view is that those 
> triggerings are caused by not clearing stale LBMS in the right places. If 
> LBMS is not wrongly kept, the quirk is no-op on all but that ID listed 
> device.

I'm making a slightly different assumption which is "something is working
until proven otherwise". We only know that the restore works on the ASMedia
when the downstream device is the Pericom switch. In fact we only know
it works for very specific layout & configuration of these two devices.
It seems wrong in my mind to be more restrictive on devices that don't have
a reported issue from, but then be less restrictive on the devices that had an
out of spec interaction in the first place. Until reported we don't know
how many devices might see LBMS get set during the course of linking up, but
then still arrive at the maximum speed.

