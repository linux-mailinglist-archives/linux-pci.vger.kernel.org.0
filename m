Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0225730529A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 06:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhA0F4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 00:56:51 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:26433 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbhA0FMi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 00:12:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611724326; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PZnOYF05HkispD0eSYFORy9Ic1cH/Mgkcr30MzSPrFs=; b=pOuSrRl+UXn/WU41SzvaNYBLfyUfb5YfU2hdDFCGRhEw8z00ddNt2p+pr5nd1fMRAuceeo/2
 RcxJUGRgoHqPzAKgHvPrTljDFod+axbsAAzptJF8mTgzJR+4aFG/SkLx6+akM1QitiJkduDS
 C9xfBGZTY0z1hLnhSTsd/nofXLY=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6010f602d75e1218e30cde0b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 05:11:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 46036C43469; Wed, 27 Jan 2021 05:11:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F314BC433CA;
        Wed, 27 Jan 2021 05:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F314BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luca Coelho <luciano.coelho@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Fix "ordering" comment typos
References: <20210126195042.2909405-1-helgaas@kernel.org>
Date:   Wed, 27 Jan 2021 07:11:22 +0200
In-Reply-To: <20210126195042.2909405-1-helgaas@kernel.org> (Bjorn Helgaas's
        message of "Tue, 26 Jan 2021 13:50:42 -0600")
Message-ID: <87zh0v9d6t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix comment typos in "ordering".
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/s390/include/asm/facility.h             | 2 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/fw/file.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
>
> Unless somebody objects, I'll just merge these typo fixes via the PCI tree.

Please do.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
