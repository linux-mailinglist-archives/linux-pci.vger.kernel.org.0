Return-Path: <linux-pci+bounces-25027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EEA771E2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 02:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEF6166B96
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665E13AC1;
	Tue,  1 Apr 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNwkYcu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE63FC7
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467466; cv=none; b=cWBc9cz45K/LvLcLnIB85iFnZEbVf+L/IX0mIQVICpvXaxXhnmxz5XrjPaF5TuwwuMIGMa9ysIe36Z0mu7S4VJj80pKq+RG5Vdw1lykoPUixabDiNybqLv+Wd9TdL2bCL7jB+qtAzRSyARnWbjiiQaB1MWJndQVsyd9y97cBd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467466; c=relaxed/simple;
	bh=it4tebdH3W9XH7WVy7D6Mu3YzW+yUsu5LAh1yBR5RD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXuKYUgEGiFGtCsjJSmzPg+2YTCOA9a1TcRtwGAfx6yfL5YPdz7QIvRIhkqCJ50+h/8p10gMMZX3lKjJ9LRB0/HlJDvMXltZ8fOSb9vMdPotihoA0SAy3ZItljN6JB2HUF4o64bAVKfZlKp/0hHPuVUDUeuKDrm22ynhTAAO8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nNwkYcu7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso8191923a12.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743467462; x=1744072262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGMpLEB1pEXtxGrqIi72KnhFsnrxgYsT195Hwt3acg4=;
        b=nNwkYcu7J5IEHfaEuGQEaj3ypkGFWK99HxDncE9h0/B/wqmVIjoy6V4ZYXgWeD/I6Y
         g13DOgVUSdpcruG1nKrZgjrOZM84tL2mAeMrkNwPIqbQFrvAQWTD+29dLdqG/7XVbbBO
         ZIbtVNXduxSknuirddH4sY/4I0O+/dRVvcq2NgqTjLDqmZ1AhPpiPAdVtHY+1vXGSwCF
         CmcyYxNncfwgioHlfQmUQOUzbgFu+yA3CHBslKjhsdqVR+0CEAuQAh4bD0+VYC7r1kat
         1vKFOE8UF6dA3monEujtNGgTNoYjKYssI5v68AH7lAYb7yDcrlFIQzeAYAGNOLvi5egC
         dHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743467462; x=1744072262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGMpLEB1pEXtxGrqIi72KnhFsnrxgYsT195Hwt3acg4=;
        b=hoT5SY91/54uyK60FqrVr1dCAlBd2YusXl4AaC1HH+36w9YYRxRj72wcIDIUNll9f4
         zYP6IKaMZPaLFzXlx41KgtlWYILiqaCxenG2dSS3ddAwfpkpnOPdQWCQnGnyXpdVHUZe
         o64YF+kbr078eYB155TOS7XLWBvL3CxKUJNM8Eee4UDmgHFQVjaVn8n9+ZsJSdMdK+tq
         J6WBgwDTWqE5YyX3pBgQo7RIxVogD/QmoNPoHZmvKEvI1Uk9OqFH/jFRezMllnH9EmSE
         xsUme+GZvd+u5WwjDGoL9SfIx/DV1fKUGume/vwte8lo9UBNQjLYyUGKid4qt9fZ8c4a
         BpXA==
X-Forwarded-Encrypted: i=1; AJvYcCW5+pt1OxU0UVtJhbbP9UZFJEkS0hg0k2+RW0t6FcxVRAFsK5f8ILrDFwVGh0jxfvqeDHjS1o1nUcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2ZTOoN3QkTJd/mHFHpL7Eo193MC93LGkZ6CSidkMTnFY1+ww
	YDYAvbtXZLFSXlxUjGffJffGGYSGYGm0/favzmHtTu0jnwfJzvJR0wP/UhI/lXQAa0OvsL46WOf
	alSHjVuuRWxWVwWwmNhaNWV2jahCxGSUVrMSO
X-Gm-Gg: ASbGncuvkjIdf8amSPS4vNquLzae5Cfm/0K61gjK7DIVc82sBI20SSj3/1hfQ/ZmJIs
	EnEZ+459sPd50FD1cXUykr0W/5hkAcLu+COmocBFFX5rKu6hV/zbd1J7VhwABLJpwZ3UDx2jJ75
	UO93EttvrqbEX3ZQc9Y4NPU02Vj3CELenl6TFQhSiTzN4yqDAbT0m+2u9p
X-Google-Smtp-Source: AGHT+IFPtJIgg0kL+Syg/D82M+Qc4M8ch0rFdghgEF/VsCrqqQ771huQds7l3v+d/21qogBGxHAA+wuqMB+avCNI7I8=
X-Received: by 2002:a05:6402:5211:b0:5e5:edf8:88f2 with SMTP id
 4fb4d7f45d1cf-5edfd9f7949mr8562707a12.23.1743467461778; Mon, 31 Mar 2025
 17:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321015806.954866-7-pandoh@google.com> <20250331184840.GA1170881@bhelgaas>
In-Reply-To: <20250331184840.GA1170881@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Mon, 31 Mar 2025 17:30:50 -0700
X-Gm-Features: AQ5f1Jow71aUrsU_7gsw-hpVm5_4MhfHoYOKsb7kzNr2ifo0tHU1Sq8GwMtpciY
Message-ID: <CAMC_AXUDqeJbT3gh48JRL7OiutVqQyf0go_cGcR_xsTfqw+Qsw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] PCI/AER: Introduce ratelimit for error logs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:48=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> I found the __ratelimit() return values a little confusing (1 =3D=3D prin=
t
> the message, 0 =3D=3D don't print), so this is appealing because it's les=
s
> confusing by itself.
>
> But I think we should name this "aer_ratelimit()" and return the
> result of __ratelimit() without inverting it so it works the same way
> as __ratelimit() and similar wrappers like ata_ratelimit(),
> net_ratelimit(), drbd_ratelimit().

Ack. Caught between readability and consistency :).

> On Thu, Mar 20, 2025 at 06:58:04PM -0700, Jon Pan-Doh wrote:
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -533,6 +533,7 @@ static inline bool pci_dev_test_and_set_removed(str=
uct pci_dev *dev)
> >
> >  struct aer_err_info {
> >       struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
> > +     bool ratelimited[AER_MAX_MULTI_ERR_DEVICES];

s/ratelimited/ratelimit here as well? Should it store aer_ratelimit()
or !aer_ratelimit()?

Thanks,
Jon

