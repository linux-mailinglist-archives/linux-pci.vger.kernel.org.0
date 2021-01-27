Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9F30623C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbhA0RkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 12:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235779AbhA0RkO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 12:40:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F84D64DAB;
        Wed, 27 Jan 2021 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611769173;
        bh=naK3iTaopBlSB+sQcWb3URmlNKN/78T0DoXJKZT6zEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cGdFG5sSyV9I3ZPmUfho7hE7n57e7ubRHSm8sELpLpCf/aJO9pbDZectnjltiMw2X
         6GAN0MRdmACKKb0faIJTokL6+OyeTVYn6FCjGSp3+KVPfJwGFuvT8rGJGweqTvFF/H
         MBz9ZSFpC+Ne4+WJMMNK2npQ8nRgFAEXp14BgQYrpe2MdzoPwrcuoYDoY3pLyMgph0
         o0YymPPIzeugG2REcRs2YNXo0ODhb+s0eHgtAqfOYDm5OSGFHndvCuubHMQRsAHCd3
         48FxMSbkk1neoWkMnC9Len5pmZt2U3galFV42bjbw4n80hnkPibFh+EEeznxX0kmf5
         CHJVbLeAQF0ow==
Received: by mail-ed1-f50.google.com with SMTP id g1so3456195edu.4;
        Wed, 27 Jan 2021 09:39:33 -0800 (PST)
X-Gm-Message-State: AOAM530dX5XXXEk+gGp9nlhttUxEEO6TApyDGECef1z6rgMXAS5asQiS
        FMSCJvQQc6lIFqCQMSxJ9HH/iVVv5W9Qk8tjKA==
X-Google-Smtp-Source: ABdhPJyOJy/ISy9sUNIYM7qY9vaU0LtK21UimaHx8jwsbwiI3t8OAYVzzNo1v4d7u2nHG20WIynIxszuWWALF5HhZCc=
X-Received: by 2002:a05:6402:2c5:: with SMTP id b5mr10489518edx.258.1611769171718;
 Wed, 27 Jan 2021 09:39:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210106105019epcas5p377bdbff5cd9e14e5107ccbf2b87b5754@epcas5p3.samsung.com>
 <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
In-Reply-To: <1609930210-19227-1-git-send-email-shradha.t@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Jan 2021 11:39:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKuvD1s0u5uphmc3o4d7vsNui6hC2b9Q3woE-nshfJi0g@mail.gmail.com>
Message-ID: <CAL_JsqKuvD1s0u5uphmc3o4d7vsNui6hC2b9Q3woE-nshfJi0g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Add upper limit address for outbound iATU
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        sriram.dash@samsung.com, niyas.ahmed@samsung.com,
        p.rajanbabu@samsung.com, l.mehra@samsung.com, hari.tv@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 6, 2021 at 4:52 AM Shradha Todi <shradha.t@samsung.com> wrote:
>
> The size parameter is unsigned long type which can accept size > 4GB. In
> that case, the upper limit address must be programmed. Add support to
> program the upper limit address and set INCREASE_REGION_SIZE in case size >
> 4GB.
>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
> v1: https://lkml.org/lkml/2020/12/20/187
> v2:
>    Addressed Rob's review comment and added PCI version check condition to
>    avoid writing to reserved registers.
>
>  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
