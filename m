Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392771C9D3E
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEGVZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:25:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43827 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEGVZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:25:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id j16so6541107oih.10;
        Thu, 07 May 2020 14:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DJ5irMJzwpgHAqiapmHTr23XyC1rqL9GiDlf1aWaR14=;
        b=Dsz87cEyw8i5Qy59dGW5ap5/py+spueNDMp4EUVO23qrfPCrsX9g/q9Gl1fe3uLZNQ
         1CCBJ+4TDClZkge1U9O01UcxzZQlLQitUtsW371zd+9758TbsXh63vCIeBbu4XM78fQU
         +54M8sFpTINtOwP7SEnaeEG3O4txGnX+lJzV0/KuuIQwVVA9I1r5yIu5nuJT0OAMWRxV
         1iR6ubKmUiWvwWeNT98GJleAnY5PqKPWkvuSMry3mKtTFcpb8dJYCm3w2FBe8YWuOUov
         MZu9pdi/FLojwJwF64/NJcI9fzfTmOwwdieu5vThEDcOFxPd8LdxjWesW9pxPpmgH+YB
         4czA==
X-Gm-Message-State: AGi0PuY0p/0RLwC06uzTSGBhgNBVM2gngQ7T85lqIYLx6+lbx2ucsXvo
        SjpcM5K4vV3uQ5vNqLxn3Q==
X-Google-Smtp-Source: APiQypKak97u52rwxgIVHGAGYeOCHRT1KhU4tTs3bXDA93ePG3IM2v3ZiF4m5A4F8yUEOh2ffsNKWA==
X-Received: by 2002:aca:3b07:: with SMTP id i7mr1750409oia.164.1588886713019;
        Thu, 07 May 2020 14:25:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n11sm1672004oij.21.2020.05.07.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:25:12 -0700 (PDT)
Received: (nullmailer pid 24945 invoked by uid 1000);
        Thu, 07 May 2020 21:25:11 -0000
Date:   Thu, 7 May 2020 16:25:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 09/12] dt-bindings: PCI: aardvark: Describe new
 properties
Message-ID: <20200507212511.GA24873@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-10-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-10-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:22 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> From: Marek Behún <marek.behun@nic.cz>
> 
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
