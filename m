Return-Path: <linux-pci+bounces-21790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756CA3B101
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 06:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC83AB371
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A41B4253;
	Wed, 19 Feb 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="era62A4A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8A25760
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943783; cv=none; b=L5p23yO/x+iEWhhjsU/mZxgcdpRC9zKilCS5/HaYVNrm37dDwvcNk7MWHp5YwiSb6g6P8xhLOT1T0iFPgvQeN8BRyexLoEzpYFJT8YqvdhvklagAv6/97O7EmG2DJKZ98V2E8gsVNdvNHiDNJfRYNHKD3wtXznBQOn+NLgTXld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943783; c=relaxed/simple;
	bh=cNdgI6Lnk0EJfyZsrjALV4Wx1Cs5MjpDot82WJnw4AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDG/3nmSnKk8THfnVEOe/WllET9Mq4AFPQ8MoP2eIcbsxIz0NopQsXbAKPPjsLIBhIaMUBKgOVjHxSErbAyFbnxfDiZht5Jw0XKlhTY2N62V0q67/U+f29YiglOfmA4O8kNSDUm63Oz5xacK2V/q8+oIePOSqV6rhGs1Bfs+mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=era62A4A; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaeec07b705so939404566b.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 21:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739943780; x=1740548580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNdgI6Lnk0EJfyZsrjALV4Wx1Cs5MjpDot82WJnw4AA=;
        b=era62A4Ab1Slyy34S5j5xp3IXm6U9HfrplWdvRNMfh/DrK9kOR0J8C1gYXDar53IF9
         UksnrWPWgoZKREVDOwBIhUO1r4i82EJgrsy3KcZEI+FJKNnNOW743ZcGGE3vL4TeJffx
         NAjgj5DR/rOBW4Daxkj3+ylZJi0r7b54bwZKeYpHUY5NTR6sqmV2xOuJ7EibC15KqCWW
         6PMy/7eMDQJWtGikv3FYKsuFUROtYneks3rnxYOAUNXfK6zM+pFBBftyozB2VzpdZZG7
         E3PxASYi4GGwnYW0r0ubW0boijCBbl19nifK8n+tzz8A9XR1DaRqC/NZuAucuRp4cLDg
         nqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943780; x=1740548580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNdgI6Lnk0EJfyZsrjALV4Wx1Cs5MjpDot82WJnw4AA=;
        b=iDyzV2zgvpHT5rt5HAyzsymG7OPS1sfLyb1OfQoT9cvOUh8QE8w/3K//JpxSyFFXeO
         xA5xpyAOAjHrAwYHezDb9cUwBDz11X6m9NwzWgzV5BE8O1DXV1AJO+CcDXcZtncYcRB0
         inCp6Zgx4VscWbrO3QRuhMORBE+Py04bmb/460cqDb+Zs9mw81y7mX1QHVagWjYrS+hn
         /cXWcR/9uJCsoUSWjY6jBB6jvKdeHgcEgecNgVFo+D8Qr1mhLnhPkK7F2DE6jzYkBuUx
         N1IDFlOLzk5Rn7cSaqxvIE9T+MVNvipMaDhT7uF/JZWm+A34WOkhx0I3dBvo0rJ4C14n
         5wNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6SoLmEgypN1bvzut8/xqttPmYCsTbM7WQBsAwB895ST015fOXJaFwpeBLNodSZiBj4RnE/eayqGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfyh9a7hRBHSUCHONQj7pL2MAIqirzYzHfzp+9uwrBt77sDSlP
	kMNEXO+N5N2ZU4I1EtEr7J/fR+PV1nNzGEj8joqGuy13GBMZF0PeP9QojfvdiKKc3JdGfmmDs1U
	Mzzei0kfNdCaZCj6lk+cG6w2MW8/vC43nMAP8
X-Gm-Gg: ASbGncvLtZMaf4dBh9WIVJ0qH1cDxfTrb8AjhoHUzVwzAHSXfk2QC8tSNcOsRfm4pjs
	3+mlNAPD4rvd0vq9LJiYRz+DNHkTdhW2aA5Jxw25uMwcLHnXPHBrNEvq0tqe3Tv+3VkxfxQ==
X-Google-Smtp-Source: AGHT+IG6BaIDHo3VQIs6Suwq6fAu96Q+gzv/vbHWUexAaIP3KqMbvipjPLrthuRXY44R6ugw8izf2++GtXUXgZdY3bE=
X-Received: by 2002:a17:907:1c84:b0:abb:cb01:f3b7 with SMTP id
 a640c23a62f3a-abbcb01f533mr293642966b.1.1739943779622; Tue, 18 Feb 2025
 21:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-8-pandoh@google.com>
 <38451a01-4e95-44ff-922b-8fda725eb25b@oracle.com>
In-Reply-To: <38451a01-4e95-44ff-922b-8fda725eb25b@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 18 Feb 2025 21:42:48 -0800
X-Gm-Features: AWEUYZlwhkSEgYsKtPttKQl_EQhYqGhLcMb5WP8BZSmlYii0EGpbkvUtWW5bEsA
Message-ID: <CAMC_AXU7L3dFw_w5v7usMUJ-144Tq0BSzkYW+efReuRLQXrCSg@mail.gmail.com>
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

On Mon, Feb 17, 2025 at 5:31=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> The convention is that sysfs files should provide one value per file. It
> won't be just people interacting with this interface, but scripts as
> well. Parsing such a string is a hassle. As we can only change the burst
> of the ratelimit, I'd simply emit pdev->aer_report->ratelimit.burst.

Realized that Jonathan said something similar in v1[1] (that I forgot
to fix). In addition to the reason you provided, he stated that
convention is to read/write the same thing to a sysfs file.

[1] https://lore.kernel.org/linux-pci/20250131143246.000037a2@huawei.com/

Thanks,
Jon

