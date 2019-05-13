Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4CF1B9CB
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfEMPVE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 11:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfEMPVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 May 2019 11:21:04 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB0E2168B;
        Mon, 13 May 2019 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557760863;
        bh=SYgBc1HBac/X+vUHcByqrS9pPjJfIUqdOtc9N7yxPdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jRkigaEcwIHxg0BisI/v8xkHnLJtivkb6bvrdiTatmnpJHuU+p6Zl7I+BzFwxM1rq
         fDzNBhBoJbAwnm3H/mN1ePxFYS7NNR3OEGVHSWDKMgX/+pZ/4PYBax42tp+CK8btCQ
         +Yjb4x6/GgedTznMSnXpEIDLuo381sZO7T8U26Zw=
Received: by mail-qt1-f173.google.com with SMTP id y22so11734091qtn.8;
        Mon, 13 May 2019 08:21:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVP507rlX5/fwiAILmJrobkVPtQ2TxBFaqECZSL67KtmWxQs75n
        +2zQ2jDoLNO43IByqNCUGtKPwhwtkhnfcYPZCg==
X-Google-Smtp-Source: APXvYqzX2L5FoRWF0zW2HYeRpIyyhRcBgYtEPjBnonNXCdUdc3d0qH4FJ9S/BaZ6kGLKiYPsCDVif2zcxQZTRnvQNiU=
X-Received: by 2002:a0c:9066:: with SMTP id o93mr23169009qvo.246.1557760862035;
 Mon, 13 May 2019 08:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190424052004.6270-1-vidyas@nvidia.com> <20190424052004.6270-11-vidyas@nvidia.com>
 <20190426154306.GA16455@bogus> <504abd8f-9eb3-1089-953c-a6372c34b346@nvidia.com>
In-Reply-To: <504abd8f-9eb3-1089-953c-a6372c34b346@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 May 2019 10:20:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEw+HAeqd2TD33cSVBjwDUNMb5amk2wGsW9m_4Z6CucQ@mail.gmail.com>
Message-ID: <CAL_JsqLEw+HAeqd2TD33cSVBjwDUNMb5amk2wGsW9m_4Z6CucQ@mail.gmail.com>
Subject: Re: [PATCH V5 10/16] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, kthota@nvidia.com,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 7, 2019 at 4:20 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> On 4/26/2019 9:13 PM, Rob Herring wrote:
> > On Wed, Apr 24, 2019 at 10:49:58AM +0530, Vidya Sagar wrote:
> >> Add support for Tegra194 PCIe controllers. These controllers are based
> >> on Synopsys DesignWare core IP.
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> ---

> >> +- nvidia,bpmp: Must contain a phandle to BPMP controller node.
> >> +- nvidia,controller-id : Controller specific ID
> >> +    0: C0
> >> +    1: C1
> >> +    2: C2
> >> +    3: C3
> >> +    4: C4
> >> +    5: C5
> >
> > We don't normal put device indexes into DT. Why do you need this.
> > Perhaps for accessing the BPMP? If so, make nvidia,bpmp a phandle+cell.
> BPMP needs to know the controller number to enable it hence it needs to be
> passed to BPMP. Just for accessing BPMP, I already added 'nvidia,bpmp' property.

Then make nvidia,bpmp take the phandle and this number.


> >> +- nvidia,disable-aspm-states: Controls advertisement of ASPM states
> >> +    bit-0 to '1': Disables advertisement of ASPM-L0s
> >> +    bit-1 to '1': Disables advertisement of ASPM-L1. This also disables
> >> +                   advertisement of ASPM-L1.1 and ASPM-L1.2
> >> +    bit-2 to '1': Disables advertisement of ASPM-L1.1
> >> +    bit-3 to '1': Disables advertisement of ASPM-L1.2
> >
> > Can't this cover what 'supports-clkreq' does?
> Well, they are related partially. i.e. if a platform doesn't have 'supports-clkreq' set,
> then, by definition, it can't advertise support for ASPM L1.1 and L1.2 states. But, ASPM-L0s
> and ASPM-L1 states don't depend on 'supports-clkreq' property.
> Having this property gives more granularity as to support for which particular ASPM state
> shouldn't be advertised by the root port.

Okay, then it should be a common property then.

Rob
