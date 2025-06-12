Return-Path: <linux-pci+bounces-29619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EDAD7DBD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 23:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31CA17E052
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B594298995;
	Thu, 12 Jun 2025 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG7UBvGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136D21FF5B;
	Thu, 12 Jun 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749764926; cv=none; b=Mji1a866xtNC7O31evmI0gUIuZdufU/M1hj0iE6xpD0eCbY8yTN2AHUSnK+MASp7TLUJDlrv4n3ZDgbudkNAW0yymkTJ44yLnFP4WdUg9D7EmZcrrsm/fm6GydktdYXd3vvi2tLF2XGdTTyUFGh3oGBQlB49TCE8hWl8QW3GGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749764926; c=relaxed/simple;
	bh=6AV0ri1VrhYVAWuVyFaR/ewqFeVNbyjkHERlfBMpRGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmj8ERRC1xPhk5hdsjMp7Yj7NXepd/3DT6AtGiHDsSfvB2EC8AtCfipZWh4UELKX3Zul1Vx0iqfD9AY2RG68Ec9NZYlW8OBGmoCY9cSALlGE9aknYqI6vaJpC8jiHIeJS61hK+bvQQkb+c6VGS4O9OZIQx3B2urqJZCrmNG8vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lG7UBvGF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1881916f8f.1;
        Thu, 12 Jun 2025 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749764922; x=1750369722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RzstqEb8p/touMZh98NUyL13rifIOqypW9ezn0H7HGI=;
        b=lG7UBvGF86ewtMb/kJrTrGF4pOfSgpiv6Q7tVO+nXVCE33vjEGc9IbQUMle9nygBQY
         cdBkEmvhpEyPo4Mr+daqT4cSL+JDDf+Oaubj04YGjSTRTULcQxG3IrB22vv9db3Je/hH
         P5wMpTr308EwWg1IaCsNbT8t8p3aHizDZSJPwVd8o5mNqsDBvy0WiJgzTuNPMOHB+hal
         qg48l8XpgNk5JRQzqeO5bwabl25bAnWi5Ifhu/26OMhWyzyTc17fhpVMX8wA2spOdxj3
         sHugemQZ+0d43zeD9Dl2Wuw+kK8H1EmOl2NvjoaNv21cErp6fWfqxflPC9SnEVYR2KMD
         q/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749764922; x=1750369722;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzstqEb8p/touMZh98NUyL13rifIOqypW9ezn0H7HGI=;
        b=blvfXqOJrS8683ZYqqa0/Nh1tzQ7oivySVNnOvt3BRH6ChGjuvMg78ZynGNNnH5MR6
         fVfy7RGtK1SNF8xNLfVTV9gUx7wlDgjC5mY924I0z9m/fBquWxAPtgu2LyxQ07+PRogl
         qKJ7wx1ZFQNZIObIoKT11RFcAQzyc5wEKoEG1gl1ftC6ju3qzUgyjS24VUsNnXuxyut3
         MP+/RRZngNFFn0vWDmg1HiuZJJb+w/+FiM3PUHnsx1QeWswqG62CHqK4JGLM+XzXLwnd
         3kCL99Flnx3P1Rr2FgUWaSEzIx7/lKc+6toh1/pajBqHUEzPSBrNsZvNf8NLWZx/2kEn
         g+bA==
X-Forwarded-Encrypted: i=1; AJvYcCUShVt1unGG/zZUd7qdLCA2On8uUPbK2qmAts5wnsbEhrDBSsGQJChHxlkOKVTPD1HGUN8sznVI@vger.kernel.org, AJvYcCVsuoc5Qt1GUzFBSGWV4A/fpNIxEo91HAwrJM42vD7NpRfd8IrjHJb5ILqqbs0L/Tm5uwZnID9TT3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyugRi8dExzOq2hhCQrEUgCI53GKY21zVA7tykYn3oyAF8/2Nlc
	KQSvtGee7lZouWS4uN7OYrIdUWGAGVk6yg5iWHhM0d8UHWYs37btnBRjsOhm1A==
