Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE932D136D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgLGOTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgLGOTU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:19:20 -0500
X-Gm-Message-State: AOAM532e5Y6b2iQ6kBDjl11eLsmVzu3bZvrJcCOA4vOyt9tUbqNTUHad
        umTReymNClnZuipK70v90+NnsqEQw/z12/MJSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607350719;
        bh=gTcXCqe9yeMZ7fk8VbczfWXHPVBJu/7UXTRjQLLfZ+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rRROwRlucuDdEDVIT3M7ZDymxB0qhxanMq7E7caQm4v0JqqI1/SMK1P5v4Tm5NFhZ
         nBYGGfNv7yGgIXiX3aAYZhSc3J7p7HRvu+lsBZ+qu+wqhuKZLuz5BsssKw2X8fdWG8
         lpdM9MSCroxERHoa2ohkYmByxDMpGf8av7d8AM1iCy73RDyvNXW2OLbRIUm7FhisbI
         emjYf7XFzDqswd+guteTaumHglDgixMUE6+DQP2tIj9msYUkSSV4nrhRBKWYJn5fhG
         Vu64H+rZBzWC9ajIp9vGyT633YXo+EI1HDbG+mFqV2thbWXOS9Pxpa1QP+dTH5Hj+2
         5cSfe1UBaZWtg==
X-Google-Smtp-Source: ABdhPJxgXeDWtSrD1bCwnK7FP7jLX7IY7SA8mS0iZBOfUkOEAUdIXARrcV+Jbi6lq099OrASiaaS5cey+ePtzNEnAbw=
X-Received: by 2002:a17:906:2806:: with SMTP id r6mr17815664ejc.130.1607350718180;
 Mon, 07 Dec 2020 06:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20201109192611.16104-1-vidyas@nvidia.com>
In-Reply-To: <20201109192611.16104-1-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Dec 2020 08:18:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK3bbp-50fu498nN+p1rmRBSyX4ctbz9tgfPFA8GqPiCg@mail.gmail.com>
Message-ID: <CAL_JsqK3bbp-50fu498nN+p1rmRBSyX4ctbz9tgfPFA8GqPiCg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Add support to configure for ECRC
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

On Mon, Nov 9, 2020 at 1:26 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 50 ++++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 47 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
