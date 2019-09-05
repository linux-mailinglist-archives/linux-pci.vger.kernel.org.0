Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADBAAE2F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 00:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfIEWD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 18:03:29 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:34171 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfIEWD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 18:03:29 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A86CC100B00EC;
        Fri,  6 Sep 2019 00:03:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 64A0330C9DE; Fri,  6 Sep 2019 00:03:27 +0200 (CEST)
Date:   Fri, 6 Sep 2019 00:03:27 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Simplify PCIe hotplug indicator control
Message-ID: <20190905220327.poa6sknhei6tj47v@wunner.de>
References: <20190903111021.1559-1-efremov@linux.com>
 <20190905210102.GG103977@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905210102.GG103977@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 04:01:02PM -0500, Bjorn Helgaas wrote:
>  void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
>  {
>  	u16 cmd = 0, mask = 0;
>  
> -	if (PWR_LED(ctrl) && pwr > 0) {
> -		cmd |= pwr;
> +	if (PWR_LED(ctrl) && pwr != INDICATOR_NOOP) {
> +		cmd |= (pwr & PCI_EXP_SLTCTL_PIC);
>  		mask |= PCI_EXP_SLTCTL_PIC;
>  	}
>  
> -	if (ATTN_LED(ctrl) && attn > 0) {
> -		cmd |= attn;
> +	if (ATTN_LED(ctrl) && attn != INDICATOR_NOOP) {
> +		cmd |= (attn & PCI_EXP_SLTCTL_AIC);
>  		mask |= PCI_EXP_SLTCTL_AIC;
>  	}

There's a subtle issue here:  A value of "0" is "reserved" per PCIe r4.0,
sec 7.8.10.  Denis filtered that out, with your change it's an accepted
value.  I don't think the function ever gets called with a value of "0",
so it's not a big deal.  And maybe we don't even want to filter that
value out.  Just noting anyway.

Thanks,

Lukas
