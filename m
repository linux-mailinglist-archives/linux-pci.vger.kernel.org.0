Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481F1662A40
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 16:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjAIPkt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 10:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjAIPkU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 10:40:20 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217D3FA34;
        Mon,  9 Jan 2023 07:36:33 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 309FaJU2097106;
        Mon, 9 Jan 2023 09:36:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673278579;
        bh=Jld2VibXBRT1Vbvhua3bqKIw1ASSScTxaM4OcrX/3lg=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=kwgCg7X7dECbJWi3t4ePButwZWv3c3vh9lElDtZze0jRc1U3VWUZX01lvxgl8+sLY
         t1GHe07zX/a1d0OOtYH1phjapYb4bKS8Uw5LOsww8cs8L/GM0dfF+KYWTRwDzPKuIc
         acL89Y/FZxfUR8K3WQwhKLK7SVeaTr8y1AJDm+U8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 309FaJjK098690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jan 2023 09:36:19 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 9
 Jan 2023 09:36:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 9 Jan 2023 09:36:18 -0600
Received: from [10.250.232.49] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 309FaE4n027581;
        Mon, 9 Jan 2023 09:36:15 -0600
Message-ID: <db93c472-f617-3207-af57-55b14de8e236@ti.com>
Date:   Mon, 9 Jan 2023 21:06:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/2] PCI: j721e: Add support to build pci-j721e as
 module.
To:     Achal Verma <a-verma1@ti.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Milind Parab <mparab@cadence.com>
References: <20230108155755.2614147-1-a-verma1@ti.com>
 <20230108155755.2614147-3-a-verma1@ti.com>
 <8dc31852-3d1c-860d-7844-15205f8fd6c6@ti.com>
 <20230109123550.GA2647927@desktop-3598>
Content-Language: en-US
In-Reply-To: <20230109123550.GA2647927@desktop-3598>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09/01/23 6:05 pm, Achal Verma wrote:
> Discussed with Vignesh the current config dependency of pcie-cadence and pci-j721e modules,
> it seems like for now to modularize these drivers with minimal changes is to use "select"
> as they were used before in PCI_J721E_HOST and PCI_J721E_EP config options.
> 

With this patch its now impossible to build PCI_J721E_HOST without
pcie endpoint support (as PCI_ENDPOINT is now a dependency). I don't
know a way to achieve this via Kconfig magic w/o splitting pci-j721e.c
into EP/RC (like pcie-rcar* or pcie-rockchip*)


> Will push updated version with "depends on PCI_ENDPOINT" in PCI_J721E config to check
> dependency on PCI_ENDPOINT before selecting PCIE_CADENCE_EP.
> 

Please don't top post and respond inline:
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

Regards
Vignesh

[...]
