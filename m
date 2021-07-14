Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4F3C7BC6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 04:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhGNCaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 22:30:00 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:44935 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhGNCaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 22:30:00 -0400
Received: by mail-il1-f174.google.com with SMTP id r16so51309ilt.11;
        Tue, 13 Jul 2021 19:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujJQoPV+pfMXXkjwrk+Bw14ahLxltcwsmW7UJl+uIn4=;
        b=UHfGjwJ0bxlIPxd9NtVKhKc5wKgqXIvNNra4h/ufSsokovuErGfpFMnezrbunJGyCR
         ElP+GyBDf3ZEjK9XFZZBtCU7Sm/fU3+9BWjJHdvJSwJFjsnvSdZTDxeD1owikIU4YohH
         37bojSB5ekENdHwIvT7Q/QQ67VtT07d30HGxDVuhu3m90wwQ2kGK+1lyrfFPlVKgGtp/
         0BKpSMq8VO1fF2r4gnSRRw9+iGzrI1zyjKq1dkGxj1/5DU6+2i8XzQe0dV8KaSdLAud6
         q40RjcER0u8L4p50yUmWdWfIxjrqJMwdDYMqnrdFpGpe6kLnWh8FcL2WQsbzNQ3cCt9K
         8pAg==
X-Gm-Message-State: AOAM530GxA8Il1MMtuwfSW4OVZRk1yYEZNe3PXKNEXMw7keQicwVnhey
        P8u8e1azVB4r0xEOgxMPVA==
X-Google-Smtp-Source: ABdhPJwA3M2HMa2pzPptPOoKbUPtAhP7RXRl85exBpd2vs27r2qnIicoquSPJTct7YIY3x8FwxSWog==
X-Received: by 2002:a05:6e02:e02:: with SMTP id a2mr5139119ilk.127.1626229629110;
        Tue, 13 Jul 2021 19:27:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h6sm477632ilo.0.2021.07.13.19.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:27:08 -0700 (PDT)
Received: (nullmailer pid 1330529 invoked by uid 1000);
        Wed, 14 Jul 2021 02:27:06 -0000
Date:   Tue, 13 Jul 2021 20:27:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>, linuxarm@huawei.com
Subject: Re: [PATCH v5 3/8] dt-bindings: PCI: kirin: Fix compatible string
Message-ID: <20210714022706.GA1330447@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
 <083e622bb8f3d529128b9d63bef9b75b98d4b1f1.1626157454.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083e622bb8f3d529128b9d63bef9b75b98d4b1f1.1626157454.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 13 Jul 2021 08:28:36 +0200, Mauro Carvalho Chehab wrote:
> The pcie-kirin driver doesn't declare a hisilicon,kirin-pcie.
> Also, remove the useless comment after the description, as other
> compat will be supported by the same driver in the future.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/kirin-pcie.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
