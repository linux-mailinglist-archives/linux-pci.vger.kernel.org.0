Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357D8410D98
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhISWIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Sep 2021 18:08:25 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:38511 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233170AbhISWIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Sep 2021 18:08:21 -0400
X-Greylist: delayed 3828 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 18:08:19 EDT
Received: from [77.244.183.192] (port=65316 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mS3xn-00BOKz-4D; Sun, 19 Sep 2021 23:03:03 +0200
Subject: Re: [PATCH v2 0/4] PCI: dwc: pci-dra7xx: miscellaneous improvements
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
 <20210621144109.GC27516@lpieralisi> <20210813155328.GC15515@lpieralisi>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <46422460-ae9b-3c04-1f59-54bb6631317e@lucaceresoli.net>
Date:   Sun, 19 Sep 2021 23:03:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813155328.GC15515@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Kishon,

On 13/08/21 17:53, Lorenzo Pieralisi wrote:
> On Mon, Jun 21, 2021 at 03:41:09PM +0100, Lorenzo Pieralisi wrote:
>> On Mon, May 31, 2021 at 10:59:30AM +0200, Luca Ceresoli wrote:
>>> This is an series of mixed improvements to the DRA7 PCI controller driver:
>>> allow building as a loadabel module, allow to get and enable a clock and a
>>> small cleanup.
>>>
>>> Luca
>>>
>>> Luca Ceresoli (4):
>>>   PCI: dwc: Export more symbols to allow modular drivers
>>>   PCI: dra7xx: Make it a kernel module
>>>   PCI: dra7xx: Remove unused include
>>>   PCI: dra7xx: Get an optional clock
>>>
>>>  drivers/pci/controller/dwc/Kconfig            |  6 ++---
>>>  drivers/pci/controller/dwc/pci-dra7xx.c       | 22 +++++++++++++++++--
>>>  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
>>>  drivers/pci/controller/dwc/pcie-designware.c  |  1 +
>>>  4 files changed, 25 insertions(+), 5 deletions(-)
>>
>> Hi Kishon,
>>
>> I'd need your ACK to proceed with this series that looks like it
>> is ready to go, please let me know.
> 
> Still need it - please let me know.
> 
> Lorenzo

Should I resend the series?

BTW it still applies cleanly on both the pci next branch and on mainline
master.

-- 
Luca
