Return-Path: <linux-pci+bounces-20022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C6A144BB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 23:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074FA1889BF3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1B1B4F0C;
	Thu, 16 Jan 2025 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6PYQ62V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC4236EA5;
	Thu, 16 Jan 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067789; cv=none; b=MP4T73g/0agb5lWqnjt0+JXGne/tO9spqfHaHXMF9NDMIrFCgqWtC2Mgv15Z7YkNqBMRiJhG7YTVKYZhPOJZ3Tn1mGoRFQNj/X0mTLs67e/It0GjlhRhDwOnP14DHMr2GUwx2aMlSpMX1RzcROund6CGClSUHFmzD2uzS2FP4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067789; c=relaxed/simple;
	bh=PDMikO17i5AVAKxEAlN9yt66EI1uj79RtlL1tPZHJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC5kpgbjrJxmwP/XP2hpsqPPciPK1wD7apa8kPjDkHNYYBlORx/KCE7S+Ik1b/dUN8CWk+o7qXuuNv7ldUzyasSAEMTS5/Ei2fAv+FvqJCfUlEWrhim+Dycj9c1oIPu69q+enx7G9H9pBYwSt4AhQqdbDkon7JhpB5j3z+OeXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6PYQ62V; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43618283d48so9710765e9.1;
        Thu, 16 Jan 2025 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737067786; x=1737672586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0ma02Y7wHsz1EmooHLyzDHaiTATIvkj5xg4rt4TbkE=;
        b=H6PYQ62Vx/7IE+HM7B0UgxhY1zLhudiT1szJ5yEbD+uML85qwhIaFE6i7mOsqeg5sK
         j/7OCvtMJsS9KsFixdTBBMIsRvokSTl8swzuyKWw1bTSLbvNsec/RlnGJbpbcLo6+Z8c
         bpC1bMk+pWMaA90YEYg5UNs/K9XmYvf1Z91UX0lMKcEGqRlMS6cR0aUOg+aOss3bu4PD
         6sB+tCBvplxGW2eIQnq1iHHcLGBxTSKlL2uo0ABJuELyRiN9tDl+ZNWvB/ezA3fxpsRa
         iSCdRtInnRDkWBzxYEuCQZhKkBMQPAbBKTdtYuWFvP9F7Q16d5dxkFBjVhRdMC29TKfv
         t00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737067786; x=1737672586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0ma02Y7wHsz1EmooHLyzDHaiTATIvkj5xg4rt4TbkE=;
        b=JvIEKkodTKMFp+I4j2Ar2SjjDaHP4hX8wCijVpP/hCgWbT4LsieVBWJDfNsvKcY6Ye
         ZiOoxq94ebH+NQIpUinSn7FQsKdBAlkNMTPRCdLE2uAsjwDGrJVEiy+Az27dmSWPzi52
         z9CTBiXvbZbDaMVCqwFc3L6+gcwRuYNSac3S/sN09hOJdf+zUDu4c7K5IK0MpSqRVrfD
         HNhQjlLzPJxnBJqOAKweYuygxP+MCNxh8jisy3Z0/ccyLinc/MrH7z6uXElU1bWiLhr6
         5lEW+jMeVdSAxcBX/SFvLB/dfxdi107JS/IEvBI6tXMgfzqDve/+SK45jACp21y06y4h
         bfDw==
X-Forwarded-Encrypted: i=1; AJvYcCV9QkhSpccRZtJ5V4pVJuB4BSTrCbIseh7Qa6S3qQCBx6UnAJ8byfHoBH1/gIW8XKlRjwnfmQjKh4z3TeEebMM=@vger.kernel.org, AJvYcCWxKRZYtj2bkTv3nexEBvDk39oe6S5nDOxoNtY/1DEN4A6vNSeGMGZLItlAU56CynMaExWWEah9G0KVOZY0@vger.kernel.org, AJvYcCXItQj94XSuGffmwJLMMjt/AaAaK1rBMMfP4CmBOpyMuzsqdPm97ODc1H6bqWlkoPnoii37JZ3ICM96@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjV9olJmEiCv/fOExfmIUrCxEGbhEgWA3WZEKFCOC9OHVUsaY
	nkzlPf7YNFUHwdTt7QXEIQLkfmB2V5PQgxHT9cPy+3jo3JPo+HFbitD1+A==
X-Gm-Gg: ASbGncvNJnoSWNn8sQqF9sEBiLEHu+LXMqPeTsnPLtW3hVz/f1vZAcmjSc9HtcDhbI3
	ycIEeLXY2UZVG8c+ftqOBDeX2LFGRhCM2frzLLzkzjnTs4P2IfR/2yEMAbCaZGx9dOfqP0/bnkI
	FK5ATWVv38IDe+KxXgBApELVc8UeWqX61M8kNCKGHOHu4BN3ln0fzVY8TXqghPLGTAUHq+LkS/z
	u84JxAjkChhFRbNbBZSUGHABQBxSMFCdeciv0Ka7G5Br3uEgMH6jGMr1mSH6qtHND0utnCvo5Ti
	gYLFGgqSR9To8DPAox0=
X-Google-Smtp-Source: AGHT+IEre0vt60Jc7+ljdNGLQYB7A4Gg6HSPtDJU5ObDo9ISjK5S2O3p4tO+4vPT5F3wXqLY3j9wUw==
X-Received: by 2002:a05:600c:1e89:b0:434:a1d3:a30f with SMTP id 5b1f17b1804b1-438913bf921mr3647525e9.6.1737067785620;
        Thu, 16 Jan 2025 14:49:45 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm71698015e9.0.2025.01.16.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 14:49:45 -0800 (PST)
Date: Thu, 16 Jan 2025 22:49:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: Fix ternary operator that never returns 0
Message-ID: <20250116224944.283e14fb@pumpkin>
In-Reply-To: <20250116172019.88116-1-colin.i.king@gmail.com>
References: <20250116172019.88116-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 17:20:19 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> The left hand size of the ? operator is always true because of the addition
> of PCIE_STD_NUM_TLP_HEADERLOG and so dev->eetlp_prefix_max is always being
> returned and the 0 is never returned (dead code). Fix this by adding the
> required parentheses around the ternary operator.
> 
> Fixes: 00048c2d5f11 ("PCI: Add TLP Prefix reading to pcie_read_tlp_log()")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/pci/pcie/tlp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 9b9e348fb1a0..0860b5da837f 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -22,8 +22,8 @@
>  unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
>  {
>  	return PCIE_STD_NUM_TLP_HEADERLOG +
> -	       (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
> -	       dev->eetlp_prefix_max : 0;
> +	       ((aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?

You can remove the extra set around the condition itself as well.
They are a good hint the writer doesn't know their operator
precedences :-)

	David

> +		dev->eetlp_prefix_max : 0);
>  }
>  
>  #ifdef CONFIG_PCIE_DPC


