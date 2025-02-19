Return-Path: <linux-pci+bounces-21785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC511A3AFCB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712C27A51F5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E52191F89;
	Wed, 19 Feb 2025 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z25DlpRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DF28628D
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933405; cv=none; b=i7E/eJm5ejmYWD/tE6cv0DxWTrClhaKO7Guuoc+in/Dw6qPLXc5JUw7grw+KR03t+m0WiTKogMYlJ8rtw+vAHpSPjkChdCiYP8oskM5NHIUHocg3asGOcAwcnGvvXN6OiHZeCtDh3iKf4rDCizKmH6v6w26TlP3X2k81TyycUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933405; c=relaxed/simple;
	bh=9TPgVvszVEpWDif2eien/ckCuDA0uLlwGVqsp78DQkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLQCS2Ez5ZqlharCKGMwekIC1VF3ubh0nHRbVZ0DHpMCR8DDhcgvoZ2ruZaQd2Ta2DsfZdsCNL3dLy18Ja+7z9wWvEqjvxU8QF0s4a38tuMb5Z3/4IIKgGimQBCExUmb6kUwPfPluwXwYYxBN2c2usgRQVowfibis91se9ezUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z25DlpRy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1269566566b.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 18:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739933402; x=1740538202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mghkcijHvSkwY7lqoFgBt/wWOCPhd1kCHkaVGr01jZY=;
        b=Z25DlpRyjA7SqcpIjPsjlczPyXubfRmMnKJqKZtP/YiFK1R34g5kvwSjEj73CX6BvZ
         3RsPpmMKGHbJqCqCCC0e8xAjddZ0sKPQ/bPAltjivyDKIn33GUYEXCYt9YhjyMdUy5HN
         QKlp29k3FxzVqjy6FdkkM56NRhURdHqjhSCVWw+o80hBtWEGJQTLY4zc2vbPhfvO1S+I
         2h82E/9k08PWTsNpusMl/64Ffwn2rUzOmvICLEGXDXJ6SHcUhRSndj+vCDO8FnCov7DF
         dpEJhVLie78HGeBXD98NpUaX0gSctLGdbDpg4eg6NlYnsC0CpI7S+AaLBMnWD7mQxLMU
         w9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739933402; x=1740538202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mghkcijHvSkwY7lqoFgBt/wWOCPhd1kCHkaVGr01jZY=;
        b=atomUu6car6quE3vOOHb8WMY4eh57cebaiq7PpcuQADpGuP30hdcoQXXpJ+EGSVGKm
         TEvFhCjHsdVuZmz++8tvNP6839MTRLXPikJhZ4l6VjRuo2oYzxOcxB5o1DeWVFtMn7y5
         UFBcCBqCvud4kkDWsFEPN8aiei0ELy9X405gWb2mKlLdjlg+/wnyK01eJkz12zogSCFQ
         Ya5cM1EuSiJ0V7FzChji9TuMFpUasuosYyyXVYEEdbV3Afo/ecikOKCAKrV/V4yFUGWi
         DJ6an9MXI8M7vhsldcBGEGRKT9DY43uf9HVhsW0eVBUWVambyylhVPeJYccx3xrhNnJQ
         OWKg==
X-Forwarded-Encrypted: i=1; AJvYcCWKBKG94IUhs0dHKdqdvbYOToXI3JdafPz/aNnSnwhKAJEN02ecqfDxQT0IvrWa14A47iQ1Evx0q9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgdbmdWa6gyPOBg6r0g70xNcPnllydm/hCtWsgAKJQhNkA0iT
	CQ8wEVIkjYvtsxq3UigByZ/0G/H++QzG1h/762FMVgzjPIL19V9IKVTr3vj1rg99UxRxO2b89Bg
	9Xp14Fyguv2kmfapAETJ9Wd3jZ2C87m+P1EDr
X-Gm-Gg: ASbGncvnNwpY5hcV8Ka4cXyYCoaDAxggDzVZiEXHjLo3qnoQZbj9BzoI+qUV92Pcz/o
	0gGXeRv4LoP8iwz4hGzBZ51I5YC94E4vqk3F3Bv3ZztNd/m1Lti8o8bzxMvAjznEGkXMm5lckP1
	ZrJGcYQxfepqVwzYRIYFLvetobdyU=
X-Google-Smtp-Source: AGHT+IGvSISBQrl7gJFz9sXpxsutIqmUl6ogOeX3UPLPQt83+pmAzH9NWVtxpeBJkQByiyEK8u17MYvbsdjUzWdVBVU=
X-Received: by 2002:a17:906:3190:b0:ab7:b30:42ed with SMTP id
 a640c23a62f3a-abb705d6a08mr1438741866b.0.1739933402384; Tue, 18 Feb 2025
 18:50:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-5-pandoh@google.com>
 <07985e7b-98c2-4b77-afbe-07a2338e032a@oracle.com>
In-Reply-To: <07985e7b-98c2-4b77-afbe-07a2338e032a@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 18 Feb 2025 18:49:51 -0800
X-Gm-Features: AWEUYZnY_W5E8kBXMZP7F8j84gdUirhVG12zkDaky58qqnPDeMZ1GK07dO46t3A
Message-ID: <CAMC_AXUW8jZbT1FDM+EN8UbabqOb-KF7aie3F9K3Mb+emSRO2A@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] PCI/AER: Rename struct aer_stats to aer_report
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:29=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
>
> On 14/02/2025 03:35, Jon Pan-Doh wrote:
> > -     dev->aer_stats =3D kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> > +     dev->aer_report =3D kzalloc(sizeof(struct aer_report), GFP_KERNEL=
);
>
> The rename brings back a checkpatch warning (to use
> sizeof(*dev->aer_report)). If you feel like it, you can fix it.

Huh. Similar to my other reply[1], checkpatch isn't showing any warnings.

Maybe a divergence in checkpatch version? Mine is 0.32 (Pulled from
pci/aer branch commit: 28d3871db7ef8ad0112f195c48a72d8638af89d1).

[1] https://lore.kernel.org/linux-pci/CAMC_AXVgYegnfc-vyKuxZS-Ck=3DaCJ95=3D=
HqdYNraVv99kXxw1QA@mail.gmail.com/

Thanks,
Jon

