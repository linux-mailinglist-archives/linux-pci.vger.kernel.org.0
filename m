Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45629299450
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788535AbgJZRwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 13:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788534AbgJZRwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 13:52:00 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D949222D9;
        Mon, 26 Oct 2020 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603734720;
        bh=80BQL1whzvkrrvfpvr5c9iWfuQJ7SPY/qpkWqr72d4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NLbQM6Mqz1PSs9AvSN1k+nXpoClbj2cBtcL8SesBzun21n05XcN/gUueWCxORCqR/
         mxHDdOoHMb7TzMXwCV33QguMXq3Rmr/8tCc+lj6wgH7iwf6mOeYefn69nrpRreb2YV
         1BJ7zEr2s6i0X8297EqKfMOFfJs8ZMVgO8GnNjmc=
Received: by mail-oi1-f181.google.com with SMTP id s21so11369537oij.0;
        Mon, 26 Oct 2020 10:52:00 -0700 (PDT)
X-Gm-Message-State: AOAM530vEI40TQcIYkDQWNoyLIAzSl32U9jgvJoYMg+kZakJhyhJG1RK
        IU+DTfFk8T7iscJSWHnJENrmUY9Qqto6JgXUKA==
X-Google-Smtp-Source: ABdhPJy3fa3VH1AFrLlXSkjQsjnSvt0DnUWFwTQdMydKgPfnfDV6BNWJdHkbBCnI7J9vvLbvd0wA8gscR6ss9EfFgDk=
X-Received: by 2002:a54:4588:: with SMTP id z8mr15075825oib.147.1603734719848;
 Mon, 26 Oct 2020 10:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201023195655.11242-1-vidyas@nvidia.com> <20201023195655.11242-2-vidyas@nvidia.com>
In-Reply-To: <20201023195655.11242-2-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Oct 2020 12:51:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJWZNLeAYyr_b3YYD2dQQDMPq5c3vT1HM2ddDTR1N3Ztw@mail.gmail.com>
Message-ID: <CAL_JsqJWZNLeAYyr_b3YYD2dQQDMPq5c3vT1HM2ddDTR1N3Ztw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: of: Warn if non-prefetchable memory aperture
 size is > 32-bit
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 2:57 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> As per PCIe spec r5.0, sec 7.5.1.3.8 only 32-bit BAR registers are defined
> for non-prefetchable memory and hence a warning should be reported when
> the size of them go beyond 32-bits.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/of.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
