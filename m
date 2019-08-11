Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7F89319
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 20:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfHKS0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 14:26:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36135 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKS0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 14:26:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so48621554pfl.3;
        Sun, 11 Aug 2019 11:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvBS7LnbEXRKBr+Vk2OxA3lSCuWdQHXP5Oy5elpb9AU=;
        b=lkmqFNrpGYqJoGAUzPYlURHNmhONCjOcA3zxL1y+ZJh4aLLst6aoB1GR7oqTEpX/sx
         dMJtqmsNTvy8TXsLRcUKB05cw8uD94B917Py9i9tXJohvgz/YgHDduBdk+gS+6qnKRjc
         b1v4xg+UAwa2HmGpvhSyxoRzaXbz7feF/ulaGP7MTgyZzy2OmqROrsavJ5CeuluXfL6T
         F+vYFz9J8vpUpxR14kIPesRrPjzjKYwmx727JTr3sHed9LjML+1sgEC+VlrMf1+/ke1J
         X/wARI3QJPd+tE7Y0TRTt1OQV0LDhQ+1YRBgeOvl933JIYmO7ADYh8wsyihYTuOoB0pY
         Nn+g==
X-Gm-Message-State: APjAAAVGr1ojjiuLTcpzhKu2zYMwVeIP5NinJd0dD8lKAc4H7MVtdyuu
        OEBkPg1VBeergbZDx2rvqpUnmQsrYKw=
X-Google-Smtp-Source: APXvYqzCX24eHkmxeM6dWX3x43XOL79S+1CVVkfVooXjwTZKpysXWMkGY3TB3bvT3jj9naxjtyfeYg==
X-Received: by 2002:a65:6096:: with SMTP id t22mr26462796pgu.204.1565547998514;
        Sun, 11 Aug 2019 11:26:38 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id o130sm168437424pfg.171.2019.08.11.11.26.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:26:37 -0700 (PDT)
Subject: Re: [PATCH 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly
 set LED indicators
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811132945.12426-1-efremov@linux.com>
 <20190811132945.12426-2-efremov@linux.com>
 <20190811160755.w2jpcqt2powdcz7q@wunner.de>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <81c06549-6076-b230-9c6b-64b07a2bb509@linux.com>
Date:   Sun, 11 Aug 2019 21:26:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811160755.w2jpcqt2powdcz7q@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you for the review, I will send v2.

On 11.08.2019 19:07, Lukas Wunner wrote:
> On Sun, Aug 11, 2019 at 04:29:42PM +0300, Denis Efremov wrote:
>> This commit adds pciehp_set_indicators() to set power and attention
> 
> Nit:  "This commit ..." is superfluous, just say "Add ...".
> 
> 
>> indicators with a single register write. enum pciehp_indicator
>> introduced to switch between the indicators statuses. Attention
>> indicator statuses are explicitly set with values in the enum to
>> transparently comply with pciehp_set_attention_status() from
>> pciehp_hpc.c and set_attention_status() from pciehp_core.c
> 
> Please document the motivation of the change (the "why").
> 
> One motivation might be to avoid waiting twice for Command Complete.
> 
> Another motivation might be to change both LEDs at the same time
> in a glitch-free manner, thereby achieving a smoother user experience.
> 
> 
>> --- a/drivers/pci/hotplug/pciehp.h
>> +++ b/drivers/pci/hotplug/pciehp.h
>> +enum pciehp_indicator {
>> +	// Explicit values to match set_attention_status interface
> 
> Kernel coding style is typically /* */, not //.
> 
> 
>> +	ATTN_NONE = -1,
>> +	ATTN_OFF = 0,
>> +	ATTN_ON = 1,
>> +	ATTN_BLINK = 2,
>> +	PWR_NONE,
>> +	PWR_OFF,
>> +	PWR_ON,
>> +	PWR_BLINK
>> +};
> 
> I'd suggest using the same values that are written to the register, i.e.:
> 
> enum pciehp_indicator {
> 	ATTN_NONE  = -1,
> 	ATTN_ON    =  1,
> 	ATTN_BLINK =  2,
> 	ATTN_OFF   =  3,
> 	PWR_NONE   = -1,
> 	PWR_ON     =  1,
> 	PWR_BLINK  =  2,
> 	PWR_OFF    =  3,
> };
> 
> Then you can just shift the values to the proper offset and don't need
> a translation between enum pciehp_indicator and register value.
> 
> 
>> +void pciehp_set_indicators(struct controller *ctrl,
>> +			   enum pciehp_indicator pwr,
>> +			   enum pciehp_indicator attn)
>> +{
>> +	u16 cmd = 0;
>> +	bool pwr_none = (pwr == PWR_NONE);
>> +	bool attn_none = (attn == ATTN_NONE);
>> +	bool pwr_led = PWR_LED(ctrl);
>> +	bool attn_led = ATTN_LED(ctrl);
>> +
>> +	if ((!pwr_led && !attn_led) || (pwr_none && attn_none) ||
>> +	    (!attn_led && pwr_none) || (!pwr_led && attn_none))
>> +		return;
> 
> I'd suggest the following simpler construct:
> 
> 	if (!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
> 	    !ATTN_LED(ctrl) || attn == ATTN_NONE))
> 		return;
> 
> 
>> +	switch (pwr) {
>> +	case PWR_OFF:
>> +		cmd = PCI_EXP_SLTCTL_PWR_IND_OFF;
>> +		break;
>> +	case PWR_ON:
>> +		cmd = PCI_EXP_SLTCTL_PWR_IND_ON;
>> +		break;
>> +	case PWR_BLINK:
>> +		cmd = PCI_EXP_SLTCTL_PWR_IND_BLINK;
>> +		break;
>> +	default:
>> +		break;
>> +	}
> 
> If you follow my suggestion above to use the register value for "pwr",
> then you can just fold all three cases into one, i.e.
> 
> 	case PWR_ON:
> 	case PWR_BLINK:
> 	case PWR_OFF:
> 		cmd = pwr << 8;
> 		mask |= PCI_EXP_SLTCTL_PIC;
> 		break;
> 
> Feel free to add a PCI_EXP_SLTCTL_PWR_IND_OFFSET macro for the offset 8.
> Add a "u16 mask = 0" to the top of the function and pass "mask" to
> pcie_write_cmd_nowait().
> 
> Thanks,
> 
> Lukas
> 
