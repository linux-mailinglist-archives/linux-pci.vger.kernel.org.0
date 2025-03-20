Return-Path: <linux-pci+bounces-24254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25713A6AE9D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DEB463E77
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C78226D1B;
	Thu, 20 Mar 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAIuBQRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC431E47B3
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499425; cv=none; b=U+GelIp2aMDM20RowLgoUitEoH2dhA4SHCUE6oCzt5RC0nq2sN+ydz22owjBYkjnKAaLz5q+PvAnhrn958eITdMiyFjnVTQXWFAWSx2qo4Px6nEyzxjA2OwQaeJoMhLqAITPCERn/CGgYCr/7ZCICy2VVC7mybALj7yAR6whWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499425; c=relaxed/simple;
	bh=T79ARQW5/glxzqdRjKlzzkCqt9422G4W37RZmBPiCnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THjxwKYUkgY1Hlg/dFZR3Ad8l6hvPHfQyZfVdtHlwAQRqNRgGTMZxPDaiSjB8s20JsctE9xyD9GI94yc/0EORUH5NInsqCyNfRey/WlufLK7zoy/qD/YBPcBoARcmyZuSmctN8If7X4OTcRmzjW/XtkTrbRA+/74iGsKfwwpYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAIuBQRV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1979005a12.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742499422; x=1743104222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7pimKdwXr8uIbZyKnfwc1wPKZSFIyl9WvOsMZ7Ayig=;
        b=oAIuBQRV338LkzkrBiMAihuzCy2yb8BhPxKfS5AKzZ+a4aNJKr2/HoTio1OsLrY1Jf
         lj8VmeVpvy/ph6Zie4Pfp/U2CMDocZf6QLBXZngJWOyIxroQNqcCtSl0zPEtzjqmN1MJ
         sZuPTEVCk2Fq+yfWUHBRcpN3KohrEAR46KK/6zhe1Sykrhmj8OrxmnGCWIhlL2GWhIqD
         GHmTvoP47/kLMktuCiPx1nOfiGaIw44K5kOdg7VFcT3wBaGuwJYBmdame2xSedwI9nUZ
         62DrcOPbUwa8Ici5DobDKDDHRlWJaShfk87zJDndOf0lbt5GvIaz7qj9uUsKkKHAokW8
         Eh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499422; x=1743104222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7pimKdwXr8uIbZyKnfwc1wPKZSFIyl9WvOsMZ7Ayig=;
        b=u711DnOmVnO6RvIXvJxtpuldx7QIAJW35DUWOhLD1HNWCwtG1L0ZMmr1W6gCp+C8N4
         AJ822oarbSeN7HBdB4kAHH1tfmxRX731+LFaI+DSC0a11Nc65k18BwI+RSXGPjO+QVI0
         Vw25uvf4TzEci17A0TSQOg0JTnCT34JLBgwT9APVkExUd7l795SYFZl4CE9sUWCt0oNS
         GkAo16gHcXGxqWgPn0+PabmL9cV4NlPsAzWwzfS3HuBacp+eMwpZOagJVVWr61sySjBZ
         UOr+zBvfiflGgiv6kzkydWEQfUp49TwcBYQ2Ho5TwUJ7NWdwiCGzUz2diygB3KR4NlML
         iv8Q==
X-Gm-Message-State: AOJu0YzptUj66U7AcEkyWb1EN7jfZCV+lPV/8EkA6V/7ZLCWXtNvFJld
	u6a4v11uP9Z3ZSdEqv7mWR9y3nrejp2xhrRzgR8yYFyaRWO3jaT21b6NAuECshxlC8ugfOS1h51
	raW5fUJfMEO/wnxlB1XDIipXzLaKNs5ZJBPz8
X-Gm-Gg: ASbGncvty0zEFtHlbI0ND41ZcQP3vh85PTREgAGzYGLN2SCLsQNL+/IAi+LkzoeDHTj
	q6OxJB03mroZVRerqbwBituWmhJhqoN9x8yYuPGp6su8msMJjHYiu4gsW4v9nxumv5O3B7xw2J4
	vFb3AWHaxwFi0LIupwitJYvDAQ4cszXL0y9As2lUTa2OlbnlRMBhkBx0IL
X-Google-Smtp-Source: AGHT+IEJ21HSBemblJkPkrx+N26cq1f8W7KDg7GGoXALGJdRpXHW7Oa+f5GBxyBM5ZHKqh6NQUnHx9W5YqgGV2ovAqA=
X-Received: by 2002:a05:6402:84f:b0:5e5:bdfe:6c00 with SMTP id
 4fb4d7f45d1cf-5ebcd467281mr438361a12.19.1742499422191; Thu, 20 Mar 2025
 12:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-8-pandoh@google.com>
 <d75a96f1-5162-4ec4-971b-9ebd4cfa5447@oracle.com>
In-Reply-To: <d75a96f1-5162-4ec4-971b-9ebd4cfa5447@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 12:36:51 -0700
X-Gm-Features: AQ5f1JrjSzYStb9fdtUzcHUb4GzVurrds-LMEvIMi1wkuwxFKW1IHwjxH0-vVqo
Message-ID: <CAMC_AXU1OZwiPZycWmaxxyUQnNTzbhmF1pf2Kx0Sk8MOb57XVQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] PCI/AER: Add sysfs attributes for log ratelimits
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:58=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
>
> On 20/03/2025 09:20, Jon Pan-Doh wrote:
> > +What:                /sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs=
_cor_log
>
> I think this attribute name (and the uncor counterpart) is too wordy. A
> user can check what this knob controls by looking up this file or AER
> docs, so I'd name it to "ratelimit_burst_cor_log" or something along
> these lines.

Will change in v5.

> > +/*
> > + * Ratelimit enable toggle uses interval value of
> > + * 0: disabled
> > + * DEFAULT_RATELIMIT_INTERVAL: enabled
>
> We set that internally, but to the user we are just operating on 0s and
> 1s. I would connect this comment with what we have in the documentation.

Will reword in v5

> > +     pdev->aer_report->cor_log_ratelimit.interval =3D interval;
> > +     pdev->aer_report->uncor_log_ratelimit.interval =3D interval;
> > +     return count;
>
> Nit, suggestion: add a blank line before return (this applies to all
> returns in the patch)

Ack.

Thanks,
Jon

