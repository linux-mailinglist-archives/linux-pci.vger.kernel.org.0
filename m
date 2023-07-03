Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA0745EF5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGCOp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGCOpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 10:45:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6310D0;
        Mon,  3 Jul 2023 07:44:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 363Ei0xv066266;
        Mon, 3 Jul 2023 09:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688395440;
        bh=EdzWHkf1aaa1WsMyIhRj6KpzRSMZEp4+Px5Tx9YAjRc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Cvvw45rNa5ezhkvHMcuAWc10NurKwUE0HvRjTSWMMydmmGgNiC9nA3YLRrzIyJFdY
         NlSwqwbVA9Y9NOs0iSbXPAqYPkQUcXfDDXoyd5meDrFMeXhNi4x62gsXcLOtHIWj5U
         XbcIun2TTAZKUjKi414Oyqoz19IflfDE4HfMfPL4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 363Ei0i7034089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jul 2023 09:44:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jul 2023 09:43:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jul 2023 09:43:59 -0500
Received: from [10.249.128.37] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 363Eht6L097671;
        Mon, 3 Jul 2023 09:43:56 -0500
Message-ID: <9bb176c9-f1e6-349e-5486-74e0ea6b5012@ti.com>
Date:   Mon, 3 Jul 2023 20:13:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [EXTERNAL] Re: [PATCH] PCI: j721e: Fix delay before PERST#
 deassert
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230703112914.68806-1-a-verma1@ti.com>
 <1891c041807.fea67a55448140.3454059194195387266@linux.beauty>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <1891c041807.fea67a55448140.3454059194195387266@linux.beauty>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/3/2023 7:19 PM, Li Chen wrote:
> Hi Achal,
>   ---- On Mon, 03 Jul 2023 19:29:14 +0800  Achal Verma  wrote ---
>   > As per the PCIe Card Electromechanical specification REV. 3.0, PERST#
>   > signal should be de-asserted after minimum 100ms from the time power-rails
>   > become stable. Current delay of 100us is observed to be not enough on some
>   > custom platform implemented using TI's K3 SOCs.
>   >
>   > So, to ensure 100ms delay to give sufficient time for power-rails and
>   > refclk to become stable, change delay from 100us to 100ms.
> 
> What problems could arise if the delay is too small? Would some endpoints not be able to detect it?
If delay is small, cpu stall is reported during probe() while accessing 
PCIe registers in some cases.
> 
> Regards,
> Li
