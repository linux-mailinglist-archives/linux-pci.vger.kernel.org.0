Return-Path: <linux-pci+bounces-23027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB80A53FF8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56B616A0BB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29A1EB2A;
	Thu,  6 Mar 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaWwAb5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5F166F07
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224780; cv=none; b=Fu42v06UkjPkU/iXqxsVzn5BeogRUBpfvS6J9jSH8pC0Il2b30jPLAVM9YmIzCtiZzrmW/m7OCDwIRKkyf2vSriBgcgNQNrDo4SEjfH2arjynQL6UkGnb8+jHaDZOkH9c9bvGzwjz6lqvMJOe+VaFCZrI1pA0DC0bSz8khyU4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224780; c=relaxed/simple;
	bh=YJvHXGmiQvx+JWBl+Dezh7U3PMy6UL0QoXK+MN9wyTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke8IwD4OGhU/yeRd7DySOBdrJt2fkvNQEFY8BwUyPMGWHDhYHEEg5pBxtmaLUGwEvMAO8AD0gzbQpkXv3+EgFCX7D3PFMqTHutsEw/AXb4L3OJc4BqYE/QR6FxM6buJCCDIfmP1s5Islr+SDI3NRvQkd3k8ZHzfrOT0Afw8qja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaWwAb5v; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso25645266b.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 17:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741224777; x=1741829577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmWvMWYWKdumXajM+Z45aMfoxAc3EBmb9Y+K6V95U9E=;
        b=iaWwAb5vPZK6FXzyC4nmRaghqsceiAZaWtkYJSh3mTmUwvhQnHZmDTlFmmy0gpwKtE
         Wro7hxZ91DvIJeYFfvOPmwEvp7Qy50SuB/b9HxSubuhX+tizawb4bh32eTsF597SsBU9
         gLkotsqo8hFkmAYuC4Me/uC2QuMoyW+TOQZKv8H6Gy223JGdmFDsJxIyOefTljWt8YGl
         K9h/juFusHFWjVO+6xV+hIb8GZhpXtKUX0qIbS1ZFa/WHdY8aXIF9hYaqA568STKwfKv
         62kV5FlEbIi5Xsx1fxVoLiyrc0TYKePG5PJSfNRJM9y7REcS191mfDpQg2tDd+yfSQUF
         mdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741224777; x=1741829577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmWvMWYWKdumXajM+Z45aMfoxAc3EBmb9Y+K6V95U9E=;
        b=Ft6+zIU2rkE1F0zxt0o9KTrZxYa2CGs7r5Sfq38iie/O9RR4Nze09KjOKuaFkigYs7
         0QmYQUTgrx51V9XUBE8pYbCivhK09BuZAUEsdZwa9oDl7HK+z/2+2A2AXNMnKie4jwOe
         QzHrcd4HRP6Dj3KgIsdUBkeipQuwCfMkrXiNzGHFq+00ZdSKtIjGRzrInrXquCYIPgUa
         vdYH86L9qZ7pLUBszwvZHviiVHgBfxKSzLAEo3VKhda9fMRgIKYwspUoiQI6p0j7nA3Q
         VFyiKDY+2LNz2C9gukaViu3ACi9voWIXUgCdqTM8o9uz/ce+v96TWRGcC4Z0M6/OeBGh
         9UKA==
X-Forwarded-Encrypted: i=1; AJvYcCVFPzlMz8C+Ss67VRMZO2PCqfuyYu1AQp01BzuvynDcXqFUkw8Ln4SlFmwcNTYO3tvgJZCkA+QxIc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUCnvk+7URq2ZpMDXLs7qe6zD+OW+de0YfksUCKEYShI2iSZ+
	NvgrBaxiWyj00ZbOxePEC9JiVUUu59nN1htQ1NspCkylJzebV1GP6xZbhEAq2lEMx3JZxPTSwuR
	QKjNCc2AexT9vzx/NoriMZYDvS0Gxa4OmJ4GM
X-Gm-Gg: ASbGnctwKuCRGZh0Rqx7D/BH0B0j+34H+81br9qQGH7N6nopCpPFFTc+DEVlH9ghgbe
	CZ1iXT1oZenpfgzXcsCjQ/HkMnAzzQX/6+PTuswyUmP+eAtgqFGV49LIunCrlUIpkjQ8qwcy1wU
	6782B5u4Lg74jjlBWIEkHZew4=
X-Google-Smtp-Source: AGHT+IEv+1dii3jIB0txETIT/XCAfuGUe1VLZruhdK1TjFmlB2Eb70ayDHkhHNIlfdr2thOvaqNkozBKHGEEOXSChN0=
X-Received: by 2002:a17:907:7290:b0:abf:615d:58c2 with SMTP id
 a640c23a62f3a-ac20d92d6c5mr535389866b.34.1741224777155; Wed, 05 Mar 2025
 17:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMC_AXUqLYb=qr+EW0WeKq-NW7wQwNNi14Kc5k-6XmtXNiC18w@mail.gmail.com>
 <20250305223540.GA312467@bhelgaas>
In-Reply-To: <20250305223540.GA312467@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 5 Mar 2025 17:32:45 -0800
X-Gm-Features: AQ5f1JojB_NqxQX5YbPHO-N1UGPkKWwGGAxChREhMw0o_c6LSP7q6gq57NyJBTY
Message-ID: <CAMC_AXWVOtKh2r4kX6c7jtJwQaEE4KEQsH=uoB1OhczJ=8K2VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] PCI/AER: Remove aer_print_port_info
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:35=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> I guess the problem is that future patches rate limit the e1000e
> messages, and we really need to rate limit the pcieport message using
> the same e1000e ratelimit_state.  We do know the Requester ID of the
> device, so maybe we could look up that ratelimit_state?

Yeah, the intent behind the patch is to simplify the ratelimiting logic.
If I accessed the ratelimit via aer_err_info, then the ratelimit would need
to be doubled.

> On Tue, Mar 04, 2025 at 05:04:21PM -0800, Jon Pan-Doh wrote:
> > Would a log suffice in that case (i.e. when aer_get_device_error()
> > returns 0)? Something along the lines of "{device} is not accessible
> > while processing (un)correctable error"

What are your thoughts on this? It adds the pcie port log in the
edge case described (with no loss of info) and doesn't require
changes to current ratelimit logic. Something like this (with more
fields filled in of course):

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 21cdf590b25e..bdfc7e8d6f0f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1253,6 +1253,8 @@ static inline void
aer_process_err_devices(struct aer_err_info *e_info)
        for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
                if (aer_get_device_error_info(e_info->dev[i], e_info))
                        aer_print_error(e_info->dev[i], e_info);
+               else
+                       pci_error(e_info->dev[i], "{device} is not
accessible while processing (un)correctable error");
        }
        for (i =3D 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
                if (aer_get_device_error_info(e_info->dev[i], e_info))

Thanks,
Jon

