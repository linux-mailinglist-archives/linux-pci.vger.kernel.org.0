Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F264147622A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhLOTuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 14:50:32 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:34417 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhLOTub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 14:50:31 -0500
Received: by mail-oo1-f49.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so6233479oog.1;
        Wed, 15 Dec 2021 11:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOnL6FtlkEPq4JwJbq4ZntR2PTCXZJH8UTvwELdoNOI=;
        b=PdHc5bn37ERxno8DvjE2ID71906Sq+Pggl6mpuuO3bZ0XWEQAUqdmzXqY2JHNGhfuF
         Vp1lQy+aUenTnuutKIDkKlyb9F8ffJuenbnDHGJ8Ybek4z8wS4iNydNL6gt80x5O1E4+
         0dZkgE37MExkos3c5RkxoZP/WzpaC7UXkS4u18oWUVUcPOyOuQmIJ2lMsOV+aRkJiKFC
         XDpxOv7oo7J+9uIljenKpvtPNsm0AUkQlNID/pBJdxUxrR87YwQki5nlvgX8UcQLi525
         WDijWSNSyq7hj9A1J8lLIiVMSy2jJmXQ1K3WGVqKYqprcNggI+j5/GIt+Hj3DOEFl1+A
         sABQ==
X-Gm-Message-State: AOAM530syD1T0+Bmo9CJ2Fu3iKnB6cj079Q6LUv/NO90Gi7300rIiAp0
        sFfUV4RNR+v6uWZLHVi6ow==
X-Google-Smtp-Source: ABdhPJymhdbBzWTF6GqA7YjnSBH3BeiC4soK970pMrTFbTWw6FjPOrFhAxHrJr10lC2NEeX3H8uwYQ==
X-Received: by 2002:a05:6820:30b:: with SMTP id l11mr8624417ooe.32.1639597830554;
        Wed, 15 Dec 2021 11:50:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t3sm609157otk.44.2021.12.15.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:50:29 -0800 (PST)
Received: (nullmailer pid 1724400 invoked by uid 1000);
        Wed, 15 Dec 2021 19:50:28 -0000
Date:   Wed, 15 Dec 2021 13:50:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        linux-mips@vger.kernel.org,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, james.quinlan@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: Add compatible string for
 Brcmstb 74[23]5 MIPs SOCs
Message-ID: <YbpHBJurUaoT4pZD@robh.at.kernel.org>
References: <20211209204726.6676-1-jim2101024@gmail.com>
 <20211209204726.6676-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209204726.6676-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 09 Dec 2021 15:47:22 -0500, Jim Quinlan wrote:
> The Broadcom STB Arm and MIPs SOCs use the same PCIe controller
> HW, although the MIPs version is older.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
