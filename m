Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4702648BC73
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 02:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbiALB34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 20:29:56 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38895 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347481AbiALB3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 20:29:55 -0500
Received: by mail-oi1-f175.google.com with SMTP id g205so1484356oif.5;
        Tue, 11 Jan 2022 17:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JQUjCC5RsS3V1MvvzDzPIF+rIzFXHuMqepYoCDJMKc0=;
        b=jRTyvuVU4VM/wQU1fqJvxJsPLA7gdW1l5koalYA3ufwNDsFKudB442XckwcMsN69UK
         fcJVQ9A+wPO2Lzv7+H0ZgekkgVelnlm/dU3VIlh2wCQQJXPi5B9EtGMtq3oQFeqwnFWo
         B1Nlot886xbcwS6pas57YGXg4qHSaNYaXWJLprVPhsZ3cGkMKuIsnPteaDjktvKDQWiG
         uhtn0SrKHYEZMKZ1wm9YTe2y4ZuUjOXNdY0drDvvmTSwqpYv8LAc8wYQ/f8Ci7o9QMHS
         5bemGiz5orwotvUK8wq2kQsDLvRYNZZ6ak8vGSgvHO/GS1xqky563FG6mgkU/JAIprow
         /HVA==
X-Gm-Message-State: AOAM533Sqx/YgC+E7lq3fgoOKp9QE3lbDmsNWIIAUgeZhFg28+wpJKID
        EWr8nRhGx448AxgFaszvog==
X-Google-Smtp-Source: ABdhPJw7M1Fxl218+YI4X4u9dzoXOt0BGQ6nVgaaR3bUUGQy8x5inZnOqNlFZjKfipCheLMl8JH4fQ==
X-Received: by 2002:a05:6808:219e:: with SMTP id be30mr3836347oib.80.1641950995238;
        Tue, 11 Jan 2022 17:29:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j16sm2321107otn.30.2022.01.11.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:29:54 -0800 (PST)
Received: (nullmailer pid 3868556 invoked by uid 1000);
        Wed, 12 Jan 2022 01:29:53 -0000
Date:   Tue, 11 Jan 2022 19:29:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 04/11] dt-bindings: PCI: mvebu: Add num-lanes property
Message-ID: <Yd4vESC55qFruR/6@robh.at.kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105150239.9628-5-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 05 Jan 2022 16:02:32 +0100, Pali Rohár wrote:
> Controller driver needs to correctly configure PCIe link if it contains 1
> or 4 SerDes PCIe lanes. Therefore add a new 'num-lanes' DT property for
> mvebu PCIe controller. Property 'num-lanes' seems to be de-facto standard
> way how number of lanes is specified in other PCIe controllers.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
