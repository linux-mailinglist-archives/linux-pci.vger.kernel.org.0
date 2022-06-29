Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78DC55F3A6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 04:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiF2C5V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 22:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF2C5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 22:57:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BA326D2
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 19:57:19 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220629025717epoutp0264f42c1f0a9f2931b2363e8adc564888~89-7_2uqU1783917839epoutp02N
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 02:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220629025717epoutp0264f42c1f0a9f2931b2363e8adc564888~89-7_2uqU1783917839epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656471437;
        bh=lEtehOiPoK/b2APjv6CNvEHHjEFq+tG5kPmZWVAOFvw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ZEx9lGt8jubuGsUKz+RqLYJnZkrQbZ5IeSvcpXwCleHZuPgpvAX3Xlie67xGcoWkV
         xzRjAKilcEdLSluUDLEfBx916CBzDfvBOt6mTbJX535Zp/5E8cve5+FyQDzDWlGWwk
         6NK67THzFtB69t5Ihz9GqWvPsh3iAbAfCz6tIhWQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220629025716epcas2p1db5d0aba0fcff1d5e48119a84e6dfd35~89-7WcHnf0482304823epcas2p1W;
        Wed, 29 Jun 2022 02:57:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXmMw3pGRz4x9Px; Wed, 29 Jun
        2022 02:57:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.C6.09642.C8FBBB26; Wed, 29 Jun 2022 11:57:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220629025715epcas2p4eb76e2a47c1d0074a04d99148e299aa5~89-6LzYEU2023820238epcas2p4I;
        Wed, 29 Jun 2022 02:57:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220629025715epsmtrp1883453015ffdbdae3c3bf41dd8be82a0~89-6KptdB2964929649epsmtrp1g;
        Wed, 29 Jun 2022 02:57:15 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-2d-62bbbf8c8735
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.EB.08802.B8FBBB26; Wed, 29 Jun 2022 11:57:15 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220629025715epsmtip1b4d12377a0ab3520bb491394ab4f1943~89-59dN6M1646216462epsmtip1U;
        Wed, 29 Jun 2022 02:57:15 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        <linux-pci@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Cc:     "'Jingoo Han'" <jingoohan1@gmail.com>,
        "'Lorenzo Pieralisi'" <lpieralisi@kernel.org>,
        "'Rob Herring'" <robh@kernel.org>,
        =?utf-8?Q?'Krzysztof_Wilczy=C5=84ski'?= <kw@linux.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Vinod Koul'" <vkoul@kernel.org>
In-Reply-To: <20220628220409.26545-1-m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/2] phy: samsung: phy-exynos-pcie: sanitize
 init/power_on callbacks
