Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE51CE297
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgEKS1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 14:27:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36587 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgEKS1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2020 14:27:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id t3so8365126otp.3;
        Mon, 11 May 2020 11:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CIBx1VjiCxtA0AYvNLauEJB36ppdEW439Ed+xOZ8GOI=;
        b=Gb69kHsweaCXKzYjnW2W6Q+BQD4RVpcEAPXGeoP+f5KOpmQ9HtjdX6pfOZkoXIzKwn
         vQM3I6R76KDGvawrrUlgjet5msI4sTRjaYFgpWdmP8cuH1ANRwdAMMZnsv1zX+G1cIN5
         lM1fdZ92ax9yw++6a3ZATi56Sk1aMUQKrMWoS2k/uFfLu/y4msBElNF+wPVybfke7Uef
         NS8dYwW6/XqZLuTAO9k9kdNZW0jAmcP5Mlup96LwrAg21sFBjD3hqhNICrqH3ehNKF7G
         uPCJSxgTJC2YKkzXTTLsXEFBYoAUlTGQoxte31A06SqzyTF29i9YMxNfvQYlYrgWhEbQ
         DEWw==
X-Gm-Message-State: AGi0PuaR/hquCl98HBO0pfZl8e9PTjOMMH1+DN4q3NRGIiDwpNdYuchE
        tPR4wXXteoN09fIEKZ4Ltg==
X-Google-Smtp-Source: APiQypIS1s3puareZxlhadJ1/IfeGfhmFMCEV1g0UAvrkDW9+LMJYWL0VuUAU8L4Cp1evliUtjvKFQ==
X-Received: by 2002:a05:6830:2158:: with SMTP id r24mr14045090otd.65.1589221638203;
        Mon, 11 May 2020 11:27:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f73sm2839119otf.53.2020.05.11.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:27:17 -0700 (PDT)
Received: (nullmailer pid 20786 invoked by uid 1000);
        Mon, 11 May 2020 18:24:23 -0000
Date:   Mon, 11 May 2020 13:24:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/9] dt-bindings: PCI: aardvark: describe new
 properties
Message-ID: <20200511182423.GA20142@bogus>
References: <20200421111701.17088-1-marek.behun@nic.cz>
 <20200421111701.17088-8-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-8-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Apr 2020 13:16:59 +0200, Marek Behún wrote:
> Document the possibility to reference a PHY and reset-gpios and to set
> max-link-speed property.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/aardvark-pci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
