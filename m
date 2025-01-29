Return-Path: <linux-pci+bounces-20533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF6A21C87
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 12:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424DB3A62AD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF391DACB8;
	Wed, 29 Jan 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqpfxZQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E41DA0E0
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151609; cv=none; b=bv1kYHdM5VhoM9dF5bQAYYJ14i6hfQS0DL1SnoaVJszu6QjtUlsuxsLUU8ccgT7SJblfeKiQLIwf2eQnKSueCKMxz1VfcIUVzxBMAynxUIsHR5mR6RnvxSYnfm/Y9p87wwagstQLMgx4b1oKjXU00v9mebR+2y41iEzn2Ef0ZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151609; c=relaxed/simple;
	bh=XtDw2SqloVGWLdyoYXtBDSN/KgfOBaAkiZ9kK5rq1js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McJJSrjTe8DzfAfNO0vpyv2/54GCKmKMZ5sbM+AZXi/R9QKu6+RqtY+3fJwaFeqHWP6qSPKpkrc7Fnv+iOwZOSmM2IfsCknSUMWe/rCnh8lZygRS+/YPGjrio5a2vApMMQYUprFUx63U0IcdmUyntqaYmpVQ0RrTDQyXhF+adw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yqpfxZQh; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e460717039fso9371451276.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 03:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738151606; x=1738756406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zgXniuQQ9m2oAxcAeny2BUJWoO/7cSc1XmBp/yMJbeo=;
        b=yqpfxZQhIkPsZL2fee/TwSb8qoS1hGFofaQ0Kn2u7P/EiSCWDLJE/yElW3V82qv9sn
         GLonBHY5ZskyuV7N9ytJzlSvcYRucDjifN+rs9K4sX/zzUG9yLslBOxfGZrMA9z1cqZ+
         9urMoSXksoevQcLX4qnqkJQc4bPfHBg8R/sE3OsN0bQ6HKDDttKy/o/dSGZ3VZlmLi8Q
         6Cfa5IP7ITUjUefLGhSRQMf3uu2zgo4YQFvNh/2cM1AHsxPEjO2hPoJG8D3jeMPfqGnt
         nf5F1DRreQQUL0DVeg3ASO0KBGRjIVPslTYG7RhWkIs8rmSvh5VPUJyDAHPGhhKYIqWE
         vzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738151606; x=1738756406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgXniuQQ9m2oAxcAeny2BUJWoO/7cSc1XmBp/yMJbeo=;
        b=oeK9/C9M9d99q18kAwayQKGFYNpBSBN1tGyYPwASunwq4a4IBcjojevl26J0BDqm+t
         u0eeqDf31PEuWn+WNbIk5M7m1Oj+3rsSb2GkO1e60yX2OxbxyAD5+tX7RqcLF0LfFDG6
         p4VtG5605ud6Hm7pZSANliqr2fdGHjwRpcG/oUO047y9II8etmUerqMa7N/1IGq3toeh
         0kUsifkCvTl8H41vFyJ90WZKRlkHMZ284B4XNgZOVuKBIUFPujiMYZQrrmI6pPaTy/GT
         1S1mkqzVZBKs7c9lhK62ZzjAAwv+Rxx9jy0mAliaRMQxhDXX78pd0sC40RMgymosQ9vM
         3Qxw==
X-Forwarded-Encrypted: i=1; AJvYcCXapYGV+UrSbbgqxWc7ztsxoOXaiCZw3LgJSbBPKMNkmcEIVwWuODwt5bJ643E/OsSbpTkDDUzCLkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/Ed1lACIGHXlVn2DpifRVoNzSmUAHGqF6bn665xXb1A8KPVW
	kBtizfnLCdVCmlarGXLPtdwId0+as3qRVbgA+POC8WqfWZHWxiUS2suclosQklykjUZglrC7rqR
	aQ2rsXazTX8p465DerDYqWkrSGFB89sgnj6dYSQ==
X-Gm-Gg: ASbGnctKImm8ZHb1J+6kpsIDIdabeQm0mOMmZt4lF++tYJ/Zy1BXAsEB+PtBZFAQmiC
	65V4pQCMdSjnkIZ7H7Yu7s+ghUH9X4NUFHyIlCOiqsyVmrMaRZZLRMV9Sc/FvEieygk8kcqWERf
	rFFyYOVJtn