X-Gm-Gg: ASbGncvKFoovsoE1gieJmxYQBhPRhuIoHCdDFCwjaB8Ay003hdTRlqXCCXmfUeJTE8d
	KFsZlSvygfyCD6APeGEtu5NCMA66B25WPWFP6Fhqx2pdS4oh/zN6FLzMmsGjaoXIb2O98Rl4J2S
	sGoy8/86Az6N69y4k5VgWmkkd2yoh8Vd14itWBV+rBql+We/gEnW6RKAsfwbBczfJaPah6c0Skj
	847qt+wavbenLHcJMeekRrRtGQ19t+b97bmVTIDWy7R98S2FCXahgM8j/jGDx5bYLDNVchy4tRa
	WpNWtKFdD+5BvVQp8V9Ree8Cos6YaBgR0yocKPE8rZ01LkK+Cv+ZpWt6W1+BRVazS7COiHKMtDv
	bofOMy7dPMKOPMjJw+sfRgo0hnupUtRpqAG0mPoh8PCZxFbYp7Vy1/21I/FpyzQwLq+uxvI9mAU
	o1Iu9VMFkmWis0a/qkxNmA7KaCPA==
X-Google-Smtp-Source: AGHT+IH9hBfzyvnbr4ZRDGHeeMIzXMg3HRNO6JZY1coemPlHnK0t9GlgZQowycGU8KxvmO1iF9yArQ==
X-Received: by 2002:a05:6000:40de:b0:3a4:ebfc:8c7 with SMTP id ffacd0b85a97d-3a56a2cb1d2mr107815f8f.8.1749764922466;
        Thu, 12 Jun 2025 14:48:42 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:3f00:7533:d8b1:ff14:6fe5? (p200300ea8f223f007533d8b1ff146fe5.dip0.t-ipconnect.de. [2003:ea:8f22:3f00:7533:d8b1:ff14:6fe5])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b4e4f1sm431790f8f.87.2025.06.12.14.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 14:48:42 -0700 (PDT)
Message-ID: <e300104e-c20c-4530-af41-bec91edc3440@gmail.com>
Date: Thu, 12 Jun 2025 23:48:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 218784] New: doc for bug
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670]
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: nic_swsd@realtek.com, netdev@vger.kernel.org
References: <20250612211933.GA928761@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250612211933.GA928761@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.06.2025 23:19, Bjorn Helgaas wrote:
> [submitter in bcc]
> 
> This is an old bug reported on Ubuntu as "[r8169] Kernel loop PCIe Bus
> Error on RTL810xE"
> (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670).
> 
> Seems like we're seeing about 10 AER Correctable Error log messages
> like this per second:
> 
>   pcieport 0000:00:1d.0: AER: Multiple Correctable error message received from 0000:01:00.0
>   r8169 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>   r8169 0000:01:00.0:   device [10ec:8136] error status/mask=00000001/00006000
>   r8169 0000:01:00.0:    [ 0] RxErr                  (First)
> 
> This is on a Dell Inc. Inspiron 3793/0C1PF2, BIOS 1.30.0 03/07/2024
> with Realtek RTL810xE NIC.
> 
> Submitter tested a patch
> (https://bugzilla.kernel.org/attachment.cgi?id=306243&action=diff)
> that just masked PCI_ERR_COR_RCVR errors, which masked the problem,
> but that patch isn't upstream and seems like a hack.
> 
> v6.16 will include ratelimiting for correctable errors, which will
> help but it's still not a real solution.
> 
> I'm not sure what if anything to do here, I'm just forwarding to the
> mailing list so it's not completely forgotten and to make it visible
> to search engines.
> 
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> Date: Sat, 27 Apr 2024 09:04:55 +0000
> From: bugzilla-daemon@kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 218784] New: doc for bug https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
> Message-ID: <bug-218784-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=218784
> 
>             Bug ID: 218784
>            Summary: doc for bug
>                     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
>         Regression: No
> 
> Created attachment 306225
>   --> https://bugzilla.kernel.org/attachment.cgi?id=306225&action=edit
> doc for bug https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
> 
> As requested by bjorn-helgaas for bug
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2015670
> attaching zip file with:
> dmesg.txt - complete dmesg log (includes some Correctable Errors)
> lspci-command - terminal message from lspci
> lspci-output - output of "sudo lspci -vv"
> grub-txt - grub default modified with "pcie_aspm=off" ... makes a difference
> dmesg-2.txt - complete dmesg log with "pcie_aspm=off"
> lspci-2-output - with "pcie_aspm=off"
> inxi.txt
> 

The Ubuntu bug report includes a full dmesg
https://launchpadlibrarian.net/660465011/CurrentDmesg.txt
The fist AER's are logged long before r8169 driver is loaded. Looks to me
like some board component incompatibility, or BIOS issue, or maybe even a
physical problem. But very likely not a network driver issue.


