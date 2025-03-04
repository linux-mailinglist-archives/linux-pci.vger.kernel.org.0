Return-Path: <linux-pci+bounces-22801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CBDA4D06F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 01:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F94188EB6C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FA28399;
	Tue,  4 Mar 2025 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8nGf+Eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8621282FA
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049944; cv=none; b=ineaCVNYcZ3BropKe88qA/c36chmPs5LqzXJgRMYKsC3dy4ejT/o2WorYkcORrI7f+9JVe4GfduonSjkdu+sNKvFRx9GeCAabl/sh7WPahESlWwuRSe1kx/KyBLpR89Sg/ltT+IhkDGiK3dOaUvilJV0B3f4jx4bJeGuMevCv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049944; c=relaxed/simple;
	bh=h8PL1WMjcCFowC/gqpiryUqgzD23BLd0QRq0cKact+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTF34sTgeX/G0AOI87dkm46KxElyRcLToukJApmR2/2LLMswUD18/qIZECua+FmFG5ULB6F06RrnHAOnDfbfQhal5cnFf+ZhBBVmIiXLV+E6R8gob2rIr9w3e7mzEisdI8WqxsP9ChMH5WBu4RHMRR0fnIq5but6MDr2+mwdCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8nGf+Eg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so9066469a12.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 16:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741049941; x=1741654741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8PL1WMjcCFowC/gqpiryUqgzD23BLd0QRq0cKact+4=;
        b=x8nGf+Eg18S8c85vPERdmjoE2+y4RCorVQWiCcQlhCytwxvFR1xh40l25+pERmOM91
         LysV3bkqj4hitJu4LWcwu6cVzfGAI3k9vVZTQ/D4yRL+S3wxtBRzVM45kXAaLpKGDdom
         dIqxdbfs5iAx0FcNczR8G4nRacJEYGiRGMAkLEW75EzUENB0oVHA55yJ4AEZA/lm0N69
         5YwpG82lRkgdsD6CJJt7isWiKCxpSr0cjcWQ194pp7dh9PIXDxuh/p5iAcpfqWpy/HAt
         zEL1Vv01NoEIdWYwSAAkHqb+5A+jTm/qZKpjCZb3vNNmLKcGJ6IbZQ7y/sbg+R8MIsqw
         TEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741049941; x=1741654741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8PL1WMjcCFowC/gqpiryUqgzD23BLd0QRq0cKact+4=;
        b=Q6NREY62E3fXa09qlqP+by1IkxWzdnd9yGP8dh1ZbBYzxS/fyWFGT8bRBgnz+KZqgj
         fb5xVCrygqLkQvhjIJNkn6IYHiMBmEGlq0UG9mov+2UREfnABSU7zVfoZIeG4e9oPpSE
         WCqYTazIGHAHZi957Glj/KxogO3ISdV/piSsJQF+GFx0s0TbTbb76KXW9O2bFOIBuroH
         X1z9eyAYwILZEhDVc5CZjIL7t1a7CjYdF6yQ7aIPhrxuebyipk9QdOCwAWRnGFXmw7Ug
         oaHOFruPBfAVvAeHiwNFQd8CRgph8NZ5AEAW7Od/YZ3o1C0YLze4LNB4b6t5QJkiDCDa
         FrVg==
X-Forwarded-Encrypted: i=1; AJvYcCUfZ5Hhy0s5Fp1xFAmlVPvK9XqDSRvZX/oZP8v/03jkcmFdE8x6Qx08wDJtHMX5OJ5DsHO+Fp3aK94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpaewBqva2Yhz9au5jughdy03SIQUdQP6am1zNirnBgKot9Ux
	OGMhSxiZANZXOF5OYBd/7nJy10sNubyfuAfQ4bJn+7Jdw7lT8sKtCRCQngQSbODwVPkbr1/7cBB
	9W8EWpSPT1MbSj1VXqUyC0sMCmqkrx1nS2kzA
X-Gm-Gg: ASbGncs5ThDnaQqQhi9m8R9oAyi2auc/TDDOefGnLUPGByvcS5elBAPjdnb1gGtI46t
	b9OSz1YcYPDZwRSeMwP1olYOLjND832JvZI5rlmdcutXrFDaHj6Eb4YPNiyDIxOStJGYPH/XOhW
	4TqxA0TKBPwaVNajY+tvaKalDGep9k9qo2rABwz8pUvmRVGufgdoKcUg8=
X-Google-Smtp-Source: AGHT+IG68wquW3gNv6gPsxVw4+vDOOOvH5+OE3tkhVdkmXDr2Uuro5eWefHjWIo9+hIO1lnQd9sNUrSfo72wrUr0Q90=
X-Received: by 2002:a17:907:9629:b0:abf:6c2d:f469 with SMTP id
 a640c23a62f3a-abf6c2df813mr810412766b.20.1741049941111; Mon, 03 Mar 2025
 16:59:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-8-pandoh@google.com>
 <319344c5-02bb-4257-92a5-424ce72654f9@oracle.com> <CAMC_AXXaxsUDkOa1SED4F6AZ8TQceHOJfQMJ8FpmQ+=gzArV4Q@mail.gmail.com>
 <49bfa13d-756e-44e6-a14d-0e4940260bcd@oracle.com>
In-Reply-To: <49bfa13d-756e-44e6-a14d-0e4940260bcd@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Mon, 3 Mar 2025 16:58:50 -0800
X-Gm-Features: AQ5f1JpakSDEJUWpKmh2eR78u_CogDJedRrD4J0srjI5jumFiQX7_SrkfCp7tx8
Message-ID: <CAMC_AXUZDTWeF77Zog1tTXZ2FMKmk3-cVEbc1PaWnfF3zgGQuQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log ratelimits
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:31=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> In my opinion, we want them to be separate. We may want to see no logs
> of errors but still have them recorded in rasdaemon, for example.

Understood. So the sysfs toggles could be something like:

aer/ratelimit_log_enable
aer/ratelimit_irq_enable (with default =3D off)

This assumes that IRQ ratelimiting part is able to be merged.

FYI, the current implementation ratelimits for both logs and trace
events, but increments AER counters. If there's a scenario where you'd
want no logs but have trace events sent, then we may need another
ratelimit and/or roll that into IRQ ratelimiting (to avoid trace
buffer/userspace agent getting inundated with events). Granted, there
is probably a higher tolerance for spam there than in console logs.

If that's desirable, maybe it could be a follow-up as well? I figure
this series is at least a good first step to handle any spam (vs.
status quo).

Thanks,
Jon

