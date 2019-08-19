Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54A94C06
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 19:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfHSRve (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 13:51:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfHSRve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 13:51:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C21A360;
        Mon, 19 Aug 2019 10:51:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98FC63F246;
        Mon, 19 Aug 2019 10:51:32 -0700 (PDT)
Date:   Mon, 19 Aug 2019 18:51:30 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, alisaidi@amazon.com, ronenk@amazon.com,
        barakw@amazon.com, talel@amazon.com, hanochu@amazon.com,
        hhhawa@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/8] PCI: Add Amazon's Annapurna Labs vendor ID
Message-ID: <20190819175130.GC23903@e119886-lin.cambridge.arm.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
 <20190723092529.11310-2-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723092529.11310-2-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 12:25:26PM +0300, Jonathan Chocron wrote:
> Add Amazon's Annapurna Labs vendor ID to pci_ids.h.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 40015609c4b5..63dfa4bace57 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2569,6 +2569,8 @@
>  
>  #define PCI_VENDOR_ID_ASMEDIA		0x1b21
>  
> +#define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
> +
>  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
>  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
>  

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.17.1
> 
