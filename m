Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4011B9B2
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfEMPQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 11:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfEMPQA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 May 2019 11:16:00 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1AE4208C3;
        Mon, 13 May 2019 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557760558;
        bh=OymGSOMK0re+Yot/v38njtC9uTP6U8c73FKxT8tC/Ms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qf4M0C9fGFnIt0Q4eTa6NkglegZSn+xlWJ65AAgdpHeRGmU9YdVFlqvTzUdWsFz7s
         NbFeWVZeHa7gRy72D9Sm9xinRKkbMMmCAfhtNzjb5iIHmukzZjYt18VA6xFSfFMGVd
         bSZWQM8VGa7vd0ujpjo/tmFDo4NGrgQ+4y9eRBgo=
Received: by mail-qk1-f171.google.com with SMTP id d4so8207626qkc.9;
        Mon, 13 May 2019 08:15:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXXapN4NR1DFituNfGKCH1mCTDVK+n5TyJYR+5izT8s5foWW9rq
        O403rF2wZBQpus3LWWCmkCZHolV1FqKXdQDmEg==
X-Google-Smtp-Source: APXvYqwCUcsN930OQbfEHdiCeZNxxMRjVQYZxsmDH3L7i6qyIbXFFz68ravs5bTeXrnotA6KjQjMS9kSXpzcUdQ9LXc=
X-Received: by 2002:a37:5c81:: with SMTP id q123mr14710095qkb.29.1557760558100;
 Mon, 13 May 2019 08:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190424052004.6270-1-vidyas@nvidia.com> <20190424052004.6270-8-vidyas@nvidia.com>
 <20190426143247.GA25107@bogus> <031df2ca-27de-2388-5f23-078320203f5d@nvidia.com>
In-Reply-To: <031df2ca-27de-2388-5f23-078320203f5d@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 May 2019 10:15:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvES6OuPRgu8A009j6L4rkc11rB9TyxPe1iUJhvk1O8w@mail.gmail.com>
Message-ID: <CAL_JsqKvES6OuPRgu8A009j6L4rkc11rB9TyxPe1iUJhvk1O8w@mail.gmail.com>
Subject: Re: [PATCH V5 07/16] dt-bindings: PCI: designware: Add binding for
 CDM register check
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

On Tue, May 7, 2019 at 3:25 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> On 4/26/2019 8:02 PM, Rob Herring wrote:
> > On Wed, Apr 24, 2019 at 10:49:55AM +0530, Vidya Sagar wrote:
> >> Add support to enable CDM (Configuration Dependent Module) registers check
> >> for any data corruption. CDM registers include standard PCIe configuration
> >> space registers, Port Logic registers and iATU and DMA registers.
> >> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
> >> Version 4.90a
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> ---
> >> Changes since [v4]:
> >> * None
> >>
> >> Changes since [v3]:
> >> * None
> >>
> >> Changes since [v2]:
> >> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
> >> * Added info about Port Logic and DMA registers being part of CDM
> >>
> >> Changes since [v1]:
> >> * This is a new patch in v2 series
> >>
> >>   Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >> index 5561a1c060d0..85b872c42a9f 100644
> >> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> >> @@ -34,6 +34,11 @@ Optional properties:
> >>   - clock-names: Must include the following entries:
> >>      - "pcie"
> >>      - "pcie_bus"
> >> +- enable-cdm-check: This is a boolean property and if present enables
> >
> > This needs a vendor prefix.
> Why only for this? Since this whole file is for Synopsys DesignWare core based PCIe IP,
> I thought there is specific prefix required. Am I wrong? Also, CDM checking is a feature
> of IP and DWC based implementations can choose either to enable this feature at hardware level
> or not. And whoever enabled it at hardware level (like Tegra194) can set this flag to
> enable corresponding software support.

TBC, I meant a Synopsys vendor prefix, not NVIDIA.

Any property that's not from a common binding should have a vendor
prefix. That hasn't always happened, so we do have lots of examples
without.

Rob
