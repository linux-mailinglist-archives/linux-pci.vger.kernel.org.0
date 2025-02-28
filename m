Return-Path: <linux-pci+bounces-22679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA74A4A5E5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66DE77AA403
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB571DFE39;
	Fri, 28 Feb 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7Aeixyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6051DED45
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781540; cv=none; b=rPExKZ+2rD2kfNMhxT0OHxP0wj1xIKmhsPf5hNdEq/cEMSmpbFcnB0yOATi14sM8s5Cgevar4My5DYw25m/jyfs5KHl+690KRcO5yH1I+g0Vq3fAC97TKka+ilQBr46hS1ISQDgemWya1H4aJ37B0fUnj8RjS311ZwBTOsSqzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781540; c=relaxed/simple;
	bh=6MyRzpv3WUm1MPCB+Plboa+7+KfzA3UsfgRa6Aorjhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxNfQ2XOcRRA6xlK0AROTDxZ8z7vCtTBAq0Xnj+CewZXY8f5CLwQHUSHifYZXQB9Pl9sLJ8O+uhHjVFBhz3yHyHURnG+gmSK/BzXKJKdbJR+6rMq0Vfk7w/x6MyKv0QYcGXdoVklZIo3+MSBDj5/qLSO4/N3ZIwCwUlcS6+BOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7Aeixyo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so509200966b.3
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 14:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781537; x=1741386337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MyRzpv3WUm1MPCB+Plboa+7+KfzA3UsfgRa6Aorjhw=;
        b=i7AeixyokQUT16YX7NSQZaowIqy+811EoyFnnsp/GgrnwXxEdluP/zuJlsQ6myu/+W
         bg7gKmtfk9JUHaKMIe2AYzYstfPfToKLjDBlQT1xJK+Lzu2XBZemjb4vyElDmC4EMeQa
         P4XO+k10usovhwL9o+rRisR/TF2WghxJxsBRnRNdSVJHrR+bJXqbGMzbiIqfs3NwHr1z
         Q3N6g2f3kY4Yeujfwmmh6AdzS+EfBydj86EWoLfFsMNE5daZf1wb1vSIcbdwazuxPJPm
         3Zlt3JjAV7IpCzAwzigPj2tmsV6pEC76TYVw4Pns6/fdjISxhbsr6k3ium39hh0BekDl
         liTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781537; x=1741386337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MyRzpv3WUm1MPCB+Plboa+7+KfzA3UsfgRa6Aorjhw=;
        b=Lea2sC3CdHiEjyMq62UAEBeJwueWmx5sMjyYrRoo2ThVSpedn9avfNlVSEz/dC+/RL
         5rq72ECAt379PK6nTYcK30Zt8heJBwgJ+G+1GVh0ZwA0s47xsj2kfvDu4sD2K7rC8Syn
         XEe6BVnT1+9Jr7IzFHPDMjcaifLm/UAUvmHlJfFxgF2MWzPREcEbz1IKUZ7p8SmYERqK
         1ljkxoU58+uU4tyg2+Zl8HG+8z9FTaHvlKPAIwekHQ1kBhINRb9flABJDpJNGluNEEH2
         EiGa3wANVkj5jOcck2p1yjwSfYdhkyPEha3DS4vFneye7jqbFc509CcvfA2vdnG6osEY
         xIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXtEsgFctkj8geTeuLFUzFekFbQGRBaBSVecyLN80RQ4IVBMPpSkIbzR7p7/HOIGu6NxdD5fWQUhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+r/7mWIPVcLzcZzoVvIaXBxspcqndkp+TBFWsa5nJ74AyWJ3
	NIcC7OV2Zt+r8dT5RNVXAHCVjeanEUJnQxKv0/aCbZp+kN98G9H0NUg1EJJRksyEjUiLh0O/SMw
	s0wzVhBWK40qbqHae/x2spBCilInCpeH9DLx2
X-Gm-Gg: ASbGnctZvn7Bu6dgw2ju8bt9myJbFVBE5R4s9NcYhOyU/FCcqeTAM+XoGf+MXk+OG6/
	QUxYB7OiHRYbwST6zrckaoIgN2+46bv5upw90ZQYevfpYUDGGF6cXBLqHji8M/FfkGzLiEdbUP1
	uCVHWyMmPTbXPm5dE3ch+n/RotK6IzdofhaFJC
X-Google-Smtp-Source: AGHT+IGn7tbcEiVrjYMp9XP7Z0UbCgWg+AYN5trakpUsxNhCBhw3jQG1RgS0X3mqJW7K41ymLsrWSknOSjOuWkZLAZU=
X-Received: by 2002:a17:907:3545:b0:abf:44b1:22e4 with SMTP id
 a640c23a62f3a-abf44b12416mr221035866b.11.1740781535677; Fri, 28 Feb 2025
 14:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-3-pandoh@google.com>
 <8e94ccbf-497b-4097-87a5-761cbc7c205d@oracle.com> <CAMC_AXVgYegnfc-vyKuxZS-Ck=aCJ95=HqdYNraVv99kXxw1QA@mail.gmail.com>
 <bbfc780c-115c-43d4-af33-935b447f6081@oracle.com>
In-Reply-To: <bbfc780c-115c-43d4-af33-935b447f6081@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 28 Feb 2025 14:25:24 -0800
X-Gm-Features: AQ5f1JocPTbruv3SQbDNzYYBqX6Sdmn9xZya4PNLgNlSG_RHdlOOENkCXstGrQg
Message-ID: <CAMC_AXXne8aLsQpvQfSWWJDxx9MzRQC0-dGs-a+9vkARzRUGmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:27=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> Right, that's probably I'm using checkpatch with a "strict" parameter.

Ah. I see the formatting issues now. Will fix it in v3.

Thanks,
Jon

