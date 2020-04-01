Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D960819AC4A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgDANBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 09:01:31 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:33303 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732534AbgDANBb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 09:01:31 -0400
Received: from [192.168.1.3] (212-5-158-187.ip.btc-net.bg [212.5.158.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 46D27CFAB;
        Wed,  1 Apr 2020 16:01:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1585746088; bh=zOxr38VY0D/4MvUtAz2wio+gKJ7DGco1NKhyuLfJmn8=;
        h=Subject:To:Cc:From:Date:From;
        b=Qhd9G2/BG12qd1SDazQPmx/WmHsy9p48aY/i3sjh8ZIHSkbpC5XWyUwla8MDCe2S1
         qG+nuRYhknQUP+HGtMu5LAq/sOu5YKLtaRHxABuWzyPzaWTXD4XwEzEj7dKVLEBbCf
         xBri1yb9Ai+wCyVXP/CaF+u+bMbgGknITT3QxXq1Y1fcY7R4Jw9sIOtPuo2FwqIpcA
         DL6lcJxub/XtnH5n1dwBz5jlzahrpsyjNR3QyIdEvnrLLB+2KzcllP5PXqtCl1AlpH
         XOHRsXt+++1YW1mSVy49pxGSO3qzriGhIJFg27paMHABECqRWJyr1DqaszAXbE++Zf
         53q9cL4CvjVSQ==
Subject: Re: [PATCH 01/12] pcie: qcom: add missing ipq806x clocks in pcie
 driver
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <416ed5fa-4e22-68cc-1c80-be720e72ad55@mm-sol.com>
Date:   Wed, 1 Apr 2020 16:01:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320183455.21311-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

As Bjorn already mentioned please make cover-letter in next version of
the patchset so that we know what is the purpose of the patches.

I've the impression that you want to use pcie-qcom platform driver as an
endpoint, am I wrong?

I'll review the patches these days.

On 3/20/20 8:34 PM, Ansuel Smith wrote:
> Aux and Ref clk are missing in pcie qcom driver.
> Add support in the driver to fix pcie inizialization
> in ipq806x
> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 5 deletions(-)


-- 
regards,
Stan
