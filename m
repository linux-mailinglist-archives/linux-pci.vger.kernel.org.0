Return-Path: <linux-pci+bounces-24256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A84A6AEE0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E743B52E7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EA1DDA39;
	Thu, 20 Mar 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPzMtHkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19761EF378
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500417; cv=none; b=gs4h9ldF5y8E3gZfJZ1PaUH0I/1jaQvaYAtgYQouh4FxAS3hdB6G4b7q9qK/Gxc7f2UGcAkjXh/8G5D+IlDMnpWfN5080Ri3vKEfM6R4MwHm3qPANl1MhTbQ5vIyQxUrwCvK9Rr2Ji3x0oAnOnjuzshm8hrHQ1ATuXXM9bnYniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500417; c=relaxed/simple;
	bh=ZtrFPx5yN8+EL43s3XburPj3Zd1/wSkoFKBleLq2oZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKV197xZqTFtVzg/hWohg0dZfBrg/5ly0RcOtqKIU9i2y8US3VUJWEGpw9QabepPZRpF/xC6e9U728ZvVLZoUgGiTFjjTZrMR6ouOMkWpGhCumL6XOtVFVcGXk4qSTUCuPzGdqo5PDVForbh6mGdNOfT7j7aaouyk1xu85osBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPzMtHkl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so2499589a12.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742500414; x=1743105214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtrFPx5yN8+EL43s3XburPj3Zd1/wSkoFKBleLq2oZ8=;
        b=nPzMtHklYdl5F8ECvbzpawatmXCtXKGArvzw88ZLT2nSL0AGjUjYAllKrF8wBIzv5Q
         4eO7g92DIevyLW8R/3lJXrFNwi0lp8z/tr7ta3Y+QFzukIg901Ap0nb5kRXS0aVLf77i
         nH+huMR7nJppEIKDEariJM+NSecalys5t8QQTPyhD5NTrtcr5ua8FB8su/0a9QjZ6YAt
         RrlqQPBgfwytvYSbRD6mrOM1pXwgXzoCNQOZsYYZQJRfLTDoiSp0N5OBWFTTzKYOxpIJ
         lMczkcr5p3AuGOOE2BmUxRgQtFfUv8tIoiEaEqIV1PlMrMgvn0W3hGget7fG5X322h8A
         WPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500414; x=1743105214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtrFPx5yN8+EL43s3XburPj3Zd1/wSkoFKBleLq2oZ8=;
        b=CM90mFUAu3MT4sHco6aYAGdxB8/VHMIZIxDbKU/VkWQDJg0K2wZZVdflKks1fWJsnE
         oEwGaHG4vTFih5kIkajeRcsMJOoCEMYL8VswP3Hu6WNeraadW5Od4xA/oEmaH6UpIb7Z
         s79brn6gyvLcUNKPZCJQ5leehuq3ItNvvZHdWElYqS7Msmd4T5EY2R49JjuLvEw7PZbd
         SjATMpZnRL6IhH5cRzp9L8XYNK8DgdMyhhEy4ZBqa5ITNs8zk6gJFvIhsHEzB+W2j8Zw
         Y/ew3MqVrjulP5KRZ/2lfTRvkDTdjy9ET4AXO32WuoSjIvZcRyXEgpgaj0Tuj4zHqtj5
         b6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQhZ4xMuuv96ci+Z3QGJmDPZWJgQMmK9j0p/qKnHC/sA4g2lIAEZRJueMAnXNI9W596RrIgSmmG5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8+6fDRynMFVllptI3cIjjzUa9tC+YyEAtkaWvj0UmF7Qv0qd
	jP+nnfcpV1aTRCX8oaD6H4aED2CoVmFfkeV/H/xdhdSbOHpLDknEBUkZQ1Xl3Fz4GgkWLWb8DZ8
	25PSTbbUQNjanlCwSj3UvxN1p4QB9iyvjqGED
X-Gm-Gg: ASbGnct1zXcptWRtw3/dzf/ftVSnwA7dsgathlg3o33egJec81zRTlaY49iShJzCD1q
	9jTmN6RmHwuU9KhQ4HDFfnJFfkS7TyzlmVKbvgVInrhCkjXteJixc9qKVuExY4iUQmmgVRNQoQy
	Vo70zkjb8dHBTTcxBkaso6CYzqk1aDfcIWTnaKwZrQlfSQWcyqj+U+5Qbf
X-Google-Smtp-Source: AGHT+IEVyd0N7GU6mefVwHJHAkZIhtd+dY1kkzxCm3WsMkBdeVp2OzXNKSsSKsprer8GIhz9mNZOFm2yTaRr9Dn8Zd8=
X-Received: by 2002:a05:6402:5255:b0:5e7:aeb9:d0cc with SMTP id
 4fb4d7f45d1cf-5ebcd40b55cmr555220a12.3.1742500413986; Thu, 20 Mar 2025
 12:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-5-pandoh@google.com>
 <9aeae39b-b923-453f-975a-cf9445459b0e@linux.intel.com>
In-Reply-To: <9aeae39b-b923-453f-975a-cf9445459b0e@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 12:53:23 -0700
X-Gm-Features: AQ5f1JpExhpR6CMgd3eXThkb4sj9_gYERIjuMVN8SVCnSNkhZ7Y7BUuRsYq8u2k
Message-ID: <CAMC_AXWYgGKKsqSCwckFzdT27ntY3fmwjft0v87Otp=WO6yzvw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] PCI/AER: Rename struct aer_stats to aer_report
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

On Thu, Mar 20, 2025 at 10:42=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> I think you meant rate limit will be added by an upcoming patch. Please
> mention that it is a preparatory patch for adding rate limit support.

Appended to commit message:

"This is a preparatory patch for adding rate limit support"

> As Bjorn suggested, I also think be aer_info would be a better name for i=
t.

Ok. Karolina, given that Sathyanarayanan and Bjorn are partial to aer_info,
should I switch back to aer_info? Or do you still have strong objections?

Thanks,
Jon

