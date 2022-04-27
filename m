Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D951130F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359150AbiD0H7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiD0H7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 03:59:41 -0400
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D86517C1;
        Wed, 27 Apr 2022 00:56:29 -0700 (PDT)
Received: from [192.168.1.2] (212-5-158-212.ip.btc-net.bg [212.5.158.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 56E6DD29D;
        Wed, 27 Apr 2022 10:56:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1651046186; bh=GZtSxf9qQHnSJ07YowYAD5qLoDp3THpbueVRvuxn6VA=;
        h=Date:Subject:To:Cc:From:From;
        b=qciIPw4l628louWQMLdpBVM5EMeeHhN8ZEAzre+a96r3HF/2688/ZCYhg0ruDm0EG
         ktWIUdT3mSzPvwmWv2F8wYHZzqM0mnW3nLXyYbDOgWuWcUmX1y9H1c5Km9Xi1tbyQn
         Ytzei+cWXW0dJkoHzbvcLOloY2Jd7BABm3bzp0WDJ53M/hvrUvoy6jsL1aiNtrBE6M
         9AOpl+3zp3I5/2g2jgXpp+2HwzJLRYdhhqtwzDdL2Zt195GF+yK0+ifug2JlDuA7Xj
         MOFRxUrjP/HF4cR7ajyFnednfse56FZXvDRtNDt7FddzP1fYGyJRaMKQccGNXku9ME
         R7kAkDg0ie5SQ==
Message-ID: <2d4f2182-73de-1c35-2006-4d1f6771b92b@mm-sol.com>
Date:   Wed, 27 Apr 2022 10:56:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] PCI: qcom: Fix probe error paths
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401133854.10421-1-johan+linaro@kernel.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20220401133854.10421-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Johan,


On 4/1/22 16:38, Johan Hovold wrote:
> This series fixes a few problems in the probe error handling which could
> cause trouble, for example, on probe deferral.
> 
> Johan
> 
> 
> Changes in v2
>  - Capitalise subject lines according to PCI subsystem conventions
> 
> 
> Johan Hovold (2):
>   PCI: qcom: Fix runtime PM imbalance on probe errors
>   PCI: qcom: Fix unbalanced PHY init on probe errors
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
