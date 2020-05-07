Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6B1C9CFD
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEGVKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:10:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38001 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:10:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id r66so6525706oie.5;
        Thu, 07 May 2020 14:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vOJAT5al1D5jfLK3KCZe+EiKaiKoKpmEc2pvPJsPSMI=;
        b=Z2hHdYFTCOCunFIh8PZ1MiclTsSpNzzJeSfr2gnLT/Nwumc+K0vDpSJYVVhTbG44tL
         x0weV1osoeDSUDY/Szfmyj5cFBUuP5P6N+aoFlz9YxgA1LSdnbxm+SGnLfCrQh2A8tsf
         PVrbMHUXWfWtj8QypCcvVH/Cq2rzhBkG6kUolLuJLo7jf0U/xjsOcgrBHTlQRzf65pQK
         RFLtCsf+WvHy9oTX1BzVgUu1KAMpbcApbppSFTaANNwgzjCvkba++DRbtRBsO0SzTaZ0
         awaOzkvqU+BpHGQMvelEGgHNatPielw7hLZ6XKUhqva2HwDkVrNxLlEkOGmDUu4B24y5
         NSTA==
X-Gm-Message-State: AGi0PuaKrUh+K1bFcEP5xhGoMM2Azvo84C3BuzESmQf0S8TEIbmkDc6k
        MOwOXSiTYawkAs9wXEuxSDKfUrU=
X-Google-Smtp-Source: APiQypKC8n4GIaDfFsylvmEQK/cN0izFWrgqXOZf1olkbDe/mTybNEvl2zkbWwcKLeEyl0uWqLvP3Q==
X-Received: by 2002:aca:f454:: with SMTP id s81mr7657610oih.138.1588885817620;
        Thu, 07 May 2020 14:10:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p13sm1735241oom.34.2020.05.07.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:10:17 -0700 (PDT)
Received: (nullmailer pid 32069 invoked by uid 1000);
        Thu, 07 May 2020 21:10:15 -0000
Date:   Thu, 7 May 2020 16:10:15 -0500
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
Subject: Re: [PATCH v4 04/12] PCI: aardvark: Improve link training
Message-ID: <20200507211015.GA31477@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-5-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:17 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> From: Marek Behún <marek.behun@nic.cz>
> 
> Currently the aardvark driver trains link in PCIe gen2 mode. This may
> cause some buggy gen1 cards (such as Compex WLE900VX) to be unstable or
> even not detected. Moreover when ASPM code tries to retrain link second
> time, these cards may stop responding and link goes down. If gen1 is
> used this does not happen.
> 
> Unconditionally forcing gen1 is not a good solution since it may have
> performance impact on gen2 cards.
> 
> To overcome this, read 'max-link-speed' property (as defined in PCI
> device tree bindings) and use this as max gen mode. Then iteratively try
> link training at this mode or lower until successful. After successful
> link training choose final controller gen based on Negotiated Link Speed
> from Link Status register, which should match card speed.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> ---
>  drivers/pci/controller/pci-aardvark.c | 114 ++++++++++++++++++++------
>  1 file changed, 89 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
