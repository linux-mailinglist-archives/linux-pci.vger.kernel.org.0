Return-Path: <linux-pci+bounces-43699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4DCDCA7B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC14A3018951
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2433FE01;
	Wed, 24 Dec 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQsIiP2q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99E23EA97
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589386; cv=none; b=ucuikugwFILvqsPc6bpKdf9RFfocNH6LOelXtucg/YFDUwk5F2d+BunGEhA5q7XtBTrM1tpY+hp7F3N+d5LV/T4fjzv57Sf+EZTA3GCktzEDe3W+safiZcpzixE9r0doix1rJKD5SfkNXQDeuBrCYDQSN5dRSROBU9FNlsUXskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589386; c=relaxed/simple;
	bh=V7+T7Mg6TvsxafSGD6PjpHZJqsgvf0DLcE2NmTVG+7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW37b2DMVjUKtnq7TY2bFgdv0NWi6c2QTE/VRSet8YU+TQQ6RiGOypeiwTp9BcSDOfltWgLQO2pXVVwpnxBZkWXVBnG6RYMB6f8jDyn3D7SPVPePX9HJ2RkeaZSiaIrkld/o8pRXUDFL2zPDTIlkeLtJpfc9uZHZ4GoNEX7Je8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQsIiP2q; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b9728a353so75076801fa.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766589381; x=1767194181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sido+HtNpq7ytQVkT1VKQmb4jxAV0sTI7ApUE+RUK2w=;
        b=bQsIiP2qQDdYUyXjgyYDr/dsKXZGONtW6BmKKMRZCz+R5hOgtLp+GqOWF7cbPdgosw
         mK8A3KBTMlTd/jKzHUfG/h8FYIksy5p4QpzaeY19UUX2Vg2QqrcM/3kVzPgzy0VqiLd8
         b8+eDNfp3IE2bjY2+slyv7tnAZ9pcaPe6durPGTvVkLXnsq+vv4EBHxlNdShDG+Pr12+
         8OwJRdjHDiSlBxQMveBb5UubB5EtyQVcpQOiTkJpsUzeka5JY7RueVOKdCB801YsiiaB
         /4p+JypbKiDoDq7dg5W3rx8xdOUq/AOvrX5pSd0xb6SxKdbYg9gr9IQcNwK8hhZiTK/y
         HqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766589381; x=1767194181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sido+HtNpq7ytQVkT1VKQmb4jxAV0sTI7ApUE+RUK2w=;
        b=ts1WEK9vUomuePdlEHq+CoornO3pCURl5MNXVsGlIPcBtZAo0UUxrRBqzss/txv7/H
         uv2dqOlDaOYnHlNaG2gl8G2deTN43twTNkcMoMhKxQ6jVc3Td7E78UirmbGOak/hsC4D
         WYzk3Y67flY6yCsI0M4YcnMl1TN2kFbINRJAbstueSmNNN4NG3DEpbbH1YUqfgTnnI7I
         nIyeHn3hZPnoCQthDUFS31yTFGoO7Yco6g6lGsiv4388m6eqf4oHhvfnTXWnRVRRuGf+
         YeVd85X+LbF/rWYHP1PVBRNxKCh6pvI9ClKzLB4YvEpbFmCe16fg/Hke8JdZgqCsH3xN
         vQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQr2YVqJuMvqbPMx7fmk4PVNbIDOQGPukjpLEPz87s6AMB1A7inhVkg+wKzvHRZKPaSn03sPQLM0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCd+UQvrVCPX92CBQgKheZvtRuZilT8Cul54jXx9lrTXKkWyde
	XIoCNi3QvDALYfEr0RRFIbs5T0u17huRlkNGEleYifnRxON5+3OIRsNterp6cUncV8oVNi+uxuA
	AkKN+eISoJnY9P5fXVOQ5vFTo30WJ8JUK+5wXo+Vocg==
X-Gm-Gg: AY/fxX64KpsWQobvFJ9PFiKlYRwe3dZk9eEFdebHIaTmMc+2bnl1D9YdL5Mj2Rrk3hN
	4QGjDY6vxPMRw071jhZFoEIuh+7YH1TySNkN1AnAcaBnAhfqI6hIiau2kgl+8Or4J5amAIKTGTI
	sGz23Q8hrUicyjBKYPo8FV/0aUsgthUyV8doijc/NgDKTPDgDx2IUcofowJX6tPy6GSe3kNoL8i
	0yIfKb63cnGp5MYJv5L6cOF3EkHeqjZnLMO8d/B8CP+Q2JSx33i0pRCLTNUhfWtykvymwB35R2N
	eya0oxM9mx/g7let0TSrwTCY6bba
X-Google-Smtp-Source: AGHT+IF8Jsu+cYeVQ67XrvoHUcltU9aS7vW3FN/4uc/6c9DvK9CgKmGbB9C+T7m+RPS35DUzHZVbC9yTnULoR83WqFY=
X-Received: by 2002:a2e:a905:0:b0:37e:566f:fc69 with SMTP id
 38308e7fff4ca-38121637290mr52651861fa.30.1766589381235; Wed, 24 Dec 2025
 07:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107143624.244978-1-marco.crivellari@suse.com>
In-Reply-To: <20251107143624.244978-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Dec 2025 16:16:10 +0100
X-Gm-Features: AQt7F2rWjiKNvgfxZOGh_G8cch1Yp6c3meXCFPqNfSziP5PNJM9z-kMMNai4di4
Message-ID: <CAAofZF7KSHXrwuYK_4q3rpYkx5+_ARuMoDWEYL4MHymSLqv=jA@mail.gmail.com>
Subject: Re: [PATCH] PCI: shpchp: add WQ_PERCPU to alloc_workqueue users
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:36=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> ---
>  drivers/pci/hotplug/shpchp_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpc=
hp_core.c
> index 0c341453afc6..56308515ecba 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -80,7 +80,8 @@ static int init_slots(struct controller *ctrl)
>                 slot->device =3D ctrl->slot_device_offset + i;
>                 slot->number =3D ctrl->first_slot + (ctrl->slot_num_inc *=
 i);
>
> -               slot->wq =3D alloc_workqueue("shpchp-%d", 0, 0, slot->num=
ber);
> +               slot->wq =3D alloc_workqueue("shpchp-%d", WQ_PERCPU, 0,
> +                                          slot->number);
>                 if (!slot->wq) {
>                         retval =3D -ENOMEM;
>                         goto error_slot;


Gentle ping.

Thanks!


--=20

Marco Crivellari

L3 Support Engineer

