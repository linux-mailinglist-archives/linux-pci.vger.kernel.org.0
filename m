Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311331C9CE5
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGVDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:03:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42387 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:03:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so5755365otq.9;
        Thu, 07 May 2020 14:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VyDpqjFf92FEuiIHFMXtKbzqroXrkI/e2oOzUcuJwg4=;
        b=fOmxt45uhBJMbl+9BWI1OFrrwQaZVNOgdd+FjriV2PPDH/WR1nDNhX2guWuiSFgY58
         nVBHSVG/4rLZwWT3sby/2RZYEiT3Ed3iXTZfmPiqGRx5noHtcjYjLeWGhyLcbcxTEkVY
         zDbuCOW/Pbdu2prukh2s1cvIF/VlfE28mycBrI3x8O4PAHM2eaecPtxjv+nyVDRJQ5zc
         tVuHRBfQeFSq76jd2Qh2VUj+KAey3i2p4mbLRpCDPod5HwKVmBIBLshrA7DKZVycYYCJ
         vB007t/IIhN5AEl9YWRTMF4XV/4wd5Rpia6iImdjW0K07OoW666D8jlvbVAHqyhVWXQg
         fNLw==
X-Gm-Message-State: AGi0PuZiWMT6Fq/8lQk2e/tus3AbFDW/2nd670C4Gm9mAYTuPVs5Xwi9
        6DZ0T2mYlDlT3woIZ7nW5g==
X-Google-Smtp-Source: APiQypIvjGiPp77s+t3QROHzGlT5BlLPBuZkwM7E4Px8YsppOcYnIGj84LS8p2dt85sZiqhftDFgJg==
X-Received: by 2002:a9d:3785:: with SMTP id x5mr11888606otb.81.1588885396749;
        Thu, 07 May 2020 14:03:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm1645901ots.21.2020.05.07.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:03:16 -0700 (PDT)
Received: (nullmailer pid 19976 invoked by uid 1000);
        Thu, 07 May 2020 21:03:15 -0000
Date:   Thu, 7 May 2020 16:03:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: Re: [PATCH] PCI: amlogic: meson: Don't use FAST_LINK_MODE to set up
 link
Message-ID: <20200507210315.GA19547@bogus>
References: <20200429164230.309922-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429164230.309922-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 Apr 2020 17:42:30 +0100, Marc Zyngier wrote:
> My vim3l board stubbornly refuses to play ball with a bog
> standard PCIe switch (ASM1184e), spitting all kind of errors
> ranging from link never coming up to crazy things like downstream
> ports falling off the face of the planet.
> 
> Upon investigating how the PCIe RC is configured, I found the
> following nugget: the Sysnopsys DWC PCIe Reference Manual, in the
> section dedicated to the PLCR register, describes bit 7 (FAST_LINK_MODE)
> as:
> 
> "Sets all internal timers to fast mode for simulation purposes."
> 
> I completely understand the need for setting this bit from a simulation
> perspective, but what I have on my desk is actual silicon, which
> expects timers to have a nominal value (and I expect this is the
> case for most people).
> 
> Making sure the FAST_LINK_MODE bit is cleared when configuring the RC
> solves this problem.
> 
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
