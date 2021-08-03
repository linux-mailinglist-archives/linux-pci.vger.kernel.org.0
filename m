Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC63DF749
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 00:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhHCWMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 18:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHCWMH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 18:12:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ECC060EE8;
        Tue,  3 Aug 2021 22:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628028716;
        bh=vSQLD2Dx1iWptSqQt/0j5xCISU3XPMV2GPsXMPEtfV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s5haClTxAMXXK+SMtVRQLn48uZKTcUAX14akEg9/wY3BQwYq7AVRcJt5h8zntzWFp
         /UIT4jYCDh4j67dB934kbf0xKBY0ExfvhUpJLULbpvC9CRLDIfYnc8qFl1r0lBviUg
         oZFikuRWBM1+EjbbORbQrpPJKFGgOwkP2YiUNOEafg5yicWOMdVeCmIA/ol3lWG4N0
         0zBHnEOLov3Y9JnsSytJSucCkhh9DNixVMsecqjjjMcdBykCUp72WEzqHqi5CruOHu
         j43AHg8y0n5589bpPH9Uk1xP1ZoR1kINMMjfcpYG3F3OQtuHRimmywvEoeL4L6M6KX
         MDsWmeSO3lv9w==
Received: by mail-ed1-f47.google.com with SMTP id p21so980211edi.9;
        Tue, 03 Aug 2021 15:11:56 -0700 (PDT)
X-Gm-Message-State: AOAM533bDacAEsEox1AgNDbp9nbedMzfs3TVsGyUlXie3pVglXRdu4Lg
        mhIsFrli/3j/ZRa8CW9uZS073lRgvst9tW5vbQ==
X-Google-Smtp-Source: ABdhPJy8lulYOjbYH1fj7VhNDQlwD+s1ZfdaUnK40lRIQAEPWK8BCRG86JqAGI6XEr1nfCf6u6Fiu0avOmOqKVXK26M=
X-Received: by 2002:a05:6402:291d:: with SMTP id ee29mr28816734edb.289.1628028714789;
 Tue, 03 Aug 2021 15:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1627965261.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Aug 2021 16:11:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
Message-ID: <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to work
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Rob,
>
> That's the third version of the DT bindings for Kirin 970 PCIE and its
> corresponding PHY.
>
> It is identical to v2, except by:
>         -          pcie@7,0 { // Lane 7: Ethernet
>         +          pcie@7,0 { // Lane 6: Ethernet

Can you check whether you have DT node links in sysfs for the PCI
devices? If you don't, then something is wrong still in the topology
or the PCI core is failing to set the DT node pointer in struct
device. Though you don't rely on that currently, we want the topology
to match. It's possible this never worked on arm/arm64 as mainly
powerpc relied on this.

I'd like some way to validate the DT matches the PCI topology. We
could have a tool that generates the DT structure based on the PCI
topology.

> at Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>
> IMO, the best would be to merge this series via your tree, as it
> depends on the patch converting the DT bindings for the PCIe DWC
> driver.

Yes, agreed.

Rob
