Return-Path: <linux-pci+bounces-20091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC000A15AF7
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 02:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07794168DD3
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC317548;
	Sat, 18 Jan 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/kwgp8H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C117C61
	for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2025 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165545; cv=none; b=WS+GVcmPQAzB6lqufF9Wbn3BAyGdEIknxYg/Ap4RbumWT+q7ls5ygYmvq6hQlMo0Y8+4mJV3CRwfhlDwgv8rbbHeoOUwXl44zs5P3SOYbjKmsN/9NWvaR4W+lqFVm9rElaHi8b5Ro2ccJwDNc6lIxidEBdaUyDR1H/fxOXOCn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165545; c=relaxed/simple;
	bh=7lA1be/MjnpDtG8ak2aEKoSWJu90/PqOCkthVEr1s50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JphaRfltpEdRUUfuWZt1lqVJmkPWf9XVzKdcGZaTmy3j6EK3e0rJsS0txqDlButwU3X0h2nYLjsJwGVNUy1qPnswf+4qTioIf/l6DdycRo+I7kR+trJ0st4pauNMpG5Y0YUnEWW6f6x48dYfGq/hGOlXIwAkYMQC1FE9LFEzQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/kwgp8H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aab925654d9so475458566b.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 17:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737165542; x=1737770342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgR9td71rsrVK7AqX7TY+6fXAEKn6zvcj65L8wXX+vU=;
        b=b/kwgp8HQJQ6iuU5UC6QbUeebbs2a8Tw38isVRyJK68jy3iRsHcyHErar+7Lnv+6sv
         XG9EQj9h0VJU3KkRMuxSEY81nNu5+SpZEfkFENksELPLVtRhnHjV+/aMTtJ2HiC47MvA
         RxIJ8O32lPIqXOeN2I0uL9RW5MJAmFFrKp3v8teoaTfYhT8rIHS0OZ65uJ9XkfJehQvw
         i+03vWBXU4AGXWoqEfRHTFBr+dvzJ4Tj/WDrMNEmSp+W2E3LkDFVDYa7B5n8I1cf26jc
         500QECyf91SIrHwv6ej4mdjozdHvdMug8n/sDebCcBWKuHX5BxgxVs4txT6IQtK8Jkhn
         M9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165542; x=1737770342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgR9td71rsrVK7AqX7TY+6fXAEKn6zvcj65L8wXX+vU=;
        b=n9fKL4DNqcOfpcGkLkcCNLNtkl8HLsTlt+TGZ6EZnhFifmC6M9YcIGSvXtKccvJ5g9
         wSBb2THuDyJEwmVNlB3LSol0LzD5KLDX/AHaypVF/LtpmDXyNpBHb5mI5tDjTS8ntNKt
         xdC0gas7ud2NGnVFMqBT4uRzSwiyIpol6X25i5EavjBV1J8fg2kupDzioyLpXOoz4c5H
         bnWi0RN7rRGX69/qP1wOHTT1VQwu5kltCKUCytn/u99p6cuc8emvhlV2ENJgHzhbOhi4
         5770UFHju9ALfhLFFlEA/QFJqGZmmXLN9sK0D5cwoAk0TBZu4NmeCJSCIRYXFHo1hljw
         7XMg==
X-Forwarded-Encrypted: i=1; AJvYcCW8aEDsVCR2u83t8E8WywkEcE3cjfoJXCCb9EY/3Un2bjpgo1bTUhIXRhm8SsoCf0v9FEGWILdVJo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCS6hxVhqKXzGwjxEYMRTMFT9Z8JWHMDVHTc1BdQUaMmilJDP
	Jxd3DdYrw7+rRYYaYbjLIY9cOJlMNRN+S7+1nMj+LoNsvyWDKOijWLpGEWWM821Dm3Xa0bZLt81
	uMKYe56dFrnpg09J6i3lP+HOR3PeU/68F4bZL8/iGlDD9jA1t2Q==
X-Gm-Gg: ASbGnctsAwH/NboT2hTay2q1Gh2sD+iB3MC96Uak3Se0o45yOVigmLpwL1ZCrtTrg2x
	gyCZ9UQyA0VplDxjwY8b1HimKczXahZFRKJSgrrq8aZvaK+zRv6jC5GOaBz/wxNam4RUbgCrwYH
	qLlA/tkQ==
X-Google-Smtp-Source: AGHT+IGJ/LB7885y5n5pJP3ZnSkCUHBZXB2eXelZEjx6T2jNKRLKq2NKjf9VU+P3/3YBf0XfYEa7e6FG8XK1KxfTRtc=
X-Received: by 2002:a17:907:6094:b0:aa6:33cf:b389 with SMTP id
 a640c23a62f3a-ab38b321474mr438061866b.34.1737165541683; Fri, 17 Jan 2025
 17:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-6-pandoh@google.com>
 <8b6796a1-5504-4d95-a565-a19272d04350@oracle.com>
In-Reply-To: <8b6796a1-5504-4d95-a565-a19272d04350@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 17 Jan 2025 17:58:50 -0800
X-Gm-Features: AbW1kvb8_Uzvy4dm7HyIWYzJ0WJs1jXfCZ6ktzTToHaooCx-UQYJ_CHH3wD0ukY
Message-ID: <CAMC_AXUeUqxaqd9_rAx4cYq6D9QCEkxUS6p4Sx24xZL4TQ831w@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:02=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> To confirm that I understand the flow -- when we're processing
> aer_err_info, that potentially carries a couple of errors, and we hit a
> ratelimit, we mask the error bits in Error Status Register and print
> a warning. After doing so, we won't see these types of errors reported
> again. What if some time passes (let's say, 2 mins), and we hit a
> condition that would normally generate an error but it's now masked? Are
> we fine with missing it? I think we should be informed about
> Uncorrectable errors as much as possible, as they indicate Link
> integrity issues.

Your understanding is correct. There's definitely more nuance/tradeoff
with uncorrectable errors (likelihood of uncorrectable spam vs.
missing critical errors). At the minimum, I think the uncorrectable
IRQ default should be higher (semi-arbitrarily chose defaults for
IRQs).

I think a dynamic (un)masking in the kernel is a bit too much and
punted the decision to userspace (e.g. rasdaemon et al.) to manage
(part of OCP Fault Management groups roadmap).

Other options include:
- only focus on correctable errors
    - seen uncorrectable spam e.g. new HW bringup but it is rarer
- some type of system-wide toggle (sysfs, kernel config/cmdline) for
uncorrectable spam handling (may be clunky)

Thanks,
Jon