X-Google-Smtp-Source: AGHT+IFOHmbvgvshGtMkNv+jvcXgtH6+9miganRxYSomVNknKphc2UXbh7Vq6ykg+Azcv4Te5xpKA4aFJH7j/0NsslM=
X-Received: by 2002:a05:6902:2009:b0:e58:ac80:348b with SMTP id
 3f1490d57ef6-e58ac8035c2mr739345276.36.1738151606586; Wed, 29 Jan 2025
 03:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12619233.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 29 Jan 2025 12:52:50 +0100
X-Gm-Features: AWEUYZmwExy8dn5Px9QpzPP3otEZVwMtQLjO2zzVYB2DYID2YIuVPj5RX0qo4M8
Message-ID: <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> resume phase") overlooked the case in which the parent of a device with
> DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
> suspended before a transition into a system-wide sleep state.  In that
> case, if the child is resumed during the subsequent transition from
> that state into the working state, its runtime PM status will be set to
> RPM_ACTIVE, but the runtime PM status of the parent will not be updated
> accordingly, even though the parent will be resumed too, because of the
> dev_pm_skip_suspend() check in device_resume_noirq().
>
> Address this problem by tracking the need to set the runtime PM status
> to RPM_ACTIVE during system-wide resume transitions for devices with
> DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.
>
> Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
>  include/linux/pm.h        |    1 +
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -656,13 +656,15 @@
>          * so change its status accordingly.
>          *
>          * Otherwise, the device is going to be resumed, so set its PM-runtime
> -        * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
> -        * to avoid confusing drivers that don't use it.
> +        * status to "active" unless its power.set_active flag is clear, in
> +        * which case it is not necessary to update its PM-runtime status.
>          */
> -       if (skip_resume)
> +       if (skip_resume) {
>                 pm_runtime_set_suspended(dev);
> -       else if (dev_pm_skip_suspend(dev))
> +       } else if (dev->power.set_active) {
>                 pm_runtime_set_active(dev);
> +               dev->power.set_active = false;
> +       }
>
>         if (dev->pm_domain) {
>                 info = "noirq power domain ";
> @@ -1189,18 +1191,24 @@
>         return PMSG_ON;
>  }
>
> -static void dpm_superior_set_must_resume(struct device *dev)
> +static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
>  {
>         struct device_link *link;
>         int idx;
>
> -       if (dev->parent)
> +       if (dev->parent) {
>                 dev->parent->power.must_resume = true;
> +               if (set_active)
> +                       dev->parent->power.set_active = true;
> +       }
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
>                 link->supplier->power.must_resume = true;
> +               if (set_active)
> +                       link->supplier->power.set_active = true;

If I understand correctly, the suppliers are already handled when the
pm_runtime_set_active() is called for consumers, so the above should
not be needed.

That said, maybe we instead allow parent/child to work in the similar
way as for consumer/suppliers, when pm_runtime_set_active() is called
for the child. In other words, when pm_runtime_set_active() is called
for a child and the parent is runtime PM enabled, let's runtime resume
it too, as we do for suppliers. Would that work, you think?

> +       }
>
>         device_links_read_unlock(idx);
>  }
> @@ -1278,8 +1286,11 @@
>               dev->power.may_skip_resume))
>                 dev->power.must_resume = true;
>
> -       if (dev->power.must_resume)
> -               dpm_superior_set_must_resume(dev);
> +       if (dev->power.must_resume) {
> +               dev->power.set_active = dev->power.set_active ||
> +                       dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> +               dpm_superior_set_must_resume(dev, dev->power.set_active);
> +       }
>
>  Complete:
>         complete_all(&dev->power.completion);
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -683,6 +683,7 @@
>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>         bool                    async_in_progress:1;    /* Owned by the PM core */
>         bool                    must_resume:1;          /* Owned by the PM core */
> +       bool                    set_active:1;           /* Owned by the PM core */
>         bool                    may_skip_resume:1;      /* Set by subsystems */
>  #else
>         bool                    should_wakeup:1;
>
>
>

Kind regards
Uffe

