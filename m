Return-Path: <linux-pci+bounces-24255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66632A6AE9E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D805F463E82
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DC226D1B;
	Thu, 20 Mar 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6ww/57A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875671E47B3
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499446; cv=none; b=AMRXbNNxk+1aCLd8DH3gIhr1pLUflyq7hEfD/on2f6ZdV8OrVBluTRO+4/sg/7EmZ7TkTMBLyaDUIhOJJTrLtJBt0Bj4g3+utLlVWfZKmu6PBtcmeSlJH0Y7W6OvKW6zIxJRTkYnbfh95FqU6Gq2YzxetwbhwRQZDT9nDr7a2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499446; c=relaxed/simple;
	bh=3vidt0pghC0sX+2onRr3/I/NAHLtqJiDQJxFgqJsW6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzGSdLDOuDuuaawcgJbyHUxSVKekHAnKaypGT0qYDif/AC/tSdpMKggKfGgYjakrZph1bXbZ6buRIgq51ZMeFGMuLzPv8p6/8nNwv+PkWSCrXv5ZpTQFhn0Ou97iLugdRHMzLStKv4K6Ncs1PeRFyhyXb+nO7coFwXX+wMilQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6ww/57A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso2153568a12.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742499443; x=1743104243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vidt0pghC0sX+2onRr3/I/NAHLtqJiDQJxFgqJsW6k=;
        b=W6ww/57A1DA3PAl/iy9tFO6PkkoLXidGDM7vwvCYi5ceQnotKIV/7P1hERwG9JOaty
         c96dujZnaYLXmNVgJgzh7cSdEmKe50JR+k9UAS5mQoIyVlAHpIqlzQqdVqhr+CkJb4x0
         7uK9Xnnr8a6Wy6yteqez5cPJqXahXuzuE2/Zyg0YyIfOUoI9NP2rXNA3ur+CHtUg92Sn
         i1JCMzskMBAOX2i59kvEtzGReMQpOV7mjwM1FmCTxt1ECGtu7JDLqs85M5RwuM2KtHpL
         YbdcJmDIftP1fwr6l3u2ooJftS52LCPnuGzHa8S5Odxn/zPU0XSevqzpfAfbZ209IpB9
         1ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499443; x=1743104243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vidt0pghC0sX+2onRr3/I/NAHLtqJiDQJxFgqJsW6k=;
        b=Ccln6GnVE0El+yeni0fDv2kBWimMPh3hLBkckDRX71NImueRB8ziTgRe42ZFQdkTET
         kOxJ5lVH1OSEnlx42J3mYbdHgPXAUMr9jPrCebyfMgAN1EzVn8VNutJyFKVlb5qTnNEu
         OnVU0cxQd+hMljej3dJSfaS6bHgDXuvdMOdL+x76NXe/rVLG9dNHojZzdMDWkXzx5rya
         kKCU0pr9QM0fSlcLWfT6Ql6w5sLKIBqgFA0N1RP/sa2z027YeJdiuQ630FTDj02VyxSM
         zTKppQGQnqyHc6wfKMfNaVPc6Z155tzhqdotDly2MSQNB82z8jazjWmKZYzZIfgTObpD
         jMrA==
X-Gm-Message-State: AOJu0Yzo3Tv6gNwSClvpDs/PSrsgDXml70CyScLPJxseuWJqv5JS4RR3
	KZ48hkyeFB12xzZKPpKyXOT/vV3GoMJse5sRtzB5Jua7pN2I6PuHaIOTC5Ktu/377Vj8AS1QvcR
	kXCgqwTAWONnozRgOTTQJMC7Ra4PyyBbpxqCf
X-Gm-Gg: ASbGncsWv3B865xf2JTCvpR5UCuIuOTiHjrrjeMAJYfYLHn5JBjQy4vpS1OuR+kvsQl
	VFiH9M1tusaxzoqjTY6/EkQM0o5yAtJJ1KDkSYUNDXEhuCj2O/RDDptwZQuEqAuVyVs2btz8VL1
	iR0j/UUnuUH3+kXYcKgPEAxlE1UlsXrC9qL+FV0EwdhsT51kt8UnxTN7ta
X-Google-Smtp-Source: AGHT+IHp9jZ2IGBFaOxHXLqEeKpGCnmVRUwwwMqUfigFisRYBy/7jvEa3r3pEAWJ2DX4P5p3pduGKftSQjh9qNDof1Y=
X-Received: by 2002:a05:6402:1d55:b0:5eb:1e0b:2bd with SMTP id
 4fb4d7f45d1cf-5ebcd478787mr527839a12.19.1742499442645; Thu, 20 Mar 2025
 12:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-6-pandoh@google.com>
 <ebafe3cc-2d0f-4000-863d-20365977e27c@oracle.com>
In-Reply-To: <ebafe3cc-2d0f-4000-863d-20365977e27c@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 12:37:11 -0700
X-Gm-Features: AQ5f1Joq8JFA25HaD-m_D4VYy8TqCyC_TFwqSSLcVkdQAb9OoL4Ua2PzxRm9_Ac
Message-ID: <CAMC_AXWZHjxXX7rpZANGsZD2_RAcGC1G5gF=C6uhEtNbZMbTTg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:57=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> For future reference -- please drop r-bs from patches that have
> functional/bigger changes. New code nullifies previous reviews.

Ack. Will remove in v5.

