Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF21A22CE
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgDHNSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 09:18:05 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:38172 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgDHNSF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 09:18:05 -0400
Received: from [192.168.1.4] (212-5-158-69.ip.btc-net.bg [212.5.158.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id A35B7CFB4;
        Wed,  8 Apr 2020 16:18:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1586351883; bh=6jsS54DDAbAVWAIdONxSTHUhrCNzAC7cdn2dSGdXnBg=;
        h=Subject:To:Cc:From:Date:From;
        b=H5BsiIzB8AZxY0Wq3Tf16IwYzzmNiusO9OkRSYpYmfdIUGLh+BC4cjiSyKjjdU/20
         OLzEOj8NRb7KFq6sCwZk+L+B6rEFumPkXkvAJMAq6ekGwk0ahP8ztFLDQrwpuhC8az
         VfQp97J1Ov1sFxv2bnMBcDblhbNWtSDtgT1MqIfpq0WJYQ+RJDEoeEPUHzhvhksk0e
         ElRZ//uN6BAO1ZDzMx++hPMrGd1TycYo+7c46ge4WdqAVyVgYJ5JOCxosA8l+a1WaL
         koBe23FyOZtaShYFn51cpiPYHIJvnGbhnOIv0w+2XPhYSx4hZr0WjoTsauBcJ1DYSc
         SUs2QL8bsicTQ==
Subject: Re: R: [PATCH v2 07/10] PCIe: qcom: fix init problem with missing
 PARF programming
To:     ansuelsmth@gmail.com, 'Andy Gross' <agross@kernel.org>
Cc:     'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-8-ansuelsmth@gmail.com>
 <fea9cfd1-2bc7-0141-444e-9c781877ad02@mm-sol.com>
 <053e01d60da2$984f1170$c8ed3450$@gmail.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <2c5dcc8e-fc65-bc72-64c4-b5c69a21f7ca@mm-sol.com>
Date:   Wed, 8 Apr 2020 16:18:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <053e01d60da2$984f1170$c8ed3450$@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

On 4/8/20 3:38 PM, ansuelsmth@gmail.com wrote:
>> PARF programming
>>
>> Hi Ansuel,
>>
>> Please fix the patch subject for all patches in the series per Bjorn H.
>> request.
>>
>> PCI: qcom: Fix init problem with missing PARF programming
>>
>> Also the patch subject is misleading to me. Actually you change few phy
>> parameters: Tx De-Emphasis, Tx Swing and Rx equalization. On the other
>> side I guess those parameters are board specific and I'm not sure how
>> this change will reflect on apq8064 boards.
>>
> 
> I also think that this would brake apq8064, on ipq8064 this is needed or 
> the system doesn't boot. 
> Should I move this to the dts and set this params only if they are present
> in dts or also here check for compatible and set accordingly? 
> 

I also think that these phy params should be per board (and they are
tunable).

Maybe you can propose those as generic phy params in pci.txt binding
document and then we can ask DT maintainers for opinion. If they refuse
such generic bindings, we could switch to custom qcom,phy properties.

-- 
regards,
Stan
