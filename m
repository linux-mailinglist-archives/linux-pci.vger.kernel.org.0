Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F47018E3
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjEMSBU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 May 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjEMSBC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 May 2023 14:01:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD835AC;
        Sat, 13 May 2023 11:00:23 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DHwTdY129663;
        Sat, 13 May 2023 12:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684000709;
        bh=mePJ/RInYE0y486rwBOzi4W43YzL4ZNbENMKuvC0VrQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ER4Zn/Yqprfvj+/F3pwYP12no5AmhVWle7eAm4Xx81m8Ogk5GQla434ZDVuuUx1sw
         TeQLq9GgZAzpQRIPQMlaaz0BbwwguiyRh+t0tuTxO6lVsHZKgr8A2aGsF6l9tbQjKC
         c5JgYPUcJLviB5SpyAArIdo0eq5/qM1WrEkgXwe4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DHwT0j079199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 12:58:29 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 12:58:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 12:58:29 -0500
Received: from [10.249.131.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DHwMIY020336;
        Sat, 13 May 2023 12:58:23 -0500
Message-ID: <3b5d7c3c-164d-0690-c2e8-2c7daec4865c@ti.com>
Date:   Sat, 13 May 2023 23:28:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [EXTERNAL] Re: [PATCH 3/3] arm64: defconfig: enable J721e PCIe
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, achal Verma <a-verma1@ti.com>
References: <20230512070510.1873171-1-a-verma1@ti.com>
 <20230512070510.1873171-4-a-verma1@ti.com>
 <13028434-f68c-cad3-056e-d319c1ec35cf@linaro.org>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <13028434-f68c-cad3-056e-d319c1ec35cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hello Krzysztof,
On 5/12/2023 12:53 PM, Krzysztof Kozlowski wrote:
> On 12/05/2023 09:05, Achal Verma wrote:
>> Enable Cadence PCIe controller and pci-j721e drivers to be built as
>> kernel modules.
> 
> Why? IOW, who needs them. Please provide rationale in the commit msg. I
> am pretty sure I asked for this...
> 
On TI's J7 SOCs, PCIe is composed of PCIe core from Cadence and TI 
wrapper. It is desired to have J7 PCIe working on upstream kernel by 
default. So to enable this I have pushed these defconfig changes.

BTW, I am planning to hold this change until PCIe code changes (rest of 
the patches in this series) gets merged.

Please let me know if there are more concern to this.
Sorry, for this time.

Thanks,
Achal Verma
> 
> Best regards,
> Krzysztof
> 
