Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01B989270
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHKQH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 12:07:58 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:34617 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKQH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 12:07:58 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7D1E330000CC0;
        Sun, 11 Aug 2019 18:07:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 56D1C22B01A; Sun, 11 Aug 2019 18:07:55 +0200 (CEST)
Date:   Sun, 11 Aug 2019 18:07:55 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly
 set LED indicators
Message-ID: <20190811160755.w2jpcqt2powdcz7q@wunner.de>
References: <20190811132945.12426-1-efremov@linux.com>
 <20190811132945.12426-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811132945.12426-2-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 04:29:42PM +0300, Denis Efremov wrote:
> This commit adds pciehp_set_indicators() to set power and attention

Nit:  "This commit ..." is superfluous, just say "Add ...".


> indicators with a single register write. enum pciehp_indicator
> introduced to switch between the indicators statuses. Attention
> indicator statuses are explicitly set with values in the enum to
> transparently comply with pciehp_set_attention_status() from
> pciehp_hpc.c and set_attention_status() from pciehp_core.c

Please document the motivation of the change (the "why").

One motivation might be to avoid waiting twice for Command Complete.

Another motivation might be to change both LEDs at the same time
in a glitch-free manner, thereby achieving a smoother user experience.


> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> +enum pciehp_indicator {
> +	// Explicit values to match set_attention_status interface

Kernel coding style is typically /* */, not //.


> +	ATTN_NONE = -1,
> +	ATTN_OFF = 0,
> +	ATTN_ON = 1,
> +	ATTN_BLINK = 2,
> +	PWR_NONE,
> +	PWR_OFF,
> +	PWR_ON,
> +	PWR_BLINK
> +};

I'd suggest using the same values that are written to the register, i.e.:

enum pciehp_indicator {
	ATTN_NONE  = -1,
	ATTN_ON    =  1,
	ATTN_BLINK =  2,
	ATTN_OFF   =  3,
	PWR_NONE   = -1,
	PWR_ON     =  1,
	PWR_BLINK  =  2,
	PWR_OFF    =  3,
};

Then you can just shift the values to the proper offset and don't need
a translation between enum pciehp_indicator and register value.


> +void pciehp_set_indicators(struct controller *ctrl,
> +			   enum pciehp_indicator pwr,
> +			   enum pciehp_indicator attn)
> +{
> +	u16 cmd = 0;
> +	bool pwr_none = (pwr == PWR_NONE);
> +	bool attn_none = (attn == ATTN_NONE);
> +	bool pwr_led = PWR_LED(ctrl);
> +	bool attn_led = ATTN_LED(ctrl);
> +
> +	if ((!pwr_led && !attn_led) || (pwr_none && attn_none) ||
> +	    (!attn_led && pwr_none) || (!pwr_led && attn_none))
> +		return;

I'd suggest the following simpler construct:

	if (!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
	    !ATTN_LED(ctrl) || attn == ATTN_NONE))
		return;


> +	switch (pwr) {
> +	case PWR_OFF:
> +		cmd = PCI_EXP_SLTCTL_PWR_IND_OFF;
> +		break;
> +	case PWR_ON:
> +		cmd = PCI_EXP_SLTCTL_PWR_IND_ON;
> +		break;
> +	case PWR_BLINK:
> +		cmd = PCI_EXP_SLTCTL_PWR_IND_BLINK;
> +		break;
> +	default:
> +		break;
> +	}

If you follow my suggestion above to use the register value for "pwr",
then you can just fold all three cases into one, i.e.

	case PWR_ON:
	case PWR_BLINK:
	case PWR_OFF:
		cmd = pwr << 8;
		mask |= PCI_EXP_SLTCTL_PIC;
		break;

Feel free to add a PCI_EXP_SLTCTL_PWR_IND_OFFSET macro for the offset 8.
Add a "u16 mask = 0" to the top of the function and pass "mask" to
pcie_write_cmd_nowait().

Thanks,

Lukas
