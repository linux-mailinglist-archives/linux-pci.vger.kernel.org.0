Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E635E254
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbhDMPKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 11:10:39 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45823 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbhDMPKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 11:10:38 -0400
Received: by mail-oi1-f173.google.com with SMTP id d12so17281078oiw.12;
        Tue, 13 Apr 2021 08:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YsCanL7b/TjLkmx+enx9Aus4Vr+uIbAaQh+vlFwv0l8=;
        b=fHREhs4nzanSlZjyzq6dXXI/IojJCiai1w3o+ysNLZztaumMATzpeRg55MuObor/ci
         6CpzR6mLmczhB/holIG2CB2suHp3LLcg116NvmYlkvpUYOf3dk2+Qm5zdtbzOZyASArY
         tJ55tvMuoYDU8X3bWGA/Ms3wCHfE5J/g8Pfz3A0AICjAs/2bfJcRBZa4CrcVAgq8j4z6
         uvp987zA+ByrTogFvQ4bNYdUF930CER2hE+e5in/9QZ7Rapi9w6bibU0z+TdEK+gWP5o
         En+cXcBXaaQeNc2ff8oYkkgs5Ma1rpib2TL+q+fdOVM/Amw1qgpxU9/E1rMb5sjPtBvO
         PK1w==
X-Gm-Message-State: AOAM530+vcInOC7JrWrlf7c7tsP8RBjoRN4eKwQ6+17KhBu/oYtD6Q8m
        Jf5hQ2Uho9a6efehIQHZ9Q==
X-Google-Smtp-Source: ABdhPJzF1zgWHCJiGfVKDmhrJ2wTKR6x2ewP8TcygE4TuVMBkDsYK6eQpMYOS/t6b7dptR+qRTWBRw==
X-Received: by 2002:a05:6808:10c5:: with SMTP id s5mr369821ois.58.1618326616659;
        Tue, 13 Apr 2021 08:10:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x2sm3539688ote.47.2021.04.13.08.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:10:15 -0700 (PDT)
Received: (nullmailer pid 1686803 invoked by uid 1000);
        Tue, 13 Apr 2021 15:10:13 -0000
Date:   Tue, 13 Apr 2021 10:10:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     bpeled@marvell.com
Cc:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, mw@semihalf.com,
        jaz@semihalf.com, kostap@marvell.com, nadavh@marvell.com,
        stefanc@marvell.com, oferh@marvell.com
Subject: Re: =?utf-8?B?W+KAnVBBVENI4oCdIDMvNV0gZHQt?=
 =?utf-8?Q?bindings=3A_pci=3A_add_system_controlle?= =?utf-8?Q?r?= and MAC
 reset bit to Armada 7K/8K controller bindings
Message-ID: <20210413151013.GA1683364@robh.at.kernel.org>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
 <1618241456-27200-4-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618241456-27200-4-git-send-email-bpeled@marvell.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 06:30:54PM +0300, bpeled@marvell.com wrote:
> From: Ben Peled <bpeled@marvell.com>
> 
> Adding optional system-controller and mac-reset-bit-mask
> needed for linkdown procedure.
> 
> Signed-off-by: Ben Peled <bpeled@marvell.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> index 7a813d0..2696e79 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -24,6 +24,10 @@ Optional properties:
>  - phy-names: names of the PHYs corresponding to the number of lanes.
>  	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
>  	2 PHYs.
> +- marvell,system-controller: address of system controller needed
> +	in order to reset MAC used by link-down handle
> +- marvell,mac-reset-bit-mask: MAC reset bit of system controller
> +	needed in order to reset MAC used by link-down handle

Seems like this should use the reset controller binding instead.

If not, this can be a single property with a phandle plus arg.

Rob
