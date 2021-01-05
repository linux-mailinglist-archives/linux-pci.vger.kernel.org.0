Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C42EAD2E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbhAEONR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 09:13:17 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:64328 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbhAEONQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 09:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=RA8bsF2IvtYDxK0HrjzycDJFsmr6rzurulhvIh6DFUY=;
        b=iGta+lS4esXb+HScA63qGOyG7p8U4fH6r69lNm057kM3oknpcdyN/f+iajEHK1I/AaYSSi1E14ORq
         pTWGC9A3YiIu2wWQPntY6NG2YEuGq9PQ45SynD5O8GCfBxpjQwzSPR+RpmcBIjbsyd+fQNPUFGkpYF
         bnifdXJmGBsF96ny/PLTAYTfsoKr0MN8G98ngH18ZLqIbIm04WaLnO+jVY4SGbqzQLeaPD1FeoOFwd
         bW0nu4L8WQZUbdRWVhpspzZMpEgQHoH/LMKwzhP6C7cFv2a3jShW0o44d/RNmegoJK7l2CL3Q2eMtW
         +4gzZ/SU5/juLIQEqDYWs8z/Wkes/GQ==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 0de8e8ad-4f60-11eb-93c8-005056a66d10;
        Tue, 05 Jan 2021 15:12:33 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 5 Jan 2021
 15:12:34 +0100
Subject: Re: [PATCH 3/3] PCI/ERR: Retain status from error notification
To:     Keith Busch <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201217171431.502030-1-kbusch@kernel.org>
 <20201217171431.502030-3-kbusch@kernel.org>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <637ad6ff-8a97-ab68-1fcc-eb5432f7ebbf@ess.eu>
Date:   Tue, 5 Jan 2021 15:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217171431.502030-3-kbusch@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: IT-Exch16-1.esss.lu.se (10.0.42.131) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/17/20 6:14 PM, Keith Busch wrote:
> Overwriting the frozen detected status with the result of the link reset
> loses the NEED_RESET result that drivers are depending on for error
> handling to report the .slot_reset() callback. Retain this status so
> that subsequent error handling has the correct flow.
> 
> Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/pci/pcie/err.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index a84f0bf4c1e2..b576aa890c76 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -198,8 +198,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	pci_dbg(bridge, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
>   		pci_walk_bridge(bridge, report_frozen_detected, &status);
> -		status = reset_subordinates(bridge);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
>   			pci_warn(bridge, "subordinate device reset failed\n");
>   			goto failed;
>   		}
> 

Dear Keith,

I can confirm that with this series of patches, applied to a linux-pci 
GIT tree kernel, the problem is solved for me. The reset is carried out, 
the secondary bus and the PCI device beind the bus all recover after 
injecting an error into the root port.

Tested-by: Hinko Kocevar <hinko.kocevar@ess.eu>

Thank you!
