Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2179232C100
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbhCCU65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:58:57 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37747 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579945AbhCCScs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 13:32:48 -0500
Received: by mail-oi1-f172.google.com with SMTP id l133so27042400oib.4;
        Wed, 03 Mar 2021 10:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZY0tUHu6hLONyVYVjIAaxzNB+f61DoThMHd4BdYBAI=;
        b=X4tZH0H9R4tFrX732HHJ1jT+HE0HuNtMCM82HsfepL9zUtmUfNMTORdKMK0LnzZsF2
         KKXHmEaQAZtIeOkj3IM/bBiWh+GDsN9L6rwsapm7vefGV8TE8gGxevzC5JWy4PV7Ct1B
         mVl4UEhAg1ewmt+UD3xl1VoXUZFaWuT97KxbPr/d8EzdeEKtEMcgTozPJGc5k+Dp2sVF
         YhrhfZfOFTFDekdRRyzuKONU6luGx25EkH/i3cTy/dgYw+nlhvwYp5IJsVqcfYaY2ysx
         699e7Jn0MpT37h3nWAcnFdpnsZVUak+ZExrolQvxvSamB0+mZZembflNVG4SfLG7TN99
         pkYg==
X-Gm-Message-State: AOAM530MOBpC5Tr0nYJEpt4slYC8dWQVpofgcZ4zuBzazr8Thar1yJG0
        VShPxsM8iuCcIxWVyRcHKVnSt9Fq3W/iryyrdPY=
X-Google-Smtp-Source: ABdhPJxRZiwCxfjQ6YQPd5xzCEoDWawYZdCETLZONsXJyxbwnui8GXBZ0orhSdLgwXeq7BWI6duGV59e1B4X/AirAD8=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr111298oia.157.1614796327952;
 Wed, 03 Mar 2021 10:32:07 -0800 (PST)
MIME-Version: 1.0
References: <4822757.tvZ08WQ2Gl@kreacher> <7de92ec8-3a15-6165-2384-15d301e7b568@huawei.com>
In-Reply-To: <7de92ec8-3a15-6165-2384-15d301e7b568@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Mar 2021 19:31:56 +0100
Message-ID: <CAJZ5v0iHN5Z2O141c-E4ehGJFSU=NhwK+6p_9==QJT2edj-LqQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: PCI: Unify printing of messages
To:     Hanjun Guo <guohanjun@huawei.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 20, 2021 at 10:25 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2021/2/20 2:14, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This series gets rid of ACPICA debugging from non-ACPICA code related to PCI
> > (patches [1-3/4]) and replaces direct printk() usage in pci_link.c with
> > pr_*() or acpi_handle_*().
> >
> > Please refer to the patch changelogs for details.
>
> Looks good to me,
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks!

Given the absence of any further comments I will be queuing up this
series for 5.13, thanks!
