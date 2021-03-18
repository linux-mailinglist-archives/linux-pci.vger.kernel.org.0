Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E50340901
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 16:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhCRPg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 11:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231785AbhCRPf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 11:35:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 397A664EF2;
        Thu, 18 Mar 2021 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616081758;
        bh=cUyS1KCt86QY6jQM5lfc60E73sd0HWmMcMbuyehISWE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ffqLNJKrozOTvGHJYyZmr8YUjPNcKHqC07wDchHX+pD/UfVUmAVVB1MDwO9toHRnD
         9xF7/005g01U82NUMjAS6BOmG6FlPCZNpltdA/gXPYpJkXXP5px7o/SQHWs9hMfGSY
         9OT8B2V9qCUu3YZGL0b3OTp07HP1LklAzYKODfSna04drclkbMRkkARB3vDHk/o5WQ
         xVoh0DevZP3fxCUnIUwvysxYBQxim/f3eKydpAVW6I8ywnR6c+06phk/lgiRBWM/ZF
         6Vj7h7dCJ2hWbuUrySfzveDFiW+klojit7dp85qUw2OsjR6gy2D6oBdKCz9gEFRRN0
         BAD4vC//7x/jw==
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
 <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
 <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
 <CAC41dw_BJBMdwyccdvWNZsdAzzh7ko=q4oSpQXo-jJDTfQGkZw@mail.gmail.com>
 <20210317190151.GA27146@wunner.de>
 <0a020128-80e8-76a7-6b94-e165d3c6f778@linux.intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <1069dc19-35ac-be1a-b02a-3815503cb295@kernel.org>
Date:   Thu, 18 Mar 2021 11:35:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0a020128-80e8-76a7-6b94-e165d3c6f778@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/2021 4:02 PM, Kuppuswamy, Sathyanarayanan wrote:
> My point is, there is no race in OS handlers (pciehp_ist() vs
> pcie_do_recovery())
>  However, Sinan wrote in
>> 2018 that one of the issues with hotplug versus DPC is that pciehp
>> may turn off slot power and thereby foil DPC recovery.  (Power off =
>> cold reset, whereas DPC recovery = warm reset.)  This can occur
>> as well if DPC is handled by firmware. 

It has been a while...

If I remember correctly, there is no race condition if the platform
handles DPC and HP interrupts on the same MSI vector.

If HP and DPC interrupts are handled as MSI-x interrupts, these can
fire out of order and can cause problems for each one.

I hope it helps.
