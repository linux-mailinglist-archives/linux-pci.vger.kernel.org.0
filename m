Return-Path: <linux-pci+bounces-24188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DAA69C4B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 23:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24253BCC87
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E821CA12;
	Wed, 19 Mar 2025 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cp+9mv/o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055231E0DF5
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424757; cv=none; b=Vw+pPanONTFjLRexUxHWOxPth/sZ38SZyWnQs+82Oo8MILdDdzDIBWoUdbx0Gi3+d2fOGDlOquTd0Uxtd86Jd2hKcgkuxtBfnZzunlg5GihlsLGPRQiqdOEjUOjcy90rTWxPH03H3SlD1unvEW+GlHh6wqlJZVmnN0CO3rC60RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424757; c=relaxed/simple;
	bh=GEpYuDB4KVECTz5kVtQD0Kwu023EfQfhNZv9+pX30os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkkiD5Hsz0F/PUdaeFQNMbnxmvNdt7aruuvbkI6DTO4/4ScnFc/7A12wKNlLxIe2IcNznqJlLtaePMKy259LhFlsUukWzzzubBZnuWDyEGIsbSqIqeaY0ZiBsIfEwJDD2DcLa3NgBqRSWqYEYSsj5mrPu0NpLol7g5hC1n/lOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cp+9mv/o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abec8b750ebso38627566b.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742424753; x=1743029553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEpYuDB4KVECTz5kVtQD0Kwu023EfQfhNZv9+pX30os=;
        b=Cp+9mv/olGbhaiPCe9cICnILXp7ll6Eo3TIWKYF4cHvLcS4JyKgHKdwq8I1OmKDFmb
         4wuYscBZEYs/KxiHWIfppwLSEYTesV/8hlsTGM8HIdjiUZsDywqJr0Xq7o+A84fjaCF/
         qguco7IJyVKpkuXeRdK1W0qFljlvmoOoyqRbMnpxlAvlml0Vw52sIDANn3Zj1C4q/Gba
         lIxdJAGJNXWOEs/EVLQbySCfIimS8vcEdYj3JzSfMtQV1/Cu8qdBBgECwxU1WTzoOpfF
         0LRahufBhg79RzqyXjH+N2sMf/qCiTzeWkTcXcmXLv22wIkd3MuUgvpI3xJXmob6eKqs
         5Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424753; x=1743029553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEpYuDB4KVECTz5kVtQD0Kwu023EfQfhNZv9+pX30os=;
        b=IMT3ly7b/lL1WufVhq/wZ9wlrqblIPHcgJPXhJ8ZDYpt1uTAKMucb5TYbpm9jL9mBY
         8Atpuqkurzx7yWBxsF6rWpGc6pBXcTYUW1+RmyhUvkfxrtT2nsjJp+3JFLvd/BwOA+18
         gJ5RfteM9MaGxc720S1/gPkjZdHDoY5KqKXx8AcElVyiZvrJ7NWwwGsmr/+UTBxPv/vH
         coAPCFuo9KbtPXzDuWgOH4AeJORm5BCKBeBPk+2zklwJvY5O5+IaSgXimxIZh4gp/Y/6
         MsX5HVpwfhc8D6+lTM9JwN5yov4CYfbs/qxYf3DNxs/124TOdTMoD4c9H6s8kA6vXLiT
         NCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9cjCuMzgpEp061EJ6+tZlxpnBfDIxhc0w+kD8eBKU1RoPX07UP0G3GLQ+JzpZuEccvTI8Tx3Dax8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qo0oOmXqwo3xUI/rTVHK3wv/2n140ia4RqfhgIsNT0nIeKIl
	tpUlSml417W9ErDZl5IxDVWcz2chw8yuES1COLkQdnB/Dr3u5YyVnAy8hbXayB7YPx2UPBpjjAl
	MG3FzXHeDO/yaXBGzAbKP/Ipi90IoDLURX/0A
X-Gm-Gg: ASbGncuDw9B5Iqz41i/1N3KRkqwqQ+2waXeN5PLSRjF947FXlbRqO3e/U9JA/nI9Okk
	NI2QNLQJWfkisq/J4VKSkmakwxaUGh6hPshh6bV8QDuvrvqNSffPoKw94UPMjcJssepGIpnraYo
	fiCwc4nt1Tdc9StdvCaFXF+EalrRxu3yc46vzRv7jMSxh1lX6KCSNAEall
X-Google-Smtp-Source: AGHT+IFpFkyc3aJVUJNsfdDwR0E+SrBYOjBObT/CKauj5i907Xbq1NEeDKEHd4ATNIT1J+Cplco7+UzmapXSyPwmtcE=
X-Received: by 2002:a17:906:4795:b0:ac2:c1e:dff0 with SMTP id
 a640c23a62f3a-ac3b7d7c110mr379867066b.19.1742424752984; Wed, 19 Mar 2025
 15:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com> <e03bf65b-c961-4196-8844-c61ac59a4a1c@linux.intel.com>
In-Reply-To: <e03bf65b-c961-4196-8844-c61ac59a4a1c@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 19 Mar 2025 15:52:21 -0700
X-Gm-Features: AQ5f1Jq_6niQMEuTZjwyU_plBF40bweAZcGV6lcuu4Z3zwarWgSGnZvm0OzorDU
Message-ID: <CAMC_AXXKqTMN2RR4d-h=Wnzf6kHG8Y2T028JYWDNByNE6n3Ttw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Rate limit AER logs
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

On Wed, Mar 19, 2025 at 3:29=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> What is the baseline version for this patch set? When I tried to apply it=
 on
> v6.14-rc7 or linux-next, it does not apply cleanly.

v2 and v3 are both based off of pci/aer.

Thanks,
Jon

