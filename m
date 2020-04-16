Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E291ACBB0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442763AbgDPPu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442756AbgDPPuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 11:50:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96439C061A0C;
        Thu, 16 Apr 2020 08:50:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h26so5424694wrb.7;
        Thu, 16 Apr 2020 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvYs9XCG2aImnv7YTN/6qNNfm9qAJyY0L/WKA+8FyXo=;
        b=EIWJ0+dXID3v2/DrPg/3fH19vNCz52vG00gJHBX1/Lp/CedRUzhPJktm+EyqHqicji
         XzN4VlrRZ/YOSHhpSSWbMlnMHfF3+C9lLC86V51yBL+4xEVxwY560QEkiEH+mtrert5D
         kLoKzqDqNYhA7HyA0wB4AkcQy5KFs5u7oX68f9e5FHHO1GScYdW4Cg5jqlZR5GGe/+Ki
         /PlHcuUUbYw3AceLuY90wjN/mMATRvALYTF7f8SCAkBivbPaVM4Ja9R01Mzvo3WM3cqr
         g9qW+hbuhgzLLhEnylxhvwPWIqaJy/nLDXUX0gzOnCeYGJbHx0TdYSpPSbJveSyR18Bd
         QAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvYs9XCG2aImnv7YTN/6qNNfm9qAJyY0L/WKA+8FyXo=;
        b=NfWEfAXZVye2XffOp2iLTH8GASk0Q9W6U3Jniycq6Iup/GOgc1ve96XiG3amoXOXCS
         nDcn+brj4LyAB1e6pdX2sCdHJDMoQtAOeeoZ/YtDVNbnXAwr1VnZ9Z/NDahoGLJXSw2/
         RZLf62xNUwyXYG18GMAGCP/B6BkGXw6+bbZOUesiolDOTQTISqPQ2WcyHUwYv7+NTZg7
         c8CvEwY3Fno57OMO6hcHNCpStNjNgYvOMk3P9qMhReGZefOEkhfUsDuQ4MmDEc8XhHdZ
         3xE8I6MDz3crt+YW5MbQUQ8HrVd0BoQNkfdCcBPWz7j8838btUjEn5a3BRI1DEw9hpcR
         2VDw==
X-Gm-Message-State: AGi0PuZwRcnMwkWIzaK1Jo0dOWK3MuQULQdGxK3uyG3nZoONZRkAvIev
        lZgW1wFc7+DH6dkFHXKLTXlDh8jU+g4=
X-Google-Smtp-Source: APiQypJvhcf6VMCyMe8iVzg+MLA48ujz8jsHVP3mxFWOxl8TPyYxY8OQhNxhtZM/8kC3ppK3Om+Kvg==
X-Received: by 2002:a05:6000:162c:: with SMTP id v12mr37458323wrb.313.1587052221186;
        Thu, 16 Apr 2020 08:50:21 -0700 (PDT)
Received: from [10.8.0.6] ([5.2.67.190])
        by smtp.gmail.com with ESMTPSA id a80sm4044167wme.37.2020.04.16.08.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:50:20 -0700 (PDT)
Subject: Re: [PATCH 0/8] PCI: aardvark: Fix support for Turris MOX and Compex
 wifi cards
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200415160054.951-1-pali@kernel.org>
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
Message-ID: <005d1646-867e-8e88-431f-43e0f42ad680@gmail.com>
Date:   Thu, 16 Apr 2020 17:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W dniu 15.04.2020 o 18:00, Pali Rohár pisze:
> This patch series fixes PCI aardvark controller to work on Turris MOX
> with Compex WLE900VX (and also other ath10k) wifi cards.
> 
> Patches are available also in my git repository in branch pci-aardvark:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
> 
> Pali Rohár (8):
>   PCI: aardvark: Set controller speed from Device Tree max-link-speed
>   dts: espressobin: Define max-link-speed for pcie0
>   PCI: aardvark: Start link training immediately after enabling link
>     training
>   PCI: aardvark: Do not overwrite Link Status register and ASPM Control
>     bits in Link Control register
>   PCI: aardvark: Set final controller speed based on negotiated link
>     speed
>   PCI: aardvark: Add support for issuing PERST via GPIO
>   dts: aardvark: Route pcie reset pin to gpio function and define
>     reset-gpios for pcie
>   PCI: aardvark: Add FIXME for code which access
>     PCIE_CORE_CMD_STATUS_REG
> 
>  .../dts/marvell/armada-3720-espressobin.dtsi  |   2 +
>  .../dts/marvell/armada-3720-turris-mox.dts    |   4 -
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   2 +-
>  drivers/pci/controller/pci-aardvark.c         | 118 +++++++++++++++---
>  4 files changed, 106 insertions(+), 20 deletions(-)
> 

For the whole series

Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>

-- 
TMN
