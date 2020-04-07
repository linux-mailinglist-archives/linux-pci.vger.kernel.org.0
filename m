Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B681A0FCD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Apr 2020 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgDGPBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 11:01:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:40734 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728943AbgDGPBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2020 11:01:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586271677; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=qfPhXpbq48UCquvIdZVCgwV3ApL3LR9hDpMi14snUs4=; b=ENnh8JuBv9aqLLKlm9/+BygURQmCxjQ7aBJkaSjvwxO/Nm7kRWDsgQ9YEH+uQT2Rw7Ba9E53
 rDkcgyxqJz1qcw9qjVEanKloFdYdU98JsaSflZOKM8yj/8PHomRL3Zr6MjV6fb5BvvH1nzB9
 RtlWMn7EPKT2J5mYfa9l11cFM6Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c95a1.7fead9ff8e30-smtp-out-n04;
 Tue, 07 Apr 2020 15:00:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9FCEC4478C; Tue,  7 Apr 2020 15:00:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12359C433F2;
        Tue,  7 Apr 2020 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12359C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <mika.westerberg@linux.intel.com>, <linuxarm@huawei.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: Use pci_pcie_find_root_port() to get root port
References: <1586262717-23566-1-git-send-email-yangyicong@hisilicon.com>
Date:   Tue, 07 Apr 2020 18:00:44 +0300
In-Reply-To: <1586262717-23566-1-git-send-email-yangyicong@hisilicon.com>
        (Yicong Yang's message of "Tue, 7 Apr 2020 20:31:57 +0800")
Message-ID: <87zhbnuyqr.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ linux-wireless

Yicong Yang <yangyicong@hisilicon.com> writes:

> Previously we use pcie_find_root_port() to get root port from a pcie
> device, use pci_find_pcie_root_port() to get root port from a pci
> device, which increase the complexity.
>
> Unify the two functions and use pci_pcie_find_root_port() to get root
> port from both pci device and pcie device. Then there is no need to
> distinguish the type of the device.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  2 +-
>  drivers/pci/pci-acpi.c                          |  4 ++--
>  drivers/pci/pci.c                               | 24 ------------------------
>  drivers/pci/pcie/aer_inject.c                   |  2 +-
>  drivers/pci/probe.c                             |  2 +-
>  drivers/pci/quirks.c                            |  2 +-
>  drivers/thunderbolt/switch.c                    |  4 ++--
>  include/linux/pci.h                             | 14 +++++++-------
>  8 files changed, 15 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> index 38d8fe2..556cb8c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> @@ -158,7 +158,7 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
>
>  	/* Print root port AER registers */
>  	pos = 0;
> -	pdev = pcie_find_root_port(pdev);
> +	pdev = pci_pcie_find_root_port(pdev);
>  	if (pdev)
>  		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
>  	if (pos) {

For the wireless change:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
