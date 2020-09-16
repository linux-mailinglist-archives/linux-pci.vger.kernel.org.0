Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD526CB00
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIPUPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 16:15:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36201 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgIPRb0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 13:31:26 -0400
Received: by mail-io1-f65.google.com with SMTP id d190so9196145iof.3;
        Wed, 16 Sep 2020 10:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRfR+j/sNQ41ZakQMoWnaCWXgTz86aIdAqvmzFe7k6U=;
        b=Pl/9emcwe2Gq/XqcPgJBcuiBmmm8IpohY6+crb6MMgl6zkhc3w/NY724CbpStYMAPh
         xFS1yiifMaP8R3Kzlpn3e9zMCI0CKd9qcKg6mKJMr1MI+sM2K+rBuGkFWn2dcpEP0dbm
         vzw81fhr2iMDoWDXQVwypJKJqXTUnbVjMVS04scOV6y/wUhV3Q/T9+idmEGHvAZQcYkD
         j+uUsvFeENCtTZhs6BC/frWOKHmJ7hEa2Q+Xt7n3M/e2bIw4acmuzuegRQaQP3/LJ+8B
         +30QTARQK8UPj3dUUDjXnKSpUS44KxWxIkP75abqSrfyXHHjrUvb7SvaRfLPGfQx62WY
         cNOw==
X-Gm-Message-State: AOAM533ZXZTcLCZPTbXjcciwZbV65+aJnEmZC+1Nk4H154jARGFcMAow
        FEJr1gMjGivVDRLIEGqhFp3dqlrL4mdk
X-Google-Smtp-Source: ABdhPJw861X0s+rWKu+n7ODsTpzYArU/ffDgC8RCudwa/a457zJcb/q+UMAaqhqvZkgl16raeuGE0A==
X-Received: by 2002:a05:6e02:e4e:: with SMTP id l14mr20856786ilk.10.1600269976645;
        Wed, 16 Sep 2020 08:26:16 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z26sm11180566ilf.60.2020.09.16.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:26:15 -0700 (PDT)
Received: (nullmailer pid 3997242 invoked by uid 1000);
        Wed, 16 Sep 2020 15:26:14 -0000
Date:   Wed, 16 Sep 2020 09:26:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 06/10] PCI: brcmstb: Add control of rescal reset
Message-ID: <20200916152614.GA3995498@bogus>
References: <20200911175232.19016-1-james.quinlan@broadcom.com>
 <20200911175232.19016-7-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911175232.19016-7-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 01:52:26PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Some STB chips have a special purpose reset controller named RESCAL (reset
> calibration).  The PCIe HW can now control RESCAL to start and stop its
> operation.  On probe(), the RESCAL is deasserted and the driver goes
> through the sequence of setting registers and reading status in order to
> start the internal PHY that is required for the PCIe.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 69 ++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
