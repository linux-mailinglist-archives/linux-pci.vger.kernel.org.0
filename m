Return-Path: <linux-pci+bounces-11997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B227D95B2D5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B04B1F21E24
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4514171088;
	Thu, 22 Aug 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z6KnSMSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF727170A3E
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322235; cv=none; b=K1Y95Q/tT1PWibIWyeu3iU8N3Oi1/XU7bmoD7TWVl+bHMjsiCh2UMbIvJL5YnvpKrmAsif/I9n0Pk3iqLnpOeB+iozpkiLrT3asn6O0dovCdps0IQsJ071TRFXBFAQvD2igpUoY1TSq2SBNTVqaEXL0F2SNsbYigTGSzvBWHNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322235; c=relaxed/simple;
	bh=R6FvxR9deCLG09yOCyp8Lj2MV+f9zFcZ0deQ+LYWJoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy3VssJpWBTXbndfC6zWkTiiguhX9DZ0FCPV6t6ft3EpjXTkGPgCXdJw+RaJj+1GVu8uFMDfLEHaBrKY2kPHBx0df8/coZoQ5TskYWs6YYYqpTLGCpRDoNYlJJQthLkP69N4LbzZXeglYChKBA0HIjq+iGGn2Bz2ZfwcLjJ3TEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z6KnSMSU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so640902e87.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724322232; x=1724927032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e45XsMuvKuKXGP1RO13hjtFbIaK2zumMe5ngPJfelL0=;
        b=Z6KnSMSUh6nxpXhPlRBKlpIHYtjyXRxk6PnapH9DtP+RzKS/N9019eIbmD36SYLp9g
         PXADv+sNXU+CM+5bidqr7AMHaPzFwI9XTDHKHSu1q4os7JHPyIY0F6A+/WapRcOnWihU
         Z/J3GCWPzHzelZTC94Rw6IzcH83En5l7+6KXzJDQkGS8Ztu38Zka0znkT7rFXwBL3zBv
         KVMC6UoYnqGuonEUC1xjHZGiT/OGkU2UB13UzpjHvX5yWKhon7Bz3dCj/LuXpK8LdKvT
         U+aoW3Vf2mRRi6YWcWQYODVLh4/vxP8Rh8PL3B7GJwjaD0LaVJH1B44320YBmfO4WnOu
         jLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322232; x=1724927032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e45XsMuvKuKXGP1RO13hjtFbIaK2zumMe5ngPJfelL0=;
        b=hqztle+KRS6Th4Wv5BuTyjrr/O7qXJ/PE8TCcJqaLWf8MD7SUHJ/xwHFFFa4SI1hpK
         0vMXGH8T5VutRb0FmweRma36J4wQXbTLUWG/uqa9zdUM9T8QAk/SZzDwdLl5oCmlAsiJ
         EOsT6ETcQWiKTkbrEt0T3bUKV6N1WuFQ7GDvN9IrG/SWSI/swJZVDkqlgRRvnH6cb0Yt
         5kyArkRxGkQ3kqxWuU37MnbueVNGkrBjHPPpC3XTRzCyC2esC5YkEPaqLWFZF9ubP4dP
         yaE0/0AWYlS2txYdYsCYosRTNeggBb9TfK5T5bak134oBrjEij2xaHvamQPBklpHOHlD
         j+RQ==
X-Gm-Message-State: AOJu0YyMxTyYhvQ1KhBUtak1wKmx9RH5cYn6fsfP724+U319ptsz8O9O
	n7qCVxORpA9MwRv2g9jRxn94Jw0xhs6Gp/aDVLvu2p77azgTAL9Xm8Ht9BqC+DJX+ATrziGsigq
	zFUhdWbCroK/VG6fXb4yhkdXINjWQWLl9BEsXrA==
X-Google-Smtp-Source: AGHT+IGL791QYbF0kzcxMmzPYHGq/lMsQK/STAf8o+ZpSVkQmYBqMW+XKfd6iiKtJPMEaRUNe0uqRDFd0YDgbwU1M7E=
X-Received: by 2002:a05:6512:15a8:b0:52c:9383:4c16 with SMTP id
 2adb3069b0e04-533485ae52fmr3332766e87.22.1724322230982; Thu, 22 Aug 2024
 03:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819082445.10248-1-brgl@bgdev.pl>
In-Reply-To: <20240819082445.10248-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Aug 2024 12:23:39 +0200
Message-ID: <CAMRc=McD=3_+XqtPj8Jum5Pz29S+NAZn=M1yJ=z5bQ8CympNRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI/pwrctl: fixes for v6.11
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Here are two fixes addressing issues with PCI pwrctl detected in some
> corner-cases.
>
> v1 -> v2:
> - use the scoped variant of for_each_child_of_node() to fix a memory
>   leak in patch 1/2
>
> Bartosz Golaszewski (2):
>   PCI: don't rely on of_platform_depopulate() for reused OF-nodes
>   PCI/pwrctl: put the bus rescan on a different thread
>
>  drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
>  drivers/pci/remove.c                   | 16 +++++++++++++++-
>  include/linux/pci-pwrctl.h             |  3 +++
>  4 files changed, 42 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>

Bjorn,

We found another issue that will require extending and modifying of
this series. Please disregard this iteration and I'll send a new
version shortly.

Bart

