Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E404128B0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 00:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhITWPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 18:15:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29340 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhITWNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 18:13:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632175893; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Subject: From: Cc: To: Sender;
 bh=vONWPXkx6SD8VsjCp021j3U3grcczOLeZXYZcHjEzN4=; b=jdZQZxWkGLFMVYsbYbEEii3aHigQzbbgeqJkOcplfCAURGwm5xGy3DrxtE2MgPwvUzFeCbTs
 JxtMYYGaGCek3jedKXTWCd4Jfgd3LVd+453nFVGORQss89z2PUgGd//BdnHLQpDgd287O92B
 Jnk96+1/C1VBEYNBf5HKePNzz64=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61490714b585cc7d24748e13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Sep 2021 22:11:32
 GMT
Sender: hemantk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA83DC4360D; Mon, 20 Sep 2021 22:11:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.9] (cpe-76-176-73-171.san.res.rr.com [76.176.73.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19EB7C4338F;
        Mon, 20 Sep 2021 22:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 19EB7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, manivannan.sadhasivam@linaro.org
From:   Hemant Kumar <hemantk@codeaurora.org>
Subject: Revert "PCI/ASPM: Save/restore L1SS Capability for suspend/resume"
Message-ID: <06838361-0d2c-4a18-da04-6fb586ecd730@codeaurora.org>
Date:   Mon, 20 Sep 2021 15:11:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Is there any plan to revisit the fix to allow L1SS CTRL1 and CTRL2 save 
and restore to work with suspend and resume.

Referring to the lkml discussion 
https://lore.kernel.org/linux-pci/20201228040513.GA611645@bjorn-Precision-5520/

A patch was shared, described as :-
"4257f7e008ea restores PCI_L1SS_CTL1, then PCI_L1SS_CTL2.  I think it
should do those in the reverse order, since the Enable bits are in
PCI_L1SS_CTL1.  It also restores L1SS state (potentially enabling
L1.x) before we restore the PCIe Capability (potentially enabling ASPM
as a whole).  Those probably should also be in the other order."

We are planning to enable aspm driver, but without L1SS control register 
save and restore, it gets disabled after resume.

Thanks,
Hemant
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project
