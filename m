Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4042CF025A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 17:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbfKEQJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 11:09:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390035AbfKEQJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 11:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zYj73f1UT7gOij9GCCcNrorE4sfMx2ngwu5XUOipz28=; b=icIN7PqFV7lEMwnaLNKG7bxBF
        D3oYIWzLqeG4iMGvdsbIM2GeR9041rEZBJiqBPeznRMvwpUeOWEgaCnyAZ6A66J5qZws2AGah9rke
        x4sP8yJLok3HX448lZB7ah2qcA7SZWua53CWYlhSAH1KhCdwPti+ikajFdRD+HeNU5Hwvx+8RfHWf
        yQtCuFLP5wBsKI8iz55oSNtq0pQmmcyXgFZS3eKUF1Tnwn810bw0yVCGxJZ7AQRh2g1GBg0TgdaT2
        SGimOUiWNsppaBBdQVAQKftbxcec2ULbOy/DjnG8PGBbdR5y8igtL3GemlMDBIXPFuo6MYFKrQpQ5
        tEvuJmxyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iS1Op-0005lQ-NQ; Tue, 05 Nov 2019 16:09:43 +0000
Date:   Tue, 5 Nov 2019 08:09:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 5/5] PCI: PM: Fold __pci_complete_power_transition() into
 its caller
Message-ID: <20191105160943.GA19190@infradead.org>
References: <2771503.n70vfTtcVb@kreacher>
 <1769241.yKxyosiRnQ@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1769241.yKxyosiRnQ@kreacher>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 11:32:02AM +0100, Rafael J. Wysocki wrote:
>  	if (state > PCI_D3cold)
> @@ -1132,10 +1112,12 @@ int pci_set_power_state(struct pci_dev *
>  	error = pci_raw_set_power_state(dev, state > PCI_D3hot ?
>  					PCI_D3hot : state);
>  
> -	if (!__pci_complete_power_transition(dev, state))
> -		error = 0;
> +	ret = pci_platform_power_transition(dev, state);
> +	/* Powering off a bridge may power off the whole hierarchy */
> +	if (!ret && state == PCI_D3cold)
> +		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
>  
> -	return error;
> +	return ret ? error : 0;

Total nitpick, but why not:

	if (pci_platform_power_transition(dev, state))
		return error;

	/* Powering off a bridge may power off the whole hierarchy */
	if (state == PCI_D3cold)
		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
	return 0;

