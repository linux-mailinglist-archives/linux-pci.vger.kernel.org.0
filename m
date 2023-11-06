Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B047E1BE7
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjKFIZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 03:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFIZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 03:25:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E321BB;
        Mon,  6 Nov 2023 00:25:35 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38CA46605769;
        Mon,  6 Nov 2023 08:25:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699259134;
        bh=Ut/U5kOAxO6gxFFmg+MrU8i15HKJJa8WFBDlN6E2YQc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jqOcc47zUCAnvPPGcHa3h+8Zy0KttpeazmkhFA1tK9/zMneD54wNl36JBclLgaqqh
         uUJkZsBAacSI0TjhgSIT2hLExGFJVkNvhQOnRNhXZVsk2p9fW4KbvXCZMj86C7g4eP
         jzeV9aDfOMmnvPKf95y/16+NNV4rVs21wuYXeIjM7ERYCr0GIt6a6Gk96I9Itudnbg
         GPiQT0tAcI6i46R6Sw5bVZ2iFUYMNMeu571W1LC91mdZoU4dx7Vz5rtAWOsMfY9Dhk
         smOy6JgIz+SlMhLe590OFdSkhCXIHVTccuJartFaQ320dAynVSxc7uA7hOvDZ5PRGI
         ftdftbTeLzl+g==
Message-ID: <a504e6f6-8bd0-4f23-9dd7-98b6a4722e95@collabora.com>
Date:   Mon, 6 Nov 2023 09:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Content-Language: en-US
To:     Jian Yang <jian.yang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chuanjia.Liu@mediatek.com, Jieyy.Yang@mediatek.com,
        Qizhong.Cheng@mediatek.com, Jianguo.Zhang@mediatek.com
References: <20231106061220.21485-1-jian.yang@mediatek.com>
 <20231106061220.21485-2-jian.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231106061220.21485-2-jian.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 06/11/23 07:12, Jian Yang ha scritto:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Add new properties to support control power supplies and reset pin of
> a downstream component.
> 
> Signed-off-by: jian.yang <jian.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


