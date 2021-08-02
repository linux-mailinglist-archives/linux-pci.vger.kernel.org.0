Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556033DDFE9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHBTRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 15:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhHBTRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Aug 2021 15:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627931827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHGFvKKCAQcBk8UJyECw5jIieBwTPrV0mdrpqVRc1IQ=;
        b=B9Hn72fgb82iEJ2CAahaLJfhKLDUompWtFGTXIfmUkpbRh0jzWQhDwdBFDsyLYUaa56VT6
        PLG7US2LT9/1m3kyInbJ3N0cYylH2Opjnn1cPZq3zBOwJVySppAF5koMUUT+OB9hTywDbi
        ago4TG7VYOH5+4R5TNDQ+WUeBzN+7YA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--c4gvc65NnCMBC6srU7N1g-1; Mon, 02 Aug 2021 15:17:06 -0400
X-MC-Unique: -c4gvc65NnCMBC6srU7N1g-1
Received: by mail-ot1-f72.google.com with SMTP id z13-20020a9d71cd0000b02904d2c9963aa2so8554914otj.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Aug 2021 12:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHGFvKKCAQcBk8UJyECw5jIieBwTPrV0mdrpqVRc1IQ=;
        b=LLDq8KKbscJUIi73xbOqloBmIzFWpLNLAT79hQA1EdpyZRfq4tCVvxhVKq4+6wHIQ8
         68EBPiEW53wbb0nDh12L+ScubhrkqG+kBbJylSKWzPXJ9ErrglCheRu0gggswtzShA9j
         gdcAOq8U3kxHq/zefZvgYEVdv/uioMVvub1AEWrwrr5B59k0GNJ/CP/+tvPfj0WkLsws
         M6L00ENw38TjBPkAn5NXHLnwk/X7JSSDGq3I0fDYC6lHIxd+P/sUDmk2cFjrhOvWZKO4
         Q2MJmKBKui8QSL0K087JYKJlymku4jewIC4HgUdr2QGxy+ijuJm+NsW5OjsZOBPooHlN
         6cHw==
X-Gm-Message-State: AOAM532b4pG+OXWmr+QlbcXRbegFPqLwrkoCv106r5NKfxjSpARjlwCZ
        UIngqtS8XUKlP/apsOw+D7OzvfuVPDmPzdFrzZr2W8+9NNW8MmyNkNvROQ0jXklgKWFZeqsgdIm
        vP5UycSWtstg7zTD5Hbs/
X-Received: by 2002:aca:2403:: with SMTP id n3mr11934240oic.109.1627931825445;
        Mon, 02 Aug 2021 12:17:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmBQ8/3nb4T/W0lb0KixselAL/jHSzE7IBpWlR0UUbZ4RQrBPf8aSBZiczw/wJteigOdObKQ==
X-Received: by 2002:aca:2403:: with SMTP id n3mr11934232oic.109.1627931825245;
        Mon, 02 Aug 2021 12:17:05 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id c11sm2037735otm.37.2021.08.02.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:17:04 -0700 (PDT)
Date:   Mon, 2 Aug 2021 13:17:04 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Make pci_cap_saved_state private to core
Message-ID: <20210802131704.0a212f89.alex.williamson@redhat.com>
In-Reply-To: <20210728231447.869117-1-helgaas@kernel.org>
References: <20210728231447.869117-1-helgaas@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Jul 2021 18:14:47 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> struct pci_cap_saved_data and struct pci_cap_saved_state were declared in
> include/linux/pci.h, but aren't needed outside drivers/pci/.  Move them to
> drivers/pci/pci.h.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h   | 17 +++++++++++++++--
>  include/linux/pci.h | 12 ------------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 93dcdd431072..ab5a989e6580 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -37,6 +37,21 @@ int pci_probe_reset_function(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  
> +struct pci_cap_saved_data {
> +	u16		cap_nr;
> +	bool		cap_extended;
> +	unsigned int	size;
> +	u32		data[];
> +};
> +
> +struct pci_cap_saved_state {
> +	struct hlist_node		next;
> +	struct pci_cap_saved_data	cap;
> +};
> +
> +void pci_allocate_cap_save_buffers(struct pci_dev *dev);
> +void pci_free_cap_save_buffers(struct pci_dev *dev);
> +
>  #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
>  #define PCI_PM_D3HOT_WAIT       10	/* msec */
>  #define PCI_PM_D3COLD_WAIT      100	/* msec */
> @@ -100,8 +115,6 @@ void pci_pm_init(struct pci_dev *dev);
>  void pci_ea_init(struct pci_dev *dev);
>  void pci_msi_init(struct pci_dev *dev);
>  void pci_msix_init(struct pci_dev *dev);
> -void pci_allocate_cap_save_buffers(struct pci_dev *dev);
> -void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..2ceeb5e9f28a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -288,18 +288,6 @@ enum pci_bus_speed {
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>  
> -struct pci_cap_saved_data {
> -	u16		cap_nr;
> -	bool		cap_extended;
> -	unsigned int	size;
> -	u32		data[];
> -};
> -
> -struct pci_cap_saved_state {
> -	struct hlist_node		next;
> -	struct pci_cap_saved_data	cap;
> -};
> -
>  struct irq_affinity;
>  struct pcie_link_state;
>  struct pci_vpd;


Do you want to move these from include/linux/pci.h as well?

struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap);

Thanks,
Alex

