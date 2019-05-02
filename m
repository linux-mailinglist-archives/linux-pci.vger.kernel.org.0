Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A835116AF
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 11:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEBJmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 05:42:42 -0400
Received: from ns.iliad.fr ([212.27.33.1]:38882 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfEBJmm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 05:42:42 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0F33521186;
        Thu,  2 May 2019 11:42:40 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id EB2B120BAF;
        Thu,  2 May 2019 11:42:39 +0200 (CEST)
Subject: Re: [RFC PATCH v1] PCI: qcom: Use quirk to override incorrect device
 class
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <20190430140621.GB18742@e121166-lin.cambridge.arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <042b5c87-388f-3d61-de62-4c379bc23abb@free.fr>
Date:   Thu, 2 May 2019 11:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430140621.GB18742@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu May  2 11:42:40 2019 +0200 (CEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/04/2019 16:06, Lorenzo Pieralisi wrote:

> On Tue, Mar 12, 2019 at 06:34:55PM +0100, Marc Gonzalez wrote:
>
>> On 12/03/2019 18:18, Marc Gonzalez wrote:
>>
>>> On 12/03/2019 13:42, Stanimir Varbanov wrote:
>>>
>>>> I wonder, in case that dw_pcie_setup_rc() already has a write to
>>>> PCI_CLASS_DEVICE configuration register to set it as a bridge do we
>>>> still need to do the above fixup?
>>>
>>> I don't know, I don't have an affected device. Unless the msm8998 /is/ affected,
>>> and dw_pcie_setup_rc() actually fixes it?
>>
>> I think you hit the nail on the head...
>>
>> If I comment out
>> //dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>> from dw_pcie_setup_rc()
>> then pci_class() returns 0xff000000 instead of 0x6040000
>>
>> So perhaps you're right: the quirk can be omitted altogether.
>> Unless it is not possible to program the device class on older chips?
> 
> Marc,
> 
> I would drop this patch from the PCI queue since in a different
> form it was already merged, please let me know if I am wrong.

I'm confused because you speak of *dropping* this patch (v1) -- but v1 was never
picked up AFAIK.

You picked up v5 on March 29:
https://patchwork.kernel.org/patch/10869519/

I see it in linux-next as 915347f67d41857a514bed77053b212f3696e8a3

Will Bjorn send it to LT during the merge window for 5.2?

Regards.
