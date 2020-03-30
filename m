Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C342A198015
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgC3PpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 11:45:15 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40370 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgC3PpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 11:45:15 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so16282937ilr.7;
        Mon, 30 Mar 2020 08:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9R8G5T/VKCO+aqrslpT5o8M241aUmf+x9/X8tSG6fnY=;
        b=Gb7J8ROSxrWWVLBFmfwIrnOph6TlTtPlU3/ljOAXC6Px2g7v5zZaqPrdWuCdocz8RP
         ES1SmQ7QleChoFCl1CPseR1DAI+bG2ccRtvFLIcyCDsdg8e6S80XBD3P0n2JWobdKaW0
         S21J0dXEXryNaAOGDvmLTNq/dLzJABv+IjUQjbwFbghCxnDgqs0OY802MZXwpOR4+jDv
         iw6uiRRSlE/EwZTnlsGj0+ECn+kBtjX8fuz1jpya+xnCINvTBpIYFQex977tLpNAldtN
         dIsHat0gGrNkuU/vz1qrMjlPMhcxGxZNWRT7XrYKP2/Tf8dCPUR7mVzWJTl40iUYukIG
         X1cg==
X-Gm-Message-State: ANhLgQ1uNi/wepOqPZejN/CEvpr4tXxwfF/mzStGj1BMHr1VdPjTeq/E
        KrKTYl/lEwBbmCfJWiNEfQ==
X-Google-Smtp-Source: ADFU+vshXHqdgHy17vaPaT+/cbnSnbdv+mzm7sW3yyhSBYLwQf9VifgKgDNngQteQjbyeb9qGzngYA==
X-Received: by 2002:a92:ce51:: with SMTP id a17mr12277809ilr.263.1585583114341;
        Mon, 30 Mar 2020 08:45:14 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w88sm4961029ila.24.2020.03.30.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:45:13 -0700 (PDT)
Received: (nullmailer pid 28997 invoked by uid 1000);
        Mon, 30 Mar 2020 15:45:12 -0000
Date:   Mon, 30 Mar 2020 09:45:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: Document Loongson PCI Host Controller
Message-ID: <20200330154512.GA27624@bogus>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200330114239.1112759-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330114239.1112759-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 30 Mar 2020 19:42:28 +0800, Jiaxun Yang wrote:
> 
> PCI host controller found on Loongson PCHs and SoCs.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../devicetree/bindings/pci/loongson.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/loongson.example.dt.yaml: pci@1a000000: ranges: [[33554432, 0, 1073741824, 1073741824, 0, 1073741824]] is too short

See https://patchwork.ozlabs.org/patch/1263901

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
