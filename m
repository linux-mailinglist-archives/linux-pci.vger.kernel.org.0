Return-Path: <linux-pci+bounces-25176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A880DA79024
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E231889373
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818FA2356A7;
	Wed,  2 Apr 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SxqjsjSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A19235375
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601480; cv=none; b=q5BRywKztzCMyNwTdgIXUyaQrtBWEgm/IXbivbDvoL/STkhGtxNOaUkoGUfzDMSUbvN5DHTPZeZ5NcYoul1TaaUih1qZScQHVmCNfV0JSU4GfQxrAKxZfc15IJVoyHzja5gN6PKX45xklJ9xuTO5yMA4EThYmW9nO43K3iduCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601480; c=relaxed/simple;
	bh=bAFtZQ4n74TeKqgW1UVgdxDBZQaL32TNRNDJ8hM/0w4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bUJmPAjkzxcu3TelJGEGLdfaHfEQbIIL7qNNuaXYICMJUNjWUZ6Fw4enbFJxoFAVL2cTHmr3B7frPrIDC76J4zwesvbd5D/VlYolM+t2oY9fP8WQvim4zaL8nrJ5aFcqmPPyA9QiD7m7+0/h723vN/DQklxfItvY2VBvnLRQIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SxqjsjSV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c0dfba946so2998847f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743601476; x=1744206276; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+KPScMUK+AO9N4U8oKua6WTB7J2b7ytXODSOml94Zo=;
        b=SxqjsjSV7bmQM2wzwYHBDlcdxHLeP6Qz2wZghJM7QY3/kEB9ryZ6HVgvxTme2ENT90
         y/eaGAaMw3LDR277H3buNfjki3GoiuHA+A2cmLLa0xxtda2y5PfkLsPuBBuRkpYsqIE0
         Z86d2X/pET+O7pHei8eUCHEQCzCbDsdRG3CMhv+lILVnsCX+9W1igH2Bt7yDJJLDeX6l
         5NDC1xE9MOrkHyZWhJGvQIAoh9gd+033yx+R5r0IuS6CXSKbjBc4HIjQ0UBppkrKY/v6
         GjKGG4fLQ2qeO97OjwZ5oyEYphRSqmxNF4xHBLKDGEAj3ZmZtEZfaeETkXw8ddKfve4a
         UtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601476; x=1744206276;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+KPScMUK+AO9N4U8oKua6WTB7J2b7ytXODSOml94Zo=;
        b=aa7JHNG7Amy3tNJaxjeurFKUmvddmD8hZ6H5WJ3nZkoJkm6RVPtG66cWMdl+5PNCiQ
         zNPPbGLT1nhpf/Xj/3LgcQhuR1ER6aLE53QEsMozZ7Nf7tCOhB+z656lsGOVOALIvr5R
         TGZcDNCywBE3JH915nj/TjxudZlF/b+LKxpqRo7Lr0UliyjrkoYCNMhqiOKxOUopO6rL
         uOrsv2j4LgmhywtvjZLgTeBJJKLwWN46GY8Z28Cx2DC4pu9xaI6m+APxmxKYcmO37pDG
         4jp0ElbISb3kt7hh4w+XLdzBhpfF473e2v1lxs/k2X6l7uKvrYgbFJp5ymdP6u7A7TZK
         Y1jA==
X-Forwarded-Encrypted: i=1; AJvYcCWk0MNguvlzOef/36TbBsS3wmKNpwTApDjuaR/YkZpN4EEP1xvGsHwZEgx19PEXjDTWZMboJGh9xB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4q6rqta/UrrpvQuLqwKpTK8ZsNsqsZ8pgN4AveUU7+xlqmm0C
	YYV/b4dXul7kXLQxPHqgH9ZFHW1p62e3g/DuuZr1Q6gbcyv2olUsG47wmu8CI5g=
X-Gm-Gg: ASbGnctI1Dar1E8z0/r6CGVV9934MD1ZAVaY6E2VM16HbNnOxNxpBwRK/5KPNopWrS3
	ESG+J2ZSt+YvPX6DtL7tfuiPM38bzu/TChRkh6rh/mdd55oKQ/9H+l58AsfwuTKE2AeDNhl3W4x
	Zrn5Gut5Z9WcWDTw+gafG/iSL+0uXfqKumJ42q0WCLJbZxOjxmTHUyJNf4GEbn0yn3OKNRCTL9C
	eSRh/TwQJzSoo7I7M+1XjaLxVMtrLPdTe8vRzR86mHbfFxyA1PwDwb4+rUaWLVVQabYiCWgrlVs
	F4NTYMmaGrH+Mk1DA3QR9P1O/ussS/s7y88lMb9qcgU=
