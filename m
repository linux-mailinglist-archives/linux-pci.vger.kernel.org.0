Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113DB446DC3
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhKFMBQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhKFMBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 08:01:16 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A93C061570
        for <linux-pci@vger.kernel.org>; Sat,  6 Nov 2021 04:58:35 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1B279300000A9;
        Sat,  6 Nov 2021 12:58:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0EF842ED390; Sat,  6 Nov 2021 12:58:31 +0100 (CET)
Date:   Sat, 6 Nov 2021 12:58:31 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Update BAR # and window messages
Message-ID: <20211106115831.GA7452@wunner.de>
References: <20211106112606.192563-1-puranjay12@gmail.com>
 <20211106112606.192563-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106112606.192563-2-puranjay12@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 06, 2021 at 04:56:05PM +0530, Puranjay Mohan wrote:
> +		switch (i) {
> +		case 0: return "BAR 0";
> +		case 1: return "BAR 1";
> +		case 2: return "BAR 2";
> +		case 3: return "BAR 3";
> +		case 4: return "BAR 4";
> +		case 5: return "BAR 5";
> +		case PCI_ROM_RESOURCE: return "ROM";
> +		#ifdef CONFIG_PCI_IOV
> +		case PCI_IOV_RESOURCES + 0: return "VF BAR 0";
> +		case PCI_IOV_RESOURCES + 1: return "VF BAR 1";
> +		case PCI_IOV_RESOURCES + 2: return "VF BAR 2";
> +		case PCI_IOV_RESOURCES + 3: return "VF BAR 3";
> +		case PCI_IOV_RESOURCES + 4: return "VF BAR 4";
> +		case PCI_IOV_RESOURCES + 5: return "VF BAR 5";
> +		#endif
> +		}

Use a static const array of char * instead of a switch/case ladder
to reduce LoC count and improve performance.

See pcie_to_hpx3_type[] or state_conv[] in drivers/pci/pci-acpi.c
for an example.

Thanks,

Lukas
