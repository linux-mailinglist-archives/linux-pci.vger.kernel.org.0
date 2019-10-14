Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6ED5F3D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfJNJq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 05:46:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46129 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfJNJq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 05:46:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so15270929qkd.13
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2019 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lu3kAKNgLKj0l9OS9STf244o7FzKM+AFq67sW2GGwEA=;
        b=Uj1L73BBDeBKogOWy6V6kJudrhezS8moRSdpCrLY3eY9sVevqZAlfZAlmZMNsqrlct
         4XIovLTXE+6nSTwfashjKKTW2PVQ/K6PU9icsADDq339H5d7jT31VyzFjtJW2asPwsdy
         L0M1pcSU3zUIQdwuXVKawprh1KTIZUtoQ3cjK3vibIrgNXXCjY6G3ttf0De5NBBY/l/+
         zPX+pEWj3G8AeMRPKsUZgjzkpJoQt63L+nEAhoMwyIOucJftx3nzAQM2WdBUWdOGHzUk
         02Kki+LBpQ/Y4lBCVMqlH5sWxGCAMWbYXCuRwD3gng7oQwVM+7Wdj3gVhhP4tao3K1NB
         MfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu3kAKNgLKj0l9OS9STf244o7FzKM+AFq67sW2GGwEA=;
        b=Esx/Et06KZ3nxk8apOv32dT9K3uqM6HSGjPwGnEvb1fUfGsuOeJA9UGLoEArP2+eyP
         dUUkeb5M2jLIZ54hbEDRAvz2cTxkGiKMNLXAtGCIwRkYlzz4WyP+DhWuJpbAJKkyUlmp
         4EnyCVtWMlWwOmHB2ozZuypMmGvipXyRsUcs1ClZmHVHM781LUj9muiOOGoqCyiLDhZq
         fVZURXcbA+fJbER+hyK3G8Pa6ouKlVBSqYHTMKxOIXRSMTOihk+W5xlH1BT2Q8dvjZxP
         6pOq6POxobA9lvnGro8USgloKNlf7OYMa9KcLrWjHDFcyduJJH258e5h1NWN4MkzCf+m
         G6BQ==
X-Gm-Message-State: APjAAAURKLg5oJ0TM5v4vBTO+aXJ9Sxj9C/SMGyJz5H2V8cvM4HW33nQ
        SjHU+RIsKvtmYS+8qME1NGd+gjVkR1rvG5dpWQWp7g==
X-Google-Smtp-Source: APXvYqyX4BdAfaAii4xGwBuVXmFyQ/mTRTffh56bnScOrXrCBjFUMfh4PyZVxGpBJtJERVnMwTOvmNlFux+g2AOjz0g=
X-Received: by 2002:a37:883:: with SMTP id 125mr28347719qki.478.1571046415923;
 Mon, 14 Oct 2019 02:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <261805141.5tZyQaKU0z@kreacher>
 <CAD8Lp46NF8rq55g0Mz40Mmz1+KzqrTzziK3oYcmfh=1RUCRzug@mail.gmail.com> <4883845.KNzyzeMIEj@kreacher>
In-Reply-To: <4883845.KNzyzeMIEj@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 14 Oct 2019 17:46:44 +0800
Message-ID: <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
Subject: Re: [PATCH] PCI: also apply D3 delay when leaving D3cold
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 5:22 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> While I still think that both the system resume and runtime resume code paths
> should be as similar as reasonably possible, the above needs to be taken into
> account IMO, so it is better to retain pci_pm_default_resume_early(), but make
> it do a conditional "ACPI power state refresh" and then call
> pci_restore_standard_config().
>
> So something like the patch below (can you please test it too?).

This is also working fine, thanks for your help!
