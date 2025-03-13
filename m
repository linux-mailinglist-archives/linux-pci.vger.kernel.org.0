Return-Path: <linux-pci+bounces-23687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704D2A6034A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 22:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E3C420030
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 21:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDF747F;
	Thu, 13 Mar 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dh8EwjX0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B881EA7C9
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900560; cv=none; b=R897VEyP3eniVMdu/i1v3EG646NQ3/uZRD0sUxdJFl50hh3KxiyLGl/dRddNdbkxC+kaWahkD9FA1xZbbD/UB1RnDO2IAvKS0GPQoKJWjkBfu0pKeyTMNXxMY/dW37EeHTPqS0UY0wwRJv3VcymmjFUCz2+VcbKoCDS6mhwcD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900560; c=relaxed/simple;
	bh=SBslDw2A231XAPt4VPjHt73apowKjdYrM7+5TgOSj5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTse4DX1mCwrNzRIcF4GuFXSM5InmokJyluoD1H6WgnDU0fhgUKSc+xAKzbkQ0PDYQRdNVszuXAVVsXeH8ZrLgXVXi9OfJn/SUxaxfcdI71H5FtL99BLN8XL0gmrsfeDV38nd7J1x4qVCDpujR0C5czOTel7gGwGR2NO1KYoXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dh8EwjX0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so2400900a12.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741900557; x=1742505357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBslDw2A231XAPt4VPjHt73apowKjdYrM7+5TgOSj5Y=;
        b=Dh8EwjX0s/uWaZgt3HTUquLCqm1Yl258y77zVfTWQdtVcycRVjt8LYTUNmuiyLFl5E
         1kaea6zIR1MgNmFD9zyVS8AtVKtRQaPsvagbIvRJu4e5Q39fQgvO6I04khqxRQbTulSY
         Ia576V3JXdifrVhWfDaQPlIwtrTJP3QjDYrTnP1EgdFgqXjcvUVkuAlSfjXz8h3+lQwA
         gbazShPesiAdfMmBeqZKloU1C1bkNW49tGouSokhEaASNu2DduVUN88+NMkayJPELtMu
         SHKTDmaMl8bI5wMPOgmJiAcB4M5ZhPhx+HxW3m10Zt13Db6x0lRDMAJRuGs4tdeOQ1Wp
         t2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900557; x=1742505357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBslDw2A231XAPt4VPjHt73apowKjdYrM7+5TgOSj5Y=;
        b=kSoK8d4dRTj3WYUc57vA4bFrbURFQ9D8mmcKYAE4ECvuAXvzeChiLYgOuxkug1zxBw
         NOJrlE6or3l1BAaieLqFGYt/AF/kwjTVHdFgIPN4PleoZRlnHPV+VtKpKnWX34KXQGM9
         Gr5JPYVULALShoIG56QcOY5mCvVIenfMSqsPh7u52Yr7Mh0hYLhH+7OXSavxGfjyqnsT
         9kVELzuCXGUU6s+ijlpjDuRaHdcVKmD4MRLOBPwBE8+BvRcz7LXAh+StcfGqCzEJLeqd
         n1PWx5b++TT2iHnxWSSupbekn7hPpq2IqOez4jV2iDJsa0iO+uHetYUJdbIiWcLuXR9l
         Tscw==
X-Forwarded-Encrypted: i=1; AJvYcCXvtzPp+NvYMdxXKdK5yxqHsybsy9ygn4+VxNvYliC3vVDqScGWk1bCu0x1/8ajCQb2U1JbXwrdqtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdI0T/YsrUkjR1h6SDNu7OBn6EgGTtbU1qIKy0P3r+YSY1g7DL
	DRTdvQ2PAdZJiHgP9fbx2Ezx2HNbvcJ0AjL1+QgTICDAOhB5X5w5REsSEU9hiI+qUhCsbKmMxvg
	a1AlLdasJdzjHnweZn4BBPuAWGJJ8y8XyEDx2
X-Gm-Gg: ASbGncvGJXkk93b7azeZZ6SNF+6Rjy+zV+81EDBjTH6eobGYDtv7mYxYldjLtMS/MoI
	NJ+1rX6oAm0Ch8dtG5Uz6D/Cu6tyKht6rIu27I4tpyQggJx/ALP3RUmdljm5yusviDAhDVHd1SF
	/BzL0hIfc+HqZqARvgSOoTWLrDrVPWynUysFUk8o42iubiBpDhptylIQ==
X-Google-Smtp-Source: AGHT+IHn8NCuuRX2zTxm/+imEM8zldHiY1ajopitgMfhaTXg9XEBojIA+ZKmdLrJkF/e3AhdyVeXyYlLG0ko7OiJYP4=
X-Received: by 2002:a05:6402:34d6:b0:5e7:c438:83ec with SMTP id
 4fb4d7f45d1cf-5e89e6acec2mr185799a12.6.1741900557043; Thu, 13 Mar 2025
 14:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304185910.GA251792@bhelgaas> <55988cb7-dfa8-47bd-a5e2-c96cd84d4159@oracle.com>
In-Reply-To: <55988cb7-dfa8-47bd-a5e2-c96cd84d4159@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 13 Mar 2025 14:15:45 -0700
X-Gm-Features: AQ5f1JrfFSgNrt1g09eVfb5cUWIXrgpXHeRJHbny5Eh7eZP2sYEH7fUOylZqoU4
Message-ID: <CAMC_AXUq937EPT_TkDs5gqHfC1xiVJAUBBp7Z2faVJ6VsseexA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:05=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> As for other changes, I agree, we can split it up. Jon, would you like
> to do it in v3?

Yeah. I can do this in v3.

Thanks,
Jon

