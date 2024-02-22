Return-Path: <linux-pci+bounces-3891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C5860494
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 22:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574B11F22C67
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C56AF94;
	Thu, 22 Feb 2024 21:15:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06E7175C;
	Thu, 22 Feb 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636510; cv=none; b=nKstjg93St2+7Xsv2y7BSUpyfMITMSGQ9PbenLev1q7d8ZTq7BH3ms+KvmqV0sxxZukMbB4urMPwChZkph26nLogl/DHcY0ujnO+vfMhhtA6r0cE3URPTpREyLeWKRca6G8sWeOlou/lrW/Wi84F9DtmtbEFHP4EX5Ksl+NpWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636510; c=relaxed/simple;
	bh=+xIXD/2/oxIWEfrv3yIZldxrY3+fcQ19267trFYIMr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSxlO7yfhkXsCliFNGRf98wPSTrG0abs6KBl3l2L5izNFAx+i2Xewm23tfLGQ+tRkliKW6QNgPylIUaLCm81ZKI+NieRTeJog57diZy6wS9eEVbRjmMV2gVXzZXJJ/pv3tWTq2nKZaNlYIWSKq9lqxqdW5oeBmjM3g7nhajg+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a0333a9779so60416eaf.0;
        Thu, 22 Feb 2024 13:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708636507; x=1709241307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iwu0gmTsePp7o8N8/VmTdIjFEQ9vkLhfKTZRszY+BUE=;
        b=GttHAknGqTKvtkURUsZyruSxKVE5PoQlhPJPShnNjeeivOPmk4XxL8k2jcjToC7bQH
         mzL13sW1Ap9Lg69pQSymZ2ebVgvtI7Nq1H+8uVJD+VFc7lzropw269YHPoEljlnY1cw1
         j5xAFq0cHn6jU/nW6dvBOIaOBHb2PlFr7hmQXOlMCsY7Z8glV5+wCX2GG8loCHGSoy/T
         604D4Y/D6uJvW+Nj7FhL8MFJqqA93rI1CG3Vkmb/DqtEQY38PwHFlBi8Tyfy9WaMv+Ht
         TchpwTDQnTEOo9BZNPmJoSvqcW/3h9au8p0wxM5C5wyKV/IEEDCXVyT9EpjsDh730q8n
         QsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSByyRWh9lHV8oM5Od9bOc8b4g43UVeDnX0XuC/0sVR/c/WasVInPWXZWks2OFSVBlYxUzlEjkfNo8KmgtrB/dmaXGrRWY+h2HDCDYVzPi4ciMuLcZfvSJanVuilQWbpoA9XPJZpx5
X-Gm-Message-State: AOJu0YwsXMm0JLVqMUM4Z8RfC0Lqag/LqZB2h2eKkRlNjgr7ZzkGNyFG
	Y3Ic8iEqkoRvnNeut8S9UJcYXV4FpD0ncEjb4B1E1PAKchq/QYPUTN0SuRO57SG0suVrnzZSDFF
	zyjWDRpow9srSgFr+IA1QCZSXk1E=
X-Google-Smtp-Source: AGHT+IFBhFMeTig5AOkgadvukvOfwWjQ8r353Lb0HZrWECBBPfGC+Dj9rZuEDuEVrBus6h6V0upsu6tQaky4nxbghaA=
X-Received: by 2002:a4a:e757:0:b0:5a0:3c8a:4940 with SMTP id
 n23-20020a4ae757000000b005a03c8a4940mr162016oov.1.1708636507038; Thu, 22 Feb
 2024 13:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170863444851.1479840.10249410842428140526.stgit@dwillia2-xfh.jf.intel.com>
 <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170863445442.1479840.1818801787239831650.stgit@dwillia2-xfh.jf.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 22:14:55 +0100
Message-ID: <CAJZ5v0hmD+7iSKKexpUccvMUtjNpd9fHo3vRrshD_s=rb5Vq_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] sysfs: Fix crash on empty group attributes array
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Marc Herbert <marc.herbert@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-coco@lists.linux.dev, 
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:40=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> It turns out that arch/x86/events/intel/core.c makes use of "empty"
> attributes.
>
>         static struct attribute *empty_attrs;
>
>         __init int intel_pmu_init(void)
>         {
>                 struct attribute **extra_skl_attr =3D &empty_attrs;
>                 struct attribute **extra_attr =3D &empty_attrs;
>                 struct attribute **td_attr    =3D &empty_attrs;
>                 struct attribute **mem_attr   =3D &empty_attrs;
>                 struct attribute **tsx_attr   =3D &empty_attrs;
>                 ...
>
> That breaks the assumption __first_visible() that expects that if
> grp->attrs is set then grp->attrs[0] must also be set and results in
> backtraces like:
>
>     BUG: kernel NULL pointer dereference, address: 00rnel mode
>     #PF: error_code(0x0000) - not-present ] PREEMPT SMP NOPTI
>     CPU: 1 PID: 1 Comm: swapper/IP: 0010:exra_is_visible+0x14/0x20
>      ? exc_page_fault+0x68/0x190
>      internal_create_groups+0x42/0xa0
>      pmu_dev_alloc+0xc0/0xe0
>      perf_event_sysfs_init+0x580000000000 ]---
>     RIP: 0010:exra_is_visible+0x14/0
>
> Check for non-empty attributes array before calling is_visible().
>
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Closes: https://github.com/thesofproject/linux/pull/4799#issuecomment-195=
8537212
> Fixes: 70317fd24b41 ("sysfs: Introduce a mechanism to hide static attribu=
te_groups")

This is not in the mainline, so linux-next I suppose?

> Cc: Marc Herbert <marc.herbert@intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/sysfs/group.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index ccb275cdabcb..8c63ba3cfc47 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -33,10 +33,10 @@ static void remove_files(struct kernfs_node *parent,
>
>  static umode_t __first_visible(const struct attribute_group *grp, struct=
 kobject *kobj)
>  {
> -       if (grp->attrs && grp->is_visible)
> +       if (grp->attrs && grp->attrs[0] && grp->is_visible)
>                 return grp->is_visible(kobj, grp->attrs[0], 0);
>
> -       if (grp->bin_attrs && grp->is_bin_visible)
> +       if (grp->bin_attrs && grp->bin_attrs[0] && grp->is_bin_visible)
>                 return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
>
>         return 0;
>

