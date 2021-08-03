Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B63DF7C7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhHCW1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 18:27:35 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:41553 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHCW1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 18:27:35 -0400
Received: by mail-il1-f181.google.com with SMTP id j18so35616ile.8;
        Tue, 03 Aug 2021 15:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHOdTdufKzUNRw/NzOjkZbCMKmy2XrmFe3sMoIzHStg=;
        b=WiEWm6j0QRgiEb7f/lu9+jbyBw1f9/cpJXC7be+StotWtt9D6GUKSfUKakrva4V9v6
         +U93IXbiNxD4dzD/8nu64HmS5TkoBxI8ot8MOh4bxmBVJduHZviU0bmsOVhfdmgJ6OYW
         GjwvJHxu5TBJz8iYTw2RP3AxBhoAy7saNAatu7zm1qu4wq7E8kMp9gzCcanPgNKUjGbh
         bNe1QTm3lfPq0x0WhCB6EaylRJLrMNUsJtaLtsbQFQ11sQUE8xsZOyxB4sxIjVqH2itQ
         ScKwTQCs/lmWeo52qyWGkybYbg8HtyxOLg+Mt6OmnRR+Ce0VYKGJA6reeHK8KKctd50s
         gIoA==
X-Gm-Message-State: AOAM533EaYmPwdYvxk22PFisASUPosEufijpJcDeoczWpfWaw7f9n+7x
        EoV3bABLw5jnTZrlzupMmQ==
X-Google-Smtp-Source: ABdhPJx7vhyLuu8I+E1UqgXX+/KHJ5KHEYbfcMsVWEy1Mgn9AL+l4jXQCnuWyZfm50CO2Ek3Cd5FYg==
X-Received: by 2002:a05:6e02:5ce:: with SMTP id l14mr237712ils.147.1628029642260;
        Tue, 03 Aug 2021 15:27:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l9sm125436ilv.31.2021.08.03.15.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 15:27:21 -0700 (PDT)
Received: (nullmailer pid 3841668 invoked by uid 1000);
        Tue, 03 Aug 2021 22:27:19 -0000
Date:   Tue, 3 Aug 2021 16:27:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: kirin: Convert kirin-pcie.txt
 to yaml
Message-ID: <YQnCx9nvXwHOMcpx@robh.at.kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <4d6e172cee9d477547d5ea26d0e5945fcbce15a1.1627965261.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6e172cee9d477547d5ea26d0e5945fcbce15a1.1627965261.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 06:38:56AM +0200, Mauro Carvalho Chehab wrote:
> Convert the file into a JSON description at the yaml format.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 86 +++++++++++++++++++
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 50 -----------
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 88 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

This doesn't apply to my tree. I think the problem is I have some other 
snps,dw-pcie.yaml changes. Can you rebase and resend.

Rob
