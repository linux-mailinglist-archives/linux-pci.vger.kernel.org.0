Return-Path: <linux-pci+bounces-25039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED2A7754B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E713A790F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9021E7C18;
	Tue,  1 Apr 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ND1yTx4s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A01E7C0E
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493155; cv=none; b=DEWzUjtEO4U9py91m6yy8PDmjqx6rnBzxTPP4E3TqkOIdWcJngZDYrwBE0fW+6CVfodhwJpXEyXb7F8H+tNnlYvT8gSj/Wm3pxr9S8wypIicMOUCTA/UaGPo1Z2HVJim427VPsMVItxWDjG/SlUKUUG1Ef0JJ8yDVpzQ2G/oYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493155; c=relaxed/simple;
	bh=mdheuFpeZgpsahHM2RP5lfGKBJ8Dr3YUmcPyiPzuymM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zy/g1SY8I8IpDy6/k+vvPmNIQzdF+whmV736jdTAkiruKKNp9TfB3Z2UtVfzEVOfn5Sdsa3gCnJ7jKtdGUltUzT3wWNXL4LB1Zft06fGeyrpB4PdRM3wetVp2+e3/x6GHwSUvNdKGA5imTDMQXgAhkwaYv6UK7g9kJ7itGsnE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ND1yTx4s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so10537355e9.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743493152; x=1744097952; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FgRCP1E3XNVjWVnRW0wDiXPiBlflClaosus3af9C8I=;
        b=ND1yTx4scDyFF+borcjf9QUcU72JHN/ce6oF5rKHDJ5mWVQarLujOyIlRx2We4i2/4
         n3c//XEI6DMO+PjcUihvimwH7C+16rhxpB4FC02B11zMIrR2oACu02RtJshQa9tG/Lom
         HekCnsapEgh3anVeg6UZ0qUCf2gAWtQOJuzbOIK78vd1xziLhQlb9pcUS4vsk1VWD/YN
         5ikt3ROQd5jJ4ezAe5+Zb3y7XWyMMUiX5OF1P+W6gEhoAqwz0ASvaan42X0iO8U7DL9T
         n7O4rG/Y1BbUCK/myMx45izM7QuYEmXtAa8airFMAH64dbGDy9Jl8DqHReVfUI9fx7hW
         oMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743493152; x=1744097952;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FgRCP1E3XNVjWVnRW0wDiXPiBlflClaosus3af9C8I=;
        b=ntYhi7ZcdU8elARj19jZgjWKRskbKP72/f97Kf9UbGfdnE0SXAw8XXizF8Z+oDXbJ0
         c+Br+C9lc0vSHHtJDEYNf0Ykzj3HMfOV9ivXSIFWFGL03j4g2GPDOm1vq+wvMz+NwEzI
         hnqQ7dPDUhnRRH80AtjTL96iHPJsv4Tc6i2f5KP0ehCfFAV2rQgkAamUnoEQrJqLwlAX
         B0I2P6uoWmHBUVY6KEwj2Fm+XkK1Ly2VUNJvDGiQ7hPKACXIJ4Eq4eRAzpph2t3xQUyA
         Gde/zr7/4t4GIl+jFzMHTgRYH19uWCEzaJizDUmTn4XAXF4diinkZ04LtC+x2hn6dTkH
         0+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUlQIS8ks9NvrBK9HL18YSNM9e7yh5E1KP/l/XYTm1qgC/mVrkmOgyITyWR4s+QPtgdFJNHtiYvN5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbO5HNvWe+4ytNdxSMlIvaZbVBKKnwxds0yT25CIGWRBdcPuLc
	tWGwF/eyBu+Nzah3GelWNm2hBtUn9Bavj9RmsLUQVprAWU9UhUM5ufyz5GZYBR4=
