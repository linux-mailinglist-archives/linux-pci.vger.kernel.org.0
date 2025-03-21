Return-Path: <linux-pci+bounces-24394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB8A6C350
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FA18946B6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569A22D4C9;
	Fri, 21 Mar 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bs5l+Cd+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F91DEFF3
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585068; cv=none; b=KFzcgYiAVPkZZL/AOpGFsQ1WNVvhgfre/P1Kx8FI8Uq52PZnPMnvKGmNhwTPINL+K7JSBqmNV2Xx7kvTaJwMO9javdL315qTVWPVa64/6EOrqIVdsczGOMU21nT25HNzWdV4JtgBRTnl+iqU/KLArwBA8IBbx4hWVn36tJyI8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585068; c=relaxed/simple;
	bh=5/p+ha8OqilpejwLlK//DsAVZs2H0J9qncLbaJM4EF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRdb+fJH//+HH9deueF9MOGRfKEJeLqCb+ew91nJcOV+0PI913PngdwqkD/Nbt+FWV0N+nQGBNAwxngjnS0b9X5KKuJIfhxkg4HxN91nZm1PXVqBs2r0yCvMEitg8S8WpihOyO0n8haiUeM5Pe7zyEt+Yarh4HegWjsLrPtDB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bs5l+Cd+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso3684079a12.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742585065; x=1743189865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/p+ha8OqilpejwLlK//DsAVZs2H0J9qncLbaJM4EF8=;
        b=Bs5l+Cd+Rda1GcGJrHKHPc0bIhYkWRKUmQ0uwSWEEbyXYBNCeqd2X8bPXtWAJqqxd1
         cV05+Kk3FhkIlZCfNUIgWyMPkF87jJDNU4RduikZ/WSbGMFr66IlU9G49ejzRCK66TAk
         kX1OPiM9j49MssQxcPBDdxRBLFlHSNjb8wOOZ0Rf6I+hG9TOPI7NrptRApEBhA0CB9Yv
         xAAvGVCXIBSfRXUJcxsPr4ffTUuq3CaUbxLWqKtfDwvO+4KdgQzVyj7c5YM3iB32lnF9
         1P2mpvnRvPonis7GaRBLZVPm5VV52Vt713H46IhzIZetdqXUpqFdPlsJYyTha+KnGI+1
         EHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585065; x=1743189865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/p+ha8OqilpejwLlK//DsAVZs2H0J9qncLbaJM4EF8=;
        b=aRSwyFPPfXl2UOX4m1eBkws7FCRxj1Dh8N5te1DZIzt11oaw/UJrWnGoXmDJuT1zTm
         RVcE8Lh0805L0jQUMstMQaLcfVqtpQlu/HBeovad0Fb8D8NUJrtNjsK2L51JBRq8+mHG
         EwdMO3IAgipMJtYkbxSlGEG/qtibrn6L8r+n/kQfwh4gkG0fQ9i/KPi0eFvCg8dDAm7n
         ay29UCyptT5R6TWD7VSC/7la65elHqGztkSlkV3FLRertVR4H+HN823P+sZsOm1IwcH5
         GZLFXpPFhVoDKjs8Zv9JLyeE1CtLiB3PISUqEBOMdtNSOyDvT2NZPG7zayteUzM+88v8
         H+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWZx3+pdqdTWJ69IdqHwPlv1pGdBiljuCwO8FDWELlOn9ygRhzdX6jivf/1fHwafYPHP4+sZiyU+Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxhgh3y+5n4c2MhAKMxBh3XmTkfn2kVpYJPF5Utae2T787msfU
	28k2xfVg55rmP9oMagO+ni82M6Bh+JcXQcgngWWfA4SADhWkFBkKP55iTPx/ucDa2io8a6G7/T1
	k43uKn7hHIVEIobzynVBZDUm7E3MSVICmTFSH
X-Gm-Gg: ASbGncsWmiKWIHb3jtJmRkAZrMPaN2Mh2aP9oO/Q8kQAgGopJ4Lz1yCuD+FPDhY2dzD
	Y0rEcXhwQAZr+RHN23ECzvrEntYqcICwgsK1lNhy5AhA7laR0qX8huaVcQKRmaFi/21e5QQOfHQ
	4iogaUNM+laWavQlO8Mj2edhNugszDIl0HIP7Db04SRbgE2yL/xI711fYD
X-Google-Smtp-Source: AGHT+IFJDs9q4STpG7rlW1ZEDxlMm/ukQHsFufhwPw4izW38wLD+kBBWX5i71yRFpV4J4e+rrqPADeY4D8VnLDhFmo8=
X-Received: by 2002:a05:6402:2355:b0:5eb:534e:1c7f with SMTP id
 4fb4d7f45d1cf-5ebcd51c591mr3937408a12.32.1742585065075; Fri, 21 Mar 2025
 12:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-6-pandoh@google.com>
 <85bd0cd9-c09f-464d-9397-ced829df27d7@linux.intel.com>
In-Reply-To: <85bd0cd9-c09f-464d-9397-ced829df27d7@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 21 Mar 2025 12:24:13 -0700
X-Gm-Features: AQ5f1Jr0XobOCreEGp9ydfickQ9PZ-NfENarr56H0d9gvc1an_PiFAZcgTO1ylU
Message-ID: <CAMC_AXW6QgDV9bSiYR5UpgSAii+YSPLk_xCdYHZGjudDZpGstQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:00=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Should we exclude fatal errors from the rate limit? Fatal error logs
> would be
> really useful for debug analysis, and they not happen very frequently.

The logs today only make the distinction between correctable vs.
uncorrectable so I thought it made sense to be consistent.

Maybe this is something that could be deferred? The only fixed
component is the sysfs attribute names (which can be made to refer to
uncorrectable nonfatal vs. uncorrectable in doc/underlying
implementation).

Thanks,
Jon

