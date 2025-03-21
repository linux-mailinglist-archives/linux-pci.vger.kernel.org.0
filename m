Return-Path: <linux-pci+bounces-24418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0743A6C5C0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF9D481C48
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B2236428;
	Fri, 21 Mar 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Rm1epK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F323373B
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595340; cv=none; b=IYVs/u7Xp9AFEgOnk61F2oPQOEyo+xCGWwuedvabBBuj3PVaprBh5pAhyso35sO6bJWP+PBy9zLKLbGPl5B2gtD/cEDmSqXuZnneNBerYcVvLFx+czlCcoavwiSQjXqAcbRZ6Q1l4GzqVE/byCsHygoswVlCn+SKf9bqDBANBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595340; c=relaxed/simple;
	bh=m8vM/G7z/Thaz51jxVF/YJVbolpTi/pv8eV+LG/UUTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgLYb+SD1aDoENPtQKY4+pQeZS8m/CMhcRyCkw8I8oOH8j9jy6LjRn2xpdNcyx8N0E/xoQGCcJLUYI7orb6KJcE3DLblNnv2blA7uspiSrqmEnFsVRKHI+f8G2w9SGaq/cNEZtxwXbOturhpZlmlNF6cmGWVslqpAI9tXShzLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Rm1epK0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso3208294a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595337; x=1743200137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J9eaqWug/IBNQXT48tPlsUMPzwb9VnX6IoI1r5Q+E8=;
        b=1Rm1epK0WqmrrBrjf/tE0k0Hg1oZS8GDXNspI8040//nVZrNSYRnoIAKQt2pcUrcpP
         6PHPkMEDn4EUaE3dZ81SL4bTzBIlbh35L3i1wKM+/abMgyUtaKdTtnXPTH84GP1M2xqg
         AXs1uB3QYLhaxmNs9lX1k+ya/Zt7BQe1ZeK1p9WJHcZyFP416fttqRljDdcb1qg6gfBO
         Fdes7/5miQy+lDlEstQIDBvxdi2gsd0l6I4FeNS0++z8p++l5ztYWU7SKnoqpGvXYHo/
         Si/02d74/YQRqog6IypaDLEbRdl7/qFID0E5nOGIwkuvusMOjuKf+t0nzOq09DDuje0e
         Dc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595337; x=1743200137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J9eaqWug/IBNQXT48tPlsUMPzwb9VnX6IoI1r5Q+E8=;
        b=sZHZkWPeIvRG+WjFuch4NjBqUbZHyoeddWFOowOxsggC1oFsdbYt9Er/uVyOU8HSJ8
         UAMIQG9VGyfej8nIRc58N5wnzF047zdFrxO95xF/uul/9Kicu+k4SD1UflXXUndfN2ui
         SptxG8EC6NaVnWGCFgFrZXganadOEoVDlmn0lhtIptCb8CsTQDo/pXzBmHaKHAy3ksbr
         tU027wEgX3KbIFAqZIO1MRH2WsmV5/+urRUnuo9TxxFweVreHoYL1mJSVHVIxgFwKi1Y
         D1HlGlUdWbmKneLLEDLHUKaIBWml8KWohOPrvcn/IZXWpW5IKrs1okYljV2lC3SKG+iP
         +Bfg==
X-Forwarded-Encrypted: i=1; AJvYcCVUMxupplFftSe6m/zUKuFtgjzMJ9HmEoSFtrMcVePcUbTDdZqptZM1LCztGdTwk8g6ZYjXq7b0NZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVVDJVU69tXtq/Xd83FdBrqC+VAT7z/z944IWqxt4IJxJlh8+
	8cziWNyNrpAEc7sWkhIxFm7ZXMa6BiXPEOKEcZAGu/DzJcZBPrHvI+KpaahnOey1H+T+sZosHfW
	5zA1n80sOiOdLyKIaf5VnRxhP3SncrsEIrPYM
X-Gm-Gg: ASbGnct66QihvFMlcTTEKr4MuOaIlChwm/T3GsTV8QOsWijK9UX1C1p3hCnPbDkom5j
	AbqQlzGQFHsLRAS9QoWqgJZgoJM0TricWr9po7w9fHzI2JcwRQuiS1gDrWSMboHiuXkgjBSc8fj
	CaqRvt1W4YmgPDHyWLvmheMzNBl5JWaj8kLsJDFmolHj8t1A6k9EWtcIjm
X-Google-Smtp-Source: AGHT+IEisflX+NZ4hBqrpsFedfbpVPDZOD1GhmSQkm7HF29WWnZJUsLSJh2h9ekpHHqGL2y3j7k5wdSgIGGn/PLUGvQ=
X-Received: by 2002:a05:6402:42c8:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5ebcd4342bfmr3926241a12.13.1742595337277; Fri, 21 Mar 2025
 15:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321015806.954866-6-pandoh@google.com> <20250321220115.GA1170462@bhelgaas>
In-Reply-To: <20250321220115.GA1170462@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 21 Mar 2025 15:15:26 -0700
X-Gm-Features: AQ5f1JqpVwYh-Kqyh1re3TEcZiQP6kpmkC2dpQ--jbLCOUh9tS32wDJ41CNgVCo
Message-ID: <CAMC_AXX0PKDY1sqJKxCbUxLGB2-0uGG3Ytr3ess8d+8pv5TYiw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 3:01=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> What did Sargun report?  Is there a bug fix in here?  Can we include a
> URL to whatever Sargun reported?

Paul added Reported-By and Acked-By tags[1] for the series which I
applied to each patch. Checkpatch mildly complained about not having a
Closes tag for Reported-By.

Sargun/Paul, do you have a Closes/URL tag?

Thanks,
Jon