X-Gm-Gg: ASbGnctsZyRDBq6jJ6MIbJWjvmGj2ArhNXnhvqfZ9vJLaggt6kXCs+GmcBZPFvfc/bg
	o7y+Z408XhoQMWFmjiRCKH34yGipkbdTKCchPe4oMvNAsgBvnTWGJdymCwOyBayv/hLJVwgQEEY
	0Mz4FepV0t42OP7inFmMZTKHjEVPG2JitLYCpncp1aHQEhlQZHJ88CGcWyO2T7W+PFdQc/FkCJN
	0TRuIjrYC8AnatfaC1MNItIlY58qZBn58lzjp9lEqcszPl8fLzlaIHEUT4//4JYMN2ni59bzit7
	sfZs1UpLu3fLkPCsoZVL4SZG9VfJptX8R+UC7A/ubhLb
X-Google-Smtp-Source: AGHT+IFPiOld3QJ0WZaa2YerdoEAwfy7aYCjxibr0qyX9+x3DyE5eZk8NwWZbSGcNdNKflzmACVViA==
X-Received: by 2002:a05:600c:470d:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43db622ade6mr95886925e9.12.1743493151744;
        Tue, 01 Apr 2025 00:39:11 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:7885:ac50:bd6f:4ff5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d8fbc1889sm146698465e9.16.2025.04.01.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 00:39:11 -0700 (PDT)
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
In-Reply-To: <Z+qrWleCthbAfDxf@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Mon, 31 Mar 2025 10:48:58 -0400")
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
	<20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
	<Z+qrWleCthbAfDxf@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 01 Apr 2025 09:39:10 +0200
Message-ID: <1jr02ctjoh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 31 Mar 2025 at 10:48, Frank Li <Frank.li@nxp.com> wrote:

> On Fri, Mar 28, 2025 at 03:53:43PM +0100, Jerome Brunet wrote:
>> When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
>> should not try to handle the size quirks for the underlying BAR, whether it
>> is fixed size or alignment. This is already handled by
>> pci_epf_alloc_space().
>>
>> Also, when handling the alignment, this allocate more space than necessary.
>> For example, with a spad size of 1024B and a ctrl size of 308B, the space
>> necessary is 1332B. If the alignment is 1MB,
>> epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
>> been more than enough.
>>
>> Just drop all the handling of the BAR size quirks and let
>> pci_epf_alloc_space() handle that.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
>>  1 file changed, 2 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>>   */
>>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>>  {
>> -	size_t align;
>>  	enum pci_barno barno;
>>  	struct epf_ntb_ctrl *ctrl;
>>  	u32 spad_size, ctrl_size;
>> -	u64 size;
>>  	struct pci_epf *epf = ntb->epf;
>>  	struct device *dev = &epf->dev;
>>  	u32 spad_count;
>> @@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>>  								epf->func_no,
>>  								epf->vfunc_no);
>>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
>> -	size = epc_features->bar[barno].fixed_size;
>> -	align = epc_features->align;
>> -
>> -	if ((!IS_ALIGNED(size, align)))
>> -		return -EINVAL;
>> -
>>  	spad_count = ntb->spad_count;
>>
>>  	ctrl_size = sizeof(struct epf_ntb_ctrl);
>
> I think keep ctrl_size at least align to 4 bytes.

Sure, makes sense

> keep align 2^n is more safe to keep spad area start at align
> possition.

That's something else. Both region are registers (or the emulation of
it) so a 32bits aligned is enough, AFAICT.

What purpose would 2^n aligned serve ? If it is safer, what's is the risk
exactly ?

>
> 	ctrl_size = roundup_pow_of_two(sizeof(struct epf_ntb_ctrl));
>
> Frank
>
>>  	spad_size = 2 * spad_count * sizeof(u32);
>>
>> -	if (!align) {
>> -		ctrl_size = roundup_pow_of_two(ctrl_size);
>> -		spad_size = roundup_pow_of_two(spad_size);
>> -	} else {
>> -		ctrl_size = ALIGN(ctrl_size, align);
>> -		spad_size = ALIGN(spad_size, align);
>> -	}
>> -
>> -	if (!size)
>> -		size = ctrl_size + spad_size;
>> -	else if (size < ctrl_size + spad_size)
>> -		return -EINVAL;
>> -
>> -	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
>> +	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
>> +				   barno, epc_features, 0);
>>  	if (!base) {
>>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
>>  		return -ENOMEM;
>>
>> --
>> 2.47.2
>>

-- 
Jerome

