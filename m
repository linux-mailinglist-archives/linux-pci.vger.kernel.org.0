Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878B948BC78
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 02:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiALBaj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 20:30:39 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46035 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiALBaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 20:30:39 -0500
Received: by mail-oi1-f170.google.com with SMTP id t9so1438496oie.12;
        Tue, 11 Jan 2022 17:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CQIGGTzoJ4KByPkRaK7D+T+l6re9t+YkmjrIouxd4KA=;
        b=BuEXApT+H0Iv+17+AfTm7fZ+Z6rLlD22d0R1PNappXkzdaHih7nA+f2mdYufCcDXrc
         zIY6aVH1T3CkGMjPY7ef2i/evIn7XEPkDxUmeIx0Hv05fIpo74b/Ppxiyw4u4xT72bt5
         G0nPOw3ImIl16p4V92vqGe6V7E6ijR18hII3toPzkescDhIgz29n84sMez9k9GK0FR8D
         hMCxOvpNInWzEhi8+wlPVe+HwDVd3IM5dJdly/gkUIeZDeEiLTO2okwP2jEjz5I74WdW
         GapMpBA6aPggYMoHFO2QJzHwWBrnYleWb0v3V5EBYbpRDP9Q5w2Vrhx/QcZiGfzXXenJ
         /Vqg==
X-Gm-Message-State: AOAM533TiR3LQ4rdQmSM3/1to+9+RVC2vlKpj6ciVxYZ40BDvFlUsYE8
        rDry1DPPmBJJf+IJiikFbOGR3PjRjQ==
X-Google-Smtp-Source: ABdhPJyRrY0awBxfCnhsmy8iXNqluRU+JGL3oUqttbabEPdPsvs8r11Gtb/cgXQ/XK0pX5ThN9578w==
X-Received: by 2002:a05:6808:1b2b:: with SMTP id bx43mr3699375oib.38.1641951038511;
        Tue, 11 Jan 2022 17:30:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w19sm394262oiw.29.2022.01.11.17.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:30:37 -0800 (PST)
Received: (nullmailer pid 3869648 invoked by uid 1000);
        Wed, 12 Jan 2022 01:30:36 -0000
Date:   Tue, 11 Jan 2022 19:30:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 09/11] dt-bindings: PCI: mvebu: Update information about
 intx interrupts
Message-ID: <Yd4vPDAu82Ec6fEc@robh.at.kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-10-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105150239.9628-10-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 05 Jan 2022 16:02:37 +0100, Pali Rohár wrote:
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
