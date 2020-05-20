Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A41DC174
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgETVg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 17:36:28 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46712 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgETVg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 17:36:28 -0400
Received: by mail-il1-f196.google.com with SMTP id w18so4818142ilm.13;
        Wed, 20 May 2020 14:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8T4g3GB0lWcH8xbCNMCDr7nb5rGktxITHYP2LXpYD7U=;
        b=fHp3Rm78Y4sM2pPVFXIH36Be3VSR1LsRH1Qf0LvJU0M6GsnBCFqUvGIa0bSXsYETd9
         P1yKWp3oTrsqQI8XIrVP8UTh5lfSdR5Sk/3hqZW3dLXMf/frOIubyCHwCTrOqS8c4yci
         +i+JCc+p1q1z+nf+UquYCbVu+mDxTiCtzrTijv787iavYe2SzvOPx1uNeK2wABRC2Kh4
         w+Zfohx4I60F3J+3jNPikK7Xek4SE27cXgIT0bSLi6RhTACJrAcOhvuP86XuMjwgjkTn
         42Q0C83Sl/lSoHfkphLWvEufOIViJLRPF6xCqcOxmfmfN2yuA4ajxQRZFr+je9xo1cJg
         ofLQ==
X-Gm-Message-State: AOAM531H88jzM5glLABPHBDAWfeDRfzQxGJFKixfpIVfH8GxFNcRAUJP
        HV0qi9Qq94Lo1K+r8wO6Mg==
X-Google-Smtp-Source: ABdhPJzV5M0ADtcekTIkjw5B3x+zFszJSje5GETuQ1ENBcHHP7QvRIraFBSdGvUoBihkMjoJKyqrIw==
X-Received: by 2002:a92:8989:: with SMTP id w9mr5962127ilk.70.1590010587012;
        Wed, 20 May 2020 14:36:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c7sm1977822ilf.36.2020.05.20.14.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 14:36:26 -0700 (PDT)
Received: (nullmailer pid 636061 invoked by uid 1000);
        Wed, 20 May 2020 21:36:25 -0000
Date:   Wed, 20 May 2020 15:36:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 08/14] PCI: cadence: Fix updating Vendor ID and
 Subsystem Vendor ID register
Message-ID: <20200520213625.GA633506@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-9-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 08:44:23PM +0530, Kishon Vijay Abraham I wrote:
> Commit 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe
> controller") in order to update Vendor ID, directly wrote to
> PCI_VENDOR_ID register. However PCI_VENDOR_ID in root port configuration
> space is read-only register and writing to it will have no effect.
> Use local management register to configure Vendor ID and Subsystem Vendor
> ID.
> 
> Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")

Fixes should come first.

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
