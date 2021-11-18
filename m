Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E74456496
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 21:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhKRVBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 16:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhKRVBT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Nov 2021 16:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58560613A3;
        Thu, 18 Nov 2021 20:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637269098;
        bh=/xt+uXa7glCQc4NoV8PVvEQVFQeQykCNInRgbr3iJxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W40RlW9A3DG5IR7234eCb49osgoPdyWqFY0IIxPdDFMWlZIidG8J98/0YJrQZ+3DM
         2jI/eGwsASssjMFkMNTK5cmWfV83leADZtO48iF9IHxYLBvvwQVOQOIqJ5eiI7AV+P
         /iPohx0AObaKf5rK26R9YXOnChBh/BV2+tKfEycdHo+tSPBxQ214A4IGmyr1qDTPeH
         DqdF9/y/Bhs0xIktNREy61AZodRuHuvPAaAjsNWgOEr8Y5jI5PoNUp+S8/tDLz+QRq
         RLXVHG2nVna4TYevQ2myx5tFc61sNOmXW45wa/pRSTB4tmKV9buFwqtJAjawhsaDUm
         OTrzf7U4kjvPA==
Date:   Thu, 18 Nov 2021 14:58:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 18/19] mxser: move ids from pci_ids.h here
Message-ID: <20211118205816.GA1883757@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118073125.12283-19-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 08:31:24AM +0100, Jiri Slaby wrote:
> There is no point having MOXA PCI device IDs in include/linux/pci_ids.h.
> Move them to the driver and sort them all by the ID.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I would capitalize "IDs" in the subject as you did in the commit log.

> ---
>  drivers/tty/mxser.c     | 20 +++++++++++++++++++-
>  include/linux/pci_ids.h | 18 ------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index f6842089459a..ba96ffed193a 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -159,14 +159,32 @@
>  #define MXSER_BAUD_BASE		921600
>  #define MXSER_CUSTOM_DIVISOR	(MXSER_BAUD_BASE * 16)
>  
> +#define PCI_DEVICE_ID_MOXA_RC7000	0x0001
> +#define PCI_DEVICE_ID_MOXA_CP102	0x1020
> +#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
> +#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
> +#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
> +#define PCI_DEVICE_ID_MOXA_C104		0x1040
> +#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
> +#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
> +#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
>  #define PCI_DEVICE_ID_MOXA_POS104UL	0x1044
>  #define PCI_DEVICE_ID_MOXA_CB108	0x1080
> -#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
>  #define PCI_DEVICE_ID_MOXA_CP112UL	0x1120
> +#define PCI_DEVICE_ID_MOXA_CT114	0x1140
> +#define PCI_DEVICE_ID_MOXA_CP114	0x1141
>  #define PCI_DEVICE_ID_MOXA_CB114	0x1142
>  #define PCI_DEVICE_ID_MOXA_CP114UL	0x1143
> +#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
> +#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
> +#define PCI_DEVICE_ID_MOXA_CP132	0x1320
> +#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
> +#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
>  #define PCI_DEVICE_ID_MOXA_CB134I	0x1341
>  #define PCI_DEVICE_ID_MOXA_CP138U	0x1380
> +#define PCI_DEVICE_ID_MOXA_C168		0x1680
> +#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
> +#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
>  
>  #define MXSER_NPORTS(ddata)		((ddata) & 0xffU)
>  #define MXSER_HIGHBAUD			0x0100
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b5248f27910e..86678588d191 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1965,24 +1965,6 @@
>  #define PCI_DEVICE_ID_APPLICOM_PCI2000PFB 0x0003
>  
>  #define PCI_VENDOR_ID_MOXA		0x1393
> -#define PCI_DEVICE_ID_MOXA_RC7000	0x0001
> -#define PCI_DEVICE_ID_MOXA_CP102	0x1020
> -#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
> -#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
> -#define PCI_DEVICE_ID_MOXA_C104		0x1040
> -#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
> -#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
> -#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
> -#define PCI_DEVICE_ID_MOXA_CT114	0x1140
> -#define PCI_DEVICE_ID_MOXA_CP114	0x1141
> -#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
> -#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
> -#define PCI_DEVICE_ID_MOXA_CP132	0x1320
> -#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
> -#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
> -#define PCI_DEVICE_ID_MOXA_C168		0x1680
> -#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
> -#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
>  #define PCI_DEVICE_ID_MOXA_CP204J	0x2040
>  #define PCI_DEVICE_ID_MOXA_C218		0x2180
>  #define PCI_DEVICE_ID_MOXA_C320		0x3200
> -- 
> 2.33.1
> 
