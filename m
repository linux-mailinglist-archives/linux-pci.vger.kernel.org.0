Return-Path: <linux-pci+bounces-24297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37EA6B2CB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA5A7A627B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D81DF979;
	Fri, 21 Mar 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2zqLVGH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BD9461
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522345; cv=none; b=aOZ09aAaaspehP+bBepJ+UFAnycz0PoQIPm31y4GoaHdt51dOo0toaSZ4iOFYicMUdB6QCh1eiVDv7Aiv2rZpMa0qxUn8HGBxPKkcKGBt2CvS4L7qOTDtwnjeA3Z0EoYPfONd0fVconVygrtambLwnGEJ82bTvWiUmpyfHuQ0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522345; c=relaxed/simple;
	bh=FMcJHrwQiCL6Q1r7i24MgOjevdRBFPR8jrNvnixjpGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjKNKfT9k9aCWYE/17X0OcD72UyPNdr1+sZy96Du/MilG0RMdbKOsoe10DebTZCv69FZOTQtJOrvKqU3qtQJcxLgZG9zIVDywfIcncYMdGQxYA90mJPGqN5EeOA+8TNHJFJFCAAerICGiYNYRsRbL8KdbMz3d/C4ZiOA7eegW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2zqLVGH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so2207537a12.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522342; x=1743127142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s89ATL2g/R395k3Hbzwgv4l0+nevLV4KAwCy+nHQc4o=;
        b=t2zqLVGHAywEFqFHoD0rBdPg7yqX1zz4ABsGZz05q4X9BSaGHoQCt04VYcxD5uzr7+
         IF/8ZB3X+c3i0SHCYyrMbuqnbj5RoUbxKvfJ2R/+as9AtjSL/blaNLwKoSn75cKAGEL7
         CVQMrdD8WeQCHSEgMM9GuvaNaumuA8AbS8QSLk1oLRnUhf1XEKumT9J4BgbGhpEQRfjm
         hD5uYOd7u4z+4VkQ4LrjPkSLy+yfcB+66E+Qd9NyY5mgk893wuca0bXUrmFudzHgaeNJ
         dz882r7i7s2pizOqzKa5TJV9vh9AiTSzxhnctlgjInOlfWOw6AJqTlv3wrzLDn44wJQN
         TV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522342; x=1743127142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s89ATL2g/R395k3Hbzwgv4l0+nevLV4KAwCy+nHQc4o=;
        b=kI9GAmk08I2Eh2TJr+AFdQoeL72OqJIrI60DKSMCeWbty/llnjnVB18+h0Bj1m40zy
         ipEys6vOE/33cZVieK7zRegQxE/EPDJ6c2oFy4xMfbiZPKlOjyScWkLBSRWedWGalBv/
         PH/4r/3lRf7k6QsplB/qCNmiClZ5HXsOgcbBukjjsUmHdWpQfYgsvL52xinoiLeYO44e
         f4pehImzvdkfzCx9aUImvxW/3EFxQq4NlvvBRjZdZsX4qXs56PdFyPckoGCDCZ95AF5y
         EHOhap98sTnQ8yxTavEljhXlsJdPMTr130PccDx5ynLqlRTUWNRsVPyqF3rU5H2IJt4Q
         X8wg==
X-Forwarded-Encrypted: i=1; AJvYcCWSXPD5Z19mNIa9WIz/yH3Hfa7EB5XwBJek3AfNAMJulHXfEER27w5XFscaYwBT5LPlB7zk/hjpzLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXghoUdYLFqGG3ZwcvFKaSPUKZoijLWC/9G8OwwWNrTEEbaO0
	XiLrPpbvyex1Qt3OlNCzQHqg22Fb83HxTy5F8BWzpS0DkKxrP6ztNo+/73L1EaO8DvfsZKCV/I/
	qXGgAL5Qvbr9PbBRa4BiMo/UwqZgkO8dTDy3y
X-Gm-Gg: ASbGncuz9dpSGjEBm5BUkTx/xC38ct7kDBbs4Gw/0UV3qNKnvu9woDwybXBNLU63SFl
	0PCjwYEmK1mkboRhVY5Gp7cbQaleUkA6pJSXDXcgLsw+giuNmIUB3i/cGM/4dIrC+4Ly+9HUq6o
	3IIDjBXa+iBE6nqBKS+/Mkk5saGpEuKATzspsxU18aFT3TkoLc6TX/pLQm
X-Google-Smtp-Source: AGHT+IGXJcYJa2ZdKH70SYkxIKHkRS16r/FisZk62uQ4CQLVTiniE7B18t36tkeUhSQjzngbyD70Wl59T9o9dntbwnU=
X-Received: by 2002:a05:6402:2753:b0:5e6:ddab:736c with SMTP id
 4fb4d7f45d1cf-5ebcd467f5fmr1371497a12.17.1742522342136; Thu, 20 Mar 2025
 18:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMC_AXVi7cFOnSa25SEkZsYf27eoX1NwFmc8VnRgFQS44PpKRQ@mail.gmail.com>
 <20250320202913.GA1097165@bhelgaas>
In-Reply-To: <20250320202913.GA1097165@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 18:58:50 -0700
X-Gm-Features: AQ5f1JpXzjZiFtN_R2BxhlKA7_X9hyRYx5hXwZObAJLMKY966-fqMOKt5K9y09s
Message-ID: <CAMC_AXWQg53uNLsZizxEsOf_3C2gv=vBdAAeMek1AmnTnMmDAw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 1:29=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Mar 20, 2025 at 12:53:53PM -0700, Jon Pan-Doh wrote:
> I think the struct aer_err_info is basically a per-interrupt thing, so
> maybe we could evaluate __ratelimit() once at the initial entry, save
> the result in aer_err_info, and use that saved value everywhere we
> print messages?

I like this approach. Another advantage is it removes the need for the 2x
ratelimit logic. Updated for v5.

>   - native AER: aer_isr_one_error() has RP pointer in rpc->rpd and
>     could save it (or pointer to the RP's ratelimit struct, or just
>     the result of __ratelimit()) in aer_err_info.

Similar to aer_err_info.dev[], I store the evaluated __ratelimit() in
aer_err_info.ratelimited[]. The main quirk is that for multiple
errors, you won't
see the root port log if the first error is ratelimited, but the
subsequent errors
are under the limit. I think this is fine, as the log prints out the
first error only,
but can change aer_print_port_info() to log if any of the errors is
under the limit.

>   - GHES AER: I'm not sure struct cper_sec_pcie contains the RP, might
>     have to search upwards from the device we know about?
>
>   - native DPC: dpc_process_error() has DP pointer and could save it
>     in aer_err_info.
>
>   - EDR DPC: passes DP pointer to dpc_process_error().

These are largely unchanged:
- GHES/CXL gated by aer_ratelimit() in pci_print_aer()
- DPC not ratelimited with the expectation that there won't be error storms

Thanks,
Jon

