Return-Path: <linux-pci+bounces-24895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DCA7412A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 23:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973233B7602
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F31B6D08;
	Thu, 27 Mar 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lh7tbnCV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC0188734
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115814; cv=none; b=N1Se/SBcaTeCDoa8oyIHRIt3LJ2oeube9Ejqy/5ZiawqOMfTF3Y8VcFvodaamfUY8RVragFJzNO0Pxush7Kn9yzPMSdKIAODrHyYtuOcWaBqSN+mMS7WSlYVoM8am5jiJTx8xoUImYrYO75HQ9qJUuQ8yrbMlVUDsJUmiYi5JSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115814; c=relaxed/simple;
	bh=1xnvHALLzW/dRpLr9+8qGYDuMjuhigictiBWxjcapSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAwkqECq8sp1YbF3bzwS6PDHc3/kLsFOnKChZdNjTGhkbXKGiRTB7g704MFon1/AhDW+fBF7gLUOvmniDhCiHU07qhLD0rMnbSxYcyaT79fLAR4nCLFOLxnaxlR1Qc231hDDstkOmvpEzCrgI0ODocsoMP5eKaQJJ5eI/kktw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lh7tbnCV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso4719730a12.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743115811; x=1743720611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioYJPNAmH8HlNTApVc1wpgStn9YIFgSRnrVT9GOs8gg=;
        b=Lh7tbnCVWhBYrFkl4B0FE4H8IeTxnYOs+Vdb0banX6qo8avsPls5mKa1k/IG3RcTvf
         c84zK8gV3MmKq5503Nzk2dFSdR53ocESySCFrUeD2exX37onfHWNYGQ3uYngkn5Y4N6E
         ZEeTVU/o92Sw45NAvY0n+C8sVaP/9PRuRFdaQ8rOJePeHQAALNQBUFMiW2jpTQSaL9RG
         Fnv/xY+bD8tj+/xNLMEZAS+xiiBwynqT/tiKwLtVaXTPrgD3hdcVj80xY1hhaP06KmFb
         Wwmtw20mJ//hxke110GEpxGBGRAVsso5wi1w2H/9lh9+/SyUWcFH4Qiuv6SG5dcV02f6
         IYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115811; x=1743720611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioYJPNAmH8HlNTApVc1wpgStn9YIFgSRnrVT9GOs8gg=;
        b=IHyElKqxvpGQuxS0vfR/CE4+IFtVWvGz/I86hoB5TTnpPQ2kBlGEj+8oQm1cuR4JLa
         RN/+FhMdwBLc5qijp1+FX8YzZL2BC/99kvFK97ypkUFjU/+1OMRr4o1ir7TjPHHaq5aj
         rAPPFHJRZzxNX6hWNuD/TUxjaVNg0nFvmfoZaryfsgWyvMEGo43mdL2g4j1khTVBKGCh
         nV068lf+uXBv57Lfr/bMcLvGGN93qA/bbm01ujrvQYp5PGE51zi473dbSQvZMVXvZEcz
         GR403t1AkV7Sn3vKcTxa8+2MHtX1334AL8bWXvw0fY2KSDj7u4ap/mxrfwoat9sT6d7I
         bR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk/oleG65u3ldnFu5LkR6Y81n9zMrBAv5cdV4LfUXtNrl+id/cvw65ajpMC5dEeUk9x+bIq3N1M+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiVMnDPOLMSgMNEvzO72g0GhoSgjw+kkTC4GmSZZYCKWhZqsK
	Esl716NurcwyCFOgGKpEmwu4rVIXivOza5aVPSzZ8fxJHdPFxLXAtRejCd81ECV8/NHh8j0Jurp
	xLRxUco5hkgrvMfOHldNNWWLGENOu4mbaYAuC/vptGbSGHo6Bz+Hf
X-Gm-Gg: ASbGncvCUaDy0BmrJE2hzelMEHrykd8oytsOz7/M3TeKlFVCnvolRjGDJgb+cLqWed4
	/1OwZfGisJ9pHducSLIeHA1TDmATW9A3fMpbuS3dfSLyUu5VCMNvXxpL8pRQo0E2pxtS3W40bqB
	ELBAV+QbonsvFERQXARtoXgGSc6JczloDofeyTv78s/SIbKl9zK28q+EmP
X-Google-Smtp-Source: AGHT+IEewdUn5p13FbAdqn/6Z8cCjCm687hu1jIxvPO6zX/JE338mXATYFaOfqcenxUeqzMuErnhscv9Edop+YfAecg=
X-Received: by 2002:a05:6402:1ed3:b0:5e6:14ab:ab6a with SMTP id
 4fb4d7f45d1cf-5edc4c07346mr421969a12.7.1743115811041; Thu, 27 Mar 2025
 15:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com> <20250321015806.954866-9-pandoh@google.com>
 <20250323122059.GF1902347@rocinante>
In-Reply-To: <20250323122059.GF1902347@rocinante>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 27 Mar 2025 15:50:00 -0700
X-Gm-Features: AQ5f1JpUiQmIrLFoFjrOaBJXy0FF7GhXKqc0jpfxuDBFg_BRN8RujL4K5dFFbG0
Message-ID: <CAMC_AXWd_3jY-Yb3bOs7EvTtRzGrjzV0DYAr3YMWKmhNs0M=pw@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] PCI/AER: Add sysfs attributes for log ratelimits
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
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

On Sun, Mar 23, 2025 at 5:21=E2=80=AFAM Krzysztof Wilczy=C5=84ski <kw@linux=
.com> wrote:
> That sad, I am not sure if we really  need to explain here how this
> particular store() function works.

Will remove in v6 since it made sense to others w/o comment.

> > +static ssize_t ratelimit_log_enable_show(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      char *buf)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +     bool enable =3D pdev->aer_report->cor_log_ratelimit.interval !=3D=
 0;
> > +
> > +     return sysfs_emit(buf, "%d\n", enable);
> > +}
>
> Perhaps "status" or "enabled" for the variable name above.

s/enable/enabled in v6.

> > +static ssize_t ratelimit_log_enable_store(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       const char *buf, size_t count)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +     bool enable;
> > +     int interval;
>
> I would love if we could add the following here:
>
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
> To ensure that only privileged user also sporting a proper set capabiliti=
es
> can modify this attribute.
> [...]
> > +     static ssize_t                                                  \
> > +     name##_store(struct device *dev, struct device_attribute *attr, \
> > +                  const char *buf, size_t count)                     \
> > +{                                                                    \
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);                        =
 \
> > +     int burst;                                                      \
>
> Same as earlier comment.  Add the following:
>
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;

Will add in v6.

Thanks,
Jon

