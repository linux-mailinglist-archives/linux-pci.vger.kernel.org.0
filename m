Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01A746F602
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhLIVid (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:38:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7483C061746;
        Thu,  9 Dec 2021 13:34:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l18so1561842pgj.9;
        Thu, 09 Dec 2021 13:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5amisMk02X6OjYIuHUB57loA8SORa0eE7CAIPMryo38=;
        b=ipw8Fb2thSLvDq0x0iCSQ22eedLIpCehS0ABagq5ThL0UFzZ8B8hRNObuCb6uiJWx0
         b0KDL2Tnne2hSzPAoq+2IyjGKUjoie73/WMeHNIJvOfFQQT9LqZW5jdz0c9lzGyOPgQt
         IMc+AuZ+Vj6K5TAbjflDlK294jR6+QSTFewBHIwD1uz7InoNtvOcED74xncRNeOwVQM9
         M3cemFaqqlgDbs9cG6VJCyjU9lbGi9RDYg0ktz1VAkRttj6/wsl/wQ4sd8m9Odox53ia
         mwpuDvnG7B7JMEcR8sZpWmsBfqPRFFOapv2GiogGA9kkFIta8V7VvbTHhd1ydiTww9k9
         si7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5amisMk02X6OjYIuHUB57loA8SORa0eE7CAIPMryo38=;
        b=wnnBsycey84r8G9013v7ARHVsE/YSQukGrjUsBgFSxR8RG8NY4EgDCbOsS6QnetA6h
         w8qKOf0qaBfYNenD4Bn4fq1DMq68LErNE8iRq94ChaIQtCxIDZg2BSzlHvXxHrpYQEsZ
         AST7TtISfck3Czjg3SaLSGaKnmmHg4RuwEXKVkW2dO9GrcLPkAtSphdtU/tdQCKBeWTS
         nGsX6GstzrJ+ViwvUM6mHjTRsyiezz5NgbVQAAtAWe9uErIekZzMxFCGB3w19/nuNI5y
         VX+GCj7jyOVT0+19iwe/gNXTBINH4Ivx2+6xkBEp16U2u2iRyjbd9UDUsc3ulUT+ECK+
         r+aA==
X-Gm-Message-State: AOAM53381x3rYmVQ6K2vpiRX2t4BTQ5aKzd3Q3rgc4Q8Q2Muf1Sgxyu/
        DyRdNcotqrsBDO+f2FtW5brE4D3ea9g=
X-Google-Smtp-Source: ABdhPJxr4pe7eb47Ap+CyEWNd0mA2jhMsJkSiHs3GbzIJ/xHzZUqPMlNUYGcI73CQ+7276kdVUDERw==
X-Received: by 2002:a05:6a00:1344:b0:49f:f357:ac9 with SMTP id k4-20020a056a00134400b0049ff3570ac9mr14060302pfu.62.1639085697976;
        Thu, 09 Dec 2021 13:34:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v25sm603062pfg.175.2021.12.09.13.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:34:57 -0800 (PST)
Subject: Re: [PATCH v10 1/7] PCI: brcmstb: Fix function return value handling
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211209211407.8102-1-jim2101024@gmail.com>
 <20211209211407.8102-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <290fe880-32a4-109d-35fa-fc72c88798e9@gmail.com>
Date:   Thu, 9 Dec 2021 13:34:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209211407.8102-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/21 1:13 PM, Jim Quinlan wrote:
> Do at least a dev_err() on some calls to reset_control_rearm() and
> brcm_phy_stop().  In some cases it may not make sense to return this error
> value "above" as doing so will cause more trouble than is warranted.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
