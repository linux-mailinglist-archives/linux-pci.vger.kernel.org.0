Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F054AC0B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbiFNIlF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352758AbiFNIkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 04:40:47 -0400
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 01:39:44 PDT
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F43B570;
        Tue, 14 Jun 2022 01:39:44 -0700 (PDT)
Received: from [192.168.1.12] (unknown [195.24.90.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id D1F5DD2BB;
        Tue, 14 Jun 2022 11:29:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1655195374; bh=umrYtwnirkoe99KkZohQM5qPVTV3RIpG36i2bQIdkos=;
        h=Date:Subject:To:Cc:From:From;
        b=PMV51+Mb85tRUpz7FyS0UjiWZGEzbHty52Rlh5G77TSFowE8pJ+wmiOll8RFTAhz7
         s14K0ij8l1Rzt0s+mfNd3+XwpIHpyEg134it1frHExrtJPXsu+ONaS0tn7F2pUjnIz
         AensMrnGcX9tuU00QtLXLM7RRvKU0334TF3kDl973Mj0254jSr+ScuZaGJlw6749jS
         oQOUjyRH/bwqvfoVRnthHru7Jxjev+YkpOiFHvn4GTHcEpqBnS1tCpn5i0YuJkTJ6q
         PAn944ytqRRVnM/kBbpdxuxtACpj/VMNGzEbATyWH37/gOoSWznWHeMQPs+kOqwAlQ
         a92sxvAGKA0bA==
Message-ID: <dd3d2e45-7f05-e5bf-ffed-aab83fd7a4af@mm-sol.com>
Date:   Tue, 14 Jun 2022 11:28:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 3/3] PCI: qcom: Add IPQ60xx support
Content-Language: en-US
To:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <cover.1655028401.git.baruch@tkos.co.il>
 <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <a470b27a642d21e7b3e64d0f3287c0c3521bd182.1655028401.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for the patch!

On 6/12/22 13:18, Baruch Siach wrote:
> From: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
> 
> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> platform.
> 
> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
> win.linuxopenwrt.2.0).
> 
> Split out the DBI registers access part from .init into .post_init. DBI
> registers are only accessible after phy_power_on().
> 
> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/
> 
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>

Looks good:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>


-- 
regards,
Stan
