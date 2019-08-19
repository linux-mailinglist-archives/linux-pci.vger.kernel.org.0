Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BDC94998
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHSQQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:16:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41143 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHSQQ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:16:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id w5so2195770edl.8;
        Mon, 19 Aug 2019 09:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nCCrj6RvVz1BVsp2AxHA5np6rFqq04zMJ69ByBhoj80=;
        b=MnY1xkLLt/6admbaiYa8aFLh6XUEsmjicep+cOnIPyvydqNWkKO6FVVOXkqPM/wMne
         9But3Kg0FlKPenLZRUK27jOztNf4lJVQm+vB/g1G4L/ayfGpaB4JO7b+YIoFnIF3cCT6
         cvGnGKtttNwQRUPa36gb8AON1Z7rCHVVV/cto5OunrtMbVvyMjj6PeoQPbtCPt6cADvG
         EcaxJuljxgFKcLBlqSCrrT37rY1q53x5THhRh2gCe28qUeXKpvTjOppzsbeLtD+1g8pt
         x0vKS5YNA6nUsJojfyn+EsiYg42SXoX16tEYVxcdAuvOev8JLTTh7fra3elEfWfJkLlr
         wxRw==
X-Gm-Message-State: APjAAAV4JoWSbSGCFIZEtJk66MxRi/AVnwJ1zKk64Sbhr02IIFp6OoMI
        kAhbaiEXs22vJA+ANHKvAuyTipBC
X-Google-Smtp-Source: APXvYqzJQmZX7Pqk6zpMWn+OkYu01h5EePIEitAWhbIXNFWc1Ert8SwkME401baaF0wQxgcqoy2K3A==
X-Received: by 2002:a17:907:2101:: with SMTP id qn1mr22259516ejb.3.1566231415418;
        Mon, 19 Aug 2019 09:16:55 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id t12sm2891678edw.40.2019.08.19.09.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 09:16:54 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v3 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190819160643.27998-1-efremov@linux.com>
 <20190819160643.27998-2-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <9cbb34b0-d6be-fbba-9992-9b6939018e5d@linux.com>
Date:   Mon, 19 Aug 2019 19:16:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819160643.27998-2-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/19/19 7:06 PM, Denis Efremov wrote:
> +		switch (pwr) {
> +		case PCI_EXP_SLTCTL_PWR_IND_ON:
> +		case PCI_EXP_SLTCTL_PWR_IND_BLINK:
> +		case PCI_EXP_SLTCTL_PWR_IND_OFF:
> +			cmd |= pwr;
> +			mask |= PCI_EXP_SLTCTL_PIC;
> +		}
> +

On 8/12/19 11:25 AM, sathyanarayanan kuppuswamy wrote:
> Do we need to switch case here ? if (pwr > 0) {} should work right ? 

I saved the switch here from v2. I think switch makes the inputs check more
precise and filters-out all non-valid values. Maybe this check is too strict?

We could use mask here ON|OFF|BLINK for the check, but I don't know how hardware
will handle a case, for example, pwr == ON|BLINK.

Thanks,
Denis
