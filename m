Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5743D6E77
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 07:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfJOFK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 01:10:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37806 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJOFK4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 01:10:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id n17so9421897qtr.4
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2019 22:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dChf/x5s1DseSM03Kd0rBda9MTuM8UvOTK3yPnAuTk=;
        b=vpcxzkJInTYYTNcBMnSERYa46NajSWpvFdC59LQdNTooIVhXTh7qftBI9WpOwP5jOr
         +gC1uITascMS89FnA0M4P8oojnafg8gvu1Y4JvDLn8xsaO9JkLRHEc4V7T/ETfZ9+DXy
         lA5U2OXDGWKu614JrU/eO3+OSWyhwzKaQ9kSQ1UFsKd8JX/0zrZJXYeAY6fSRlMIUqoI
         1FX+3gUhOBSZKuHtD1q1zGl7GbuJERh+omu2PTYZgcCWvptuEfA3bzx4wCHF18m6qG9u
         6I4n5UrJVlr+Erp7xM7xKjeTjq0n4nCmiaN7qUyanqYUAxAzzSnoCaVPpBVauJHNtCxj
         T61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dChf/x5s1DseSM03Kd0rBda9MTuM8UvOTK3yPnAuTk=;
        b=C7G04hPZTHcu15Uj+q29/9Hbuh0SqrawbixpHHyBXszQcjBaG3NjjFWhUZXOyN1nwz
         SZr2HQnXC6kTh8N3nl1gMf3JiX7BypdbRh6yOaKvr8Xw62GaJ4gGUq3Ch+9C+KrBLOUL
         lJ7zcMInWjk6ZrtuJAtmZcCjaLmHhHmQdLrX2FrSWpk5EmaBMx1NfYKGzHb1JsbEDUZZ
         tHs24dKkh1QYSAcDZcxweXtF0NJww8bQfGueSwolul93ysH6xjV6xdYPgPPK5aewu4I0
         EmUoiCRcU5qv9Mj6+jdntR8WtNz6gkYxklvg7ojf+a/UziQkoEISQKvOA+22hM3IrxjI
         v4Wg==
X-Gm-Message-State: APjAAAUDpIq5ZGemL/mvk271JwKaJzwcHOmI1/bf2gRRsv3ebXi3i7gV
        F0uzUvIGrPyqo/HBpuhP/d+qqEVJxP+b69rQrkxesQ==
X-Google-Smtp-Source: APXvYqy4g6NAupYLZe3cJqQPtl4z1+OKDrP3eSTx8LtKVS3LsxInbV9XUFzeN+VzoMb7cdtLLoGGrSDxq8+zqWSj/xM=
X-Received: by 2002:ac8:32ab:: with SMTP id z40mr8448770qta.391.1571116255461;
 Mon, 14 Oct 2019 22:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
 <3118349.722IRLjr4b@kreacher> <5720276.eiOaOx1Qyb@kreacher>
In-Reply-To: <5720276.eiOaOx1Qyb@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 15 Oct 2019 13:10:44 +0800
Message-ID: <CAD8Lp45rKeLs5xSvS9ffs+G0D5iLMn5-MWypqCKWCn0jGdfGHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Fix pci_power_up()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 14, 2019 at 7:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Since there is no reason for that difference to exist, modify
> pci_power_up() to follow pci_set_power_state() more closely and
> invoke __pci_start_power_transition() from there to call the
> platform firmware to power up the device (in case that's necessary).
>
> Fixes: db288c9c5f9d ("PCI / PM: restore the original behavior of pci_set_power_state()")
> Reported-by: Daniel Drake <drake@endlessm.com>
> Link: https://lore.kernel.org/linux-pm/CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com/T/#m21be74af263c6a34f36e0fc5c77c5449d9406925
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Daniel, please test this one.

This one is working too, thanks

Daniel