X-Google-Smtp-Source: AGHT+IH2Shn9J0awqYD8blIWstPWQg0xn0kUnMPetVi0klBHYvCu+x/je/Jcfw4sK2CLrMVB6OxOdA==
X-Received: by 2002:a5d:6d84:0:b0:39c:dfa:d41f with SMTP id ffacd0b85a97d-39c120cb81fmr11722261f8f.3.1743601475734;
        Wed, 02 Apr 2025 06:44:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:bcc0:32e:c479:20d5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b7a8e0asm16873922f8f.101.2025.04.02.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:44:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Marek Vasut
 <marek.vasut+renesas@gmail.com>,  Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
In-Reply-To: <Z+v+Uni7PV9Nlstq@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 1 Apr 2025 10:55:14 -0400")
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
	<20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
	<Z+qrWleCthbAfDxf@lizhi-Precision-Tower-5810>
	<1jr02ctjoh.fsf@starbuckisacylon.baylibre.com>
	<Z+v+Uni7PV9Nlstq@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 02 Apr 2025 15:44:34 +0200
Message-ID: <1jldsiu18d.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 01 Apr 2025 at 10:55, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, Apr 01, 2025 at 09:39:10AM +0200, Jerome Brunet wrote:
>> On Mon 31 Mar 2025 at 10:48, Frank Li <Frank.li@nxp.com> wrote:
>>
>> > On Fri, Mar 28, 2025 at 03:53:43PM +0100, Jerome Brunet wrote:
>> >> When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
>> >> should not try to handle the size quirks for the underlying BAR, whether it
>> >> is fixed size or alignment. This is already handled by
>> >> pci_epf_alloc_space().
>> >>
>> >> Also, when handling the alignment, this allocate more space than necessary.
>> >> For example, with a spad size of 1024B and a ctrl size of 308B, the space
>> >> necessary is 1332B. If the alignment is 1MB,
>> >> epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
>> >> been more than enough.
>> >>
>> >> Just drop all the handling of the BAR size quirks and let
>> >> pci_epf_alloc_space() handle that.
>> >>
>> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> >> ---
>> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
>> >>  1 file changed, 2 insertions(+), 22 deletions(-)
>> >>
>> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
>> >> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> @@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>> >>   */
>> >>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>> >>  {
>> >> -	size_t align;
>> >>  	enum pci_barno barno;
>> >>  	struct epf_ntb_ctrl *ctrl;
>> >>  	u32 spad_size, ctrl_size;
>> >> -	u64 size;
>> >>  	struct pci_epf *epf = ntb->epf;
>> >>  	struct device *dev = &epf->dev;
>> >>  	u32 spad_count;
>> >> @@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>> >>  								epf->func_no,
>> >>  								epf->vfunc_no);
>> >>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
>> >> -	size = epc_features->bar[barno].fixed_size;
>> >> -	align = epc_features->align;
>> >> -
>> >> -	if ((!IS_ALIGNED(size, align)))
>> >> -		return -EINVAL;
>> >> -
>> >>  	spad_count = ntb->spad_count;
>> >>
>> >>  	ctrl_size = sizeof(struct epf_ntb_ctrl);
>> >
>> > I think keep ctrl_size at least align to 4 bytes.
>>
>> Sure, makes sense
>>
>> > keep align 2^n is more safe to keep spad area start at align
>> > possition.
>>
>> That's something else. Both region are registers (or the emulation of
>> it) so a 32bits aligned is enough, AFAICT.
>>
>> What purpose would 2^n aligned serve ? If it is safer, what's is the risk
>> exactly ?
>
> After second think, it should be fine if 4 bytes align.
>
> Frank

Ok. Thanks for the feedback.

I think the same type of change should probably be applied to the NTB
endpoint function. It also tries to handle the alignment on its own, but
that's mixed up with msix doorbell things

I don't have the necessary HW to test that function so it would be a bit
risky for me to modify it, but it would be nice for the two endpoint
functions to be somehow aligned, especially since they share the same RC
side driver.

If anyone is able to help on this, that would be greatly appreciated :)

>
>>
>> >
>> > 	ctrl_size = roundup_pow_of_two(sizeof(struct epf_ntb_ctrl));
>> >
>> > Frank
>> >
>> >>  	spad_size = 2 * spad_count * sizeof(u32);
>> >>
>> >> -	if (!align) {
>> >> -		ctrl_size = roundup_pow_of_two(ctrl_size);
>> >> -		spad_size = roundup_pow_of_two(spad_size);
>> >> -	} else {
>> >> -		ctrl_size = ALIGN(ctrl_size, align);
>> >> -		spad_size = ALIGN(spad_size, align);
>> >> -	}
>> >> -
>> >> -	if (!size)
>> >> -		size = ctrl_size + spad_size;
>> >> -	else if (size < ctrl_size + spad_size)
>> >> -		return -EINVAL;
>> >> -
>> >> -	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
>> >> +	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
>> >> +				   barno, epc_features, 0);
>> >>  	if (!base) {
>> >>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
>> >>  		return -ENOMEM;
>> >>
>> >> --
>> >> 2.47.2
>> >>
>>
>> --
>> Jerome

-- 
Jerome

