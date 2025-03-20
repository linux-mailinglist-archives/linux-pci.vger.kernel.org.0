Return-Path: <linux-pci+bounces-24252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C606A6AE1C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472481887E23
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC1227E99;
	Thu, 20 Mar 2025 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGrn754s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EDB1EC006
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497586; cv=none; b=M7TebwGFD6XCzEJS8TYPdn2W+uRpqh+8QQEWs9O2gy3odv+GuNQ1Qcbta8i8O/5+ER94E7kIh/dEhVo13IcrtGLlxN3OUIVO9Rh17A/jTWt61044L0BiEP2riry/tZv0peRvFGQHhqHhU68ugIlV3FRxNrtEVnBRTuRYy2IFMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497586; c=relaxed/simple;
	bh=a/jrDGXBBTvpPP1JojCI8HHSOOPQXl2O6Qc6nhYH4PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdGSF5QCtV8i8X2Ee0CxTBVyQmQ6xNXmKc60itIviQHcY8sUxbc41jalRfGcpQHCoaW5oLLjr57CrISv0AmVUASktTos1nGbcUXiZIjKCT59G4+v8K3g99Ahr8PCCvWcXLs3URrSNVR9A9X4YbpMgOHBALs0yuENnbF+exErkps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yGrn754s; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so2416759a12.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742497583; x=1743102383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/jrDGXBBTvpPP1JojCI8HHSOOPQXl2O6Qc6nhYH4PY=;
        b=yGrn754sPlSiyRli0vCmPVYJikdRcZqNog/r5Q7zSiJPrPVAdEfrakMdzjEbydewpd
         GKRQe1ikZ6ETU3ukt5O3IkYsu0/sjLp5qgNKdIk3hudrrYnZDImEYmgv+uk1BjR7/uDm
         uJ47znc46e+nwkNHngI8p2aUqPtSud6JqLEAO0v1fRgElRgMQto4VvkzlnBnL3svmNcc
         Cs2XsL96cRM49xx7hqjLfhRyEk+CuWKFmRfYRKg6XNBsBhbqJ4+ZMFCbbjs+7pe4g2Pf
         OtUy9VJp2munpVZ5rVXheIhW69TNG1QRWKwuhiY9VtgQrmb5PMpZBvifc33JQvXK50RZ
         fAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497583; x=1743102383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/jrDGXBBTvpPP1JojCI8HHSOOPQXl2O6Qc6nhYH4PY=;
        b=sMTyeDizuEoIcT0vftax4301w00iLpSZPYqVRtT2RwfqkqGLtnuKQsHJ/8w+D8XLJe
         XBpofj2AZLHt7VcESEIDKxEh2BVhRVwT5SXVAvS+Laad0zNHUt+VQzi22PDW7iInPN1a
         WsgWvPoXLuStgEaBpyNZKqtstNxjWx1G9KnNSYZzgAJTYB610/qnD6DstCDfVU8h9xOS
         Xh462ZI1PREhYgiW7M98y/oLZxSIYnkWIhoGlsX5G5mwzXx0d/tOs8sVTDGwtDEaqqGV
         DBrAb/xUeub2NPd3tYrkZeVdIsfYa2xp8R3BBlUM9Ke+Dq/thwVKHXRcpNHFiv71bTrD
         rRFw==
X-Forwarded-Encrypted: i=1; AJvYcCXivHFZdCDIzFRutYVWtp57hhE0MkO4xMmQmv3GAPABHeBFpaUBa0XOu4iPUzcYx68Qs2Ttlgwq6TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtqKShfn342DIMQPC1CuQAZDpINT3aEXueu2XoYi/oa1EuuUlV
	Q+vMJzFPGxQIB0hWH9G6rlfSVvlCrh9AZLWgt4D5jjuuWOQiRtFNDUSKYlRDalkeizhOEEW6WQh
	6NAnAnq7RldyPDxylEm4+fofbi0mv9UrqH7ZZ
X-Gm-Gg: ASbGncs1fuYvyRIFYNMrM6RtQsMq6ricKF0gorO9aPHP4Q7x5xVOeP/MOQUgikOTws0
	3VdvW8awZ+HoHNfREW08NozgMtmQMQeOjtzmB4lW+tn/eiKjr7Df3nJLeabY/7LmcZ6SUoO3hd1
	vhNdjvLwevnpeU3HA4FvUANER4dGTml9ABWkMvScTu1UtltzCqrDzAkUUU
X-Google-Smtp-Source: AGHT+IGzYxTe78mR92M78v6TUCY5stb2TNpWtStMelj7PdsgMZoWfOkCh+wSI8r27oYL9yeGpkIv5ag1D5Z/tAxAPyk=
X-Received: by 2002:a05:6402:2546:b0:5eb:1706:aa17 with SMTP id
 4fb4d7f45d1cf-5ebcd40bd13mr505707a12.6.1742497582773; Thu, 20 Mar 2025
 12:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-3-pandoh@google.com>
 <79f4ddd5-af44-4fc9-9f04-4e79f66db21e@linux.intel.com> <CAMC_AXX11GcfbOyp4HXaA_9MmzfKPyPFtA470-aCdMqC7zanVA@mail.gmail.com>
 <35a6ab6b-209c-46bc-ad6a-d4a1b4f76bb1@linux.intel.com>
In-Reply-To: <35a6ab6b-209c-46bc-ad6a-d4a1b4f76bb1@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 12:06:10 -0700
X-Gm-Features: AQ5f1JpGs5Qtn_xWy1dwiPYM7JiiOR6uOPE82iAg9pg-VvnR50PRkklGisyXAfg
Message-ID: <CAMC_AXX29XzoBqL2Ve9JdiPaxxGUA9J3Lq3vGViwSyYFHF5k5g@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] PCI/AER: Make all pci_print_aer() log levels
 depend on error type
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

On Thu, Mar 20, 2025 at 7:23=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=
=3Daer&id=3Dfab874e12593b68f9a7fcb1a31a7dcf4829e88f7

Ah. I have no objections if this patch is squashed with Ilpo's.

Thanks,
Jon

