Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE55668C2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGEK6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiGEK5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 06:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC9167ED;
        Tue,  5 Jul 2022 03:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6DD760B83;
        Tue,  5 Jul 2022 10:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4049AC341C7;
        Tue,  5 Jul 2022 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657018579;
        bh=j1oJZmU/BD2PKhSkrFTBAPRMJhqsYWZdc4xtZEXxOoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k7wWsL0POJ6OcEQ4FJaNLKW+MosT1/EAneUZUt1+Imn+qZyvAgpe0SSlQcB8ubSy+
         5uOutuOtX9rHfApzLHlnXsCSc2/Pgyq4hEnZ0A33kKvTeImvyiVg/M9dBBK8OmPHEV
         1VouRw8aUyUVoIZMxsfSpokyIgIZPWb+r3rAVfEzaEANNEjiYKECBxr0siTYEkdPTJ
         uHi+Elt1P2Fajmhml2aZn+j/bYn0xnYZN1bj+4YoAN91llVeHik/Dqwpyyz6xj5BOx
         LyDFddfoIEq2ZGOY5LwSsKO1/YL7Tdl/l0+Mda+yE+lOp3vGW6sTQkIk8B6Q6EmVzd
         mi0RDe/cSVJXg==
Message-ID: <43a075c6-ff48-acf2-0be7-634d292daf30@kernel.org>
Date:   Tue, 5 Jul 2022 12:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
Cc:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
References: <20220620083821epcms2p57a65984523a0f2a3815e4873e8bfc6df@epcms2p5>
 <4b4b08af-887b-89e9-b4a5-93e7d8a03222@kernel.org>
 <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
 <20220614012916epcms2p5cf8d55e7420dea10bb4a05d91aaf99dd@epcms2p5>
 <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p6>
 <20220629071829epcms2p65eab75702495a939f3f6e4ea020181de@epcms2p6>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220629071829epcms2p65eab75702495a939f3f6e4ea020181de@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/06/2022 09:18, Wangseok Lee wrote:
> Just a gentle ping for this patch, if any concern on this patch please let me know.
> 

You received comments to fix in this patch. Exactly four. Four important
points to fix. Therefore what is this ping about?

Without fixing these items, your patch cannot be accepted. What is more
to ping here?

Best regards,
Krzysztof
