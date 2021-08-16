Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1C3EDEB0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 22:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhHPUfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 16:35:13 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37597 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhHPUfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Aug 2021 16:35:11 -0400
Received: by mail-oi1-f169.google.com with SMTP id u10so28577542oiw.4;
        Mon, 16 Aug 2021 13:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7oF4cY6wlWIjx7KIyMGDbLK0US100rK8cbns+Ja8Tc=;
        b=k8dxl8nfbb1SkCudbIvFD8ugkpLhBMJJeo6a1RD3Fcr816qYfBCCLHEu/zqpkc6pVx
         I2fzjQGmxbvW8+KXSVa/ubECvLIQXMDyzJAUQdV1rDWxfYwdSRc5gzh6CRoqZankUjlZ
         mcu4GZAuGrtMDWVJS6J5OVMOjU/rCyqOOwF8YNW4k/7p1iKe0dyV8Q2aJfcq6ikZJ5OH
         CAlloFG7shXHYr0TpO7UUbqvb9gtN5x4Rq2S69jCpeFq4Ivsr+9dKYlHyAL510DBvXaS
         Cvjq9fGr2NBp4+AiOE/PgiUbZMR66A5zR3CToo+wf2Scc3NtHf4w5QINas2Vwg+2f5PF
         gisA==
X-Gm-Message-State: AOAM530I3PD2Zc1REwI+xB3FDi+atSlfqjhoagsS5P4EUOdmjS45EnHr
        L4SU2+JsIDkq33IeGiAUrw==
X-Google-Smtp-Source: ABdhPJygpDnonMJ9OuIxHg0kOrR2DRgIqw4+ZZ0Hp+jrDk/Ghxyu8TRUXAKPj95r1mZRfanmb0dAig==
X-Received: by 2002:a54:4096:: with SMTP id i22mr539410oii.26.1629146078778;
        Mon, 16 Aug 2021 13:34:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm22947ooy.5.2021.08.16.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:34:38 -0700 (PDT)
Received: (nullmailer pid 2606260 invoked by uid 1000);
        Mon, 16 Aug 2021 20:34:37 -0000
Date:   Mon, 16 Aug 2021 15:34:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Adjust HiKey examples for kirin-pcie
Message-ID: <YRrL3Y3wvMLYSUsZ@robh.at.kernel.org>
References: <cover.1629143524.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629143524.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 16, 2021 at 09:53:24PM +0200, Mauro Carvalho Chehab wrote:
> Rob,
> 
> As discussed on another thread, there are three issues at
> pci/hisilicon,kirin-pcie.yaml:
> 
> - The bus-range parameters are causing warnings;
> - The Kirin970 example doesn't reflect the right device
>   hierarchy, causing some of_node files under sysfs to
>   not be initialized;
> - There is a wrong msi-parent node causing it to not work
>   properly and to produce  several warnings.
> 
> This small series fix such issues.
> 
> Mauro Carvalho Chehab (2):
>   dt-bindings: PCI: kirin: fix bus-range
>   dt-bindings: PCI: kirin: fix HiKey970 example
> 
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 66 ++++++++++---------
>  1 file changed, 36 insertions(+), 30 deletions(-)

I applied and squashed these into the prior series.

Rob
