Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143E3DA9FB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhG2RUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 13:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhG2RUy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 13:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C67E760F42;
        Thu, 29 Jul 2021 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627579250;
        bh=3u51lRqQafrXq5f6IqvWMxZ1ptNInQdEddFA3TjKAb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bbTDTTZUuX1tvZrjspUiyv7DKa8/vf8E/FZBxFhlf4W1jolNX6oBAnUQmJLMA+/HO
         os+AFaPTyDu57ZXYiK1ZmRz+uv4PsMw0xMU5NsT4xSr2TCKBn4DlXJQPC9aOVprzve
         OXGhvZsI9KJS8jfurdZYrJmlILa2SrwZumTm2BeTDTueOvNKqD7DpMpMemfTMHwQtP
         m7OWv5mIHK07aUFQSE73K7t6wqG3gJKYxq8Cv36//b5YyWFrVKc2ohRCANV5aEPjFA
         js5QvQdGh2cPcaatgPANzygIq1RoxijBd88J8YAo6KIOtXqCmuSd4gLTGtZ0TAwS1H
         3ysTC+kA1fsag==
Received: by mail-ej1-f48.google.com with SMTP id e19so11929870ejs.9;
        Thu, 29 Jul 2021 10:20:50 -0700 (PDT)
X-Gm-Message-State: AOAM532WgPfHP1QJVQvUosrjizcT70WnF0mKtZUW3IjL7SbnwBIGnPIn
        vRUygH3UR6wGhX9Vti6hopcJNpJ8dapK/6Dmow==
X-Google-Smtp-Source: ABdhPJzuipRyW+xyNT+RtqOAnbQFg0W4CvcPJqdZSA4Ju9OA/O4unHd//H8Jvub6DcKsikWuNgfrKfNfwMj6Ur9hAJQ=
X-Received: by 2002:a17:906:d287:: with SMTP id ay7mr5417811ejb.360.1627579249347;
 Thu, 29 Jul 2021 10:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627559126.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1627559126.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jul 2021 11:20:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+fY3k7JzUYH5WX=nDoa2jLwnoEf8hp64UjYR5OpPAFiA@mail.gmail.com>
Message-ID: <CAL_Jsq+fY3k7JzUYH5WX=nDoa2jLwnoEf8hp64UjYR5OpPAFiA@mail.gmail.com>
Subject: Re: [PATCH 0/5] DT schema changes for HiKey970 PCIe hardware to work
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 5:56 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Rob,
>
> After our discussions, I'm opting to submit first the DT bindings for the
> Kirin 970 PCIe support.
>
> Patch 1 is there just because patch 2 needs. You already acked on it.
>
> Patch 5 is also there just as an example of the entire stuff added to
> the DTS file.
>
> The core of this series are patches 2 to 4. They contain the conversion
> of the kirin-pcie.txt file to the DT schema, and adds the needed
> bindings.
>
> Currently, it generates some warnings:
>
>    Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f5000000: pcie@4,0:compatible: None of ['pciclass,0604'] are valid under the given schema
>         From schema: Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml

This should be fixed now in dtschema master.

>   Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@4,0: reset-gpios: [[4294967295, 1, 0]] is too short

Your proposed change to pci-bus.yaml is wrong. It's requiring 4
entries. You need 'minItems: 1'.

Rob
