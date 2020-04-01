Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A271919AC9D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbgDANV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 09:21:26 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:34561 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732557AbgDANV0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 09:21:26 -0400
Received: from [192.168.1.3] (212-5-158-187.ip.btc-net.bg [212.5.158.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id E352ECFAB;
        Wed,  1 Apr 2020 16:21:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1585747284; bh=jQLOaV/9gNCw8k6Dt09Ffv5U8fBSYoigBETbYtsrfGg=;
        h=Subject:To:Cc:From:Date:From;
        b=hOQ+FwI48FvfF4wgRCrjSPX9HRQope4b+LmxDEKYjeqnGLh8jbjR0tx1EX+E5ptKp
         0ytSgtjowjMUO6eybbWh+YvQnCL+0oAo+NdYwfBY8qw3iNMidnhC1bbXhw65uBYczK
         A1vmXZOtyKyq+P5MwGPWp0+WazbYk2SEBkcd9IusLpfeYHjOxhHERPuYl0L6NFI5lU
         I7mdYarbwmXm2EEzzlaiTxsDvPt/yDv7p4UPMjTJzyxbIGJ7jVdPvocgrHXI9N8MO5
         V3Mdd3SPEVWwVooVP7+RFnGIR41vehx8QXe3q4+OgF/7T/7ScF93OPUEBbGLzE91eB
         mYz1QcKewFzjA==
Subject: Re: [PATCH 09/12] pcie: qcom: Programming the PCIE iATU for IPQ806x
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
 <20200320183455.21311-9-ansuelsmth@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <3890fd67-53a3-aa73-af52-4b79c5881dca@mm-sol.com>
Date:   Wed, 1 Apr 2020 16:21:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320183455.21311-9-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On 3/20/20 8:34 PM, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Resolved PCIE EP detection errors caused due to missing iATU programming.

NACK, the iATU programing is not belonging here. Did you check what
pcie-designware-*.c is doing with iATU?

If you want to support endpoint mode in pcie-qcom driver you have to see
how the other drivers is doing that.

> 
> Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 78 ++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 


-- 
regards,
Stan
