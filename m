Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A26309CF6
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jan 2021 15:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhAaOdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jan 2021 09:33:00 -0500
Received: from so15.mailgun.net ([198.61.254.15]:23669 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhAaOZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 31 Jan 2021 09:25:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612103086; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=is+Y0S6VYuSq/a22S7AdpwgFKHNWJy9S/ugml5uNJWU=; b=f5/6hEYRIFalQEqdmikweoSuMN2JECFP7ynd1WYiqsgde2l/MGCWwGA2drpgxNmYbdpsBGmN
 EVP9AnxflZ4NcbvEPuGXrfunzMymuqHS4xSp8FzZluRoDP4nDkhwwIOEJ8kvB57aGyHiV5iV
 6ad3yK1DRtpbOcdGhulemFN1B2w=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6016bc2f7a21b36a9deb2f5f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 31 Jan 2021 14:18:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7BDAC433CA; Sun, 31 Jan 2021 14:18:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7039C433C6;
        Sun, 31 Jan 2021 14:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7039C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] misc: qca639x: add support for QCA639x powerup sequence
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
        <20210128175225.3102958-2-dmitry.baryshkov@linaro.org>
Date:   Sun, 31 Jan 2021 16:18:16 +0200
In-Reply-To: <20210128175225.3102958-2-dmitry.baryshkov@linaro.org> (Dmitry
        Baryshkov's message of "Thu, 28 Jan 2021 20:52:21 +0300")
Message-ID: <875z3dmbpz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> Qualcomm QCA639x is a family of WiFi + Bluetooth SoCs, with BT part
> being controlled through the UART and WiFi being present on PCIe
> bus. Both blocks share common power sources. Add device driver handling
> power sequencing of QCA6390/1.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/misc/Kconfig        |  12 +++
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/qcom-qca639x.c | 164 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 drivers/misc/qcom-qca639x.c
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e90c2524e46c..a14f67ab476c 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -255,6 +255,18 @@ config QCOM_FASTRPC
>  	  applications DSP processor. Say M if you want to enable this
>  	  module.
>  
> +config QCOM_QCA639X
> +	tristate "Qualcomm QCA639x WiFi/Bluetooth module support"
> +	depends on REGULATOR && PM_GENERIC_DOMAINS
> +	help
> +	  If you say yes to this option, support will be included for Qualcomm
> +	  QCA639x family of WiFi and Bluetooth SoCs. Note, this driver supports
> +	  only power control for this SoC, you still have to enable individual
> +	  Bluetooth and WiFi drivers.
> +
> +	  Say M here if you want to include support for QCA639x chips as a
> +	  module. This will build a module called "qcom-qca639x".

Is this is something you need on ARM platforms? As on x86 this is
definitely not needed, for example it's enough to load ath11k_pci to get
QCA6390 Wi-Fi working. I think the documentation should be clarified
where this QCOM_QCA639X is needed (and it's not needed on normal PCI
devices).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