Date:   Wed, 29 Jun 2022 11:57:15 +0900
Message-ID: <015901d88b63$f023f0a0$d06bd1e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIZhXYmJhgT1yDF8TBX6sXxM1d3EAGdjdchrNbQO9A=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmhW7P/t1JBgfuyFg8mLeNzWJJU4bF
        ii8z2S0uPO1hs9j7eiu7RUPPb1aLs/OOs1lMWPWNxWLG+X1MFi1/Wlgs1h65y27xf88Odoud
        d04wO/B67Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMO
        tc9hLrjLXvGr4xNrA+MOti5GTg4JAROJB00NLF2MXBxCAjsYJVp/f2SHcD4xSsxd8IoJwvnM
        KPHlegNcy5l7l1ghErsYJS62zWGGcF4wSpy6dZsVpIpNQF/iZcc2MFtEYBajxJZ9IiBFzAJz
        mCV+rjvDDJLgFLCT+LHmLpgtLBAl0XjqCQuIzSKgKjGxo5sdxOYVsJS4M7sPyhaUODkTooZZ
        QF5i+9s5zBAnKUj8fLqMFSIuIjG7s40ZYrGVxMPDxxhBFksI3OCQaPsMcZGEgIvEnitzWSBs
        YYlXx7ewQ9hSEi/726DsYomlsz4xQTQ3MEpc3vYLGgDGErOetQNN5QDapimxfpc+iCkhoCxx
        5BbUbXwSHYf/skOEeSU62oQgGtUlDmyfDrVVVqJ7zmfWCYxKs5B8NgvJZ7OQfDMLYdcCRpZV
        jGKpBcW56anFRgXG8OhOzs/dxAhO0lruOxhnvP2gd4iRiYPxEKMEB7OSCO/CMzuThHhTEiur
        Uovy44tKc1KLDzGaAsN6IrOUaHI+ME/klcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1O
        TS1ILYLpY+LglGpgWhjaMYO/f+a331PN0zczVj9i3zJ1Y7k641VNQbM+06Oqs/oF5soWyBoG
        /PTe7vdwZpXIB1bWnez9rjdc7xRt67bZukZos2r+takLJqcGZYRUyjTLTY3/4TQtYZpepGWS
        7A2bl96P3k6e/yTn6a7/aisn+p0KP5j15LWx2ZmkTzM/R30Rnb/+SuztKWduROTs+lDwsk82
        UCs5TduR4wjzkWnHLdS+cLn+bMr/9HaVW0K+gM/bSbxGrVzVBQdvHnxs/H+qLj93e0z1Xa0e
        OYOvQcafZF9Oel4jI6QZ9en/yurbM9/eyJ5mfoJz8cptt7xT0yfkd29z2tzhlZc/e/bvrzu9
        Nyxf+o+n1EFw9t498kosxRmJhlrMRcWJAItmYGdbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnG73/t1JBqtOyFk8mLeNzWJJU4bF
        ii8z2S0uPO1hs9j7eiu7RUPPb1aLs/OOs1lMWPWNxWLG+X1MFi1/Wlgs1h65y27xf88Odoud
        d04wO/B67Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFFc
        NimpOZllqUX6dglcGYfa5zAX3GWv+NXxibWBcQdbFyMnh4SAicSZe5dYuxi5OIQEdjBKTL/W
        wQ6RkJV49m4HlC0scb/lCFTRM0aJC8uWgiXYBPQlXnZsA0uICMxhlHh94iEbiMMssIBZ4tD/
        6+wQLf2MEl/29jOBtHAK2En8WHOXGcQWFoiQuPTsFdgoFgFViYkd3WA2r4ClxJ3ZfVC2oMTJ
        mU9YQGxmAW2JpzefQtnyEtvfzmGGuE9B4ufTZawQcRGJ2Z1tYHERASuJh4ePMU5gFJ6FZNQs
        JKNmIRk1C0n7AkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwTGrpbWDcc+qD3qH
        GJk4GA8xSnAwK4nwLjyzM0mINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakF
        qUUwWSYOTqkGpnB7sS8mIl7Sngd0OrxValf8njeZIec5byBXqdLFZZKJ6zQXzpma8Oc8+7eE
        yk8Z3s8kb60R0WB43Xr4DNfMc6pXOHt6wpfwrCs6+OziVp0r3VNCdq8yFhRQXzThyBX+Rzr3
        7qSuNyqRltDc//2woY2CulSUv6SjueeUeeEB2/fG/itnC90RZHw8oueN7CPJNO2nx16ftNri
        4OLqzpsic+tIlLlqy7cvspNP32c027jm8SbGf535e1+1r1WZrKHkfMAg8+OMllf/ffVUD/Cl
        mTRNXSL4l/dU5GKZMsfKyW49gZcu7n19JTJK4HJx0y0Fj5USaxdwhl56lM8fqRl4ucUgbtWu
        67H2H0sWzlq4VImlOCPRUIu5qDgRAJEfypFIAwAA
X-CMS-MailID: 20220629025715epcas2p4eb76e2a47c1d0074a04d99148e299aa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628220437eucas1p2c478751458323f93a71050c4a949f12e
References: <CGME20220628220437eucas1p2c478751458323f93a71050c4a949f12e@eucas1p2.samsung.com>
        <20220628220409.26545-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> The exynos-pcie driver called phy_power_on() and then phy_init() for some
> historical reasons. However the generic PHY framework assumes that the
> proper sequence is to call phy_init() first, then phy_power_on(). The
> operations done by both functions should be considered as one action and
> as such they are called by the exynos-pcie driver (without doing anything
> between them). The initialization is just a sequence of register writes,
> which cannot be altered, without breaking the hardware operation.
> 
> To match the generic PHY framework requirement, simply move all register
> writes to the phy_init()/phy_exit() and drop power_on()/power_off()
> callbacks. This way the driver will also work with the old (incorrect) PHY
> initialization call sequence.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

